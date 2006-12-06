Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937698AbWLFWEh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937698AbWLFWEh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 17:04:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937703AbWLFWEh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 17:04:37 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:42665 "EHLO e6.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S937698AbWLFWEf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 17:04:35 -0500
Message-ID: <45773E85.8040505@us.ibm.com>
Date: Wed, 06 Dec 2006 16:04:53 -0600
From: Maynard Johnson <maynardj@us.ibm.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.3) Gecko/20040910
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Luke Browning <lukeb@br.ibm.com>, Arnd Bergmann <arnd.bergmann@de.ibm.com>
CC: Luke Browning <lukebrowning@us.ibm.com>, maynardj@linux.vnet.ibm.com,
       linuxppc-dev-bounces+lukebrowning=us.ibm.com@ozlabs.org,
       linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
       oprofile-list@lists.sourceforge.net, cbe-oss-dev@ozlabs.org
Subject: Re: [PATCH]Add notification for active Cell SPU tasks
References: <OF9A01B09B.B62F8342-ON8325723C.006A9343-8325723C.006B2236@us.ibm.com>
In-Reply-To: <OF9A01B09B.B62F8342-ON8325723C.006A9343-8325723C.006B2236@us.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Luke Browning wrote:

> linuxppc-dev-bounces+lukebrowning=us.ibm.com@ozlabs.org wrote on 
> 12/04/2006 10:26:57:
>
> > linuxppc-dev-bounces+lukebrowning=us.ibm.com@ozlabs.org wrote on
> > 01/12/2006 06:01:15 PM:
> >
> > >
> > > Subject: Enable SPU switch notification to detect currently 
> activeSPU tasks.
> > >
> > > From: Maynard Johnson <maynardj@us.ibm.com>
> > >
> > > This patch adds to the capability of spu_switch_event_register to 
> notify the
> > > caller of currently active SPU tasks.  It also exports
> > > spu_switch_event_register
> > > and spu_switch_event_unregister.
> > >
> > > Signed-off-by: Maynard Johnson <mpjohn@us.ibm.com>
> > >
> > >
> > > Index: linux-2.6.19-rc6-
> > > arnd1+patches/arch/powerpc/platforms/cell/spufs/sched.c
> > > ===================================================================
> > > --- linux-2.6.19-rc6-arnd1+patches.
> > > orig/arch/powerpc/platforms/cell/spufs/sched.c   2006-11-24 11:34:
> > > 44.884455680 -0600
> > > +++ linux-2.6.19-rc6-
> > > arnd1+patches/arch/powerpc/platforms/cell/spufs/sched.c   2006-12-01
> > > 13:57:21.864583264 -0600
> > > @@ -84,15 +84,37 @@
> > >               ctx ? ctx->object_id : 0, spu);
> > >  }
> > >  
> > > +static void notify_spus_active(void)
> > > +{
> > > +   int node;
> > > +   for (node = 0; node < MAX_NUMNODES; node++) {
> > > +      struct spu *spu;
> > > +      mutex_lock(&spu_prio->active_mutex[node]);
> > > +      list_for_each_entry(spu, &spu_prio->active_list[node], list) {
> > > +              struct spu_context *ctx = spu->ctx;
> > > +              blocking_notifier_call_chain(&spu_switch_notifier,
> > > +                     ctx ? ctx->object_id : 0, spu);
> > > +      }
> > > +      mutex_unlock(&spu_prio->active_mutex[node]);
> > > +    }
> > > +
> > > +}
> > > +
> > >  int spu_switch_event_register(struct notifier_block * n)
> > >  {
> > > -   return blocking_notifier_chain_register(&spu_switch_notifier, n);
> > > +   int ret;
> > > +   ret = blocking_notifier_chain_register(&spu_switch_notifier, n);
> > > +   if (!ret)
> > > +      notify_spus_active();
> > > +   return ret;
> > >  }
> > > +EXPORT_SYMBOL_GPL(spu_switch_event_register);
> > >  
> > >  int spu_switch_event_unregister(struct notifier_block * n)
> > >  {
> > >     return 
> blocking_notifier_chain_unregister(&spu_switch_notifier, n);
> > >  }
> > > +EXPORT_SYMBOL_GPL(spu_switch_event_unregister);
> > >  
> > >  
> > >  static inline void bind_context(struct spu *spu, struct 
> spu_context *ctx)
> >
> > Is this really the right strategy?  First, it serializes all spu 
> context
> > switching at the node level.  Second, it performs 17 callouts for
>
I could be wrong, but I think if we moved the mutex_lock to be inside of 
the list_for_each_entry loop, we could have a race condition.  For 
example, we obtain the next spu item from the spu_prio->active_mutex 
list, then wait on the mutex which is being held for the purpose of 
removing the very spu context we just obtained.

> > every context
> > switch.  Can't oprofile internally derive the list of active spus 
> from the  
> > context switch callout. 
>
Arnd would certainly know the answer to this off the top of his head, 
but when I initially discussed the idea for this patch with him 
(probably a couple months ago or so), he didn't suggest a better 
alternative.  Perhaps there is a way to do this with current SPUFS 
code.  Arnd, any comments on this?

> >
> > Also, the notify_spus_active() callout is dependent on the return 
> code of
> > spu_switch_notify().  Should notification be hierarchical?  If I
> > only register
> > for the second one, should my notification be dependent on the 
> return code
> > of some non-related subsystem's handler. 
>
I'm not exactly sure what you're saying here.  Are you suggesting that a 
user may only be interested in acitve SPU notification and, therefore, 
shouldn't have to be depenent on the "standard" notification 
registration succeeding?  There may be a case for adding a new 
registration function, I suppose; although, I'm not aware of any other 
users of the SPUFS notification mechanism besides OProfile and PDT, and 
we need notification of both active and future SPU tasks.  But I would 
not object to a new function.

> >
> > Does blocking_callchain_notifier internally check for the presence
> > of registered
> > handlers before it takes locks ...?  We should ensure that there is
> > minimal overhead
> > when there are no registered handlers.
>
I won't pretend to be expert enough to critique the performance of that 
code.

> >
> > Regards,
> > Luke___________________
>
> Any comments to my questions above.  Seems like oprofile / pdt could 
> derive the
> list of active spus from a single context switch callout.  This patch 
> will have
> a large impact on the performance of the system.
>
For OProfile, the registration is only done at the time when a user 
starts the profiler to collect performance data, typically focusing on a 
single application, so I don't see this as an impact on normal 
production operations.  Since you must have root authority to run 
OProfile, it cannot be invoked by just any user for nefarious purposes.

-Maynard

>
> Luke
>
>------------------------------------------------------------------------
>
>_______________________________________________
>Linuxppc-dev mailing list
>Linuxppc-dev@ozlabs.org
>https://ozlabs.org/mailman/listinfo/linuxppc-dev
>


