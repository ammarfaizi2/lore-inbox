Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262934AbTE2WWT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 18:22:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262946AbTE2WWT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 18:22:19 -0400
Received: from air-2.osdl.org ([65.172.181.6]:51942 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262934AbTE2WWR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 18:22:17 -0400
Date: Thu, 29 May 2003 15:36:03 -0700
From: Dave Olien <dmo@osdl.org>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] sparse tool handling of escaped characters in strings
Message-ID: <20030529223603.GA8958@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Hi, Linus.  I'm just beginning to look over your sparse tool library.
I decided to start with something simple.  Running your check tool
on the 2.5.70 kernel produces 25 warnings of the forms:

warning: drivers/char/n_tty.c:198:35: Unknown escape 'r'
warning: drivers/char/n_tty.c:225:11: Unknown escape 'b'
warning: drivers/char/n_tty.c:547:17: Unknown escape 'a'

They come from character strings that contain escaped characters that
escapechar() in tokenize.c didn't recognize. I added cases for these
characters.

The warning below is a little more interesting.

warning: fs/proc/array.c:338:1: Unknown escape '
'

It comes from a string that is continued on multiple lines, of the form:

printf("abcdef\
ghijkl");

This is different from the other cases because the \<newline> character should
never appear in the parsed string.

As a first fix, I've made escapechar() call itself recursively.
One flaw with this fix is that escapechar() will mark the first character on
the second line of the input string as "escaped":

	/* Mark it as escaped */
	value |= 0x100;

But, none of the callers to escapechar() ever use or preserve this information.
Can this "escaped" character information be removed.

Or, I could add a flag (ugh) that causes the code to NOT add the
escape flag in this particular case.

Or, I could find a different solution to this case.

Thanks!
Dave Olien
OSDL

--------------------------------------------------------------------------

--- sparse_original/tokenize.c	2003-05-29 14:22:20.000000000 -0700
+++ sparse_test/tokenize.c	2003-05-29 15:19:25.000000000 -0700
@@ -340,18 +340,39 @@
 		next = nextchar(stream);
 		if (value != type) {
 			switch (value) {
-			case 'n':
-				value = '\n';
+			case 'a':
+				value = '\a';
+				break;
+			case 'b':
+				value = '\b';
 				break;
 			case 't':
 				value = '\t';
 				break;
+			case 'n':
+				value = '\n';
+				break;
+			case 'v':
+				value = '\v';
+				break;
+			case 'f':
+				value = '\f';
+				break;
+			case 'r':
+				value = '\r';
+				break;
+			case 'e':
+				value = '\e';
+				break;
 			case '\\':
 				break;
 			case '\'':
 				break;
 			case '"':
 				break;
+			case '\n':
+				next = escapechar(next, type, stream, &value);
+				break;
 			case '0'...'7': {
 				int nr = 2;
 				value -= '0';
