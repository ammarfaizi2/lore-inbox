Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263441AbTKQJaX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Nov 2003 04:30:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263439AbTKQJaX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Nov 2003 04:30:23 -0500
Received: from sccrmhc11.comcast.net ([204.127.202.55]:59343 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S263435AbTKQJ3b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Nov 2003 04:29:31 -0500
Subject: Re: [PATCH] Add lib/parser.c kernel-doc
From: Will Dyson <will_dyson@pobox.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20031117072822.GO26866@lug-owl.de>
References: <1068970562.19499.11.camel@thalience>
	 <1069022225.19499.59.camel@thalience>  <20031117072822.GO26866@lug-owl.de>
Content-Type: multipart/mixed; boundary="=-+LbQOqvmIeZIpxNKrIfp"
Message-Id: <1069061369.1139.83.camel@thalience>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 17 Nov 2003 04:29:29 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-+LbQOqvmIeZIpxNKrIfp
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, 2003-11-17 at 02:28, Jan-Benedict Glaw wrote:
> On Sun, 2003-11-16 17:37:05 -0500, Will Dyson <will_dyson@pobox.com>
> wrote in message <1069022225.19499.59.camel@thalience>:
> > On Sun, 2003-11-16 at 03:16, Will Dyson wrote:
> 
> > -int match_token(char *s, match_table_t table, substring_t args[]);
> > -
> > +int match_token(char *, match_table_t table, substring_t args[]);
> 
> Dropping the blank line is okay, but I don't like dropping "s"
> altogether:)

Well, I think it should be consistent. My original patch added "s" to
all of the prototypes, on the basis that that is the name given in the
function definition (and a partial misunderstanding of kernel-doc). But
it was pointed out that "s" is highly uninformative as an argument name,
and serves no documentation purpose. So I got rid of it, with the
intention of providing another patch which changes the argument names to
something better.

For what it's worth, however, I didn't realize that the original
match_token had the "s" when I re-diffed the patch earlier. And having
the blank line does make some sense, because match_token is different
from the others.

Got any ideas about how to name that argument in a way that is more
helpful to a developer looking to use the functions? I was thinking 
"char *token" for match_token (because you must tokenize the argument
string before feeding each token to match_token) and "substring_t arg"
for the others.

Here is a(nother) rediff of the kernel-doc patch, changing no prototypes
at all. And also a follow-on that renames the arguments in the manner I
describe in the previous paragraph. Feel free to provide an alternate
renaming patch if you've got a better idea than "token" and "arg".

-- 
Will Dyson
"Back off man, I'm a scientist!" -Dr. Peter Venkman

--=-+LbQOqvmIeZIpxNKrIfp
Content-Disposition: attachment; filename=parser-doc.patch
Content-Type: text/x-patch; name=parser-doc.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1352  -> 1.1355 
#	        lib/parser.c	1.2     -> 1.4    
#	include/linux/parser.h	1.1     -> 1.4    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/11/16	will@thalience.(none)	1.1353
# Add documentation and comments to lib/parser.c and include/linux/parser.h
# --------------------------------------------
# 03/11/16	will@thalience.(none)	1.1354
# Incorporate fixes/suggestions from Matthew Wilcox
# --------------------------------------------
# 03/11/17	will@thalience.(none)	1.1355
# Go back to original prototype
# --------------------------------------------
#
diff -Nru a/include/linux/parser.h b/include/linux/parser.h
--- a/include/linux/parser.h	Mon Nov 17 04:02:55 2003
+++ b/include/linux/parser.h	Mon Nov 17 04:02:55 2003
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
@@ -5,8 +16,10 @@
 
 typedef struct match_token match_table_t[];
 
+/* Maximum number of arguments that match_token will find in a pattern */
 enum {MAX_OPT_ARGS = 3};
 
+/* Describe the location within a string of a substring */
 typedef struct {
 	char *from;
 	char *to;
diff -Nru a/lib/parser.c b/lib/parser.c
--- a/lib/parser.c	Mon Nov 17 04:02:55 2003
+++ b/lib/parser.c	Mon Nov 17 04:02:55 2003
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

--=-+LbQOqvmIeZIpxNKrIfp
Content-Disposition: attachment; filename=parser-arg-rename.patch
Content-Type: text/x-patch; name=parser-arg-rename.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1355  -> 1.1356 
#	        lib/parser.c	1.4     -> 1.5    
#	include/linux/parser.h	1.4     -> 1.5    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/11/17	will@thalience.(none)	1.1356
# change argument names of parser.h functions to be more informative and readable
# --------------------------------------------
#
diff -Nru a/include/linux/parser.h b/include/linux/parser.h
--- a/include/linux/parser.h	Mon Nov 17 04:23:03 2003
+++ b/include/linux/parser.h	Mon Nov 17 04:23:03 2003
@@ -25,10 +25,10 @@
 	char *to;
 } substring_t;
 
-int match_token(char *s, match_table_t table, substring_t args[]);
+int match_token(char *token, match_table_t table, substring_t args[]);
 
-int match_int(substring_t *, int *result);
-int match_octal(substring_t *, int *result);
-int match_hex(substring_t *, int *result);
-void match_strcpy(char *, substring_t *);
-char *match_strdup(substring_t *);
+int match_int(substring_t *arg, int *result);
+int match_octal(substring_t *arg, int *result);
+int match_hex(substring_t *arg, int *result);
+void match_strcpy(char *dest, substring_t *arg);
+char *match_strdup(substring_t *arg);
diff -Nru a/lib/parser.c b/lib/parser.c
--- a/lib/parser.c	Mon Nov 17 04:23:03 2003
+++ b/lib/parser.c	Mon Nov 17 04:23:03 2003
@@ -13,39 +13,39 @@
 
 /**
  * match_one: - Determines if a string matches a simple pattern
- * @s: the string to examine for presense of the pattern
- * @p: the string containing the pattern
+ * @str: the string to examine for presense of the pattern
+ * @pat: the string containing the pattern
  * @args: array of %MAX_OPT_ARGS &substring_t elements. Used to return match
  * locations.
  *
- * Description: Determines if the pattern @p is present in string @s. Can only
- * match extremely simple token=arg style patterns. If the pattern is found,
- * the location(s) of the arguments will be returned in the @args array.
+ * Description: Determines if the pattern @pat is present in string @str. Can
+ * only match extremely simple token=arg style patterns. If the pattern is
+ * found, the location(s) of the arguments will be returned in the @args array.
  */
-static int match_one(char *s, char *p, substring_t args[])
+static int match_one(char *str, char *pat, substring_t args[])
 {
 	char *meta;
 	int argc = 0;
 
-	if (!p)
+	if (!pat)
 		return 1;
 
 	while(1) {
 		int len = -1;
-		meta = strchr(p, '%');
+		meta = strchr(pat, '%');
 		if (!meta)
-			return strcmp(p, s) == 0;
+			return strcmp(pat, str) == 0;
 
-		if (strncmp(p, s, meta-p))
+		if (strncmp(pat, str, meta-pat))
 			return 0;
 
-		s += meta - p;
-		p = meta + 1;
+		str += meta - pat;
+		pat = meta + 1;
 
-		if (isdigit(*p))
-			len = simple_strtoul(p, &p, 10);
-		else if (*p == '%') {
-			if (*s++ != '%')
+		if (isdigit(*pat))
+			len = simple_strtoul(pat, &pat, 10);
+		else if (*pat == '%') {
+			if (*str++ != '%')
 				return 0;
 			continue;
 		}
@@ -53,26 +53,26 @@
 		if (argc >= MAX_OPT_ARGS)
 			return 0;
 
-		args[argc].from = s;
-		switch (*p++) {
+		args[argc].from = str;
+		switch (*pat++) {
 		case 's':
-			if (strlen(s) == 0)
+			if (strlen(str) == 0)
 				return 0;
-			else if (len == -1 || len > strlen(s))
-				len = strlen(s);
-			args[argc].to = s + len;
+			else if (len == -1 || len > strlen(str))
+				len = strlen(str);
+			args[argc].to = str + len;
 			break;
 		case 'd':
-			simple_strtol(s, &args[argc].to, 0);
+			simple_strtol(str, &args[argc].to, 0);
 			goto num;
 		case 'u':
-			simple_strtoul(s, &args[argc].to, 0);
+			simple_strtoul(str, &args[argc].to, 0);
 			goto num;
 		case 'o':
-			simple_strtoul(s, &args[argc].to, 8);
+			simple_strtoul(str, &args[argc].to, 8);
 			goto num;
 		case 'x':
-			simple_strtoul(s, &args[argc].to, 16);
+			simple_strtoul(str, &args[argc].to, 16);
 		num:
 			if (args[argc].to == args[argc].from)
 				return 0;
@@ -80,14 +80,14 @@
 		default:
 			return 0;
 		}
-		s = args[argc].to;
+		str = args[argc].to;
 		argc++;
 	}
 }
 
 /**
  * match_token: - Find a token (and optional args) in a string
- * @s: the string to examine for token/argument pairs
+ * @token: the string to examine for token/argument pair
  * @table: match_table_t describing the set of allowed option tokens and the
  * arguments that may be associated with them. Must be terminated with a
  * &struct match_token whose pattern is set to the NULL pointer.
@@ -99,11 +99,11 @@
  * format identifiers which will be taken into account when matching the
  * tokens, and whose locations will be returned in the @args array.
  */
-int match_token(char *s, match_table_t table, substring_t args[])
+int match_token(char *token, match_table_t table, substring_t args[])
 {
 	struct match_token *p;
 
-	for (p = table; !match_one(s, p->pattern, args) ; p++)
+	for (p = table; !match_one(token, p->pattern, args) ; p++)
 		;
 
 	return p->token;
@@ -111,7 +111,7 @@
 
 /**
  * match_number: scan a number in the given base from a substring_t
- * @s: substring to be scanned
+ * @arg: substring to be scanned
  * @result: resulting integer on success
  * @base: base to use when converting string
  *
@@ -119,17 +119,17 @@
  * as a number in that base. On success, sets @result to the integer represented
  * by the string and returns 0. Returns either -ENOMEM or -EINVAL on failure.
  */
-static int match_number(substring_t *s, int *result, int base)
+static int match_number(substring_t *arg, int *result, int base)
 {
 	char *endp;
 	char *buf;
 	int ret;
 
-	buf = kmalloc(s->to - s->from + 1, GFP_KERNEL);
+	buf = kmalloc(arg->to - arg->from + 1, GFP_KERNEL);
 	if (!buf)
 		return -ENOMEM;
-	memcpy(buf, s->from, s->to - s->from);
-	buf[s->to - s->from] = '\0';
+	memcpy(buf, arg->from, arg->to - arg->from);
+	buf[arg->to - arg->from] = '\0';
 	*result = simple_strtol(buf, &endp, base);
 	ret = 0;
 	if (endp == buf)
@@ -140,74 +140,74 @@
 
 /**
  * match_int: - scan a decimal representation of an integer from a substring_t
- * @s: substring_t to be scanned
+ * @arg: substring_t to be scanned
  * @result: resulting integer on success
  *
- * Description: Attempts to parse the &substring_t @s as a decimal integer. On
+ * Description: Attempts to parse the &substring_t @arg as a decimal integer. On
  * success, sets @result to the integer represented by the string and returns 0.
  * Returns either -ENOMEM or -EINVAL on failure.
  */
-int match_int(substring_t *s, int *result)
+int match_int(substring_t *arg, int *result)
 {
-	return match_number(s, result, 0);
+	return match_number(arg, result, 0);
 }
 
 /**
  * match_octal: - scan an octal representation of an integer from a substring_t
- * @s: substring_t to be scanned
+ * @arg: substring_t to be scanned
  * @result: resulting integer on success
  *
- * Description: Attempts to parse the &substring_t @s as an octal integer. On
+ * Description: Attempts to parse the &substring_t @arg as an octal integer. On
  * success, sets @result to the integer represented by the string and returns
  * 0. Returns either -ENOMEM or -EINVAL on failure.
  */
-int match_octal(substring_t *s, int *result)
+int match_octal(substring_t *arg, int *result)
 {
-	return match_number(s, result, 8);
+	return match_number(arg, result, 8);
 }
 
 /**
  * match_hex: - scan a hex representation of an integer from a substring_t
- * @s: substring_t to be scanned
+ * @arg: substring_t to be scanned
  * @result: resulting integer on success
  *
- * Description: Attempts to parse the &substring_t @s as a hexadecimal integer.
- * On success, sets @result to the integer represented by the string and
- * returns 0. Returns either -ENOMEM or -EINVAL on failure.
+ * Description: Attempts to parse the &substring_t @arg as a hexadecimal
+ * integer. On success, sets @result to the integer represented by the string
+ * and returns 0. Returns either -ENOMEM or -EINVAL on failure.
  */
-int match_hex(substring_t *s, int *result)
+int match_hex(substring_t *arg, int *result)
 {
-	return match_number(s, result, 16);
+	return match_number(arg, result, 16);
 }
 
 /**
  * match_strcpy: - copies the characters from a substring_t to a string
- * @to: string to copy characters to.
- * @s: &substring_t to copy
+ * @dest: string to copy characters to.
+ * @arg: &substring_t to copy
  *
  * Description: Copies the set of characters represented by the given
- * &substring_t @s to the c-style string @to. Caller guarantees that @to is
- * large enough to hold the characters of @s.
+ * &substring_t @arg to the c-style string @to. Caller guarantees that @to is
+ * large enough to hold the characters of @arg.
  */
-void match_strcpy(char *to, substring_t *s)
+void match_strcpy(char *dest, substring_t *arg)
 {
-	memcpy(to, s->from, s->to - s->from);
-	to[s->to - s->from] = '\0';
+	memcpy(dest, arg->from, arg->to - arg->from);
+	to[arg->to - arg->from] = '\0';
 }
 
 /**
  * match_strdup: - allocate a new string with the contents of a substring_t
- * @s: &substring_t to copy
+ * @arg: &substring_t to copy
  *
  * Description: Allocates and returns a string filled with the contents of
- * the &substring_t @s. The caller is responsible for freeing the returned
+ * the &substring_t @arg. The caller is responsible for freeing the returned
  * string with kfree().
  */
-char *match_strdup(substring_t *s)
+char *match_strdup(substring_t *arg)
 {
-	char *p = kmalloc(s->to - s->from + 1, GFP_KERNEL);
+	char *p = kmalloc(arg->to - arg->from + 1, GFP_KERNEL);
 	if (p)
-		match_strcpy(p, s);
+		match_strcpy(p, arg);
 	return p;
 }
 

--=-+LbQOqvmIeZIpxNKrIfp--

