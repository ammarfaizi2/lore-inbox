Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753073AbWKCEFl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753073AbWKCEFl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 23:05:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753076AbWKCEFc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 23:05:32 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:48843 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1753064AbWKCEE6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 23:04:58 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org,
       =?UTF-8?q?David=20H=E4rdeman?= <david@hardeman.nu>,
       Oliver Endriss <o.endriss@gmx.de>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 2/7] V4L/DVB (4785): Budget-ci: Change DEBIADDR_IR to a
	safer default
Date: Fri, 03 Nov 2006 01:02:13 -0300
Message-id: <20061103040213.PS7698750002@infradead.org>
In-Reply-To: <20061103035925.PS9047100000@infradead.org>
References: <20061103035925.PS9047100000@infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0-1mdv2007.0 
Content-Transfer-Encoding: 8bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: David Härdeman <david@hardeman.nu>

The IR chip has no address decoding, so the IR data is always present in 
the high byte when doing a read from the saa7146 chip. This means that 
the DEBI address used is irrelevant to the IR decoding logic.
DEBI addresses 0x1XXX are mapped to the registers on the CI module 
itself, but only the lowest two bits are actually used (see EN50221, 
section A.2.2.1), meaning that 0x1234 is equivalent to 0x1000 which maps 
to register 0 (the data register). A read from the data register is 
supposed to be preceded by a read from the size register, so some CI 
modules will be confused (the AlphaCrypt CAM will hang completely).
The attached patch changes the address used when reading the IR data to 
use 0x4000 instead. This is the CI version address, which is a safer 
default, works with the AlphaCrypt CAM and matches the behaviour of the 
Windows driver (AFAIK).

Signed-off-by: David Härdeman <david@hardeman.nu>
Signed-off-by: Oliver Endriss <o.endriss@gmx.de>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

 drivers/media/dvb/ttpci/budget-ci.c |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/drivers/media/dvb/ttpci/budget-ci.c b/drivers/media/dvb/ttpci/budget-ci.c
index 2a2e9b4..ac0cecb 100644
--- a/drivers/media/dvb/ttpci/budget-ci.c
+++ b/drivers/media/dvb/ttpci/budget-ci.c
@@ -46,7 +46,14 @@ #include "lnbp21.h"
 #include "bsbe1.h"
 #include "bsru6.h"
 
-#define DEBIADDR_IR		0x1234
+/*
+ * Regarding DEBIADDR_IR:
+ * Some CI modules hang if random addresses are read.
+ * Using address 0x4000 for the IR read means that we
+ * use the same address as for CI version, which should
+ * be a safe default.
+ */
+#define DEBIADDR_IR		0x4000
 #define DEBIADDR_CICONTROL	0x0000
 #define DEBIADDR_CIVERSION	0x4000
 #define DEBIADDR_IO		0x1000

