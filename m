Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289462AbSAOJ0D>; Tue, 15 Jan 2002 04:26:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289455AbSAOJZy>; Tue, 15 Jan 2002 04:25:54 -0500
Received: from 12-234-95-123.client.attbi.com ([12.234.95.123]:64328 "HELO
	hellmouth.digitalvampire.org") by vger.kernel.org with SMTP
	id <S289467AbSAOJZr>; Tue, 15 Jan 2002 04:25:47 -0500
To: torvalds@transmeta.com, marcelo@conectiva.com.br, alan@lxorguk.ukuu.org.uk,
        linux-kernel@vger.kernel.org
Subject: [PATCH] fix two bugs in lib/vsprintf.c
From: Roland Dreier <roland@digitalvampire.org>
Date: 15 Jan 2002 01:25:38 -0800
Message-ID: <87advgrmnh.fsf@love-shack.home.digitalvampire.org>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) XEmacs/21.1 (Capitol Reef)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The below patch fixes two bugs in lib/vsprintf.c's implementation of
vsscanf().  First, the man page for vsscanf() says about the 'i'
conversion:

       i      Matches an  optionally  signed  integer;  the  next
              pointer  must  be a pointer to int.  The integer is
              read in base 16 if it begins with `0x' or `0X',  in
              base  8  if  it  begins  with  `0',  and in base 10
              otherwise.  Only characters that correspond to  the
              base are used.

To me this means that vsscanf() should pass base 0 to simple_strtol;
however the Linux implementation defaults to base 10.  The first part
of the patch corrects this.

Second, vsscanf() checks the first character of the number it's about
to read using isdigit(); this is incorrect for hex or octal
conversions.  The second part of this patch corrects vsscanf() to use
the correct check depending on the value of base.

lib/vsprintf.c has not changed in quite a while, so this patch should
apply cleanly to 2.4.17, 2.4.18pre3 and 2.5.2.

Thanks,
  Roland

diff -Naur linux-2.4.17.orig/lib/vsprintf.c linux-2.4.17/lib/vsprintf.c
--- linux-2.4.17.orig/lib/vsprintf.c	Thu Oct 11 11:17:22 2001
+++ linux-2.4.17/lib/vsprintf.c	Tue Jan 15 01:06:29 2002
@@ -616,8 +616,9 @@
 		case 'X':
 			base = 16;
 			break;
-		case 'd':
 		case 'i':
+                        base = 0;
+		case 'd':
 			is_sign = 1;
 		case 'u':
 			break;
@@ -637,7 +638,11 @@
 		while (isspace(*str))
 			str++;
 
-		if (!*str || !isdigit(*str))
+		if (!*str
+                    || (base == 16 && !isxdigit(*str))
+                    || (base == 10 && !isdigit(*str))
+                    || (base == 8 && (!isdigit(*str) || *str > '7'))
+                    || (base == 0 && !isdigit(*str)))
 			break;
 
 		switch(qualifier) {

-- 
Roland Dreier                                <roland@digitalvampire.org>
GPG Key fingerprint = A89F B5E9 C185 F34D BD50  4009 37E2 25CC E0EE FAC0
