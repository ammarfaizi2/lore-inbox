Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261891AbUDLP1L (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Apr 2004 11:27:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262080AbUDLP1K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Apr 2004 11:27:10 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:35555 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S261891AbUDLP06
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Apr 2004 11:26:58 -0400
Message-ID: <407AB4FD.4070905@us.ibm.com>
Date: Mon, 12 Apr 2004 10:25:49 -0500
From: Brian King <brking@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020827
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
       linux-hotplug-devel@lists.sourceforge.net
Subject: Re: [PATCH] call_usermodehelper hang
References: <4072F2B7.2070605@us.ibm.com>	<20040406172903.186dd5f1.akpm@osdl.org>	<20040407061146.GA10413@kroah.com>	<407487A6.8020904@us.ibm.com>	<20040408224713.GD15125@kroah.com>	<40770AD0.4000402@us.ibm.com>	<20040409205344.GA5236@kroah.com>	<20040409141511.4e372554.akpm@osdl.org>	<20040410165322.GG1317@kroah.com> <20040410131137.0eff0ae2.akpm@osdl.org>
Content-Type: multipart/mixed;
 boundary="------------050409000605020104040001"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050409000605020104040001
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Andrew Morton wrote:
> Greg KH <greg@kroah.com> wrote:
> 
>>>The deadlock opportunity occurs during the call_usermodehelper() handoff to
>>
>> > keventd, which is synchronous.
>> > 
>> > 2-3 years back I did have a call_usermodehelper() which was fully async. 
>> > It was pretty unpleasant because of the need to atomically allocate
>> > arbitrary amounts of memory to hold the argv[] and endp[] arrays, to pass
>> > them between a couple of threads and to then correctly free it all up
>> > again.
>>
>> Ok, you've convinced me of the mess that would cause.  So what should we
>> do to help fix this?  Serialize call_usermodehelper()?
> 
> 
> May as well bring back call_usermodehelper_async() I guess.
> 
> 
> There are two patches here, and they are totally untested...

I loaded the patches on my ppc64 box and they worked fine after I fixed a compile
bug. The attached patch fixes the compile bug and changes the call_usermodehelper
call in kset_hotplug to call_usermodehelper_async.

-Brian




-- 
Brian King
eServer Storage I/O
IBM Linux Technology Center

--------------050409000605020104040001
Content-Type: text/plain;
 name="call_usermodehelper_kobject.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="call_usermodehelper_kobject.patch"


Fixes a compile error in call_usermodehelper_async and changes kset_hotplug 
to use call_usermodehelper_async, since it is called with a semaphore held,
which can result in a deadlock.


---


diff -puN kernel/kmod.c~call_usermodehelper_kobject kernel/kmod.c
--- linux-2.6.5/kernel/kmod.c~call_usermodehelper_kobject	Mon Apr 12 08:27:20 2004
+++ linux-2.6.5-bjking1/kernel/kmod.c	Mon Apr 12 08:27:44 2004
@@ -296,7 +296,7 @@ int call_usermodehelper_async(char *path
 {
 	struct subprocess_info *sub_info;
 
-	if (system_state != SYSTEM_RUNNING)
+	if (!system_running)
 		return -EBUSY;
 	if (path[0] == '\0')
 		goto out;
diff -puN lib/kobject.c~call_usermodehelper_kobject lib/kobject.c
--- linux-2.6.5/lib/kobject.c~call_usermodehelper_kobject	Mon Apr 12 08:28:07 2004
+++ linux-2.6.5-bjking1/lib/kobject.c	Mon Apr 12 08:28:28 2004
@@ -187,7 +187,7 @@ static void kset_hotplug(const char *act
 
 	pr_debug ("%s: %s %s %s %s %s %s %s\n", __FUNCTION__, argv[0], argv[1],
 		  envp[0], envp[1], envp[2], envp[3], envp[4]);
-	retval = call_usermodehelper (argv[0], argv, envp, 0);
+	retval = call_usermodehelper_async (argv[0], argv, envp, GFP_KERNEL);
 	if (retval)
 		pr_debug ("%s - call_usermodehelper returned %d\n",
 			  __FUNCTION__, retval);

_

--------------050409000605020104040001--

