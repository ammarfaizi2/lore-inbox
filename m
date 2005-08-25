Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964815AbVHYF0t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964815AbVHYF0t (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 01:26:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964810AbVHYFVR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 01:21:17 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:59851 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S964807AbVHYFVL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 01:21:11 -0400
To: geert@linux-m68k.org, torvalds@osdl.org
Subject: [PATCH] (7/22) lvalues abuse in mac8390
Cc: linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org
Message-Id: <E1E8ADo-0005bZ-7b@parcelfarce.linux.theplanet.co.uk>
From: Al Viro <viro@www.linux.org.uk>
Date: Thu, 25 Aug 2005 06:24:16 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

cast is not an lvalue

Signed-off-by: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
----
diff -urN RC13-rc7-atyfb-typo/drivers/net/mac8390.c RC13-rc7-mac8390/drivers/net/mac8390.c
--- RC13-rc7-atyfb-typo/drivers/net/mac8390.c	2005-06-17 15:48:29.000000000 -0400
+++ RC13-rc7-mac8390/drivers/net/mac8390.c	2005-08-25 00:54:09.000000000 -0400
@@ -560,55 +560,52 @@
 /* directly from daynaport.c by Alan Cox */
 static void dayna_memcpy_fromcard(struct net_device *dev, void *to, int from, int count)
 {
-	volatile unsigned short *ptr;
-	unsigned short *target=to;
+	volatile unsigned char *ptr;
+	unsigned char *target=to;
 	from<<=1;	/* word, skip overhead */
-	ptr=(unsigned short *)(dev->mem_start+from);
+	ptr=(unsigned char *)(dev->mem_start+from);
 	/* Leading byte? */
 	if (from&2) {
-		*((char *)target)++ = *(((char *)ptr++)-1);
+		*target++ = ptr[-1];
+		ptr += 2;
 		count--;
 	}
 	while(count>=2)
 	{
-		*target++=*ptr++;	/* Copy and */
-		ptr++;			/* skip cruft */
+		*(unsigned short *)target = *(unsigned short volatile *)ptr;
+		ptr += 4;			/* skip cruft */
+		target += 2;
 		count-=2;
 	}
 	/* Trailing byte? */
 	if(count)
-	{
-		/* Big endian */
-		unsigned short v=*ptr;
-		*((char *)target)=v>>8;
-	}
+		*target = *ptr;
 }
 
 static void dayna_memcpy_tocard(struct net_device *dev, int to, const void *from, int count)
 {
 	volatile unsigned short *ptr;
-	const unsigned short *src=from;
+	const unsigned char *src=from;
 	to<<=1;	/* word, skip overhead */
 	ptr=(unsigned short *)(dev->mem_start+to);
 	/* Leading byte? */
 	if (to&2) { /* avoid a byte write (stomps on other data) */
-		ptr[-1] = (ptr[-1]&0xFF00)|*((unsigned char *)src)++;
+		ptr[-1] = (ptr[-1]&0xFF00)|*src++;
 		ptr++;
 		count--;
 	}
 	while(count>=2)
 	{
-		*ptr++=*src++;		/* Copy and */
+		*ptr++=*(unsigned short *)src;		/* Copy and */
 		ptr++;			/* skip cruft */
+		src += 2;
 		count-=2;
 	}
 	/* Trailing byte? */
 	if(count)
 	{
-		/* Big endian */
-		unsigned short v=*src;
 		/* card doesn't like byte writes */
-		*ptr=(*ptr&0x00FF)|(v&0xFF00);
+		*ptr=(*ptr&0x00FF)|(*src << 8);
 	}
 }
 
