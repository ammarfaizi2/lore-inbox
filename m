Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1750772AbWFEJAY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750772AbWFEJAY (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 05:00:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750810AbWFEJAY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 05:00:24 -0400
Received: from wx-out-0102.google.com ([66.249.82.202]:57351 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1750772AbWFEJAW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 05:00:22 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=NCrJQwIFOPD31JWDivsNMvkBwlcaKuGDeERRSLjnYkHP/4lVl87msiEyX3Rp37Q3OQbHwV+aQ1zCHNADdTq16/BePVjRj2smMmvO4ZzkG3XO9Yraj6kKN8WPNQih/gf+FsZC3ArX7OymGAoZPhGIdZMNKObVT7UueYt/ai59Vxk=
Message-ID: <986ed62e0606050200w67514c6ey2794b59b1bd0cbec@mail.gmail.com>
Date: Mon, 5 Jun 2006 02:00:20 -0700
From: "Barry K. Nathan" <barryn@pobox.com>
To: "Ingo Molnar" <mingo@elte.hu>
Subject: Re: 2.6.17-rc5-mm3: bad unlock ordering (reiser4?)
Cc: Valdis.Kletnieks@vt.edu, "Andrew Morton" <akpm@osdl.org>,
        arjan@linux.intel.com, linux-kernel@vger.kernel.org,
        reiserfs-dev@namesys.com, "Hans Reiser" <reiser@namesys.com>
In-Reply-To: <20060605081220.GA30123@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <986ed62e0606040504n148bf744x77bd0669a5642dd0@mail.gmail.com>
	 <20060604133326.f1b01cfc.akpm@osdl.org>
	 <200606042056.k54KuoKQ005588@turing-police.cc.vt.edu>
	 <20060604213432.GB5898@elte.hu>
	 <986ed62e0606041503v701f8882la4cbead47ae3982f@mail.gmail.com>
	 <20060605065444.GA27445@elte.hu>
	 <986ed62e0606050058v21b457a7tb4da4da62cb7e4e3@mail.gmail.com>
	 <20060605081220.GA30123@elte.hu>
X-Google-Sender-Auth: 0b7fe89632975356
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/5/06, Ingo Molnar <mingo@elte.hu> wrote:
>
> * Barry K. Nathan <barryn@pobox.com> wrote:
[snip]
> > So, does that mean the plan is to annotate/tweak things in order to
> > shut up *each and every* false positive in the kernel?
>
> yes. Note that for the many reasons i outlined before they are only
> "half false positives" - i.e. they are potentially dangerous constructs
> and they are potentially inefficient - hence we _want to_ document them
> in the code, to increase the cleanliness of the kernel. A pure "false
> positive" would be a totally valid and perfect locking construct being
> flagged by the lock validator.
>
> nor do these warnings really hurt anyone. Lockdep prints info and then
> shuts up - the system continues to work.

Ok, thanks for explaining that.

> > Anyway, I tried your patch and I got this:
>
> please try the addon patch below.

I don't know if you saw this comment on the lock validator article at LWN?

---begin quote---
The kernel lock validator
Posted May 31, 2006 9:35 UTC (Wed) by subscriber nix [Link]

... and now reiser4 turns up with a tree of locks where each rank may
be taken within the rank above safely, but where there are a
potentially unbounded number of ranks...
---end quote---

I have no idea if that's actually the case, but if it is, it might be relevant.

Anyway, I have a new, more scary-looking lockdep warning:

http://members.cox.net/barrykn/linux/trace/dmesg.reiser4-4
http://members.cox.net/barrykn/linux/trace/latency_trace_reiser4-4.bz2

[  316.680616] (            smbd-824  |#0): new 239822061 us user-latency.
[  316.680805] stopped custom tracer.
[  316.680951]
[  316.680964] =====================================================
[  316.681241] [ BUG: possible circular locking deadlock detected! ]
[  316.681412] -----------------------------------------------------
[  316.681575] smbd/824 is trying to acquire lock:
[  316.681727]  (&txnh->hlock){--..}, at: [<e09a884a>]
txn_end+0x3f9/0x47c [reiser4]
[  316.682366]
[  316.682379] but task is already holding lock:
[  316.682629]  (&atom->alock){--..}, at: [<e09a78da>]
txnh_get_atom+0x23/0x85 [reiser4]
[  316.683192]
[  316.683206] which lock already depends on the new lock,
[  316.683472] which could lead to circular deadlocks!
[  316.683633]
[  316.683648] the existing dependency chain (in reverse order) is:
[  316.683922]
[  316.683936] -> #1 (&atom->alock){--..}:
[  316.684392]        [<c012f30f>] lockdep_acquire+0x67/0x7f
[  316.685084]        [<c029b67f>] _spin_lock+0x1d/0x2b
[  316.685772]        [<e09a7c0c>] try_capture+0x2d0/0x9cb [reiser4]
[  316.686514]        [<e09a214d>] longterm_lock_znode+0x2fc/0x415 [reiser4]
[  316.687245]        [<e09af884>] coord_by_handle+0x142/0xb76 [reiser4]
[  316.687982]        [<e09b03cc>] coord_by_key+0x55/0x5a [reiser4]
[  316.688714]        [<e09a3ca5>] insert_by_key+0x31/0x5c [reiser4]
[  316.689483]        [<e09bb77d>]
write_sd_by_inode_common+0x117/0x502 [reiser4]
[  316.690340]        [<e09bbb95>] create_object_common+0x2d/0x37 [reiser4]
[  316.691092]        [<e09b8f57>] create_vfs_object+0x376/0x551 [reiser4]
[  316.691841]        [<e09b91bb>] create_common+0x44/0x4b [reiser4]
[  316.692581]        [<c0167a6e>] vfs_create+0x67/0xad
[  316.693259]        [<c016a832>] open_namei+0x19b/0x6cd
[  316.693936]        [<c0158d64>] do_filp_open+0x2b/0x42
[  316.694621]        [<c0158ddc>] do_sys_open+0x61/0xef
[  316.695276]        [<c0158e9d>] sys_open+0x18/0x1a
[  316.695934]        [<c029b8cc>] syscall_call+0x7/0xb
[  316.696629]
[  316.696643] -> #0 (&txnh->hlock){--..}:
[  316.697087]        [<c012f30f>] lockdep_acquire+0x67/0x7f
[  316.697781]        [<c029b67f>] _spin_lock+0x1d/0x2b
[  316.698451]        [<e09a884a>] txn_end+0x3f9/0x47c [reiser4]
[  316.699242]        [<e09a443c>] reiser4_exit_context+0xb2/0x125 [reiser4]
[  316.699981]        [<e09b90f2>] create_vfs_object+0x511/0x551 [reiser4]
[  316.700729]        [<e09b91bb>] create_common+0x44/0x4b [reiser4]
[  316.701467]        [<c0167a6e>] vfs_create+0x67/0xad
[  316.702142]        [<c016a832>] open_namei+0x19b/0x6cd
[  316.702823]        [<c0158d64>] do_filp_open+0x2b/0x42
[  316.703493]        [<c0158ddc>] do_sys_open+0x61/0xef
[  316.704159]        [<c0158e9d>] sys_open+0x18/0x1a
[  316.704831]        [<c029b8cc>] syscall_call+0x7/0xb
[  316.705518]
[  316.705532] other info that might help us debug this:
[  316.705566]
[  316.705936] 2 locks held by smbd/824:
[  316.706085]  #0:  (&inode->i_mutex){--..}, at: [<c0299d58>]
mutex_lock+0xd/0xf
[  316.706654]  #1:  (&atom->alock){--..}, at: [<e09a78da>]
txnh_get_atom+0x23/0x85 [reiser4]
[  316.707335]
[  316.707349] stack backtrace:
[  316.709560]  [<c01032ab>] show_trace_log_lvl+0x64/0x125
[  316.710003]  [<c01038bd>] show_trace+0x1b/0x20
[  316.710421]  [<c0103914>] dump_stack+0x1f/0x24
[  316.710842]  [<c012e400>] print_circular_bug_tail+0x5d/0x69
[  316.712546]  [<c012eca2>] __lockdep_acquire+0x896/0xa91
[  316.714438]  [<c012f30f>] lockdep_acquire+0x67/0x7f
[  316.716133]  [<c029b67f>] _spin_lock+0x1d/0x2b
[  316.717929]  [<e09a884a>] txn_end+0x3f9/0x47c [reiser4]
[  316.718768]  [<e09a443c>] reiser4_exit_context+0xb2/0x125 [reiser4]
[  316.719319]  [<e09b90f2>] create_vfs_object+0x511/0x551 [reiser4]
[  316.720536]  [<e09b91bb>] create_common+0x44/0x4b [reiser4]
[  316.721610]  [<c0167a6e>] vfs_create+0x67/0xad
[  316.724954]  [<c016a832>] open_namei+0x19b/0x6cd
[  316.728125]  [<c0158d64>] do_filp_open+0x2b/0x42
[  316.730886]  [<c0158ddc>] do_sys_open+0x61/0xef
[  316.733473]  [<c0158e9d>] sys_open+0x18/0x1a
[  316.736245]  [<c029b8cc>] syscall_call+0x7/0xb

-- 
-Barry K. Nathan <barryn@pobox.com>
