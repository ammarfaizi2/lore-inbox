Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262424AbUKLAQe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262424AbUKLAQe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 19:16:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262415AbUKLAQa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 19:16:30 -0500
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:40889
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S262439AbUKLANr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 19:13:47 -0500
Date: Thu, 11 Nov 2004 16:00:21 -0800
From: "David S. Miller" <davem@davemloft.net>
To: Radheka Godse <radheka.godse@intel.com>
Cc: bonding-devel@lists.sourceforge.net, fubar@us.ibm.com,
       ctindel@users.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [Bonding-devel][PATCH]Zero Copy Transmit Support (Update)
Message-Id: <20041111160021.5c586095.davem@davemloft.net>
In-Reply-To: <Pine.LNX.4.61.0411121515530.15487@localhost.localdomain>
References: <Pine.LNX.4.61.0411121515530.15487@localhost.localdomain>
X-Mailer: Sylpheed version 0.9.99 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Nov 2004 15:51:49 -0800 (PST)
Radheka Godse <radheka.godse@intel.com> wrote:

> -
> + 
> +	/* We let the bond device publish all hardware
> +	 * acceleration features possible. This is OK,
> +	 * since if an skb is passed from the bond to
> +	 * a slave that doesn't support one of those
> +	 * features, everything is fixed in the
> +	 * dev_queue_xmit() function (e.g. calculate
> +	 * check sum, linearize the skb, etc.).
> +	 */

This is very inefficient if the bond slaves don't
support these features.

I believe you when you say you saw improvement in the
case where the slaves do support TSO, but if you test
a non-TSO slave case I bet you'll see a marked
decrease in system utilization at least.

The upper layers need to know the precise capabilities
of the device in order to optimize the copy from userspace,
the checksumming, and the data gathering into the SKB.

Therefore, if you "fake it out" like this without checking
what the slaves actually support, then a lot of wasted cpu
time will be spent in each dev_queue_xmit() path.  There will
in many cases be multiple passes over the data instead of one,
and it is possible to introduce an extra data copy as well.

I would recommend instead the following algorithm.  Publish
only the capabilities which all slaves support.
