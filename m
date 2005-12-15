Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751059AbVLOUim@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751059AbVLOUim (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 15:38:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751060AbVLOUim
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 15:38:42 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:3300 "EHLO e32.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751058AbVLOUil (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 15:38:41 -0500
Message-ID: <43A1D435.5060602@us.ibm.com>
Date: Thu, 15 Dec 2005 15:38:13 -0500
From: JANAK DESAI <janak@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: viro@ftp.linux.org.uk, chrisw@osdl.org, dwmw2@infradead.org,
       jamie@shareable.org, serue@us.ibm.com, mingo@elte.hu,
       linuxram@us.ibm.com, jmorris@namei.org, sds@tycho.nsa.gov,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -mm 1/9] unshare system call: system call handler function
References: <1134513959.11972.167.camel@hobbs.atlanta.ibm.com> <m1k6e687e2.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m1k6e687e2.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:

>JANAK DESAI <janak@us.ibm.com> writes:
>
>  
>
>>[PATCH -mm 1/9] unshare system call: system call handler function 
>>
>>sys_unshare system call handler function accepts the same flags as
>>clone system call, checks constraints on each of the flags and invokes
>>corresponding unshare functions to disassociate respective process
>>context if it was being shared with another task. 
>>
>>Changes since the first submission of this patch on 12/12/05:
>>	- Moved cleaning up of old shared structures outside of the
>>	  block that holds task_lock (12/13/05)
>> 
>>Signed-off-by: Janak Desai <janak@us.ibm.com>
>> 
>>---
>> 
>> fork.c | 232 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>> 1 files changed, 232 insertions(+)
>> 
>>diff -Naurp 2.6.15-rc5-mm2/kernel/fork.c 2.6.15-rc5-mm2+patch/kernel/fork.c
>>--- 2.6.15-rc5-mm2/kernel/fork.c	2005-12-12 03:05:59.000000000 +0000
>>+++ 2.6.15-rc5-mm2+patch/kernel/fork.c	2005-12-13 18:38:26.000000000 +0000
>>@@ -1330,3 +1330,235 @@ void __init proc_caches_init(void)
>> 			sizeof(struct mm_struct), 0,
>> 			SLAB_HWCACHE_ALIGN|SLAB_PANIC, NULL, NULL);
>> }
>>+
>>+
>>+/*
>>+ * Check constraints on flags passed to the unshare system call and
>>+ * force unsharing of additional process context as appropriate.
>>+ */
>>    
>>
>
>If it isn't legal how about we deny the unshare call.
>Then we can share this code with clone.
>
>Eric
>
>
>  
>
unshare is doing the reverse of what clone does. So if you are unsharing 
namespace
you want to make sure that you are not sharing fs. That's why the 
CLONE_FS flag
is forced (meaning you are also going to unshare fs). Since namespace is 
shared
by default and fs is not, if clone is called with CLONE_NEWNS, the 
intent is to
create a new namespace, which means you cannot share fs. clone checks to
makes sure that CLONE_NEWNS and CLONE_FS are not specified together, while
unshare will force CLONE_FS if CLONE_NEWNS is spefcified. Basically you
can have a shared namespace and non shared fs, but not the other way 
around and
since clone and unshare are doing opposite things, sharing code between 
them that
checks constraints on the flags can get convoluted.

-Janak
