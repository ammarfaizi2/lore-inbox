Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135852AbRDTR7R>; Fri, 20 Apr 2001 13:59:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135887AbRDTR7H>; Fri, 20 Apr 2001 13:59:07 -0400
Received: from smtp01.web.de ([194.45.170.210]:33294 "HELO smtp.web.de")
	by vger.kernel.org with SMTP id <S135852AbRDTR6w>;
	Fri, 20 Apr 2001 13:58:52 -0400
Content-Type: text/plain;
  charset="iso-8859-1"
From: Rene Scharfe <l.s.r@web.de>
Reply-To: l.s.r@web.de
To: linux-kernel@vger.kernel.org
Subject: [PATCH] change strsep() behaviour
Date: Fri, 20 Apr 2001 19:56:06 +0200
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <01042019560600.01123@golmepha>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

some time ago Ingo Oeser tried to replace strtok() and noone seemed to
notice. This time it's me who believes to be on this quest.

Why? strtok() is not reentrant, it uses a global variable to store some
kind of state. As its manpage states: "Don't use this function". But right
now almost every file system and framebuffer uses strtok() for parameter
parsing.

strsep() was created as an replacement. Unfortunatly the implementation
which made it into the kernel misses an important feature: it does not
return empty tokens.

OK, and after applying this patch you'll have a rectified strsep(). It
works against 2.4.3 and -ac10, and should also do so against -pre5. If
this gets accepted, I'm willing to start a crusade against strtok(),
sending patches to the maintainers and all.

There's a minor issue with smbfs which uses the old-style semantics of
strsep(). My patch takes care of this. I could not find any other current
use of strsep() exept in some #if 0'ed piece of code in the Power PC tree.

Any comments? Am I doing something stupid?
Please, cc: me (l.s.r@web.de) in replies, because I'm not on lkml (yet).

Best regards,
René Scharfe


--- linux-2.4.3/lib/string.c	Wed Apr  4 20:06:39 2001
+++ linux-2.4.3-ac10-rs/lib/string.c	Fri Apr 20 18:08:56 2001
@@ -326,21 +326,24 @@
  * @ct: The characters to search for
  *
  * strsep() updates @s to point after the token, ready for the next call.
+ *
+ * It returns empty tokens, too, behaving exactly like the libc function
+ * of that name. In fact, it was stolen from glibc2 and de-fancy-fied.
+ * Same semantics, slimmer shape. ;)
  */
-char * strsep(char **s, const char * ct)
+char * strsep(char **s, const char *ct)
 {
-	char *sbegin=*s;
-	if (!sbegin) 
-		return NULL;
-	
-	sbegin += strspn(sbegin,ct);
-	if (*sbegin == '\0') 
+	char *sbegin = *s;
+
+	if (sbegin == NULL)
 		return NULL;
-	
-	*s = strpbrk( sbegin, ct);
-	if (*s && **s != '\0')
+
+	if (*s = strpbrk(sbegin, ct))
 		*(*s)++ = '\0';
-	return (sbegin);
+	else
+		*s = NULL;
+
+	return sbegin;
 }
 #endif
 
--- linux-2.4.3/fs/smbfs/getopt.c	Mon Aug 14 22:31:10 2000
+++ linux-2.4.3-ac10-rs/fs/smbfs/getopt.c	Fri Apr 20 17:49:26 2001
@@ -30,8 +30,10 @@
 	char *val;
 	int i;
 
-	if ( (token = strsep(options, ",")) == NULL)
-		return 0;
+	do {
+		if ((token = strsep(options, ",")) == NULL)
+			return 0;
+	} while (*token == '\0');
 	*optopt = token;
 
 	*optarg = NULL;
