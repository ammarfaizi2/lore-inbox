Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932362AbWCUJlf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932362AbWCUJlf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 04:41:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932364AbWCUJlf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 04:41:35 -0500
Received: from e31.co.us.ibm.com ([32.97.110.149]:61337 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S932362AbWCUJle
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 04:41:34 -0500
Date: Tue, 21 Mar 2006 07:32:57 +0530
From: Prasanna S Panchamukhi <prasanna@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: ak@suse.de, davem@davemloft.net, suparna@in.ibm.com,
       richardj_moore@uk.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [3/3 PATCH] Kprobes: User space probes support- single stepping out-of-line
Message-ID: <20060321020257.GB3320@in.ibm.com>
Reply-To: prasanna@in.ibm.com
References: <20060320060745.GC31091@in.ibm.com> <20060320060931.GD31091@in.ibm.com> <20060320061014.GE31091@in.ibm.com> <20060320061123.GF31091@in.ibm.com> <20060320030922.4ea9445b.akpm@osdl.org> <20060320134854.GG8662@in.ibm.com> <20060320124049.62861819.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060320124049.62861819.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 20, 2006 at 12:40:49PM -0800, Andrew Morton wrote:
> Prasanna S Panchamukhi <prasanna@in.ibm.com> wrote:
> >
> > > > +
> > > > +	if (__copy_to_user_inatomic((unsigned long *)addr,
> > > > +				(unsigned long *)uprobe->kp.ainsn.insn, size))
> > > > +		return -EFAULT;
> > > > +
> > > > +	regs->eip = addr;
> > > > +
> > > > +	return 0;
> > > > +}
> > > 
> > > If we're going to use __copy_to_user_inatomic() then we'll need some nice
> > > comments explaining why this is happening.
> > > 
> > > And we'll need to actually *be* in-atomic.  That means we need an
> > > open-coded inc_preempt_count() and dec_preempt_count() in there and I don't
> > > see them.
> > > 
> > 
> > We come here, after probe is hit, through uporbe_handler() with
> > interrupts disabled (since it is a interrupt gate). In uprobe_handler()
> > preemption is disabled and remains disabled until original instruction
> > is single stepped.
> > 
> > I will add proper comments in next iteration.
> 
> preempt_disable() is insufficient - it is a no-op on !CONFIG_PREEMPT.
> 
> You _must_ run inc_preempt_count().  See how kmap_atomic() and
> kunmap_atomic() work.
> 

Yes, I will use inc_preempt_count() instead of preempt_disable().

> > > > + */
> > > > +void __kprobes replace_original_insn(struct uprobe *uprobe,
> > > > +				struct pt_regs *regs, kprobe_opcode_t opcode)
> > > > +{
> > > > +	kprobe_opcode_t *addr;
> > > > +	struct page *page;
> > > > +
> > > > +	page = find_get_page(uprobe->inode->i_mapping,
> > > > +					uprobe->offset >> PAGE_CACHE_SHIFT);
> > > > +	BUG_ON(!page);
> > > > +
> > > > +	__lock_page(page);
> > > 
> > > Whoa.  Why is __lock_page() being used here?  It looks like a bug is being
> > > covered up.
> > > 
> > 
> > we come here with a spinlock held. I will add the comment.
> 
> Then the code is buggy.  __lock_page() can schedule away, causing this CPU
> to recur onto the same lock and deadlock.

Agreed. I will look at this issue and remove the __lock_page().

> 
> > > > +	addr = (kprobe_opcode_t *)kmap_atomic(page, KM_USER1);
> > > > +	addr = (kprobe_opcode_t *)((unsigned long)addr +
> > > > +				 (unsigned long)(uprobe->offset & ~PAGE_MASK));
> > > > +	*addr = opcode;
> > > > +	/*TODO: flush vma ? */
> > > 
> > > flush_dcache_page() would be needed.
> > > 
> > > But then, what happens if the page is shared by other processes?  Do they
> > > all start taking debug traps?
> > 
> > Yes, you are right. I think single stepping inline was a bad idea, disarming
> > the probe looks to be a better option
> > 
> 
> You skipped my second question?

There is a small window in which other processor will not be able to see
the breakpoint if we are single step inline. But since single stepping inline
is a bad idea, we will disarm the probe forever (replace with original instrcution) if we cannot single step out-of-line.
Any suggestions?

Thanks
Prasanna
-- 
Prasanna S Panchamukhi
Linux Technology Center
India Software Labs, IBM Bangalore
Email: prasanna@in.ibm.com
Ph: 91-80-51776329
