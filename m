Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261520AbVBVTKs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261520AbVBVTKs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Feb 2005 14:10:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261497AbVBVTKr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Feb 2005 14:10:47 -0500
Received: from dsl027-180-174.sfo1.dsl.speakeasy.net ([216.27.180.174]:47256
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S261520AbVBVTIL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Feb 2005 14:08:11 -0500
Date: Tue, 22 Feb 2005 11:07:22 -0800
From: "David S. Miller" <davem@davemloft.net>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: mlists@danielinux.net, linux-net@vger.kernel.org,
       linux-kernel@vger.kernel.org, ccaini@deis.unibo.it,
       rfirrincieli@arces.unibo.it
Subject: Re: [PATCH] TCP-Hybla proposal
Message-Id: <20050222110722.0a9fd761.davem@davemloft.net>
In-Reply-To: <20050222094219.0a8efbe1@dxpl.pdx.osdl.net>
References: <200502221534.42948.mlists@danielinux.net>
	<20050222094219.0a8efbe1@dxpl.pdx.osdl.net>
X-Mailer: Sylpheed version 1.0.1 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Feb 2005 09:42:19 -0800
Stephen Hemminger <shemminger@osdl.org> wrote:

> The protocol choices are mutually exclusive, if you walk through the code
> (or do experiments), you find that that only one gets used.  As part of the
> longer term plan, I would like to:
> 	- have one sysctl
> 	- choice by route and destination
> 	- union for fields in control block

Let's take a first baby step and make the congestion control
algorithm a single enumeration instead of all of this
tp->foo_cong_ctrl_on, tp->bar_cong_ctrl_on stuff.  Then make
the union to shrink the tcp_sock size, we could even use an
anonymous union to make the patch a lot smaller.

We can't just get rid of all the existing sysctls.  We can
add a new one that just makes the choice as you describe.
We could therefore do something like this:

enum tcp_congctrl_alg tcp_global_congctrl_alg;

And then we use a special sysctl handler for all the individual
sysctl_tcp_bic et al. enablers that does something like:

	if (tcp_global_congctrl_alg == TCP_CONGCTRL_BIC)
		return 1;
	return 0;

and setting just does the necessary assignment to
tcp_global_congctrl_alg.  Well... I hope the sysctl framework
allows something like this :-)  If not, it should not be hard to
add.
