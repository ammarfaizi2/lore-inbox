Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424413AbWKJVmo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424413AbWKJVmo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 16:42:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966118AbWKJVmo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 16:42:44 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:23242 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S966116AbWKJVmn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 16:42:43 -0500
Date: Fri, 10 Nov 2006 22:42:08 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Christoph Lameter <clameter@sgi.com>
Cc: "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>, akpm@osdl.org,
       mm-commits@vger.kernel.org, nickpiggin@yahoo.com.au,
       linux-kernel@vger.kernel.org
Subject: Re: + sched-use-tasklet-to-call-balancing.patch added to -mm tree
Message-ID: <20061110214208.GA23456@elte.hu>
References: <000001c70490$01cea4b0$8bc8180a@amr.corp.intel.com> <Pine.LNX.4.64.0611101027100.25459@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0611101027100.25459@schroedinger.engr.sgi.com>
User-Agent: Mutt/1.4.2.2i
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


* Christoph Lameter <clameter@sgi.com> wrote:

> On a 8p system:
> 
> I) Percent of ticks where load balancing was found to be required
> 
> II) Percent of ticks where we attempted load balancing
>    but we found that we need to try again due to load balancing
>    in progress elsewhere (This increases (I) since we found that
>    load balancing was required but we decided to defer. Tasklet
>    was not invoked).
> 
>     	I)	II) 
> Boot:	70%	~1%
> AIM7:	30%	2%
> Idle:	50%	 <0.5%
> 
> 256p:
> 	I)	II)
> Boot:	80%	30%
> AIM7:	90%	30%
> Idle: 	95%	30%

nice measurements and interesting results.

note that with a tasklet a 'retry' will often be done on the /same/ CPU 
that was running the tasklet when we tried to schedule it. I.e. such a 
'collision' will result not only in the 'loss' of the local rebalance 
event, but also causes /another/ rebalance event on the remote CPU.

so a better model would be the trylock model i suggested in the previous 
mail: to just lose the rebalance events upon collision and not cause 
extra work on the remote CPU. I'd also suggest to keep the rebalancing 
code under the irqs-off section, like it is currently - only do it 
conditional on trylock success. Do you think that would work?

	Ingo
