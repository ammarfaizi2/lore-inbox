Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261604AbUFNArD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261604AbUFNArD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jun 2004 20:47:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261582AbUFNApS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jun 2004 20:45:18 -0400
Received: from holomorphy.com ([207.189.100.168]:31645 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261563AbUFNAn5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jun 2004 20:43:57 -0400
Date: Sun, 13 Jun 2004 17:43:54 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Subject: [9/12] fix duplicate environment variables passed to init
Message-ID: <20040614004354.GX1444@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org
References: <20040614003148.GO1444@holomorphy.com> <20040614003331.GP1444@holomorphy.com> <20040614003459.GQ1444@holomorphy.com> <20040614003605.GR1444@holomorphy.com> <20040614003708.GS1444@holomorphy.com> <20040614003835.GT1444@holomorphy.com> <20040614003929.GU1444@holomorphy.com> <20040614004034.GV1444@holomorphy.com> <20040614004147.GW1444@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040614004147.GW1444@holomorphy.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 * Fixed argument processing bug in init/main.c (Eric Delaunay)
This fixes Debian BTS #58566.
http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=58566

	From: Eric Delaunay <delaunay@lix.polytechnique.fr>
	Message-Id: <200002201918.UAA02327@jazz.pontchartrain.fr>
	Subject: pb in handling parameters on kernel command line
	To: submit@bugs.debian.org (debian bug tracking system)

Hello, I found some bugs in kernel command line parser.  AFAIK, they are not
Debian nor sparc specific but I'm not subscribed to linux-kernel mailing list
and since I'm involved with boot-floppies (mainly for sparc), I think I'm right
to report it here.  Feel free to forward it upstream (I checked the latest
2.3.46 sources and it seems these bugs are still there).

These bugs are not release critical.  The latter just not gives the user a
chance to overwrite TERM env var at boot time.  It could be just
inconvenient for serial console boot, and in this case, our busybox' init is
already enforcing TERM=vt102.
Nevertheless if it could not be fixed before the release, I could even write a
workaround in busybox' init (it's just a matter of rewriting getenv()).

At last, it does not affect sysvinit package because serial console tty is
controlled by a getty process which is reading terminal settings on its command
line (take a look in inittab for T0 entries, if any).


Ok, here is my modest contribution to kernel hacking.  I don't know much about
kernel internals but it seems that argument parsing is a bit broken.

One trivial patch for command line like "init=/bin/sh console=prom" where
console=prom is replaced by lot of spaces in previous call to setup_arch() on
sparc, therefore the line parsed by parse_options() is really
"init=/bin/sh            " and a lot of null args are pushed into argv_init.

The other patch is for command line like "TERM=vt100" where both default & user
TERM entries are pushed into the env array.
Taking a look into /proc/1/environ, it shows up:
HOME=/
TERM=linux
TERM=vt100

It appears that ash (maybe other shells too) is giving the latter entry but
glibc getenv() is giving the former.  It is therefore impossible to get entry
from the user in a C program like busybox' init (used in Debian boot-floppies).

I guess getenv() is not written to support duplicate entries, therefore the
kernel should avoid such construct.


Index: linux-2.5/init/main.c
===================================================================
--- linux-2.5.orig/init/main.c	2004-06-13 11:57:47.000000000 -0700
+++ linux-2.5/init/main.c	2004-06-13 12:08:56.000000000 -0700
@@ -268,6 +268,8 @@
 				panic_later = "Too many boot env vars at `%s'";
 				panic_param = param;
 			}
+			if (!strncmp(param, envp_init[i], val - param))
+				break;
 		}
 		envp_init[i] = param;
 	} else {
