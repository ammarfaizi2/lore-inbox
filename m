Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751251AbWJEIp2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751251AbWJEIp2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 04:45:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751344AbWJEIp2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 04:45:28 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:19658 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751251AbWJEIp1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 04:45:27 -0400
Date: Thu, 5 Oct 2006 10:37:54 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: make-bogus-warnings-go-away tree [was: 2.6.18-mm3]
Message-ID: <20061005083754.GA1060@elte.hu>
References: <20061003001115.e898b8cb.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061003001115.e898b8cb.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.8 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	-0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrew Morton <akpm@osdl.org> wrote:

> - Added Jeff's make-bogus-warnings-go-away tree to the -mm lineup, as
>   git-gccbug.patch

Jeff: very nice! (I did this myself on a much smaller scale for the -rt 
patch, because it's just so lethal if some serious warning gets lost in 
the myriads of 'possible use of uninitialized' messages.)

A small suggestion: to give GCC folks a chance to actually fix this, 
could we actively annotate these places instead of working them around?
I.e., instead of:

        long cursor = 0;
        int error = 0;
-       void *new_mc;
+       void *new_mc = NULL;
        int cpu;
        cpumask_t old;

couldnt we do:

	void *new_mc __GCC_WARN_BUG;

and then do something like this in gcc.h:

 #ifdef CONFIG_ELIMINATE_BOGUS_GCC_WARNINGS
 # define __GCC_WARN_BUG = 0
 #else
 # define __GCC_WARN_BUG
 #endif

this both gives an in-source incentive for GCC folks to get rid of these 
bogus warnings (or remain shamed for eternity), and gives us the ability 
to control the presence of these workarounds (and the eventual ability 
to eliminate them in the future).

this would also mean we could merge your tree upstream without worrying 
about hiding gcc bugs.

	Ingo
