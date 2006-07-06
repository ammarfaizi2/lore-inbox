Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750936AbWGFW1x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750936AbWGFW1x (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 18:27:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750938AbWGFW1x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 18:27:53 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:31725 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750935AbWGFW1w
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 18:27:52 -0400
Message-ID: <44AD8E65.70006@watson.ibm.com>
Date: Thu, 06 Jul 2006 18:27:49 -0400
From: Shailabh Nagar <nagar@watson.ibm.com>
User-Agent: Debian Thunderbird 1.0.2 (X11/20051002)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Thomas Graf <tgraf@suug.ch>, jlan@sgi.com, pj@sgi.com,
       Valdis.Kletnieks@vt.edu, balbir@in.ibm.com, csturtiv@sgi.com,
       linux-kernel@vger.kernel.org, hadi@cyberus.ca, netdev@vger.kernel.org
Subject: Re: [PATCH] per-task delay accounting taskstats interface: control
 exit data through cpumasks]
References: <44ACD7C3.5040008@watson.ibm.com>	<20060706025633.cd4b1c1d.akpm@osdl.org>	<1152185865.5986.15.camel@localhost.localdomain>	<20060706120835.GY14627@postel.suug.ch> <20060706144808.1dd5fadf.akpm@osdl.org>
In-Reply-To: <20060706144808.1dd5fadf.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Thomas Graf <tgraf@suug.ch> wrote:
> 
>>* Shailabh Nagar <nagar@watson.ibm.com> 2006-07-06 07:37
>>
>>>@@ -37,9 +45,26 @@ static struct nla_policy taskstats_cmd_g
>>> __read_mostly = {
>>> 	[TASKSTATS_CMD_ATTR_PID]  = { .type = NLA_U32 },
>>> 	[TASKSTATS_CMD_ATTR_TGID] = { .type = NLA_U32 },
>>>+	[TASKSTATS_CMD_ATTR_REGISTER_CPUMASK] = { .type = NLA_STRING },
>>>+	[TASKSTATS_CMD_ATTR_DEREGISTER_CPUMASK] = { .type = NLA_STRING },};
>>
>>>+		na = info->attrs[TASKSTATS_CMD_ATTR_REGISTER_CPUMASK];
>>>+		if (nla_len(na) > TASKSTATS_CPUMASK_MAXLEN)
>>>+			return -E2BIG;
>>>+		rc = cpulist_parse((char *)nla_data(na), mask);
>>
>>This isn't safe, the data in the attribute is not guaranteed to be
>>NUL terminated. Still it's probably me to blame for not making
>>this more obvious in the API.
>>
> 
> 
> Thanks, that was an unpleasant bug.
> 
> 
>>I've attached a patch below extending the API to make it easier
>>for interfaces using NUL termianted strings,
> 
> 
> In the interests of keeping this work decoupled from netlink enhancements
> I'd propose the below.  

The patch looks good. I was also thinking of simply modifying the input
to have the null termination and modify later when netlink provides
generic support.


> Is it bad to modify the data at nla_data()?
> 
> 
> --- a/kernel/taskstats.c~per-task-delay-accounting-taskstats-interface-control-exit-data-through-cpumasks-fix
> +++ a/kernel/taskstats.c
> @@ -299,6 +299,23 @@ cleanup:
>  	return 0;
>  }
>  
> +static int parse(struct nlattr *na, cpumask_t *mask)
> +{
> +	char *data;
> +	int len;
> +
> +	if (na == NULL)
> +		return 1;
> +	len = nla_len(na);
> +	if (len > TASKSTATS_CPUMASK_MAXLEN)
> +		return -E2BIG;
> +	if (len < 1)
> +		return -EINVAL;
> +	data = nla_data(na);
> +	data[len - 1] = '\0';
> +	return cpulist_parse(data, *mask);
> +}
> +
>  static int taskstats_user_cmd(struct sk_buff *skb, struct genl_info *info)
>  {
>  	int rc = 0;
> @@ -309,27 +326,17 @@ static int taskstats_user_cmd(struct sk_
>  	struct nlattr *na;
>  	cpumask_t mask;
>  
> -	if (info->attrs[TASKSTATS_CMD_ATTR_REGISTER_CPUMASK]) {
> -		na = info->attrs[TASKSTATS_CMD_ATTR_REGISTER_CPUMASK];
> -		if (nla_len(na) > TASKSTATS_CPUMASK_MAXLEN)
> -			return -E2BIG;
> -		rc = cpulist_parse((char *)nla_data(na), mask);
> -		if (rc)
> -			return rc;
> -		rc = add_del_listener(info->snd_pid, &mask, REGISTER);
> +	rc = parse(info->attrs[TASKSTATS_CMD_ATTR_REGISTER_CPUMASK], &mask);
> +	if (rc < 0)
>  		return rc;
> -	}
> +	if (rc == 0)
> +		return add_del_listener(info->snd_pid, &mask, REGISTER);
>  
> -	if (info->attrs[TASKSTATS_CMD_ATTR_DEREGISTER_CPUMASK]) {
> -		na = info->attrs[TASKSTATS_CMD_ATTR_DEREGISTER_CPUMASK];
> -		if (nla_len(na) > TASKSTATS_CPUMASK_MAXLEN)
> -			return -E2BIG;
> -		rc = cpulist_parse((char *)nla_data(na), mask);
> -		if (rc)
> -			return rc;
> -		rc = add_del_listener(info->snd_pid, &mask, DEREGISTER);
> +	rc = parse(info->attrs[TASKSTATS_CMD_ATTR_DEREGISTER_CPUMASK], &mask);
> +	if (rc < 0)
>  		return rc;
> -	}
> +	if (rc == 0)
> +		return add_del_listener(info->snd_pid, &mask, DEREGISTER);
>  
>  	/*
>  	 * Size includes space for nested attributes
> _
> 

