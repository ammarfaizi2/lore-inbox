Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268110AbUHNHXG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268110AbUHNHXG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Aug 2004 03:23:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268115AbUHNHXG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Aug 2004 03:23:06 -0400
Received: from fep22-0.kolumbus.fi ([193.229.0.60]:47471 "EHLO
	fep22-app.kolumbus.fi") by vger.kernel.org with ESMTP
	id S268110AbUHNHXA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Aug 2004 03:23:00 -0400
Date: Sat, 14 Aug 2004 10:22:56 +0300 (EEST)
From: Kai Makisara <Kai.Makisara@kolumbus.fi>
X-X-Sender: makisara@kai.makisara.local
To: Jeff Garzik <jgarzik@pobox.com>
cc: Peter Jones <pmjones@gmail.com>, Linus Torvalds <torvalds@osdl.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: SG_IO and security
In-Reply-To: <411D1885.8060904@pobox.com>
Message-ID: <Pine.LNX.4.58.0408141008170.9797@kai.makisara.local>
References: <1092313030.21978.34.camel@localhost.localdomain>
 <Pine.LNX.4.58.0408120929360.1839@ppc970.osdl.org>
 <Pine.LNX.4.58.0408120943210.1839@ppc970.osdl.org> <411BA0F4.9060201@pobox.com>
 <Pine.LNX.4.58.0408120958000.1839@ppc970.osdl.org>
 <Pine.LNX.4.58.0408122216300.4586@kai.makisara.local>
 <9ac707cb040813122522d4a71@mail.gmail.com> <411D1885.8060904@pobox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Aug 2004, Jeff Garzik wrote:

> Peter Jones wrote:
> > On Thu, 12 Aug 2004 22:22:36 +0300 (EEST), Kai Makisara
> > <kai.makisara@kolumbus.fi> wrote:
> > 
> >>On Thu, 12 Aug 2004, Linus Torvalds wrote:
> >>
> >>>Let's see now:
> >>>
> >>>      brw-rw----    1 root     disk       3,   0 Jan 30  2003 /dev/hda
> >>>
> >>>would you put people you don't trust with your disk in the "disk" group?
> >>>
> >>
> >>This protects disks in practice but SG_IO is currently supported by other
> >>devices, at least SCSI tapes. It is reasonable in some organizations to
> >>give r/w access to ordinary users so that they can read/write tapes. I
> >>would be worried if this would enable the users, for instance, to mess up
> >>the mode page contents of the drive or change the firmware.
> > 
> > 
> > Sure, but for that we need command based filtering.
> 
> We have that now (sigh).  See attached patch, which is in BK...
> 

This patch looks OK except that it includes the command WRITE BUFFER. It 
is used to flash the firmware for many devices. Even the SCSI standard 
(draft) specifies that mode 06h is "Download microcode and save". This 
command _should be removed_ from the list of allowed commands.

> A similar approach could be applied to tape as well.
> 
As far as I can read the code, the filtering applies to all devices. 
Except WRITE BUFFER, the commands are acceptable for tapes considering the 
opening mode or undefined for tapes. The undefined commands may cause a 
device with bad firmware to lock the SCSI bus and in this way to cause DoS. 
However, this applies also to commands defined for a type of device but 
not implemented because they are optional.

I am ready to accept this risk of DoS (provided that allowing the filtered 
commands is really useful for somebody) but this is a risk we must 
recognize.

> Though in general I think command-based filtering is not scalable...  at 
> the very least I would prefer a list loaded from userspace at boot.
> 
I think always requiring CAP_RAWIO would be the approach of least 
surprise.

-- 
Kai
