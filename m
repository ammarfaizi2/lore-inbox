Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266753AbUI0Q7i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266753AbUI0Q7i (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 12:59:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266813AbUI0Q7i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 12:59:38 -0400
Received: from umhlanga.stratnet.net ([12.162.17.40]:13306 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S266753AbUI0Q7d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 12:59:33 -0400
In-Reply-To: <B33qvfouFeHShDoMHJWh26ey96c@topspin.com>
X-Mailer: roland_patchbomb
Date: Mon, 27 Sep 2004 09:59:30 -0700
Message-Id: <hJgnR3dPmMe8ppFeFKO0pB44tv8@topspin.com>
Mime-Version: 1.0
To: greg@kroah.com, linux-kernel@vger.kernel.org
From: Roland Dreier <roland@topspin.com>
X-SA-Exim-Connect-IP: 127.0.0.1
X-SA-Exim-Mail-From: roland@topspin.com
Subject: [PATCH][1/2] [RESEND] kobject: add HOTPLUG_ENV_VAR
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: Yes (on eddore)
X-OriginalArrivalTime: 27 Sep 2004 16:59:30.0342 (UTC) FILETIME=[5AD7F460:01C4A4B3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add a HOTPLUG_ENV_VAR macro to <linux/kobject.h>.  There's a lot of
boilerplate code involved in setting environment variables in a
hotplug method, so we should have a convenience macro to consolidate
it (and avoid subtle bugs).


Signed-off-by: Roland Dreier <roland@topspin.com>

Index: linux-bk/include/linux/kobject.h
===================================================================
--- linux-bk.orig/include/linux/kobject.h	2004-09-12 15:17:02.000000000 -0700
+++ linux-bk/include/linux/kobject.h	2004-09-12 19:44:31.000000000 -0700
@@ -95,6 +95,20 @@
 			int num_envp, char *buffer, int buffer_size);
 };
 
+#define HOTPLUG_ENV_VAR(_buf, _size, _envp, _nenvp, _index, _fmt, _arg...) \
+	({								\
+		int len, ret = 0;					\
+		_envp[_index++] = _buf;					\
+		len = snprintf(_buf, _size, _fmt, ## _arg);		\
+		if (_size - len <= 0 || _index >= _nenvp)		\
+			ret = -ENOMEM;					\
+		else {							\
+			_buf  += len + 1;				\
+			_size -= len + 1;				\
+		}							\
+		ret;							\
+	})
+
 struct kset {
 	struct subsystem	* subsys;
 	struct kobj_type	* ktype;

