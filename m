Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264267AbTDWWgy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 18:36:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264270AbTDWWgy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 18:36:54 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:40359 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S264267AbTDWWgx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 18:36:53 -0400
Date: Wed, 23 Apr 2003 15:38:35 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrew Theurer <habanero@us.ibm.com>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org
cc: ricklind@us.ibm.com
Subject: Re: [patch] HT scheduler, sched-2.5.68-B2
Message-ID: <1574320000.1051137515@flay>
In-Reply-To: <1538380000.1051123399@flay>
References: <Pine.LNX.4.44.0304231816210.10779-100000@localhost.localdomain> <1535810000.1051120075@flay> <200304231253.09520.habanero@us.ibm.com> <1538380000.1051123399@flay>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>> >  - turn off the more agressive idle-steal variant. This could fix the
>>> >    low-load regression reported by Martin J. Bligh.
>>> 
>>> Yup, that fixed it (I tested just your first version with just that
>>> bit altered).
>> 
>> Can we make this an arch specific option?  I have a feeling the HT performance 
>> on low loads will actually drop with this disabled.  

Actually, what must be happening here is that we're agressively stealing
things on non-HT machines ... we should be able to easily prevent that.

Suppose we have 2 real cpus + HT ... A,B,C,D are the cpus, where A, B 
are HT twins, and C,D are HT twins. A&B share runqueue X, and C&D share
runqueue Y

What I presume you're trying to do is when A and B are running 1 task
each, and C and D are not running anything, balance out so we have
one on A and one on C. If we define some "nr_active(rq)" concept to be
the number of tasks actually actively running on cpus, then if we we're
switching from nr_actives of 2/0 to 1/0.

However, we don't want to switch from 2/1 to 1/2 ... that's pointless.
Or 0/1 to 1/0 (which I think it's what's happening). But in the case
where we had (theoretically) 4 HT siblings per real cpu, we would want
to migrate 1/3 to 2/2.

The key is that we want to agressively steal when 
nr_active(remote) - nr_active(idle) > 1 ... not > 0.
This will implicitly *never* happen on non HT machines, so it seems
like a nice algorithm ... ?

M.

