Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161131AbWJKQpu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161131AbWJKQpu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 12:45:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161129AbWJKQpu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 12:45:50 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:24807 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1161131AbWJKQpt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 12:45:49 -0400
Date: Wed, 11 Oct 2006 17:45:47 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] i2Output always takes kernel data now
Message-ID: <20061011164547.GD29920@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 drivers/char/ip2/i2lib.c   |   11 +++--------
 drivers/char/ip2/i2lib.h   |    2 +-
 drivers/char/ip2/ip2main.c |    4 ++--
 3 files changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/char/ip2/i2lib.c b/drivers/char/ip2/i2lib.c
index fc944d3..54d93f0 100644
--- a/drivers/char/ip2/i2lib.c
+++ b/drivers/char/ip2/i2lib.c
@@ -1007,7 +1007,7 @@ #endif 
 // applications that one cannot break out of.
 //******************************************************************************
 static int
-i2Output(i2ChanStrPtr pCh, const char *pSource, int count, int user )
+i2Output(i2ChanStrPtr pCh, const char *pSource, int count)
 {
 	i2eBordStrPtr pB;
 	unsigned char *pInsert;
@@ -1020,7 +1020,7 @@ i2Output(i2ChanStrPtr pCh, const char *p
 
 	int bailout = 10;
 
-	ip2trace (CHANN, ITRC_OUTPUT, ITRC_ENTER, 2, count, user );
+	ip2trace (CHANN, ITRC_OUTPUT, ITRC_ENTER, 2, count, 0 );
 
 	// Ensure channel structure seems real
 	if ( !i2Validate ( pCh ) ) 
@@ -1087,12 +1087,7 @@ i2Output(i2ChanStrPtr pCh, const char *p
 			DATA_COUNT_OF(pInsert)  = amountToMove;
 
 			// Move the data
-			if ( user ) {
-				rc = copy_from_user((char*)(DATA_OF(pInsert)), pSource,
-						amountToMove );
-			} else {
-				memcpy( (char*)(DATA_OF(pInsert)), pSource, amountToMove );
-			}
+			memcpy( (char*)(DATA_OF(pInsert)), pSource, amountToMove );
 			// Adjust pointers and indices
 			pSource					+= amountToMove;
 			pCh->Obuf_char_count	+= amountToMove;
diff --git a/drivers/char/ip2/i2lib.h b/drivers/char/ip2/i2lib.h
index 952e113..e559e9b 100644
--- a/drivers/char/ip2/i2lib.h
+++ b/drivers/char/ip2/i2lib.h
@@ -332,7 +332,7 @@ static int  i2QueueCommands(int, i2ChanS
 static int  i2GetStatus(i2ChanStrPtr, int);
 static int  i2Input(i2ChanStrPtr);
 static int  i2InputFlush(i2ChanStrPtr);
-static int  i2Output(i2ChanStrPtr, const char *, int, int);
+static int  i2Output(i2ChanStrPtr, const char *, int);
 static int  i2OutputFree(i2ChanStrPtr);
 static int  i2ServiceBoard(i2eBordStrPtr);
 static void i2DrainOutput(i2ChanStrPtr, int);
diff --git a/drivers/char/ip2/ip2main.c b/drivers/char/ip2/ip2main.c
index 858ba54..a3f32d4 100644
--- a/drivers/char/ip2/ip2main.c
+++ b/drivers/char/ip2/ip2main.c
@@ -1704,7 +1704,7 @@ ip2_write( PTTY tty, const unsigned char
 
 	/* This is the actual move bit. Make sure it does what we need!!!!! */
 	WRITE_LOCK_IRQSAVE(&pCh->Pbuf_spinlock,flags);
-	bytesSent = i2Output( pCh, pData, count, 0 );
+	bytesSent = i2Output( pCh, pData, count);
 	WRITE_UNLOCK_IRQRESTORE(&pCh->Pbuf_spinlock,flags);
 
 	ip2trace (CHANN, ITRC_WRITE, ITRC_RETURN, 1, bytesSent );
@@ -1764,7 +1764,7 @@ ip2_flush_chars( PTTY tty )
 		//
 		// We may need to restart i2Output if it does not fullfill this request
 		//
-		strip = i2Output( pCh, pCh->Pbuf, pCh->Pbuf_stuff, 0 );
+		strip = i2Output( pCh, pCh->Pbuf, pCh->Pbuf_stuff);
 		if ( strip != pCh->Pbuf_stuff ) {
 			memmove( pCh->Pbuf, &pCh->Pbuf[strip], pCh->Pbuf_stuff - strip );
 		}
-- 
1.4.2.GIT


