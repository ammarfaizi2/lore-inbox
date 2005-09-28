Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030219AbVI1Iha@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030219AbVI1Iha (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 04:37:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030215AbVI1Iha
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 04:37:30 -0400
Received: from smtp107.mail.sc5.yahoo.com ([66.163.169.227]:39538 "HELO
	smtp107.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1030216AbVI1Ih2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 04:37:28 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.de;
  h=Received:Date:From:To:Cc:Subject:Message-ID:Mime-Version:Content-Type:Content-Disposition:User-Agent;
  b=oZyBLwpuNJdIVLUYwgSv2UuZcrvSdHxOwFRXFCwT0/DuqyfxBDHAVtIcWaZBjnfl/i7x5YQzS8XSMz9h1T9DVKvc4ox6zYNEQNBEjp6KFQUijFu8FJBRVSyp5Z6i5/FTOKXpMKfdkPf/Aa5tgY/CBN4C5knrEd8CjzTb4MYTxME=  ;
Date: Wed, 28 Sep 2005 10:37:37 +0200
From: Borislav Petkov <bbpetkov@yahoo.de>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, R.E.Wolff@BitWizard.nl
Subject: [PATCH] remove check_region in drivers-char-specialix.c
Message-ID: <20050928083737.GA29498@gollum.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

   This is also a pretty simple case. We remove the wrapper and make
   sx__request_io_range return struct resource *. We check its value accordingly
   in the probing routine. It compiles cleanly here.

   Signed-off-by: Borislav Petkov <petkov@uni-muenster.de>


--- 2.6.14-rc2/drivers/char/specialix.c.orig	2005-09-28 10:02:31.000000000 +0200
+++ 2.6.14-rc2/drivers/char/specialix.c	2005-09-28 10:30:24.000000000 +0200
@@ -338,15 +338,9 @@ static inline void sx_wait_CCR_off(struc
  *  specialix IO8+ IO range functions.
  */
 
-static inline int sx_check_io_range(struct specialix_board * bp)
+static inline struct resource * sx_request_io_range(struct specialix_board * bp)
 {
-	return check_region (bp->base, SX_IO_SPACE);
-}
-
-
-static inline void sx_request_io_range(struct specialix_board * bp)
-{
-	request_region(bp->base, 
+	return request_region(bp->base, 
 	               bp->flags&SX_BOARD_IS_PCI?SX_PCI_IO_SPACE:SX_IO_SPACE,
 	               "specialix IO8+" );
 }
@@ -495,7 +489,7 @@ static int sx_probe(struct specialix_boa
 
 	func_enter();
 
-	if (sx_check_io_range(bp)) {
+	if (!sx_request_io_range(bp)) {
 		func_exit();
 		return 1;
 	}
@@ -583,7 +577,6 @@ static int sx_probe(struct specialix_boa
 		return -EIO;
 	}
 
-	sx_request_io_range(bp);
 	bp->flags |= SX_BOARD_PRESENT;
 	
 	/* Chip           revcode   pkgtype

	

	
		
___________________________________________________________ 
Gesendet von Yahoo! Mail - Jetzt mit 1GB Speicher kostenlos - Hier anmelden: http://mail.yahoo.de
