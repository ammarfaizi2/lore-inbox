Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262066AbTFOJlA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jun 2003 05:41:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262073AbTFOJlA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jun 2003 05:41:00 -0400
Received: from hueytecuilhuitl.mtu.ru ([195.34.32.123]:14084 "EHLO
	hueymiccailhuitl.mtu.ru") by vger.kernel.org with ESMTP
	id S262066AbTFOJk7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jun 2003 05:40:59 -0400
From: Andrey Borzenkov <arvidjaar@mail.ru>
To: Rusty Russell <rusty@rustcorp.com.au>
Subject: module-init-tools and chained aliases
Date: Sun, 15 Jun 2003 13:52:36 +0400
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200306151352.36226.arvidjaar@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Apparently modprobe from module-init-tools 0.9.11a does not support chained 
aliases like modutils did, i.e.

alias foo bar
alias bar baz

will result in error doing "modprobe foo" instead of loading "baz".

This is a real problem when converting modules.devfs, because customary

alias /dev/tts* /dev/tts
alias /dev/tts serial

simply does not work for accessing /dev/tts/*. modprobe.devfs as shipped with 
modue-init-tools has exactly the problem in parts.

It is possible to partially work around it by using

install foo /sbin/modprobe bar

consistently instead of alias but it means extra forks every time, besided it 
breaks parsing for many tools (initscripts or mkinitrd make heavy use of 
parsing sometimes, at least on Mandrake).

Is the behaviour intentional? Fixing it is just a one line patch and I fail to 
see why current state would be preferred.

regards

-andrey

--- modprobe.c.orig     2003-06-15 01:32:21.000000000 +0400
+++ modprobe.c  2003-06-15 13:46:25.000000000 +0400
@@ -1021,8 +1021,11 @@ static char *read_config(const char *fil

                        if (!wildcard || !realname)
                                grammar(cmd, filename, linenum);
-                       else if (fnmatch(wildcard,name,0) == 0)
-                               result = NOFAIL(strdup(realname));
+                       else if (fnmatch(wildcard,name,0) == 0) {
+                               if (result)
+                                       free(result);
+                               name = result = NOFAIL(strdup(realname));
+                       }
                } else if (strcmp(cmd, "include") == 0) {
                        char *newresult, *newfilename;


