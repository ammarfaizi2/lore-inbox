Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267774AbUGWOyn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267774AbUGWOyn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jul 2004 10:54:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267770AbUGWOym
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jul 2004 10:54:42 -0400
Received: from baikonur.stro.at ([213.239.196.228]:15058 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S267772AbUGWOyc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jul 2004 10:54:32 -0400
Date: Fri, 23 Jul 2004 16:54:26 +0200
From: maximilian attems <janitor@sternwelten.at>
To: linux-ide@vger.kernel.org
Cc: B.Zolnierkiewicz@elka.pw.edu.pl, linux-kernel@vger.kernel.org
Subject: [patch-kj] MIN/MAX removal in ide-timing.h
Message-ID: <20040723145425.GK1795@stro.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I replaced the custom MIN/MAX macros with the type safe min/max macros
from linux/kernel.h.

On Sat, Jul 10, 2004 at 04:03:37PM +0200, Vojtech Pavlik wrote:
> How about if you used the "min_t" and "max_t" macros inside FIT? That
> could help get rid of the casts completely (assuming the second and
> third parameters to FIT are expected to be constants).

Yes, that's better. It reduces the necessary changes to a minimum.

patch applies cleanly to 2.6.8-rc2

From: Clemens Buchacher <drizzd@aon.at>
Signed-off-by: Maximilian Attems <janitor@sternwelten.at>



---

 linux-2.6.7-bk20-max/drivers/ide/ide-timing.h |   25 ++++++++++++-------------
 1 files changed, 12 insertions(+), 13 deletions(-)

diff -puN drivers/ide/ide-timing.h~min-max-ide_ide-timing.h drivers/ide/ide-timing.h
--- linux-2.6.7-bk20/drivers/ide/ide-timing.h~min-max-ide_ide-timing.h	2004-07-11 15:07:01.000000000 +0200
+++ linux-2.6.7-bk20-max/drivers/ide/ide-timing.h	2004-07-11 15:07:01.000000000 +0200
@@ -27,6 +27,7 @@
  * Vojtech Pavlik, Simunkova 1594, Prague 8, 182 00 Czech Republic
  */
 
+#include <linux/kernel.h>
 #include <linux/hdreg.h>
 
 #define XFER_PIO_5		0x0d
@@ -96,11 +97,9 @@ static struct ide_timing ide_timing[] = 
 #define IDE_TIMING_UDMA		0x80
 #define IDE_TIMING_ALL		0xff
 
-#define MIN(a,b)	((a)<(b)?(a):(b))
-#define MAX(a,b)	((a)>(b)?(a):(b))
-#define FIT(v,min,max)	MAX(MIN(v,max),min)
-#define ENOUGH(v,unit)	(((v)-1)/(unit)+1)
-#define EZ(v,unit)	((v)?ENOUGH(v,unit):0)
+#define FIT(v,vmin,vmax)	max_t(short,min_t(short,v,vmax),vmin)
+#define ENOUGH(v,unit)		(((v)-1)/(unit)+1)
+#define EZ(v,unit)		((v)?ENOUGH(v,unit):0)
 
 #define XFER_MODE	0xf0
 #define XFER_UDMA_133	0x48
@@ -188,14 +187,14 @@ static void ide_timing_quantize(struct i
 
 static void ide_timing_merge(struct ide_timing *a, struct ide_timing *b, struct ide_timing *m, unsigned int what)
 {
-	if (what & IDE_TIMING_SETUP  ) m->setup   = MAX(a->setup,   b->setup);
-	if (what & IDE_TIMING_ACT8B  ) m->act8b   = MAX(a->act8b,   b->act8b);
-	if (what & IDE_TIMING_REC8B  ) m->rec8b   = MAX(a->rec8b,   b->rec8b);
-	if (what & IDE_TIMING_CYC8B  ) m->cyc8b   = MAX(a->cyc8b,   b->cyc8b);
-	if (what & IDE_TIMING_ACTIVE ) m->active  = MAX(a->active,  b->active);
-	if (what & IDE_TIMING_RECOVER) m->recover = MAX(a->recover, b->recover);
-	if (what & IDE_TIMING_CYCLE  ) m->cycle   = MAX(a->cycle,   b->cycle);
-	if (what & IDE_TIMING_UDMA   ) m->udma    = MAX(a->udma,    b->udma);
+	if (what & IDE_TIMING_SETUP  ) m->setup   = max(a->setup,   b->setup);
+	if (what & IDE_TIMING_ACT8B  ) m->act8b   = max(a->act8b,   b->act8b);
+	if (what & IDE_TIMING_REC8B  ) m->rec8b   = max(a->rec8b,   b->rec8b);
+	if (what & IDE_TIMING_CYC8B  ) m->cyc8b   = max(a->cyc8b,   b->cyc8b);
+	if (what & IDE_TIMING_ACTIVE ) m->active  = max(a->active,  b->active);
+	if (what & IDE_TIMING_RECOVER) m->recover = max(a->recover, b->recover);
+	if (what & IDE_TIMING_CYCLE  ) m->cycle   = max(a->cycle,   b->cycle);
+	if (what & IDE_TIMING_UDMA   ) m->udma    = max(a->udma,    b->udma);
 }
 
 static struct ide_timing* ide_timing_find_mode(short speed)

_
