Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964896AbWDDAAq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964896AbWDDAAq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 20:00:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964905AbWDCX74
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 19:59:56 -0400
Received: from wp060.webpack.hosteurope.de ([80.237.132.67]:30135 "EHLO
	wp060.webpack.hosteurope.de") by vger.kernel.org with ESMTP
	id S964897AbWDCX7k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 19:59:40 -0400
Date: Tue, 4 Apr 2006 02:00:24 +0200
From: Hansjoerg Lipp <hjlipp@web.de>
To: Karsten Keil <kkeil@suse.de>
Cc: i4ldeveloper@listserv.isdn4linux.de, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>,
       Tilman Schmidt <tilman@imap.cc>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH 10/13] isdn4linux: Siemens Gigaset drivers - remove private version of __skb_put()
Message-ID: <gigaset307x.2006.04.04.001.10@hjlipp.my-fqdn.de>
References: <gigaset307x.2006.04.04.001.0@hjlipp.my-fqdn.de> <gigaset307x.2006.04.04.001.1@hjlipp.my-fqdn.de> <gigaset307x.2006.04.04.001.2@hjlipp.my-fqdn.de> <gigaset307x.2006.04.04.001.3@hjlipp.my-fqdn.de> <gigaset307x.2006.04.04.001.4@hjlipp.my-fqdn.de> <gigaset307x.2006.04.04.001.5@hjlipp.my-fqdn.de> <gigaset307x.2006.04.04.001.6@hjlipp.my-fqdn.de> <gigaset307x.2006.04.04.001.7@hjlipp.my-fqdn.de> <gigaset307x.2006.04.04.001.8@hjlipp.my-fqdn.de> <gigaset307x.2006.04.04.001.9@hjlipp.my-fqdn.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <gigaset307x.2006.04.04.001.9@hjlipp.my-fqdn.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tilman Schmidt <tilman@imap.cc>, Hansjoerg Lipp <hjlipp@web.de>

This patch removes the private version of __skb_put() from the Siemens
Gigaset drivers. Please merge.

Signed-off-by: Hansjoerg Lipp <hjlipp@web.de>
Signed-off-by: Tilman Schmidt <tilman@imap.cc>
---

 drivers/isdn/gigaset/asyncdata.c |    5 ++---
 drivers/isdn/gigaset/gigaset.h   |   17 -----------------
 drivers/isdn/gigaset/isocdata.c  |    2 +-
 3 files changed, 3 insertions(+), 21 deletions(-)

--- linux-2.6.16-gig-mutex/drivers/isdn/gigaset/gigaset.h	2006-04-02 18:43:41.000000000 +0200
+++ linux-2.6.16-gig-skb/drivers/isdn/gigaset/gigaset.h	2006-04-02 18:44:06.000000000 +0200
@@ -852,23 +852,6 @@ static inline void gigaset_bchannel_up(s
 /* handling routines for sk_buff */
 /* ============================= */
 
-/* private version of __skb_put()
- * append 'len' bytes to the content of 'skb', already knowing that the
- * existing buffer can accomodate them
- * returns a pointer to the location where the new bytes should be copied to
- * This function does not take any locks so it must be called with the
- * appropriate locks held only.
- */
-static inline unsigned char *gigaset_skb_put_quick(struct sk_buff *skb,
-						   unsigned int len)
-{
-	unsigned char *tmp = skb->tail;
-	/*SKB_LINEAR_ASSERT(skb);*/		/* not needed here */
-	skb->tail += len;
-	skb->len += len;
-	return tmp;
-}
-
 /* pass received skb to LL
  * Warning: skb must not be accessed anymore!
  */
--- linux-2.6.16-gig-mutex/drivers/isdn/gigaset/isocdata.c	2006-04-02 18:43:01.000000000 +0200
+++ linux-2.6.16-gig-skb/drivers/isdn/gigaset/isocdata.c	2006-04-02 18:44:06.000000000 +0200
@@ -532,7 +532,7 @@ static inline void hdlc_putbyte(unsigned
 		bcs->skb = NULL;
 		return;
 	}
-	*gigaset_skb_put_quick(bcs->skb, 1) = c;
+	*__skb_put(bcs->skb, 1) = c;
 }
 
 /* hdlc_flush
--- linux-2.6.16-gig-mutex/drivers/isdn/gigaset/asyncdata.c	2006-04-02 18:43:01.000000000 +0200
+++ linux-2.6.16-gig-skb/drivers/isdn/gigaset/asyncdata.c	2006-04-02 18:44:06.000000000 +0200
@@ -252,8 +252,7 @@ byte_stuff:
 				inputstate |= INS_skip_frame;
 				break;
 			}
-			*gigaset_skb_put_quick(skb, 1) = c;
-			/* *__skb_put (skb, 1) = c; */
+			*__skb_put(skb, 1) = c;
 			fcs = crc_ccitt_byte(fcs, c);
 		}
 
@@ -303,7 +302,7 @@ static inline int iraw_loop(unsigned cha
 				inputstate |= INS_skip_frame;
 				break;
 			}
-			*gigaset_skb_put_quick(skb, 1) = gigaset_invtab[c];
+			*__skb_put(skb, 1) = gigaset_invtab[c];
 		}
 
 		if (unlikely(!numbytes))
