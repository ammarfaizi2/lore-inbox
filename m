Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129780AbRCASub>; Thu, 1 Mar 2001 13:50:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129781AbRCASuT>; Thu, 1 Mar 2001 13:50:19 -0500
Received: from smtp102.urscorp.com ([38.202.96.105]:64263 "EHLO
	smtp102.urscorp.com") by vger.kernel.org with ESMTP
	id <S129780AbRCASuE>; Thu, 1 Mar 2001 13:50:04 -0500
To: alan@lxorguk.ukuu.org.uk, linux-tr@linuxtr.net,
        linux-kernel@vger.kernel.org, sullivam@us.ibm.com
Subject: [PATCH] Memory Leak fix for ibmtr
X-Mailer: Lotus Notes Release 5.0.5  September 22, 2000
From: mike_phillips@urscorp.com
Message-ID: <OF24EE3DF5.7589961C-ON85256A02.005DD6DE@urscorp.com>
Date: Thu, 1 Mar 2001 13:11:47 -0500
X-MIMETrack: Serialize by Router on SMTP102/URSCorp(Release 5.0.5 |September 22, 2000) at
 03/01/2001 01:47:25 PM,
	Serialize complete at 03/01/2001 01:47:25 PM
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is a small patch that fixes a memory leak in the ibmtr driver. 

Basically the bug occurs because the skb->tail pointer is set past the end 
of the skb data buffer. This causes problems when the skb's are cloned 
(they are unabled to be freed properly). The result is a leak that 
eventually will stop the system. 

Mike Phillips
Linux Token Ring Project
http://www.linuxtr.net 

--- linux.orig/drivers/net/tokenring/ibmtr.c    Wed Feb 14 16:49:55 2001
+++ linux/drivers/net/tokenring/ibmtr.c Wed Feb 14 16:50:01 2001
@@ -1716,7 +1716,8 @@
                }
 #endif
 
-               skb_size = length;
+       skb_size=(sizeof(struct trh_hdr)-lan_hdr_len+sizeof(struct 
trllc)+15) & ~15;
+               skb_size+=length;
 
                if (!(skb=dev_alloc_skb(skb_size))) {
                        DPRINTK("out of memory. frame dropped.\n");
@@ -1727,8 +1728,8 @@
                        return;
                }
 
-       skb_put(skb, length);
-       skb_reserve(skb, sizeof(struct trh_hdr)-lan_hdr_len+sizeof(struct 
trllc));
+       skb_reserve(skb, (sizeof(struct trh_hdr)-lan_hdr_len+sizeof(struct 
trllc)+15) & ~15);
+       skb_put(skb,length);
                skb->dev=dev;
                data=skb->data;
        rbuffer_len=ntohs(isa_readw(rbuffer + offsetof(struct rec_buf, 
buf_len)));
