Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266795AbSLDBpm>; Tue, 3 Dec 2002 20:45:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266796AbSLDBpm>; Tue, 3 Dec 2002 20:45:42 -0500
Received: from smtp.comcast.net ([24.153.64.2]:1421 "EHLO smtp.comcast.net")
	by vger.kernel.org with ESMTP id <S266795AbSLDBpl>;
	Tue, 3 Dec 2002 20:45:41 -0500
Date: Tue, 03 Dec 2002 20:48:00 -0500
From: Mike Phillips <phillim2@comcast.net>
Subject: [PATCH]tr.c lockup when accessing /proc/net/tr_rif under heavy load
To: marcelo@connectiva.br, linux-kernel@vger.kernel.org, jgarzik@pobox.com,
       torvalds@transmeta.com, alan@lxorguk.ukuu.org.uk
Message-id: <20021204014800.GA29150@siasl.dyndns.org>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All,

Here's a small patch that fixes a lock and potential oops when accessing
/proc/net/tr_rif is the token ring interface is under heavy load. 

The patch also applies to 2.5.50 with a couple of lines offset. 

Mike Phillips


diff -urN -x /home/phillim/dev/dontdiff linux-2.4.20.vanilla/net/802/tr.c linux-2.4.20/net/802/tr.c
--- linux-2.4.20.vanilla/net/802/tr.c	2002-08-02 20:39:46.000000000 -0400
+++ linux-2.4.20/net/802/tr.c	2002-12-03 20:28:35.000000000 -0500
@@ -468,6 +468,7 @@
 	off_t pos=0;
 	int size,i,j,rcf_len,segment,brdgnmb;
 	unsigned long now=jiffies;
+	unsigned long flags;
 
 	rif_cache entry;
 
@@ -476,7 +477,7 @@
 	pos+=size;
 	len+=size;
 
-	spin_lock_bh(&rif_lock);
+	spin_lock_irqsave(&rif_lock,flags);
 	for(i=0;i < RIF_TABLE_SIZE;i++) 
 	{
 		for(entry=rif_table[i];entry;entry=entry->next) {
@@ -525,7 +526,7 @@
 		if(pos>offset+length)
 			break;
 	}
-	spin_unlock_bh(&rif_lock);
+	spin_unlock_irqrestore(&rif_lock,flags);
 
 	*start=buffer+(offset-begin); /* Start of wanted data */
 	len-=(offset-begin);    /* Start slop */
