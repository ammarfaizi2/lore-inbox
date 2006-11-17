Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933575AbWKQMnl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933575AbWKQMnl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 07:43:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933563AbWKQMnl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 07:43:41 -0500
Received: from amsfep20-int.chello.nl ([62.179.120.15]:24990 "EHLO
	amsfep20-int.chello.nl") by vger.kernel.org with ESMTP
	id S933575AbWKQMnl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 07:43:41 -0500
Subject: Re: vm: weird behaviour when munmapping
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: moreau francis <francis_moreau2000@yahoo.fr>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20061117113124.75132.qmail@web23112.mail.ird.yahoo.com>
References: <20061117113124.75132.qmail@web23112.mail.ird.yahoo.com>
Content-Type: text/plain
Date: Fri, 17 Nov 2006 13:41:04 +0100
Message-Id: <1163767265.5968.104.camel@twins>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-11-17 at 11:31 +0000, moreau francis wrote:
> Hmm, I'm probably missing something but I don't see what. Please be
> nice even if the question is really stupid ;)
> 
> I'm looking at mmap.c code and to understand it I decided to implement
> a dumb char device that implement its own foo_mmap() method. In this
> method it defined its own vma ops:
> 
>     static void foo_vma_open(struct vm_area_struct *vma)
>     static void foo_vma_close(struct vm_area_struct *vma)
> 
> A dumb application mmap the device in order to make foo_mmap() install
> the vma ops.
> 
>     mmap(NULL, 16384, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
> 
> mmap returned 0x2aaae000 for example. Until now, foo_vma_open() and
> foo_vma_close() are not called.
> 
> Now I want to unmap the first part of the previous mapping to see how
> vma ops are called. So I did:
> 
>     munmap(0x2aaae000, 1024);
> 
> and here's what happen:
> 
>     foo_vma_open(vma) is called with:
>         vma->vm_start = 0x2aaae000
>         vma->vm_end = 0x2aaaf000
> 
>     foo_vma_close(vma) is called with:
>         vma->vm_start = 0x2aaae000
>         vma->vm_end = 0x2aaaf000
> 
> However I would have expected:
> 
>     foo_vma_open(vma) is called with:
>         vma->vm_start = 0x2aaaf000
>         vma->vm_end = 0x2aaab2000
> 
>     foo_vma_close(vma) is called with:
>         vma->vm_start = 0x2aaae000
>         vma->vm_end = 0x2aaaf000
> 
> Can anybody tell me why I get this behaviour ?
> 

http://lwn.net/Kernel/LDD3/

Chapter 15. Section 'Virtual Memory Areas'.

Basically; vm_ops->open() is not called on the first vma. With this
munmap() you split the area in two, and it so happens the new vma is the
lower one.


