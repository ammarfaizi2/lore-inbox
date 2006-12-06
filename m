Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1760316AbWLFIsF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760316AbWLFIsF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 03:48:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760312AbWLFIsF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 03:48:05 -0500
Received: from twin.jikos.cz ([213.151.79.26]:36821 "EHLO twin.jikos.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760316AbWLFIsE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 03:48:04 -0500
Date: Wed, 6 Dec 2006 09:47:48 +0100 (CET)
From: Jiri Kosina <jikos@jikos.cz>
To: Ingo Molnar <mingo@elte.hu>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] let WARN_ON() output the condition
In-Reply-To: <20061206083730.GB24851@elte.hu>
Message-ID: <Pine.LNX.4.64.0612060940130.28502@twin.jikos.cz>
References: <Pine.LNX.4.64.0612060149220.28502@twin.jikos.cz>
 <20061206083730.GB24851@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Dec 2006, Ingo Molnar wrote:

> a WARN_ON() also triggers a stack dump, which should pinpoint the exact 
> location. (especially if combined with kallsyms) For example:

Actually, I was referring to something a little bit different. For example 
kernel/mutex.c:__mutex_lock_common() calls spin_lock_mutex() on line 132. 
spin_lock_mutex() contains

                DEBUG_LOCKS_WARN_ON(in_interrupt());    \
                local_irq_save(flags);                  \
                __raw_spin_lock(&(lock)->raw_lock);     \
                DEBUG_LOCKS_WARN_ON(l->magic != l);     \

When one of these two WARN_ONs trigger, we get only

	WARNING at kernel/mutex.c:132 __mutex_lock_common()

but it's indistuingishable which of the two WARN_ONs triggered. My patch 
turns this into

	WARNING (l->magic != l) at kernel/mutex.c:132 __mutex_lock_common()

> side-effects happen regularly in WARN_ON()s and while they should be 
> avoided, they are not noticed by the compiler and can cause nasty bugs 
> if executed twice. Do we really need this change?

I absolutely don't insist on it to be merged, besides this Andrew also 
pointed out non-trivial .text growth. I just cooked it up for myself when 
debugging some locking problems and that warning at kernel/mutex.c:132 
triggered, and I didn't know which one was the reason.

-- 
Jiri Kosina
