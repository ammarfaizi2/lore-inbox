Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261827AbTFFO6j (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 10:58:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261840AbTFFO6j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 10:58:39 -0400
Received: from yue.hongo.wide.ad.jp ([203.178.139.94]:42505 "EHLO
	yue.hongo.wide.ad.jp") by vger.kernel.org with ESMTP
	id S261827AbTFFO6E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 10:58:04 -0400
Date: Sat, 07 Jun 2003 00:11:41 +0900 (JST)
Message-Id: <20030607.001141.95015636.yoshfuji@linux-ipv6.org>
To: zippel@linux-m68k.org
CC: yoshfuji@linux-ipv6.org, mec@shout.net, kbuild-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: [PATCH] scripts/kconfig/conf segfaults without filename
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
Organization: USAGI Project
X-URL: http://www.yoshifuji.org/%7Ehideaki/
X-Fingerprint: 90 22 65 EB 1E CF 3A D1 0B DF 80 D8 48 07 F8 94 E0 62 0E EA
X-PGP-Key-URL: http://www.yoshifuji.org/%7Ehideaki/hideaki@yoshifuji.org.asc
X-Face: "5$Al-.M>NJ%a'@hhZdQm:."qn~PA^gq4o*>iCFToq*bAi#4FRtx}enhuQKz7fNqQz\BYU]
 $~O_5m-9'}MIs`XGwIEscw;e5b>n"B_?j/AkL~i/MEa<!5P`&C$@oP>ZBLP
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.1 (AOI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

scripts/kconfig/conf does not check number of command line arguments 
properly, and it segfaults if it is invoked without filename.

Thanks in advance.

Index: linux25/scripts/kconfig/conf.c
===================================================================
RCS file: /cvsroot/usagi/usagi/kernel/linux25/scripts/kconfig/conf.c,v
retrieving revision 1.1.1.4
diff -u -r1.1.1.4 conf.c
--- linux25/scripts/kconfig/conf.c	27 May 2003 03:01:00 -0000	1.1.1.4
+++ linux25/scripts/kconfig/conf.c	6 Jun 2003 14:54:34 -0000
@@ -476,39 +476,45 @@
 	const char *name;
 	struct stat tmpstat;
 
-	if (ac > 1 && av[1][0] == '-') {
-		switch (av[1][1]) {
-		case 'o':
-			input_mode = ask_new;
-			break;
-		case 's':
-			input_mode = ask_silent;
-			valid_stdin = isatty(0) && isatty(1) && isatty(2);
-			break;
-		case 'd':
-			input_mode = set_default;
-			break;
-		case 'n':
-			input_mode = set_no;
-			break;
-		case 'm':
-			input_mode = set_mod;
-			break;
-		case 'y':
-			input_mode = set_yes;
-			break;
-		case 'r':
-			input_mode = set_random;
-			srandom(time(NULL));
-			break;
-		case 'h':
-		case '?':
-			printf("%s [-o|-s] config\n", av[0]);
-			exit(0);
-		}
-		name = av[2];
+	if (ac > 1) {
+		if (av[1][0] == '-') {
+			name = ac > 2 ? av[2] : NULL;
+
+			switch (av[1][1]) {
+			case 'o':
+				input_mode = ask_new;
+				break;
+			case 's':
+				input_mode = ask_silent;
+				valid_stdin = isatty(0) && isatty(1) && isatty(2);
+				break;
+			case 'd':
+				input_mode = set_default;
+				break;
+			case 'n':
+				input_mode = set_no;
+				break;
+			case 'm':
+				input_mode = set_mod;
+				break;
+			case 'y':
+				input_mode = set_yes;
+				break;
+			case 'r':
+				input_mode = set_random;
+				srandom(time(NULL));
+				break;
+			default:
+				name = NULL;
+			}
+		} else
+			name = av[1];
 	} else
-		name = av[1];
+		name = NULL;
+	if (name == NULL) {
+		printf("%s [-o|-s|-d|-n|-m|-y|-r] config\n", av[0]);
+		exit(0);
+	}
 	conf_parse(name);
 	//zconfdump(stdout);
 	switch (input_mode) {

-- 
Hideaki YOSHIFUJI @ USAGI Project <yoshfuji@linux-ipv6.org>
GPG FP: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
