Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965251AbVLRTbZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965251AbVLRTbZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Dec 2005 14:31:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965252AbVLRTbY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Dec 2005 14:31:24 -0500
Received: from pat.uio.no ([129.240.130.16]:21173 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S965250AbVLRTbY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Dec 2005 14:31:24 -0500
Subject: Re: lockd: couldn't create RPC handle for (host)
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Ryan Richter <ryan@tau.solarneutrino.net>
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <20051218180150.GF20539@tau.solarneutrino.net>
References: <20051216205536.GA20497@tau.solarneutrino.net>
	 <1134776945.7952.4.camel@lade.trondhjem.org>
	 <20051216235841.GA20539@tau.solarneutrino.net>
	 <1134797577.20929.2.camel@lade.trondhjem.org>
	 <20051217055907.GC20539@tau.solarneutrino.net>
	 <1134801822.7946.4.camel@lade.trondhjem.org>
	 <20051217070222.GD20539@tau.solarneutrino.net>
	 <1134847699.7950.25.camel@lade.trondhjem.org>
	 <20051217194553.GE20539@tau.solarneutrino.net>
	 <1134894836.7931.17.camel@lade.trondhjem.org>
	 <20051218180150.GF20539@tau.solarneutrino.net>
Content-Type: text/plain
Date: Sun, 18 Dec 2005 14:31:07 -0500
Message-Id: <1134934267.7966.37.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.112, required 12,
	autolearn=disabled, AWL 1.70, FORGED_RCVD_HELO 0.05,
	RCVD_IN_SORBS_DUL 0.14, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-12-18 at 13:01 -0500, Ryan Richter wrote:
> On Sun, Dec 18, 2005 at 03:33:56AM -0500, Trond Myklebust wrote:
> > Any Oopses? (use 'dmesg')
> > 
> > Could you also check dmesg for any entries of the form
> > 
> > 'lockd: new process, skipping host shutdown'
> > or
> > 'lockd_up: makesock failed, error='
> 
> Well, there are the oopses I reported last week or so:
> 
> Unable to handle kernel NULL pointer dereference at 0000000000000018 RIP: 
> <ffffffff801dbd9e>{nlmclnt_mark_reclaim+62}
> PGD 7e0e7067 PUD 7e6c0067 PMD 0 
> Oops: 0000 [1] 
> CPU 0 
> Modules linked in:
> Pid: 1316, comm: lockd Not tainted 2.6.14.2 #2
> RIP: 0010:[<ffffffff801dbd9e>] <ffffffff801dbd9e>{nlmclnt_mark_reclaim+62}
> RSP: 0018:ffff81007dfade70  EFLAGS: 00010246
> RAX: 0000000000000000 RBX: ffff81007ad74740 RCX: ffff81007e24a858
> RDX: ffff81007e24a8f0 RSI: ffff81007e24a8e8 RDI: ffff81007ad74740
> RBP: ffff81007e820e00 R08: 00000000fffffffa R09: 0000000000000001
> R10: 00000000ffffffff R11: 0000000000000000 R12: 0000000000000000
> R13: 0000000000000000 R14: ffffffff803ec420 R15: ffff81007df62014
> FS:  00002aaaab00c4a0(0000) GS:ffffffff804b6800(0000) knlGS:00000000557a9080
> CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
> CR2: 0000000000000018 CR3: 000000007e113000 CR4: 00000000000006e0
> Process lockd (pid: 1316, threadinfo ffff81007dfac000, task ffff81007eea61c0)
> Stack: ffffffff801dbe6b ffff81007ad74740 ffffffff801e3d8c 3256cc84d3030002 
>        0000000000000000 ffff81007df4fc68 ffff81007df4fc00 ffffffff803ed4a0 
>        ffff81007df4fca0 ffff81007df4fc68 
> Call Trace:<ffffffff801dbe6b>{nlmclnt_recovery+139} <ffffffff801e3d8c>{nlm4svc_proc_sm_notify+188}
>        <ffffffff8034c5a4>{svc_process+884} <ffffffff8012ab40>{default_wake_function+0}
>        <ffffffff801dde00>{lockd+352} <ffffffff801ddca0>{lockd+0}
>        <ffffffff8010e352>{child_rip+8} <ffffffff801ddca0>{lockd+0}
>        <ffffffff801ddca0>{lockd+0} <ffffffff8010e34a>{child_rip+0}
>        
> 
> Code: 48 39 78 18 75 1c 8b 86 8c 00 00 00 a8 01 74 12 83 c8 02 89 
> RIP <ffffffff801dbd9e>{nlmclnt_mark_reclaim+62} RSP <ffff81007dfade70>
> CR2: 0000000000000018

Looks like the global lock list is corrupted. Could you cat the contents
of /proc/locks?

> Every machine with a dead lockd has had this oops.  Other stuff that
> looks related (these came after the oops, a few days later):

Those errors are unrelated. These errors come from the server.

> lockd: unexpected unlock status: 1
> lockd: weird return 7 for CANCEL call

Error "7" is the equivalent of "ESTALE" (stale filehandle). That means
either someone deleted the file you are trying to lock on the server, or
that a bug caused nfsd  to somehow lose track of the file.

I suspect the Error "1" is related to the same issue.


> > Finally, please do
> > 
> > echo 1 > /proc/sys/sunrpc/rpc_lockd
> > then unmount one of your NFS partitions, and then mount it again.
> 
> That file doesn't exist.
> 
> $ ls /proc/sys/sunrpc 
> nfs_debug  nfsd_debug  nlm_debug  rpc_debug  tcp_slot_table_entries
> udp_slot_table_entries

Sorry, I meant 'nlm_debug'.

Cheers,
 Trond

