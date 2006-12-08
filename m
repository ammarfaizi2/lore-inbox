Return-Path: <linux-kernel-owner+w=401wt.eu-S1947257AbWLHV12@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1947257AbWLHV12 (ORCPT <rfc822;w@1wt.eu>);
	Fri, 8 Dec 2006 16:27:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1947265AbWLHV12
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 16:27:28 -0500
Received: from gepetto.dc.ltu.se ([130.240.42.40]:35660 "EHLO
	gepetto.dc.ltu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1947257AbWLHV11 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 16:27:27 -0500
Message-ID: <4579D941.9040607@student.ltu.se>
Date: Fri, 08 Dec 2006 22:29:37 +0100
From: Richard Knutsson <ricknu-0@student.ltu.se>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Randy Dunlap <randy.dunlap@oracle.com>
CC: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       shaggy@austin.ibm.com
Subject: Re: [PATCH] fs/jfs: fix error due to PF_* undeclared
References: <Pine.LNX.4.64.0611291411300.3513@woody.osdl.org>	<4579B554.5010701@student.ltu.se> <20061208112330.7e8d4e88.randy.dunlap@oracle.com>
In-Reply-To: <20061208112330.7e8d4e88.randy.dunlap@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy Dunlap wrote:
> On Fri, 08 Dec 2006 19:56:20 +0100 Richard Knutsson wrote:
>
>   
>>   CC [M]  fs/jfs/jfs_txnmgr.o
>> In file included from fs/jfs/jfs_txnmgr.c:49:
>> include/linux/freezer.h: In function ‘frozen’:
>> include/linux/freezer.h:9: error: dereferencing pointer to incomplete type
>> include/linux/freezer.h:9: error: ‘PF_FROZEN’ undeclared (first use in this function)
>> <snip>
>> fs/jfs/jfs_txnmgr.c: In function ‘freezing’:
>> include/linux/freezer.h:18: warning: control reaches end of non-void function
>> make[2]: *** [fs/jfs/jfs_txnmgr.o] Error 1
>> make[1]: *** [fs/jfs] Error 2
>> make: *** [fs] Error 2
>>
>> Signed-off-by: Richard Knutsson <ricknu-0@student.ltu.se>
>>
>> ---
>>
>> Guess this is the desired fix, since including linux/sched.h in linux/freezer.h
>> make little sense.
>>     
>
> Why do you say that?  freezer.h is what uses those #defined values,
> and freezer.h is what uses struct task_struct fields as well,
> so it needs sched.h.
>   
Oh, an error of thought when I read the patch 
7dfb71030f7636a0d65200158113c37764552f93 made that statement. After more 
checking, sched.h is apperarently included in suspend.h from swap.h so 
the direct include of sched.h in most drivers was/is not nessecary.

Do you agree with the patch below then? This was how I first fixed it 
but found it strange no-one hit it before, and from there it went on... 
Thanks for the help. (Sign it?)
>> diff --git a/fs/jfs/jfs_txnmgr.c b/fs/jfs/jfs_txnmgr.c
>> index d558e51..2aee0a8 100644
>> --- a/fs/jfs/jfs_txnmgr.c
>> +++ b/fs/jfs/jfs_txnmgr.c
>> @@ -46,6 +46,7 @@ #include <linux/fs.h>
>>  #include <linux/vmalloc.h>
>>  #include <linux/smp_lock.h>
>>  #include <linux/completion.h>
>> +#include <linux/sched.h>
>>  #include <linux/freezer.h>
>>  #include <linux/module.h>
>>  #include <linux/moduleparam.h>
>>
>>     
  CC [M]  fs/jfs/jfs_txnmgr.o
In file included from fs/jfs/jfs_txnmgr.c:49:
include/linux/freezer.h: In function ‘frozen’:
include/linux/freezer.h:9: error: dereferencing pointer to incomplete type
include/linux/freezer.h:9: error: ‘PF_FROZEN’ undeclared (first use in this function)
<snip>
fs/jfs/jfs_txnmgr.c: In function ‘freezing’:
include/linux/freezer.h:18: warning: control reaches end of non-void function
make[2]: *** [fs/jfs/jfs_txnmgr.o] Error 1
make[1]: *** [fs/jfs] Error 2
make: *** [fs] Error 2

Signed-off-by: Richard Knutsson <ricknu-0@student.ltu.se>

---

Compile-tested only.


diff --git a/include/linux/freezer.h b/include/linux/freezer.h
index 6e05e3e..f616c0c 100644
--- a/include/linux/freezer.h
+++ b/include/linux/freezer.h
@@ -1,3 +1,4 @@
+#include <linux/sched.h>
 /* Freezer declarations */

 #ifdef CONFIG_PM


