Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964899AbVJDS07@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964899AbVJDS07 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 14:26:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964901AbVJDS07
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 14:26:59 -0400
Received: from kepler.fjfi.cvut.cz ([147.32.6.11]:12444 "EHLO
	kepler.fjfi.cvut.cz") by vger.kernel.org with ESMTP id S964899AbVJDS06
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 14:26:58 -0400
Date: Tue, 4 Oct 2005 20:26:55 +0200 (CEST)
From: Martin Drab <drab@kepler.fjfi.cvut.cz>
To: Brian Gerst <bgerst@didntduck.org>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4 in-kernel file opening
In-Reply-To: <4342C007.6020809@didntduck.org>
Message-ID: <Pine.LNX.4.60.0510042010170.8210@kepler.fjfi.cvut.cz>
References: <Pine.LNX.4.60.0510041924520.8210@kepler.fjfi.cvut.cz>
 <4342C007.6020809@didntduck.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Oct 2005, Brian Gerst wrote:

> Martin Drab wrote:
> > Hi,
> > 
> > can anybody tell me why there is no sys_open() exported in kernel/ksyms.c in
> > 2.4 kernels while the sys_close() is there? And what is then the preferred
> > way of opening files from within a 2.4 kernel module?
> 
> Why do you need to open files from kernel space?  There are usually better
> alternatives like the firmware loader interface.

I was kind of working this out here a while ago. I am collecting data from 
RTLinux driver (in Real-Time). I am filing DMA buffers and I need to 
transfer their contents (preferably by mmap()ping) to the user space.

My first problem (that I was solving a while ago) was that I was unable to 
mmap() the buffer using mmap() through the /dev/mem. I solved that by 
creating my own device with its own fops->mmap() using vmops->nopage().
Problem is that this is not RT safe. So I wanted to do it all from 
within the ioctl call to the RT-FIFOs, which are RT safe, since the 
RT-FIFOs do not provide for the safe mmap() operation redefinition. I'm 
not very sure it can be done in a safe way by calling the mmap() on that 
new device from the user space.

Perhaps the only way then may be to do (from the user space):

	0) read() from RT-FIFO the info about next available DMA buffer.
	1) ioctl() to RT-FIFO to block the buffer and dispose it for the 
	   user-space mmap() via the unsafe interface.
	2) mmap() it from user space.
	3) use the data from the mmap()ped buffer
	4) munmap() the buffer.
	5) ioctl() to the RT-FIFO to release the buffer for further reuse

Is that so?
Before I was kind of hoping I could do 2) from within 1) and 4) from 
within 5), but evidently this was not a good idea.

Martin
