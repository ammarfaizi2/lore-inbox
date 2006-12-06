Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1760325AbWLFIzp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760325AbWLFIzp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 03:55:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760330AbWLFIzp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 03:55:45 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:44888 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760325AbWLFIzo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 03:55:44 -0500
Date: Wed, 6 Dec 2006 09:54:28 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Jiri Kosina <jikos@jikos.cz>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] let WARN_ON() output the condition
Message-ID: <20061206085428.GA28160@elte.hu>
References: <Pine.LNX.4.64.0612060149220.28502@twin.jikos.cz> <20061206083730.GB24851@elte.hu> <Pine.LNX.4.64.0612060940130.28502@twin.jikos.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0612060940130.28502@twin.jikos.cz>
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Jiri Kosina <jikos@jikos.cz> wrote:

> On Wed, 6 Dec 2006, Ingo Molnar wrote:
> 
> > a WARN_ON() also triggers a stack dump, which should pinpoint the exact 
> > location. (especially if combined with kallsyms) For example:
> 
> Actually, I was referring to something a little bit different. For example 
> kernel/mutex.c:__mutex_lock_common() calls spin_lock_mutex() on line 132. 
> spin_lock_mutex() contains
> 
>                 DEBUG_LOCKS_WARN_ON(in_interrupt());    \
>                 local_irq_save(flags);                  \
>                 __raw_spin_lock(&(lock)->raw_lock);     \
>                 DEBUG_LOCKS_WARN_ON(l->magic != l);     \
> 
> When one of these two WARN_ONs trigger, we get only
> 
> 	WARNING at kernel/mutex.c:132 __mutex_lock_common()

no, that's not all we get - we should also get a stackdump. Are you not 
getting a stackdump perhaps?

but i agree with you in theory that your proposed output is better, but 
the side-effect issue is a killer i think. Could you try to rework it to 
not evaluate the condition twice and to make it dependent on 
CONFIG_DEBUG_BUGVERBOSE? You can avoid the evaluation side-effect issue 
by doing something like:

	int __c = (c);							\
                                                                        \
        if (unlikely(__c)) {                                            \
                if (debug_locks_off())                                  \
                        WARN_ON(__c);                                   \
                __ret = 1;                                              \

	Ingo
