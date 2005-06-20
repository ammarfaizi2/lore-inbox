Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261340AbVFUFsy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261340AbVFUFsy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 01:48:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261875AbVFUFqT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 01:46:19 -0400
Received: from mail.dif.dk ([193.138.115.101]:3472 "EHLO saerimmer.dif.dk")
	by vger.kernel.org with ESMTP id S261433AbVFTWlA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 18:41:00 -0400
Date: Tue, 21 Jun 2005 00:46:26 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Jeff Garzik <jgarzik@pobox.com>,
       Domen Puncer <domen@coderock.org>
Subject: [RFC] cleanup patches for strings
Message-ID: <Pine.LNX.4.62.0506200052320.2415@dragon.hyggekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have a bunch (few hundred) of oneliners like the ones below lying around 
on my HD and I'm wondering what the best way to submit them is.

The patches all make the same change, there's just a lot of files the 
change needs to be made in.  The change they make is to change strings 
from the form
	[const] char *foo = "blah";
to
	[const] char foo[] = "blah";

The reason to do this was well explained by Jeff Garzik in the past (and 
now found in the Kernel Janitors TODO) :

-----------------------------------------------------------------------------
From: Jeff Garzik <jgarzik at mandrakesoft dot com>

The string form

        [const] char *foo = "blah";

creates two variables in the final assembly output, a static string, and
a char pointer to the static string.  The alternate string form

        [const] char foo[] = "blah";

is better because it declares a single variable.

For variables marked __initdata, the "*foo" form causes only the
pointer, not the string itself, to be dropped from the kernel image,
which is a bug.  Using the "foo[]" form with regular 'ole local
variables also makes the assembly shorter.
-----------------------------------------------------------------------------

What I did was make a small sed script to blindly change all occourances 
of the first form into the second. Of course this won't always work, since 
the second form is not always good if we later assign something to the 
variable, but it provided a starting point.  I'm now in the process of 
weeding out the false positives so that I'll be left with all the patches 
that actually make a sane change.

As for submitting them. I was planning to split them into groups based on 
top-level kernel source dirs, then concatenate all the patches for one dir 
into one large patch and send it to lkml + CC:akpm (this would mean <=11 
patches) - sending each patch to a sepperate maintainer would make it a 
nightmare and would take ages. Andrew: would you be OK with that? Are 
patches like these even wanted?


Below I've just picked 5 of my patches at random to show you what they 
look like. These should not be merged yet.


--- linux-2.6.12-orig/drivers/isdn/hardware/avm/b1.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.12/drivers/isdn/hardware/avm/b1.c	2005-06-20 00:04:10.000000000 +0200
@@ -28,7 +28,7 @@
 #include <linux/isdn/capicmd.h>
 #include <linux/isdn/capiutil.h>
 
-static char *revision = "$Revision: 1.1.2.2 $";
+static char revision[] = "$Revision: 1.1.2.2 $";
 
 /* ------------------------------------------------------------- */
 
--- linux-2.6.12-orig/drivers/net/wireless/wavelan_cs.p.h	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.12/drivers/net/wireless/wavelan_cs.p.h	2005-06-20 00:04:11.000000000 +0200
@@ -512,7 +512,7 @@
 /************************ CONSTANTS & MACROS ************************/
 
 #ifdef DEBUG_VERSION_SHOW
-static const char *version = "wavelan_cs.c : v24 (SMP + wireless extensions) 11/1/02\n";
+static const char version[] = "wavelan_cs.c : v24 (SMP + wireless extensions) 11/1/02\n";
 #endif
 
 /* Watchdog temporisation */

--- linux-2.6.12-orig/drivers/net/appletalk/cops.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.12/drivers/net/appletalk/cops.c	2005-06-20 00:04:11.000000000 +0200
@@ -84,7 +84,7 @@ static const char *version =
  *      io regions, irqs and dma channels
  */
 
-static const char *cardname = "cops";
+static const char cardname[] = "cops";
 
 #ifdef CONFIG_COPS_DAYNA
 static int board_type = DAYNA;	/* Module exported */

--- linux-2.6.12-orig/drivers/net/sun3lance.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.12/drivers/net/sun3lance.c	2005-06-20 00:04:11.000000000 +0200
@@ -21,7 +21,7 @@
   
 */
 
-static char *version = "sun3lance.c: v1.2 1/12/2001  Sam Creasey (sammy@sammy.net)\n";
+static char version[] = "sun3lance.c: v1.2 1/12/2001  Sam Creasey (sammy@sammy.net)\n";
 
 #include <linux/module.h>
 #include <linux/stddef.h>

--- linux-2.6.12-orig/drivers/net/ibmlana.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.12/drivers/net/ibmlana.c	2005-06-20 00:04:11.000000000 +0200
@@ -842,7 +842,7 @@ static int ibmlana_tx(struct sk_buff *sk
 	   Sorry Linus for the filler string but I couldn't resist ;-) */
 
 	if (tmplen > skb->len) {
-		char *fill = "NetBSD is a nice OS too! ";
+		char fill[] = "NetBSD is a nice OS too! ";
 		unsigned int destoffs = skb->len, l = strlen(fill);
 
 		while (destoffs < tmplen) {


