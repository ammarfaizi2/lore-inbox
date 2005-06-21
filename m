Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262339AbVFUWUY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262339AbVFUWUY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 18:20:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262331AbVFUWUY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 18:20:24 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:9470 "EHLO e33.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S262552AbVFUVj2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 17:39:28 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 4/11] ppc64: pSeries_progress -> rtas_progress
Date: Tue, 21 Jun 2005 23:18:15 +0200
User-Agent: KMail/1.7.2
Cc: linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org
References: <200506212310.54156.arnd@arndb.de> <200506212313.12090.arnd@arndb.de> <200506212317.13467.arnd@arndb.de>
In-Reply-To: <200506212317.13467.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506212318.16573.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The pSeries_progress function is called from some places in the rtas code,
which may also be used by non-pSeries platforms.
Though pSeries is currently the only platform type that implements
display-character, the code is actually generic enough to be part of
the rtas subsystem.

I hit a bug here because the generic rtas code tried calling ppc_md.progress,
which points to an __init function on most platforms.

We could also clear the ppc_md.progress pointer when freeing the init memory
to make it more explicit that ppc_md.progress must not be called after
bootup.

Signed-off-by: Arnd Bergmann <arndb@de.ibm.com>

---

 arch/ppc64/kernel/pSeries_setup.c |  103 ------------------------------------
 arch/ppc64/kernel/rtas.c          |  106 +++++++++++++++++++++++++++++++++++++-
 include/asm-ppc64/rtas.h          |    1 
 3 files changed, 106 insertions(+), 104 deletions(-)

--- linux-cg.orig/arch/ppc64/kernel/pSeries_setup.c	2005-06-21 03:22:26.797955872 -0400
+++ linux-cg/arch/ppc64/kernel/pSeries_setup.c	2005-06-21 03:25:16.110912400 -0400
@@ -375,107 +375,6 @@ static void __init pSeries_init_early(vo
 }
 
 
-static void pSeries_progress(char *s, unsigned short hex)
-{
-	struct device_node *root;
-	int width, *p;
-	char *os;
-	static int display_character, set_indicator;
-	static int max_width;
-	static DEFINE_SPINLOCK(progress_lock);
-	static int pending_newline = 0;  /* did last write end with unprinted newline? */
-
-	if (!rtas.base)
-		return;
-
-	if (max_width == 0) {
-		if ((root = find_path_device("/rtas")) &&
-		     (p = (unsigned int *)get_property(root,
-						       "ibm,display-line-length",
-						       NULL)))
-			max_width = *p;
-		else
-			max_width = 0x10;
-		display_character = rtas_token("display-character");
-		set_indicator = rtas_token("set-indicator");
-	}
-
-	if (display_character == RTAS_UNKNOWN_SERVICE) {
-		/* use hex display if available */
-		if (set_indicator != RTAS_UNKNOWN_SERVICE)
-			rtas_call(set_indicator, 3, 1, NULL, 6, 0, hex);
-		return;
-	}
-
-	spin_lock(&progress_lock);
-
-	/*
-	 * Last write ended with newline, but we didn't print it since
-	 * it would just clear the bottom line of output. Print it now
-	 * instead.
-	 *
-	 * If no newline is pending, print a CR to start output at the
-	 * beginning of the line.
-	 */
-	if (pending_newline) {
-		rtas_call(display_character, 1, 1, NULL, '\r');
-		rtas_call(display_character, 1, 1, NULL, '\n');
-		pending_newline = 0;
-	} else {
-		rtas_call(display_character, 1, 1, NULL, '\r');
-	}
- 
-	width = max_width;
-	os = s;
-	while (*os) {
-		if (*os == '\n' || *os == '\r') {
-			/* Blank to end of line. */
-			while (width-- > 0)
-				rtas_call(display_character, 1, 1, NULL, ' ');
- 
-			/* If newline is the last character, save it
-			 * until next call to avoid bumping up the
-			 * display output.
-			 */
-			if (*os == '\n' && !os[1]) {
-				pending_newline = 1;
-				spin_unlock(&progress_lock);
-				return;
-			}
- 
-			/* RTAS wants CR-LF, not just LF */
- 
-			if (*os == '\n') {
-				rtas_call(display_character, 1, 1, NULL, '\r');
-				rtas_call(display_character, 1, 1, NULL, '\n');
-			} else {
-				/* CR might be used to re-draw a line, so we'll
-				 * leave it alone and not add LF.
-				 */
-				rtas_call(display_character, 1, 1, NULL, *os);
-			}
- 
-			width = max_width;
-		} else {
-			width--;
-			rtas_call(display_character, 1, 1, NULL, *os);
-		}
- 
-		os++;
- 
-		/* if we overwrite the screen length */
-		if (width <= 0)
-			while ((*os != 0) && (*os != '\n') && (*os != '\r'))
-				os++;
-	}
- 
-	/* Blank to end of line. */
-	while (width-- > 0)
-		rtas_call(display_character, 1, 1, NULL, ' ');
-
-	spin_unlock(&progress_lock);
-}
-
 static int pSeries_check_legacy_ioport(unsigned int baseport)
 {
 	struct device_node *np;
@@ -535,7 +434,7 @@ struct machdep_calls __initdata pSeries_
 	.get_rtc_time		= rtas_get_rtc_time,
 	.set_rtc_time		= rtas_set_rtc_time,
 	.calibrate_decr		= generic_calibrate_decr,
-	.progress		= pSeries_progress,
+	.progress		= rtas_progress,
 	.check_legacy_ioport	= pSeries_check_legacy_ioport,
 	.system_reset_exception = pSeries_system_reset_exception,
 	.machine_check_exception = pSeries_machine_check_exception,
--- linux-cg.orig/arch/ppc64/kernel/rtas-proc.c	2005-06-21 20:21:27.735960616 -0400
+++ linux-cg/arch/ppc64/kernel/rtas-proc.c	2005-06-21 20:22:10.272883704 -0400
@@ -371,11 +371,11 @@ static ssize_t ppc_rtas_progress_write(s
 	/* Lets see if the user passed hexdigits */
 	hex = simple_strtoul(progress_led, NULL, 10);
 
-	ppc_md.progress ((char *)progress_led, hex);
+	rtas_progress ((char *)progress_led, hex);
 	return count;
 
 	/* clear the line */
-	/* ppc_md.progress("                   ", 0xffff);*/
+	/* rtas_progress("                   ", 0xffff);*/
 }
 /* ****************************************************************** */
 static int ppc_rtas_progress_show(struct seq_file *m, void *v)
--- linux-cg.orig/arch/ppc64/kernel/rtas.c	2005-06-21 20:20:19.484954016 -0400
+++ linux-cg/arch/ppc64/kernel/rtas.c	2005-06-21 20:21:52.832873152 -0400
@@ -91,6 +91,108 @@ call_rtas_display_status_delay(unsigned 
 	}
 }
 
+void
+rtas_progress(char *s, unsigned short hex)
+{
+	struct device_node *root;
+	int width, *p;
+	char *os;
+	static int display_character, set_indicator;
+	static int max_width;
+	static DEFINE_SPINLOCK(progress_lock);
+	static int pending_newline = 0;  /* did last write end with unprinted newline? */
+
+	if (!rtas.base)
+		return;
+
+	if (max_width == 0) {
+		if ((root = find_path_device("/rtas")) &&
+		     (p = (unsigned int *)get_property(root,
+						       "ibm,display-line-length",
+						       NULL)))
+			max_width = *p;
+		else
+			max_width = 0x10;
+		display_character = rtas_token("display-character");
+		set_indicator = rtas_token("set-indicator");
+	}
+
+	if (display_character == RTAS_UNKNOWN_SERVICE) {
+		/* use hex display if available */
+		if (set_indicator != RTAS_UNKNOWN_SERVICE)
+			rtas_call(set_indicator, 3, 1, NULL, 6, 0, hex);
+		return;
+	}
+
+	spin_lock(&progress_lock);
+
+	/*
+	 * Last write ended with newline, but we didn't print it since
+	 * it would just clear the bottom line of output. Print it now
+	 * instead.
+	 *
+	 * If no newline is pending, print a CR to start output at the
+	 * beginning of the line.
+	 */
+	if (pending_newline) {
+		rtas_call(display_character, 1, 1, NULL, '\r');
+		rtas_call(display_character, 1, 1, NULL, '\n');
+		pending_newline = 0;
+	} else {
+		rtas_call(display_character, 1, 1, NULL, '\r');
+	}
+ 
+	width = max_width;
+	os = s;
+	while (*os) {
+		if (*os == '\n' || *os == '\r') {
+			/* Blank to end of line. */
+			while (width-- > 0)
+				rtas_call(display_character, 1, 1, NULL, ' ');
+ 
+			/* If newline is the last character, save it
+			 * until next call to avoid bumping up the
+			 * display output.
+			 */
+			if (*os == '\n' && !os[1]) {
+				pending_newline = 1;
+				spin_unlock(&progress_lock);
+				return;
+			}
+ 
+			/* RTAS wants CR-LF, not just LF */
+ 
+			if (*os == '\n') {
+				rtas_call(display_character, 1, 1, NULL, '\r');
+				rtas_call(display_character, 1, 1, NULL, '\n');
+			} else {
+				/* CR might be used to re-draw a line, so we'll
+				 * leave it alone and not add LF.
+				 */
+				rtas_call(display_character, 1, 1, NULL, *os);
+			}
+ 
+			width = max_width;
+		} else {
+			width--;
+			rtas_call(display_character, 1, 1, NULL, *os);
+		}
+ 
+		os++;
+ 
+		/* if we overwrite the screen length */
+		if (width <= 0)
+			while ((*os != 0) && (*os != '\n') && (*os != '\r'))
+				os++;
+	}
+ 
+	/* Blank to end of line. */
+	while (width-- > 0)
+		rtas_call(display_character, 1, 1, NULL, ' ');
+
+	spin_unlock(&progress_lock);
+}
+
 int
 rtas_token(const char *service)
 {
@@ -425,8 +527,8 @@ rtas_flash_firmware(void)
 
 	printk(KERN_ALERT "FLASH: flash image is %ld bytes\n", image_size);
 	printk(KERN_ALERT "FLASH: performing flash and reboot\n");
-	ppc_md.progress("Flashing        \n", 0x0);
-	ppc_md.progress("Please Wait...  ", 0x0);
+	rtas_progress("Flashing        \n", 0x0);
+	rtas_progress("Please Wait...  ", 0x0);
 	printk(KERN_ALERT "FLASH: this will take several minutes.  Do not power off!\n");
 	status = rtas_call(update_token, 1, 1, NULL, rtas_block_list);
 	switch (status) {	/* should only get "bad" status */
--- linux-cg.orig/include/asm-ppc64/rtas.h	2005-06-21 20:21:43.670935016 -0400
+++ linux-cg/include/asm-ppc64/rtas.h	2005-06-21 20:21:52.832873152 -0400
@@ -186,6 +186,7 @@ extern int rtas_get_sensor(int sensor, i
 extern int rtas_get_power_level(int powerdomain, int *level);
 extern int rtas_set_power_level(int powerdomain, int level, int *setlevel);
 extern int rtas_set_indicator(int indicator, int index, int new_value);
+extern void rtas_progress(char *s, unsigned short hex);
 extern void rtas_initialize(void);
 
 struct rtc_time;

