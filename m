Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262359AbVCOJ24@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262359AbVCOJ24 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 04:28:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262360AbVCOJ24
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 04:28:56 -0500
Received: from mx2.elte.hu ([157.181.151.9]:51657 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262359AbVCOJ2d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 04:28:33 -0500
Date: Tue, 15 Mar 2005 10:28:06 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Christoph Lameter <christoph@lameter.com>
Cc: Andrew Morton <akpm@osdl.org>, Oleg Nesterov <oleg@tv-sign.ru>,
       linux-kernel@vger.kernel.org, Shai Fultheim <Shai@Scalex86.org>
Subject: Re: [patch] del_timer_sync scalability patch
Message-ID: <20050315092806.GA28924@elte.hu>
References: <4231E959.141F7D85@tv-sign.ru> <42343C61.6A1210C0@tv-sign.ru> <Pine.LNX.4.58.0503150004190.13281@server.graphe.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0503150004190.13281@server.graphe.net>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Christoph Lameter <christoph@lameter.com> wrote:

> The following patch removes the magic in the timer_list structure
> (Andrew suggested that we may not need it anymore) and replaces it
> with two u8 variables that give us some additional state of the timer

The 'remove the magic' observation is not a 'backdoor' to introduce new
fields 'for free'. So please dont mix the two things into one patch.

> +       u8 running;             /* function is currently executing */
> +       u8 shutdown;            /* do not schedule this timer */

it may as well be cleaner to do the timer->base_running thing after all,
and to do this in __run_timers():

	timer->base = NULL;
	timer->base_running = base;

note that we cannot clear ->base_running in __run_timers() [we dont own
any access to the timer anymore, it may be kfree()d, etc.], so
del_timer_sync() has to make sure that the timer->base_running info is
not stale - it is a hint only. But it looks doable, and it should solve
the NUMA scalability problem.

	Ingo
