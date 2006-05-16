Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932331AbWEPRqH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932331AbWEPRqH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 13:46:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932462AbWEPRqG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 13:46:06 -0400
Received: from mtagate2.uk.ibm.com ([195.212.29.135]:39686 "EHLO
	mtagate2.uk.ibm.com") by vger.kernel.org with ESMTP id S932449AbWEPRpq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 13:45:46 -0400
Message-ID: <446A0FBE.2030105@de.ibm.com>
Date: Tue, 16 May 2006 19:45:34 +0200
From: Martin Peschke <mp3@de.ibm.com>
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: akpm@osdl.org, ak@suse.de, hch@infradead.org, arjan@infradead.org,
       James.Smart@Emulex.Com, James.Bottomley@SteelEye.com
Subject: [RFC] [Patch 2/8] statistics infrastructure - prerequisite: parser
 enhancement
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds two match_* derivates for 64 bit operands to the parser
library.

Signed-off-by: Martin Peschke <mp3@de.ibm.com>
---

  include/linux/parser.h |    2 +
  lib/parser.c           |   60 +++++++++++++++++++++++++++++++++++++++++++++++++
  2 files changed, 62 insertions(+)

diff -Nurp a/include/linux/parser.h b/include/linux/parser.h
--- a/include/linux/parser.h	2006-03-20 06:53:29.000000000 +0100
+++ b/include/linux/parser.h	2006-05-15 17:56:25.000000000 +0200
@@ -31,3 +31,5 @@ int match_octal(substring_t *, int *resu
  int match_hex(substring_t *, int *result);
  void match_strcpy(char *, substring_t *);
  char *match_strdup(substring_t *);
+int match_u64(substring_t *, u64 *result, int);
+int match_s64(substring_t *, s64 *result, int);
diff -Nurp a/lib/parser.c b/lib/parser.c
--- a/lib/parser.c	2006-03-20 06:53:29.000000000 +0100
+++ b/lib/parser.c	2006-05-15 17:56:25.000000000 +0200
@@ -140,6 +140,64 @@ static int match_number(substring_t *s,
  }

  /**
+ * match_u64: scan a number in the given base from a substring_t
+ * @s: substring to be scanned
+ * @result: resulting integer on success
+ * @base: base to use when converting string
+ *
+ * Description: Given a &substring_t and a base, attempts to parse the substring
+ * as a number in that base. On success, sets @result to the u64 represented
+ * by the string and returns 0. Returns either -ENOMEM or -EINVAL on failure.
+ */
+int match_u64(substring_t *s, u64 *result, int base)
+{
+	char *endp;
+	char *buf;
+	int ret;
+
+	buf = kmalloc(s->to - s->from + 1, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+	memcpy(buf, s->from, s->to - s->from);
+	buf[s->to - s->from] = '\0';
+	*result = simple_strtoull(buf, &endp, base);
+	ret = 0;
+	if (endp == buf)
+		ret = -EINVAL;
+	kfree(buf);
+	return ret;
+}
+
+/**
+ * match_s64: scan a number in the given base from a substring_t
+ * @s: substring to be scanned
+ * @result: resulting integer on success
+ * @base: base to use when converting string
+ *
+ * Description: Given a &substring_t and a base, attempts to parse the substring
+ * as a number in that base. On success, sets @result to the s64 represented
+ * by the string and returns 0. Returns either -ENOMEM or -EINVAL on failure.
+ */
+int match_s64(substring_t *s, s64 *result, int base)
+{
+	char *endp;
+	char *buf;
+	int ret;
+
+	buf = kmalloc(s->to - s->from + 1, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+	memcpy(buf, s->from, s->to - s->from);
+	buf[s->to - s->from] = '\0';
+	*result = simple_strtoll(buf, &endp, base);
+	ret = 0;
+	if (endp == buf)
+		ret = -EINVAL;
+	kfree(buf);
+	return ret;
+}
+
+/**
   * match_int: - scan a decimal representation of an integer from a substring_t
   * @s: substring_t to be scanned
   * @result: resulting integer on success
@@ -218,3 +276,5 @@ EXPORT_SYMBOL(match_octal);
  EXPORT_SYMBOL(match_hex);
  EXPORT_SYMBOL(match_strcpy);
  EXPORT_SYMBOL(match_strdup);
+EXPORT_SYMBOL(match_u64);
+EXPORT_SYMBOL(match_s64);

