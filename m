Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751379AbWDYHcT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751379AbWDYHcT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 03:32:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751395AbWDYHcT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 03:32:19 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:54503 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP
	id S1751379AbWDYHcS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 03:32:18 -0400
Subject: Re: [PATCH/RFC] s390: Hypervisor File System
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: Michael Holzheu <holzheu@de.ibm.com>
Cc: ioe-lkml@rameria.de, linux-kernel@vger.kernel.org, mschwid2@de.ibm.com,
       joern@wohnheim.fh-wedel.de
In-Reply-To: <1145948304.11463.5.camel@localhost>
References: <20060424191941.7aa6412a.holzheu@de.ibm.com>
	 <1145948304.11463.5.camel@localhost>
Date: Tue, 25 Apr 2006 10:32:16 +0300
Message-Id: <1145950336.11463.8.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution 2.4.2.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-04-24 at 19:19 +0200, Michael Holzheu wrote:
> > +#ifndef __HAVE_ARCH_STRRTRIM
> > +/**
> > + * strrtrim - Remove trailing characters specified in @reject
> > + * @s: The string to be searched
> > + * @reject: The string of letters to avoid
> > + */
> > +void strrtrim(char *s, const char *reject)

On Tue, 2006-04-25 at 09:58 +0300, Pekka Enberg wrote:
> I think this should return s to be consistent with other string API
> functions.

Hmm, thinking about this, I think a better API would be to not have that
reject parameter at all. Would something like this be accetable for your
use?

				Pekka

diff --git a/include/linux/string.h b/include/linux/string.h
index c61306d..3d66cae 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -56,6 +56,9 @@ #endif
 #ifndef __HAVE_ARCH_STRRCHR
 extern char * strrchr(const char *,int);
 #endif
+#ifndef __HAVE_ARCH_STRSTRIP
+extern char * strstrip(char *);
+#endif
 #ifndef __HAVE_ARCH_STRSTR
 extern char * strstr(const char *,const char *);
 #endif
diff --git a/lib/string.c b/lib/string.c
index 064f631..5b4257d 100644
--- a/lib/string.c
+++ b/lib/string.c
@@ -301,6 +301,38 @@ char *strnchr(const char *s, size_t coun
 EXPORT_SYMBOL(strnchr);
 #endif
 
+#ifndef __HAVE_ARCH_STRSTRIP
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
+#endif
+
 #ifndef __HAVE_ARCH_STRLEN
 /**
  * strlen - Find the length of a string


