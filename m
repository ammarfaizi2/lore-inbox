Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317888AbSFNJLq>; Fri, 14 Jun 2002 05:11:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317890AbSFNJLq>; Fri, 14 Jun 2002 05:11:46 -0400
Received: from mail.gmx.de ([213.165.64.20]:4898 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S317888AbSFNJLo>;
	Fri, 14 Jun 2002 05:11:44 -0400
From: "Michael Kerrisk" <michael.kerrisk@gmx.net>
To: marcelo@conectiva.com.br, lKML <linux-kernel@vger.kernel.org>
Date: Fri, 14 Jun 2002 11:09:22 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: [PATCH] [2.4.18] Fix adjtimex when txc->modes == 0
CC: drepper@redhat.com
Message-ID: <3D09CEE2.5529.1100FEC@localhost>
X-mailer: Pegasus Mail for Win32 (v3.12c)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The glibc implementation of adjtime(delta, old_delta) should return
the remaining time adjustment value from adjtimex() in old_delta if that
argument is non-NULL.  

This is broken in the case that delta is NULL (i.e., we don't want 
a change, but just to find out the current time_adjust).  The breakage
occurs because adjtime specifies txc->modes as 0 (so that no change
is made to the current offset) and in this case do_adjtimex() does not
correctly return the required information in txc->offset.  

The patch below (against 2.4.18pre10) seems to me the simplest way to 
fix the problem.

Cheers,

Michael

--- linux-2.4.18/kernel/time.c	Fri Jun 14 10:17:46 2002
+++ linux-2.4.18-adjtimex/kernel/time.c	Fri Jun 14 09:48:59 2002
@@ -357,7 +357,9 @@
 	    /* p. 24, (d) */
 		result = TIME_ERROR;
 	
-	if ((txc->modes & ADJ_OFFSET_SINGLESHOT) == ADJ_OFFSET_SINGLESHOT)
+	if (!txc->modes)
+	    txc->offset	   = time_adjust;
+	else if ((txc->modes & ADJ_OFFSET_SINGLESHOT) == ADJ_OFFSET_SINGLESHOT)
 	    txc->offset	   = save_adjust;
 	else {
 	    if (time_offset < 0)

