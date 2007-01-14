Return-Path: <linux-kernel-owner+w=401wt.eu-S1750861AbXANA7m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750861AbXANA7m (ORCPT <rfc822;w@1wt.eu>);
	Sat, 13 Jan 2007 19:59:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750917AbXANA7m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Jan 2007 19:59:42 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:50884 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750861AbXANA7l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Jan 2007 19:59:41 -0500
Subject: [patch 00/12] Fix ppc64's writing to struct file_operations
From: Arjan van de Ven <arjan@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org
In-Reply-To: <1168735868.3123.315.camel@laptopd505.fenrus.org>
References: <1168735868.3123.315.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Organization: Intel International BV
Date: Sat, 13 Jan 2007 16:51:45 -0800
Message-Id: <1168735914.3123.317.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-2.fc6) 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arjan van de Ven <arjan@linux.intel.com>
Subject: [patch 00/12] Fix ppc64's writing to struct file_operations

the ppc64 code needlessly wrote to a struct file_operations variable;
this patch turns this into a compile time initialization instead.


Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>

Index: linux-2.6/arch/powerpc/kernel/lparcfg.c
===================================================================
--- linux-2.6.orig/arch/powerpc/kernel/lparcfg.c
+++ linux-2.6/arch/powerpc/kernel/lparcfg.c
@@ -570,6 +570,7 @@ static int lparcfg_open(struct inode *in
 struct file_operations lparcfg_fops = {
 	.owner		= THIS_MODULE,
 	.read		= seq_read,
+	.write		= lparcfg_write,
 	.open		= lparcfg_open,
 	.release	= single_release,
 };
@@ -581,10 +582,8 @@ int __init lparcfg_init(void)
 
 	/* Allow writing if we have FW_FEATURE_SPLPAR */
 	if (firmware_has_feature(FW_FEATURE_SPLPAR) &&
-			!firmware_has_feature(FW_FEATURE_ISERIES)) {
-		lparcfg_fops.write = lparcfg_write;
+			!firmware_has_feature(FW_FEATURE_ISERIES))
 		mode |= S_IWUSR;
-	}
 
 	ent = create_proc_entry("ppc64/lparcfg", mode, NULL);
 	if (ent) {


