Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312681AbSEHKG4>; Wed, 8 May 2002 06:06:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312691AbSEHKG4>; Wed, 8 May 2002 06:06:56 -0400
Received: from w007.z208177138.sjc-ca.dsl.cnc.net ([208.177.141.7]:16774 "HELO
	mail.gurulabs.com") by vger.kernel.org with SMTP id <S312681AbSEHKGy>;
	Wed, 8 May 2002 06:06:54 -0400
Date: Wed, 8 May 2002 03:40:11 -0600 (MDT)
From: Dax Kelson <dax@gurulabs.com>
X-X-Sender: dkelson@mooru.gurulabs.com
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, <marcelo@conectiva.com.br>
Subject: [PATCH] Completely honor prctl(PR_SET_KEEPCAPS, 1)
In-Reply-To: <20020508125711.B10505@in.ibm.com>
Message-ID: <Pine.LNX.4.44.0205080136560.8607-100000@mooru.gurulabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Originally when a process set*uided all capabilities bits were cleared.  
Then sometime later (wish BK went back 3 years), the behaviour was
modified according to the comment "A process may, via prctl(), elect to
keep its capabilites when it calls setuid() and switches away from
uid==0. Both permitted and effective sets will be retained."

The current behavior/implementation doesn't match the comment. Only 
permitted capabilities are retained.

This patch against 2.4.18-3 (RHL7.3 kernel, should apply against stock)  
fixes it.  Now both permitted and effective capabilities are retained.

--- kernel/sys.c-org	Wed May  8 01:20:37 2002
+++ kernel/sys.c	Wed May  8 01:35:04 2002
@@ -482,7 +482,7 @@
 		cap_clear(current->cap_permitted);
 		cap_clear(current->cap_effective);
 	}
-	if (old_euid == 0 && current->euid != 0) {
+	if ((old_euid == 0 && current->euid != 0) && !current->keep_capabilities) {
 		cap_clear(current->cap_effective);
 	}
 	if (old_euid != 0 && current->euid == 0) {




