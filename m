Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751282AbWCJP12@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751282AbWCJP12 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 10:27:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751359AbWCJP11
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 10:27:27 -0500
Received: from mx03.cybersurf.com ([209.197.145.106]:2980 "EHLO
	mx03.cybersurf.com") by vger.kernel.org with ESMTP id S1751282AbWCJP10
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 10:27:26 -0500
Subject: Re: [UPDATED PATCH] Re: [Lse-tech] Re: [Patch 7/7] Generic netlink
	interface (delay	accounting)
From: jamal <hadi@cyberus.ca>
Reply-To: hadi@cyberus.ca
To: balbir@in.ibm.com
Cc: Shailabh Nagar <nagar@watson.ibm.com>, netdev <netdev@vger.kernel.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       lse-tech@lists.sourceforge.net
In-Reply-To: <20060309143759.GA4653@in.ibm.com>
References: <1141026996.5785.38.camel@elinux04.optonline.net>
	 <1141029060.5785.77.camel@elinux04.optonline.net>
	 <1141045194.5363.12.camel@localhost.localdomain>
	 <4403608E.1050304@watson.ibm.com>
	 <1141652556.5185.64.camel@localhost.localdomain>
	 <440C6AAA.9030301@watson.ibm.com>
	 <1141742282.5171.55.camel@localhost.localdomain>
	 <440F52FF.30908@watson.ibm.com>  <20060309143759.GA4653@in.ibm.com>
Content-Type: text/plain
Organization: unknown
Date: Fri, 10 Mar 2006 09:53:53 -0500
Message-Id: <1142002433.5298.42.camel@jzny2>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-09-03 at 20:07 +0530, Balbir Singh wrote:

> Please find the latest version of the patch for review. The genetlink
> code has been updated as per your review comments. The changelog is provided
> below
> 
> 1. Eliminated TASKSTATS_CMD_LISTEN and TASKSTATS_CMD_IGNORE
> 2. Provide generic functions called genlmsg_data() and genlmsg_len()
>    in linux/net/genetlink.h
> 3. Do not multicast all replies, multicast only events generated due
>    to task exit.
> 4. The taskstats and taskstats_reply structures are now 64 bit aligned.
> 5. Family id is dynamically generated.
> 
> Please let us know if we missed something out.

Design still shaky IMO - now that i think i may understand what your end
goal is. 
Using the principles i described in earlier email, the problem you are
trying to solve is:

a) shipping of the taskstats from kernel to user-space asynchronously to
all listeners on multicast channel/group TASKSTATS_LISTEN_GRP
at the point when some process exits.
b) responding to queries issued by the user to the kernel for taskstats
of a particular defined tgid and/or pid combination. 

Did i summarize your goals correctly?

So lets stat with #b:
i) the message is multicast; there has to be a user space app registered
to the multicast group otherwise nothing goes to user space.
ii) user space issues a GET and it seems to me the appropriate naming
for the response is a NEW.

Lets go to #a:
The issued multicast messages are also NEW and no different from the
ones sent in response to a GET.

Having said that then, you have the following commands:

enum {
       TASKSTATS_CMD_UNSPEC,           /* Reserved */
       TASKSTATS_CMD_GET,              /* user -> kernel query*/
       TASKSTATS_CMD_NEW,             /* kernel -> user update */
};

You also need the following TLVs

enum {
       TASKSTATS_TYPE_UNSPEC,           /* Reserved */
       TASKSTATS_TYPE_TGID,              /* The TGID */
       TASKSTATS_TYPE_PID,             /* The PID */
       TASKSTATS_TYPE_STATS, 		/* carries the taskstats */
       TASKSTATS_TYPE_VERS,		/* carries the version */
};

Refer to the doc i passed you and provide feedback if how to use the
above is not obvious.
 
The use of TLVs above implies that any of these can be optionally
appearing.
So when you are going from user->kernel with a GET a in #a above, then
you can specify the PID and/or TGID and you dont need to specify the
STATS and this would be perfectly legal.

On kernel->user (in the case of response to #a or async notifiation as
in #b) you really dont need to specify the TG/PID since they appear in
the STATS etc.
I take it you dont want to configure the values of taskstats from user
space, otherwise user->kernel will send a NEW as well.
I also take it dumping doesnt apply to you, so you dont need a dump
callback in your kernel code.
>From what i described so far, you dont really need a header for yourself
either (maybe you need one to just store the VERSION?)

I didnt understand the point to the err field you had in the reply.
Netlink already does issue errors which can be read via perror. If this
is different from what you need, it may be an excuse to have your own
header.

I hope this helps.

cheers,
jamal



