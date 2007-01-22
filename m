Return-Path: <linux-kernel-owner+w=401wt.eu-S1751760AbXAVCbW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751760AbXAVCbW (ORCPT <rfc822;w@1wt.eu>);
	Sun, 21 Jan 2007 21:31:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751878AbXAVCbW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Jan 2007 21:31:22 -0500
Received: from mail9.hitachi.co.jp ([133.145.228.44]:33491 "EHLO
	mail9.hitachi.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751760AbXAVCbV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Jan 2007 21:31:21 -0500
Message-ID: <45B42194.3050601@hitachi.com>
Date: Mon, 22 Jan 2007 11:29:40 +0900
From: "Kawai, Hidehiro" <hidehiro.kawai.ez@hitachi.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; ja-JP; rv:1.4) 
    Gecko/20030624 Netscape/7.1 (ax)
X-Accept-Language: ja
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       gregkh@suse.de, james.bottomley@steeleye.com,
       Satoshi OSHIMA <soshima@redhat.com>,
       "Hideo AOKI@redhat" <haoki@redhat.com>,
       sugita <yumiko.sugita.yf@hitachi.com>,
       Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] binfmt_elf: core dump masking support
References: <457FA840.5000107@hitachi.com> 
    <20061213132358.ddcaaaf4.akpm@osdl.org> <20061220154056.GA4261@ucw.cz> 
    <45A2EADF.3030807@hitachi.com> <20070109143912.GC19787@elf.ucw.cz> 
    <45A74B89.4040100@hitachi.com> <20070114200157.GA2582@elf.ucw.cz> 
    <45B01387.7010207@hitachi.com> <20070119004548.GE10351@elf.ucw.cz>
In-Reply-To: <20070119004548.GE10351@elf.ucw.cz>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,

>>>>The /proc/<pid>/ approach doesn't have these demerits, and it
>>>>has an advantage that users can change the bitmask of any process
>>>>at anytime.
>>>
>>>Well... not sure if it is advantage. 
>>
>>For example, consider the following case:
>>  a process forks many children and system administrator wants to
>>  allow only one of these processes to dump shared memory.
>>
>>This is accomplished as follows:
>>
>> $ echo 1 > /proc/self/coremask
>> $ ./some_program
>> (fork children)
>> $ echo 0 > /proc/<a child's pid>/coremask
>>
>>With the /proc/<pid>/ interface, we don't need to modify the
>>user program.  In contrast, with the ulimit or setrlimit interface,
>>the administrator can't do it without modifying the user program
>>to call setrlimit.  This will not be preferred.
> 
> Yep, otoh process coremask setting can change while it is running,
> that is not expected. Hmm, it can also change while it is dumping
> core, are you sure it is not racy?

Good point, thanks.  I never thought of that.
We can change the coremask setting while dumping the process's
memory, and it is problematic.

maydump() function which decides a given VMA may be dumped or not
is invoked twice per VMAs.  One is at the time of writing a program
header for a VMA, another is at the time of writing its contents.
If the coremask setting differs between the two, the program
header will point wrong place in the core file as its contents.

 
> (run echo 1 > coremask, echo 0 > coremask in a loop while dumping
> core. Do you have enough locking to make it work as expected?)

Currently, any lock isn't acquired.  But I think the kernel only
have to preserve the coremask setting in a local variable at the
begining of core dumping.  I'm going to do this in the next version.

Best regards,
-- 
Hidehiro Kawai
Hitachi, Ltd., Systems Development Laboratory


