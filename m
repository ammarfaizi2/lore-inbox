Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424471AbWKKBBz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424471AbWKKBBz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 20:01:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424472AbWKKBBz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 20:01:55 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:59611 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1424471AbWKKBBy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 20:01:54 -0500
Date: Fri, 10 Nov 2006 17:01:27 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: Ingo Molnar <mingo@elte.hu>
cc: "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>, akpm@osdl.org,
       mm-commits@vger.kernel.org, nickpiggin@yahoo.com.au,
       linux-kernel@vger.kernel.org
Subject: Re: + sched-use-tasklet-to-call-balancing.patch added to -mm tree
In-Reply-To: <20061110213839.GA21928@elte.hu>
Message-ID: <Pine.LNX.4.64.0611101648310.26789@schroedinger.engr.sgi.com>
References: <000001c70490$01cea4b0$8bc8180a@amr.corp.intel.com>
 <Pine.LNX.4.64.0611101027100.25459@schroedinger.engr.sgi.com>
 <20061110213839.GA21928@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Nov 2006, Ingo Molnar wrote:

> ok, that's what i suspected - what made the difference wasnt the fact 
> that it was moved out of irqs-off section, but that it was running 
> globally, instead of in parallel on every cpu. I have no conceptual 
> problem with single-threading the more invasive load-balancing bits. 
> (since it has to touch every runqueue anyway there's probably little 
> parallelism possible) But it's a scary change nevertheless, it 
> materially affects every SMP system's balancing characteristics.

We saw multiple issues. The first we saw was interrupt holdoff related 
since IPIs took a long time to complete. The other was that multiple 
load balance actions in multiple CPUs seem to serialize on the locks 
trying each to move tasks off the same busy processor. So both better be 
addressed.

Load balancing for small domains is running faster so there is less chance 
of parallelism. It seems that the staggering of the timer interrupt is 
sufficient on smaller systems to avoid concurrent load balancing 
operations.

