Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932523AbVHILty@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932523AbVHILty (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 07:49:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932524AbVHILty
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 07:49:54 -0400
Received: from gate.corvil.net ([213.94.219.177]:6920 "EHLO corvil.com")
	by vger.kernel.org with ESMTP id S932523AbVHILty (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 07:49:54 -0400
Message-ID: <42F897B2.9090404@draigBrady.com>
Date: Tue, 09 Aug 2005 12:46:58 +0100
From: P@draigBrady.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040124
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: [OT] util-linux 2.13-pre1
References: <20050802230751.GB4029@stusta.de>
In-Reply-To: <20050802230751.GB4029@stusta.de>
Content-Type: multipart/mixed;
 boundary="------------030903010301080400030704"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030903010301080400030704
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 8bit

Adrian Bunk wrote:
> util-linux 2.13-pre1 is available at
>   ftp://ftp.kernel.org/pub/linux/utils/util-linux/testing/util-linux-2.13-pre1.tar.gz

You missed my fixes to cal to fix a possible crash bug
for certain terminal types, and to fix date alignment
issues for certain dates. I've rediffed the attached
patched against 2.13-pre1.

Also schedutils build is breaking on redhat 9.
This really is messy but should be handled.
http://mail.linux.ie/pipermail/ilug/2004-November/019784.html
API changes in same minor version of glibc should just not happen.

-- 
Pa'draig Brady - http://www.pixelbeat.org
--

--------------030903010301080400030704
Content-Type: application/x-texinfo;
 name="cal-2.13-pre1-highlight.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cal-2.13-pre1-highlight.diff"

--- cal.c	2005-08-01 20:41:02.000000000 +0000
+++ cal-pb.c	2005-08-09 11:21:15.000000000 +0000
@@ -87,9 +87,13 @@
      putp(s);
 }
 
-static char *
+static const char *
 my_tgetstr(char *s, char *ss) {
-     return tigetstr(ss);
+     const char* ret = tigetstr(ss);
+     if (!ret || ret==(char*)-1)
+         return "";
+     else
+         return ret;
 }
 
 #elif defined(HAVE_LIBTERMCAP)
@@ -110,9 +114,13 @@
      tputs (s, 1, putchar);
 }
 
-static char *
+static const char *
 my_tgetstr(char *s, char *ss) {
-     return tgetstr(s, &strbuf);
+     const char* ret = tgetstr(s, &strbuf);
+     if (!ret)
+         return "";
+     else
+         return ret;
 }
 
 #endif
@@ -225,6 +233,7 @@
 char * ascii_day(char *, int);
 void center_str(const char* src, char* dest, size_t dest_size, int width);
 void center(const char *, int, int);
+int strlen_terminal(const char* s);
 void day_array(int, int, int, int *);
 int day_in_week(int, int, int);
 int day_in_year(int, int, int);
@@ -498,10 +507,18 @@
 	for (i = 0; i < 2; i++)
 		printf("%s  %s  %s\n", out_prev.s[i], out_curm.s[i], out_next.s[i]);
 	for (i = 2; i < FMT_ST_LINES; i++) {
+		int width1,width2,width3;
+		width1=width2=width3=width;
+#if defined(HAVE_NCURSES) || defined(HAVE_LIBTERMCAP)
+		/* adjust width to allow for non printable characters */
+		width1+=strlen(out_prev.s[i])-strlen_terminal(out_prev.s[i]);
+		width2+=strlen(out_curm.s[i])-strlen_terminal(out_curm.s[i]);
+		width3+=strlen(out_next.s[i])-strlen_terminal(out_next.s[i]);
+#endif
 		snprintf(lineout, SIZE(lineout), "%-*s  %-*s  %-*s\n",
-		       width, out_prev.s[i],
-		       width, out_curm.s[i],
-		       width, out_next.s[i]);
+		       width1, out_prev.s[i],
+		       width2, out_curm.s[i],
+		       width3, out_next.s[i]);
 #if defined(HAVE_NCURSES) || defined(HAVE_LIBTERMCAP)
 		my_putstring(lineout);
 #else
@@ -773,6 +790,15 @@
 		(void)printf("%*s", separate, "");
 }
 
+int
+strlen_terminal(const char* s)
+{
+	if (Senter && Senter[0])
+		if (strstr(s,Senter))
+			return strlen(s) - strlen(Senter) - strlen(Sexit);
+	return strlen(s);
+}
+
 void
 usage()
 {

--------------030903010301080400030704--
