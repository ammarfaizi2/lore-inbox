Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267119AbSKMHF0>; Wed, 13 Nov 2002 02:05:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267121AbSKMHFZ>; Wed, 13 Nov 2002 02:05:25 -0500
Received: from air-2.osdl.org ([65.172.181.6]:3217 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S267119AbSKMHFX>;
	Wed, 13 Nov 2002 02:05:23 -0500
Date: Tue, 12 Nov 2002 23:06:44 -0800 (PST)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: Ray Lee <ray-lk@madrabbit.org>
cc: <hps@intermeta.de>, <schwab@suse.de>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Re: sscanf("-1", "%d", &i) fails, returns 0
In-Reply-To: <1037046334.22906.117.camel@orca>
Message-ID: <Pine.LNX.4.33L2.0211122241490.29595-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11 Nov 2002, Ray Lee wrote:

| I probably didn't state it very clearly, but that was what I was getting
| at. It's the same value after a cast. As Andreas points out though, it
| may not be bit-for-bit identical on machines that don't use two's
| complement. That's why the conversion code cares about the format
| specifiers, it seems.
|
| > Now what does it mean to "convert the value to an unsigned and return
| > that."  This is the same as above, isn't it?
|
| Explicitly, in the scan conversion you'd do a:
|
|   unsigned int *u = (unsigned int *) va_arg(args,long long *);
|   *u = (unsigned int) converted_value;
|
| ...from wherever you get converted_value from (simple_strtoul? I haven't
| looked at that routine). (The cast here is implied if left off, I'm just
| being explicit.)
|
| > I.e., on the scanf() side, there is no conversion needed; just store the
| > value.
|
| Almost true, as Andreas pointed out. You have to be careful that the
| target you're storing to has the correctly declared type inside the
| conversion routine.

See if this is close...

For 'h' (short), 'l' (long), 'L' (long long), and default
('d' and 'i'), signed input is allowed, even for octal or hex
(as well as decimal), so scan/convert signed values.
Then if the destination type is not signed (!is_sign),
store the value in an unsigned <length> var so that
conversion can be done as needed.

Here are a few sample conversions:

scanning input string:{-42}:
  %o level = 037777777736 = 0xffffffde
  %x level = -66 = 0xffffffbe
  %i level = -42 = 0xffffffd6
scanning input string:{-100}:
  %o level = 037777777700 = 0xffffffc0
  %x level = -256 = 0xffffff00
  %i level = -100 = 0xffffff9c
scanning input string:{-10}:
  %o level = 037777777770 = 0xfffffff8
  %x level = -16 = 0xfffffff0
  %i level = -10 = 0xfffffff6

I think that this patch (to 2.5.47) gets the kernel close
to the same semantics as C's sscanf() function, which is
usually a good thing.  What say you?

-- 
~Randy
  "I read part of it all the way through." -- Samuel Goldwyn




--- ./lib/vsprintf.c%scan	Sun Nov 10 19:28:30 2002
+++ ./lib/vsprintf.c	Tue Nov 12 20:51:23 2002
@@ -640,7 +640,7 @@
 			str++;

 		digit = *str;
-		if (is_sign && digit == '-')
+		if (digit == '-')
 			digit = *(str + 1);

 		if (!digit
@@ -652,46 +652,50 @@

 		switch(qualifier) {
 		case 'h':
-			if (is_sign) {
-				short *s = (short *) va_arg(args,short *);
-				*s = (short) simple_strtol(str,&next,base);
-			} else {
-				unsigned short *s = (unsigned short *) va_arg(args, unsigned short *);
-				*s = (unsigned short) simple_strtoul(str, &next, base);
+		{
+			short *s = (short *) va_arg(args, short *);
+			*s = (short) simple_strtol(str, &next, base);
+			if (!is_sign) {
+				unsigned short *us = s;
+				*us = (unsigned short) *s;
 			}
+		}
 			break;
 		case 'l':
-			if (is_sign) {
-				long *l = (long *) va_arg(args,long *);
-				*l = simple_strtol(str,&next,base);
-			} else {
-				unsigned long *l = (unsigned long*) va_arg(args,unsigned long*);
-				*l = simple_strtoul(str,&next,base);
+		{
+			long *l = (long *) va_arg(args, long *);
+			*l = simple_strtol(str, &next, base);
+			if (!is_sign) {
+				unsigned long *ul = l;
+				*ul = (unsigned long) *l;
 			}
+		}
 			break;
 		case 'L':
-			if (is_sign) {
-				long long *l = (long long*) va_arg(args,long long *);
-				*l = simple_strtoll(str,&next,base);
-			} else {
-				unsigned long long *l = (unsigned long long*) va_arg(args,unsigned long long*);
-				*l = simple_strtoull(str,&next,base);
+		{
+			long long *l = (long long *) va_arg(args, long long *);
+			*l = simple_strtoll(str, &next, base);
+			if (!is_sign) {
+				unsigned long long *ul = l;
+				*ul = (unsigned long long) *l;
 			}
+		}
 			break;
 		case 'Z':
 		{
-			size_t *s = (size_t*) va_arg(args,size_t*);
-			*s = (size_t) simple_strtoul(str,&next,base);
+			size_t *s = (size_t *) va_arg(args, size_t *);
+			*s = (size_t) simple_strtoul(str, &next, base);
 		}
-		break;
+			break;
 		default:
-			if (is_sign) {
-				int *i = (int *) va_arg(args, int*);
-				*i = (int) simple_strtol(str,&next,base);
-			} else {
-				unsigned int *i = (unsigned int*) va_arg(args, unsigned int*);
-				*i = (unsigned int) simple_strtoul(str,&next,base);
+		{
+			int *i = (int *) va_arg(args, int *);
+			*i = (int) simple_strtol(str, &next, base);
+			if (!is_sign) {
+				unsigned int *ui = i;
+				*ui = (unsigned int) *i;
 			}
+		}
 			break;
 		}
 		num++;

