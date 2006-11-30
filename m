Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759122AbWK3Ibw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759122AbWK3Ibw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 03:31:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759124AbWK3Ibw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 03:31:52 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:58330 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1759122AbWK3Ibv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 03:31:51 -0500
Date: Thu, 30 Nov 2006 09:29:34 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Gautham R Shenoy <ego@in.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       torvalds@osdl.org, davej@redhat.com, dipankar@in.ibm.com,
       vatsa@in.ibm.com
Subject: Re: CPUFREQ-CPUHOTPLUG: Possible circular locking dependency
Message-ID: <20061130082934.GB29609@elte.hu>
References: <20061129152404.GA7082@in.ibm.com> <20061129130556.d20c726e.akpm@osdl.org> <20061130042807.GA4855@in.ibm.com> <20061130063512.GA19492@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061130063512.GA19492@in.ibm.com>
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=none autolearn=no SpamAssassin version=3.0.3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Gautham R Shenoy <ego@in.ibm.com> wrote:

> Ok, I see that we are already doing it :(. So we can end up in a 
> deadlock.
> 
> Here's the culprit callpath:

in general lockdep is 100% correct when it comes to "individual locks". 
The overwhelming majority of lockdep false-positives is not due to 
lockdep not getting the dependencies right, but due to the "lock class" 
not being correctly identified. That's not an issue here i think.

what lockdep does is it observes actual locking dependencies as they 
happen individually in various contexts, and then 'completes' the 
dependency graph by combining all the possible scenarios how contexts 
might preempt each other. So if lockdep sees independent dependencies 
and concludes that they are circular, there's nothing that saves us from 
the deadlock.

The only way for those dependencies to /never/ trigger simultaneously on 
different CPUs would be via the use of a further 'outer' exclusion 
mechanism (i.e. a lock) - but all explicit kernel-API exclusion 
mechanisms are tracked by lockdep => Q.E.D. (Open-coded exclusion might 
escape the attention of lockdep, but those are extremely rare and are 
also easily found.)

	Ingo
