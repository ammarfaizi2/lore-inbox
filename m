Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314709AbSEPVIn>; Thu, 16 May 2002 17:08:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314723AbSEPVIm>; Thu, 16 May 2002 17:08:42 -0400
Received: from scfdns02.sc.intel.com ([143.183.152.26]:38097 "EHLO
	crotus.sc.intel.com") by vger.kernel.org with ESMTP
	id <S314709AbSEPVIj>; Thu, 16 May 2002 17:08:39 -0400
Message-Id: <200205162108.g4GL8Xw01263@unix-os.sc.intel.com>
Content-Type: text/plain; charset=US-ASCII
From: Mark Gross <mgross@unix-os.sc.intel.com>
Reply-To: mgross@unix-os.sc.intel.com
Organization: SSG Intel
To: Daniel Jacobowitz <dan@debian.org>, Andi Kleen <ak@suse.de>
Subject: Re: PATCH Multithreaded core dump support for the 2.5.14 (and 15) kernel.
Date: Thu, 16 May 2002 14:08:10 -0400
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <59885C5E3098D511AD690002A5072D3C057B485B@orsmsx111.jf.intel.com.suse.lists.linux.kernel> <20020516192759.A5326@wotan.suse.de> <20020516173634.GA16561@nevyn.them.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 16 May 2002 01:36 pm, Daniel Jacobowitz wrote:
> On Thu, May 16, 2002 at 07:27:59PM +0200, Andi Kleen wrote:
> > On Thu, May 16, 2002 at 10:13:40AM -0400, Mark Gross wrote:
> > > Also, does anyone know WHY the mmap_sem is needed in the elf_core_dump
> > > code, and is this need still valid if I've suspended all the other
> > > processes that could even touch that mm?  I.e. can I fix this by
> > > removing the down_write / up_write in elf_core_dump?
> >
> > The mmap_sem is needed to access current->mm (especially the vma list)
> > safely. Otherwise someone else sharing the mm_struct could modify it.
> > If you make sure all others sharing the mm_struct are killed first
> > (including now way for them to start new clones inbetween) then
> > the only loophole left would be remote access using /proc/pid/mem or
> > ptrace. If you handle that too then it is probably safe to drop it.
> > Unfortunately I don't see a way to handle these remote users without at
> > least
> > taking it temporarily.
> >
> > Of course there are other semaphores in involved in dumping too (e.g. the
> > VFS ->write code may take the i_sem or other private ones). I guess they
> > won't be a big problem if you first kill and then dump later.
>
> Except unfortunately we don't kill; the other threads are resumed
> afterwards for cleanup.  They're just suspended.

Yes, they start back up after the dump.  

It certainly seems that with the processes paused that the use of the 
current->mm->mm_sem could be obsolete for core dumps.  I'm not so sure 
protecting the core file data from ptrace or /proc/pid/mem is important in 
the case of core dumping.

I just don't want the kernel to lock up dumping the multithreaded core file.

I'm still not sure we have a problem yet.  (wishful thinking I suppose).   
Also I've seen zero lock ups from semaphore being held by one of the 
processes getting pauses temporarily in my testing on the patch I posted.

To restate: the only way I see that my design gets into trouble is when a 
semaphore is HELD, not getting waited on, by one of the processes that gets 
put onto the phantom runqueue, AND that semaphore is needed in the processing 
of elf_core_dump(...).

For this to happen that semaphore would have to held across schedule()'s.  
The ONLY place I've seen that in the kernel is set_CPUs_allowed + 
migration_thread.  

Can someone point me at other critical sections that have non-deterministic 
life times as a function of when the process holding the semaphore gets 
scheduled onto a CPU?  That type of code seems very risky to me.  This is the 
only type of code that could get my design into trouble.

--mgross


