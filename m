Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932155AbWCWOIE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932155AbWCWOIE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 09:08:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932181AbWCWOIE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 09:08:04 -0500
Received: from mx03.cybersurf.com ([209.197.145.106]:48306 "EHLO
	mx03.cybersurf.com") by vger.kernel.org with ESMTP id S932155AbWCWOIA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 09:08:00 -0500
Subject: Re: [RFC][UPDATED PATCH 2.6.16] [Patch 9/9] Generic netlink
	interface for delay accounting
From: jamal <hadi@cyberus.ca>
Reply-To: hadi@cyberus.ca
To: balbir@in.ibm.com
Cc: Matt Helsley <matthltc@us.ibm.com>, Shailabh Nagar <nagar@watson.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       netdev <netdev@vger.kernel.org>
In-Reply-To: <20060322074922.GA1164@in.ibm.com>
References: <1142296834.5858.3.camel@elinux04.optonline.net>
	 <1142297791.5858.31.camel@elinux04.optonline.net>
	 <1142303607.24621.63.camel@stark> <1142304506.5219.34.camel@jzny2>
	 <20060322074922.GA1164@in.ibm.com>
Content-Type: text/plain
Organization: unknown
Date: Thu, 23 Mar 2006 09:04:46 -0500
Message-Id: <1143122686.5186.27.camel@jzny2>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Balbir,

Looking good.
This is a quick scan, so i didnt look at little details.
Some comments embedded.

On Wed, 2006-22-03 at 13:19 +0530, Balbir Singh wrote:




>  

> diff -puN /dev/null include/linux/taskstats.h

> + * The struct is versioned. Newer versions should only add fields to
> + * the bottom of the struct to maintain backward compatibility.
> + *
> + * To create the next version, bump up the taskstats_version variable
> + * and delineate the start of newly added fields with a comment indicating
> + * the version number.
> + */
> +



> +enum {
> +	TASKSTATS_MSG_UNICAST,		/* send data only to requester */
> +	TASKSTATS_MSG_MULTICAST,	/* send data to a group */
> +};
> +

Above will never be used outside of the kernel.
Should it go under the ifdef kernel below?


> +#ifdef __KERNEL__
> +

Note: some people will argue that you should probably have
two header files. One for all kernel things and includes another
which contains all the stuff above ifdef __KERNEL__

> +
> +#endif /* __KERNEL__ */
> +#endif /* _LINUX_TASKSTATS_H */




> diff -puN kernel/Makefile~delayacct-genetlink kernel/Makefile
> --- linux-2.6.16/kernel/Makefile~delayacct-genetlink	2006-03-22 11:56:03.000000000 +0530
> +++ linux-2.6.16-balbir/kernel/Makefile	2006-03-22 11:56:03.000000000 +0530

> +
> +const int taskstats_version = TASKSTATS_VERSION;
> +static DEFINE_PER_CPU(__u32, taskstats_seqnum) = { 0 };
> +static int family_registered = 0;
> +
> +static struct genl_family family = {
> +	.id             = GENL_ID_GENERATE,
> +	.name           = TASKSTATS_GENL_NAME,
> +	.version        = TASKSTATS_GENL_VERSION,
> +	.hdrsize        = 0,

Do you need to specify hdrsize of 0?


> +static int prepare_reply(struct genl_info *info, u8 cmd, struct sk_buff **skbp,
> +			 void **replyp)
> +{
> +	struct sk_buff *skb;
> +	void *reply;
> +
> +	skb = nlmsg_new(NLMSG_GOODSIZE);

Ok,  getting a size of NLMSG_GOODSIZE is not a good idea. 
The max size youll ever get it seems to me is 2*32-bit-data TLVs +
sizeof struct stats. Why dont you allocate that size?

> +	if (!skb)
> +		return -ENOMEM;
> +
> +	if (!info) {
> +		int seq = get_cpu_var(taskstats_seqnum)++;
> +		put_cpu_var(taskstats_seqnum);
> +
> +		reply = genlmsg_put(skb, 0, seq,
> +				    family.id, 0, NLM_F_REQUEST,
> +				    cmd, family.version);

Double check if you need NLM_F_REQUEST

> +	} else
> +		reply = genlmsg_put(skb, info->snd_pid, info->snd_seq,
> +				    family.id, 0, info->nlhdr->nlmsg_flags,
> +				    info->genlhdr->cmd, family.version);

A Response to a GET is a NEW. So i dont think info->genlhdr->cmd is the
right thing?





> +static int taskstats_send_stats(struct sk_buff *skb, struct genl_info *info)
> +{
> +	int rc;
> +	struct sk_buff *rep_skb;
> +	struct taskstats stats;
> +	void *reply;
> +
> +	memset(&stats, 0, sizeof(stats));
> +	rc = prepare_reply(info, info->genlhdr->cmd, &rep_skb, &reply);

Same comment as before: a response to a GET is a NEW; so
info->genlhdr->cmd doesnt seem right.

> +	if (rc < 0)
> +		return rc;
> +
> +	if (info->attrs[TASKSTATS_CMD_ATTR_PID]) {
> +		u32 pid = nla_get_u32(info->attrs[TASKSTATS_CMD_ATTR_PID]);
> +		NLA_PUT_U32(rep_skb, TASKSTATS_TYPE_PID, pid);
> +		rc = fill_pid((pid_t)pid, NULL, &stats);
> +		if (rc < 0)
> +			return rc;
> +	}
> +
> +	if (info->attrs[TASKSTATS_CMD_ATTR_TGID]) {
> +		u32 tgid = nla_get_u32(info->attrs[TASKSTATS_CMD_ATTR_TGID]);
> +		NLA_PUT_U32(rep_skb, TASKSTATS_TYPE_TGID, tgid);
> +		rc = fill_tgid((pid_t)tgid, NULL, &stats);
> +		if (rc < 0)
> +			return rc;
> +	}
> +

Should there be at least either a pid or tgid? If yes, you need to
validate here...

> +	NLA_PUT_TYPE(rep_skb, struct taskstats, TASKSTATS_TYPE_STATS, stats);
> +	return send_reply(rep_skb, info->snd_pid, TASKSTATS_MSG_UNICAST);
> +
> +nla_put_failure:
> +	return genlmsg_cancel(rep_skb, reply);
> +

As a general comment double check your logic for errors; if you already
have stashed something in the skb, you need to remove it etc.

> +}
> +
> +
> +/* Send pid data out on exit */
> +void taskstats_exit_pid(struct task_struct *tsk)
> +{
> +	int rc;
> +	struct sk_buff *rep_skb;
> +	void *reply;
> +	struct taskstats stats;
> +
> +	/*
> +	 * tasks can start to exit very early. Ensure that the family
> +	 * is registered before notifications are sent out
> +	 */
> +	if (!family_registered)
> +		return;
> +
> +	memset(&stats, 0, sizeof(stats));
> +	rc = prepare_reply(NULL, TASKSTATS_CMD_NEW, &rep_skb, &reply);
> +	if (rc < 0)
> +		return;
> +
> +	NLA_PUT_U32(rep_skb, TASKSTATS_TYPE_PID, (u32)tsk->pid);
> +	rc = fill_pid(tsk->pid, tsk, &stats);
> +	if (rc < 0)
> +		return;
> +
> +	NLA_PUT_TYPE(rep_skb, struct taskstats, TASKSTATS_TYPE_STATS, stats);
> +	rc = send_reply(rep_skb, 0, TASKSTATS_MSG_MULTICAST);
> +
> +	if (rc || thread_group_empty(tsk))
> +		return;
> +
> +	/* Send tgid data too */
> +	rc = prepare_reply(NULL, TASKSTATS_CMD_NEW, &rep_skb, &reply);
> +	if (rc < 0)
> +		return;
> +

A single message with PID+TGID sounds reasonable. Why two messages with
two stats? all you will need to do is get rid of the prepare_reply()
above and NLA_PUT_U32() below (just like you do in a response to a GET.

> +	NLA_PUT_U32(rep_skb, TASKSTATS_TYPE_TGID, (u32)tsk->tgid);
> +	rc = fill_tgid(tsk->tgid, tsk, &stats);
> +	if (rc < 0)
> +		return;
> +
> +	NLA_PUT_TYPE(rep_skb, struct taskstats, TASKSTATS_TYPE_STATS, stats);
> +	send_reply(rep_skb, 0, TASKSTATS_MSG_MULTICAST);
> +
> +nla_put_failure:
> +	genlmsg_cancel(rep_skb, reply);
> +}


Other than the above comments - I believe you have it right.

cheers,
jamal

