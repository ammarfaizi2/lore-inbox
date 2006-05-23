Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932273AbWEWVJs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932273AbWEWVJs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 17:09:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932275AbWEWVJs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 17:09:48 -0400
Received: from sj-iport-5.cisco.com ([171.68.10.87]:46632 "EHLO
	sj-iport-5.cisco.com") by vger.kernel.org with ESMTP
	id S932273AbWEWVJr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 17:09:47 -0400
X-IronPort-AV: i="4.05,161,1146466800"; 
   d="scan'208"; a="281652835:sNHT3054863888"
To: "Bryan O'Sullivan" <bos@pathscale.com>
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [PATCH 1 of 10] ipath - fix spinlock recursion bug
X-Message-Flag: Warning: May contain useful information
References: <bc968dacc8608566f4d2.1148409149@eng-12.pathscale.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Tue, 23 May 2006 14:09:31 -0700
In-Reply-To: <bc968dacc8608566f4d2.1148409149@eng-12.pathscale.com> (Bryan O'Sullivan's message of "Tue, 23 May 2006 11:32:29 -0700")
Message-ID: <adawtccqwhg.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 23 May 2006 21:09:31.0727 (UTC) FILETIME=[2F74E5F0:01C67EAD]
Authentication-Results: sj-dkim-2.cisco.com; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks, I've put 1 through 10 into my git tree and asked Linus to pull.

BTW, I just tried SRP with 2.6.17-rc4 + my for-2.6.18 tree + all of
these patches, and immediately after connecting to a storage target I
get the following:

Kernel BUG at drivers/infiniband/hw/ipath/ipath_layer.c:761
invalid opcode: 0000 [1] SMP
CPU 0
Modules linked in: ib_srp ib_cm ib_sa ib_mad ib_ipath ib_core ipv6 thermal fan button processor ac battery nfs lockd nfs_acl sunrpc dm_mod ide_generic ide_disk ide_cd cdrom e1000 amd74xx shpchp generic pci_hotplug ipath_core parport_pc parport psmouse ohci_hcd ide_core ehci_hcd serio_raw pcspkr
Pid: 3623, comm: udevd Not tainted 2.6.17-rc4 #4
RIP: 0010:[<ffffffff880737d5>] <ffffffff880737d5>{:ipath_core:ipath_verbs_send+364}
RSP: 0000:ffffffff804e1e28  EFLAGS: 00010246
RAX: ffff8101a02b4148 RBX: 0000000000000000 RCX: 0000000000000000
RDX: ffff8101a02b4148 RSI: ffff8101a02b40b0 RDI: ffffc200001c8020
RBP: 0000000000000000 R08: ffff8101a02b4148 R09: 0000000000000002
R10: ffff8101a02b41b0 R11: 000000021e056480 R12: 0000000000000000
R13: ffffc200001c8020 R14: 0000000000000040 R15: 0000000000000010
FS:  00002b8024bbcae0(0000) GS:ffffffff80537000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 00002b8024513350 CR3: 00000001a0075000 CR4: 00000000000006e0
Process udevd (pid: 3623, threadinfo ffff81021cc8e000, task ffff8101a02b8770)
Stack: 0000000000000092 ffff8101a02b4148 ffff8101a02b4098 0000000016000003
       ffff8101a02b4000 000000000000000a 0000000000000000 0000000000000014
       ffff8101a02b40a0 ffffffff881e29ec
Call Trace: <IRQ> <ffffffff881e29ec>{:ib_ipath:ipath_do_rc_send+384}
       <ffffffff8820aea9>{:ib_srp:srp_completion+631} <ffffffff8022e523>{tasklet_hi_action+96}
       <ffffffff8022e5c3>{__do_softirq+86} <ffffffff8020a97a>{call_softirq+30}
       <ffffffff8020c39a>{do_softirq+44} <ffffffff8020c3df>{do_IRQ+65}
       <ffffffff80209cd8>{ret_from_intr+0} <EOI> <ffffffff80258d12>{__handle_mm_fault+1278}
       <ffffffff80219024>{do_page_fault+796} <ffffffff80219007>{do_page_fault+767}
       <ffffffff80391b6e>{datagram_poll+0} <ffffffff8020a471>{error_exit+0}

Code: 0f 0b 68 22 e9 07 88 c2 f9 02 eb 07 44 39 f5 41 0f 47 ee 48
RIP <ffffffff880737d5>{:ipath_core:ipath_verbs_send+364} RSP <ffffffff804e1e28>
 
