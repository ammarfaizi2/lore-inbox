Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293408AbSCAROv>; Fri, 1 Mar 2002 12:14:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293410AbSCAROl>; Fri, 1 Mar 2002 12:14:41 -0500
Received: from ip68-3-107-226.ph.ph.cox.net ([68.3.107.226]:63425 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S293408AbSCARO0>;
	Fri, 1 Mar 2002 12:14:26 -0500
Message-ID: <3C7FB6F1.1040801@candelatech.com>
Date: Fri, 01 Mar 2002 10:14:25 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20011019 Netscape6/6.2
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: jgarzik@mandrakesoft.com
Subject: Re: Various 802.1Q VLAN driver patches. [try3]
In-Reply-To: <20020301.072831.120445660.davem@redhat.com> <3C7FA81A.3070602@candelatech.com> <20020301.081110.76328637.davem@redhat.com> <3C7FAC00.4010402@candelatech.com> <20020301183059.V23151@mea-ext.zmailer.org>
Content-Type: multipart/mixed;
 boundary="------------090204080802000308080807"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090204080802000308080807
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Ok, tulip patch attached as hopefully a plain-text attachment.
The 3com link has already been sent, and the eepro100 patch
was short enough not to wrap.

Thanks for your patience.

Matti Aarnio wrote:

>   No, it does not.
> 
> On Fri, Mar 01, 2002 at 09:27:44AM -0700, Ben Greear wrote:
> 
>>User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20011019 Netscape6/6.2
>>
> 
>   You MIGHT be able to send the patches as ATTACHMENTS.
> I think Uncle DaveM will accept them, while Linus dislikes them immensely.
> 
> /Matti Aarnio
> 
> 


-- 
Ben Greear <greearb@candelatech.com>       <Ben_Greear AT excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear


--------------090204080802000308080807
Content-Type: text/plain;
 name="tulip_vlan.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="tulip_vlan.patch"

diff -u --recursive --new-file linux/drivers/net/tulip/interrupt.c linux.dev/drivers/net/tulip/interrupt.c
--- linux/drivers/net/tulip/interrupt.c	Fri Nov  9 22:45:35 2001
+++ linux.dev/drivers/net/tulip/interrupt.c	Tue Dec 11 09:24:36 2001
@@ -128,8 +128,8 @@
 				   dev->name, entry, status);
 		if (--rx_work_limit < 0)
 			break;
-		if ((status & 0x38008300) != 0x0300) {
-			if ((status & 0x38000300) != 0x0300) {
+		if ((status & (0x38000000 | RxDescFatalErr | RxWholePkt)) != RxWholePkt) {
+			if ((status & (0x38000000 | RxWholePkt)) != RxWholePkt) {
 				/* Ingore earlier buffers. */
 				if ((status & 0xffff) != 0x7fff) {
 					if (tulip_debug > 1)
@@ -155,10 +155,10 @@
 			struct sk_buff *skb;
 
 #ifndef final_version
-			if (pkt_len > 1518) {
+			if (pkt_len > 1522) {
 				printk(KERN_WARNING "%s: Bogus packet size of %d (%#x).\n",
 					   dev->name, pkt_len, pkt_len);
-				pkt_len = 1518;
+				pkt_len = 1522;
 				tp->stats.rx_length_errors++;
 			}
 #endif
diff -u --recursive --new-file linux/drivers/net/tulip/tulip.h linux.dev/drivers/net/tulip/tulip.h
--- linux/drivers/net/tulip/tulip.h	Fri Nov  9 22:45:35 2001
+++ linux.dev/drivers/net/tulip/tulip.h	Tue Dec 11 09:24:36 2001
@@ -186,7 +186,7 @@
 
 enum desc_status_bits {
 	DescOwned = 0x80000000,
-	RxDescFatalErr = 0x8000,
+	RxDescFatalErr = 0x4842,
 	RxWholePkt = 0x0300,
 };
 
diff -u --recursive --new-file linux/drivers/net/tulip/tulip_core.c linux.dev/drivers/net/tulip/tulip_core.c
--- linux/drivers/net/tulip/tulip_core.c	Tue Nov 20 00:19:42 2001
+++ linux.dev/drivers/net/tulip/tulip_core.c	Tue Dec 11 09:24:36 2001
@@ -63,7 +63,7 @@
 #if defined(__alpha__) || defined(__arm__) || defined(__hppa__) \
 	|| defined(__sparc_) || defined(__ia64__) \
 	|| defined(__sh__) || defined(__mips__)
-static int rx_copybreak = 1518;
+static int rx_copybreak = 1522;
 #else
 static int rx_copybreak = 100;
 #endif


--------------090204080802000308080807--

