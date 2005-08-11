Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932321AbVHKRvy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932321AbVHKRvy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 13:51:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932313AbVHKRvy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 13:51:54 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:58596 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932326AbVHKRvx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 13:51:53 -0400
Subject: Re: files_lock deadlock?
From: Arjan van de Ven <arjan@infradead.org>
To: Martin Wilck <martin.wilck@fujitsu-siemens.com>
Cc: Alexander Nyberg <alexn@telia.com>, linux-kernel@vger.kernel.org
In-Reply-To: <42FB8ECF.4090106@fujitsu-siemens.com>
References: <42DD2E37.3080204@fujitsu-siemens.com>
	 <1121870871.1103.14.camel@localhost.localdomain>
	 <42FB8ECF.4090106@fujitsu-siemens.com>
Content-Type: text/plain
Date: Thu, 11 Aug 2005 19:51:39 +0200
Message-Id: <1123782699.3201.43.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 3.0 (+++)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (3.0 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 NORMAL_HTTP_TO_IP      URI: Uses a dotted-decimal IP address in URL
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	2.8 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-08-11 at 19:45 +0200, Martin Wilck wrote:
> Alexander Nyberg wrote:
> > 
> > spin_lock_irqsave is only needed when a lock is taken both in normal
> > context and in interrupt context. Clearly this lock is not intended to
> > be taken in interrupt context. 
> 
> Further investigation has shown that there was indeed a deadlock, at 
> least until 2.6.10.
> 
> See this patch:
> http://linux.bkbits.net:8080/linux-2.6/cset@1.1982.120.2?nav=index.html|src/|src/net|src/net/ipv6|related/net/ipv6/addrconf.c
> ("[IPV6]: Unregister per-device snmp6 proc entry earlier.")
> 
> That patch (indirectly) moves a call to remove_proc_entry() from
> a softirq execution path, thus removing the files_lock deadlock thgat 
> can be seen in the trace below. However, I think there may be other 
> paths like this, and even if there aren't people may very easily add 
> calls to (say) remove_prc_entry() to softirq paths in the future, which 
> will conjur up the same problem again. So my plea is to make files_lock 
> protected by spin_lock_bh().

I disagree, it's a performance cost.
It's a lot easier to make remove_proc_entry() a might_sleep().. (I'm
surprised it isn't already btw given that it's vfs related and the vfs
is mostly semaphore based)

> 
> Regards
> Martin
> 
> 
> Kernel panic - not syncing: fs/proc/generic.c:521: 
> spin_lock(fs/file_table.c:ffffffff80420280) already locked by fs/file_tabl
> e.c/204
> Kernel BUG at panic:74
> invalid operand: 0000 [1]
> CPU 0
> Modules linked in: md5 ipv6 mptctl smbus(U) ipmi(U) sunrpc scsi_dump 
> diskdump button battery ac uhci_hcd ehci_hcd tg3 sg dm_s
> napshot dm_zero dm_mirror ext3 jbd dm_mod mptscsih mptbase sd_mod scsi_mod
> Pid: 3974, comm: ifdown Not tainted 2.6.9-11.EL
> RIP: 0010:[<ffffffff80137d42>] <ffffffff80137d42>{panic+211}
> RSP: 0018:ffffffff8048cce8  EFLAGS: 00010286
> RAX: 0000000000000089 RBX: ffffffff80358c9a RCX: 0000000000003c22
> RDX: 00000000ffffff01 RSI: 0000000000003c22 RDI: ffffffff804189e0
> RBP: 000001020b8b0dc0 R08: 0000000000000002 R09: 000000000000000d
> R10: 000000000000000e R11: 0000ffff80436560 R12: 00000100efec3400
> R13: 0000000000000004 R14: 000001020f52b6d8 R15: 000001000dfbf800
> FS:  0000002a955843e0(0000) GS:ffffffff8051e980(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
> CR2: 000000000044f3c0 CR3: 0000000000101000 CR4: 00000000000006e0
> Process ifdown (pid: 3974, threadinfo 000001020d816000, task 
> 000001020b039110)
> Stack: 0000003000000030 ffffffff8048cdd0 ffffffff8048cd08 000001000827a6e0
>         ffffffff8048cd58 ffffffff8036314e 0000000000000209 ffffffff80361bcb
>         ffffffff80420280 ffffffff80361bcb
> Call Trace:
> <IRQ>   <ffffffff8027f373>{cfq_next_request+59}
>          <ffffffff80275481>{elv_next_request+238}
>          <ffffffff801cd6be>{remove_proc_entry+288}
>          <ffffffffa0174422>{:ipv6:snmp6_unregister_dev+54}
>          <ffffffffa015390b>{:ipv6:in6_dev_finish_destroy+132}
>          <ffffffff802e6bc7>{dst_destroy+121}
>          <ffffffff802e6cef>{dst_run_gc+212}
>          <ffffffff801426a5>{run_timer_softirq+591}
>          <ffffffff8013e34c>{__do_softirq+76}
>          <ffffffff8013e3d3>{do_softirq+49}
>          <ffffffff80113987>{do_IRQ+664}
>          <ffffffff80110e8f>{ret_from_intr+0}  <EOI>
>          <ffffffff801ec510>{dummy_inode_permission+0}
>          <ffffffff801ec510>{dummy_inode_permission+0}
>          <ffffffff80187041>{file_move+204}
>          <ffffffff801ec510>{dummy_inode_permission+0}
>          <ffffffff80184c6f>{dentry_open+179}
>          <ffffffff80192b70>{open_exec+140}
>          <ffffffff80162cec>{__generic_file_aio_read+390}
>          <ffffffff80185c53>{vfs_read+248}
>          <ffffffff801bd3ce>{load_elf_binary+784}
>          <ffffffff80185b2f>{do_sync_read+173}
>          <ffffffff801924b1>{copy_strings+451}
>          <ffffffff801945f3>{search_binary_handler+128}
>          <ffffffff801948e7>{do_execve+393}
>          <ffffffff801108c6>{system_call+126}
>          <ffffffff8010ece5>{sys_execve+56}
>          <ffffffff80110cea>{stub_execve+106}
> 
> Code: 0f 0b 33 a2 35 80 ff ff ff ff 4a 00 31 ff e8 67 bf fe ff 31
> 
> 
> -- 
> Martin Wilck                Phone: +49 5251 8 15113
> Fujitsu Siemens Computers   Fax:   +49 5251 8 20409
> Heinz-Nixdorf-Ring 1        mailto:Martin.Wilck@Fujitsu-Siemens.com
> D-33106 Paderborn           http://www.fujitsu-siemens.com/primergy
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

