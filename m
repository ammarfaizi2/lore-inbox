Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264281AbTLAVgk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Dec 2003 16:36:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264282AbTLAVgk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Dec 2003 16:36:40 -0500
Received: from www14.mailshell.com ([209.157.66.246]:60613 "HELO mailshell.com")
	by vger.kernel.org with SMTP id S264281AbTLAVga (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Dec 2003 16:36:30 -0500
Message-ID: <20031201213624.18232.qmail@mailshell.com>
Date: Mon, 01 Dec 2003 23:36:20 +0200
X-Accept-Language: en-us, en
MIME-Version: 1.0
Subject: Re: PROBLEM: 2.6test11 kernel panic on "head -1 /proc/net/tcp"
References: <20031128170138.9513.qmail@mailshell.com>	 <87d6bc2yvq.fsf@devron.myhome.or.jp>	 <20031129170034.10522.qmail@mailshell.com> <1070242158.1110.150.camel@buffy> <3FCBAE6F.1090405@myrealbox.com>
In-Reply-To: <3FCBAE6F.1090405@myrealbox.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
From: lkml-031128@amos.mailshell.com
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonathan,

I'm not sure I understand - what exactly froze your machine?
My machine used to freeze on "head -1 /proc/net/tcp" until
I added that one-line suggested by Mr. Ogawa.

After I added Ogawa's line, "head -1 /proc/net/tcp" stopped
freezing my machine but PPP failed to work.

Also after adding Ogawa's line, PPP works fine (as it is now, as
I write this message) as long as I don't try "head -1 /proc/net/tcp"
after boot. If I'll try "head -1 /proc/net/tcp" now PPP will stop
working.

So which situation did you confirm to reproduce?

Thanks,

--Amos

Jonathan Fors wrote:
> Thomas Cataldo wrote:
> 
>> On Sat, 2003-11-29 at 18:00, lkml-031128@amos.mailshell.com wrote:
>>  
>>
>>> Partially.  It seems to trigger ppp failure later.
>>>   
>>
>> [...]
>>  
>>
>>> This gives me tons of messages like the following:
>>>
>>> Badness in local_bh_enable at kernel/softirq.c:121
>>> Call Trace:
>>>  [<c011df25>] local_bh_enable+0x85/0x90
>>>  [<c02315e2>] ppp_async_push+0xa2/0x180
>>>  [<c0230efd>] ppp_asynctty_wakeup+0x2d/0x60
>>>  [<c0202638>] pty_unthrottle+0x58/0x60
>>>  [<c01ff0fd>] check_unthrottle+0x3d/0x40
>>>  [<c01ff1a3>] n_tty_flush_buffer+0x13/0x60
>>>  [<c0202a47>] pty_flush_buffer+0x67/0x70
>>>  [<c01fba41>] do_tty_hangup+0x3f1/0x460
>>>  [<c01fcfbc>] release_dev+0x62c/0x660
>>>  [<c013dfab>] zap_pmd_range+0x4b/0x70
>>>  [<c013e013>] unmap_page_range+0x43/0x70
>>>  [<c01622a2>] dput+0x22/0x210
>>>  [<c01fd38a>] tty_release+0x2a/0x60
>>>  [<c014ccf8>] __fput+0x108/0x120
>>>  [<c014b359>] filp_close+0x59/0x90
>>>  [<c011b874>] put_files_struct+0x54/0xc0
>>>  [<c011c47d>] do_exit+0x15d/0x3e0
>>>  [<c011c79a>] do_group_exit+0x3a/0xb0
>>>  [<c01091b7>] syscall_call+0x7/0xb
>>>   
>>
>>
>> I just looked at my logs and realised I add a similar oops in my log. It
>> happened a few days ago on 2.6.0-test10 (I failed to notice because
>> everything seems to work fine).
>>
>> Here is what I have :
>>
>> Badness in local_bh_enable at kernel/softirq.c:121
>> Call Trace:
>> [<c01251d3>] local_bh_enable+0x93/0xa0
>> [<f997dced>] ppp_async_push+0xbd/0x1b0 [ppp_async]
>> [<f997d58e>] ppp_asynctty_wakeup+0x2e/0x70 [ppp_async]
>> [<c01cc619>] pty_unthrottle+0x59/0x60
>> [<c01c8c1b>] check_unthrottle+0x3b/0x40
>> [<c01c8cd3>] n_tty_flush_buffer+0x13/0x60
>> [<c01cca2d>] pty_flush_buffer+0x6d/0x70
>> [<c01cc9c0>] pty_flush_buffer+0x0/0x70
>> [<c01c4ee3>] do_tty_hangup+0x4e3/0x580
>> [<c01c6752>] release_dev+0x742/0x780
>> [<c013f82c>] __pagevec_free+0x1c/0x30
>> [<c014487e>] release_pages+0x7e/0x1a0
>> [<c0171bb1>] dput+0x31/0x270
>> [<c01c6b7b>] tty_release+0x3b/0x90
>> [<c015a3db>] __fput+0x10b/0x120
>> [<c01588e9>] filp_close+0x59/0x90
>> [<c0122634>] put_files_struct+0x64/0xd0
>> [<c01233cf>] do_exit+0x19f/0x4c0
>> [<c01237c2>] do_group_exit+0x42/0xe0
>> [<c0109539>] sysenter_past_esp+0x52/0x71
>>
>> The previous line in my logs was from my TI acx100 wifi card. It runs
>> with the experimental driver from http://acx100.sf.net. So if this oops
>> can be caused by bad driver behaviour, please ignore.
>>
>> I am using ppp with pppoe on a ne2k-pci network board.
>>
>> I have smp (dual-p3) and preemption enabled. The kernel is compiled with
>> gcc 3.3.1-2 from debian sid.
>>
>>
>> -
>> To unsubscribe from this list: send the line "unsubscribe 
>> linux-kernel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> Please read the FAQ at  http://www.tux.org/lkml/
>>
>>
>>  
>>
> I can verify that one, tried it on my pentium 2 and it  froze the 
> machine (i was NOT root then) . Had to SysRQ the box to get up again.
> 
> My machine is:
> Dell Optiplek Gx1
> 350MhZ Pentium 2 Deschutes
> 190 MB Pc100 SDRAM
> Gentoo Linux 1.4
> GCC 3.2.3
> Kernel: 2.6.0-test11 modified only with bootsplash patch
> Preempt ENABLED
> 
> 
> 
> ---------- Your email is protected by Mailshell ---------- To block spam 
> or change delivery options: 
> http://www.mailshell.com/control.html?a=blue1spxa32bf9syihlatspyammgqquwzqnwz8k 
> 
> 
> ReturnPath.net http://rd.mailshell.com/ad481
> Earn up to $3 for each of your friends who signs up with Mailshell! 
> http://rd.mailshell.com/sp5


