Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751863AbWJWJkL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751863AbWJWJkL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 05:40:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751865AbWJWJkL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 05:40:11 -0400
Received: from mail.daysofwonder.com ([213.186.49.53]:17580 "EHLO
	mail.daysofwonder.com") by vger.kernel.org with ESMTP
	id S1751863AbWJWJkI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 05:40:08 -0400
Subject: Re: Sluggish system while copying large files.
From: Brice Figureau <brice+lklm@daysofwonder.com>
To: Chris Mason <chris.mason@oracle.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20061018150901.GC16570@think.oraclecorp.com>
References: <1160747774.7929.53.camel@localhost.localdomain>
	 <20061018150901.GC16570@think.oraclecorp.com>
Content-Type: text/plain
Date: Mon, 23 Oct 2006 11:40:05 +0200
Message-Id: <1161596405.473.29.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 2006-10-18 at 11:09 -0400, Chris Mason wrote:
> On Fri, Oct 13, 2006 at 03:56:14PM +0200, Brice Figureau wrote:
> > I have a brand new Dell 2850 biXeon x86_64 with a Perc4e/Di (megaraid)
> > RAID card with two hardware RAID1 volumes (sda and sdb, ext3 on top of
> > LVM2, io scheduler deadline).
> > 
> > This machine runs 2.6.18 and is used as a mysql server.
> > 
> > Whenever I cp large files (for instance during backup) from one volume
> > to the other, the system becomes really sluggish. 
> > [snipped my long explanation] 
> > Mysql data is on sdb. The copy takes place from sdb to sda.
> 
> The first thing I would suggest would be to use data=writeback for the
> mysql partitions.  The easiest way to figure out what is causing the
> latencies is to get the output from sysrq-t during one of the stalls.
> 
> (see Documentation/sysrq.txt for details on enabling sysrq).

Unfortunately, sysrq-t has an unfortunate tendency to freeze the box
because of a problem in the stack unwinder in this kernel version (as I
read somewhere on lklm).
Last time I tried, it locked the box and I had some problem to revive it
(especially because there was a running LVM snapshot that wasn't
deactivated and the next reboot stalled, I still have to check why).

I'll try the data=writeback mount option. Is it possible to remount the
partition and change the journal option on a running system?

> Since mysql is probably triggering tons of fsyncs or O_SYNC writes,
> you may want to increase the size of the ext3 log.

Mysql is using O_DIRECT for its datafile. I don't know how it relates to
the sync things, but I guess that to be truly ACID, it has to fsync the
files on each transactions.
How can I increase the ext3 log ?
Any idea of the size I should use (and what is the default) ?

> If mysql is constantly appending to the files holding your tables, the
> synchronous writes are more expensive and log intensive.  Check your
> setup to see if you can manually extend any of those files to avoid
> constantly growing table files.

The use of a battery-backed RAID cache should mitigate the sync writes,
and since our mysql load is quite low, the machine shouldn't definitely
freeze for seconds while copying files.

Last week I opened bug #7372 on bugzilla.kernel.org where I gave more
information about this problem.

Thank you for your help,
-- 
Brice Figureau
Days of Wonder

