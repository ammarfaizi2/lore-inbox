Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030701AbWF0EnR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030701AbWF0EnR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 00:43:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030710AbWF0EnN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 00:43:13 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:58843 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S1030704AbWF0EnE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 00:43:04 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 11/13] [Suspend2] snprintf_used function
Date: Tue, 27 Jun 2006 14:43:03 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060627044302.15066.32228.stgit@nigel.suspend2.net>
In-Reply-To: <20060627044226.15066.7403.stgit@nigel.suspend2.net>
References: <20060627044226.15066.7403.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The normal snprintf function tells you how many characters would have been
appended to a buffer if it was large enough. For Suspend2, we want to know
how many characters were actually added. This variant of the routine does
that.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 include/linux/kernel.h |    2 ++
 lib/vsprintf.c         |   23 +++++++++++++++++++++++
 2 files changed, 25 insertions(+), 0 deletions(-)

diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index f4fc576..5e99865 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -108,6 +108,8 @@ extern int vsprintf(char *buf, const cha
 	__attribute__ ((format (printf, 2, 0)));
 extern int snprintf(char * buf, size_t size, const char * fmt, ...)
 	__attribute__ ((format (printf, 3, 4)));
+extern int snprintf_used(char *buffer, int buffer_size,
+		const char *fmt, ...);
 extern int vsnprintf(char *buf, size_t size, const char *fmt, va_list args)
 	__attribute__ ((format (printf, 3, 0)));
 extern int scnprintf(char * buf, size_t size, const char * fmt, ...)
diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index b07db5c..fccee2c 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -236,6 +236,29 @@ static char * number(char * buf, char * 
 	return buf;
 }
 
+/*
+ * vsnprintf_used
+ *
+ * Functionality    : Print a string with parameters to a buffer of a 
+ *                    limited size. Unlike vsnprintf, we return the number
+ *                    of bytes actually put in the buffer, not the number
+ *                    that would have been put in if it was big enough.
+ */
+int snprintf_used(char *buffer, int buffer_size, const char *fmt, ...)
+{
+	int result;
+	va_list args;
+
+	if (!buffer_size)
+		return 0;
+
+	va_start(args, fmt);
+	result = vsnprintf(buffer, buffer_size, fmt, args);
+	va_end(args);
+
+	return result > buffer_size ? buffer_size : result;
+}
+
 /**
  * vsnprintf - Format a string and place it in a buffer
  * @buf: The buffer to place the result into

--
Nigel Cunningham		nigel at suspend2 dot net
