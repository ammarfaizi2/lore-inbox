Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314458AbSEPROL>; Thu, 16 May 2002 13:14:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314459AbSEPROK>; Thu, 16 May 2002 13:14:10 -0400
Received: from scfdns02.sc.intel.com ([143.183.152.26]:60385 "EHLO
	crotus.sc.intel.com") by vger.kernel.org with ESMTP
	id <S314458AbSEPROJ>; Thu, 16 May 2002 13:14:09 -0400
Message-Id: <200205161714.g4GHE3w02908@unix-os.sc.intel.com>
Content-Type: text/plain; charset=US-ASCII
From: Mark Gross <mgross@unix-os.sc.intel.com>
Reply-To: mgross@unix-os.sc.intel.com
Organization: SSG Intel
To: Andi Kleen <ak@suse.de>
Subject: Re: PATCH Multithreaded core dump support for the 2.5.14 (and 15) kernel.
Date: Thu, 16 May 2002 10:13:40 -0400
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <59885C5E3098D511AD690002A5072D3C057B485B@orsmsx111.jf.intel.com.suse.lists.linux.kernel> <200205152353.g4FNrew30146@unix-os.sc.intel.com.suse.lists.linux.kernel> <p73it5oz21j.fsf@oldwotan.suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 16 May 2002 08:54 am, Andi Kleen wrote:
> Mark Gross <mgross@unix-os.sc.intel.com> writes:
> > Any driver that holds a lock across any sleep_on call I think is abusing
> > locks and needs adjusting.
>
> That's true for spinlocks, but not for semaphores. The mm layer and the
> vfs layer both use semaphores extensively and sleep with them hold,
> also some other subsystems (like networking) use sleeping locks.
>
> -Andi

Hmmm, then the only nasty bit I see is the down_write(&current->mm->mmap_sem) 
in elf_core_dump.  

If as durring a core dump, one of the suspended thread processes had the 
mmap_sem for the currently dumping process, AND was sleeping, then I could 
get into trouble.  This could happen with thread processes created using the 
CLONE_VM flag (pthread applications use this flag).

I've just spent a bit of time grepping around looking for places a process 
could grab the mmap_sem and then sleep but didn't find anything.   I know 
this doesn't prove anything, but I had to look ;)

Does anyone knowlegible with the use / role of the mm_sem in the kernel have 
any insight into its use that would help me?  I would really like to make the 
TCORE patch work well.

Also, does anyone know WHY the mmap_sem is needed in the elf_core_dump code, 
and is this need still valid if I've suspended all the other processes that 
could even touch that mm?  I.e. can I fix this by removing the down_write / 
up_write in elf_core_dump?

--mgross
