Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751648AbWCYSWO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751648AbWCYSWO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Mar 2006 13:22:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751651AbWCYSWO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Mar 2006 13:22:14 -0500
Received: from nproxy.gmail.com ([64.233.182.188]:44338 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751648AbWCYSWN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Mar 2006 13:22:13 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fALPp8sYMGgcz23uqPQmoy7n+jjZZnwIDeAL8I7hH4571s93FyCVGeDFTRp6pDX23QawDnYLE3eLoSOQXw2AESFz6VaZc/Vp42+8GjZsOb2BwcPPsWplO40B54TwrgMNXVUYoGZogCtJXAWBVhJvLSDHl6T1ReBcOGGmFIl0rnw=
Message-ID: <661de9470603251022w7f8991e9g73d70a65f5d475ea@mail.gmail.com>
Date: Sat, 25 Mar 2006 23:52:12 +0530
From: "Balbir Singh" <balbir@in.ibm.com>
Reply-To: balbir@in.ibm.com
To: hadi@cyberus.ca
Subject: Re: [RFC][UPDATED PATCH 2.6.16] [Patch 9/9] Generic netlink interface for delay accounting
Cc: "Matt Helsley" <matthltc@us.ibm.com>,
       "Shailabh Nagar" <nagar@watson.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       netdev <netdev@vger.kernel.org>
In-Reply-To: <1143308901.5184.48.camel@jzny2>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1142303607.24621.63.camel@stark> <1143122686.5186.27.camel@jzny2>
	 <20060323154106.GA13159@in.ibm.com> <1143209061.5076.14.camel@jzny2>
	 <20060324145459.GA7495@in.ibm.com> <1143249565.5184.6.camel@jzny2>
	 <20060325094126.GA9376@in.ibm.com> <1143291133.5184.32.camel@jzny2>
	 <20060325153632.GA25431@in.ibm.com> <1143308901.5184.48.camel@jzny2>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/25/06, jamal <hadi@cyberus.ca> wrote:
> On Sat, 2006-25-03 at 21:06 +0530, Balbir Singh wrote:
> > On Sat, Mar 25, 2006 at 07:52:13AM -0500, jamal wrote:
>
>
> I didnt pay attention to failure paths etc; i suppose your testing
> should catch those. Getting there, a couple more comments:
>

Yes, I have tried several negative test cases.

>
> > +enum {
> > +     TASKSTATS_CMD_UNSPEC = 0,       /* Reserved */
> > +     TASKSTATS_CMD_GET,              /* user->kernel request */
> > +     TASKSTATS_CMD_NEW,              /* kernel->user event */
>
> Should the comment read "kernel->user event/get-response"
>

Yes, good catch. I will update the comment.

>
> > +
> > +static int taskstats_send_stats(struct sk_buff *skb, struct genl_info *info)
> > +{
>
>
> > +
> > +     if (info->attrs[TASKSTATS_CMD_ATTR_PID]) {
> > +             u32 pid = nla_get_u32(info->attrs[TASKSTATS_CMD_ATTR_PID]);
> > +             rc = fill_pid((pid_t)pid, NULL, &stats);
> > +             if (rc < 0)
> > +                     goto err;
> > +
> > +             na = nla_nest_start(rep_skb, TASKSTATS_TYPE_AGGR_PID);
> > +             NLA_PUT_U32(rep_skb, TASKSTATS_TYPE_PID, pid);
> > +     } else if (info->attrs[TASKSTATS_CMD_ATTR_TGID]) {
>
> in regards to the elseif above:
> Could you not have both PID and TGID passed? From my earlier
> understanding it seemed legit, no? if answer is yes, then you will have
> to do your sizes + reply TLVs at the end.

No, we cannot have both passed. If we pass both a PID and a TGID and
then the code returns just the stats for the PID.

>
> Also in regards to the nesting, isnt there a need for nla_nest_cancel in
> case of failures to add TLVs?
>

I thought about it, but when I looked at the code of genlmsg_cancel()
and nla_nest_cancel().  It seemed that genlmsg_cancel() should
suffice.

<snippet>
static inline int genlmsg_cancel(struct sk_buff *skb, void *hdr)
{
        return nlmsg_cancel(skb, hdr - GENL_HDRLEN - NLMSG_HDRLEN);
}

static inline int nlmsg_cancel(struct sk_buff *skb, struct nlmsghdr *nlh)
{
        skb_trim(skb, (unsigned char *) nlh - skb->data);

        return -1;
}

static inline int nla_nest_cancel(struct sk_buff *skb, struct nlattr *start)
{
        if (start)
                skb_trim(skb, (unsigned char *) start - skb->data);

        return -1;
}

</snippet>

genlmsg_cancel() seemed more generic, since it handles skb_trim from
the nlmsghdr down to skb->data, where as nla_test_cancel() does it
only from the start of the nested attributes to skb->data.

Is my understanding correct?


> cheers,
> jamal
>

Thanks,
Balbir
