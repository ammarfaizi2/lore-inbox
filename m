Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261564AbTFFOvf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 10:51:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261704AbTFFOvf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 10:51:35 -0400
Received: from smtpzilla2.xs4all.nl ([194.109.127.138]:15364 "EHLO
	smtpzilla2.xs4all.nl") by vger.kernel.org with ESMTP
	id S261564AbTFFOum (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 10:50:42 -0400
Date: Fri, 6 Jun 2003 17:04:11 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: John Kim <john@larvalstage.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: make allyesconfig broken in 2.5.70-bk10 and -bk11
In-Reply-To: <Pine.LNX.4.53.0306061009530.28886@jake.larvalstage.com>
Message-ID: <Pine.LNX.4.44.0306061658050.12110-100000@serv>
References: <Pine.LNX.4.53.0306061009530.28886@jake.larvalstage.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 6 Jun 2003, John Kim wrote:

>   Root Plug Support (SECURITY_ROOTPLUG) [N/m/y/?] (NEW) y
> *
> * Cryptographic options
> *
> -----
> make allyesconfig works just fine for -bk9.

Hmm, it seems I missed a problem with the new select keyword.
This patch prevents any attempt to change any symbol which isn't changable 
anyway (e.g. force to 'y' via select).

bye, Roman

diff -pur linux-2.5.70-bk10.org/scripts/kconfig/conf.c linux-2.5.70-bk10/scripts/kconfig/conf.c
--- linux-2.5.70-bk10.org/scripts/kconfig/conf.c	2003-06-06 10:57:49.000000000 +0200
+++ linux-2.5.70-bk10/scripts/kconfig/conf.c	2003-06-06 16:51:38.000000000 +0200
@@ -73,6 +73,13 @@ static void conf_askvalue(struct symbol 
 	line[0] = '\n';
 	line[1] = 0;
 
+	if (!sym_is_changable(sym)) {
+		printf("%s\n", def);
+		line[0] = '\n';
+		line[1] = 0;
+		return;
+	}
+
 	switch (input_mode) {
 	case ask_new:
 	case ask_silent:
@@ -82,12 +89,6 @@ static void conf_askvalue(struct symbol 
 		}
 		check_stdin();
 	case ask_all:
-		if (!sym_is_changable(sym)) {
-			printf("%s\n", def);
-			line[0] = '\n';
-			line[1] = 0;
-			return;
-		}
 		fflush(stdout);
 		fgets(line, 128, stdin);
 		return;

