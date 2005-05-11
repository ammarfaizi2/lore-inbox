Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261986AbVEKRgs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261986AbVEKRgs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 13:36:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261230AbVEKRgs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 13:36:48 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:39896 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261986AbVEKReu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 13:34:50 -0400
Date: Wed, 11 May 2005 09:46:40 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Manfred Schwarb <manfred99@gmx.ch>
Cc: linux-kernel@vger.kernel.org, davem@redhat.com, netdev@oss.sgi.com
Subject: Re: 2.4.30-hf1 do_IRQ stack overflows
Message-ID: <20050511124640.GE8541@logos.cnet>
References: <5.2.1.1.2.20050511093252.01c887b0@mail.meteodat.ch>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="SLDf9lqlvOQaIe6s"
Content-Disposition: inline
In-Reply-To: <5.2.1.1.2.20050511093252.01c887b0@mail.meteodat.ch>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


Hi Manfred,

On Wed, May 11, 2005 at 10:15:02AM +0200, Manfred Schwarb wrote:
> Hi,
> with recent versions of the 2.4 kernel (Vanilla), I get an increasing amount of do_IRQ stack overflows.
> This night, I got 3 of them.
> With 2.4.28 I got an overflow about twice a year, with 2.4.29 nearly once a month and with
> 2.4.30 nearly every day 8-((

The system is getting dangerously close to an actual stack overflow, which would 
crash the system. 

"do_IRQ: stack overflow: " indicates how many bytes are still available. 

The traces show huge networking execution paths.

It seems you are using some packet scheduler (CONFIG_NET_SCHED)? Pretty much all 
traces show functions from sch_generic.c. Can you disable that for a test? 

> My layout: Pentium4 HT SMP, raid1 on a promise card, driven by libata_promise, 
> everything using reiserfs, heavy nfs and network traffic, with a Linksys (tulip) and a Realtek (8139too) NIC.
> The used 2.4.30-hf1 is pure Vanilla.
> 
> Below my three overflow messages. Would the stack reduction patches of Badari Pulavarty
> help in my case? If so, I would strongly vote for inclusion into 2.4 series!!

It has been decided that the stack reduction patches were too intrusive to be merged
at this stage of v2.4 life. 

We did not receive any report either - v2.4's 8KB kernel stack seems to be enough
for vast majority of situations.


--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="stack_ovf_2430.log"

 May 11 04:22:09 server kernel: do_IRQ: stack overflow: 628
 May 11 04:22:09 server kernel: f3668824 00000274 e9a40380 00000000 00000003 f7e5d280 f3668000 0000000e
 May 11 04:22:09 server kernel:        c010d948 00000003 f7e5d318 f7e5d308 f7e5d280 f3668000 0000000e 00000006
 May 11 04:22:09 server kernel:        f1960018 f1a00018 ffffff14 c024893e 00000010 00000202 f7e5d280 f196cc00
 May 11 04:22:09 server kernel: Call Trace:    [call_do_IRQ+5/13] [pfifo_fast_dequeue+62/80] [qdisc_restart+31/432] [dev_queue_xmit+383/880] [neigh_resolve_output+321/624]
 May 11 04:22:09 server kernel: Call Trace:    [<c010d948>] [<c024893e>] [<c02483df>] [<c023ccaf>] [<c0243af1>]
 May 11 04:22:09 server kernel:   [ip_finish_output2+184/336] [ip_finish_output2+0/336] [ip_finish_output2+0/336] [nf_hook_slow+478/528] [ip_finish_output2+0/336] [ip_output+334/480]
 May 11 04:22:09 server kernel:   [<c025a2d8>] [<c025a220>] [<c025a220>] [<c024763e>] [<c025a220>] [<c0258a4e>]
 May 11 04:22:09 server kernel:   [ip_finish_output2+0/336] [ip_queue_xmit2+213/671] [ip_queue_xmit2+0/671] [ip_queue_xmit2+0/671] [nf_hook_slow+478/528] [ip_queue_xmit2+0/671]
 May 11 04:22:09 server kernel:   [<c025a220>] [<c025a445>] [<c025a370>] [<c025a370>] [<c024763e>] [<c025a370>]
 May 11 04:22:09 server kernel:   [ip_queue_xmit+845/1536] [ip_queue_xmit2+0/671] [dev_queue_xmit+383/880] [tcp_v4_send_check+160/240] [tcp_transmit_skb+1001/1792] [tcp_send_ack+132/208]
 May 11 04:22:09 server kernel:   [<c0258e2d>] [<c025a370>] [<c023ccaf>] [<c0271c20>] [<c026bdc9>] [<c026e824>]
 May 11 04:22:09 server kernel:   [tcp_rfree+0/32] [tcp_rfree+0/32] [tcp_rcv_established+2042/2640] [tcp_v4_do_rcv+314/352] [tcp_v4_rcv+1726/1952] [ip_local_deliver_finish+351/416]
 May 11 04:22:09 server kernel:   [<c025d4a0>] [<c025d4a0>] [<c026a2fa>] [<c0272eda>] [<c02735be>] [<c025581f>]
 May 11 04:22:09 server kernel:   [ip_local_deliver_finish+0/416] [nf_hook_slow+478/528] [ip_local_deliver_finish+0/416] [ip_local_deliver+399/576] [ip_local_deliver_finish+0/416] [ip_rcv_finish+553/700]
 May 11 04:22:09 server kernel:   [<c02556c0>] [<c024763e>] [<c02556c0>] [<c025514f>] [<c02556c0>] [<c0255a89>]
 May 11 04:22:09 server kernel:   [ip_rcv_finish+0/700] [ip_rcv_finish+0/700] [nf_hook_slow+478/528] [ip_rcv_finish+0/700] [ip_rcv+905/1216] [ip_rcv_finish+0/700]
 May 11 04:22:09 server kernel:   [<c0255860>] [<c0255860>] [<c024763e>] [<c0255860>] [<c0255589>] [<c0255860>]
 May 11 04:22:09 server kernel:   [netif_receive_skb+485/544] [process_backlog+147/304] [net_rx_action+250/368] [do_softirq+118/224] [do_IRQ+244/304] [call_do_IRQ+5/13]
 May 11 04:22:09 server kernel:   [<c023d505>] [<c023d5d3>] [<c023d76a>] [<c01254c6>] [<c010b094>] [<c010d948>]
 May 11 04:22:09 server kernel:   [__switch_to+82/256] [schedule+738/1344] [schedule_timeout+84/160] [process_timeout+0/96] [st:__insmod_st_O/lib/modules/2.4.30-hf1/kernel/drivers/scsi/st+4294702743/96] [st:__insmod_st_O/lib/modules/2.4.30-hf1/kernel/drivers/scsi/st+4294703097/96]
 May 11 04:22:09 server kernel:   [<c0107722>] [<c011cee2>] [<c011cb14>] [<c011ca60>] [<f90f0697>] [<f90f07f9>]
 May 11 04:22:09 server kernel:   [st:__insmod_st_O/lib/modules/2.4.30-hf1/kernel/drivers/scsi/st+4294703275/96] [st:__insmod_st_O/lib/modules/2.4.30-hf1/kernel/drivers/scsi/st+4294709446/96] [<f914d588>] [<f914f255>] [st:__insmod_st_O/lib/modules/2.4.30-hf1/kernel/drivers/scsi/st+4288825300/96] [st:__insmod_st_O/lib/modules/2.4.30-hf1/kernel/drivers/scsi/st+4288879050/96]
 May 11 04:22:09 server kernel:   [<f90f08ab>] [<f90f20c6>] [<f914d588>] [<f914f255>] [<f8b557d4>] [<f8b629ca>]
 May 11 04:22:09 server kernel:   [st:__insmod_st_O/lib/modules/2.4.30-hf1/kernel/drivers/scsi/st+4288713668/96] [st:__insmod_st_O/lib/modules/2.4.30-hf1/kernel/drivers/scsi/st+4288789620/96] [st:__insmod_st_O/lib/modules/2.4.30-hf1/kernel/drivers/scsi/st+4288713668/96] [st:__insmod_st_O/lib/modules/2.4.30-hf1/kernel/drivers/scsi/st+4288712232/96] [st:__insmod_st_O/lib/modules/2.4.30-hf1/kernel/drivers/scsi/st+4288755907/96] [st:__insmod_st_O/lib/modules/2.4.30-hf1/kernel/drivers/scsi/st+4288791678/96]
 May 11 04:22:09 server kernel:   [<f8b3a3c4>] [<f8b4cc74>] [<f8b3a3c4>] [<f8b39e28>] [<f8b448c3>] [<f8b4d47e>]
 May 11 04:22:09 server kernel:   [st:__insmod_st_O/lib/modules/2.4.30-hf1/kernel/drivers/scsi/st+4288800963/96] [st:__insmod_st_O/lib/modules/2.4.30-hf1/kernel/drivers/scsi/st+4288763515/96] [st:__insmod_st_O/lib/modules/2.4.30-hf1/kernel/drivers/scsi/st+4288713480/96] [st:__insmod_st_O/lib/modules/2.4.30-hf1/kernel/drivers/scsi/st+4288763309/96] [st:__insmod_st_O/lib/modules/2.4.30-hf1/kernel/drivers/scsi/st+4288815612/96] [__kfree_skb+254/352]
 May 11 04:22:09 server kernel:   [<f8b4f8c3>] [<f8b4667b>] [<f8b3a308>] [<f8b465ad>] [<f8b531fc>] [<c02387be>]
 May 11 04:22:09 server kernel:   [__kfree_skb+254/352] [st:__insmod_st_O/lib/modules/2.4.30-hf1/kernel/drivers/scsi/st+4294624756/96] [qdisc_restart+31/432] [dev_queue_xmit+383/880] [neigh_resolve_output+321/624] [__kfree_skb+254/352]
 May 11 04:22:09 server kernel:   [<c02387be>] [<f90dd5f4>] [<c02483df>] [<c023ccaf>] [<c0243af1>] [<c02387be>]
 May 11 04:22:09 server kernel:   [st:__insmod_st_O/lib/modules/2.4.30-hf1/kernel/drivers/scsi/st+4294624756/96] [qdisc_restart+31/432] [dev_queue_xmit+383/880] [neigh_resolve_output+321/624] [ip_finish_output2+184/336] [ip_finish_output2+0/336]
 May 11 04:22:09 server kernel:   [<f90dd5f4>] [<c02483df>] [<c023ccaf>] [<c0243af1>] [<c025a2d8>] [<c025a220>]
 May 11 04:22:09 server kernel:   [ip_finish_output2+0/336] [nf_hook_slow+478/528] [ip_finish_output2+0/336] [ip_output+334/480] [ip_finish_output2+0/336] [ip_queue_xmit2+213/671]
 May 11 04:22:09 server kernel:   [<c025a220>] [<c024763e>] [<c025a220>] [<c0258a4e>] [<c025a220>] [<c025a445>]
 May 11 04:22:09 server kernel:   [ip_queue_xmit2+0/671] [ip_queue_xmit2+0/671] [nf_hook_slow+478/528] [ip_queue_xmit2+0/671] [ip_queue_xmit+845/1536] [ip_queue_xmit2+0/671]
 May 11 04:22:09 server kernel:   [<c025a370>] [<c025a370>] [<c024763e>] [<c025a370>] [<c0258e2d>] [<c025a370>]
 May 11 04:22:09 server kernel:   [skb_checksum+92/800] [sock_def_readable+99/128] [tcp_rfree+0/32] [tcp_rfree+0/32] [tcp_rcv_established+1981/2640] [tcp_v4_do_rcv+314/352]
 May 11 04:22:09 server kernel:   [<c02399dc>] [<c0237f63>] [<c025d4a0>] [<c025d4a0>] [<c026a2bd>] [<c0272eda>]
 May 11 04:22:09 server kernel:   [tcp_v4_rcv+1726/1952] [locate_hd_struct+56/160] [st:__insmod_st_O/lib/modules/2.4.30-hf1/kernel/drivers/scsi/st+4288606771/96] [st:__insmod_st_O/lib/modules/2.4.30-hf1/kernel/drivers/scsi/st+4288606771/96] [st:__insmod_st_O/lib/modules/2.4.30-hf1/kernel/drivers/scsi/st+4288607559/96] [st:__insmod_st_O/lib/modules/2.4.30-hf1/kernel/drivers/scsi/st+4288679225/96]
 May 11 04:22:09 server kernel:   [<c02735be>] [<c01e4308>] [<f8b20233>] [<f8b20233>] [<f8b20547>] [<f8b31d39>]
 May 11 04:22:09 server kernel:   [st:__insmod_st_O/lib/modules/2.4.30-hf1/kernel/drivers/scsi/st+4288574821/96] [st:__insmod_st_O/lib/modules/2.4.30-hf1/kernel/drivers/scsi/st+4288906935/96] [st:__insmod_st_O/lib/modules/2.4.30-hf1/kernel/drivers/scsi/st+4288935563/96] [bh_action+106/112] [tasklet_hi_action+83/160] [sys_ioctl+677/785]
 May 11 04:22:09 server kernel:   [<f8b18565>] [<f8b696b7>] [<f8b7068b>] [<c01258ca>] [<c0125753>] [<c0158905>]
 May 11 04:22:09 server kernel:   [system_call+51/56]
 May 11 04:22:09 server kernel:   [<c0108fa7>]
 
 #######################################################
 
 May 11 04:26:28 server kernel: do_IRQ: stack overflow: 1000
 May 11 04:26:28 server kernel: f3668998 000003e8 00000000 00000000 f3668000 f3668ac0 f3668a34 00000000
 May 11 04:26:28 server kernel:        c010d948 f3668000 0001961a 00000944 f3668ac0 f3668a34 00000000 00000944
 May 11 04:26:28 server kernel:        00000018 f1960018 ffffff14 f90820a7 00000010 00000246 f3668a34 f40a9ec0
 May 11 04:26:28 server kernel: Call Trace:    [call_do_IRQ+5/13] [st:__insmod_st_O/lib/modules/2.4.30-hf1/kernel/drivers/scsi/st+4294250663/96] [st:__insmod_st_O/lib/modules/2.4.30-hf1/kernel/drivers/scsi/st+4294268736/96] [st:__insmod_st_O/lib/modules/2.4.30-hf1/kernel/drivers/scsi/st+4294250842/96] [st:__insmod_st_O/lib/modules/2.4.30-hf1/kernel/drivers/scsi/st+4294254302/96]
 May 11 04:26:28 server kernel: Call Trace:    [<c010d948>] [<f90820a7>] [<f9086740>] [<f908215a>] [<f9082ede>]
 May 11 04:26:28 server kernel:   [ip_queue_xmit2+0/671] [nf_iterate+85/160] [ip_queue_xmit2+0/671] [ip_queue_xmit2+0/671] [nf_hook_slow+247/528] [ip_queue_xmit2+0/671]
 May 11 04:26:28 server kernel:   [<c025a370>] [<c0247185>] [<c025a370>] [<c025a370>] [<c0247557>] [<c025a370>]
 May 11 04:26:28 server kernel:   [st:__insmod_st_O/lib/modules/2.4.30-hf1/kernel/drivers/scsi/st+4294266808/96] [ip_queue_xmit+845/1536] [ip_queue_xmit2+0/671] [tcp_v4_rcv+1726/1952] [tcp_v4_send_check+160/240] [tcp_transmit_skb+1001/1792]
 May 11 04:26:28 server kernel:   [<f9085fb8>] [<c0258e2d>] [<c025a370>] [<c02735be>] [<c0271c20>] [<c026bdc9>]
 May 11 04:26:28 server kernel:   [tcp_send_ack+132/208] [tcp_rfree+0/32] [tcp_rfree+0/32] [tcp_rcv_established+2042/2640] [tcp_v4_do_rcv+314/352] [tcp_v4_rcv+1726/1952]
 May 11 04:26:28 server kernel:   [<c026e824>] [<c025d4a0>] [<c025d4a0>] [<c026a2fa>] [<c0272eda>] [<c02735be>]
 May 11 04:26:28 server kernel:   [ip_local_deliver_finish+351/416] [ip_local_deliver_finish+0/416] [nf_hook_slow+478/528] [ip_local_deliver_finish+0/416] [ip_local_deliver+399/576] [ip_local_deliver_finish+0/416]
 May 11 04:26:28 server kernel:   [<c025581f>] [<c02556c0>] [<c024763e>] [<c02556c0>] [<c025514f>] [<c02556c0>]
 May 11 04:26:28 server kernel:   [ip_rcv_finish+553/700] [ip_rcv_finish+0/700] [ip_rcv_finish+0/700] [nf_hook_slow+478/528] [ip_rcv_finish+0/700] [ip_rcv+905/1216]
 May 11 04:26:28 server kernel:   [<c0255a89>] [<c0255860>] [<c0255860>] [<c024763e>] [<c0255860>] [<c0255589>]
 May 11 04:26:28 server kernel:   [ip_rcv_finish+0/700] [netif_receive_skb+485/544] [process_backlog+147/304] [net_rx_action+250/368] [do_softirq+118/224] [do_IRQ+244/304]
 May 11 04:26:28 server kernel:   [<c0255860>] [<c023d505>] [<c023d5d3>] [<c023d76a>] [<c01254c6>] [<c010b094>]
 May 11 04:26:28 server kernel:   [call_do_IRQ+5/13] [st:__insmod_st_O/lib/modules/2.4.30-hf1/kernel/drivers/scsi/st+4294701080/96] [<f914e620>] [<f914e7b6>] [<f914d473>] [<f914d5a6>]
 May 11 04:26:28 server kernel:   [<c010d948>] [<f90f0018>] [<f914e620>] [<f914e7b6>] [<f914d473>] [<f914d5a6>]
 May 11 04:26:28 server kernel:   [isofs_read_super+1131/2048] [<f914f255>] [st:__insmod_st_O/lib/modules/2.4.30-hf1/kernel/drivers/scsi/st+4288825300/96] [st:__insmod_st_O/lib/modules/2.4.30-hf1/kernel/drivers/scsi/st+4288879050/96] [st:__insmod_st_O/lib/modules/2.4.30-hf1/kernel/drivers/scsi/st+4288713668/96] [st:__insmod_st_O/lib/modules/2.4.30-hf1/kernel/drivers/scsi/st+4288789620/96]
 May 11 04:26:28 server kernel:   [<c018480b>] [<f914f255>] [<f8b557d4>] [<f8b629ca>] [<f8b3a3c4>] [<f8b4cc74>]
 May 11 04:26:28 server kernel:   [st:__insmod_st_O/lib/modules/2.4.30-hf1/kernel/drivers/scsi/st+4288713668/96] [st:__insmod_st_O/lib/modules/2.4.30-hf1/kernel/drivers/scsi/st+4288712232/96] [st:__insmod_st_O/lib/modules/2.4.30-hf1/kernel/drivers/scsi/st+4288755907/96] [st:__insmod_st_O/lib/modules/2.4.30-hf1/kernel/drivers/scsi/st+4288791678/96] [st:__insmod_st_O/lib/modules/2.4.30-hf1/kernel/drivers/scsi/st+4288800963/96] [st:__insmod_st_O/lib/modules/2.4.30-hf1/kernel/drivers/scsi/st+4288763515/96]
 May 11 04:26:28 server kernel:   [<f8b3a3c4>] [<f8b39e28>] [<f8b448c3>] [<f8b4d47e>] [<f8b4f8c3>] [<f8b4667b>]
 May 11 04:26:28 server kernel:   [st:__insmod_st_O/lib/modules/2.4.30-hf1/kernel/drivers/scsi/st+4288713480/96] [st:__insmod_st_O/lib/modules/2.4.30-hf1/kernel/drivers/scsi/st+4288763309/96] [st:__insmod_st_O/lib/modules/2.4.30-hf1/kernel/drivers/scsi/st+4288815612/96] [__kfree_skb+254/352] [__kfree_skb+254/352] [__kfree_skb+254/352]
 May 11 04:26:28 server kernel:   [<f8b3a308>] [<f8b465ad>] [<f8b531fc>] [<c02387be>] [<c02387be>] [<c02387be>]
 May 11 04:26:28 server kernel:   [st:__insmod_st_O/lib/modules/2.4.30-hf1/kernel/drivers/scsi/st+4294624756/96] [qdisc_restart+31/432] [dev_queue_xmit+383/880] [neigh_resolve_output+321/624] [ip_finish_output2+184/336] [ip_finish_output2+0/336]
 May 11 04:26:28 server kernel:   [<f90dd5f4>] [<c02483df>] [<c023ccaf>] [<c0243af1>] [<c025a2d8>] [<c025a220>]
 May 11 04:26:28 server kernel:   [ip_finish_output2+0/336] [nf_hook_slow+478/528] [ip_finish_output2+0/336] [ip_output+334/480] [ip_finish_output2+0/336] [ip_queue_xmit2+213/671]
 May 11 04:26:28 server kernel:   [<c025a220>] [<c024763e>] [<c025a220>] [<c0258a4e>] [<c025a220>] [<c025a445>]
 May 11 04:26:28 server kernel:   [ip_queue_xmit2+0/671] [ip_queue_xmit2+0/671] [nf_hook_slow+478/528] [ip_queue_xmit2+0/671] [ip_queue_xmit+845/1536] [ip_queue_xmit2+0/671]
 May 11 04:26:28 server kernel:   [<c025a370>] [<c025a370>] [<c024763e>] [<c025a370>] [<c0258e2d>] [<c025a370>]
 May 11 04:26:28 server kernel:   [nf_hook_slow+478/528] [tcp_v4_send_check+160/240] [tcp_transmit_skb+1001/1792] [sock_def_readable+99/128] [tcp_rfree+0/32] [tcp_rfree+0/32]
 May 11 04:26:28 server kernel:   [<c024763e>] [<c0271c20>] [<c026bdc9>] [<c0237f63>] [<c025d4a0>] [<c025d4a0>]
 May 11 04:26:28 server kernel:   [tcp_rcv_established+1981/2640] [tcp_v4_do_rcv+314/352] [tcp_v4_rcv+1726/1952] [ip_local_deliver_finish+351/416] [ip_local_deliver_finish+0/416] [nf_hook_slow+478/528]
 May 11 04:26:28 server kernel:   [<c026a2bd>] [<c0272eda>] [<c02735be>] [<c025581f>] [<c02556c0>] [<c024763e>]
 May 11 04:26:28 server kernel:   [ip_local_deliver_finish+0/416] [ip_local_deliver+399/576] [ip_local_deliver_finish+0/416] [ip_rcv_finish+553/700] [ip_rcv_finish+0/700] [ip_rcv_finish+0/700]
 May 11 04:26:28 server kernel:   [<c02556c0>] [<c025514f>] [<c02556c0>] [<c0255a89>] [<c0255860>] [<c0255860>]
 May 11 04:26:28 server kernel:   [nf_hook_slow+478/528] [schedule+738/1344] [schedule_timeout+94/160] [poll_freewait+68/80] [do_select+569/592] [sys_select+660/1248]
 May 11 04:26:28 server kernel:   [<c024763e>] [<c011cee2>] [<c011cb1e>] [<c01594d4>] [<c01598d9>] [<c0159bb4>]
 May 11 04:26:28 server kernel:   [sys_ioctl+677/785] [sys_time+21/80] [system_call+51/56]
 May 11 04:26:28 server kernel:   [<c0158905>] [<c0124bb5>] [<c0108fa7>]
 
 #############################################################
 
 May 11 04:30:06 server kernel: do_IRQ: stack overflow: 640
 May 11 04:30:06 server kernel: f3668830 00000280 f2c73080 00000000 f196cd80 d2029180 d2029180 00000042
 May 11 04:30:06 server kernel:        c010d948 f196cd80 f008a0ec d2029180 d2029180 d2029180 00000042 f008a080
 May 11 04:30:06 server kernel:        f1960018 f5fd0018 ffffff14 c0238723 00000010 00000202 d2029180 d2029180
 May 11 04:30:06 server kernel: Call Trace:    [call_do_IRQ+5/13] [__kfree_skb+99/352] [st:__insmod_st_O/lib/modules/2.4.30-hf1/kernel/drivers/scsi/st+4294624756/96] [qdisc_restart+114/432] [dev_queue_xmit+383/880]
 May 11 04:30:06 server kernel: Call Trace:    [<c010d948>] [<c0238723>] [<f90dd5f4>] [<c0248432>] [<c023ccaf>]
 May 11 04:30:06 server kernel:   [ip_finish_output2+184/336] [ip_finish_output2+0/336] [ip_finish_output2+0/336] [nf_hook_slow+478/528] [ip_finish_output2+0/336] [ip_output+334/480]
 May 11 04:30:06 server kernel:   [<c025a2d8>] [<c025a220>] [<c025a220>] [<c024763e>] [<c025a220>] [<c0258a4e>]
 May 11 04:30:06 server kernel:   [ip_finish_output2+0/336] [ip_queue_xmit2+213/671] [ip_queue_xmit2+0/671] [ip_queue_xmit2+0/671] [nf_hook_slow+478/528] [ip_queue_xmit2+0/671]
 May 11 04:30:06 server kernel:   [<c025a220>] [<c025a445>] [<c025a370>] [<c025a370>] [<c024763e>] [<c025a370>]
 May 11 04:30:06 server kernel:   [ip_queue_xmit+845/1536] [ip_queue_xmit2+0/671] [tcp_v4_send_check+160/240] [tcp_transmit_skb+1001/1792] [tcp_send_ack+132/208] [tcp_rfree+0/32]
 May 11 04:30:06 server kernel:   [<c0258e2d>] [<c025a370>] [<c0271c20>] [<c026bdc9>] [<c026e824>] [<c025d4a0>]
 May 11 04:30:06 server kernel:   [tcp_rfree+0/32] [tcp_rcv_established+2042/2640] [tcp_v4_do_rcv+314/352] [tcp_v4_rcv+1726/1952] [ip_local_deliver_finish+351/416] [ip_local_deliver_finish+0/416]
 May 11 04:30:06 server kernel:   [<c025d4a0>] [<c026a2fa>] [<c0272eda>] [<c02735be>] [<c025581f>] [<c02556c0>]
 May 11 04:30:06 server kernel:   [nf_hook_slow+478/528] [ip_local_deliver_finish+0/416] [ip_local_deliver+399/576] [ip_local_deliver_finish+0/416] [ip_rcv_finish+553/700] [ip_rcv_finish+0/700]
 May 11 04:30:06 server kernel:   [<c024763e>] [<c02556c0>] [<c025514f>] [<c02556c0>] [<c0255a89>] [<c0255860>]
 May 11 04:30:06 server kernel:   [ip_rcv_finish+0/700] [nf_hook_slow+478/528] [ip_rcv_finish+0/700] [ip_rcv+905/1216] [ip_rcv_finish+0/700] [netif_receive_skb+485/544]
 May 11 04:30:06 server kernel:   [<c0255860>] [<c024763e>] [<c0255860>] [<c0255589>] [<c0255860>] [<c023d505>]
 May 11 04:30:06 server kernel:   [process_backlog+147/304] [net_rx_action+250/368] [do_softirq+118/224] [do_IRQ+244/304] [call_do_IRQ+5/13] [st:__insmod_st_O/lib/modules/2.4.30-hf1/kernel/drivers/scsi/st+4294806243/96]
 May 11 04:30:06 server kernel:   [<c023d5d3>] [<c023d76a>] [<c01254c6>] [<c010b094>] [<c010d948>] [<f9109ae3>]
 May 11 04:30:06 server kernel:   [st:__insmod_st_O/lib/modules/2.4.30-hf1/kernel/drivers/scsi/st+4294808580/96] [st:__insmod_st_O/lib/modules/2.4.30-hf1/kernel/drivers/scsi/st+4294815256/96] [st:__insmod_st_O/lib/modules/2.4.30-hf1/kernel/drivers/scsi/st+4294702477/96] [st:__insmod_st_O/lib/modules/2.4.30-hf1/kernel/drivers/scsi/st+4294702701/96] [st:__insmod_st_O/lib/modules/2.4.30-hf1/kernel/drivers/scsi/st+4294703097/96] [st:__insmod_st_O/lib/modules/2.4.30-hf1/kernel/drivers/scsi/st+4294703275/96]
 May 11 04:30:06 server kernel:   [<f910a404>] [<f910be18>] [<f90f058d>] [<f90f066d>] [<f90f07f9>] [<f90f08ab>]
 May 11 04:30:06 server kernel:   [st:__insmod_st_O/lib/modules/2.4.30-hf1/kernel/drivers/scsi/st+4294709446/96] [<f914d588>] [isofs_read_super+1131/2048] [<f914f255>] [st:__insmod_st_O/lib/modules/2.4.30-hf1/kernel/drivers/scsi/st+4288825300/96] [st:__insmod_st_O/lib/modules/2.4.30-hf1/kernel/drivers/scsi/st+4288879050/96]
 May 11 04:30:06 server kernel:   [<f90f20c6>] [<f914d588>] [<c018480b>] [<f914f255>] [<f8b557d4>] [<f8b629ca>]
 May 11 04:30:06 server kernel:   [st:__insmod_st_O/lib/modules/2.4.30-hf1/kernel/drivers/scsi/st+4288713668/96] [st:__insmod_st_O/lib/modules/2.4.30-hf1/kernel/drivers/scsi/st+4288789620/96] [st:__insmod_st_O/lib/modules/2.4.30-hf1/kernel/drivers/scsi/st+4288713668/96] [st:__insmod_st_O/lib/modules/2.4.30-hf1/kernel/drivers/scsi/st+4288712232/96] [st:__insmod_st_O/lib/modules/2.4.30-hf1/kernel/drivers/scsi/st+4288755907/96] [st:__insmod_st_O/lib/modules/2.4.30-hf1/kernel/drivers/scsi/st+4288791678/96]
 May 11 04:30:06 server kernel:   [<f8b3a3c4>] [<f8b4cc74>] [<f8b3a3c4>] [<f8b39e28>] [<f8b448c3>] [<f8b4d47e>]
 May 11 04:30:06 server kernel:   [st:__insmod_st_O/lib/modules/2.4.30-hf1/kernel/drivers/scsi/st+4288800963/96] [st:__insmod_st_O/lib/modules/2.4.30-hf1/kernel/drivers/scsi/st+4288763515/96] [st:__insmod_st_O/lib/modules/2.4.30-hf1/kernel/drivers/scsi/st+4288713480/96] [st:__insmod_st_O/lib/modules/2.4.30-hf1/kernel/drivers/scsi/st+4288763309/96] [st:__insmod_st_O/lib/modules/2.4.30-hf1/kernel/drivers/scsi/st+4288815612/96] [__kfree_skb+254/352]
 May 11 04:30:06 server kernel:   [<f8b4f8c3>] [<f8b4667b>] [<f8b3a308>] [<f8b465ad>] [<f8b531fc>] [<c02387be>]
 May 11 04:30:06 server kernel:   [netif_rx+147/496] [st:__insmod_st_O/lib/modules/2.4.30-hf1/kernel/drivers/scsi/st+4294626081/96] [st:__insmod_st_O/lib/modules/2.4.30-hf1/kernel/drivers/scsi/st+4294624756/96] [__kfree_skb+254/352] [st:__insmod_st_O/lib/modules/2.4.30-hf1/kernel/drivers/scsi/st+4294624756/96] [__kfree_skb+254/352]
 May 11 04:30:06 server kernel:   [<c023cfb3>] [<f90ddb21>] [<f90dd5f4>] [<c02387be>] [<f90dd5f4>] [<c02387be>]
 May 11 04:30:06 server kernel:   [__kfree_skb+254/352] [st:__insmod_st_O/lib/modules/2.4.30-hf1/kernel/drivers/scsi/st+4294624756/96] [qdisc_restart+31/432] [dev_queue_xmit+383/880] [ip_finish_output2+184/336] [ip_finish_output2+0/336]
 May 11 04:30:06 server kernel:   [<c02387be>] [<f90dd5f4>] [<c02483df>] [<c023ccaf>] [<c025a2d8>] [<c025a220>]
 May 11 04:30:06 server kernel:   [ip_finish_output2+0/336] [nf_hook_slow+478/528] [ip_finish_output2+0/336] [ip_output+334/480] [ip_finish_output2+0/336] [ip_queue_xmit2+213/671]
 May 11 04:30:06 server kernel:   [<c025a220>] [<c024763e>] [<c025a220>] [<c0258a4e>] [<c025a220>] [<c025a445>]
 May 11 04:30:06 server kernel:   [ip_queue_xmit2+0/671] [ip_queue_xmit2+0/671] [nf_hook_slow+478/528] [ip_queue_xmit2+0/671] [ip_queue_xmit+845/1536] [ip_queue_xmit2+0/671]
 May 11 04:30:06 server kernel:   [<c025a370>] [<c025a370>] [<c024763e>] [<c025a370>] [<c0258e2d>] [<c025a370>]
 May 11 04:30:06 server kernel:   [sock_def_readable+99/128] [tcp_rfree+0/32] [tcp_rfree+0/32] [tcp_rcv_established+1981/2640] [tcp_v4_do_rcv+314/352] [tcp_v4_rcv+1726/1952]
 May 11 04:30:06 server kernel:   [<c0237f63>] [<c025d4a0>] [<c025d4a0>] [<c026a2bd>] [<c0272eda>] [<c02735be>]
 May 11 04:30:06 server kernel:   [ip_local_deliver_finish+351/416] [ip_local_deliver_finish+0/416] [nf_hook_slow+478/528] [ip_local_deliver_finish+0/416] [ip_local_deliver+399/576] [ip_local_deliver_finish+0/416]
 May 11 04:30:06 server kernel:   [<c025581f>] [<c02556c0>] [<c024763e>] [<c02556c0>] [<c025514f>] [<c02556c0>]
 May 11 04:30:06 server kernel:   [ip_rcv_finish+553/700] [__alloc_pages+100/640] [poll_freewait+68/80] [do_select+569/592] [sys_select+660/1248] [sys_ioctl+677/785]
 May 11 04:30:06 server kernel:   [<c0255a89>] [<c013e624>] [<c01594d4>] [<c01598d9>] [<c0159bb4>] [<c0158905>]
 May 11 04:30:06 server kernel:   [sys_time+21/80] [system_call+51/56]
 May 11 04:30:06 server kernel:   [<c0124bb5>] [<c0108fa7>]

--SLDf9lqlvOQaIe6s--
