Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264323AbUEINIm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264323AbUEINIm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 May 2004 09:08:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264330AbUEINIm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 May 2004 09:08:42 -0400
Received: from mx1.redhat.com ([66.187.233.31]:51086 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264323AbUEINIi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 May 2004 09:08:38 -0400
Message-ID: <409E2D50.8030402@redhat.com>
Date: Sun, 09 May 2004 03:08:32 -1000
From: Warren Togami <wtogami@redhat.com>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040418)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Markus Lidel <Markus.Lidel@shadowconnect.com>,
       Arjan van de Ven <arjanv@redhat.com>, Alan Cox <alan@redhat.com>,
       Alexander Viro <aviro@redhat.com>, Cristian Gafton <gafton@redhat.com>
Subject: Re: [PATCH 2.6] to fix i2o_proc kernel panic on access of /proc/i2o/iop0/lct
References: <409CC59B.3020500@shadowconnect.com> <200405081739.50871.ioe-lkml@rameria.de> <409DA6CD.2080303@shadowconnect.com>
In-Reply-To: <409DA6CD.2080303@shadowconnect.com>
X-Enigmail-Version: 0.83.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Markus Lidel wrote:
> Hello,
> 
> Ingo Oeser wrote:
> 
>>> the patch fixes a bug in the i2o_proc.c module, where the kernel 
>>> panics, if you access /proc/i2o/iop0/lct and read more then 1024 
>>> bytes of it.
>>> The problem was, that no paging was implemented by the function. This 
>>> is now solved.
>>
>> What about solving this properly and using the seq_file API for this
>> problem class as anywhere else in the kernel?
>> Code will also get much more readable by this ;-)
> 
> 
> Didn't know of the seq_file API. But you are right, now it looks much 
> cleaner than before. Thanks for telling me!
> 

Thanks Markus!  This patch seems to solve the x86-64 rmmod oops. 
Unfortunately I have discovered another problem, a fix for that problem, 
then another problem after that.  I tested it by running the two scripts 
below simultaneously.  Not long after running the scripts it triggered 
many oopses and eventually a panic.

#!/bin/bash
date
modprobe i2o_proc
modprobe -r i2o_proc
exec $0

#!/bin/bash
cat /proc/i2o/iop0/lct
exec $0

http://togami.com/~warren/temp/i2o_proc.log.bz2
bzip2 compressed log from the netconsole, showing the many oops and 
tracebacks all the way to the final panic.  (I suspect this problem may 
exist in many other kernel modules too?)

--- kernel-2.6.5.orig/linux-2.6.5/drivers/message/i2o/i2o_proc.c 
2004-04-03 17:37:25.000000000 -1000
+++ kernel-2.6.5/linux-2.6.5/drivers/message/i2o/i2o_proc.c 
2004-05-09 01:18:05.667902973 -1000
@@ -3329,6 +3329,7 @@
         i2o_proc_dir_root = proc_mkdir("i2o", 0);
         if(!i2o_proc_dir_root)
                 return -1;
+       i2o_proc_dir_root->owner = THIS_MODULE;

         for(i = 0; i < MAX_I2O_CONTROLLERS; i++)
         {

Al Viro immediately saw the race condition as ->owner not being set. 
Adding the above patch seems to prevent oops and panic when 
simultaneously running the two scripts.  This test has been done on x86-64.

Unfortunately the modprobe script stops at a certain point when it 
attempts to load the module.  With the other script still looping, it 
appears to cause this:

[root@i2obox64 root]# lsmod
Module                  Size  Used by
i2o_proc               53056  4294961501

And dmesg repeats this message billions of times:
de_put: entry i2o already free!

I am guessing this is some kind of locking trouble?  In any case after 
this ->owner fix this module is no longer problematic, mainly because 
NOBODY has any good reason to be using the i2o_proc module (or load and 
unload it rapidly), and it is not necessary for normal i2o_block usage.

Warren Togami
wtogami@redhat.com
