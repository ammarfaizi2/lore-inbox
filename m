Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932093AbWHQG7m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932093AbWHQG7m (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 02:59:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932089AbWHQG7m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 02:59:42 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:479 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932083AbWHQG7l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 02:59:41 -0400
Subject: Re: Relation between free() and remove_vm_struct()
From: Arjan van de Ven <arjan@infradead.org>
To: "Abu M. Muttalib" <abum@aftek.com>
Cc: kernelnewbies@nl.linux.org, linux-newbie@vger.kernel.org,
       linux-kernel@vger.kernel.org, linux-mm <linux-mm@kvack.org>
In-Reply-To: <BKEKJNIHLJDCFGDBOHGMKEEHDGAA.abum@aftek.com>
References: <BKEKJNIHLJDCFGDBOHGMKEEHDGAA.abum@aftek.com>
Content-Type: text/plain
Organization: Intel International BV
Date: Thu, 17 Aug 2006 08:59:25 +0200
Message-Id: <1155797966.4494.29.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-08-17 at 12:29 +0530, Abu M. Muttalib wrote:
> Hi,
> 
> In an application I am freeing some memory address, earlier reserved with
> malloc.
> 
> I have put prints in remove_vm_struct() function in ./mm/mmap.c. For few
> calls to free(), there is no corresponding call to remove_vm_struct(). I am
> not able to understand why the user space call to free() is not propagated
> to kernel, where in the remove_vm_strcut() function should get called.

Hi,
there is 2 parts to this question

first of all, glibc malloc doesn't always use mmap for it's allocations,
it's a split between the brk() area and mmap() depending on the size of
the allocation. (>= 128Kb uses mmap, smaller uses brk(). brk using
allocations will not end up in remove_vm_struct at all)

second of all, glibc delays freeing of some memory (in the brk() area)
to optimize for cases of frequent malloc/free operations, so that it
doesn't have to go to the kernel all the time (and a free would imply a
cross cpu TLB invalidate which is *expensive*, so batching those up is a
really good thing for performance)

I hope this answer helps you... it's probably worth reading the
malloc/malloc.c code in the glibc code tree, this behavior is documented
there...

Greetings,
   Arjan van de Ven

-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com

