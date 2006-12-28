Return-Path: <linux-kernel-owner+w=401wt.eu-S1754871AbWL1P0H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754871AbWL1P0H (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 10:26:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754873AbWL1P0G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 10:26:06 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:4709 "HELO
	mailout.stusta.mhn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754871AbWL1P0F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 10:26:05 -0500
Date: Thu, 28 Dec 2006 16:26:07 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, mchehab@infradead.org
Cc: linux-kernel@vger.kernel.org, v4l-dvb-maintainer@linuxtv.org
Subject: [-mm patch] DVB: fix compile error
Message-ID: <20061228152607.GC20714@stusta.de>
References: <20061228024237.375a482f.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061228024237.375a482f.akpm@osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 28, 2006 at 02:42:37AM -0800, Andrew Morton wrote:
>...
> Changes since 2.6.20-rc1-mm1:
>...
>  git-dvb.patch
>...
>  git trees
>...


This patch fixes the following compile error:

<--  snip  -->

...
  LD      drivers/media/video/built-in.o
drivers/media/video/saa7134/built-in.o:(.data+0x85ec): multiple definition of `ir_rc5_remote_gap'
drivers/media/video/bt8xx/built-in.o:(.data+0x734c): first defined here
drivers/media/video/saa7134/built-in.o:(.data+0x85f0): multiple definition of `ir_rc5_key_timeout'
drivers/media/video/bt8xx/built-in.o:(.data+0x7350): first defined here
make[4]: *** [drivers/media/video/built-in.o] Error 1

<--  snip  -->

Since this variables were needlessly global, this patch implements the 
trivial fix of making them static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/media/video/bt8xx/bttv-input.c      |    4 ++--
 drivers/media/video/saa7134/saa7134-input.c |    4 ++--
 include/media/ir-common.h                   |    3 ---
 3 files changed, 4 insertions(+), 7 deletions(-)

--- linux-2.6.20-rc2-mm1/include/media/ir-common.h.old	2006-12-28 12:54:05.000000000 +0100
+++ linux-2.6.20-rc2-mm1/include/media/ir-common.h	2006-12-28 12:54:39.000000000 +0100
@@ -36,9 +36,6 @@
 #define IR_KEYCODE(tab,code)	(((unsigned)code < IR_KEYTAB_SIZE) \
 				 ? tab[code] : KEY_RESERVED)
 
-extern int ir_rc5_remote_gap;
-extern int ir_rc5_key_timeout;
-
 #define RC5_START(x)	(((x)>>12)&3)
 #define RC5_TOGGLE(x)	(((x)>>11)&1)
 #define RC5_ADDR(x)	(((x)>>6)&31)
--- linux-2.6.20-rc2-mm1/drivers/media/video/saa7134/saa7134-input.c.old	2006-12-28 12:54:48.000000000 +0100
+++ linux-2.6.20-rc2-mm1/drivers/media/video/saa7134/saa7134-input.c	2006-12-28 12:55:00.000000000 +0100
@@ -41,9 +41,9 @@
 module_param(pinnacle_remote, int, 0644);    /* Choose Pinnacle PCTV remote */
 MODULE_PARM_DESC(pinnacle_remote, "Specify Pinnacle PCTV remote: 0=coloured, 1=grey (defaults to 0)");
 
-int ir_rc5_remote_gap = 885;
+static int ir_rc5_remote_gap = 885;
 module_param(ir_rc5_remote_gap, int, 0644);
-int ir_rc5_key_timeout = 115;
+static int ir_rc5_key_timeout = 115;
 module_param(ir_rc5_key_timeout, int, 0644);
 
 #define dprintk(fmt, arg...)	if (ir_debug) \
--- linux-2.6.20-rc2-mm1/drivers/media/video/bt8xx/bttv-input.c.old	2006-12-28 12:55:08.000000000 +0100
+++ linux-2.6.20-rc2-mm1/drivers/media/video/bt8xx/bttv-input.c	2006-12-28 12:55:17.000000000 +0100
@@ -36,9 +36,9 @@
 static int repeat_period = 33;
 module_param(repeat_period, int, 0644);
 
-int ir_rc5_remote_gap = 885;
+static int ir_rc5_remote_gap = 885;
 module_param(ir_rc5_remote_gap, int, 0644);
-int ir_rc5_key_timeout = 200;
+static int ir_rc5_key_timeout = 200;
 module_param(ir_rc5_key_timeout, int, 0644);
 
 #define DEVNAME "bttv-input"

