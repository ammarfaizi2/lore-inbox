Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266611AbUFRSU4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266611AbUFRSU4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 14:20:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266609AbUFRSU4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 14:20:56 -0400
Received: from stat1.steeleye.com ([65.114.3.130]:18408 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S266602AbUFRSUs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 14:20:48 -0400
Subject: Re: DMA API issues
From: James Bottomley <James.Bottomley@steeleye.com>
To: Ian Molton <spyro@f2s.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 18 Jun 2004 13:20:43 -0500
Message-Id: <1087582845.1752.107.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    
    
    My colleagues and I are encountering a number of difficulties with the
    DMA API, to which a generic solution is required (or risk multiple
    architectures, busses, and devices going their own way...)
    
    Here is an example system that illustrates these problems:
    
    I have a System On Chip device which, among other functions, contains an
    OHCI controller and 32K of SRAM.
    
    heres the catch:- The OHCI controller has a different address space than
    the host bus, and worse, can *only* DMA data from its internal SRAM.
    
    The architecture is not broken, merely unusual.
    
    This causes the following problems:
    
    1) The DMA API provides no methods to set up a mapping between the host
       memory map and the devices view of the space
            example:
               the OHCI controller above would see its 32K of SRAM as
               mapped from 0x10000 - 0x1ffff and not 0xXXX10000 - 0xXXX1ffff
               which is the address the CPU sees.

Erm, well this isn't unusual.  A lot of devices have on board memory to
offload accesses to.  All the later Symbios SCSI chips for instance.  If
you look at the drivers, you'll see they ioremap the region and then use
it via the normal memory accessors.

    2) The DMA API assumes the device can access SDRAM
            example:
               the OHCI controller base is mapped at 0x10000000 on my platform.
               this is NOT is SDRAM, its in IO space.

The usual thing for devices to do is maintain their own mapping of the
the regions, since the device physical locations has no meaning at all
to the platform systems (other than it better not clash with real
memory).
    
    If these points are possible to be addressed, it would allow at LEAST three chips *in \
    use* in linux devices able to use mainline OHCI code directly - TC6393XB (in toshiba \
    PDAs), SAMCOP (Ipaqs), and mediaQ (dell axims).
    
    I am told HPPA has some similar problems also.
    
I don't understand what you're asking for beyond what we currently do. 
These devices should be able to operate using ioremap and memcpy_toio,
what more do you want?

There was one extension to the DMA API that I considered for a Q720 SCSI
card which has 2MB of onboard memory.  That was to allow the device to
declare the memory region to the platform so the platform could hand it
out as coherent memory (this is platform dependent, some platforms
simply cannot allow direct memory access to bus space like this). 
However, something with a memory space as tiny as 32kB is unlikely to
benefit from this.

James


