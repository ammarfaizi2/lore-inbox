Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261676AbVADOxU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261676AbVADOxU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 09:53:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261675AbVADOxM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 09:53:12 -0500
Received: from [212.20.225.142] ([212.20.225.142]:59925 "EHLO
	orlando.wolfsonmicro.main") by vger.kernel.org with ESMTP
	id S261667AbVADOuo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 09:50:44 -0500
Subject: [PATCH 1/2] AC97 plugin suspend/resume
From: Liam Girdwood <Liam.Girdwood@wolfsonmicro.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: lkml <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-r9GN3GZK6Cf8ELNLcAeA"
Message-Id: <1104850243.9143.333.camel@cearnarfon>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Tue, 04 Jan 2005 14:50:43 +0000
X-OriginalArrivalTime: 04 Jan 2005 14:50:44.0146 (UTC) FILETIME=[C4914120:01C4F26C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-r9GN3GZK6Cf8ELNLcAeA
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This patch adds suspend and resume support to OSS AC97 plugins.

Changes :-

  o added suspend/resume callbacks to struct ac97_driver
  o added suspend/resume handlers to ac97_codec.c

Signed-off-by: Liam Girdwood <liam.girdwood@wolfsonmicro.com>

Liam

--=-r9GN3GZK6Cf8ELNLcAeA
Content-Disposition: attachment; filename=ac97_codec_pm.diff
Content-Type: text/x-patch; name=ac97_codec_pm.diff; charset=
Content-Transfer-Encoding: 7bit

--- a/sound/oss/ac97_codec.c	2004-12-24 21:34:00.000000000 +0000
+++ b/sound/oss/ac97_codec.c	2004-12-08 17:08:42.000000000 +0000
@@ -1391,6 +1421,33 @@
 
 EXPORT_SYMBOL(ac97_restore_state);
 
+int ac97_suspend(struct ac97_codec *codec, int state)
+{
+	struct ac97_driver *driver;
+	int ret = 0;
+
+	down(&codec_sem);
+	driver = codec->driver;
+	if (driver != NULL && driver->suspend)
+		ret = driver->suspend(codec, state);
+	up(&codec_sem);
+
+	return ret;
+}
+EXPORT_SYMBOL(ac97_suspend);
+
+void ac97_resume(struct ac97_codec *codec)
+{
+	struct ac97_driver *driver;
+
+	down(&codec_sem);
+	driver = codec->driver;
+	if (driver != NULL && driver->resume)
+		driver->resume(codec);
+	up(&codec_sem);
+}
+EXPORT_SYMBOL(ac97_resume);
+
 /**
  *	ac97_register_driver	-	register a codec helper
  *	@driver: Driver handler
--- a/include/linux/ac97_codec.h	2004-12-24 21:33:50.000000000 +0000
+++ b/include/linux/ac97_codec.h	2004-12-08 13:28:42.000000000 +0000
@@ -299,6 +300,8 @@
 extern unsigned int ac97_set_dac_rate(struct ac97_codec *codec, unsigned int rate);
 extern int ac97_save_state(struct ac97_codec *codec);
 extern int ac97_restore_state(struct ac97_codec *codec);
+extern int ac97_suspend(struct ac97_codec *codec, int state);
+extern void ac97_resume(struct ac97_codec *codec);
 
 extern struct ac97_codec *ac97_alloc_codec(void);
 extern void ac97_release_codec(struct ac97_codec *codec);
@@ -310,6 +313,8 @@
 	u32 codec_mask;
 	int (*probe) (struct ac97_codec *codec, struct ac97_driver *driver);
 	void (*remove) (struct ac97_codec *codec, struct ac97_driver *driver);
+	int (*suspend) (struct ac97_codec *codec, int state);
+	void (*resume) (struct ac97_codec *codec);
 };
 
 extern int ac97_register_driver(struct ac97_driver *driver);

--=-r9GN3GZK6Cf8ELNLcAeA--

