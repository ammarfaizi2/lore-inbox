Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264210AbUEXJyq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264210AbUEXJyq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 05:54:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264213AbUEXJyq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 05:54:46 -0400
Received: from mail010.syd.optusnet.com.au ([211.29.132.56]:48032 "EHLO
	mail010.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S264210AbUEXJyl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 05:54:41 -0400
From: "Cef (LKML)" <cef-lkml@optusnet.com.au>
To: linux-kernel@vger.kernel.org
Subject: Re: [announce/OT] kerneltop ver. 0.7
Date: Mon, 24 May 2004 19:55:42 +1000
User-Agent: KMail/1.6.2
Cc: William Lee Irwin III <wli@holomorphy.com>,
       "Randy.Dunlap" <rddunlap@osdl.org>
References: <20040523215027.5dc99711.rddunlap@osdl.org> <20040524053153.GM1833@holomorphy.com>
In-Reply-To: <20040524053153.GM1833@holomorphy.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200405241955.43938.cef-lkml@optusnet.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 May 2004 15:31, William Lee Irwin III wrote:
> On Sun, May 23, 2004 at 09:50:27PM -0700, Randy.Dunlap wrote:
> > just a little note about kerneltop...
> > 'kerneltop' is similar to 'top', but shows only kernel function usage
> > (modules not included).
> > I have updated it a bit (now version 0.7) and made sure that it
> > works OK on Linux 2.6.x.
> > It's available here:
> > 	http://www.xenotime.net/linux/kerneltop/
>
> GRRR.. this tries to reset /proc/profile. Multiple megabytes of in-
> kernel memset() at a frequency of 1Hz are extremely unfriendly.

Following patch primes the buffer first time round (avoids huge total_ticks on 
first pass) and moves total_ticks to the end of the field header bar, saving 
an output line for useful data.

PS: If this keeps going, we should probably take this off-list or move to 
somewhere appropriate.

--- kerneltop.c-old	2004-05-24 19:44:35.000000000 +1000
+++ kerneltop.c	2004-05-24 19:48:40.000000000 +1000
@@ -266,7 +266,7 @@
  * heading looks like (3 lines):
 <uname -a>
 Sampling step: n | Address range: s_text_addr - e_text_addr
-address  function ..... date/time ...... ticks
+address  function ..... date/time ...... ticks (total_ticks)
  */
 static void heading (void)
 {
@@ -797,6 +797,11 @@
 
 	heading ();
 
+	printf ("... profiling ...\n"); // keep the user in suspense
+	len = profile_read (proFile, &buf); // allocates buf & returns its len
+	memset (freqs, 0, sizeof(int) * (text_lines + 1));
+	sleep (1);
+
     while (1) {		// get profile data, put it into symbol buckets, print
 	lastbuf = buf;
 	len = profile_read (proFile, &buf); // allocates buf & returns its len
@@ -809,7 +814,7 @@
 	time (&timer);
 	dttm = localtime (&timer);
 	vid_curpos (ROW_HEADINGS, 1);
-	printf (_("address  function ..... %d-%02d-%02d/%02d:%02d:%02d ...... 
ticks\n"),
+	printf (_("address  function ..... %d-%02d-%02d/%02d:%02d:%02d ...... 
ticks"),
 		dttm->tm_year + 1900, dttm->tm_mon + 1, dttm->tm_mday,
 		dttm->tm_hour, dttm->tm_min, dttm->tm_sec);
 
@@ -841,6 +846,9 @@
 		if (fnx >= 0)
 			freqs [fnx] += ticks;
 	}
+	// Print total on end of previous string
+	printf (" (%6i)\n", total_ticks);
+
 	/*
 	 * Optionally sort the top <prof_lines> entries.
 	 * Print the top entries.
@@ -863,9 +871,6 @@
 			textsym->textadr, textsym->textname, ticks);
 	}
 
-	/* trailer */
-	printf ("%08x %-40s %6i\n", 0, "total", total_ticks);
-
 	total_ticks = 0;
 	// clear freqs for next pass
 	memset (freqs, 0, sizeof(int) * (text_lines + 1));

-- 
 Stuart Young (aka Cef)
 cef-lkml@optusnet.com.au is for LKML and related email only
