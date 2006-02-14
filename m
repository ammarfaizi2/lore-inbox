Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030495AbWBNG1i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030495AbWBNG1i (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 01:27:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030496AbWBNG1i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 01:27:38 -0500
Received: from ms-smtp-03-smtplb.tampabay.rr.com ([65.32.5.133]:50363 "EHLO
	ms-smtp-03.tampabay.rr.com") by vger.kernel.org with ESMTP
	id S1030493AbWBNG1h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 01:27:37 -0500
Message-ID: <43F17850.8080600@cfl.rr.com>
Date: Tue, 14 Feb 2006 01:27:28 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Mail/News 1.5 (X11/20060119)
MIME-Version: 1.0
To: Kyle Moffett <mrmacman_g4@mac.com>
CC: Alan Stern <stern@rowland.harvard.edu>,
       Alon Bar-Lev <alon.barlev@gmail.com>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: Flames over -- Re: Which is simpler?
References: <Pine.LNX.4.44L0.0602131601220.4754-100000@iolanthe.rowland.org> <43F11A9D.5010301@cfl.rr.com> <BCC8C7FA-25A2-4460-A667-5AA88BF5BC6D@mac.com> <43F13BDF.3060208@cfl.rr.com> <DD0B9449-14AF-47D1-8372-DDC7E896DBC2@mac.com>
In-Reply-To: <DD0B9449-14AF-47D1-8372-DDC7E896DBC2@mac.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kyle Moffett wrote:
> No, that's _exactly_ what the spec says (well, not verbatim but close 
> enough).  When you disconnect, both the master and slave devices are 
> perfectly free to assume that the connection is completely broken and no 
> state is maintained.  Anything that breaks that assumption is against 
> the spec and likely to break in odd scenarios.
> 

Perfectly free to != required to.  When you know that the connection is 
"broken" due to suspend and there is no way to differentiate between 
that and the device really being disconnected, you have two choices:

1) Assume the user is a masochistic idiot and replaced the device with 
one that looks just like it, or connected the device somewhere else and 
modified it before replacing it, or

2) Assume the user is sane and did no such thing.

Assumption #2 will be correct most of the time and is a valid use case, 
the first is not. If either assumption is wrong, it will lead to data 
loss.  All else being equal, which case do you optimize for?  The common 
and correct case, or the uncommon error case?

> 
> Which causes worse data-loss, writing out cached pages and filesystem 
> metadata to a filesystem that has changed in the mean-time (possibly 
> allocating those for metadata, etc) or forcibly unmounting it as though 
> the user pulled the cable?  Most filesystems are designed to handle the 
> latter (it's the same as a hard-shutdown), whereas _none_ are designed 
> to handle the former.
> 

So you condemn the common correct use case to always suffer data loss to 
give _slightly_ better protection to the uncommon and incorrect use 
case?  I think most users prefer a system that works right when you use 
it right to one that doesn't break quite as badly when you do something 
stupid.

Also why is this argument more valid for USB than SCSI?  I am just as 
free to unplug a scsi disk and replace it with a different one while 
hibernated, yet I don't suffer data loss when I don't do such 
foolishness.  By your argument, because the kernel can not know for sure 
that I didn't do that, it must disconnect and break all the drives on 
the bus.

> A good set of suspend scripts should handle the hardware-suspend with no 
> extra work because hardware supporting hardware-suspend basically 
> inevitably supports USB low-power-mode, and handle software-suspend by 
> either forcibly syncing and unmounting USB filesystems or by failing the 
> suspend and asking the user to.  You also could patch the kernel to fail 
> a powerdown software suspend if some USB device is mounted or otherwise 
> unremovably in-use.
> 

That would prevent data loss, so it would be better than the current 
method of silently loosing data because you assume the user is out to 
get you.  There are other downsides to it though.  What if someone wants 
to boot from a usb drive and suspend to disk?

> 
> Except that would make Linux broken with respect to the USB spec.  It is 

Please point out where in the USB spec it states that the OS _MUST_ 
assume that the device is no longer the same after a bus shutdown and 
restart, even though it otherwise appears to be.

> fallacious to assume that a USB device that the kernel has told to 
> disconnect will still have the same state when the kernel tries to 
> reconnect, even _if_ you could reliably identify it (which you can't 
> because there is no serial number of any sort on a lot of devices.
> 

It is worse to assume that it HAS changed, when that is guaranteed to 
lead to data loss even though it most likely has not changed.  This is 
no different than assuming that the user knows what they are doing when 
they fdisk a drive.  You don't refuse to fdisk a drive just because you 
can't be 100% certain that they aren't doing something stupid that _may_ 
result in data loss, so you assume they know what they are doing and do 
as they say.


