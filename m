Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263172AbTLJKEv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 05:04:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263173AbTLJKEv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 05:04:51 -0500
Received: from null.rsn.bth.se ([194.47.142.3]:64235 "EHLO null.rsn.bth.se")
	by vger.kernel.org with ESMTP id S263172AbTLJKEt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 05:04:49 -0500
Date: Wed, 10 Dec 2003 11:04:46 +0100 (CET)
From: Martin Josefsson <gandalf@wlug.westbo.se>
X-X-Sender: gandalf@tux.rsn.bth.se
To: Neal Stephenson <neal@bakerst.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.23 masquerading broken? key.oif = 0;
In-Reply-To: <1071021069.16543.14.camel@moran.bakerst.org>
Message-ID: <Pine.LNX.4.58.0312101056320.27704@tux.rsn.bth.se>
References: <1071021069.16543.14.camel@moran.bakerst.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Dec 2003, Neal Stephenson wrote:

> iptables -t mangle -A PREROUTING --protocol tcp --destination-port 80 -j
> MARK --set-mark 0x932
> iptables -t nat -A POSTROUTING -o ppp0 -j MASQUERADE
>
> ip rule add pri 424 iif eth0 fwmark 0x932 table symp
>
> 	and this is what shows up in dmesg
>
> MASQUERADE: Route sent us somewhere else.
>
> 	Any suggestions appreciated,

Try adding "-i eth0" to the mangle/PREROUTING rule
and remove "iif eth0" in the iproute rule.

I think the problem is that when the packet is routed it follows the
iproute rule and goes to the "symp" table.
But when ipt_MASQUERADE.c does another lookup to get the local
source-address of the route that this packet will match we don't have the
input-interface anymore, and thus matches another rule/route. So change
the fwmark to include the input interface.

This is just a theory, I know too little about your routingtables to say
anything more specific.

(The earlier behaviour was incorrect, ipt_MASQUERADE.c ignored
policy-routing which broke things. Now it should be a lot more sane, but
does unexpected things in some cases, like yours :)

/Martin
