Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751413AbWDYIBg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751413AbWDYIBg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 04:01:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932136AbWDYIBg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 04:01:36 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:18921 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP
	id S1751413AbWDYIBg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 04:01:36 -0400
Subject: Re: [PATCH/RFC] s390: Hypervisor File System
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: Andrew Morton <akpm@osdl.org>
Cc: holzheu@de.ibm.com, ioe-lkml@rameria.de, linux-kernel@vger.kernel.org,
       mschwid2@de.ibm.com, joern@wohnheim.fh-wedel.de
In-Reply-To: <20060425004736.451644bb.akpm@osdl.org>
References: <20060424191941.7aa6412a.holzheu@de.ibm.com>
	 <1145948304.11463.5.camel@localhost> <1145950336.11463.8.camel@localhost>
	 <20060425004736.451644bb.akpm@osdl.org>
Date: Tue, 25 Apr 2006 11:01:33 +0300
Message-Id: <1145952094.11463.12.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution 2.4.2.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pekka Enberg <penberg@cs.helsinki.fi> wrote:
> > +#ifndef __HAVE_ARCH_STRSTRIP
> >  +extern char * strstrip(char *);
> >  +#endif

On Tue, 2006-04-25 at 00:47 -0700, Andrew Morton wrote:
> Do we really need this gunk?  It's not as if strstrip() is so super
> performance-sensitive that anyone would go and write a hand-tuned assembly
> version?

I guess not. I added it for consistency, but whatever makes you happy
Andrew :)

			Pekka

diff --git a/include/linux/string.h b/include/linux/string.h
index c61306d..e4c7558 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -56,6 +56,7 @@ #endif
 #ifndef __HAVE_ARCH_STRRCHR
 extern char * strrchr(const char *,int);
 #endif
+extern char * strstrip(char *);
 #ifndef __HAVE_ARCH_STRSTR
 extern char * strstr(const char *,const char *);
 #endif
diff --git a/lib/string.c b/lib/string.c
index 064f631..6307726 100644
--- a/lib/string.c
+++ b/lib/string.c
@@ -301,6 +301,36 @@ char *strnchr(const char *s, size_t coun
 EXPORT_SYMBOL(strnchr);
 #endif
 
+/**
+ * strstrip - Removes leading and trailing whitespace from @s.
+ * @s: The string to be stripped.
+ *
+ * Note that the first trailing whitespace is replaced with a %NUL-terminator
+ * in the given string @s. Returns a pointer to the first non-whitespace
+ * character in @s.
+ */
+char *strstrip(char *s)
+{
+	size_t size;
+	char *end;
+
+	size = strlen(s);
+
+	if (!size)
+		return s;
+
+	end = s + size - 1;
+	while (end != s && isspace(*end))
+		end--;
+	*(end + 1) = '\0';
+
+	while (*s && isspace(*s))
+		s++;
+
+	return s;
+}
+EXPORT_SYMBOL(strstrip);
+
 #ifndef __HAVE_ARCH_STRLEN
 /**
  * strlen - Find the length of a string


