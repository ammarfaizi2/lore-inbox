Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965062AbWACX2B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965062AbWACX2B (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 18:28:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965050AbWACX17
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 18:27:59 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:61659 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S965012AbWACX1q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 18:27:46 -0500
To: torvalds@osdl.org
Subject: [PATCH 16/41] m68k: lvalues abuse in mac8390
Cc: linux-kernel@vger.kernel.org, linux-m68k@vger.kernel.org
Message-Id: <E1EtvZB-0003Mk-Iy@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Tue, 03 Jan 2006 23:27:45 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>
Date: 1133437188 -0500

cast is not an lvalue

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 drivers/net/mac8390.c |   31 ++++++++++++++-----------------
 1 files changed, 14 insertions(+), 17 deletions(-)

50be3a97d63c141504c44861e575848b88a72ab7
diff --git a/drivers/net/mac8390.c b/drivers/net/mac8390.c
index d8c99f0..06cb460 100644
--- a/drivers/net/mac8390.c
+++ b/drivers/net/mac8390.c
@@ -559,55 +559,52 @@ static void mac8390_no_reset(struct net_
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
 
-- 
0.99.9.GIT

