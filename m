Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261420AbUKBP5P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261420AbUKBP5P (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 10:57:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262118AbUKBP5O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 10:57:14 -0500
Received: from a26.t1.student.liu.se ([130.236.221.26]:14274 "EHLO
	mail.drzeus.cx") by vger.kernel.org with ESMTP id S261420AbUKBPtI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 10:49:08 -0500
Message-ID: <4187AC80.6050409@drzeus.cx>
Date: Tue, 02 Nov 2004 16:49:20 +0100
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040919)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: __GFP flags and kmalloc failures
X-Enigmail-Version: 0.84.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm trying to allocate a buffer to be used for ISA DMA and I'm 
experiencing some difficulties.

I'm allocating a 64kB buffer (max size for low ISA DMA) using:

kmalloc(65536, GFP_KERNEL | GFP_DMA);

The choice of flags are from another driver that does ISA DMA so I 
didn't put too much thought into them at first.

The problem is now that this allocation doesn't always succeed. When it 
fails I get:

insmod: page allocation failure. order:4, mode:0x11

and a nice little stack dump.

Digging around in gfp.h to see if I have the proper flags I find that I 
currently have the following:

* __GFP_WAIT : This seems to indicate that the process should be put to 
sleep until the allocation can succeed. Doesn't seem to work that way 
though.

* __GFP_IO : What is meant with physical IO? PCI DMA? This buffer needs 
only be read by the ISA DMA controller and the driver in kernel space. 
Any useful data is copied to other buffers.

* __GFP_FS : Since the data is copied before use this probably isn't needed.

* __GFP_DMA : From what I've been told, this flags causes the allocator 
to do the magic required for the buffer to end up i memory accessible 
from the ISA DMA controller. So this seems to be the only flag that 
actually does anything useful.

My question is now, why does the allocation fail (sometimes) and what 
should I do about it?

Memory fragmentation and overusage seems like reasons to why but why 
doesn't the kernel throw out cache pages and reorganise user pages so 
that the allocation can succeed?

As for solutions I've tried using __GFP_REPEAT which seems to do the 
trick. But the double underscore indicates (at least to me) that these 
are internal defines that shouldn't be used except for very special 
cases. What is the policy about these?

Rgds
Pierre
