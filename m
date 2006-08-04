Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161020AbWHDFrH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161020AbWHDFrH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 01:47:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030347AbWHDFpt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 01:45:49 -0400
Received: from ns2.suse.de ([195.135.220.15]:29616 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1030346AbWHDFpa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 01:45:30 -0400
Date: Thu, 3 Aug 2006 22:40:32 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org,
       Arjan van de Ven <arjan@infradead.org>
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       David Lang <dlang@digitalinsight.com>,
       Andrew de Quincey <adq_dvb@lidskialf.net>,
       Michael Krufky <mkrufky@linuxtv.org>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 19/23] Fix budget-av compile failure
Message-ID: <20060804054032.GT769@kroah.com>
References: <20060804053258.391158155@quad.kroah.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="fix-budget-av-compile-failure.patch"
In-Reply-To: <20060804053807.GA769@kroah.com>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------
From: Andrew de Quincey <adq_dvb@lidskialf.net>

Currently I am doing lots of refactoring work in the dvb tree. This
bugfix became necessary to fix 2.6.17 whilst I was in the middle of this
work. Unfortunately after I tested the original code for the patch, I
generated the diff against the wrong tree (I accidentally used a tree
with part of the refactoring code in it). This resulted in the reported
compile errors because that tree (a) was incomplete, and (b) used
features which are simply not in the mainline kernel yet.

Many apologies for the error and problems this has caused. :(

Signed-off-by: Andrew de Quincey <adq_dvb@lidskialf.net>
Signed-off-by: Michael Krufky <mkrufky@linuxtv.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/media/dvb/ttpci/budget-av.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

--- linux-2.6.17.7.orig/drivers/media/dvb/ttpci/budget-av.c
+++ linux-2.6.17.7/drivers/media/dvb/ttpci/budget-av.c
@@ -58,6 +58,7 @@ struct budget_av {
 	struct tasklet_struct ciintf_irq_tasklet;
 	int slot_status;
 	struct dvb_ca_en50221 ca;
+	u8 reinitialise_demod:1;
 };
 
 /* GPIO Connections:
@@ -214,8 +215,9 @@ static int ciintf_slot_reset(struct dvb_
 	while (--timeout > 0 && ciintf_read_attribute_mem(ca, slot, 0) != 0x1d)
 		msleep(100);
 
-	/* reinitialise the frontend */
-	dvb_frontend_reinitialise(budget_av->budget.dvb_frontend);
+	/* reinitialise the frontend if necessary */
+	if (budget_av->reinitialise_demod)
+		dvb_frontend_reinitialise(budget_av->budget.dvb_frontend);
 
 	if (timeout <= 0)
 	{
@@ -1064,12 +1066,10 @@ static void frontend_init(struct budget_
 		fe = tda10021_attach(&philips_cu1216_config,
 				     &budget_av->budget.i2c_adap,
 				     read_pwm(budget_av));
-		if (fe) {
-			fe->ops.tuner_ops.set_params = philips_cu1216_tuner_set_params;
-		}
 		break;
 
 	case SUBID_DVBC_KNC1_PLUS:
+		budget_av->reinitialise_demod = 1;
 		fe = tda10021_attach(&philips_cu1216_config,
 				     &budget_av->budget.i2c_adap,
 				     read_pwm(budget_av));

--
