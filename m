Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261972AbVCRRMV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261972AbVCRRMV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Mar 2005 12:12:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261979AbVCRRMV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Mar 2005 12:12:21 -0500
Received: from mx2.elte.hu ([157.181.151.9]:28126 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261972AbVCRRL7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Mar 2005 12:11:59 -0500
Date: Fri, 18 Mar 2005 18:11:26 +0100
From: Ingo Molnar <mingo@elte.hu>
To: "Paul E. McKenney" <paulmck@us.ibm.com>
Cc: dipankar@in.ibm.com, shemminger@osdl.org, akpm@osdl.org, torvalds@osdl.org,
       rusty@au1.ibm.com, tgall@us.ibm.com, jim.houston@comcast.net,
       manfred@colorfullife.com, gh@us.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: Real-Time Preemption and RCU
Message-ID: <20050318171126.GA30310@elte.hu>
References: <20050318002026.GA2693@us.ibm.com> <20050318074903.GA27656@elte.hu> <20050318164351.GE1299@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050318164351.GE1299@us.ibm.com>
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


* Paul E. McKenney <paulmck@us.ibm.com> wrote:

> For the patch, here are my questions:
> 
> o	What is the best way to select between classic RCU and this
> 	scheme?
> 
> 	1.	Massive #ifdef across rcupdate.c
> 
> 	2.	Create an rcupdate_rt.c and browbeat the build system
> 		into picking one or the other (no clue if this is
> 		possible...)
> 
> 	3.	Create an rcupdate_rt.c and rely on the linker to pick
> 		one or the other, with rcupdate.h generating different
> 		external symbol names to make the choice.

you can also go for option #0: just replace the existing RCU code with
the new one, and i'll then deal with the configuration details.

what will have to happen is most likely #2 (since there is near zero
code sharing between the two variants, right?). Picking rcupdate_rt.c is
as simple as doing this:

 obj-$(CONFIG_DONT_PREEMPT_RCU) += rcupdate.o
 obj-$(CONFIG_PREEMPT_RCU) += rcupdate_rt.o

and then use Kconfig to generate either CONFIG_DONT_PREEMPT_RCU
(default) or CONFIG_PREEMPT_RCU (if the user selects it).

but it's not yet clear whether we want to offer this to users as a
configurable option. The simplest solution for you would be to go with
option #0 :-) [or if you prefer switchability, #1 is good too - i can
then extract the bits and do #2 based on that.]

> o	How best to interface to OOM?  Left to myself, I leave this
> 	for later.  ;-)

yeah, i'd not worry about OOM that much at this stage.

> I will take the cowardly approach of patching against the upstream
> kernel.

sure. This is in fact easier for me: i'll first rip all my RCU hackery
out of -RT and then add your code, so the base i'll be merging against
will be closer to upstream than to current -RT.

	Ingo
