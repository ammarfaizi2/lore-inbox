Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262540AbVCCRyO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262540AbVCCRyO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 12:54:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262069AbVCCRvy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 12:51:54 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:46778 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S262054AbVCCRst (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 12:48:49 -0500
Date: Thu, 3 Mar 2005 18:48:51 +0100
From: Jan Kara <jack@suse.cz>
To: Petr Vandrovec <vandrove@vc.cvut.cz>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: Crash in ext3 while extracting 2.6.11 (on 2.6.11-rc5-something)
Message-ID: <20050303174851.GA9253@atrey.karlin.mff.cuni.cz>
References: <20050302180633.GA25304@ppc.vc.cvut.cz> <20050303131004.GA16512@atrey.karlin.mff.cuni.cz> <20050303144949.GH22176@vana.vc.cvut.cz> <20050303162611.GB23366@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050303162611.GB23366@atrey.karlin.mff.cuni.cz>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > On Thu, Mar 03, 2005 at 02:10:04PM +0100, Jan Kara wrote:
<snip>
> > It died because of dereferencing RBP which contained memory poisoning
> > signature:
> > 
> > 0xffffffff801d9996 <log_do_checkpoint+246>:     lock btsl $0x13,0x0(%rbp)
> > 
> > apparently x86-64 generates #SS for %rbp non-canonical addresses too, like 
> > i386 does with %ebp segment overruns.
> > 
> > Crash occured in bit_spin_trylock called by jbd_trylock_bh_state from
> > log_do_checkpoint (fs/jbd/checkpoint.c:636), because jh2bh (jh->b_bh)
> > returned poisoned pattern - apparently somebody else freed journal_head
> > while we were holding pointer to it.  No idea how it happened.
> > 
> > >   Anyway I was briefly reading the code in log_do_checkpoint() and two
> > > things are not clear to me - are we guaranteed that
> > > transaction->t_checkpoint_list is non-empty (the code relies on that)?
> > > Another thing is - __flush_buffer() can sleep. Cannot someone change
> > > the t_checkpoint_list while we are sleeping? We are protected only by
> > > the j_checkpoint_sem and that only protects us against other
> > > log_do_checkpoint() calls.
> > 
> > Code apparently believes that if __flush_buffer() sleeps then it returns
> > 1.
>   Yes, I see that all the buffer heads will be processed. But I'm not
> sure whether someone cannot come while we are sleeping and release the
> journal_head next_jh points too (actually it seems that such thing is
> happening). I'll have a look what could cause such nasty thing...
  Sorry, you were right that the test with 'retry' should handle this
case also correctly. It must be something else.

								Honza
  <snip>
-- 
Jan Kara <jack@suse.cz>
SuSE CR Labs
