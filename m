Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263962AbUEXFcA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263962AbUEXFcA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 01:32:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263971AbUEXFcA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 01:32:00 -0400
Received: from holomorphy.com ([207.189.100.168]:19847 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S263962AbUEXFb4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 01:31:56 -0400
Date: Sun, 23 May 2004 22:31:53 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [announce/OT] kerneltop ver. 0.7
Message-ID: <20040524053153.GM1833@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"Randy.Dunlap" <rddunlap@osdl.org>,
	lkml <linux-kernel@vger.kernel.org>
References: <20040523215027.5dc99711.rddunlap@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040523215027.5dc99711.rddunlap@osdl.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 23, 2004 at 09:50:27PM -0700, Randy.Dunlap wrote:
> just a little note about kerneltop...
> 'kerneltop' is similar to 'top', but shows only kernel function usage
> (modules not included).
> I have updated it a bit (now version 0.7) and made sure that it
> works OK on Linux 2.6.x.
> It's available here:
> 	http://www.xenotime.net/linux/kerneltop/

GRRR.. this tries to reset /proc/profile. Multiple megabytes of in-
kernel memset() at a frequency of 1Hz are extremely unfriendly.


--- kerneltop.c.orig	2004-05-23 22:11:29.000000000 -0700
+++ kerneltop.c	2004-05-23 22:22:08.000000000 -0700
@@ -491,32 +491,6 @@ int do_key(char c)
 } // end do_key
 
 
-/* reset the profile buffer after each read of it */
-static void profile_reset (void)
-{
-	int multiplier, fd, to_write;
-
-	/*
-	 * When writing the multiplier, if the length of the write is
-	 * not sizeof(int), the multiplier is not changed.
-	 */
-	multiplier = 0;
-	to_write = 1;	/* smth different from sizeof(int) */
-	/* try to become root, just in case */
-	setuid (0);
-	fd = open (defaultpro, O_WRONLY);
-	if (fd < 0) {
-		perror (defaultpro);
-		exit (1);
-	}
-	if (write (fd, &multiplier, to_write) != to_write) {
-		fprintf (stderr, "kerneltop: error writing %s: %s\n",
-			defaultpro, strerror (errno));
-		exit (1);
-	}
-	close (fd);
-} // end profile_reset
-
 /*
  * allocates <buf> for the profile data;
  * returns buffer length;
@@ -753,7 +727,7 @@ main (int argc, char **argv) {
 	char *mapFile, *proFile;
 	unsigned long len = 0;
 	unsigned int step;
-	unsigned int *buf;
+	unsigned int *lastbuf, *buf = NULL;
 	int opt;
 	int optReverse = 0, optProfile = 0;
 	time_t timer;
@@ -824,10 +798,8 @@ main (int argc, char **argv) {
 	heading ();
 
     while (1) {		// get profile data, put it into symbol buckets, print
-
+	lastbuf = buf;
 	len = profile_read (proFile, &buf); // allocates buf & returns its len
-	if (!optProfile)		// don't reset if using non-default file
-		profile_reset ();
 	step = buf[0];
 	vid_curpos (ROW_SAMPLING_RANGE, 1);
 	printf (_("Sampling_step: %i | Address range: 0x%lx - 0x%lx\n"),
@@ -863,7 +835,7 @@ main (int argc, char **argv) {
 	// collect frequency histogram of profile buf.
 	for (ix = 0, lookup_last = 0; ix < mx; ix++) {
 		adr = adr0 + step * ix;
-		ticks = buf [ix + 1];
+		ticks = buf [ix + 1] - (lastbuf ? lastbuf [ix + 1] : 0);
 		total_ticks += ticks;
 		fnx = lookup (adr);
 		if (fnx >= 0)
@@ -897,7 +869,7 @@ main (int argc, char **argv) {
 	total_ticks = 0;
 	// clear freqs for next pass
 	memset (freqs, 0, sizeof(int) * (text_lines + 1));
-	free (buf);	// before next profile_read call
+	free (lastbuf);	// before next profile_read call
 
 	// check for stdin (keyboard) input 1x per second
 	// while sleeping for <sleep_seconds>
@@ -910,6 +882,7 @@ main (int argc, char **argv) {
 	}
 
     } // end while 1
+    free (buf);
 
 fini:
 	printf("\n");
