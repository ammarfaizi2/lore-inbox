Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277294AbRJRBaa>; Wed, 17 Oct 2001 21:30:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277295AbRJRBaU>; Wed, 17 Oct 2001 21:30:20 -0400
Received: from tartarus.telenet-ops.be ([195.130.132.34]:7650 "EHLO
	tartarus.telenet-ops.be") by vger.kernel.org with ESMTP
	id <S277294AbRJRBaL>; Wed, 17 Oct 2001 21:30:11 -0400
Message-ID: <3BCE2E26.EB0EDEFF@pandora.be>
Date: Thu, 18 Oct 2001 03:19:34 +0200
From: johan verrept <johan.verrept@pandora.be>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>, alan cox <alan@redhat.com>
Subject: Re: [PATCH] (Minor) Bugfixes to vsprintf.c, vsscanf().
In-Reply-To: <3BCE1E54.D14794A5@pandora.be>
Content-Type: multipart/mixed;
 boundary="------------DDE38193B6E74523C9854D5E"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------DDE38193B6E74523C9854D5E
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit

johan verrept wrote:
> 
> hello,
> 
> minor bugfix for vsprintf.c, vsscanf did not discard whitespace in input:
> - when encoutering whitespace in fmt not followed by '%'
> - in conversion where result is ignored with '*'
> 
> There is another bugfix in this, don't know from who. (picked it up with uml)
> (vsscanf used to skip two characters in the fmt for a single char in the input if not in
> conversion.)
> 
> Patch against 2.4.12, I am afraid.

Attached patch is beter. Both bugs are fixed and it adds fieldwidth support for conversions with
ignored results.
Again against 2.4.12.

	J.
--------------DDE38193B6E74523C9854D5E
Content-Type: text/plain; charset=iso-8859-15;
 name="vsprintf.c.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="vsprintf.c.diff"

--- linux-2.4.12-clean/lib/vsprintf.c	Sun Sep 16 20:26:10 2001
+++ linux-2.4.12-devel/lib/vsprintf.c	Thu Oct 18 03:06:47 2001
@@ -525,12 +525,15 @@
 	for (; *fmt; fmt++) {
 		/* skip any white space in format */
 		if (isspace(*fmt)) {
+			/* space in fmt skips all space in input */
+			while (isspace(*str)) str++;
 			continue;
 		}
 
 		/* anything that is not a conversion must match exactly */
 		if (*fmt != '%') {
-			if (*fmt++ != *str++)
+			/* Don't bump fmt because the for header will do it */
+			if (*fmt != *str++)
 				return num;
 			continue;
 		}
@@ -540,10 +543,25 @@
 		 * advance both strings to next white space
 		 */
 		if (*fmt == '*') {
-			while (!isspace(*fmt))
+			fmt++;
+			/* get fieldwidth */
+			field_width = 0xffffffffUL;
+			if (isdigit(*fmt))
+				field_width = skip_atoi(&fmt);
+
+			/* skip possible conversion qualifier */
+			if (*fmt == 'h' || *fmt == 'l' || *fmt == 'L' || *fmt == 'Z')
 				fmt++;
-			while(!isspace(*str))
+
+			/* do not skip conversion char, the for loop will do this */
+
+			/* eat all whitespace before conversion! */
+			while(isspace(*str))
+				str++;
+			while(!isspace(*str) && field_width) {
+				field_width--;
 				str++;
+			}
 			continue;
 		}
 

--------------DDE38193B6E74523C9854D5E--

