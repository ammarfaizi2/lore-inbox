Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272840AbTG3LxM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 07:53:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272841AbTG3LxM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 07:53:12 -0400
Received: from mx2.elte.hu ([157.181.151.9]:8094 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S272840AbTG3LxJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 07:53:09 -0400
Date: Wed, 30 Jul 2003 13:49:52 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, <linas@austin.ibm.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: PATCH: Race in 2.6.0-test2 timer code
In-Reply-To: <20030730111639.GI23835@dualathlon.random>
Message-ID: <Pine.LNX.4.44.0307301342260.17411-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 30 Jul 2003, Andrea Arcangeli wrote:

> in del_timer, list_del can be reordered after the timer->base = NULL,
> the C compiler can do that. so list_del will run at the same time of
> internal_add_timer(base, timer) that does the list_add_tail.

no, it cannot run at the same time. The add_timer() will first lock the
current CPU's base, before touching the list. Any parallel del_timer() can
only do the list_del() if it first has locked timer->base. timer->base can
only have the base of the CPU where it_real_fn is running, or be NULL. In
the NULL case del_timer() wont do a thing but return. In the other case
the timer->base value observed by the del_timer()-executing CPU will be
the same base as where it_real_fn is running, so both the add_timer() and
the del_timer() will serialize on the same base => no parallel list
handling possible. How the compiler (or even the CPU, on non-x86) orders
the writes within the locked section is irrelevant in this scenario.

	Ingo

