Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264074AbTH1QRS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 12:17:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264097AbTH1QRR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 12:17:17 -0400
Received: from portraits.wsisiz.edu.pl ([213.135.44.34]:25625 "EHLO
	portraits.wsisiz.edu.pl") by vger.kernel.org with ESMTP
	id S264074AbTH1QRN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 12:17:13 -0400
Date: Thu, 28 Aug 2003 18:13:45 +0200
Message-Id: <200308281613.h7SGDjuT002596@lt.wsisiz.edu.pl>
From: Lukasz Trabinski <lukasz@lt.wsisiz.edu.pl>
To: krzysiek@mediaone.pl (Krzysztof Sierota)
CC: linux-kernel@vger.kernel.org, marcelo@conectiva.com.br
Subject: Re: 2.4.22 oops in ATM 2.4.21 works fine
In-Reply-To: <200308281559.01395.krzysiek@mediaone.pl>
X-Newsgroups: wsisiz.linux-kernel
X-PGP-Key-Fingerprint: 87 9F 39 9C F9 EE EA 7F  8F C9 58 6A D4 54 0E B9
X-Key-ID: 6DB9C699
User-Agent: tin/1.6.1-20030810 ("Mingulay") (UNIX) (Linux/2.4.22 (i686))
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <200308281559.01395.krzysiek@mediaone.pl> you wrote:
> [-- text/plain, encoding quoted-printable, charset: us-ascii, 17 lines --]
> 
> Hi,
> 
> the 2.4.22 kernel is oopsing at start scripts, machine stays alive, but ATM 
> does not work. 2.4.21 works just fine.

Exactly, Here is patch from Chas Williams.

Date: Tue, 26 Aug 2003 13:46:34 -0400
From: chas williams <chas@cmf.nrl.navy.mil>

In message <Pine.LNX.4.53.0308260104580.17995@oceanic.wsisiz.edu.pl>,Lukasz Tra
binski writes:
>I have always used vanilla kernel with very old patch for ATM
>(name: linux-2.3.99-pre6-fore200e-0.2f.patch) It worked well -
>trouble-free. 
>I have just tried vanilla 2.4.22, here is oops. ATM doesn't work :(

yep, i screwed that up.  when clip isnt a module, the common code try
to manipulate the module count while fails.  see if this patch makes
it better -- apply with patch -p1 in your linux source tree.

--- linux-2.4.22/net/atm/common.c.000	Tue Aug 26 10:40:30 2003
+++ linux-2.4.22/net/atm/common.c	Tue Aug 26 13:12:35 2003
@@ -672,7 +672,8 @@
 			}
 			if (try_atm_clip_ops()) {
 				ret_val = atm_clip_ops->clip_create(arg);
-				__MOD_DEC_USE_COUNT(atm_clip_ops->owner);
+				if (atm_clip_ops->owner)
+					__MOD_DEC_USE_COUNT(atm_clip_ops->owner);
 			} else
 				ret_val = -ENOSYS;
 			goto done;
@@ -687,7 +688,8 @@
 #endif
 			if (try_atm_clip_ops()) {
 				error = atm_clip_ops->atm_init_atmarp(vcc);
-				__MOD_DEC_USE_COUNT(atm_clip_ops->owner);
+				if (atm_clip_ops->owner)
+					__MOD_DEC_USE_COUNT(atm_clip_ops->owner);
 				if (!error)
 					sock->state = SS_CONNECTED;
 				ret_val = error;
@@ -701,7 +703,8 @@
 			}
 			if (try_atm_clip_ops()) {
 				ret_val = atm_clip_ops->clip_mkip(vcc, arg);
-				__MOD_DEC_USE_COUNT(atm_clip_ops->owner);
+				if (atm_clip_ops->owner)
+					__MOD_DEC_USE_COUNT(atm_clip_ops->owner);
 			} else
 				ret_val = -ENOSYS;
 			goto done;
@@ -712,7 +715,8 @@
 			}
 			if (try_atm_clip_ops()) {
 				ret_val = atm_clip_ops->clip_setentry(vcc, arg);
-				__MOD_DEC_USE_COUNT(atm_clip_ops->owner);
+				if (atm_clip_ops->owner)
+					__MOD_DEC_USE_COUNT(atm_clip_ops->owner);
 			} else
 				ret_val = -ENOSYS;
 			goto done;
@@ -723,7 +727,8 @@
 			}
 			if (try_atm_clip_ops()) {
 				ret_val = atm_clip_ops->clip_encap(vcc, arg);
-				__MOD_DEC_USE_COUNT(atm_clip_ops->owner);
+				if (atm_clip_ops->owner)
+					__MOD_DEC_USE_COUNT(atm_clip_ops->owner);
 			} else
 				ret_val = -ENOSYS;
 			goto done;
--- linux-2.4.22/net/atm/proc.c.000	Tue Aug 26 13:30:23 2003
+++ linux-2.4.22/net/atm/proc.c	Tue Aug 26 13:31:58 2003
@@ -358,7 +358,7 @@
 				spin_unlock_irqrestore(&dev->lock, flags);
 				spin_unlock(&atm_dev_lock);
 #if defined(CONFIG_ATM_CLIP) || defined(CONFIG_ATM_CLIP_MODULE)
-				if (clip_info)
+				if (clip_info && atm_clip_ops->owner)
 					__MOD_DEC_USE_COUNT(atm_clip_ops->owner);
 #endif
 				return strlen(buf);
@@ -367,8 +367,8 @@
 	}
 	spin_unlock(&atm_dev_lock);
 #if defined(CONFIG_ATM_CLIP) || defined(CONFIG_ATM_CLIP_MODULE)
-	if (clip_info)
-		__MOD_DEC_USE_COUNT(atm_clip_ops->owner);
+	if (clip_info && atm_clip_ops->owner)
+			__MOD_DEC_USE_COUNT(atm_clip_ops->owner);
 #endif
 	return 0;
 }
@@ -458,7 +458,8 @@
 				if (--count) continue;
 				atmarp_info(n->dev,entry,NULL,buf);
 				read_unlock_bh(&clip_tbl_hook->lock);
-				__MOD_DEC_USE_COUNT(atm_clip_ops->owner);
+				if (atm_clip_ops->owner)
+					__MOD_DEC_USE_COUNT(atm_clip_ops->owner);
 				return strlen(buf);
 			}
 			for (vcc = entry->vccs; vcc;
@@ -466,12 +467,14 @@
 				if (--count) continue;
 				atmarp_info(n->dev,entry,vcc,buf);
 				read_unlock_bh(&clip_tbl_hook->lock);
-				__MOD_DEC_USE_COUNT(atm_clip_ops->owner);
+				if (atm_clip_ops->owner)
+					__MOD_DEC_USE_COUNT(atm_clip_ops->owner);
 				return strlen(buf);
 			}
 		}
 	read_unlock_bh(&clip_tbl_hook->lock);
-	__MOD_DEC_USE_COUNT(atm_clip_ops->owner);
+	if (atm_clip_ops->owner)
+		__MOD_DEC_USE_COUNT(atm_clip_ops->owner);
 	return 0;
 }
 #endif




-- 
*[ £ukasz Tr±biñski ]*
