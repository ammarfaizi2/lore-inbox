Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753064AbWKCEFl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753064AbWKCEFl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 23:05:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753069AbWKCEFa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 23:05:30 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:50379 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1753073AbWKCEFJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 23:05:09 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org, Oliver Endriss <o.endriss@gmx.de>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 6/7] V4L/DVB (4784): [saa7146_i2c] short_delay mode fixed
	for fast machines
Date: Fri, 03 Nov 2006 01:02:14 -0300
Message-id: <20061103040214.PS1889240006@infradead.org>
In-Reply-To: <20061103035925.PS9047100000@infradead.org>
References: <20061103035925.PS9047100000@infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0-1mdv2007.0 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Oliver Endriss <o.endriss@gmx.de>

TT DVB-C 2300 runs at 137 kHz I2C speed. short_delay mode did not work
reliably on fast machines with that speed. Increased max loop count from
20 to 50. Moved dummy access out of the loop.

Signed-off-by: Oliver Endriss <o.endriss@gmx.de>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

 drivers/media/common/saa7146_i2c.c |   10 ++++------
 1 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/media/common/saa7146_i2c.c b/drivers/media/common/saa7146_i2c.c
index d9953f7..5297a36 100644
--- a/drivers/media/common/saa7146_i2c.c
+++ b/drivers/media/common/saa7146_i2c.c
@@ -217,11 +217,9 @@ static int saa7146_i2c_writeout(struct s
 		}
 		/* wait until we get a transfer done or error */
 		timeout = jiffies + HZ/100 + 1; /* 10ms */
+		/* first read usually delivers bogus results... */
+		saa7146_i2c_status(dev);
 		while(1) {
-			/**
-			 *  first read usually delivers bogus results...
-			 */
-			saa7146_i2c_status(dev);
 			status = saa7146_i2c_status(dev);
 			if ((status & 0x3) != 1)
 				break;
@@ -232,10 +230,10 @@ static int saa7146_i2c_writeout(struct s
 				DEB_I2C(("saa7146_i2c_writeout: timed out waiting for end of xfer\n"));
 				return -EIO;
 			}
-			if ((++trial < 20) && short_delay)
+			if (++trial < 50 && short_delay)
 				udelay(10);
 			else
-			msleep(1);
+				msleep(1);
 		}
 	}
 

