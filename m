Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750762AbVILLsv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750762AbVILLsv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 07:48:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750763AbVILLsv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 07:48:51 -0400
Received: from moraine.clusterfs.com ([66.96.26.190]:3289 "EHLO
	moraine.clusterfs.com") by vger.kernel.org with ESMTP
	id S1750762AbVILLsu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 07:48:50 -0400
From: Nikita Danilov <nikita@clusterfs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17189.27398.848822.787487@gargle.gargle.HOWL>
Date: Mon, 12 Sep 2005 15:48:22 +0400
To: Paul Jackson <pj@sgi.com>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Simon Derr <Simon.Derr@bull.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpuset semaphore depth check optimize
In-Reply-To: <20050912113030.15934.9433.sendpatchset@jackhammer.engr.sgi.com>
References: <20050912113030.15934.9433.sendpatchset@jackhammer.engr.sgi.com>
X-Mailer: VM 7.17 under 21.5 (patch 17) "chayote" (+CVS-20040321) XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson writes:

[...]

 >  
 >  static inline void cpuset_down(struct semaphore *psem)
 >  {
 > -	if (current->cpuset_sem_nest_depth == 0)
 > +	if (cpuset_sem_owner != current) {
 >  		down(psem);
 > -	current->cpuset_sem_nest_depth++;
 > +		cpuset_sem_owner = current;
 > +	}
 > +	cpuset_sem_depth++;
 >  }

Err... note that now cpuset_{down,up}() take semaphore as a parameter,
but use global cpuset_sem_{owner,depth} to track recursion. This, I
believe, is an inconsistent API---it only works for a single semaphore
as passing different @psem's would lead to deadlocks and meaningless
owner and depth.

What about making these functions 

        static void cpuset_{down,up}(void);

operating on cpuset_sem internally?

"I won't rest till it's the best ..." :-)

Nikita.
