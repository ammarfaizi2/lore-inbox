Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751408AbWFUAbq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751408AbWFUAbq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 20:31:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751880AbWFUAbq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 20:31:46 -0400
Received: from gw.goop.org ([64.81.55.164]:53948 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S1751408AbWFUAbo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 20:31:44 -0400
Message-ID: <44989376.1030908@goop.org>
Date: Tue, 20 Jun 2006 17:31:50 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060613)
MIME-Version: 1.0
To: "Randy.Dunlap" <rdunlap@xenotime.net>
CC: linux-kernel@vger.kernel.org, akpm@osdl.org,
       Christian.Limpach@cl.cam.ac.uk, chrisw@sous-sol.org
Subject: Re: [PATCH] Implement kasprintf
References: <44988B5C.9080400@goop.org>	<20060620171020.301add23.rdunlap@xenotime.net>	<44988F7F.2010502@goop.org> <20060620172600.9294cd00.rdunlap@xenotime.net>
In-Reply-To: <20060620172600.9294cd00.rdunlap@xenotime.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy.Dunlap wrote:
> Doesn't this already add the bloat/code? ::
>   
Yup.  My back-of-the-mind unexamined assumption was that this was going 
into a .a, which it isn't.

Updated patch below.

    J


--

From: Jeremy Fitzhardinge <jeremy@xensource.com>

Implement kasprintf, a kernel version of asprintf.  This allocates the
memory required for the formatted string, including the trailing '\0'.
Returns NULL on allocation failure.

Signed-off-by: Jeremy Fitzhardinge <jeremy@xensource.com>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>

---
 include/linux/kernel.h |    2 ++
 lib/vsprintf.c         |   23 +++++++++++++++++++++++
 2 files changed, 25 insertions(+)


diff -r cd45ea4bb813 include/linux/kernel.h
--- a/include/linux/kernel.h	Tue Jun 20 17:28:16 2006 -0700
+++ b/include/linux/kernel.h	Tue Jun 20 17:29:18 2006 -0700
@@ -114,6 +114,8 @@ extern int scnprintf(char * buf, size_t 
 	__attribute__ ((format (printf, 3, 4)));
 extern int vscnprintf(char *buf, size_t size, const char *fmt, va_list args)
 	__attribute__ ((format (printf, 3, 0)));
+extern char *kasprintf(gfp_t gfp, const char *fmt, ...)
+	__attribute__ ((format (printf, 2, 3)));
 
 extern int sscanf(const char *, const char *, ...)
 	__attribute__ ((format (scanf, 2, 3)));
diff -r cd45ea4bb813 lib/vsprintf.c
--- a/lib/vsprintf.c	Tue Jun 20 17:28:16 2006 -0700
+++ b/lib/vsprintf.c	Tue Jun 20 17:29:18 2006 -0700
@@ -849,3 +849,26 @@ int sscanf(const char * buf, const char 
 }
 
 EXPORT_SYMBOL(sscanf);
+
+
+/* Simplified asprintf. */
+char *kasprintf(gfp_t gfp, const char *fmt, ...)
+{
+	va_list ap;
+	unsigned int len;
+	char *p;
+
+	va_start(ap, fmt);
+	len = vsnprintf(NULL, 0, fmt, ap);
+	va_end(ap);
+
+	p = kmalloc(len+1, gfp);
+	if (!p)
+		return NULL;
+	va_start(ap, fmt);
+	vsnprintf(p, len+1, fmt, ap);
+	va_end(ap);
+	return p;
+}
+
+EXPORT_SYMBOL(kasprintf);


