Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262406AbUJHTng@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262406AbUJHTng (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 15:43:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263540AbUJHTng
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 15:43:36 -0400
Received: from [195.23.16.24] ([195.23.16.24]:23744 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S262406AbUJHTnd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 15:43:33 -0400
Message-ID: <4166EDC9.7@grupopie.com>
Date: Fri, 08 Oct 2004 20:43:05 +0100
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Albert Cahalan <albert@users.sf.net>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>,
       Linux Kernel List <linux-kernel@vger.kernel.org>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Catalin Marinas <Catalin.Marinas@arm.com>,
       Richard Earnshaw <Richard.Earnshaw@arm.com>,
       Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [RFC] ARM binutils feature churn causing kernel problems
References: <20040927210305.A26680@flint.arm.linux.org.uk>	 <20041008160456.H17999@flint.arm.linux.org.uk>	 <4166C216.2080305@grupopie.com> <1097259244.2673.2646.camel@cube>
In-Reply-To: <1097259244.2673.2646.camel@cube>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiVirus: checked by Vexira MailArmor (version: 2.0.1.16; VAE: 6.28.0.3; VDF: 6.28.0.7; host: bipbip)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Albert Cahalan wrote:
> ....
> 
> No, the /proc/*/wchan file is supposed to be used.
> For some reason, stat() is failing. Here is the code:
> 
>   // next try the Linux 2.5.xx method
>   if(!stat("/proc/self/wchan", &sbuf)){
>     use_wchan_file = 1; // hack
>     return 0;
>   }
> 
> See what these commands tell you:
> 
> strace -o data -e trace=stat ps alx >> /dev/null ; grep self data
> stat /proc/self/wchan
> stat /proc/$$/wchan
> stat /proc/self/
> stat /proc/self

You are right. I just tested this on my system and ps doesn't read any 
System.map at all, provided there is a /proc/<pid>/wchan file to read from.

>>If this is the case, then after the changes to kallsyms go in, procps 
>>could start using wchan directly and avoid reading the System.map 
>>altogether.
> 
> 
> Here's an idea: if both name and number were provided
> at the same time and I could get notified when a module
> is loaded or unloaded, then I could cache the
> number-to-name translation.

This is more a question of whether kallsyms is a good feature to have 
always (modulo embedded or very limited memory systems) or not. If 
kallsyms is always available, the procps tools already read 
/proc/<pid>/wchan and don't need to cache anything at all. The only 
reason to cache would be performance, but if you try a recent -mm kernel 
you can see that there is no need for that any more.

 From what I've seen on this list since I've joined (almost a year ago), 
2.4 stack dumps are almost useless[1] whereas the 2.6 ones give very 
useful information thanks to the function names (and offsets) that lead 
to the problem.

IMHO we should try to make kallsyms always available, reducing further 
the space used by the symbol data if necessary.

-- 
Paulo Marques - www.grupopie.com

To err is human, but to really foul things up requires a computer.
Farmers' Almanac, 1978

[1] of course using ksymoops would solve this, but it requires more 
knowledge from the user than kallsyms, so it is not the same thing
