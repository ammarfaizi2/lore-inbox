Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268556AbUHLNUq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268556AbUHLNUq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 09:20:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268563AbUHLNUp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 09:20:45 -0400
Received: from colin2.muc.de ([193.149.48.15]:56585 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S268556AbUHLNUW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 09:20:22 -0400
Date: 12 Aug 2004 15:20:21 +0200
Date: Thu, 12 Aug 2004 15:20:21 +0200
From: Andi Kleen <ak@muc.de>
To: Prasanna S Panchamukhi <prasanna@in.ibm.com>
Cc: linux-kernel@vger.kernel.org, suparna@in.ibm.com
Subject: Re: [4/4] Network packet tracer module using kprobes interface.
Message-ID: <20040812132021.GB39944@muc.de>
References: <20040811162212.GF24460@in.ibm.com> <20040812123541.GD2925@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040812123541.GD2925@in.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +static char config[256];
> +static unsigned short src_port, tgt_port;
> +module_param_string(netpktlog, config, 256, 0);
> +MODULE_PARM_DESC(netpktlog, " netpktlog=@<source-port>,<target-port>\n");

It would be better to use the new style module_parm here, then 
it could be even modified from sysfs at runtime when you set suitable 
permissions.

> + * with source port. Example insmod netpktlog.ko netpktlog=@62333,
> + * To trace network packets based on target port, insert module with
> + * target port.	Example insmod netpktlog.ko netpktlog=@,254
> + */
> +
> +static void jnetif_rx(struct sk_buff *skb)
> +{
> +	netfilter_ip(skb);

Are you sure this works?  I'm not sure skb->nh.iph is initialized
at this point. At this point you have to skip the ethernet header
yourself.

> +static void j__kfree_skb(struct sk_buff *skb)
> +{
> +	netfilter_ip(skb);

This may have the same problem depending on where it is called from.
Should be unlikely enough though that it could be ignored.

> +	jprobe_return();
> +}
> +
> +static int jnetif_receive_skb(struct sk_buff *skb)
> +{
> +	netfilter_ip(skb);

This function only sets skb->nh.iph
> +#include <net/udp.h>
> +
> +void tcp_send_dupack(struct sock *sk, struct sk_buff *skb);

This shouldn't be needed anymore, no? 

> +
> +static inline void option_setup(char *opt)

[...] Not sure why you made these two functions inline? 

-andi
