Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265847AbUIMDJj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265847AbUIMDJj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 23:09:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265900AbUIMDJj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 23:09:39 -0400
Received: from umhlanga.stratnet.net ([12.162.17.40]:53105 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S265847AbUIMDJ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 23:09:27 -0400
Subject: [PATCH][1/2] kobject: add HOTPLUG_ENV_VAR
In-Reply-To: <10950449652770@topspin.com>
X-Mailer: roland_patchbomb
Date: Sun, 12 Sep 2004 20:09:25 -0700
Message-Id: <10950449652309@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: greg@kroah.com, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Roland Dreier <roland@topspin.com>
X-OriginalArrivalTime: 13 Sep 2004 03:09:25.0935 (UTC) FILETIME=[13520BF0:01C4993F]
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
 
+#define HOTPLUG_ENV_VAR(_buf, _size, _envp, _nenvp, _index, _fmt, ...)	\
+	({								\
+		int len, ret = 0;					\
+		_envp[_index++] = _buf;					\
+		len = snprintf(_buf, _size, _fmt, ## __VA_ARGS__);	\
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

