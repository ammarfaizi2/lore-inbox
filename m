Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279277AbRKMVeF>; Tue, 13 Nov 2001 16:34:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279317AbRKMVdz>; Tue, 13 Nov 2001 16:33:55 -0500
Received: from [217.6.75.131] ([217.6.75.131]:7384 "EHLO
	mail.internetwork-ag.de") by vger.kernel.org with ESMTP
	id <S279277AbRKMVdp>; Tue, 13 Nov 2001 16:33:45 -0500
Message-ID: <3BF193F8.FE8C579@internetwork-ag.de>
Date: Tue, 13 Nov 2001 22:43:20 +0100
From: Till Immanuel Patzschke <tip@internetwork-ag.de>
Organization: interNetwork AG
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.16 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: pwang@iphase.com, acme@conectiva.com.br
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [BUG/PATCH] iphase ATM driver (Oops - Div0)
Content-Type: multipart/mixed;
 boundary="------------09C3F26FAC0AC8F12CB14B62"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------09C3F26FAC0AC8F12CB14B62
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi,

please find attached a fix for a nasty bug in the iphase ATM NIC. If te max_sdu
exceeds the limit the internal structure ia_vcc is freed BUT the pointer in the
vcc struct is NOT been reset.  This results in a Div0 error in ia_close
(ctimeout = 300000 / ia_vcc->pcr) - clearing the referencing pointer fixes the
problem.
I've also diabled the "Misaligned SKB" check since it works fine w/o it
AND re-aligning is to expensive if it works (I know, jumping to conclusions, but
it works fine on my boxes)...
Could you please - at least - apply the pointer fix?

Thanks,

Immanuel

--
Till Immanuel Patzschke                 mailto: tip@internetwork-ag.de
interNetwork AG                         Phone:  +49-(0)611-1731-121
Bierstadter Str. 7                      Fax:    +49-(0)611-1731-31
D-65189 Wiesbaden                       Web:    http://www.internetwork-ag.de



--------------09C3F26FAC0AC8F12CB14B62
Content-Type: text/plain; charset=us-ascii;
 name="qq2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="qq2"

diff -Naur linux-2.4.10/drivers/atm/iphase.c linux-2.4.10-new/drivers/atm/iphase.c
--- linux-2.4.10/drivers/atm/iphase.c	Tue Sep 18 07:52:34 2001
+++ linux-2.4.10-new/drivers/atm/iphase.c	Tue Nov 13 18:40:49 2001
@@ -1777,8 +1777,9 @@
         memset((caddr_t)ia_vcc, 0, sizeof(*ia_vcc));
         if (vcc->qos.txtp.max_sdu > 
                          (iadev->tx_buf_sz - sizeof(struct cpcs_trailer))){
-           printk("IA:  SDU size over the configured SDU size %d\n",
-                                                          iadev->tx_buf_sz);
+           printk("IA:  SDU size over (%d) the configured SDU size %d\n",
+		  vcc->qos.txtp.max_sdu,iadev->tx_buf_sz);
+	   INPH_IA_VCC(vcc) = NULL;  
            kfree(ia_vcc);
            return -EINVAL; 
         }
@@ -2896,14 +2897,16 @@
                  dev_kfree_skb_any(skb);
           return 0;
         }
+#if 0
         if ((u32)skb->data & 3) {
-           printk("Misaligned SKB\n");
+           printk("Misaligned SKB (0x%p)\n",skb->data);
            if (vcc->pop)
                  vcc->pop(vcc, skb);
            else
                  dev_kfree_skb_any(skb);
            return 0;
         }       
+#endif
 	/* Get a descriptor number from our free descriptor queue  
 	   We get the descr number from the TCQ now, since I am using  
 	   the TCQ as a free buffer queue. Initially TCQ will be   

--------------09C3F26FAC0AC8F12CB14B62--

