Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932152AbVHMMHl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932152AbVHMMHl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Aug 2005 08:07:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932154AbVHMMHl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Aug 2005 08:07:41 -0400
Received: from smtprelay03.ispgateway.de ([80.67.18.15]:63123 "EHLO
	smtprelay03.ispgateway.de") by vger.kernel.org with ESMTP
	id S932152AbVHMMHl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Aug 2005 08:07:41 -0400
Message-ID: <42FDE286.40707@v.loewis.de>
Date: Sat, 13 Aug 2005 14:07:34 +0200
From: =?ISO-8859-1?Q?=22Martin_v=2E_L=F6wis=22?= <martin@v.loewis.de>
User-Agent: Debian Thunderbird 1.0.6 (X11/20050802)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [Patch] Support UTF-8 scripts
X-Enigmail-Version: 0.92.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support for UTF-8 signatures (aka BOM, byte order
mark) to binfmt_script. Files that start with EF BF FF # ! are now
recognized as scripts (in addition to files starting with # !).

With such support, creating scripts that reliably carry non-ASCII
characters is simplified. Editors and the script interpreter can
easily agree on what the encoding of the script is, and the
interpreter can then render strings appropriately. Currently,
Python supports source files that start with the UTF-8 signature;
the approach would naturally extend to Perl to enhance/replace
the "use utf8" pragma. Likewise, Tcl could use the UTF-8 signature
to reliably identify UTF-8 source code (instead of assuming
[encoding system] for source code).

Please find the patch attached below.

Regards,
Martin

Signed-off-by: Martin v. Löwis <martin@v.loewis.de>

diff --git a/fs/binfmt_script.c b/fs/binfmt_script.c
--- a/fs/binfmt_script.c
+++ b/fs/binfmt_script.c
@@ -1,7 +1,7 @@
 /*
  *  linux/fs/binfmt_script.c
  *
- *  Copyright (C) 1996  Martin von Löwis
+ *  Copyright (C) 1996, 2005  Martin von Löwis
  *  original #!-checking implemented by tytso.
  */

@@ -23,7 +23,16 @@ static int load_script(struct linux_binp
        char interp[BINPRM_BUF_SIZE];
        int retval;

-       if ((bprm->buf[0] != '#') || (bprm->buf[1] != '!') ||
(bprm->sh_bang))
+       /* It is a recursive invocation. */
+       if (bprm->sh_bang)
+               return -ENOEXEC;
+
+       /* It starts neither with #!, nor with #! preceded by
+          the UTF-8 signature. */
+       if (!(((bprm->buf[0] == '#') && (bprm->buf[1] == '!'))
+             || ((bprm->buf[0] == '\xef') && (bprm->buf[1] == '\xbb')
+                 && (bprm->buf[2] == '\xbf') && (bprm->buf[3] == '#')
+                 && (bprm->buf[4] == '!'))))
                return -ENOEXEC;
        /*
         * This section does the #! interpretation.
@@ -46,7 +55,8 @@ static int load_script(struct linux_binp
                else
                        break;
        }
-       for (cp = bprm->buf+2; (*cp == ' ') || (*cp == '\t'); cp++);
+       cp = (bprm->buf[0]=='\xef') ? bprm->buf+5 : bprm->buf+2;
+       while ((*cp == ' ') || (*cp == '\t')) cp++;
        if (*cp == '\0')
                return -ENOEXEC; /* No interpreter name found */
        i_name = cp;
