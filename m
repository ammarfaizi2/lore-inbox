Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265051AbUHCGFf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265051AbUHCGFf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 02:05:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265053AbUHCGFf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 02:05:35 -0400
Received: from fw.osdl.org ([65.172.181.6]:46314 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265051AbUHCGFc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 02:05:32 -0400
Date: Mon, 2 Aug 2004 23:03:07 -0700
From: Andrew Morton <akpm@osdl.org>
To: Dave Jones <davej@redhat.com>
Cc: linux.nics@intel.com, linux-kernel@vger.kernel.org
Subject: Re: ixgb boolean typo ?
Message-Id: <20040802230307.6a26dac0.akpm@osdl.org>
In-Reply-To: <20040803005536.GA12571@redhat.com>
References: <20040803005536.GA12571@redhat.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones <davej@redhat.com> wrote:
>
> Is this perhaps what was meant to be here ?
> 
>  		Dave
> 
>  --- 1/drivers/net/ixgb/ixgb_main.c~	2004-08-03 01:18:00.000000000 +0100
>  +++ 2/drivers/net/ixgb/ixgb_main.c	2004-08-03 01:53:46.653695768 +0100
>  @@ -1615,7 +1615,7 @@
>   	}
>   #else
>   	for (i = 0; i < IXGB_MAX_INTR; i++)
>  -		if (!ixgb_clean_rx_irq(adapter) & !ixgb_clean_tx_irq(adapter))
>  +		if (!ixgb_clean_rx_irq(adapter) && !ixgb_clean_tx_irq(adapter))
>   			break;
>   	/* if RAIDC:EN == 1 and ICR:RXDMT0 == 1, we need to
>   	 * set IMS:RXDMT0 to 1 to restart the RBD timer (POLL)

Both versions will do the same thing, inefficiently: keep going until both
functions return false.  And keep pointlessly calling a functions which is
returning FALSE all the time.

I think this would be better:

--- 25/drivers/net/ixgb/ixgb_main.c~igxb-speedup	2004-08-02 23:01:04.810311392 -0700
+++ 25-akpm/drivers/net/ixgb/ixgb_main.c	2004-08-02 23:02:18.475112640 -0700
@@ -1615,8 +1615,12 @@ static irqreturn_t ixgb_intr(int irq, vo
 	}
 #else
 	for (i = 0; i < IXGB_MAX_INTR; i++)
-		if (!ixgb_clean_rx_irq(adapter) & !ixgb_clean_tx_irq(adapter))
+		if (ixgb_clean_rx_irq(adapter) == FALSE)
 			break;
+	for (i = 0; i < IXGB_MAX_INTR; i++)
+		if (ixgb_clean_tx_irq(adapter) == FALSE)
+			break;
+
 	/* if RAIDC:EN == 1 and ICR:RXDMT0 == 1, we need to
 	 * set IMS:RXDMT0 to 1 to restart the RBD timer (POLL)
 	 */
_

