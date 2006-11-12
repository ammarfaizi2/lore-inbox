Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753309AbWKLWEm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753309AbWKLWEm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Nov 2006 17:04:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753333AbWKLWEl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Nov 2006 17:04:41 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:36276 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1753309AbWKLWEl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Nov 2006 17:04:41 -0500
Date: Sun, 12 Nov 2006 23:03:18 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Mikael Pettersson <mikpe@it.uu.se>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] floppy: suspend/resume fix
Message-ID: <20061112220318.GA3387@elte.hu>
References: <200611122047.kACKl8KP004895@harpo.it.uu.se> <20061112212941.GA31624@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061112212941.GA31624@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4.2.2i
X-ELTE-SpamScore: -2.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.8 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5003]
	-0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Russell King <rmk+lkml@arm.linux.org.uk> wrote:

> In which case isn't the real regression that it does IO?
> 
> Nevertheless, I give you two options:
> 
> 1. Abort all IO do inserted floppy disk after resume.
> 2. Corrupt replaced floppy disk after resume.
> 
> You have to pick one and exactly one.  Which is inherently less risky 
> to the end user?

this isnt about in-flight IO (suspend doesnt succeed if IO is in flight 
anyway). The bug is this:

  1) you use the floppy and then stop using it
  2) 1 hour passes. Nothing uses the floppy.
  3) you suspend and later resume
  4) another hour passes. Nothing uses the floppy.
  5) you try to use the floppy: you get a bunch of IO errors!
  6) you try to use the floppy again: this time it works

that's the regression. For some reason suspend/resume puts the floppy 
hardware into a state that confuses the floppy driver.

my patch adds all the right suspend/resume hooks for this, without 
reintroducing the bug that was noticed by lockdep and which was fixed by 
my patch that introduced this regression - we just have to figure out 
what to do upon resume to get the floppy driver and the hardware match 
up each other, without passing spurious IO errors to the user.

	Ingo
