Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030265AbWGFNVG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030265AbWGFNVG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 09:21:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030263AbWGFNVG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 09:21:06 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:24225 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030260AbWGFNVE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 09:21:04 -0400
Subject: Re: [PATCH] per-task delay accounting taskstats interface: control
	exit data through cpumasks]
From: Shailabh Nagar <nagar@watson.ibm.com>
Reply-To: nagar@watson.ibm.com
To: Thomas Graf <tgraf@suug.ch>
Cc: Andrew Morton <akpm@osdl.org>, Jay Lan <jlan@sgi.com>, pj@sgi.com,
       Valdis.Kletnieks@vt.edu, Balbir Singh <balbir@in.ibm.com>,
       csturtiv@sgi.com, linux-kernel <linux-kernel@vger.kernel.org>,
       Jamal <hadi@cyberus.ca>, netdev <netdev@vger.kernel.org>
In-Reply-To: <20060706120835.GY14627@postel.suug.ch>
References: <44ACD7C3.5040008@watson.ibm.com>
	 <20060706025633.cd4b1c1d.akpm@osdl.org>
	 <1152185865.5986.15.camel@localhost.localdomain>
	 <20060706120835.GY14627@postel.suug.ch>
Content-Type: text/plain
Date: Thu, 06 Jul 2006 09:21:01 -0400
Message-Id: <1152192061.1244.1.camel@manjushri.watson.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-07-06 at 14:08 +0200, Thomas Graf wrote:
> * Shailabh Nagar <nagar@watson.ibm.com> 2006-07-06 07:37
> > @@ -37,9 +45,26 @@ static struct nla_policy taskstats_cmd_g
> >  __read_mostly = {
> >  	[TASKSTATS_CMD_ATTR_PID]  = { .type = NLA_U32 },
> >  	[TASKSTATS_CMD_ATTR_TGID] = { .type = NLA_U32 },
> > +	[TASKSTATS_CMD_ATTR_REGISTER_CPUMASK] = { .type = NLA_STRING },
> > +	[TASKSTATS_CMD_ATTR_DEREGISTER_CPUMASK] = { .type = NLA_STRING },};
> 
> > +		na = info->attrs[TASKSTATS_CMD_ATTR_REGISTER_CPUMASK];
> > +		if (nla_len(na) > TASKSTATS_CPUMASK_MAXLEN)
> > +			return -E2BIG;
> > +		rc = cpulist_parse((char *)nla_data(na), mask);
> 
> This isn't safe, the data in the attribute is not guaranteed to be
> NUL terminated. Still it's probably me to blame for not making
> this more obvious in the API.
> 
> I've attached a patch below extending the API to make it easier
> for interfaces using NUL termianted strings, so you'd do:
> 
> [TASKSTATS_CMS_ATTR_REGISTER_CPUMASK] = { .type = NLA_NUL_STRING,
>                                           .len = TASKSTATS_CPUMASK_MAXLEN }
> 
> ... and then use (char *) nla_data(str_attr) without any further
> sanity checks.


Thanks. That makes it much clearer. I was looking around for a "maxlen"
attribute helper yesterday :-)

--Shailabh


> 
> [NETLINK]: Improve string attribute validation
> 
> Introduces a new attribute type NLA_NUL_STRING to support NUL
> terminated strings. Attributes of this kind require to carry
> a terminating NUL within the maximum specified in the policy.
> 
> The `old' NLA_STRING which is not required to be NUL terminated
> is extended to provide means to specify a maximum length of the
> string.
> 
> Aims at easing the pain with using nla_strlcpy() on temporary
> buffers.
> 
> The old `minlen' field is renamed to `len' for cosmetic purposes
> which is ok since nobody was using it at this point.
> 
> Signed-off-by: Thomas Graf <tgraf@suug.ch>

<snip>

