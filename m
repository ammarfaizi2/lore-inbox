Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932513AbWBPINM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932513AbWBPINM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 03:13:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932514AbWBPINM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 03:13:12 -0500
Received: from mr1.bfh.ch ([147.87.250.50]:9604 "EHLO mr1.bfh.ch")
	by vger.kernel.org with ESMTP id S932513AbWBPINL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 03:13:11 -0500
X-PMWin-Version: 2.5.0e, Antispam-Engine: 2.2.0.0, Antivirus-Engine: 2.32.10
Thread-Index: AcYy0MB8ahj8pI8iTLaPLNxMHWInnA==
Message-ID: <43F433F6.2000500@bfh.ch>
Content-class: urn:content-classes:message
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.1830
Importance: normal
Date: Thu, 16 Feb 2006 09:12:38 +0100
From: "Seewer Philippe" <philippe.seewer@bfh.ch>
Organization: BFH
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050811)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Phillip Susi" <psusi@cfl.rr.com>
Cc: "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
       "Bartlomiej Zolnierkiewicz" <bzolnier@gmail.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: RFC: disk geometry via sysfs
References: <43EC8FBA.1080307@bfh.ch> <43F0B484.3060603@cfl.rr.com>  <43F0D7AD.8050909@bfh.ch> <43F0DF32.8060709@cfl.rr.com>  <43F206E7.70601@bfh.ch> <43F21F21.1010509@cfl.rr.com>  <43F2E8BA.90001@bfh.ch>  <58cb370e0602150051w2f276banb7662394bef2c369@mail.gmail.com> <1140016519.14831.18.camel@localhost.localdomain> <43F348C2.2070305@cfl.rr.com>
In-Reply-To: <43F348C2.2070305@cfl.rr.com>
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 16 Feb 2006 08:12:38.0438 (UTC) FILETIME=[C01D7460:01C632D0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Phillip Susi wrote:
> Alan Cox wrote:
> 
>> The tools need to know the C/H/S drive addressing data for old drives
>> because it is used to determine partition tables. That doesn't have to
>> be GETGEO but it does need to exist somewhere.
> 
> Currently GETGEO very often does not report the same values of the bios
> doesn't it?  For some disks it's completely made up, and for others it
> is the value returned by the drive itself, which often differs from the
> bios values.  If this is the case, and it is the bios values that must
> be stored in the MBR, then it makes little sense to have GETGEO seeing
> as how it often provides incorrect information.
As stated earlier GETGEO reports the drivers/subsystem's idea of disk
geometry.
> Wouldn't it be better then, to clean up GETGEO everywhere so that unless
> it has correct values from the bios, it should just fail?  And leave it
> up to fdisk and friends to inform the user of that failure, choose
> default values, and allow the user to override those defaults should
> they need to?
Thats the problem point here. As of 2.6 the kernel does no longer know
anything about bios geometry. The exception here might be for older
drives which do not support lba, where the physical geometry is the one
the bios reports (if not configured diffently).

This is, as we all know, intentional. Because it's quite impossible to
always and accurately match bios disk information to drives reported by
drivers.

> 
> The only time they would even have to worry about it is if they are
> installing linux on a blank disk, and then want to install windows to
> dual boot with it.  In that case they might have to correct the CHS
> values in the MBR to match the values the bios provides.
> 
> 
Not only windows but other os as well.

The problem here is a general interface problem. Tools want one
interface (be it ioctl or sysfs). If they can depend on a kernel
interface only partially and have to determine values themeself
otherwise, that interface should be dropped. Again i'm talking about the
interface, not actual code which might still depend on c/h/s.

On the other hand, if we keep that interface (or perhaps ioctl for
compatibility and sysfs for newer things) and introduce a means to tell
the driver via userspace what we want, many things can be solved. For
example for older drives which need chs, userspace can tell the driver
what the bios uses if values differ. For other implementations which
return defaults which are correct in 80% of all cases, the other 20% can
be overridden.

It's of course not really the kernel's responsability to fix things (or
better allow the user to fix things) not important to Linux, but i think
for the sake of compatility necessary.



