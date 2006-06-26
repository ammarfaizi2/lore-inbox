Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751162AbWFZVlN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751162AbWFZVlN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 17:41:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751062AbWFZVlM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 17:41:12 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:7386 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S1751256AbWFZVlM (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 17:41:12 -0400
Message-Id: <200606262141.k5QLf7wi004164@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: 2.6.17-mm2 hrtimer code wedges at boot?
In-Reply-To: Your message of "Sat, 24 Jun 2006 06:19:14 PDT."
             <20060624061914.202fbfb5.akpm@osdl.org>
From: Valdis.Kletnieks@vt.edu
References: <20060624061914.202fbfb5.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1151358067_3793P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 26 Jun 2006 17:41:07 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1151358067_3793P
Content-Type: text/plain; charset=us-ascii

On Sat, 24 Jun 2006 06:19:14 PDT, Andrew Morton said:
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17/2.6.17-mm2/

I'm seeing a 2-minute or so hang at system startup, seems to be hrtimer
related.  This is at fairly early userspace - the initrd has run, but we're not
into /etc/rc.sysinit yet (although the root filesystem is mounted and we have
a kjournald for it).  Poking with sysrq-T and sysrq-R gets me this:

[  108.301806] Pid: 4, comm:              khelper
[  108.330565] EIP: 0060:[<c0119f48>] CPU: 0
[  108.359315] EIP is at getnstimeofday+0x9e/0xb8
[  108.387820]  EFLAGS: 00000207    Not tainted  (2.6.17-mm2 #1)
[  108.416344] EAX: efed073c EBX: efed073c ECX: 00000000 EDX: 0f16d9ba
[  108.444765] ESI: a7955c5a EDI: 4a12cf06 EBP: effd0e5c DS: 007b ES: 007b
[  108.473303] CR0: 8005003b CR2: b7d9acb0 CR3: 2ffbc000 CR4: 000006d0
[  108.501579]  <c0125c0c> ktime_get_ts+0x14/0x3f  <c0110f84> copy_process+0x395/0x1111
[  108.530366]  <c0111f3c> do_fork+0x8d/0x16a  <c0100a27> kernel_thread+0x6c/0x74
[  108.559363]  <c0120431> __call_usermodehelper+0x2b/0x44  <c0120982> run_workqueue+0x94/0xe9
[  108.588523]  <c0120e64> worker_thread+0xe1/0x115  <c01232b2> kthread+0xb0/0xdc
[  108.617618]  <c01006c5> kernel_thread_helper+0x5/0xb
[  115.881903] SysRq : Show Regs
[  115.910288]
[  115.938097] Pid: 4, comm:              khelper
[  115.965908] EIP: 0060:[<c0119f48>] CPU: 0
[  115.993553] EIP is at getnstimeofday+0x9e/0xb8
[  116.020928]  EFLAGS: 00000287    Not tainted  (2.6.17-mm2 #1)
[  116.048387] EAX: efed073c EBX: efed073c ECX: 00000000 EDX: 0f16d9ba
[  116.075750] ESI: 9484965a EDI: 2262af5b EBP: effd0e5c DS: 007b ES: 007b
[  116.103240] CR0: 8005003b CR2: b7d9acb0 CR3: 2ffbc000 CR4: 000006d0
[  116.130449]  <c0125c0c> ktime_get_ts+0x14/0x3f  <c0110f84> copy_process+0x395/0x1111
[  116.158078]  <c0111f3c> do_fork+0x8d/0x16a  <c0100a27> kernel_thread+0x6c/0x74
[  116.185729]  <c0120431> __call_usermodehelper+0x2b/0x44  <c0120982> run_workqueue+0x94/0xe9
[  116.213729]  <c0120e64> worker_thread+0xe1/0x115  <c01232b2> kthread+0xb0/0xdc
[  116.241689]  <c01006c5> kernel_thread_helper+0x5/0xb

Looking at the body of ktime_get_ts, I see:

        do {
                seq = read_seqbegin(&xtime_lock);
                getnstimeofday(ts);
                tomono = wall_to_monotonic;

        } while (read_seqretry(&xtime_lock, seq));

Which looks like a good place to get hung in a loop for a while....

Eventually (after about 2 minutes, it finally unwedges and continues on.

Any ideas?


--==_Exmh_1151358067_3793P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFEoFRzcC3lWbTT17ARAlAzAJ4lQzVgYkhl1xZwOPnP7u23KAt0ygCgxTzJ
nKG+ktjbahrwGkFRyOaHmNg=
=2eQW
-----END PGP SIGNATURE-----

--==_Exmh_1151358067_3793P--
