Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265885AbSKKTIB>; Mon, 11 Nov 2002 14:08:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265887AbSKKTIB>; Mon, 11 Nov 2002 14:08:01 -0500
Received: from air-2.osdl.org ([65.172.181.6]:48258 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S265885AbSKKTH7>;
	Mon, 11 Nov 2002 14:07:59 -0500
Date: Mon, 11 Nov 2002 11:09:28 -0800 (PST)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: Ray Lee <ray-lk@madrabbit.org>
cc: <hps@intermeta.de>, <schwab@suse.de>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Re: sscanf("-1", "%d", &i) fails, returns 0
In-Reply-To: <1037026495.22906.36.camel@orca>
Message-ID: <Pine.LNX.4.33L2.0211111019300.23954-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11 Nov 2002, Ray Lee wrote:

Randy wrote:
| > > What should it do?
Henning wrote:
| > I would model this after user space. (Which does strange things:
|
| <snip>
|
| It only sounds strange at first. It actually means that scanf is
| consistent with C's rules of assignment between mixed types. For
| example:
|
| ray:~$ cat signs.c
|
[snippage]
|
| ray:~$ ./signs
| -100 scanned to signed -100 and unsigned 4294967196
| -100 assigned to unsigned int gives 4294967196

These values (-100 and 4294967196) are the same bits, just observed/used
in a different manner.

| So, one should think of scanf as having correct knowledge of the types
| it's scanning, and then shoe-horning the result into whatever you asked
| for. Just like C itself.

Why would scanf() have to know whether the destination is signed
or unsigned?  It needs to know type (=> size) of course.

Seems to me that "signed-ness" is in the eyes of the user of the value.
I.e., scanf() can scan "-100" to an <int value> of
-100 = (unsigned) 4294967196 and shoe-horn that value into an
int-sized shoe and the caller can use it as signed or unsigned.


Andreas Schwab wrote:
|> IOW, asking for an unsigned number (in the format string)
|> and getting "-123" does return 0.

| Not in C.  According to the standard scanf is supposed to convert the
| value to unsinged and return that.
OK, thanks, I found that in the C spec.

Now what does it mean to "convert the value to an unsigned and return
that."  This is the same as above, isn't it?
I.e., on the scanf() side, there is no conversion needed; just store the
value.

So... somebody tell me if the following patch makes the kernel's
vsscanf() function act like C's sscanf() function, or why it doesn't,
or what I'm overlooking.  :)

And then we'll see if the change is worthwhile... or for which kernel
version.
-- 
~Randy




--- ./lib/vsprintf.c%scan	Sun Nov 10 19:28:30 2002
+++ ./lib/vsprintf.c	Mon Nov 11 09:56:51 2002
@@ -640,7 +640,7 @@
 			str++;

 		digit = *str;
-		if (is_sign && digit == '-')
+		if (digit == '-')
 			digit = *(str + 1);

 		if (!digit
@@ -652,45 +652,33 @@

 		switch(qualifier) {
 		case 'h':
-			if (is_sign) {
-				short *s = (short *) va_arg(args,short *);
-				*s = (short) simple_strtol(str,&next,base);
-			} else {
-				unsigned short *s = (unsigned short *) va_arg(args, unsigned short *);
-				*s = (unsigned short) simple_strtoul(str, &next, base);
+			{
+			short *s = (short *) va_arg(args,short *);
+			*s = (short) simple_strtol(str,&next,base);
 			}
 			break;
 		case 'l':
-			if (is_sign) {
-				long *l = (long *) va_arg(args,long *);
-				*l = simple_strtol(str,&next,base);
-			} else {
-				unsigned long *l = (unsigned long*) va_arg(args,unsigned long*);
-				*l = simple_strtoul(str,&next,base);
+			{
+			long *l = (long *) va_arg(args,long *);
+			*l = simple_strtol(str,&next,base);
 			}
 			break;
 		case 'L':
-			if (is_sign) {
-				long long *l = (long long*) va_arg(args,long long *);
-				*l = simple_strtoll(str,&next,base);
-			} else {
-				unsigned long long *l = (unsigned long long*) va_arg(args,unsigned long long*);
-				*l = simple_strtoull(str,&next,base);
+			{
+			long long *l = (long long*) va_arg(args,long long *);
+			*l = simple_strtoll(str,&next,base);
 			}
 			break;
 		case 'Z':
-		{
+			{
 			size_t *s = (size_t*) va_arg(args,size_t*);
 			*s = (size_t) simple_strtoul(str,&next,base);
-		}
-		break;
+			}
+			break;
 		default:
-			if (is_sign) {
-				int *i = (int *) va_arg(args, int*);
-				*i = (int) simple_strtol(str,&next,base);
-			} else {
-				unsigned int *i = (unsigned int*) va_arg(args, unsigned int*);
-				*i = (unsigned int) simple_strtoul(str,&next,base);
+			{
+			int *i = (int *) va_arg(args, int*);
+			*i = (int) simple_strtol(str,&next,base);
 			}
 			break;
 		}



