Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932089AbVLaDZJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932089AbVLaDZJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Dec 2005 22:25:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932085AbVLaDZJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Dec 2005 22:25:09 -0500
Received: from web34104.mail.mud.yahoo.com ([66.163.178.102]:52333 "HELO
	web34104.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932081AbVLaDZH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Dec 2005 22:25:07 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=AhldJHqJtiMSE6d23T9tbE8wCWqsgT05CgH+WIJ3IFVSU5TR6oflHWHQxktZzNx5al+I89cFP2XDN+hDOo4GxR6QVwWxmjLYQw66UNTQ7496Q2130jVa80ykRcmPp9d9OPsGSbQg725sO87n0jAVlEudG3uXpUSinZqEgNYMR3o=  ;
Message-ID: <20051231032506.62838.qmail@web34104.mail.mud.yahoo.com>
Date: Fri, 30 Dec 2005 19:25:06 -0800 (PST)
From: Kenny Simpson <theonetruekenny@yahoo.com>
Subject: Re: RAID controller safety
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1135990179.28365.40.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> On Gwe, 2005-12-30 at 10:58 -0800, Kenny Simpson wrote:
> > So all writes would be treated as syncronous in the write-through case (no battery), making
> fsync
> > a no-op?
> 
> fsync is never a no-op. fsync ensures material the OS is caching hits
> disk drivers/disks. Barriers or write through on the disk driver ensure
> that it hits the media.
> 
> The two are independant
> 

Ok, the light is slowly coming on for me...  

  Lets see if I get it:
fsync, according to POSIX, will flush all pending writes
http://www.opengroup.org/onlinepubs/009695399/functions/fsync.html
Linux, according to the man page, takes this a little further an says that data is on stable
storage.

Stable storage for a battery-backed RAID controller means its battery-backed cache.  Stable
storage for a RAID controller w/o battery means that the data is on disk.  I2O controllers are
told the caching requirement for each write in the command.

To tell a disk to force data to the platter, it needs to be sent a specific command (which some
drives ignore), or the write cache must be disabled (write-through mode).  The specific command
varies depending on SCSI vs. SATA vs. TCQ, etc..

Ignoring O_DIRECT, Linux writes out data from the page cache.  Data gets written out when the OS
decides (high memory pressure, timers expire, etc..), or when a program requests it (fsync).

For Linux, to make the fsync command have stability (Durability), it must not only send the data
to the controller, but must inform the controller to force the data to stable storage, and then
wait for the controller to report the writes as completed.

An battery-backed I2O controller only needs to be sent the writes as write-back cache.  A
non-battery-backed I2O controller needs to be sent these writes as write-through.
In both cases, the controller should set the drives themselves to be write-through.

To match the POSIX behavior, the onus on the OS is just the push out the data to the driver.  To
get the further reliability, the driver, contoller (and firmware), and drives (and firmware) must
all function as advertised.  If any one of these fail, the reliability is lost.  Linux can at most
hope to control the driver.

Ok, with all that out of the way...

Are there any known drivers that do not correctly pass on barriers/flush/sync to their
controllers?

  In my observations, and what others have told me in private emails, the I2O driver is such a
driver at least for my non-battery-backed controller (Adaptec 2015S).  I read in the comments of
the I2O driver that it should set the write-cache flag for writes as write-through for
non-battery-backed controllers, but I don't observe that setting via blktool, and basic
write/fsync benchmarks run too fast for the drives I have (4x 10kRPM in RAID-10).
  Also from reading the source, I only see the write-cache flag being set to write-back.  I see no
test for controller properties, or anything else that would modify this setting (except for the
ioctl).
  Of course, I could be mis-reading the I2O spec and all this is up to the controller to know if
it has a battery, so the controller is responsible for doing the right thing, and the flag in the
I2O driver is irrelavant for this.

Thanks for your patience,
-Kenny



		
__________________________________________ 
Yahoo! DSL – Something to write home about. 
Just $16.99/mo. or less. 
dsl.yahoo.com 

