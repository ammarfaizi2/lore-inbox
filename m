Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315451AbSFYG6r>; Tue, 25 Jun 2002 02:58:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315455AbSFYG6q>; Tue, 25 Jun 2002 02:58:46 -0400
Received: from ns2.radioschefer.ch ([62.2.224.35]:2317 "EHLO
	ns2.radioschefer.ch") by vger.kernel.org with ESMTP
	id <S315451AbSFYG6q>; Tue, 25 Jun 2002 02:58:46 -0400
Message-ID: <3D18137E.B0CCC572@optronic.ch>
Date: Tue, 25 Jun 2002 08:53:50 +0200
From: Stephan Brauss <sbrauss@optronic.ch>
Organization: OPTRONIC AG
X-Mailer: Mozilla 4.75 [de] (Win95; U)
X-Accept-Language: de
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [realtek] System hang with heavy network traffic using rtl8139c
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, 

maybe I had a similar problem. In my case, the rtl8139 chip reports
a negative buffer size and a following dev_alloc_skb() crashed my system.
The problem was caused by receive buffer overruns that occur if the CPU is not fast
enough to fetch all data. Please check if you see rtl8139-realted kernel messages 
during the test.
I reported this problem to the realtek list some time ago, but, as far as I know,
it is not included in the test version 1.18 until know.

Here is my patch of rtl8129_rx():

                } else {
                        /* Malloc up new buffer, compatible with net-2e. */
                        /* Omit the four octet CRC from the length. */
                        struct sk_buff *skb;
                        int pkt_size = rx_size - 4;

+                       if(pkt_size<0)
+                       {
+                               if (tp->msg_level & NETIF_MSG_DRV)
+                                       printk(KERN_ERR"%s: Impossible packet length.\n",dev->name);
+                               tp->stats.rx_dropped++;
+                               rtl_hw_start(dev);
+                               break;
+                       }
+
                        skb = dev_alloc_skb(pkt_size + 2);
                        if (skb == NULL) {

Additionally, I think it is a good idea to increase the receive buffer size to the maximum by setting
RX_BUF_LEN_IDX from 2 to 3.
If you read older messages of the realtek list, you can find additional driver changes that are maybe
helpfull for you.

Stephan
