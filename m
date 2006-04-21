Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751371AbWDUWcu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751371AbWDUWcu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 18:32:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751373AbWDUWcu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 18:32:50 -0400
Received: from smtprelay01.ispgateway.de ([80.67.18.13]:48602 "EHLO
	smtprelay01.ispgateway.de") by vger.kernel.org with ESMTP
	id S1751371AbWDUWcu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 18:32:50 -0400
From: Ingo Oeser <ioe-lkml@rameria.de>
To: "Pekka Enberg" <penberg@cs.helsinki.fi>
Subject: Re: [PATCH/RFC] s390: Hypervisor File System
Date: Sat, 22 Apr 2006 00:30:28 +0200
User-Agent: KMail/1.9.1
Cc: "Michael Holzheu" <holzheu@de.ibm.com>, linux-kernel@vger.kernel.org,
       schwidefsky@de.ibm.com
References: <20060421133541.37002378.holzheu@de.ibm.com> <84144f020604210742j69222654s5ec68f34ea96999c@mail.gmail.com>
In-Reply-To: <84144f020604210742j69222654s5ec68f34ea96999c@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604220030.29214.ioe-lkml@rameria.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pekka, 

On Friday, 21. April 2006 16:42, Pekka Enberg wrote:
> On 4/21/06, Michael Holzheu <holzheu@de.ibm.com> wrote:
> > diff -urpN linux-2.6.16/fs/hypfs/hypfs.h linux-2.6.16-hypfs/fs/hypfs/hypfs.h
> > --- linux-2.6.16/fs/hypfs/hypfs.h	1970-01-01 01:00:00.000000000 +0100
> > +++ linux-2.6.16-hypfs/fs/hypfs/hypfs.h	2006-04-21 12:56:58.000000000 +0200
> > +static void inline remove_trailing_blanks(char *string)
> > +{
> > +	char *ptr;
> > +	for (ptr = string + strlen(string) - 1; ptr > string; ptr--) {
> > +		if (*ptr == ' ')
> > +			*ptr = 0;
> > +		else
> > +			break;
> > +	}
> > +}
> 
> Please consider moving this to lib/string.c and perhaps renaming it to
> strstrip().

Nearly.

- Just return the *ptr and let the caller modify the string.
- Take a string with characters to reject

Reasons: 
	- string might be read only
	- caller wants to copy it anyway
	- string might be a substring or sth. we like to parse further
	- Symmetry with strchr()

Otherwise it is a very good idea implemented in a patch similiar to this
untested one below against Linus' current tree.

use case would be:
char *s = strltrim(string, " \t");
char *e = strrtrim(s, " \t\n\r");
*e = '\0';

Regards

Ingo Oeser
----

diff --git a/include/linux/string.h b/include/linux/string.h
index c61306d..fc90a70 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -68,6 +68,12 @@ extern __kernel_size_t strnlen(const cha
 #ifndef __HAVE_ARCH_STRPBRK
 extern char * strpbrk(const char *,const char *);
 #endif
+#ifndef __HAVE_ARCH_STRLTRIM
+extern char * strltrim(const char *,const char *);
+#endif
+#ifndef __HAVE_ARCH_STRRTRIM
+extern char * strrtrim(const char *,const char *);
+#endif
 #ifndef __HAVE_ARCH_STRSEP
 extern char * strsep(char **,const char *);
 #endif
diff --git a/lib/string.c b/lib/string.c
index 064f631..4bdcd5e 100644
--- a/lib/string.c
+++ b/lib/string.c
@@ -408,6 +408,55 @@ char *strpbrk(const char *cs, const char
 EXPORT_SYMBOL(strpbrk);
 #endif
 
+#ifndef __HAVE_ARCH_STRLTRIM
+/**
+ * strltrim - Get pointer to first character of @s which is
+ * 	not contained in letters in @reject
+ * @s: The string to be searched
+ * @reject: The string of letters to avoid
+ */
+char *strltrim(const char *s, const char *reject)
+{
+	const char *p;
+	const char *r;
+
+	for (p = s; p != '\0'; ++p) {
+		for (r = reject; *r != '\0'; ++r) {
+			if (*p == *r)
+				continue;
+		}
+		return (char *)p;
+	}
+	return (char *)s;
+}
+EXPORT_SYMBOL(strltrim);
+#endif
+
+#ifndef __HAVE_ARCH_STRRTRIM
+/**
+ * strrtrim - Get pointer to last character of @s which is
+ * 	not contained in letters in @reject
+ * @s: The string to be searched
+ * @reject: The string of letters to avoid
+ */
+char *strrtrim(const char *s, const char *reject)
+{
+	const char *end = s + strlen(s);
+	const char *p;
+	const char *r;
+
+	for (p = end - 1; s <= p; --p) {
+		for (r = reject; *r != '\0'; ++r) {
+			if (*p == *r)
+				continue;
+		}
+		return (char *)p;
+	}
+	return (char *)end;
+}
+EXPORT_SYMBOL(strrtrim);
+#endif
+
 #ifndef __HAVE_ARCH_STRSEP
 /**
  * strsep - Split a string into tokens
