Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281450AbRL3RZl>; Sun, 30 Dec 2001 12:25:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281214AbRL3RZb>; Sun, 30 Dec 2001 12:25:31 -0500
Received: from net088s.hetnet.nl ([194.151.104.184]:33808 "EHLO hetnet.nl")
	by vger.kernel.org with ESMTP id <S280588AbRL3RZZ>;
	Sun, 30 Dec 2001 12:25:25 -0500
Message-Id: <5.1.0.14.2.20011230174733.00a2fc50@pop.hetnet.nl>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Sun, 30 Dec 2001 18:23:50 +0100
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
From: Henk de Groot <henk.de.groot@hetnet.nl>
Subject: Re: AX25/socket kernel PATCHes
Cc: linux-hams@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <E16KVhV-0006bg-00@the-village.bc.nu>
In-Reply-To: <5.1.0.14.2.20011230004059.00a2ac90@pop.hetnet.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Allan,

At 02:27 30-12-01 +0000, Alan Cox wrote:
>> >                        if (skb2->nh.raw < skb2->data || skb2->nh.raw >= skb2->...
>
>> +                       if (skb2->nh.raw < skb2->data || nh.raw > skb2->tail) {
>Add:                                                       skb2->
>
>my fault

To clear this once and for all I applied a brute-force patch:

----------------------------------------------------------------------
--- linux/net/core/dev.c.orig   Sun Dec 30 16:57:55 2001
+++ linux/net/core/dev.c        Sun Dec 30 17:07:25 2001
@@ -940,9 +940,14 @@
                         */
                        skb2->mac.raw = skb2->data;
 
-                       if (skb2->nh.raw < skb2->data || skb2->nh.raw > skb2->tail) {
+                       if (skb2->nh.raw < skb2->data || skb2->nh.raw >= skb2->tail) {
                                if (net_ratelimit())
+                                {
                                        printk(KERN_DEBUG "protocol %04x is buggy, dev %s\n", skb2->protocol, dev->name);
+                                       printk(KERN_DEBUG "PE1DNN: skb2->nh.raw = 0x%08x\n", (unsigned long) skb2->nh.raw);
+                                       printk(KERN_DEBUG "PE1DNN: skb2->data = 0x%08x\n", (unsigned long) skb2->data);
+                                       printk(KERN_DEBUG "PE1DNN: skb2->tail = 0x%08x\n", (unsigned long) skb2->tail);
+                                }
                                skb2->nh.raw = skb2->data;
                        }
----------------------------------------------------------------------

That should provide enough data about this part.. This is the output it creates, its not an off-by-one error...

----------------------------------------------------------------------
Dec 30 17:45:54 pe1dnn kernel: protocol 0000 is buggy, dev bcsf0
Dec 30 17:45:54 pe1dnn kernel: PE1DNN: skb2->nh.raw = 0xc4b0ed40
Dec 30 17:45:54 pe1dnn kernel: PE1DNN: skb2->data = 0xc4b0ece7
Dec 30 17:45:54 pe1dnn kernel: PE1DNN: skb2->tail = 0xc4b0ed11
----------------------------------------------------------------------

nh.raw is pointing way beyond the end of the data; 48 bytes if tail points at the adress just after the data - magic number or any clue why 48 bytes?

According to this the data should be 42 bytes (where data points to the first byte and tail just after the last byte). What is written to the AX.25 socket with 'sendto' is:

1 - KISS discriminator (0 - data) -> 1 byte
1 - AX.25 source address -> 7 bytes
1 - AX.25 destination address -> 7 bytes
2 - Digi paths @ 7bytes -> 14 bytes
1 - control fiels (primitve, UI frame) -> 1 byte
1 - PID (0xF0 normal AX.25 text) -> 1 byte
1 - payload data -> 11 bytes

Total 42 bytes, that seems to add up, only the nh.raw pointer seems to point to nowhere.

Kind regards,

Henk.

