Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1163652AbWLGW6e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1163652AbWLGW6e (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 17:58:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1163649AbWLGW6e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 17:58:34 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:43330 "EHLO e2.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1163651AbWLGW6b convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 17:58:31 -0500
From: Arnd Bergmann <arnd.bergmann@de.ibm.com>
Organization: IBM Deutschland Entwicklung GmbH
To: cbe-oss-dev@ozlabs.org
Subject: Re: [Cbe-oss-dev] [PATCH]Add notification for active Cell SPU tasks
Date: Thu, 7 Dec 2006 23:58:13 +0100
User-Agent: KMail/1.9.5
Cc: Maynard Johnson <maynardj@us.ibm.com>, Luke Browning <lukeb@br.ibm.com>,
       maynardj@linux.vnet.ibm.com,
       linuxppc-dev-bounces+lukebrowning=us.ibm.com@ozlabs.org,
       Luke Browning <lukebrowning@us.ibm.com>, linux-kernel@vger.kernel.org,
       linuxppc-dev@ozlabs.org, oprofile-list@lists.sourceforge.net
References: <OF9A01B09B.B62F8342-ON8325723C.006A9343-8325723C.006B2236@us.ibm.com> <45773E85.8040505@us.ibm.com>
In-Reply-To: <45773E85.8040505@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200612072358.15707.arnd.bergmann@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 06 December 2006 23:04, Maynard Johnson wrote:
> text(struct spu *spu, struct 
> > spu_context *ctx)
> > >
> > > Is this really the right strategy?  First, it serializes all spu 
> > context
> > > switching at the node level.  Second, it performs 17 callouts for
> >
> I could be wrong, but I think if we moved the mutex_lock to be inside of 
> the list_for_each_entry loop, we could have a race condition.  For 
> example, we obtain the next spu item from the spu_prio->active_mutex 
> list, then wait on the mutex which is being held for the purpose of 
> removing the very spu context we just obtained.
> 
> > > every context
> > > switch.  Can't oprofile internally derive the list of active spus 
> > from the  
> > > context switch callout. 
> >
> Arnd would certainly know the answer to this off the top of his head, 
> but when I initially discussed the idea for this patch with him 
> (probably a couple months ago or so), he didn't suggest a better 
> alternative.  Perhaps there is a way to do this with current SPUFS 
> code.  Arnd, any comments on this?



No code should ever need to look at other SPUs when performing an
operation on a given SPU, so we don't need to hold a global lock
during normal operation.

We have two cases that need to be handled:

- on each context unload and load (both for a full switch operation),
  call to the profiling code with a pointer to the current context
  and spu (context is NULL when unloading).

  If the new context is not know yet, scan its overlay table (expensive)
  and store information about it in an oprofile private object. Otherwise
  just point to the currently active object, this should be really cheap.

- When enabling oprofile initially, scan all contexts that are currently
  running on one of the SPUs. This is also expensive, but should happen
  before the measurement starts so it does not impact the resulting data.

> > >
> > > Also, the notify_spus_active() callout is dependent on the return 
> > code of
> > > spu_switch_notify().  Should notification be hierarchical?  If I
> > > only register
> > > for the second one, should my notification be dependent on the 
> > return code
> > > of some non-related subsystem's handler. 
> >
> I'm not exactly sure what you're saying here.  Are you suggesting that a 
> user may only be interested in acitve SPU notification and, therefore, 
> shouldn't have to be depenent on the "standard" notification 
> registration succeeding?  There may be a case for adding a new 
> registration function, I suppose; although, I'm not aware of any other 
> users of the SPUFS notification mechanism besides OProfile and PDT, and 
> we need notification of both active and future SPU tasks.  But I would 
> not object to a new function.
> 
I think what Luke was trying to get to is that notify_spus_active() should
not call blocking_notifier_call_chain(), since it will notify other users
as well as the newly registered one. Instead, it can simply call the
notifier function directly.

	Arnd <><
