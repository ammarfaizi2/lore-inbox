Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264881AbUHHAGp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264881AbUHHAGp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Aug 2004 20:06:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264900AbUHHAGp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Aug 2004 20:06:45 -0400
Received: from mx1.redhat.com ([66.187.233.31]:17367 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264881AbUHHAGo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Aug 2004 20:06:44 -0400
Date: Sat, 7 Aug 2004 17:05:03 -0700
From: "David S. Miller" <davem@redhat.com>
To: Pekka Pietikainen <pp@ee.oulu.fi>
Cc: jgarzik@pobox.com, jolt@tuxbox.org, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com
Subject: Re: [PATCH] b44 1GB DMA workaround (was: b44: add 47xx support)
Message-Id: <20040807170503.3b05255a.davem@redhat.com>
In-Reply-To: <20040807224019.GA24817@ee.oulu.fi>
References: <200407232335.37809.jolt@tuxbox.org>
	<20040726141128.GA5435@ee.oulu.fi>
	<20040804003108.GA10445@ee.oulu.fi>
	<20040803183919.2990d045.davem@redhat.com>
	<20040807224019.GA24817@ee.oulu.fi>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 8 Aug 2004 01:40:19 +0300
Pekka Pietikainen <pp@ee.oulu.fi> wrote:

> On Tue, Aug 03, 2004 at 06:39:19PM -0700, David S. Miller wrote:
> > Changing skb->data is not legal.  Please implement this in
> > such a way that skb->data does not get modified.  By modifying
> > skb->data you will break things such as packet sniffers and
> > netfilter, and that's just the tip of the iceberg. :-)
> > 
> Haven't noticed any breakage (tm) but I'm just a x86 weenie :-)

Not an x86 specific problem :-)  Just run tcpdump in a shell when
one of these TX bounce cases happen, your skb->data modification could
will make tcpdump see a corrupt packet.

> Current approach is:
> 
>         if(1 (just for testing ;) ) || mapping+len > B44_DMA_MASK) {
>                 /* Chip can't handle DMA to/from >1GB, use bounce buffer */
>                 pci_unmap_single(bp->pdev, mapping, len,PCI_DMA_TODEVICE);
>                 memcpy(bp->tx_bufs+entry*TX_PKT_BUF_SZ,skb->data,skb->len);
>                 mapping = pci_map_single(bp->pdev,bp->tx_bufs+entry*TX_PKT_BUF_SZ, len, PCI_DMA_TODEVICE);
>         }

This looks a bit better.
