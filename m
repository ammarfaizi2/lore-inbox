Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162749AbWLBDbV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162749AbWLBDbV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 22:31:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162753AbWLBDbV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 22:31:21 -0500
Received: from wx-out-0506.google.com ([66.249.82.239]:16151 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1162749AbWLBDbU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 22:31:20 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:sender;
        b=AugRhah6/KF00upA3WQ2DDd7o83mlCeDyehl8HlHNK5DQ9DDHFE0KXJY9HoMadFFpRSHWa32Gt1cWwQtNrz5Wv54xJgGE5wHJYS1H6CtSWyPdqEiEguv23c9yVWFLF9CZm0e7b63P2IfHQasQ1ZIatZR13ZHW0d11mUD6DZKgUg=
Message-ID: <4570F373.5090608@kaigai.gr.jp>
Date: Sat, 02 Dec 2006 12:30:59 +0900
From: KaiGai Kohei <kaigai@kaigai.gr.jp>
User-Agent: Thunderbird 1.5.0.8 (Windows/20061025)
MIME-Version: 1.0
To: "Serge E. Hallyn" <serue@us.ibm.com>
CC: "Bill O'Donnell" <billodo@sgi.com>, Chris Friedhoff <chris@friedhoff.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-security-module@vger.kernel.org,
       Stephen Smalley <sds@tycho.nsa.gov>, James Morris <jmorris@namei.org>,
       Chris Wright <chrisw@sous-sol.org>,
       Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: [PATCH] Implement file posix capabilities
References: <20061127170740.GA5859@sergelap.austin.ibm.com> <20061129112848.8e48267e.chris@friedhoff.org> <20061129204013.GA7228@sgi.com> <20061130180502.GA20345@sgi.com> <20061130225707.GA23379@sergelap.austin.ibm.com>
In-Reply-To: <20061130225707.GA23379@sergelap.austin.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oops, it's my stupid bug.

> Ah, this actually makes sense.  The setfcaps usage() statement does
> 
> 	for (i=0; _cap_names[i]; i++) {
> 		printf...
> 
> so it expects _cap_names to end with a terminating NULL, but that
> doesn't seem to be the case in cap_names.h in libcap.
> 
> KaiGai, perhaps setfcaps should do something like
> 
> diff setfcaps.c.orig setfcaps.c
> 25c25
> <     for (i=0; _cap_names[i]; i++)
> ---
>>     for (i=0; i<__CAP_BITS; i++)

I fixed the matter as follows:

[kaigai@masu libcap-1.10.kg]$ env LANG=C svn diff -r2:3
Index: libcap/_makenames.c
===================================================================
--- libcap/_makenames.c (revision 2)
+++ libcap/_makenames.c (revision 3)
@@ -45,6 +45,7 @@
            "#define __CAP_BITS   %d\n"
            "\n"
            "#ifdef LIBCAP_PLEASE_INCLUDE_ARRAY\n"
+          "  int const _cap_names_num = __CAP_BITS;\n"
            "  char const *_cap_names[__CAP_BITS] = {\n", maxcaps);

      for (i=0; i<maxcaps; ++i) {
Index: libcap/include/sys/capability.h
===================================================================
--- libcap/include/sys/capability.h     (revision 2)
+++ libcap/include/sys/capability.h     (revision 3)
@@ -113,6 +113,7 @@
  extern int capgetp(pid_t pid, cap_t cap_d);
  extern int capsetp(pid_t pid, cap_t cap_d);
  extern char const *_cap_names[];
+extern int const _cap_names_num;

  #endif /* !defined(_POSIX_SOURCE) */

Index: progs/setfcaps.c
===================================================================
--- progs/setfcaps.c    (revision 2)
+++ progs/setfcaps.c    (revision 3)
@@ -14,6 +14,7 @@
  #include <errno.h>
  #include <sys/capability.h>

+extern int const _cap_names_num;
  extern char const *_cap_names[];

  static void usage() {
@@ -21,8 +22,8 @@
      int i;

      fputs(message, stderr);
-    for (i=0; _cap_names[i]; i++)
-       fprintf(stderr, "%s%s", i%4==0 ? "\n\t" : ", ", _cap_names[i]);
+    for (i=0; i < _cap_names_num; i++)
+        fprintf(stderr, "%s%s", i%4==0 ? "\n\t" : ", ", _cap_names[i]);
      fputc('\n', stderr);
      exit(0);
  }
[kaigai@masu libcap-1.10.kg]$

Because '__CAP_BITS' is decided at compiling time, I think it's not
appropriate to indicate the length of _cap_names[] which is linked
at run time.
Therefore, I add a new integer variable _cap_names_num to represent
the length of _cap_names at run time.

You can download it from http://www.kaigai.gr.jp/index.php?FrontPage#b556e50d

Thanks,
-- 
KaiGai Kohei <kaigai@kaigai.gr.jp>
