Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265636AbSLWCCB>; Sun, 22 Dec 2002 21:02:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265787AbSLWCCB>; Sun, 22 Dec 2002 21:02:01 -0500
Received: from dp.samba.org ([66.70.73.150]:64164 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S265636AbSLWCCA>;
	Sun, 22 Dec 2002 21:02:00 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Burton Windle <bwindle@fint.org>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [2.5.51+] kernel not honoring init= bootparm? (fwd) 
In-reply-to: Your message of "Fri, 20 Dec 2002 15:41:52 CDT."
             <Pine.LNX.4.43.0212201540160.3821-100000@morpheus> 
Date: Mon, 23 Dec 2002 13:08:57 +1100
Message-Id: <20021223021009.8E1482C0A7@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.43.0212201540160.3821-100000@morpheus> you write:
> I think this might be due to the changes you made.

Indeed it was.  Looks like overzealous patch cropping on my part.

This works for me.  Linus, please apply.

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

Name: init= boot command line fix
Author: Rusty Russell
Status: Tested on 2.5.52

D: Restores the accidentally dropped code to handle init=.

diff -urNp --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.52/init/main.c working-2.5.52-noexit/init/main.c
--- linux-2.5.52/init/main.c	Tue Dec 17 08:11:00 2002
+++ working-2.5.52-noexit/init/main.c	Mon Dec 23 12:49:41 2002
@@ -259,6 +259,22 @@ static int __init unknown_bootoption(cha
 	return 0;
 }
 
+static int __init init_setup(char *str)
+{
+	unsigned int i;
+
+	execute_command = str;
+	/* In case LILO is going to boot us with default command line,
+	 * it prepends "auto" before the whole cmdline which makes
+	 * the shell think it should execute a script with such name.
+	 * So we ignore all arguments entered _before_ init=... [MJ]
+	 */
+	for (i = 1; i < MAX_INIT_ARGS; i++)
+		argv_init[i] = NULL;
+	return 1;
+}
+__setup("init=", init_setup);
+
 extern void setup_arch(char **);
 extern void cpu_idle(void);
 
