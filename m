Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751158AbVH3ELQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751158AbVH3ELQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 00:11:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751178AbVH3ELQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 00:11:16 -0400
Received: from smtp.osdl.org ([65.172.181.4]:28065 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751158AbVH3ELP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 00:11:15 -0400
Date: Mon, 29 Aug 2005 21:09:24 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>, helgehaf@aitel.hist.no
Subject: Re: Ignore disabled ROM resources at setup
In-Reply-To: <Pine.LNX.4.58.0508292045590.3243@g5.osdl.org>
Message-ID: <Pine.LNX.4.58.0508292056530.3243@g5.osdl.org>
References: <200508261859.j7QIxT0I016917@hera.kernel.org> 
 <1125369485.11949.27.camel@gaston> <1125371996.11963.37.camel@gaston>
 <Pine.LNX.4.58.0508292045590.3243@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 29 Aug 2005, Linus Torvalds wrote:
> 
> What you want is a "zombie state", where we write the partial information 
> to hardware. It's what we used to do, but it's certainly no more logical 
> than what it does now, and it led to problem reports.

Btw, the fundamental reason for the change is that x86 used to not ever 
touch any ROM resources _at_all_ by default, unless you used the "pci=rom" 
kernel command line switch.

But that got changed, and in an effort to make x86 more like all the other
architectures, it now uses the generic setup-bus stuff (which used to be
"generic, but not x86", since the BIOS tends to set up all PCI buses on
PC's) that probes all resources (including rom resources) to see how big
they are etc.

That meant that suddenly the ROM resources _did_ get sized up and written,
even if they didn't actually get enabled. So on an x86, 2.6.12 would never
touch the ROM resource at all, while for a while in 2.6.13-rc it would
write it with a disabled value by default.

And that's the thing that broke. 

So 2.6.13 is being "safe". It allocates the space for the ROM in the
resource tables, but it neither enables it nor does it write the
(disabled) address out to the device, since both of those actions have
been shown to break on PC's. And sadly (or happily, depends on your
viewpoint), PC's have a _much_ wider range of hardware, so they are the
ones we have to work around.

So yes, behaviour changed, but it changed exactly because not changing it 
leads to problems. So what you will find is that /sbin/lspci actually 
understands this situation:

	01:00.0 VGA compatible controller: ATI Technologies Inc Radeon Mobility M7 LW [Radeon Mobility 7500] (prog-if 00 [VGA])
		...
	        [virtual] Expansion ROM at 90220000 [disabled] [size=128K]
		...
	30: 00 00 00 00 58 00 00 00 00 00 00 00 0a 01 08 00

Notice how the hardware ROM base at 0x30 is set to "00 00 00 00", but 
because the resource allocation has been made and the resource shows up in 
/sys, lspci shows the disabled allocation correctly. That's really how any 
kernel user will need to understand it too: the allocation exists, but 
since it's not enabled, the hardware hasn't been told.

			Linus
