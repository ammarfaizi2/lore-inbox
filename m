Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262177AbVCUXi3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262177AbVCUXi3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 18:38:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262138AbVCUXhi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 18:37:38 -0500
Received: from fire.osdl.org ([65.172.181.4]:59610 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262191AbVCUX3s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 18:29:48 -0500
Date: Mon, 21 Mar 2005 15:29:48 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jochen Suckfuell <jo-lkml@suckfuell.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.11 bug: unbacked private shared memory segments missing in
 core dump
Message-Id: <20050321152948.475676f4.akpm@osdl.org>
In-Reply-To: <20050308134332.GA2356@ds217-115-141-141.dedicated.hosteurope.de>
References: <20050301170614.GA6121@ds217-115-141-141.dedicated.hosteurope.de>
	<20050308134332.GA2356@ds217-115-141-141.dedicated.hosteurope.de>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jochen Suckfuell <jo-lkml@suckfuell.net> wrote:
>
> Hello!
> 
> Since 2.6.10, unbacked private shared memory allocated via shmget is not
> included in core dumps.

Can you please confirm that 2.6.12-rc1 fixed this?

Thanks.

> This is a simple example code demonstrating the bug:
> 
> #include <sys/shm.h>
> 
> int main(int argc, char ** argv)
> {
> 	int size = 1000;
> 	int id = shmget(IPC_PRIVATE, size, (IPC_CREAT | 0660));
> 	if(id < 0) return(1);
> 	int *buffer = (int *)shmat(id, 0, 0);
> 	int i;
> 	for(i = 0; i < 1000; i++)
> 		buffer[i] = i;
> 
> 	// now dump core
> 	*((unsigned long *)1) = 0;
> 
> 	// The private shared memory is not included in the core dump,
> 	// although it's not backed and cannot be accessed any more in any
> 	// way.
> 	return 0;
> }
> 
> This bug was introduced in 2.6.10 by a patch to binfmt_elf.c that
> resulted in:
> 
> static int maydump(struct vm_area_struct *vma)
> {
> 	/* Do not dump I/O mapped devices, shared memory, or special mappings */
> 	if (vma->vm_flags & (VM_IO | VM_SHARED | VM_RESERVED))
> 		return 0;
> ...
> 
> (See the thread at
> http://www.ussg.iu.edu/hypermail/linux/kernel/0410.2/1890.html)
> 
> Excluding all pages with VM_SHARED set is also excluding the unbacked
> private mapping and should be replaced by a more specific criterion.
> 
> Bye
> Jochen
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
