Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262432AbTKPWhW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Nov 2003 17:37:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263053AbTKPWhW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Nov 2003 17:37:22 -0500
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:53165 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S262432AbTKPWhI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Nov 2003 17:37:08 -0500
Subject: Re: [PATCH] Add lib/parser.c kernel-doc
From: Will Dyson <will_dyson@pobox.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
In-Reply-To: <1068970562.19499.11.camel@thalience>
References: <1068970562.19499.11.camel@thalience>
Content-Type: multipart/mixed; boundary="=-K9Tn7CtZKW6FktJiHoiw"
Message-Id: <1069022225.19499.59.camel@thalience>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sun, 16 Nov 2003 17:37:05 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-K9Tn7CtZKW6FktJiHoiw
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sun, 2003-11-16 at 03:16, Will Dyson wrote:
> When I converted befs's option parsing to use the new lib/parser.c
> functions, I had to read the functions (and the patch converting ext3)
> in order to understand exactly how to use them. They are not that
> complicated, but since I'd already read and (hopefully) understood the
> functions, I figured I'd add a bit of documentation for others.
> 
> I am not the author of the functions I am attempting to document here,
> so any mistakes are just that: mistakes on my part.

Here is take 2, incorporating Matthew Wilcox's suggestions and sent as
an attatchment to avoid word-wrap.

-- 
Will Dyson
"Back off man, I'm a scientist!" -Dr. Peter Venkman

--=-K9Tn7CtZKW6FktJiHoiw
Content-Disposition: attachment; filename=fsdoc.patch
Content-Type: text/x-patch; name=fsdoc.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1352  -> 1.1354 
#	        lib/parser.c	1.2     -> 1.4    
#	include/linux/parser.h	1.1     -> 1.3    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/11/16	will@thalience.(none)	1.1353
# Add documentation and comments to lib/parser.c and include/linux/parser.h
# --------------------------------------------
# 03/11/16	will@thalience.(none)	1.1354
# Incorporate fixes/suggestions from Matthew Wilcox
# --------------------------------------------
#
diff -Nru a/include/linux/parser.h b/include/linux/parser.h
--- a/include/linux/parser.h	Sun Nov 16 17:32:10 2003
+++ b/include/linux/parser.h	Sun Nov 16 17:32:10 2003
@@ -1,3 +1,14 @@
+/*
+ * linux/include/linux/parser.h
+ *
+ * Header for lib/parser.c
+ * Intended use of these functions is parsing filesystem argument lists,
+ * but could potentially be used anywhere else that simple option=arg 
+ * parsing is required.
+ */
+
+
+/* associates an integer enumerator with a pattern string. */
 struct match_token {
 	int token;
 	char *pattern;
@@ -5,15 +16,16 @@
 
 typedef struct match_token match_table_t[];
 
+/* Maximum number of arguments that match_token will find in a pattern */
 enum {MAX_OPT_ARGS = 3};
 
+/* Describe the location within a string of a substring */
 typedef struct {
 	char *from;
 	char *to;
 } substring_t;
 
-int match_token(char *s, match_table_t table, substring_t args[]);
-
+int match_token(char *, match_table_t table, substring_t args[]);
 int match_int(substring_t *, int *result);
 int match_octal(substring_t *, int *result);
 int match_hex(substring_t *, int *result);
diff -Nru a/lib/parser.c b/lib/parser.c
--- a/lib/parser.c	Sun Nov 16 17:32:10 2003
+++ b/lib/parser.c	Sun Nov 16 17:32:10 2003
@@ -11,6 +11,17 @@
 #include <linux/slab.h>
 #include <linux/string.h>
 
+/**
+ * match_one: - Determines if a string matches a simple pattern
+ * @s: the string to examine for presense of the pattern
+ * @p: the string containing the pattern
+ * @args: array of %MAX_OPT_ARGS &substring_t elements. Used to return match
+ * locations.
+ *
+ * Description: Determines if the pattern @p is present in string @s. Can only
+ * match extremely simple token=arg style patterns. If the pattern is found,
+ * the location(s) of the arguments will be returned in the @args array.
+ */
 static int match_one(char *s, char *p, substring_t args[])
 {
 	char *meta;
@@ -74,6 +85,20 @@
 	}
 }
 
+/**
+ * match_token: - Find a token (and optional args) in a string
+ * @s: the string to examine for token/argument pairs
+ * @table: match_table_t describing the set of allowed option tokens and the
+ * arguments that may be associated with them. Must be terminated with a
+ * &struct match_token whose pattern is set to the NULL pointer.
+ * @args: array of %MAX_OPT_ARGS &substring_t elements. Used to return match
+ * locations.
+ *
+ * Description: Detects which if any of a set of token strings has been passed
+ * to it. Tokens can include up to MAX_OPT_ARGS instances of basic c-style
+ * format identifiers which will be taken into account when matching the
+ * tokens, and whose locations will be returned in the @args array.
+ */
 int match_token(char *s, match_table_t table, substring_t args[])
 {
 	struct match_token *p;
@@ -84,6 +109,16 @@
 	return p->token;
 }
 
+/**
+ * match_number: scan a number in the given base from a substring_t
+ * @s: substring to be scanned
+ * @result: resulting integer on success
+ * @base: base to use when converting string
+ *
+ * Description: Given a &substring_t and a base, attempts to parse the substring
+ * as a number in that base. On success, sets @result to the integer represented
+ * by the string and returns 0. Returns either -ENOMEM or -EINVAL on failure.
+ */
 static int match_number(substring_t *s, int *result, int base)
 {
 	char *endp;
@@ -103,27 +138,71 @@
 	return ret;
 }
 
+/**
+ * match_int: - scan a decimal representation of an integer from a substring_t
+ * @s: substring_t to be scanned
+ * @result: resulting integer on success
+ *
+ * Description: Attempts to parse the &substring_t @s as a decimal integer. On
+ * success, sets @result to the integer represented by the string and returns 0.
+ * Returns either -ENOMEM or -EINVAL on failure.
+ */
 int match_int(substring_t *s, int *result)
 {
 	return match_number(s, result, 0);
 }
 
+/**
+ * match_octal: - scan an octal representation of an integer from a substring_t
+ * @s: substring_t to be scanned
+ * @result: resulting integer on success
+ *
+ * Description: Attempts to parse the &substring_t @s as an octal integer. On
+ * success, sets @result to the integer represented by the string and returns
+ * 0. Returns either -ENOMEM or -EINVAL on failure.
+ */
 int match_octal(substring_t *s, int *result)
 {
 	return match_number(s, result, 8);
 }
 
+/**
+ * match_hex: - scan a hex representation of an integer from a substring_t
+ * @s: substring_t to be scanned
+ * @result: resulting integer on success
+ *
+ * Description: Attempts to parse the &substring_t @s as a hexadecimal integer.
+ * On success, sets @result to the integer represented by the string and
+ * returns 0. Returns either -ENOMEM or -EINVAL on failure.
+ */
 int match_hex(substring_t *s, int *result)
 {
 	return match_number(s, result, 16);
 }
 
+/**
+ * match_strcpy: - copies the characters from a substring_t to a string
+ * @to: string to copy characters to.
+ * @s: &substring_t to copy
+ *
+ * Description: Copies the set of characters represented by the given
+ * &substring_t @s to the c-style string @to. Caller guarantees that @to is
+ * large enough to hold the characters of @s.
+ */
 void match_strcpy(char *to, substring_t *s)
 {
 	memcpy(to, s->from, s->to - s->from);
 	to[s->to - s->from] = '\0';
 }
 
+/**
+ * match_strdup: - allocate a new string with the contents of a substring_t
+ * @s: &substring_t to copy
+ *
+ * Description: Allocates and returns a string filled with the contents of
+ * the &substring_t @s. The caller is responsible for freeing the returned
+ * string with kfree().
+ */
 char *match_strdup(substring_t *s)
 {
 	char *p = kmalloc(s->to - s->from + 1, GFP_KERNEL);

--=-K9Tn7CtZKW6FktJiHoiw--

