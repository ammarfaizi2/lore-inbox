Return-Path: <SRS0=oqI+=ZD=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0555C43331
	for <io-uring@archiver.kernel.org>; Mon, 11 Nov 2019 04:19:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B305120818
	for <io-uring@archiver.kernel.org>; Mon, 11 Nov 2019 04:19:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726756AbfKKET1 convert rfc822-to-8bit (ORCPT
        <rfc822;io-uring@archiver.kernel.org>);
        Sun, 10 Nov 2019 23:19:27 -0500
Received: from smtpbgsg2.qq.com ([54.254.200.128]:54395 "EHLO smtpbgsg2.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726754AbfKKET1 (ORCPT <rfc822;io-uring@vger.kernel.org>);
        Sun, 10 Nov 2019 23:19:27 -0500
X-QQ-mid: bizesmtp17t1573445961tabenr2u
Received: from [192.168.142.168] (unknown [218.76.23.26])
        by esmtp6.qq.com (ESMTP) with 
        id ; Mon, 11 Nov 2019 12:19:20 +0800 (CST)
X-QQ-SSF: 00400000002000T0ZU90000A0000000
X-QQ-FEAT: 8EH74LRXnGwJzwqDgsyfOqBPv3P3CAci3xmrrqnBF3su//jSAMhEwHWT26yQc
        p3h2HVX/itw2/exXsMqDreZ5oqqP6CYc+otEWFIwbaNfKygofZO5ww2htDFFMRiObiHh5Q7
        JK+L9qj5Innb9w0PqmHMIxrp7GxFiMiVd/wsZHP7odTZ7ulOyDvgxwYh5AYofZbmWnT5tZN
        Jm+lqHfYRViVQ0o/xCNODRWVKv35K9Vi20o9LcffwJAfnm47/i3zkbUP4NzA8XUL+578umZ
        KCBSf7pQWrYjUIWtYJzb66frUc0nT8ORgof2qEsOJ4qQttsgzDhJXcciQoTYhC3taNJwQX2
        VCw6E2NboleX9EJCwlqEmct7z0Vfg==
X-QQ-GoodBg: 2
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3601.0.10\))
Subject: Re: [PATCH] io_uring: fix error clear of ->file_table in
 io_sqe_files_register()
From:   Jackie Liu <liuyun01@kylinos.cn>
In-Reply-To: <834e83ff-e03c-24a0-0f50-1995d944056a@kernel.dk>
Date:   Mon, 11 Nov 2019 12:19:19 +0800
Cc:     Bob Liu <bob.liu@oracle.com>, io-uring@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <5F7B4358-5805-4D83-AE99-5222A109B68D@kylinos.cn>
References: <9851837d-47f3-abfe-8c19-f518e0935b22@kernel.dk>
 <e2309d10-73bf-0af3-5687-b701d6d6cb3a@oracle.com>
 <dd9711ef-cc21-1177-8aae-59e3b9a19447@kernel.dk>
 <A20A2F95-A658-44B9-B859-370832A072A0@kylinos.cn>
 <834e83ff-e03c-24a0-0f50-1995d944056a@kernel.dk>
To:     Jens Axboe <axboe@kernel.dk>
X-Mailer: Apple Mail (2.3601.0.10)
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:kylinos.cn:qybgforeign:qybgforeign7
X-QQ-Bgrelay: 1
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org



> 2019年11月11日 12:09，Jens Axboe <axboe@kernel.dk> 写道：
> 
> On 11/10/19 9:02 PM, Jackie Liu wrote:
>> 
>> 
>>> 2019年11月11日 11:54，Jens Axboe <axboe@kernel.dk> 写道：
>>> 
>>> On 11/10/19 4:44 PM, Bob Liu wrote:
>>>> On 11/10/19 11:46 PM, Jens Axboe wrote:
>>>>> syzbot reports that when using failslab and friends, we can get a double
>>>>> free in io_sqe_files_unregister():
>>>>> 
>>>>> BUG: KASAN: double-free or invalid-free in
>>>>> io_sqe_files_unregister+0x20b/0x300 fs/io_uring.c:3185
>>>>> 
>>>>> CPU: 1 PID: 8819 Comm: syz-executor452 Not tainted 5.4.0-rc6-next-20191108
>>>>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
>>>>> Google 01/01/2011
>>>>> Call Trace:
>>>>>   __dump_stack lib/dump_stack.c:77 [inline]
>>>>>   dump_stack+0x197/0x210 lib/dump_stack.c:118
>>>>>   print_address_description.constprop.0.cold+0xd4/0x30b mm/kasan/report.c:374
>>>>>   kasan_report_invalid_free+0x65/0xa0 mm/kasan/report.c:468
>>>>>   __kasan_slab_free+0x13a/0x150 mm/kasan/common.c:450
>>>>>   kasan_slab_free+0xe/0x10 mm/kasan/common.c:480
>>>>>   __cache_free mm/slab.c:3426 [inline]
>>>>>   kfree+0x10a/0x2c0 mm/slab.c:3757
>>>>>   io_sqe_files_unregister+0x20b/0x300 fs/io_uring.c:3185
>>>>>   io_ring_ctx_free fs/io_uring.c:3998 [inline]
>>>>>   io_ring_ctx_wait_and_kill+0x348/0x700 fs/io_uring.c:4060
>>>>>   io_uring_release+0x42/0x50 fs/io_uring.c:4068
>>>>>   __fput+0x2ff/0x890 fs/file_table.c:280
>>>>>   ____fput+0x16/0x20 fs/file_table.c:313
>>>>>   task_work_run+0x145/0x1c0 kernel/task_work.c:113
>>>>>   exit_task_work include/linux/task_work.h:22 [inline]
>>>>>   do_exit+0x904/0x2e60 kernel/exit.c:817
>>>>>   do_group_exit+0x135/0x360 kernel/exit.c:921
>>>>>   __do_sys_exit_group kernel/exit.c:932 [inline]
>>>>>   __se_sys_exit_group kernel/exit.c:930 [inline]
>>>>>   __x64_sys_exit_group+0x44/0x50 kernel/exit.c:930
>>>>>   do_syscall_64+0xfa/0x760 arch/x86/entry/common.c:290
>>>>>   entry_SYSCALL_64_after_hwframe+0x49/0xbe
>>>>> RIP: 0033:0x43f2c8
>>>>> Code: 31 b8 c5 f7 ff ff 48 8b 5c 24 28 48 8b 6c 24 30 4c 8b 64 24 38 4c 8b
>>>>> 6c 24 40 4c 8b 74 24 48 4c 8b 7c 24 50 48 83 c4 58 c3 66 <0f> 1f 84 00 00
>>>>> 00 00 00 48 8d 35 59 ca 00 00 0f b6 d2 48 89 fb 48
>>>>> RSP: 002b:00007ffd5b976008 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
>>>>> RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 000000000043f2c8
>>>>> RDX: 0000000000000000 RSI: 000000000000003c RDI: 0000000000000000
>>>>> RBP: 00000000004bf0a8 R08: 00000000000000e7 R09: ffffffffffffffd0
>>>>> R10: 0000000000000001 R11: 0000000000000246 R12: 0000000000000001
>>>>> R13: 00000000006d1180 R14: 0000000000000000 R15: 0000000000000000
>>>>> 
>>>>> This happens if we fail allocating the file tables. For that case we do
>>>>> free the file table correctly, but we forget to set it to NULL. This
>>>>> means that ring teardown will see it as being non-NULL, and attempt to
>>>>> free it again.
>>>>> 
>>>>> Fix this by clearing the file_table pointer if we free the table.
>>>>> 
>>>>> Reported-by: syzbot+3254bc44113ae1e331ee@syzkaller.appspotmail.com
>>>>> Fixes: 65e19f54d29c ("io_uring: support for larger fixed file sets")
>>>>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>>>>> 
>>>> 
>>>> Reviewed-by: Bob Liu <bob.liu@oracle.com>
>>> 
>>> Thanks, added.
>>> 
>>>> By the way, there are many place(besides io_uring.c) which need to set
>>>> pointer to NULL after free.  I saw similar fix from time to time.
>>>> 
>>>> Do you think a safe_free() is worth? e.g
>>>> #define SAFE_FREE(p) { if (p) { free(p); (p)=NULL; } }
>>> 
>>> Hmm not sure, and would probably be better as:
>>> 
>>> kfree_safe(&ptr);
>>> 
>>> or something instead. I seem to recall discussions about that ages ago,
>>> probably worth while to try and search and see if you can find those. I
>>> suspect Linus hates it, reasons not remembered ;-)
>>> 
>> 
>> I think this may be a worthwhile solution, but kfree can handle NULL, we can
>> set it to NULL directly after free is finished.
>> 
>> void kfree_safe(const void *ptr)
>> {
>> 	kfree(ptr);
>> 	ptr = NULL;
>> }
> 
> Sure, but that doesn't change the ptr in the caller, which was my point.
> You need to pass in a pointer to the pointer for that, otherwise
> clearing it in kfree_safe() is pointless:
> 
> void kfree_safe(const void **ptr)
> {
> 	kfree(*ptr);
> 	*ptr = NULL;
> }

Yes, you are right. If it is set to NULL directly, if it is wrong, it can be
panic immediately, which is convenient for debugging.

> 
> and then you run into all sorts of fun, since void ** isn't the same as
> 'struct foo **'.
> 


--
BR, Jackie Liu



