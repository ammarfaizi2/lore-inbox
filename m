Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030190AbVLNEtA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030190AbVLNEtA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 23:49:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030363AbVLNEtA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 23:49:00 -0500
Received: from mail.gmx.net ([213.165.64.21]:52440 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1030190AbVLNEs7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 23:48:59 -0500
X-Authenticated: #26200865
Message-ID: <439FA436.50107@gmx.net>
Date: Wed, 14 Dec 2005 05:48:54 +0100
From: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.7.12) Gecko/20050921
X-Accept-Language: de, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Greg KH <greg@kroah.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       stable@kernel.org, acpi-devel <acpi-devel@lists.sourceforge.net>
Subject: [PATCH] Fix oops in asus_acpi.c on Samsung P30/P35 Laptops
References: <4395D945.6080108@gmx.net> <20051206192136.GA22615@kroah.com> <4395F0AB.1080408@gmx.net> <20051208033841.GA25008@kroah.com> <439A23CB.50102@gmx.net>
In-Reply-To: <439A23CB.50102@gmx.net>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, Greg,

please apply the following patch to your trees. It fixes
http://bugzilla.kernel.org/show_bug.cgi?id=5067

The patch has been tested and verified, is shipped in the
SUSE 10.0 kernel and does not cause any regressions.

Unfortunately, the ACPI maintainers have been ignoring
this patch for the last few months despite repeated
requests for review on acpi-devel. I even CCed all ACPI
maintainers personally and didn't receive any response.

Regards,
Carl-Daniel


From: Christian Aichinger <Greek0@gmx.net>
Subject: [PATCH] acpi: Fix oops in asus_acpi.c on Samsung P30/P35 Laptops
Date: 2005-09-23 23:36:25 GMT

Samsung P35's INIT returns an integer (instead of a string or a
plain buffer), which caused an oops when the result was treated as
string in asus_hotk_get_info() (since an invalid pointer got
dereferenced).

This patch explicitly checks for ACPI_TYPE_INTEGER and for the
return values possible on the P30/P35.

Signed-off-by: Christian Aichinger <Greek0@gmx.net>

    drivers/acpi/asus_acpi.c |   31 ++++++++++++++++++++++++++++---
    1 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/asus_acpi.c b/drivers/acpi/asus_acpi.c
--- a/drivers/acpi/asus_acpi.c
+++ b/drivers/acpi/asus_acpi.c
@@ -1006,6 +1006,24 @@ static int __init asus_hotk_get_info(voi
  	}

  	model = (union acpi_object *)buffer.pointer;
+
+	/* INIT on Samsung's P35 returns an integer, possible return
+	 * values are tested below */
+	if (model->type == ACPI_TYPE_INTEGER) {
+		if (model->integer.value == -1 ||
+			model->integer.value == 0x58 ||
+			model->integer.value == 0x38) {
+			hotk->model = P30;
+			printk(KERN_NOTICE
+				       "  Samsung P35 detected, supported\n");
+			goto out_known;
+		} else {
+			printk(KERN_WARNING
+				"  unknown integer returned by INIT\n");
+			goto out_unknown;
+		}
+	}
+
  	if (model->type == ACPI_TYPE_STRING) {
  		printk(KERN_NOTICE "  %s model detected, ",
  		       model->string.pointer);
@@ -1057,9 +1075,7 @@ static int __init asus_hotk_get_info(voi
  		hotk->model = L5x;

  	if (hotk->model == END_MODEL) {
-		printk("unsupported, trying default values, supply the "
-		       "developers with your DSDT\n");
-		hotk->model = M2E;
+		goto out_unknown;
  	} else {
  		printk("supported\n");
  	}
@@ -1088,6 +1104,15 @@ static int __init asus_hotk_get_info(voi
  	acpi_os_free(model);

  	return AE_OK;
+
+out_unknown:
+	printk(KERN_WARNING "  unsupported, trying default values, "
+			"supply the developers with your DSDT\n");
+	hotk->model = M2E;
+out_known:
+	hotk->methods = &model_conf[hotk->model];
+	acpi_os_free(model);
+	return AE_OK;
  }

  static int __init asus_hotk_check(void)

