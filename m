Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263927AbUACUDU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jan 2004 15:03:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263963AbUACUDU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jan 2004 15:03:20 -0500
Received: from [193.138.115.2] ([193.138.115.2]:21265 "HELO
	diftmgw.backbone.dif.dk") by vger.kernel.org with SMTP
	id S263927AbUACUDF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jan 2004 15:03:05 -0500
Date: Sat, 3 Jan 2004 21:00:15 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: kbuild-devel@lists.sourceforge.net
cc: linux-kernel@vger.kernel.org
Subject: CONFIG_KGDB_OPTIONS and CONFIG_CC_OPTIMIZE_FOR_SIZE conflict
Message-ID: <Pine.LNX.4.56.0401032039390.4664@jju_lnx.backbone.dif.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I've noticed that if you enable both CONFIG_KGDB_MORE (with the default
CONFIG_KGDB_OPTIONS) and CONFIG_CC_OPTIMIZE_FOR_SIZE, then the kernel will be
build with (amongst other options) "-g -O1 -Os" -
this is less than optimal since according to "man gcc" :
 "If you use multiple -O options, with or without level numbers, the last such option is the one that is effective."

So in the case where someone enables both options, the resulting kernel
will effectively be build with "-g -Os" which will ignore any -O
option specified in CONFIG_KGDB_OPTIONS - that will probably be surprising
to some.
Wouldn't it be better to only make it possible for the user to select one
of the options, or at least make the user aware of how the kernel will be
build if both options are enabled?

I suggest the patch below (against 2.6.1-rc1-mm1) :


--- linux-2.6.1-rc1-mm1-orig/arch/i386/Kconfig  2004-01-01 23:22:03.000000000 +0100
+++ linux-2.6.1-rc1-mm1/arch/i386/Kconfig       2004-01-03 21:04:21.000000000 +0100
@@ -1395,7 +1395,6 @@ config KGDB_MORE
          Saying yes here turns on the ability to enter additional
          compile options.

-
 config KGDB_OPTIONS
        depends on KGDB_MORE
        string "Additional compile arguments"
@@ -1408,6 +1407,9 @@ config KGDB_OPTIONS
          turned on.  In addition, on i386 platforms
          "-fomit-frame-pointer" is deleted from the standard compile
          options.
+         Be aware that if you have enabled CONFIG_CC_OPTIMIZE_FOR_SIZE
+         which adds -Os to the compile options then that will overrule
+         any -O option you specify here.

 config NO_KGDB_CPUS
        int "Number of CPUs"



Kind regards,

Jesper Juhl




PS. Please CC me if replies are only send to
kbuild-devel@lists.sourceforge.net since I'm not subscribed to that list.
I am subscribed to lkml though, so no need to CC me if that list is
included.

