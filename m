Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267180AbUHDBli@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267180AbUHDBli (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 21:41:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267184AbUHDBli
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 21:41:38 -0400
Received: from mx1.redhat.com ([66.187.233.31]:36271 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267180AbUHDBlc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 21:41:32 -0400
Date: Tue, 3 Aug 2004 18:39:19 -0700
From: "David S. Miller" <davem@redhat.com>
To: Pekka Pietikainen <pp@ee.oulu.fi>
Cc: jgarzik@pobox.com, jolt@tuxbox.org, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com
Subject: Re: [PATCH] b44 1GB DMA workaround (was: b44: add 47xx support)
Message-Id: <20040803183919.2990d045.davem@redhat.com>
In-Reply-To: <20040804003108.GA10445@ee.oulu.fi>
References: <200407232335.37809.jolt@tuxbox.org>
	<20040726141128.GA5435@ee.oulu.fi>
	<20040804003108.GA10445@ee.oulu.fi>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Aug 2004 03:31:08 +0300
Pekka Pietikainen <pp@ee.oulu.fi> wrote:

> +	if(mapping+len > B44_DMA_MASK) {
> +		/* Chip can't handle DMA to/from >1GB, use bounce buffer */
> +		pci_unmap_single(bp->pdev, mapping, len,PCI_DMA_TODEVICE);
> +		memcpy(bp->tx_bufs+entry*TX_PKT_BUF_SZ,skb->data,skb->len);
> +		skb->data=bp->tx_bufs+entry*TX_PKT_BUF_SZ;
> +		mapping = pci_map_single(bp->pdev, skb->data, len, PCI_DMA_TODEVICE);
> +	}

Changing skb->data is not legal.  Please implement this in
such a way that skb->data does not get modified.  By modifying
skb->data you will break things such as packet sniffers and
netfilter, and that's just the tip of the iceberg. :-)

I would suggest merely freeing up this TX skb, and marking the
entry in the b44 software state with some dummy skb pointer
such as (void *) 0x1UL or something like that to indicate
this case.
