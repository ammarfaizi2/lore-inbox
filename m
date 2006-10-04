Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161804AbWJDRLM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161804AbWJDRLM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 13:11:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161813AbWJDRLL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 13:11:11 -0400
Received: from mga07.intel.com ([143.182.124.22]:5755 "EHLO
	azsmga101.ch.intel.com") by vger.kernel.org with ESMTP
	id S1161804AbWJDRLJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 13:11:09 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,256,1157353200"; 
   d="scan'208"; a="126892057:sNHT40953822"
Subject: Re: [PATCH] Fix WARN_ON / WARN_ON_ONCE regression
From: Tim Chen <tim.c.chen@linux.intel.com>
Reply-To: tim.c.chen@linux.intel.com
To: Andrew Morton <akpm@osdl.org>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, herbert@gondor.apana.org.au,
       linux-kernel@vger.kernel.org, leonid.i.ananiev@intel.com
In-Reply-To: <20061004093025.ab235eaa.akpm@osdl.org>
References: <1159916644.8035.35.camel@localhost.localdomain>
	 <4522FB04.1080001@goop.org>
	 <1159919263.8035.65.camel@localhost.localdomain>
	 <45233B1E.3010100@goop.org>
	 <1159968095.8035.76.camel@localhost.localdomain>
	 <20061004093025.ab235eaa.akpm@osdl.org>
Content-Type: text/plain
Organization: Intel
Date: Wed, 04 Oct 2006 09:22:09 -0700
Message-Id: <1159978929.8035.109.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-8) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-10-04 at 09:30 -0700, Andrew Morton wrote:

> > I have measured the cache miss with tool.  So it is not just my theory.
> > 
> 
> And what did that tool tell you?

I am using emon.  Measuring a 20 second stretch of tbench run saw the L2
cache miss go from 14 million to 25 million on each of the cpu core.
> 
> Please don't just ignore my questions.  *why* are we getting a cache miss
> rate on that integer which is causing measurable performance changes?  If
> we're reading it that frequently then the variable should be in cache(!).
> 

The point is valid, __warn_once should be in cache, unless something
evicts it. What I have found so far is with patch by Andrew and Leonid
that avoid looking up the __warn_once integer, the cache miss rate is
reduced to the level before.  

> Again: do you know which callsite is causing the problem?  I assume one of
> the ones in softirq.c?  Do you know what the cache miss frequency is?  etc.
> 
Unfortunately emon does not directly give the callsite.  Oprofile data
shows a marked increase in time spent in do_softirq and local_bh_enable.
What I could do is to individually turn off WARN_ON_ONCE at these sites
and see if they are responsible for the cache miss.  Will let you know
what I found.

Oprofile data --
Before WARN_ON_ONCE patch:

117767 thread_return                           
106651 local_bh_enable                          
 83767 tcp_v4_rcv                                
 72266 copy_user_generic_unrolled               
 47136 do_softirq                              

 41100 tcp_recvmsg                               
 39394 tcp_sendmsg        
118383 thread_return                            
 88171 copy_user_generic                        
                           
..
  8281 local_bh_enable
  6790 do_softirq                                

After WARN_ON_ONCE patch:

117767 thread_return                           
106651 local_bh_enable                          
 83767 tcp_v4_rcv                                
 72266 copy_user_generic_unrolled               
 47136 do_softirq                              


Tim
