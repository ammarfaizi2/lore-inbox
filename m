Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750739AbWCYMwZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750739AbWCYMwZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Mar 2006 07:52:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751378AbWCYMwZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Mar 2006 07:52:25 -0500
Received: from mx02.cybersurf.com ([209.197.145.105]:21725 "EHLO
	mx02.cybersurf.com") by vger.kernel.org with ESMTP id S1750739AbWCYMwY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Mar 2006 07:52:24 -0500
Subject: Re: [RFC][UPDATED PATCH 2.6.16] [Patch 9/9] Generic netlink
	interface for delay accounting
From: jamal <hadi@cyberus.ca>
Reply-To: hadi@cyberus.ca
To: balbir@in.ibm.com
Cc: Matt Helsley <matthltc@us.ibm.com>, Shailabh Nagar <nagar@watson.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       netdev <netdev@vger.kernel.org>
In-Reply-To: <20060325094126.GA9376@in.ibm.com>
References: <1142296834.5858.3.camel@elinux04.optonline.net>
	 <1142297791.5858.31.camel@elinux04.optonline.net>
	 <1142303607.24621.63.camel@stark> <1142304506.5219.34.camel@jzny2>
	 <20060322074922.GA1164@in.ibm.com> <1143122686.5186.27.camel@jzny2>
	 <20060323154106.GA13159@in.ibm.com> <1143209061.5076.14.camel@jzny2>
	 <20060324145459.GA7495@in.ibm.com> <1143249565.5184.6.camel@jzny2>
	 <20060325094126.GA9376@in.ibm.com>
Content-Type: text/plain
Organization: unknown
Date: Sat, 25 Mar 2006 07:52:13 -0500
Message-Id: <1143291133.5184.32.camel@jzny2>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-25-03 at 15:11 +0530, Balbir Singh wrote:

> 
> Thanks for the advice, I will dive into nesting. I could not find any 
> in tree users who use nesting, so I have a few questions
> 

Hrm - I have to say i am suprised theres nothing; i could have sworn
Thomas had done some conversions already.

> nla_nest_start() accepts two parameters an skb and an attribute type.
> Do I have to create a new attribute type like TASKSTATS_TYPE_AGGR to
> contain the nested attributes 
> 
> TASKSTATS_TYPE_AGGR
>    TASKSTATS_TYPE_PID/TGID
>    TASKSTATS_TYPE_STATS
> 
>
> but this will lead to
> 
> TASKSTATS_TYPE_AGGR
>    TASKSTATS_TYPE_PID
>    TASKSTATS_TYPE_STATS
> TASKSTATS_TYPE_AGGR
>    TASKSTATS_TYPE_TGID
>    TASKSTATS_TYPE_STATS
> 
> being returned from taskstats_exit_pid().
> 

no this is wrong by virtue of having TASKSTATS_TYPE_AGGR twice.
Again invoke the rule i cited earlier.
What you could do instead is a second AGGR; and your nesting would be:

TASKSTATS_TYPE_AGGR1 <--- nest start with this type
   TASKSTATS_TYPE_PID <-- NLA_U32_PUT
   TASKSTATS_TYPE_STATS <-- NAL_PUT_TYPE
                     <-- nest end of TASKSTATS_TYPE_AGGR1
TASKSTATS_TYPE_AGGR2 <--- nest start with this type
   TASKSTATS_TYPE_TGID <-- NLA_U32_PUT
   TASKSTATS_TYPE_STATS <-- NAL_PUT_TYPE
                       <-- nest end of TASKSTATS_TYPE_AGGR2

> The other option is to nest
> 
> TASKSTATS_TYPE_PID/TGID
>    TASKSTATS_TYPE_STATS
> 

The advantage being you dont introduce another T.

> but the problem with this approach is, nla_len contains the length of
> all attributes including the nested attribute. So it is hard to find
> the offset of TASKSTATS_TYPE_STATS in the buffer.
> 

So you would distinguish the two as have something like:

TASKSTATS_TYPE_PID
   u32 pid
   TASKSTATS_TYPE_STATS
TASKSTATS_TYPE_TGID
   u32 tgid
   TASKSTATS_TYPE_STATS
or
TASKSTATS_TYPE_PID
   u32 pid
TASKSTATS_TYPE_TGID
   u32 tgid

both should be fine. The difference between the two is the length in the
second case will be 4 and in the other case will be larger. 

But come to think of it, this will introduce unneeded semantics; you
have very few items to do, so forget it. Go with scheme #1 but change
the names to TASKSTATS_TYPE_AGGR_PID and TASKSTATS_TYPE_AGGR_TGID.

cheers,
jamal


