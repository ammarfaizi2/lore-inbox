Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262639AbUKLWE6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262639AbUKLWE6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 17:04:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262635AbUKLWE6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 17:04:58 -0500
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:14785
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S262639AbUKLWEX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 17:04:23 -0500
Date: Fri, 12 Nov 2004 13:49:18 -0800
From: "David S. Miller" <davem@davemloft.net>
To: Jay Vosburgh <fubar@us.ibm.com>
Cc: radheka.godse@intel.com, bonding-devel@lists.sourceforge.net,
       ctindel@users.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [Bonding-devel][PATCH]Zero Copy Transmit Support (Update)
Message-Id: <20041112134918.305379c4.davem@davemloft.net>
In-Reply-To: <200411122156.iACLuQLq014316@death.nxdomain.ibm.com>
References: <20041112132050.45b83434.davem@davemloft.net>
	<200411122156.iACLuQLq014316@death.nxdomain.ibm.com>
X-Mailer: Sylpheed version 0.9.99 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Nov 2004 13:56:26 -0800
Jay Vosburgh <fubar@us.ibm.com> wrote:

> 
> David S. Miller <davem@davemloft.net> wrote:
> >> I had similar thoughts but then, the bond device does not have any
> >> slaves attached to it at load time. By publishing them upfront the bond
> >> device is able to take advantage of hardware acceleration if it is later
> >> available...
> 
> 	"Shlomi Yaakobovich" <Shlomi@exanet.com> posted a patch to
> update the features as slaves are added and removed, based on the
> features advertised by the slaves.  His original patch wasn't properly
> based; this is the same change set redone to patch against 2.6.9.

That's definitely a good start.

It does need to be fixed to enforce the usual rules about
illegal combinations.  And his code is going to include
all sorts of weird things like VLAN offload which I wonder
if works correctly with the current bonding driver? :)

The two rules are codified in register_netdevice() as follows:

	/* Fix illegal SG+CSUM combinations. */
	if ((dev->features & NETIF_F_SG) &&
	    !(dev->features & (NETIF_F_IP_CSUM |
			       NETIF_F_NO_CSUM |
			       NETIF_F_HW_CSUM))) {
		printk("%s: Dropping NETIF_F_SG since no checksum feature.\n",
		       dev->name);
		dev->features &= ~NETIF_F_SG;
	}

	/* TSO requires that SG is present as well. */
	if ((dev->features & NETIF_F_TSO) &&
	    !(dev->features & NETIF_F_SG)) {
		printk("%s: Dropping NETIF_F_TSO since no SG feature.\n",
		       dev->name);
		dev->features &= ~NETIF_F_TSO;
	}
