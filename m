Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264782AbUGMK1i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264782AbUGMK1i (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 06:27:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264808AbUGMK1i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 06:27:38 -0400
Received: from mail006.syd.optusnet.com.au ([211.29.132.63]:14539 "EHLO
	mail006.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S264782AbUGMK1f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 06:27:35 -0400
Message-ID: <40F3B8EC.4000301@kolivas.org>
Date: Tue, 13 Jul 2004 20:26:52 +1000
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: ck@vds.kolivas.org, linux-kernel@vger.kernel.org, wli@holomorphy.com
Subject: Re: Preempt Threshold Measurements
References: <200407121943.25196.devenyga@mcmaster.ca>	<20040713024051.GQ21066@holomorphy.com>	<200407122248.50377.devenyga@mcmaster.ca>	<cone.1089687290.911943.12958.502@pc.kolivas.org>	<20040712210107.1945ac34.akpm@osdl.org>	<cone.1089697919.186986.12958.502@pc.kolivas.org> <20040712231406.427caa2a.akpm@osdl.org>
In-Reply-To: <20040712231406.427caa2a.akpm@osdl.org>
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig51762AEFAC43F1AB3DEF9BDF"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig51762AEFAC43F1AB3DEF9BDF
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Andrew Morton wrote:
> Con Kolivas <kernel@kolivas.org> wrote:
> 
>>4ms at blkdev_put+0x48
> 
> 
> This can run under one of two depths of lock_kernel.  filemap_fdatawrite()
> and filemap_fdatawait() both do cond_resched(), so this is odd.
> 
> Try this:
> 

Thanks! I'll certainly give that a shot.

> Need to see the whole trace.

Do you mean the traces from your patch or the ones that come from this 
preempt test like this?

Jul 13 07:22:18 pc kernel: 4ms non-preemptible critical section violated 
1 ms preempt threshold starting at exit_mmap+0x1c/0x188 and ending at 
exit_mmap+0x
118/0x188
Jul 13 07:22:18 pc kernel:  [<c011d769>] dec_preempt_count+0x14f/0x151
Jul 13 07:22:18 pc kernel:  [<c014d0d4>] exit_mmap+0x118/0x188
Jul 13 07:22:18 pc kernel:  [<c014d0d4>] exit_mmap+0x118/0x188
Jul 13 07:22:18 pc kernel:  [<c011df0a>] mmput+0x61/0x7b
Jul 13 07:22:18 pc kernel:  [<c01634dc>] exec_mmap+0x11d/0x248
Jul 13 07:22:18 pc kernel:  [<c016364c>] flush_old_exec+0x45/0x284
Jul 13 07:22:18 pc kernel:  [<c018119f>] load_elf_binary+0x3e8/0xd00
Jul 13 07:22:18 pc kernel:  [<c013a9b1>] do_generic_mapping_read+0x295/0x4f2
Jul 13 07:22:18 pc kernel:  [<c0164312>] search_binary_handler+0xd0/0x34c
Jul 13 07:22:18 pc kernel:  [<c0180db7>] load_elf_binary+0x0/0xd00
Jul 13 07:22:18 pc kernel:  [<c0164329>] search_binary_handler+0xe7/0x34c
Jul 13 07:22:18 pc kernel:  [<c0164759>] do_execve+0x1cb/0x23c
Jul 13 07:22:18 pc kernel:  [<c0165f39>] getname+0x55/0xb8
Jul 13 07:22:18 pc kernel:  [<c0104bcf>] sys_execve+0x35/0x68
Jul 13 07:22:18 pc kernel:  [<c0105fd5>] sysenter_past_esp+0x52/0x71


I can try and extract the exact points from the disassembly after some 
guidance I've received (most of them seem to be buried deep in inlined 
functions.) The exit_mmap one seemed to work out (as you probably saw in 
my previous email) to be set off here:

          profile_exit_mmap(mm);
          lru_add_drain();
c014cfce:       e8 18 72 ff ff          call   c01441eb <lru_add_drain>
          spin_lock(&mm->page_table_lock);
c014cfd3:       e8 16 06 fd ff          call   c011d5ee <inc_preempt_count>


Cheers,
Con

--------------enig51762AEFAC43F1AB3DEF9BDF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFA87jvZUg7+tp6mRURArIfAJ0fib0m7bs5y+TRTq1VB9caNps26wCbBY69
Xur8mgyc+csHobtwPI80Slo=
=8Pa+
-----END PGP SIGNATURE-----

--------------enig51762AEFAC43F1AB3DEF9BDF--
