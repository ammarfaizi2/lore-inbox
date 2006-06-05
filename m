Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1750719AbWFEH7A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750719AbWFEH7A (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 03:59:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750720AbWFEH7A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 03:59:00 -0400
Received: from wx-out-0102.google.com ([66.249.82.194]:17254 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1750719AbWFEH67 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 03:58:59 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=d37p0OyiKkiHjBAAJD42Q4rOvw9jE4PafJ8dECfSshFjCuPoDySH4GjfaQkvwIMeUsVO+UONTor20rcy5DaVcQywEfcOW/6VTNnTzvztqCnXkVT6FqPHOoOfQFqtiw3QiX4pwiidQBj1F5qdmkto7Bs3nWGnMbx0igSxUdcqKFQ=
Message-ID: <986ed62e0606050058v21b457a7tb4da4da62cb7e4e3@mail.gmail.com>
Date: Mon, 5 Jun 2006 00:58:58 -0700
From: "Barry K. Nathan" <barryn@pobox.com>
To: "Ingo Molnar" <mingo@elte.hu>
Subject: Re: 2.6.17-rc5-mm3: bad unlock ordering (reiser4?)
Cc: Valdis.Kletnieks@vt.edu, "Andrew Morton" <akpm@osdl.org>,
        arjan@linux.intel.com, linux-kernel@vger.kernel.org,
        reiserfs-dev@namesys.com, "Hans Reiser" <reiser@namesys.com>
In-Reply-To: <20060605065444.GA27445@elte.hu>
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
X-Google-Sender-Auth: d6c8b457ef1e9900
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/4/06, Ingo Molnar <mingo@elte.hu> wrote:
> reporting the first one only is necessary, because the validator cannot
> trust a system's dependency info that it sees as incorrect. Deadlock
> possibilities are quite rare in a kernel that is "in balance". Right now
> we are not "in balance" yet, because the validator has only been added a
> couple of days ago. The flurry of initial fixes will die down quickly.

So, does that mean the plan is to annotate/tweak things in order to
shut up *each and every* false positive in the kernel?

Anyway, I tried your patch and I got this:

[  401.004071] (            smbd-920  |#0): new 324990707 us user-latency.
[  401.004264] stopped custom tracer.
[  401.004412]
[  401.004425] ======================================
[  401.004687] [ BUG: bad unlock ordering detected! ]
[  401.004849] --------------------------------------
[  401.005010] smbd/920 is trying to release lock (&txnh->hlock) at:
[  401.005302]  [<e09a8332>] get_current_atom_locked_nocheck+0x3d/0x46 [reiser4]
[  401.005702] but the next lock to release is:
[  401.005856]  (&atom->alock){--..}, at: [<e09a78da>]
txnh_get_atom+0x23/0x85 [reiser4]
[  401.006391]
[  401.006405] other info that might help us debug this:
[  401.006660] 2 locks held by smbd/920:
[  401.006804]  #0:  (&inode->i_mutex){--..}, at: [<c0299d58>]
mutex_lock+0xd/0xf
[  401.007373]  #1:  (&txnh->hlock){--..}, at: [<e09a78cc>]
txnh_get_atom+0x15/0x85 [reiser4]
[  401.008021]
[  401.008034] stack backtrace:
[  401.010115]  [<c01032ab>] show_trace_log_lvl+0x64/0x125
[  401.010538]  [<c01038bd>] show_trace+0x1b/0x20
[  401.010955]  [<c0103914>] dump_stack+0x1f/0x24
[  401.011367]  [<c012f4b9>] lockdep_release+0x192/0x35e
[  401.013039]  [<c029b6dc>] _spin_unlock+0x19/0x27
[  401.014899]  [<e09a8332>] get_current_atom_locked_nocheck+0x3d/0x46 [reiser4]
[  401.015674]  [<e09b3c83>] oid_count_allocated+0xd/0x2c [reiser4]
[  401.016649]  [<e09bb853>] write_sd_by_inode_common+0x1fd/0x502 [reiser4]
[  401.017788]  [<e09bbb85>] create_object_common+0x2d/0x37 [reiser4]
[  401.018926]  [<e09b8f47>] create_vfs_object+0x376/0x551 [reiser4]
[  401.020011]  [<e09b91ab>] create_common+0x44/0x4b [reiser4]
[  401.021047]  [<c0167a6e>] vfs_create+0x67/0xad
[  401.024271]  [<c016a832>] open_namei+0x19b/0x6cd
[  401.027492]  [<c0158d64>] do_filp_open+0x2b/0x42
[  401.030193]  [<c0158ddc>] do_sys_open+0x61/0xef
[  401.032721]  [<c0158e9d>] sys_open+0x18/0x1a
[  401.035432]  [<c029b8cc>] syscall_call+0x7/0xb

dmesg and /proc/latency_trace are here:
http://members.cox.net/barrykn/linux/trace/dmesg.reiser4-3
http://members.cox.net/barrykn/linux/trace/latency_trace_reiser4-3.bz2
-- 
-Barry K. Nathan <barryn@pobox.com>
