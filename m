Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263511AbVCEAnw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263511AbVCEAnw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 19:43:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263491AbVCEAi6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 19:38:58 -0500
Received: from palrel12.hp.com ([156.153.255.237]:24547 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S263427AbVCEA2e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 19:28:34 -0500
Date: Fri, 4 Mar 2005 16:28:13 -0800
To: "David S. Miller" <davem@davemloft.net>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6 IrDA] arbitrary lsap connect
Message-ID: <20050305002813.GF23895@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ir261_connect_lsap-2.diff :
~~~~~~~~~~~~~~~~~~~~~~~~~
		<Original patch from Iavor Fetvadjie>
	o [FEATURE] allow IrDA socket to connect on arbitrary LSAPs
Signed-off-by: Jean Tourrilhes <jt@hpl.hp.com>


diff -u -p linux/net/irda/af_irda.d0.c linux/net/irda/af_irda.c
--- linux/net/irda/af_irda.d0.c	Fri Feb  4 14:45:33 2005
+++ linux/net/irda/af_irda.c	Fri Feb  4 15:16:26 2005
@@ -1012,11 +1012,23 @@ static int irda_connect(struct socket *s
 		self->daddr = addr->sir_addr;
 		IRDA_DEBUG(1, "%s(), daddr = %08x\n", __FUNCTION__, self->daddr);
 
-		/* Query remote LM-IAS */
-		err = irda_find_lsap_sel(self, addr->sir_name);
-		if (err) {
-			IRDA_DEBUG(0, "%s(), connect failed!\n", __FUNCTION__);
-			return err;
+		/* If we don't have a valid service name, we assume the
+		 * user want to connect on a specific LSAP. Prevent
+		 * the use of invalid LSAPs (IrLMP 1.1 p10). Jean II */
+		if((addr->sir_name[0] != '\0') ||
+		   (addr->sir_lsap_sel >= 0x70)) {
+			/* Query remote LM-IAS using service name */
+			err = irda_find_lsap_sel(self, addr->sir_name);
+			if (err) {
+				IRDA_DEBUG(0, "%s(), connect failed!\n", __FUNCTION__);
+				return err;
+			}
+		} else {
+			/* Directly connect to the remote LSAP
+			 * specified by the sir_lsap field.
+			 * Please use with caution, in IrDA LSAPs are
+			 * dynamic and there is no "well-known" LSAP. */
+			self->dtsap_sel = addr->sir_lsap_sel;
 		}
 	}
 
