Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262624AbTDAQDP>; Tue, 1 Apr 2003 11:03:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262625AbTDAQDP>; Tue, 1 Apr 2003 11:03:15 -0500
Received: from franka.aracnet.com ([216.99.193.44]:57277 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S262624AbTDAQDL>; Tue, 1 Apr 2003 11:03:11 -0500
Date: Tue, 01 Apr 2003 08:13:43 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Jeff Garzik <jgarzik@pobox.com>
cc: Andrew Morton <akpm@digeo.com>, colpatch@us.ibm.com,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] (2.5.66-mm2) War on warnings
Message-ID: <25070000.1049213622@[10.10.2.4]>
In-Reply-To: <20030401152703.GA21986@gtf.org>
References: <19200000.1049210557@[10.10.2.4]> <20030401152703.GA21986@gtf.org>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> drivers/base/node.c: In function `register_node_type':
>> drivers/base/node.c:96: warning: suggest parentheses around assignment used as truth value
>> drivers/base/memblk.c: In function `register_memblk_type':
>> drivers/base/memblk.c:54: warning: suggest parentheses around assignment used as truth value
>> 
>> Bah.
>> 
>> --- linux-2.5.66-mm2/drivers/base/node.c	2003-04-01 06:40:02.000000000 -0800
>> +++ 2.5.66-mm2/drivers/base/node.c	2003-04-01 06:37:32.000000000 -0800
>> @@ -93,7 +93,7 @@ int __init register_node_type(void)
>>  {
>>  	int error;
>>  	if (!(error = devclass_register(&node_devclass)))
>> -		if (error = driver_register(&node_driver))
>> +		if ((error = driver_register(&node_driver)))
>>  			devclass_unregister(&node_devclass);
> 
> Personally, I feel statements like these are prone to continual error
> and confusion.  I would prefer to break each test like this out into
> separate assignment and test statements.  Combining them decreases
> readability, while saving a paltry few extra bytes of source code.
> 
> Sure, the gcc warning is silly, but the code is a bit obtuse too.

True, I agree with this in general, and I think Andrew does too, from
previous comments. I was just being lazy ;-) More appropriate patch below.
Compile tested, but not run.

M.

diff -urpN -X /home/fletch/.diff.exclude mm2/drivers/base/memblk.c mm2-warnfix/drivers/base/memblk.c
--- mm2/drivers/base/memblk.c	Tue Apr  1 08:05:55 2003
+++ mm2-warnfix/drivers/base/memblk.c	Tue Apr  1 08:08:36 2003
@@ -50,9 +50,13 @@ int __init register_memblk(struct memblk
 int __init register_memblk_type(void)
 {
 	int error;
-	if (!(error = devclass_register(&memblk_devclass)))
-		if (error = driver_register(&memblk_driver))
+
+	error = devclass_register(&memblk_devclass);
+	if (!error) {
+		error = driver_register(&memblk_driver);
+		if (error)
 			devclass_unregister(&memblk_devclass);
+	}
 	return error;
 }
 postcore_initcall(register_memblk_type);
diff -urpN -X /home/fletch/.diff.exclude mm2/drivers/base/node.c mm2-warnfix/drivers/base/node.c
--- mm2/drivers/base/node.c	Tue Apr  1 08:05:55 2003
+++ mm2-warnfix/drivers/base/node.c	Tue Apr  1 08:07:36 2003
@@ -92,9 +92,13 @@ int __init register_node(struct node *no
 int __init register_node_type(void)
 {
 	int error;
-	if (!(error = devclass_register(&node_devclass)))
-		if (error = driver_register(&node_driver))
+	
+	error = devclass_register(&node_devclass);
+	if (!error) {
+		error = driver_register(&node_driver);
+		if (error)
 			devclass_unregister(&node_devclass);
+	}
 	return error;
 }
 postcore_initcall(register_node_type);

