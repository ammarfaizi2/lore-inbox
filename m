Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262446AbUAISIr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 13:08:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262714AbUAISIr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 13:08:47 -0500
Received: from gprs214-232.eurotel.cz ([160.218.214.232]:39296 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S262446AbUAISIp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 13:08:45 -0500
Date: Fri, 9 Jan 2004 19:10:09 +0100
From: Pavel Machek <pavel@suse.cz>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>, vojtech@suse.cz
Subject: Re: Alt-arrow console switch sometimes dropped
Message-ID: <20040109181009.GB191@elf.ucw.cz>
References: <20040103133746.GA516@elf.ucw.cz> <20040108002255.0EC092C44B@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040108002255.0EC092C44B@lists.samba.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Alt-arrow console switch is routinely dropped under high load. This
> > patch fixes it: alt-arrow has to start from console _we want to switch
> > to_, if switch is already pending. Please apply,
> > 								Pavel
> 
> Sure, but a comment would be nice:
> 
> 	/* Currently switching?  Queue this next switch relative to
> > that. */

Oops, there was exactly the same problem in "fn_dec_console". Here's
incremental patch to add the comment and fix fn_dec_console,
too. I hope it is applicable.

								Pavel
--- tmp/linux/drivers/char/keyboard.c	2004-01-09 19:04:43.000000000 +0100
+++ linux/drivers/char/keyboard.c	2004-01-09 18:59:43.000000000 +0100
@@ -515,8 +515,13 @@
 static void fn_dec_console(struct vc_data *vc, struct pt_regs *regs)
 {
 	int i;
+	int cur = fg_console;
+
+	/* Currently switching?  Queue this next switch relative to that. */
+	if (want_console != -1)
+		cur = want_console;
  
-	for (i = fg_console-1; i != fg_console; i--) {
+	for (i = cur-1; i != cur; i--) {
 		if (i == -1)
 			i = MAX_NR_CONSOLES-1;
 		if (vc_cons_allocated(i))
@@ -530,6 +535,7 @@
 	int i;
 	int cur = fg_console;
 
+	/* Currently switching?  Queue this next switch relative to that. */
 	if (want_console != -1)
 		cur = want_console;
 
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
