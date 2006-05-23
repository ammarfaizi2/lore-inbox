Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751321AbWEWFep@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751321AbWEWFep (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 01:34:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751340AbWEWFep
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 01:34:45 -0400
Received: from smtp.enter.net ([216.193.128.24]:38930 "EHLO smtp.enter.net")
	by vger.kernel.org with ESMTP id S1751321AbWEWFeo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 01:34:44 -0400
From: "D. Hazelton" <dhazelton@enter.net>
To: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: OpenGL-based framebuffer concepts
Date: Tue, 23 May 2006 00:48:14 +0000
User-Agent: KMail/1.8.1
Cc: Manu Abraham <abraham.manu@gmail.com>, linux cbon <linuxcbon@yahoo.fr>,
       Helge Hafting <helge.hafting@aitel.hist.no>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org
References: <20060519224056.37429.qmail@web26611.mail.ukl.yahoo.com> <44700ACC.8070207@gmail.com> <A78F7AE7-C3C2-43DA-9F17-D196CCA7632A@mac.com>
In-Reply-To: <A78F7AE7-C3C2-43DA-9F17-D196CCA7632A@mac.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605230048.14708.dhazelton@enter.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 23 May 2006 05:08, Kyle Moffett wrote:
> Tentatively going with the assumption put forth by Jon Smirl in his
> future-of-linux-graphics document and the open-graphics-project group
> that 3d rendering is an absolutely essential part of any next-
> generation graphics system, I'd be interested in ideas on a new or
> modified /dev/fbX device that offers native OpenGL rendering
> support.  Someone once mentioned OpenGL ES as a possibility as it
> provides extensions for multiple-process windowing environments.
> Other requirements would obviously be the ability to allow client
> programs to allocate and share out chunks of graphics memory to other
> clients (later used as textures for compositing), support for
> multiple graphics cards with different hardware renderers over
> different busses, using DMA to transfer data between cards as
> necessary (and user-configurable policy about how to divide use of
> the cards), support for single or multiple framebuffers per GPU, as
> well as an arbitrary number of hardware and software viewports per
> framebuffer.  There would also need to be a way for userspace to trap
> and emulate or ignore unsupported OpenGL commands.  The kernel would
> need some rudimentary understanding of OpenGL to be able to handle
> buggy GPUs and prevent them from hanging the PCI bus (some GPUs can
> do that if sent invalid commands), but you obviously wouldn't want a
> full software renderer in the kernel.  The system should also support
> transmitting OpenGL textures, commands, and other data asynchronously
> over a TCP socket, though doing it locally via mmap would be far more
> efficient.  I'm probably missing other necessary generics, but that
> should provide a good discussion starter.

Not that I can see, but the network connectivity bit should probably not be 
targeted in the first set of patches. IMHO, the best way to handle this would 
be to start merging the DRI drivers into the Framebuffer drivers.  This would 
then provide some of the infrastructure needed to bring an accelerated 
graphics framework into the realm of possibility just in userspace.

In other words - like with everything, the kernel only needs to provide a very 
basic set of tools. Provide the kernel with the capacity to handle the 
accelerated aspects of video cards seemlessly with the framebuffer driver and 
the "Mesa Solo" project would be more than half complete.

By implementing a framework where userspace doesn't have to know - or care - 
about the hardware, which, IMNSHO, is the way things should be, then 
userspace applications can take advantage of such a system and be even more 
stable.

> The necessary kernel support would include a graphics-memory
> allocator, resource management, GPU-time allocation, etc, as well as
> support for an overlaid kernel console.  Ideally an improved graphics
> driver like that would be able to dump panics directly to the screen
> composited on top of whatever graphics are being displayed, so you'd
> get panics even while running X.  If that kind of support was
> available in-kernel, fixing X to not need root would be far simpler,
> plus you could also write replacement X-like tools without half the
> effort.  Given that sort of support, a rootless xserver would be a
> fairly trivial wrapper over whatever underlying implementation there
> was.

Here you outline what is needed, and strangely I find myself thinking that a 
lot of this code has already been written. The DRI/DRM system provides a 
method for userspace to directly access the acceleration features of graphics 
cards. Would it not be possible, then, to take the DRI system, merge it with 
the framebuffer system in some manner, and provide a single interface to 
userspace?

Even now I know that most applications that directly access the framebuffer 
and make use of it have special drivers for the various cards that have 
framebuffer drivers in Linux. These might be because of the various 
colorspace conventions - like the BGRA (IIRC) of the Radeons - but even that 
could be better handled either via a sysfs file or by an ioctl in the 
drivers.

But if the Framebuffer system got a makeover, perhaps implementing the 
information side as sysfs files and the actual control side as ioctls...

One thing that I've been thinking about is that there is some need for DMA to 
and from the card. This would probably best be done by the current S/G DMA 
system, as it's a well known and very stable part of the kernel that is 
(IIRC) exposed to userspace.

As for allowing direct access to the GPU, about all I can think of is 
providing an IOCTL that gives you a pointer to a buffer that you can write 
the information to, although a better solution would be to provide a single 
IOCTL that takes a userspace buffer and transfers it directly to the GPU.

Neither option seems good to me, since both would require userspace to know 
which card it's talking to. So, my only real suggestion is to add another 
library to the kernel - one that can translate a user request into the proper 
GPU commands and hide all the machinery from the end-user.

DRH
(Note: I do not like any of the GPU access options I mentioned. The first two 
because they require userspace knowing which hardware it's talking to when I, 
personally, feel that userspace should have no need to know that sort of 
information. The last one because it requires adding a complex interpreter to 
the kernel, and that screams to me of "bloat".)
