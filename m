Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266461AbUAIJqp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 04:46:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266462AbUAIJqp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 04:46:45 -0500
Received: from voyager.sparta.afb.lu.se ([194.47.242.75]:5344 "EHLO
	taket.barbanet.com") by vger.kernel.org with ESMTP id S266461AbUAIJql
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 04:46:41 -0500
Date: Fri, 9 Jan 2004 10:46:39 +0100
From: Anders Westrup <anders@barbanet.com>
To: Neal Stephenson <neal@bakerst.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: solved it (at lest for me) "MASQUERADE: Route sent us somewhere else."
Message-ID: <20040109094639.GD3073@taket.barbanet.com>
References: <1073620346.17985.26.camel@moran.bakerst.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1073620346.17985.26.camel@moran.bakerst.org>
User-Agent: Mutt/1.3.28i
X-Linux: Debian (http://www.debian.org)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have another solution to the same problem. I also use multiple external
interfaces and select outgoing interface via:

ip rule add from IP/range lookup TABLE

With 2.4.23 iptables -j MASQUERADE stopped working, reporting:
MASQUERADE: Route sent us somewhere else.

In my case the solution was to change my masquerade rule

iptables -t nat -A POSTROUTING -o IF -s IP/range -j MASQUERADE

to SNAT instead:

iptables -t nat -A POSTROUTING -o IF -s IP/range -j SNAT --to-source EXT-IP

With this config everything works as before 2.4.23.

regards
Anders Westrup

On Thu, Jan 08, 2004 at 10:52:26PM -0500, Neal Stephenson wrote:
> Hi,
> 
> 	I figured out my routing problems which were causing
> 
> MASQUERADE: Route sent us somewhere else.
> 
> messages from the kernel. I use iptables to masquerade and mangle
> packets so with the advanced router features i can send it out
> appropriate interfaces (i.e. web traffic out my residential ISP service
> not my commercial ISP service). See the earlier thread on this for more
> info (Subject 2.4.23 masquerading broken?). I got a useful reply from
> Martin Josefsson who suggested that ipt_MASQUERADE could no longer find
> the input-interface anymore. Upon further investigation and it seems all
> the rules with iif or from in them no longer work (at least for me). So
> rules like the following will cause the error in post 2.4.22 kernels.
> 
> ip rule add pri 420 from IP lookup TABLE
> 
> I now use exclusively rules of the form 
> 
> ip rule add pri 420 fwmark MARK table TABLE
> 
> and mark all packets needing special routing with mangling rules such as
> 
> iptables -t mangle -A PREROUTING -s IP -j MARK --set-mark MARK
> 
> this seems to prevent the problem. Don't know what changed in the
> kernel.
> 
> 		Neal
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
--------------------------------------------
Anders Westrup <anders@barbanet.com>
echo '[lddx%Px/dsnK<b]dsb203953535806376680189225555sn[ln128]sdx' | dc
