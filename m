Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316909AbSFDWzu>; Tue, 4 Jun 2002 18:55:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316912AbSFDWzt>; Tue, 4 Jun 2002 18:55:49 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:32273 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S316909AbSFDWzr>;
	Tue, 4 Jun 2002 18:55:47 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Alexander.Riesen@synopsys.com
Cc: kbuild-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: Announce: Kernel Build for 2.5, release 3.0 is available 
In-Reply-To: Your message of "Tue, 04 Jun 2002 11:16:46 +0200."
             <20020604091646.GB29455@riesen-pc.gr05.synopsys.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 05 Jun 2002 08:55:35 +1000
Message-ID: <17931.1023231335@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Jun 2002 11:16:46 +0200, 
Alex Riesen <Alexander.Riesen@synopsys.com> wrote:
>Got this trying to compile 2.5.20 with Debian's gcc 2.95.4.
>Why it took the system-wide zlib.h?
>In file included from /export/home/riesen-pc0/riesen/compile/v2.5/fs/isofs/compress.c:38:
>include/linux/zlib.h:34: zconf.h: No such file or directory

In order to do separate source and object correctly, kbuild 2.5
enforces the rule that #include "" comes from the local directory,
#include <> comes from the include path.  include/linux/zlib.h
incorrectly does #include "zconf.h" instead of #include <linux/zconf.h>,
breaking the rules.

This was not detected by common-2.5.20-1 because the nostdinc check was
incomplete, common-2.5.20-2 does nostdinc correctly.  I avoid changing
the source code for kbuild 2.5, instead I workaround these incorrect
includes by adding extra_cflags() with FIXME comments to correct the
code later.  I will do a common-2.5.20-3 to workaround zlib.h, in the
meantime try this quick and dirty fix

--- 2.5.20-pristine/include/linux/zlib.h	Mon Apr 15 05:18:43 2002
+++ 2.5.20-kbuild-2.5/include/linux/zlib.h	Tue Jun  4 11:03:05 2002
@@ -31,7 +31,7 @@
 #ifndef _ZLIB_H
 #define _ZLIB_H
 
-#include "zconf.h"
+#include <linux/zconf.h>
 
 #ifdef __cplusplus
 extern "C" {


