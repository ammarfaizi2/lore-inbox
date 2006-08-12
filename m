Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030262AbWHLSc2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030262AbWHLSc2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Aug 2006 14:32:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030253AbWHLSc2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Aug 2006 14:32:28 -0400
Received: from helium.samage.net ([83.149.67.129]:32663 "EHLO
	helium.samage.net") by vger.kernel.org with ESMTP id S1030240AbWHLSc1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Aug 2006 14:32:27 -0400
Message-ID: <57504.81.207.0.53.1155407532.squirrel@81.207.0.53>
In-Reply-To: <1155406120.13508.87.camel@lappy>
References: <20060812141415.30842.78695.sendpatchset@lappy> 
    <20060812141445.30842.47336.sendpatchset@lappy> 
    <44640.81.207.0.53.1155403862.squirrel@81.207.0.53> 
    <1155404697.13508.81.camel@lappy> 
    <40048.81.207.0.53.1155405282.squirrel@81.207.0.53>
    <1155406120.13508.87.camel@lappy>
Date: Sat, 12 Aug 2006 20:32:12 +0200 (CEST)
Subject: Re: [RFC][PATCH 3/4] deadlock prevention core
From: "Indan Zupancic" <indan@nul.nu>
To: "Peter Zijlstra" <a.p.zijlstra@chello.nl>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       "Evgeniy Polyakov" <johnpol@2ka.mipt.ru>,
       "Daniel Phillips" <phillips@google.com>,
       "Rik van Riel" <riel@redhat.com>, "David Miller" <davem@davemloft.net>
User-Agent: SquirrelMail/1.4.3a
X-Mailer: SquirrelMail/1.4.3a
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, August 12, 2006 20:08, Peter Zijlstra said:
> On Sat, 2006-08-12 at 19:54 +0200, Indan Zupancic wrote:
>> True, but currently memalloc_reserve isn't used in a sensible way,
>> or I'm missing something.
>
> Well, I'm somewhat reluctant to stick network related code into mm/, it
> seems well separated now.

What I had in mind was something like:

+static DEFINE_SPINLOCK(memalloc_lock);
+static int memalloc_socks;
+
+atomic_t memalloc_skbs_used;
+EXPORT_SYMBOL_GPL(memalloc_skbs_used);
+
+int sk_adjust_memalloc(int nr_socks)
+{
+	unsigned long flags;
+	unsigned int reserve;
+	int err;
+
+	spin_lock_irqsave(&memalloc_lock, flags);
+
+	memalloc_socks += nr_socks;
+	BUG_ON(memalloc_socks < 0);
+
+	reserve = nr_socks * (2 * MAX_PHYS_SEGMENTS + 	/* outbound */
+			      5 * MAX_CONCURRENT_SKBS);	/* inbound */
+
+	err = adjust_memalloc_reserve(reserve);
+	spin_unlock_irqrestore(&memalloc_lock, flags);
+	if (err) {
+		printk(KERN_WARNING
+			"Unable to change RX reserve to: %lu, error: %d\n",
+			reserve, err);
+	}
+	return err;
+}

The original code missed the brackets, so 5 * MAX_CONCURRENT_SKBS wasn't done
per socket. But the comment said it was per socket, so I added in this version.

Greetings,

Indan


