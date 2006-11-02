Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752811AbWKBMhg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752811AbWKBMhg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 07:37:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752813AbWKBMhg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 07:37:36 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:19110 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1752801AbWKBMhg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 07:37:36 -0500
Message-ID: <4549E68B.4020300@watson.ibm.com>
Date: Thu, 02 Nov 2006 07:37:31 -0500
From: Shailabh Nagar <nagar@watson.ibm.com>
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
MIME-Version: 1.0
To: Thomas Graf <tgraf@suug.ch>
CC: Oleg Nesterov <oleg@tv-sign.ru>, Andrew Morton <akpm@osdl.org>,
       Balbir Singh <balbir@in.ibm.com>, Jay Lan <jlan@sgi.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] taskstats: factor out reply assembling
References: <20061101182611.GA447@oleg> <20061102103402.GH12964@postel.suug.ch>
In-Reply-To: <20061102103402.GH12964@postel.suug.ch>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Graf wrote:
> * Oleg Nesterov <oleg@tv-sign.ru> 2006-11-01 21:26
>> Introduce mk_reply() helper which does all nla_put()s on reply.
>>
>> Saves 453 bytes and a preparation for the next patch.
>>
>> Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>
>>
>>  taskstats.c |   55 ++++++++++++++++++++++++++++---------------------------
>>  1 files changed, 28 insertions(+), 27 deletions(-)
>>
>> --- STATS/kernel/taskstats.c~5_factor	2006-10-31 16:33:56.000000000 +0300
>> +++ STATS/kernel/taskstats.c	2006-11-01 14:00:03.000000000 +0300
>> @@ -348,6 +348,25 @@ static int parse(struct nlattr *na, cpum
>>  	return ret;
>>  }
>>  
>> +static int mk_reply(struct sk_buff *skb, int type, u32 pid, struct taskstats *stats)
>> +{
>> +	struct nlattr *na;
>> +	int aggr;
>> +
>> +	aggr = TASKSTATS_TYPE_AGGR_TGID;
>> +	if (type == TASKSTATS_TYPE_PID)
>> +		aggr = TASKSTATS_TYPE_AGGR_PID;
>> +
>> +	na = nla_nest_start(skb, aggr);

	if (!na)
		goto nla_put_failure;

>> +	NLA_PUT_U32(skb, type, pid);
>> +	NLA_PUT_TYPE(skb, struct taskstats, TASKSTATS_TYPE_STATS, *stats);
>> +	nla_nest_end(skb, na);
>> +
>> +	return 0;
>> +nla_put_failure:
>> +	return -1;
>> +}
> 
> nla_nest_start() may return NULL, either rely on prepare_reply() to be
> correct and BUG() on failure or do proper error handling for all
> functions.

Thanks for catching that bug which was present in the unrefactored code.
The error path from prepare_reply() which generates the skb is being
handled already.

But as you point out, nla_nest_start failure, unlike those of the NLA_PUT_*
macros, isn't handled by having a nla_put_failure label alone. So we'll
need to add something like the above since we certainly don't want a BUG()
on failure !

Thanks,
Shailabh


