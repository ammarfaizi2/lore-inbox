Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262809AbVFVGWj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262809AbVFVGWj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 02:22:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262815AbVFVGUa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 02:20:30 -0400
Received: from mail.kroah.org ([69.55.234.183]:40092 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262808AbVFVFWJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 01:22:09 -0400
Cc: tnt@246tNt.com
Subject: [PATCH] i2c: Race fix for i2c-mpc.c
In-Reply-To: <11194174663452@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 21 Jun 2005 22:17:46 -0700
Message-Id: <11194174662120@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] i2c: Race fix for i2c-mpc.c

i2c: Race fix for i2c-mpc.c

The problem was that the clock speed and driver data is
initialized after the i2c adapter was added. This caused
the i2c bus to start working at a wrong speed. (Mostly
noticable on the second bus on mpc5200)

With this patch we've tried to keep the i2c adapter
working perfectly all the time it is included in the system.
Initialize before added, Remove garbage after deleleted.

Submitted-by: Asier Llano Palacios
Signed-off-by: Sylvain Munaut <tnt@246tNt.com>
Signed-off-by: Kumar Gala <kumar.gala@freescale.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 7f02d56e54f2a8afaa01974df650ace9dc15d0cd
tree dd39ab530763bfb2f34e84c83d469199e53fc8b0
parent d68a861d857c11a017a8f755fa250afaf8b1bcdb
author Sylvain Munaut <tnt@246tNt.com> Wed, 18 May 2005 19:39:57 +0200
committer Greg Kroah-Hartman <gregkh@suse.de> Tue, 21 Jun 2005 21:52:01 -0700

 drivers/i2c/busses/i2c-mpc.c |   14 ++++++++------
 1 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/i2c/busses/i2c-mpc.c b/drivers/i2c/busses/i2c-mpc.c
--- a/drivers/i2c/busses/i2c-mpc.c
+++ b/drivers/i2c/busses/i2c-mpc.c
@@ -333,6 +333,9 @@ static int __devinit mpc_i2c_probe(struc
 	} else
 		i2c->irq = 0;
 
+	mpc_i2c_setclock(i2c);
+	ocp_set_drvdata(ocp, i2c);
+
 	i2c->adap = mpc_ops;
 	i2c_set_adapdata(&i2c->adap, i2c);
 
@@ -341,8 +344,6 @@ static int __devinit mpc_i2c_probe(struc
 		goto fail_add;
 	}
 
-	mpc_i2c_setclock(i2c);
-	ocp_set_drvdata(ocp, i2c);
 	return result;
 
       fail_add:
@@ -358,8 +359,8 @@ static int __devinit mpc_i2c_probe(struc
 static void __devexit mpc_i2c_remove(struct ocp_device *ocp)
 {
 	struct mpc_i2c *i2c = ocp_get_drvdata(ocp);
-	ocp_set_drvdata(ocp, NULL);
 	i2c_del_adapter(&i2c->adap);
+	ocp_set_drvdata(ocp, NULL);
 
 	if (ocp->def->irq != OCP_IRQ_NA)
 		free_irq(i2c->irq, i2c);
@@ -430,6 +431,9 @@ static int fsl_i2c_probe(struct device *
 			goto fail_irq;
 		}
 
+	mpc_i2c_setclock(i2c);
+	dev_set_drvdata(device, i2c);
+
 	i2c->adap = mpc_ops;
 	i2c_set_adapdata(&i2c->adap, i2c);
 	i2c->adap.dev.parent = &pdev->dev;
@@ -438,8 +442,6 @@ static int fsl_i2c_probe(struct device *
 		goto fail_add;
 	}
 
-	mpc_i2c_setclock(i2c);
-	dev_set_drvdata(device, i2c);
 	return result;
 
       fail_add:
@@ -456,8 +458,8 @@ static int fsl_i2c_remove(struct device 
 {
 	struct mpc_i2c *i2c = dev_get_drvdata(device);
 
-	dev_set_drvdata(device, NULL);
 	i2c_del_adapter(&i2c->adap);
+	dev_set_drvdata(device, NULL);
 
 	if (i2c->irq != 0)
 		free_irq(i2c->irq, i2c);

