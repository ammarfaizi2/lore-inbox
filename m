Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750815AbWI2WWx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750815AbWI2WWx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 18:22:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750827AbWI2WWx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 18:22:53 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:64804 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1750815AbWI2WWw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 18:22:52 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=daHAr41K+14N3G9OrgrAA5DP1H59eDQXU7fPSHcr549CuCPqq40WiFCQRxqyBh5oT6t+FjjXLLcKm/aKdEJ4vH7ldooC8FgKTnDE98IwyMZgfa4vtsLkqkcpIxNLoIB/ABKy7VQZj5GmmBIQYF8S9dCC0XpukubzfzTG4kXHF/M=
Date: Sat, 30 Sep 2006 02:24:28 +0400
From: "Eugeny S. Mints" <eugeny.mints@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: linux-pm@lists.osdl.org, matt@nomadgs.com, amit.kucheria@nokia.com,
       igor.stoppa@nokia.com, ext-Tuukka.Tikkanen@nokia.com
Subject: [RFC] OMAP1 PM Core,  Platform Power Parameter 1/2
Message-Id: <20060930022428.e27d4c53.eugeny.mints@gmail.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.15; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Basic building block for PM Core layer is platform power parameter concept. A platform power parameter is a name, get and set methods.  

Although an PM Core implementation is completely arch specific any PM Core is
supposed to utilize platform power parameter concept.

Also any PM Core is supposed to export names of all platform power parameters
available on a platform. Any entity which registeres operating points is primary
consumer of platform_pwr_param_get_names() interface.

(Probably this interface routine might be moved to be a part of PowerOP Core 
interface)

diff --git a/include/linux/plat_pwr_param.h b/include/linux/plat_pwr_param.h
new file mode 100644
index 0000000..3a78d2b
--- /dev/null
+++ b/include/linux/plat_pwr_param.h
@@ -0,0 +1,27 @@
+/*
+ * Interface to the list of platfrom power parameter names available on a
+ * platform
+ *
+ * Author: Eugeny S. Mints <eugeny@nomadgs.com>
+ *
+ * 2006 (c) Nomad Global Solutions, Inc. This file is licensed under
+ * the terms of the GNU General Public License version 2. This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ *
+ * This is used by an operating point registration entity/module 
+ */
+
+#ifndef __PLAT_PWR_PARAM_H__
+#define __PLAT_PWR_PARAM_H__
+
+/* 
+ * FIXME: for struct attribute; may be we need get rid of sysfs header 
+ * dependency
+ */
+#include <linux/sysfs.h>
+
+int
+platform_pwr_param_get_names(struct attribute ***platform_pwr_params_names);
+
+#endif /*__PLAT_PWR_PARAM_H__*/
diff --git a/include/linux/pm_core.h b/include/linux/pm_core.h
new file mode 100644
index 0000000..a166bc5
--- /dev/null
+++ b/include/linux/pm_core.h
@@ -0,0 +1,46 @@
+/*
+ * Generic platform power parameter interface 
+ *
+ * Author: Eugeny S. Mints <eugeny@nomadgs.com>
+ *
+ * 2006 (c) Nomad Global Solutions, Inc. This file is licensed under
+ * the terms of the GNU General Public License version 2. This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ *
+ * This _arch_ _independent_ header defines concept of platform power parameter
+ * to be used by any PM Core layer arch specific implementation
+ *
+ * NOTE: this header is designed to be included by PM Core implementations only
+ */
+
+#ifndef __PM_CORE_H__
+#define __PM_CORE_H__
+
+/* 
+ * FIXME: for struct attribute; may be we need get rid of sysfs header 
+ * dependency
+ */
+#include <linux/sysfs.h>
+
+struct platform_pwr_param {
+	struct attribute attr;
+	int  (*show) (void *md_opt, int *value);
+	void (*store) (void *md_opt, int value);
+};
+
+#define platform_pwr_param_init(_name) \
+static struct platform_pwr_param _name##_attr = { \
+	.attr   = {				\
+		.name = __stringify(_name),	\
+		.mode = 0644,			\
+		.owner = THIS_MODULE,		\
+	},					\
+	.show   = _name##_show,			\
+	.store  = _name##_store,		\
+}
+
+#define to_platform_pwr_param(_attr) container_of((_attr), \
+	struct platform_pwr_param, attr)
+
+#endif /*__PM_CORE_H__*/
