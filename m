Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262454AbUKLEMR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262454AbUKLEMR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 23:12:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262452AbUKLELV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 23:11:21 -0500
Received: from fw.osdl.org ([65.172.181.6]:34990 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262442AbUKLEK2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 23:10:28 -0500
Message-ID: <41943754.6090806@osdl.org>
Date: Thu, 11 Nov 2004 20:08:52 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: yiding_wang@agilent.com
CC: arjan@infradead.org, linux-kernel@vger.kernel.org, rusty@rustcorp.com.au,
       akpm <akpm@osdl.org>
Subject: Re: module tool with 2.6.9 limitation issue
References: <08A354A3A9CCA24F9EE9BE13600CFBC50F3AED@wcosmb07.cos.agilent.com>
In-Reply-To: <08A354A3A9CCA24F9EE9BE13600CFBC50F3AED@wcosmb07.cos.agilent.com>
Content-Type: multipart/mixed;
 boundary="------------010203010800040003010503"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010203010800040003010503
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

yiding_wang@agilent.com wrote:
> I am using moudle-init-tools-3.1-pre6 with kernel 2.6.9. The new insmod seems have restrictions which failed using parameters to load a driver module.
> 
> My module parameter is in the form of modname="*************** ****", a quite long one.
> Run - insmod modname.o modname="*********** *******" (with a script), it complains about the space and treats the string next to the space to be a "Unknown parameter".
> 
> By replacing the space with any character, then it complains 
> "modname: string parameter too long"

Patch for that one is attached.  It might be overkill,
but it works with this patch (as long as parameter value length
is <= 1024 -- not that I tried one of that length).

Rusty or anyone else, where do the quotes come from?
Here's what I enter:
insmod test_module modprm="this test"

but the kernel sees this parameter string:
"modprm=this test"
(with the quotation marks).
Who/what moved the quotation marks?  Is bash doing any of that?
I don't see it in insmod or modprobe (with a quick look).

> Reducing the length of the parameter to less than 1k character works fine.

Right, parameter value length cannot be > 1024.

> Same long parameter string wit space in between works fine under 2.4.25 with original insmod.
> 
> Questions:
> 1, Is this a bug or new insmod has restrictions? 

The limit is actually in linux/kernel/params.c, not in insmod.
It seems a little arbitrary, but a parameter that long also seems
quite excessive.  Just break it into multiple parameters.

> 2, If it is restriction on special character such as space, or limitation on parameter length, then why and what is the limit? 

Just 1024 bytes in total length.

> 3, If insmod has limitation, then what is better way to pass long parameter with some special character? 

Just break it into multiple parameters....

-- 
~Randy

--------------010203010800040003010503
Content-Type: text/x-patch;
 name="modprm_quoted.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="modprm_quoted.patch"

linux-2610-rc1-bk21
description

Signed-off-by: Randy Dunlap <rddunlap@osdl.org>

diffstat:=
 kernel/params.c |   15 ++++++++++++---
 1 files changed, 12 insertions(+), 3 deletions(-)

diff -Naurp ./kernel/params.c~modprm_quoted ./kernel/params.c
--- ./kernel/params.c~modprm_quoted	2004-11-11 15:13:26.000000000 -0800
+++ ./kernel/params.c	2004-11-11 19:42:36.714124784 -0800
@@ -77,10 +77,16 @@ static int parse_one(char *param,
 static char *next_arg(char *args, char **param, char **val)
 {
 	unsigned int i, equals = 0;
-	int in_quote = 0;
+	int in_quote = 0, quoted = 0;
+	char *next;
 
 	/* Chew any extra spaces */
 	while (*args == ' ') args++;
+	if (*args == '"') {
+		args++;
+		in_quote = 1;
+		quoted = 1;
+	}
 
 	for (i = 0; args[i]; i++) {
 		if (args[i] == ' ' && !in_quote)
@@ -106,13 +112,16 @@ static char *next_arg(char *args, char *
 			if (args[i-1] == '"')
 				args[i-1] = '\0';
 		}
+		if (quoted && args[i-1] == '"')
+			args[i-1] = '\0';
 	}
 
 	if (args[i]) {
 		args[i] = '\0';
-		return args + i + 1;
+		next = args + i + 1;
 	} else
-		return args + i;
+		next = args + i;
+	return next;
 }
 
 /* Args looks like "foo=bar,bar2 baz=fuz wiz". */

--------------010203010800040003010503--
