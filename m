Return-Path: <linux-kernel-owner+w=401wt.eu-S965104AbWLMTxv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965104AbWLMTxv (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 14:53:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965106AbWLMTxv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 14:53:51 -0500
Received: from mx2.suse.de ([195.135.220.15]:53200 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965104AbWLMTxu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 14:53:50 -0500
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: Kay Sievers <kay.sievers@vrfy.org>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 5/14] Driver core: show "initstate" of module
Date: Wed, 13 Dec 2006 11:52:56 -0800
Message-Id: <11660396032350-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.4.4.2
In-Reply-To: <11660395998-git-send-email-greg@kroah.com>
References: <20061213195226.GA6736@kroah.com> <1166039585152-git-send-email-greg@kroah.com> <11660395913232-git-send-email-greg@kroah.com> <11660395951158-git-send-email-greg@kroah.com> <11660395998-git-send-email-greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kay Sievers <kay.sievers@vrfy.org>

Show the initialization state(live, coming, going) of the module:
  $ cat /sys/module/usbcore/initstate
  live

Signed-off-by: Kay Sievers <kay.sievers@vrfy.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 kernel/module.c |   25 +++++++++++++++++++++++++
 1 files changed, 25 insertions(+), 0 deletions(-)

diff --git a/kernel/module.c b/kernel/module.c
index d9eae45..b565eae 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -824,9 +824,34 @@ static inline void module_unload_init(struct module *mod)
 }
 #endif /* CONFIG_MODULE_UNLOAD */
 
+static ssize_t show_initstate(struct module_attribute *mattr,
+			   struct module *mod, char *buffer)
+{
+	const char *state = "unknown";
+
+	switch (mod->state) {
+	case MODULE_STATE_LIVE:
+		state = "live";
+		break;
+	case MODULE_STATE_COMING:
+		state = "coming";
+		break;
+	case MODULE_STATE_GOING:
+		state = "going";
+		break;
+	}
+	return sprintf(buffer, "%s\n", state);
+}
+
+static struct module_attribute initstate = {
+	.attr = { .name = "initstate", .mode = 0444, .owner = THIS_MODULE },
+	.show = show_initstate,
+};
+
 static struct module_attribute *modinfo_attrs[] = {
 	&modinfo_version,
 	&modinfo_srcversion,
+	&initstate,
 #ifdef CONFIG_MODULE_UNLOAD
 	&refcnt,
 #endif
-- 
1.4.4.2

