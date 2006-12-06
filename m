Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1760345AbWLFJEx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760345AbWLFJEx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 04:04:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760351AbWLFJEx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 04:04:53 -0500
Received: from twin.jikos.cz ([213.151.79.26]:37840 "EHLO twin.jikos.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760345AbWLFJEv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 04:04:51 -0500
Date: Wed, 6 Dec 2006 10:04:43 +0100 (CET)
From: Jiri Kosina <jikos@jikos.cz>
To: Ingo Molnar <mingo@elte.hu>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] let WARN_ON() output the condition
In-Reply-To: <20061206085428.GA28160@elte.hu>
Message-ID: <Pine.LNX.4.64.0612060957180.28502@twin.jikos.cz>
References: <Pine.LNX.4.64.0612060149220.28502@twin.jikos.cz>
 <20061206083730.GB24851@elte.hu> <Pine.LNX.4.64.0612060940130.28502@twin.jikos.cz>
 <20061206085428.GA28160@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Dec 2006, Ingo Molnar wrote:

> >                 DEBUG_LOCKS_WARN_ON(in_interrupt());    \
> >                 local_irq_save(flags);                  \
> >                 __raw_spin_lock(&(lock)->raw_lock);     \
> >                 DEBUG_LOCKS_WARN_ON(l->magic != l);     \
> > When one of these two WARN_ONs trigger, we get only
> > 	WARNING at kernel/mutex.c:132 __mutex_lock_common()
> no, that's not all we get - we should also get a stackdump. Are you not 
> getting a stackdump perhaps?

I am getting stackump, but I am perhaps just blind and don't see how to 
use it to distinguish the two WARN_ONs() conveniently, besides of 
disassembling the __mutex_lock_dommon and comparing it with offset in a 
stackdump. Well, not that it's not doable, but ...

> but i agree with you in theory that your proposed output is better, but 
> the side-effect issue is a killer i think. Could you try to rework it to 
> not evaluate the condition twice and to make it dependent on 
> CONFIG_DEBUG_BUGVERBOSE? You can avoid the evaluation side-effect issue 
> by doing something like:
> 	int __c = (c);							\
>                                                                         \
>         if (unlikely(__c)) {                                            \
>                 if (debug_locks_off())                                  \
>                         WARN_ON(__c);                                   \
>                 __ret = 1;                                              \
> 

Yep, making it dependent on CONFIG_DEBUG_BUGVERBOSE makes sense. Andrew, 
will you take such patch? (when I also fix the evaluating-twice issue).

Thanks,

-- 
Jiri Kosina
