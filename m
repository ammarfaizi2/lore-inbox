Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268593AbUIQIwS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268593AbUIQIwS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 04:52:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268591AbUIQIwQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 04:52:16 -0400
Received: from corpmail.outblaze.com ([203.86.166.82]:41386 "EHLO
	corpmail.outblaze.com") by vger.kernel.org with ESMTP
	id S268588AbUIQIvw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 04:51:52 -0400
Message-ID: <414AA5A6.3020907@outblaze.com>
Date: Fri, 17 Sep 2004 16:51:50 +0800
From: Christopher Chan <cchan@outblaze.com>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040908)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: Seiji Kihara <kihara.seiji@lab.ntt.co.jp>, ext3-users@redhat.com,
       ospfs@lab.ntt.co.jp, linux-fsdevel@vger.kernel.org, sct@redhat.com,
       adilger@clusterfs.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] BUG on fsync/fdatasync with Ext3 data=journal
References: <ufz5i5q4r.wl%kihara.seiji@lab.ntt.co.jp> <20040916145059.44a7e800.akpm@osdl.org>
In-Reply-To: <20040916145059.44a7e800.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiVirus: checked by Vexira MailArmor (version: 2.0.2-5; VAE: 6.27.0.10; VDF: 6.27.0.65; host: corpmail.outblaze.com)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Seiji Kihara <kihara.seiji@lab.ntt.co.jp> wrote:
> 
>>We found that fsync and fdatasync syscalls sometimes don't sync
>>data in an ext3 file system under the following conditions.
>>
>>1. Kernel version is 2.6.6 or later (including 2.6.8.1 and 2.6.9-rc2).
>>2. Ext3's journalling mode is "data=journal".
>>
>>The problem was occurred since 2.6.5-bk1, which includes the patch
>>"[PATCH] ext3 fsync() and fdatasync() speedup".  We found that the
>>problem was solved by deleting the part of the patch which
>>modifies ext3_sync_file().  Maybe, i_state is not correctly set to
>>I_DIRTY when the related page cache is dirty (is it true?)
> 

I have a few qmail (about the heaviest fsync using mta software around) 
boxes that have their queues on ext3.

On a 2.6.7 kernel, these guys are guaranteed to crash within hours if I 
used data=journal for the fs on which the qmail queues are. I say this 
because I ran two of them with data=journal mode and they crashed once 
or more a day. Another one which stayed with ordered had no problems 
during the same period.

Going back to ordered meant that they ran stable for days (weeks now).

The only thing I could get from the logs is:

---------------------------

Aug 17 05:58:22 mta1-7 kernel: Assertion failure in 
__journal_drop_transaction() at fs/jbd/checkpoint.c:613: "transaction->t
_forget == NULL"
Aug 17 05:58:22 mta1-7 kernel: ------------[ cut here ]------------
Aug 17 05:58:22 mta1-7 kernel: kernel BUG at fs/jbd/checkpoint.c:613!
Aug 17 05:58:22 mta1-7 kernel: invalid operand: 0000 [#1]
Aug 17 05:58:22 mta1-7 kernel: SMP
Aug 17 05:58:22 mta1-7 kernel: Modules linked in: nfs lockd sunrpc e1000 
e100 mii usbcore
Aug 17 05:58:22 mta1-7 kernel: CPU:    0
Aug 17 05:58:22 mta1-7 kernel: EIP:    0060:[<c0193db0>]    Not tainted
Aug 17 05:58:22 mta1-7 kernel: EFLAGS: 00010202   (2.6.7)

