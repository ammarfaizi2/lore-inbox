Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267402AbTGLDJu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 23:09:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267425AbTGLDJu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 23:09:50 -0400
Received: from rth.ninka.net ([216.101.162.244]:10635 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id S267402AbTGLDJs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 23:09:48 -0400
Date: Fri, 11 Jul 2003 20:24:26 -0700
From: "David S. Miller" <davem@redhat.com>
To: Pekka Pietikainen <pp@netppl.fi>
Cc: linux-kernel@vger.kernel.org, jgarzik@pobox.com
Subject: Re: REQ: BCM4400 network driver for 2.4.22
Message-Id: <20030711202426.5b0e475b.davem@redhat.com>
In-Reply-To: <20030711163345.GA23076@netppl.fi>
References: <200307092333.36917.bas@basmevissen.nl>
	<3F0C9194.5060206@pobox.com>
	<20030711163345.GA23076@netppl.fi>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Jul 2003 19:33:45 +0300
Pekka Pietikainen <pp@netppl.fi> wrote:

> @@ -660,9 +671,12 @@
>  	ctrl = src_desc->ctrl;
>  	if (dest_idx == (B44_RX_RING_SIZE - 1))
>  		ctrl |= cpu_to_le32(DESC_CTRL_EOT);
> +	else
> +		ctrl &= ~DESC_CTRL_EOT;

Please be kind to us underprivileged big-endian users
out here :-)

-		ctrl &= ~DESC_CTRL_EOT;
+		ctrl &= cpu_to_le32(~DESC_CTRL_EOT);

> @@ -733,6 +749,7 @@
>  			/* DMA sync done above */
>  			memcpy(copy_skb->data, skb->data, len);
>  
> +			skb->data-=bp->rx_offset;
>  			skb = copy_skb;
>  		}
>  		skb->ip_summed = CHECKSUM_NONE;

You can't modify skb->data without doing something sane
with skb->len and friends too, this is why we have skb_*()
interfaces to do these kinds of operations which do all
the necessary book-keeping :-)

Otherwise looks good.
