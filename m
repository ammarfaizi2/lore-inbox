Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263183AbUDVIvN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263183AbUDVIvN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 04:51:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263877AbUDVIvN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 04:51:13 -0400
Received: from smtpout.mac.com ([17.250.248.97]:9705 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S263183AbUDVIvG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 04:51:06 -0400
Message-ID: <16641351.1082623864205.JavaMail.pwaechtler@mac.com>
Date: Thu, 22 Apr 2004 10:51:04 +0200
From: Peter Waechtler <pwaechtler@mac.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] coredump - as root not only if euid switched
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
On Thursday, April 22, 2004, at 03:18AM, Andrew Morton <akpm@osdl.org> wrote:

>Peter W�chtler <pwaechtler@mac.com> wrote:
>>
>> While it's more secure to not dump core at all if the program has
>>  switched euid, it's also very unpractical. Since only programs 
>>  started from root, being setuid root or have CAP_SETUID it's far 
>>  more practical to dump as root.root mode 600. This is the bahavior 
>>  of Solaris.
>> 
>>  The current implementation does not ensure that an existing core
>>  file is only readable as root, i.e. after dumping the ownership 
>>  and mode is unchanged.
>> 
>>  Besides mm->dumpable to avoid recursive core dumps, on setuid files 
>>  the dumpable flag still prevents a core dump while seteuid & co will
>>  result in a core only readable as root.
>
>It's a bit sad to add another function call level to sys_unlink() simply
>because the core dumping code needs it.
>
>Is it not possible to call sys_unlink() directly from there?  Something like
>
>long kernel_unlink(const char *name)
>{
>	mm_segment_t old_fs = get_fs();
>	long ret;
>
>	set_fs(KERNEL_DS);
>	ret = sys_unlink(name);
>	set_fs(old_fs);
>	return ret;
>}	

And you're asking me? ;)
While getname() has a check for user/kernelspace - do you really
care about "the overhead" for a function call level with 1 argument?
Uhm, probably if you even care to write this..

What is the cost for switching the segments?
But I agree that sys_unlink should be the fast call and dumping core
is the exception :)

would fastcall do_unlink() help? I guess the arg is then passed in a
register


