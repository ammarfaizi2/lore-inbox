Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1751084AbWFENGJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751084AbWFENGJ (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 09:06:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751088AbWFENGJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 09:06:09 -0400
Received: from hellhawk.shadowen.org ([80.68.90.175]:16395 "EHLO
	hellhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S1751084AbWFENGI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 09:06:08 -0400
Message-ID: <44842C01.2050604@shadowen.org>
Date: Mon, 05 Jun 2006 14:05:05 +0100
From: Andy Whitcroft <apw@shadowen.org>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Martin J. Bligh" <mbligh@mbligh.org>, Andrew Morton <akpm@osdl.org>
CC: Andy Whitcroft <apw@shadowen.org>, mbligh@google.com,
        linux-kernel@vger.kernel.org, ak@suse.de,
        Hugh Dickins <hugh@veritas.com>
Subject: Re: 2.6.17-rc5-mm1
References: <447DEF49.9070401@google.com>	<20060531140652.054e2e45.akpm@osdl.org>	<447E093B.7020107@mbligh.org> <20060531144310.7aa0e0ff.akpm@osdl.org> <447E104B.6040007@mbligh.org> <447F1702.3090405@shadowen.org>
In-Reply-To: <447F1702.3090405@shadowen.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Whitcroft wrote:
> Martin J. Bligh wrote:
> 
>>Andrew Morton wrote:
>>
>>
>>>"Martin J. Bligh" <mbligh@mbligh.org> wrote:
>>>
>>>
>>>>Andrew Morton wrote:
>>>>
>>>>
>>>>>Martin Bligh <mbligh@google.com> wrote:
>>>>>
>>>>>
>>>>>
>>>>>>The x86_65 panic in LTP has changed a bit. Looks more useful now.
>>>>>>Possibly just unrelated new stuff. Possibly we got lucky.
>>>>>
>>>>>
>>>>>What are you doing to make this happen?
>>>>
>>>>
>>>>runalltests on LTP
> 
> 
> Ok, I think this could well be the same problem I got half way through
> tracking last time round.  We are still handing off threads with
> non-initialised stacks.
> 
> APW: schedule: ffffffff805f0cd8 bad rsp flags=00000000
> Kernel panic - not syncing: BAD STACK POINTER
> 
> Interestingly this has remained unchanged for dispite the major churn
> -mm takes so this could well be the underlying issue as we almost always
> blow up randomly when we do this, in a mess with no stack to work with.
> 
> Last time I tried to split search -mm1 and she was being a hideous pig,
> I just couldn't get any bit of it to compile without the rest.  Will try
> and track this down with the new -mm.

Ok.  Did a split search on -mm2 for this.  With the full stack I was
still tripping up on the bad thread hand-off trigger above.  However,
when split searching I seemed to get somewhat different panics pretty
commonly in the allocator.  My split search led me to the start of the
swapless page migration patches:

GOOD:page-migration-cleanup-pass-mapping-to-migration-functions.patch
GOOD:page-migration-cleanup-move-fallback-handling-into-special-function.patch
----:swapless-pm-add-r-w-migration-entries.patch
-BAD:swapless-pm-add-r-w-migration-entries-fix-2.patch

I tried pretty hard to slide this out of -mm and can't say with
cirtainty that I did it right.  I backed out the following in order to
get the first two off (obviously from the bottom up):

swapless-pm-add-r-w-migration-entries.patch
swapless-pm-add-r-w-migration-entries-fix-2.patch
swapless-page-migration-rip-out-swap-based-logic.patch
swapless-page-migration-modify-core-logic.patch
more-page-migration-do-not-inc-dec-rss-counters.patch
more-page-migration-use-migration-entries-for-file-pages.patch
page-migration-update-documentation.patch
page-migration-simplify-migrate_pages.patch
page-migration-simplify-migrate_pages-tweaks.patch
page-migration-handle-freeing-of-pages-in-migrate_pages.patch
page-migration-use-allocator-function-for-migrate_pages.patch
page-migration-support-moving-of-individual-pages.patch
page-migration-detailed-status-for-moving-of-individual-pages.patch
page-migration-support-moving-of-individual-pages-fixes.patch
page-migration-support-moving-of-individual-pages-x86_64-support.patch
page-migration-support-moving-of-individual-pages-x86-support.patch
   page-migration-support-moving-of-individual-pages-x86-support-fix.patch
page-migration-support-a-vma-migration-function.patch
allow-migration-of-mlocked-pages.patch

That did seem to get rid of the original error.    However, I'm now
experiencing a reiserfs4 panic so I'm not 100% confident the problem
really is gone, but the reiserfs panic isn't anywhere as near hard as
the panic's I have been experiencing; I was able to reboot the machine
even though the tests were not completing correctly.  Full panic for
that one is below:

general protection fault: 0000 [1] SMP
last sysfs file: /devices/pci0000:00/0000:00:06.0/resource
CPU 1
Modules linked in:
Pid: 19163, comm: mkdir09 Not tainted 2.6.17-rc5-mm2-autokern1 #1
RIP: 0010:[<ffffffff802412b0>]  [<ffffffff802412b0>]
check_deadlock+0x1f/0x117
RSP: 0000:ffff8101fb803dd8  EFLAGS: 00010002
RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000000000
RDX: ffff8101f3e64000 RSI: 0000000000000001 RDI: 2222222222222222
RBP: ffff8101fb803df8 R08: 0000000000000000 R09: ffff8101fb803e68
R10: ffff8101fb802000 R11: 00000000ffffff9c R12: ffff8101fcafa7b0
R13: 2222222222222222 R14: 2222222222222222 R15: 0000000000000000
FS:  000000000804a020(0000) GS:ffff8100e3f27e40(0063) knlGS:00000000f7e15460
CS:  0010 DS: 002b ES: 002b CR0: 000000008005003b
CR2: 00000000f7ee2090 CR3: 00000001f4dce000 CR4: 00000000000006e0
Process mkdir09 (pid: 19163, threadinfo ffff8101fb802000, task
ffff8101fdd4b0d0)
Stack: 0000000000000000 ffff8101fcafa7b0 ffff8101f3ae5988 2222222222222222
       ffff8101fb803e28 ffffffff80241361 ffff8101f3ae5988 ffff8101fb802000
       ffff8101fb803e68 ffff8101fdd4b0d0
Call Trace:
 [<ffffffff80241361>] check_deadlock+0xd0/0x117
 [<ffffffff80241574>] debug_mutex_add_waiter+0x57/0x6f
 [<ffffffff8048cf47>] __mutex_lock_slowpath+0xc7/0x232
 [<ffffffff802800bc>] do_path_lookup+0x258/0x29c
 [<ffffffff8048d0bb>] mutex_lock+0x9/0xb
 [<ffffffff802816db>] do_rmdir+0x84/0xfc
 [<ffffffff80281764>] sys_rmdir+0x11/0x13
 [<ffffffff8021c2d6>] ia32_sysret+0x0/0xa


Code: 48 8b 57 18 48 85 d2 0f 84 e2 00 00 00 4c 8b 22 45 31 f6 49
RIP  [<ffffffff802412b0>] check_deadlock+0x1f/0x117 RSP <ffff8101fb803dd8>
 NMI Watchdog detected LOCKUP on CPU 0
CPU 0
Modules linked in:
Pid: 19164, comm: mkdir09 Not tainted 2.6.17-rc5-mm2-autokern1 #1
RIP: 0010:[<ffffffff8048d626>]  [<ffffffff8048d626>]
.text.lock.mutex+0x2f/0x65
RSP: 0000:ffff8101f3e65e98  EFLAGS: 00000086
RAX: 0000000000000000 RBX: ffff81007b8ec748 RCX: 0000000000000012
RDX: 0000000000000000 RSI: 0000000000000012 RDI: ffff8101f3ae5988
RBP: ffff8101f3e65eb8 R08: ffff8101803f6cf8 R09: ffff81007b8ec748
R10: 000000000000002f R11: 0000000000000000 R12: ffff8101f3ae5988
R13: 0000000000000246 R14: 0000000000000000 R15: 0000000000000000
FS:  000000000804a020(0000) GS:ffffffff8061b000(0063) knlGS:00000000f7e15460
CS:  0010 DS: 002b ES: 002b CR0: 000000008005003b
CR2: 00000000f7ed5cc0 CR3: 00000001f52e4000 CR4: 00000000000006e0
Process mkdir09 (pid: 19164, threadinfo ffff8101f3e64000, task
ffff8101fcafa7b0)
Stack: 0000000000000012 ffff81007b8ec748 0000000000000000 ffff81007b92a000
       ffff8101f3e65ec8 ffffffff8048d2a3 ffff8101f3e65f68 ffffffff8028172a
       ffff8101f4dd49b8 ffff810180051ec0
Call Trace:
 [<ffffffff8048d2a3>] mutex_unlock+0x9/0xb
 [<ffffffff8028172a>] do_rmdir+0xd3/0xfc
 [<ffffffff80281764>] sys_rmdir+0x11/0x13
 [<ffffffff8021c2d6>] ia32_sysret+0x0/0xa

-apw
