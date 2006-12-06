Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1760574AbWLFM56@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760574AbWLFM56 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 07:57:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760575AbWLFM55
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 07:57:57 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:45480 "EHLO inti.inf.utfsm.cl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760574AbWLFM55 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 07:57:57 -0500
Message-Id: <200612061252.kB6CqRYP008046@laptop13.inf.utfsm.cl>
To: Andrew Morton <akpm@osdl.org>
cc: Jiri Kosina <jkosina@suse.cz>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] let WARN_ON() output the condition 
In-Reply-To: Message from Andrew Morton <akpm@osdl.org> 
   of "Tue, 05 Dec 2006 17:27:37 -0800." <20061205172737.14ecfeb3.akpm@osdl.org> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.5  (beta27)
Date: Wed, 06 Dec 2006 09:52:27 -0300
From: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0.2 (inti.inf.utfsm.cl [200.1.21.155]); Wed, 06 Dec 2006 09:52:27 -0300 (CLST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:
> On Wed, 6 Dec 2006 01:51:01 +0100 (CET)
> Jiri Kosina <jkosina@suse.cz> wrote:
> 
> > [PATCH] let WARN_ON() output the condition
> > 
> > It is possible, in some cases, that the output of WARN_ON() is ambiguous 
> > and can't be properly used to identify the exact condition which caused 
> > the warning to trigger. This happens whenever there is a macro that 
> > contains multiple WARN_ONs inside. Notable example is spin_lock_mutex(). 
> > If any of the two WARN_ONs trigger, we are not able to say which one was 
> > the cause (as we get only line number, which however belongs to the place 
> > where the macro was expanded).
> > 
> > This patch lets WARN_ON() to output also the condition and fixes the 
> > DEBUG_LOCKS_WARN_ON() macro to pass the condition properly to WARN_ON. The 
> > possible drawback could be when someone passes a condition which has 
> > sideeffects. Then it would be evaluated twice, instead of current one 
> > evaluation. On the other hand, when anyone passes expression with 
> > sideeffects to WARN_ON(), he is asking for problems anyway.
> > 
> > Patch against 2.6.19-rc6-mm2.
> > 
> > Signed-off-by: Jiri Kosina <jkosina@suse.cz>
> > 
> > --- 
> > 
> >  include/asm-generic/bug.h   |    4 ++--
> >  include/linux/debug_locks.h |    2 +-
> >  2 files changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/include/asm-generic/bug.h b/include/asm-generic/bug.h
> > index a06eecd..af7574e 100644
> > --- a/include/asm-generic/bug.h
> > +++ b/include/asm-generic/bug.h
> > @@ -35,8 +35,8 @@ #ifndef HAVE_ARCH_WARN_ON
> >  #define WARN_ON(condition) ({						\
> >  	typeof(condition) __ret_warn_on = (condition);			\
> >  	if (unlikely(__ret_warn_on)) {					\
> > -		printk("WARNING at %s:%d %s()\n", __FILE__,	\
> > -			__LINE__, __FUNCTION__);			\
> > +		printk("WARNING (%s) at %s:%d %s()\n", #condition,	\
> > +			__FILE__,__LINE__, __FUNCTION__);		\

			__FILE__, __LINE__, __FUNCTION__);

(missing space after "__FILE__,")
                     
> >  		dump_stack();						\
> >  	}								\
> >  	unlikely(__ret_warn_on);					\
> > diff --git a/include/linux/debug_locks.h b/include/linux/debug_locks.h
> > index 952bee7..1c2b682 100644
> > --- a/include/linux/debug_locks.h
> > +++ b/include/linux/debug_locks.h
> > @@ -25,7 +25,7 @@ ({									\
> >  									\
> >  	if (unlikely(c)) {						\
> >  		if (debug_locks_off())					\
> > -			WARN_ON(1);					\
> > +			WARN_ON(c);					\
> >  		__ret = 1;						\
> >  	}								\
> >  	__ret;								\


Why not just:

    WARN_ON(debug_locks_off())

here? Would give a more readable message too, IMHO.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                    Fono: +56 32 2654431
Universidad Tecnica Federico Santa Maria             +56 32 2654239
Casilla 110-V, Valparaiso, Chile               Fax:  +56 32 2797513

