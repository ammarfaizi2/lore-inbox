Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422695AbWJPQFp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422695AbWJPQFp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 12:05:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422697AbWJPQFp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 12:05:45 -0400
Received: from amsfep17-int.chello.nl ([213.46.243.15]:3760 "EHLO
	amsfep12-int.chello.nl") by vger.kernel.org with ESMTP
	id S1422695AbWJPQFn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 12:05:43 -0400
Subject: Re: pagefault_disable (was Re: [patch 6/6] mm: fix pagecache write
	deadlocks)
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Linux Memory Management <linux-mm@kvack.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, David Howells <dhowells@redhat.com>,
       Ingo Molnar <mingo@elte.hu>
In-Reply-To: <4533A411.2020207@yahoo.com.au>
References: <20061013143516.15438.8802.sendpatchset@linux.site>
	 <20061013143616.15438.77140.sendpatchset@linux.site>
	 <1160912230.5230.23.camel@lappy> <20061015115656.GA25243@wotan.suse.de>
	 <1160920269.5230.29.camel@lappy> <20061015141953.GC25243@wotan.suse.de>
	 <1160927224.5230.36.camel@lappy>  <20061015155727.GA539@wotan.suse.de>
	 <1160928835.5230.41.camel@lappy>  <4533A411.2020207@yahoo.com.au>
Content-Type: text/plain
Date: Mon, 16 Oct 2006 18:05:32 +0200
Message-Id: <1161014732.2096.9.camel@taijtu>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-10-17 at 01:24 +1000, Nick Piggin wrote:
> (trimming cc list)
> 
> Peter Zijlstra wrote:
> > On Sun, 2006-10-15 at 17:57 +0200, Nick Piggin wrote:
> 
> >>Hmm, but you may not be doing a copy*user within the kmap. And you may
> >>want an atomic copy*user not within a kmap (maybe).
> >>
> >>I think it really would be more logical to do it in a wrapper function
> >>pagefault_disable() pagefault_enable()? ;)
> > 
> > 
> > I did that one first, but then noticed that most non trivial kmap_atomic
> > implementations already did the inc_preempt_count()/dec_preempt_count()
> > thing (except frv which did preempt_disable()/preempt_enable() ?)
> > 
> > Anyway, here goes:
> > 
> > Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
> 
> I think this is a good approach. The missed preempt checks could easily
> have been causing scheduling delays because the usercopy can take up a
> lot of kernel time.
> 
> I don't know that the function should go in filemap.h... uaccess.h seems
> more appropriate, and had thought the pagefault_disable() be calle
> directly from within the copy_*_user_inatomic functions themselves, not
> the filemap helper.
> 
> Also, the rest of the kernel tree (mainly uaccess and futexes) should be
> converted ;)

Yeah, lotsa places to touch.

> > Index: linux-2.6/mm/filemap.h
> > ===================================================================
> > --- linux-2.6.orig/mm/filemap.h	2006-10-14 20:20:20.000000000 +0200
> > +++ linux-2.6/mm/filemap.h	2006-10-15 17:17:45.000000000 +0200
> > @@ -21,6 +21,22 @@ __filemap_copy_from_user_iovec_inatomic(
> >  					size_t bytes);
> >  
> >  /*
> > + * By increasing the preempt_count we make sure the arch preempt
> > + * handler bails out early, before taking any locks, so that the copy
> > + * operation gets terminated early.
> > + */
> > +pagefault_static inline void disable(void)
> > +{
> > +	inc_preempt_count();

I think we also need a barrier(); here. We need to make sure the preempt
count is written to memory before we hit the fault handler.

> > +}
> > +
> > +pagefault_static inline void enable(void)
> > +{
> > +	dec_preempt_count();
> > +	preempt_check_resched();
> > +}
> 
> Interesting prototype ;)

Bah, sed magic gone awry ;-(

