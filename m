Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261851AbVBTPkz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261851AbVBTPkz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Feb 2005 10:40:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261852AbVBTPkz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Feb 2005 10:40:55 -0500
Received: from ylpvm29-ext.prodigy.net ([207.115.57.60]:4301 "EHLO
	ylpvm29.prodigy.net") by vger.kernel.org with ESMTP id S261851AbVBTPkd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Feb 2005 10:40:33 -0500
Message-ID: <4218AF68.3010500@pacbell.net>
Date: Sun, 20 Feb 2005 07:40:24 -0800
From: Mickey Stein <yekkim@pacbell.net>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i2c.h: Fix another gcc 4.0 compile failure
References: <42177048.2000109@pacbell.net> <20050219223711.GB12713@kroah.com>
In-Reply-To: <20050219223711.GB12713@kroah.com>
Content-Type: multipart/mixed;
 boundary="------------040000030201080905000907"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040000030201080905000907
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Greg KH wrote:

>On Sat, Feb 19, 2005 at 08:58:48AM -0800, Mickey Stein wrote:
>  
>
>>From: Mickey Stein
>> Versions:   linux-2.6.11-rc4-bk7, gcc4 (GCC) 4.0.0 20050217 (latest fc 
>>rawhide from 19Feb DL)
>>
>> gcc4 cvs seems to dislike "include/linux/i2c.h file":
>>
>> Error msg:   include/linux/i2c.h:{55,194} error: array type has 
>>incomplete element type
>>
>> A. Daplas has recently done a workaround for this on another header 
>>file. A thread discussing this
>> can be found by following the link below:
>>
>> http://gcc.gnu.org/ml/gcc/2005-02/msg00053.html
>>
>> The patch changes the array declaration from "struct x y[]" format to 
>>"struct x *y".
>> I realize its only a workaround, but the gcc guys seem to be aware of 
>>this.
>> ** Note: I'm a noob at this, so feel free to make chopped liver out of 
>>this if its incorrect.
>> patch below is also attached since I'm not sure formatting survives 
>>the cut&paste.
>>    
>>
>
>The patch looks sane, but before I apply it, care to also fix up all of
>the function pointers that are affected by this patch?  Also the
>i2c_transfer() function itself should be changed (not just the header
>file.)
>
>thanks,
>
>greg k-h
>
>  
>
Greg,

I took a look for other references similar to those in my first take at 
this and found a couple more files.
Attached is another patch that hopefully addresses the all the similar 
cases.  I tried it on today's (-bk8) kernel,
with all i2c switches enabled.

From: Mickey Stein
 Versions:   linux-2.6.11-rc4-bk8, gcc4 (GCC) 4.0.0 20050217 (latest fc 
rawhide from 19Feb DL)

 gcc4 cvs seems to dislike "include/linux/i2c.h, i2c-core.c files".

 I also tweaked the Documentation/i2c/writing-clients file.

 Error msg:   include/linux/i2c.h:{55,194} error: array type has 
incomplete element type

 A. Daplas has recently done a workaround for this on another header 
file. A thread discussing this
 can be found by following the link below:

 http://gcc.gnu.org/ml/gcc/2005-02/msg00053.html

 The patch changes the i2c-transfer code in i2c.h  from "struct x y[]" 
format to "struct x *y".
 It also changes the associated i2c-transfer declarations in i2c-core.c.
 It tweaks the Documentation/i2c/writing-clients file to reconcile 
i2c-transfer docs.

 I realize its only a workaround, but the gcc guys seem to be aware of 
this.

Thanks very much,

Mickey Stein

 Signed-off-by: Mickey Stein <yekkim@pacbell.net>




--------------040000030201080905000907
Content-Type: text/plain;
 name="i2c.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="i2c.patch"

--- ./include/linux/i2c.h.sav	2005-02-20 07:03:41.000000000 -0800
+++ ./include/linux/i2c.h	2005-02-20 07:14:26.000000000 -0800
@@ -55,7 +55,7 @@
 
 /* Transfer num messages.
  */
-extern int i2c_transfer(struct i2c_adapter *adap, struct i2c_msg msg[],int num);
+extern int i2c_transfer(struct i2c_adapter *adap, struct i2c_msg *msg,int num);
 
 /*
  * Some adapter types (i.e. PCF 8584 based ones) may support slave behaviuor. 
@@ -194,7 +194,7 @@
 	   to NULL. If an adapter algorithm can do SMBus access, set 
 	   smbus_xfer. If set to NULL, the SMBus protocol is simulated
 	   using common I2C messages */
-	int (*master_xfer)(struct i2c_adapter *adap,struct i2c_msg msgs[], 
+	int (*master_xfer)(struct i2c_adapter *adap,struct i2c_msg *msgs, 
 	                   int num);
 	int (*smbus_xfer) (struct i2c_adapter *adap, u16 addr, 
 	                   unsigned short flags, char read_write,
--- ./drivers/i2c/i2c-core.c.sav	2005-02-20 07:03:53.000000000 -0800
+++ ./drivers/i2c/i2c-core.c	2005-02-20 07:11:46.000000000 -0800
@@ -583,7 +583,7 @@
  * ----------------------------------------------------
  */
 
-int i2c_transfer(struct i2c_adapter * adap, struct i2c_msg msgs[],int num)
+int i2c_transfer(struct i2c_adapter * adap, struct i2c_msg *msgs,int num)
 {
 	int ret;
 
--- ./Documentation/i2c/writing-clients.sav	2005-02-20 07:05:12.000000000 -0800
+++ ./Documentation/i2c/writing-clients	2005-02-20 07:08:29.000000000 -0800
@@ -642,7 +642,7 @@
 parameter contains the bytes the read/write, the third the length of the
 buffer. Returned is the actual number of bytes read/written.
   
-  extern int i2c_transfer(struct i2c_adapter *adap, struct i2c_msg msg[],
+  extern int i2c_transfer(struct i2c_adapter *adap, struct i2c_msg *msg,
                           int num);
 
 This sends a series of messages. Each message can be a read or write,

--------------040000030201080905000907--
