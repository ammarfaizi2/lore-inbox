Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264651AbTKNRy6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Nov 2003 12:54:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264652AbTKNRy6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Nov 2003 12:54:58 -0500
Received: from gaia.cela.pl ([213.134.162.11]:63237 "EHLO gaia.cela.pl")
	by vger.kernel.org with ESMTP id S264651AbTKNRyv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Nov 2003 12:54:51 -0500
Date: Fri, 14 Nov 2003 18:54:42 +0100 (CET)
From: Maciej Zenczykowski <maze@cela.pl>
To: Timothy Miller <miller@techsource.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: "things are about right" kernel test?
In-Reply-To: <3FB50CA4.9080108@techsource.com>
Message-ID: <Pine.LNX.4.44.0311141838510.7550-100000@gaia.cela.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I recall some people mentioning that if they have 1GiB of RAM, something 
> (I forget what) performs badly.  They set it to 900-some MiB, and then 
> things work better.  A test for that with built-in tips for solving the 
> problem might be helpful.

Regarding the 1GB limit (or rather 1024-128 MB = 896 MB limit), this is 
due to Kernel space beginning at 0xC0000000 (giving 1GB of ram for the 
kernel from 0xC0000000..0xFFFFFFFF) of which 128 MB are reserved for 
vmalloc and other uses...  The question is: is there any reason why this 
0xC0000000 couldn't be lowered by 128 MB (to 0xBE000000)?

This would allow using the full 1GB of Ram without using highmem.  As I
understand it using highmem does involve some performance loss.  
Effectively for me this means that PAGE_OFFSET in include/asm-i386/page.h
should be set to either 4GB-128MB-512MB (allowing 512MB ram without
highmem) or 4GB-128MB-1GB (allowing 1GB ram without highmem).  Afterall
I'd expect real life memory configurations are for the majority power of 2
situations - which means you're likely to hit 512MB or 1GB - having the
limit at 896 MB seems pointless.  1GB memory configurations are becoming
more and more common and they are just barely above the highmem cut-off
point, changeing it would fix all the 1GB problems and not really affect
anything else (like those machines with even more RAM).  Sure this limits
the memory available for user processes (from 3 GB to 2.875 GB), but then
the true limit in user space (if I understand this correctly) is that mmap
starts mapping at 1GB anyway [TASK_UNMAPPED_BASE = TASK_SIZE/3 =
PAGE_OFFSET/3 = 1GB currently], if this was changed to a lower value
(likely a static 16MB or even 1MB+64KB would be OK) then we'd effectively
increase the amount of mmaping you could do (sure this doesn't affect brk,
oh well.)

Comments,

MaZe.

