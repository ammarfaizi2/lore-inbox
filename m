Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265265AbUFHReD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265265AbUFHReD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jun 2004 13:34:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265263AbUFHReD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jun 2004 13:34:03 -0400
Received: from mail.tmr.com ([216.238.38.203]:55307 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S265260AbUFHRd7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jun 2004 13:33:59 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Bill Davidsen <davidsen@tmr.com>
Newsgroups: mail.linux-kernel
Subject: Re: msync() oops in 2.6.7-rc2-bk1
Date: Tue, 08 Jun 2004 13:34:34 -0400
Organization: TMR Associates, Inc
Message-ID: <ca4t2l$p5t$1@gatekeeper.tmr.com>
References: <c9pvrd$v39$1@news.cistron.nl> <20040604213315.7060e7da.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Trace: gatekeeper.tmr.com 1086715797 25789 192.168.12.100 (8 Jun 2004 17:29:57 GMT)
X-Complaints-To: abuse@tmr.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208
X-Accept-Language: en-us, en
In-Reply-To: <20040604213315.7060e7da.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> "Miquel van Smoorenburg" <miquels@cistron.nl> wrote:
> 
>>I'm running a news server. The innd process uses mmap()s for several
>>files and uses msync() to force synchronization to disk every so
>>often. Suddenly, an msync() causes an oops (and innd SEGVs). This
>>is after the box has been up and running for 3 days:
>>
>># uname -a
>>Linux enterprise 2.6.7-rc2-bk1 #1 Mon May 31 15:03:52 CEST 2004 i686 GNU/Linux
>>
>> <1>Unable to handle kernel NULL pointer dereference at virtual address 00000000 printing eip:
>>c0149120
>>*pde = 00000000
>>Oops: 0002 [#5]
>>Modules linked in: e100 mii
>>CPU:    0
>>EIP:    0060:[<c0149120>]    Not tainted
>>EFLAGS: 00010213   (2.6.7-rc2-bk1)
>>EIP is at __set_page_dirty_buffers+0x20/0xb0
>>eax: 00000000   ebx: f77a1e7c   ecx: c15706e0   edx: eba5a83c
>>esi: 5ccfb000   edi: 00000000   ebp: 5d000000   esp: f44b5efc
>>ds: 007b   es: 007b   ss: 0068
>>Process innd (pid: 10936, threadinfo=f44b5000 task=d0eb2c70)
>>Stack: f77a1de4 00000004 00000000 c4af23ec c013143e c15706e0 c013da1c 5ccfb000
>>       c4af23f0 c013db0f c4af23ec f7101900 5ccfb000 00000001 5cc00000 ce8b25d0
>>       00000000 5d000000 c013dbc3 ce8b25cc 5cc00000 5d000000 f7101900 00000001
>>Call Trace:
>> [<c013143e>] set_page_dirty+0x3e/0x50
>> [<c013da1c>] filemap_sync_pte+0x5c/0x80
>> [<c013db0f>] filemap_sync_pte_range+0xcf/0xf0
>> [<c013dbc3>] filemap_sync+0x93/0x100
>> [<c013dc96>] msync_interval+0x66/0xf0
>> [<c013de37>] sys_msync+0x117/0x123
>> [<c0103c7b>] syscall_call+0x7/0xb
>>
>>Code: 0f ba 28 01 8b 40 08 39 d0 75 f5 0f ba 29 04 19 c0 85 c0 75
> 
> 
> You have a page which has PG_private set, but page->private is NULL.  And
> the machine is non-SMP, non-preempt, yes?
> 
> I'd be wondering whether that machine has flipped a bit in page->flags,
> frankly.  How old is it?
> 
> Was the mmap of a regular file or of a block device?

I don't think so... I have a number of machines, also news servers, 
which are producing various errors in filemap. In the RH2.4.21-15 kernel 
it shows up in filemap_sync_pte_range, which is now in msync. It appears 
to be a bad pte coming in, I see the error at pmd_bad sometimes.

I see it with several applications, all news, all mmap() heavily.

Sorry I can't tell you more, but it happens on multiple brand-new Xeon 
systems. If he is seeing similar on an Athlon I would assume that it's 
some "less traveled way" in the kernel, because I have a limited ability 
to believe in coincidence.


-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
