Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261500AbUBKBJr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 20:09:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262228AbUBKBJr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 20:09:47 -0500
Received: from gaia.cela.pl ([213.134.162.11]:5124 "EHLO gaia.cela.pl")
	by vger.kernel.org with ESMTP id S261500AbUBKBJp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 20:09:45 -0500
Date: Wed, 11 Feb 2004 02:09:42 +0100 (CET)
From: Maciej Zenczykowski <maze@cela.pl>
To: "Bloch, Jack" <Jack.Bloch@icn.siemens.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: your mail
In-Reply-To: <7A25937D23A1E64C8E93CB4A50509C2A0310F0A7@stca204a.bus.sc.rolm.com>
Message-ID: <Pine.LNX.4.44.0402110206090.13719-100000@gaia.cela.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Feb 2004, Bloch, Jack wrote:

> I have a system with 2GB of memory. One of my processes calls mmap to try to
> map a 100MB file into memory. This calls fails with -ENOMEM. I rebuilt the
> kernel with a few debug printk statements in mmap.c to see where the failure
> was occurring it occurred in the function arch_get_unmapped_area. the code
> is as follows:
> 
> for (vma = find_vma(mm, addr); ; vma = vma->vm_next) {
> 		/* At this point:  (!vma || addr < vma->vm_end). */
> 		unsigned long __heap_stack_gap;
> 		if (TASK_SIZE - len < addr)
>                 { 

it's valid there's no point in searching further for an area of at least 
len bytes.  The user area is 0 .. TASK_SIZE-1.  The addr is the address 
currently being checked, the len is the requested length.  if addr+len is 
greater or equal to TASK_SIZE then the current addr (which is increasing 
within this loop) already causes such a mapping to overflow into kernel 
space (exceeds the TASK_SIZE virtual address limit).  This is precisely as 
expected.

I'd assume your program has fragmented memory to such a level that a 
single consecutive 100 MB area is no longer free (not that hard to do, 
since TASK_SIZE is 3 GB).

Cheers,
MaZe.


