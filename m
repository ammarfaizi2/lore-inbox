Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318086AbSGZTfW>; Fri, 26 Jul 2002 15:35:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318437AbSGZTfV>; Fri, 26 Jul 2002 15:35:21 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:35569 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S318086AbSGZTfV>; Fri, 26 Jul 2002 15:35:21 -0400
Subject: Re: [PATCH] lock assertion macros for 2.5.28
From: Robert Love <rml@tech9.net>
To: Jesse Barnes <jbarnes@sgi.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020726174258.GC793866@sgi.com>
References: <20020725233047.GA782991@sgi.com>
	<20020726120918.GA22049@reload.namesys.com> 
	<20020726174258.GC793866@sgi.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8.99 
Date: 26 Jul 2002 12:38:37 -0700
Message-Id: <1027712317.2442.45.camel@sinai>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-07-26 at 10:42, Jesse Barnes wrote:

> Well, I had that in one version of the patch, but people didn't think
> it would be useful.  Maybe you'd like to check out Oliver's comments
> at http://marc.theaimsgroup.com/?l=linux-kernel&m=102644431806734&w=2
> and respond?  If there's demand for MUST_NOT_HOLD, I'd be happy to add
> it since it should be easy.  But if you're using it to enforce lock
> ordering as Oliver suggests, then there are probably more robust
> solutions.

Two other suggestions you could implement are CAN_SLEEP and
CANNOT_SLEEP.  You can implement them via the preempt_count.

Even if CONFIG_PREEMPT is not set, you will get preempt_count values
representing whether or not you are in an interrupt or softirq (and thus
atomic and cannot sleep).  If CONFIG_PREEMPT is set, you get a counter
that represents exactly the atomicity of the code including locks held.

E.g.,

	#define CAN_SLEEP	do { \
		assert(unlikely(!preempt_count())); \
	} while (0)

	#define CANNOT_SLEEP	do { \
		assert(unlikely(preempt_count())); \
	} while (0)

This works great because after the IRQ changes in 2.5.28, preempt_count
is a universal "are we atomic" count.

	Robert Love

