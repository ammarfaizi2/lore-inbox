Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751235AbWFFLLJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751235AbWFFLLJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 07:11:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751237AbWFFLLI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 07:11:08 -0400
Received: from wx-out-0102.google.com ([66.249.82.198]:53140 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751235AbWFFLLD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 07:11:03 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=hVBXEhvN9CWoMfvNgvATeOM4m3EAwZoUiIRiO5HJK3bHVjP2BE5cb5I5Y+pfQz95Xc90bfbio71+OGZ5NqHKImRGP+NXuBu9KyvAtc5po0i8jPRbMBhRZNweJqLVJG/pBaqsMRxtbsSZ34N1g/+/UaDdREjTTYF1eewQ6a9Qt6I=
Message-ID: <44856247.8090405@gmail.com>
Date: Tue, 06 Jun 2006 19:08:55 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: [PATCH 5/7] Detaching fbcon: Clean up exit code
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

To detach fbcon, it must also clean up all resources it allocated. This was
never done before because fbcon cannot be unloaded. 

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 drivers/video/console/fbcon.c |   43 +++++++++++++++++++++++++++++++++++++++++
 1 files changed, 43 insertions(+), 0 deletions(-)

diff --git a/drivers/video/console/fbcon.c b/drivers/video/console/fbcon.c
index 014afea..a8de822 100644
--- a/drivers/video/console/fbcon.c
+++ b/drivers/video/console/fbcon.c
@@ -3112,6 +3112,49 @@ static void __exit fbcon_deinit_class_de
 
 static void __exit fbcon_exit(void)
 {
+	struct fb_info *info;
+	int i, j, mapped;
+
+	for (i = 0; i < FB_MAX; i++) {
+		info = registered_fb[i];
+
+		if (info && info->fbcon_par)
+			fbcon_del_cursor_timer(info);
+	}
+
+#ifdef CONFIG_ATARI
+	free_irq(IRQ_AUTO_4, fbcon_vbl_handler);
+#endif
+#ifdef CONFIG_MAC
+	if (MACH_IS_MAC && vbl_detected)
+		free_irq(IRQ_MAC_VBL, fbcon_vbl_handler);
+#endif
+
+	kfree((void *)softback_buf);
+
+	for (i = 0; i < FB_MAX; i++) {
+		mapped = 0;
+		info = registered_fb[i];
+
+		if (info == NULL)
+			continue;
+
+		for (j = 0; j < MAX_NR_CONSOLES; j++) {
+			if (con2fb_map[j] == i) {
+				con2fb_map[j] = -1;
+				mapped = 1;
+			}
+		}
+
+		if (mapped) {
+			if (info->fbops->fb_release)
+				info->fbops->fb_release(info, 0);
+			module_put(info->fbops->owner);
+			kfree(info->fbcon_par);
+			info->fbcon_par = NULL;
+		}
+	}
+
 	fbcon_deinit_class_device();
 	class_device_destroy(fb_class, MKDEV(FB_MAJOR, FB_MAX));
 }



