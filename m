Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751232AbWEBTz1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751232AbWEBTz1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 15:55:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751236AbWEBTz1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 15:55:27 -0400
Received: from mf00.sitadelle.com ([212.94.174.67]:33502 "EHLO
	smtp.cegetel.net") by vger.kernel.org with ESMTP id S1751232AbWEBTz0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 15:55:26 -0400
From: Eric Dumazet <dada1@cosmosbay.com>
To: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: [RFC, PATCH] cond_resched() added to close_files()
Date: Tue, 2 May 2006 21:55:31 +0200
User-Agent: KMail/1.9.1
References: <20060419112130.GA22648@elte.hu> <44577822.8050103@mbligh.org> <20060502155244.GA5981@elte.hu>
In-Reply-To: <20060502155244.GA5981@elte.hu>
MIME-Version: 1.0
Message-Id: <200605022155.31990.dada1@cosmosbay.com>
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_zk7VERA5O9hg3PW"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_zk7VERA5O9hg3PW
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

When a process exits, it might spend a lot of time in close_files() closing 
thousand of files.

This is bad for latency, and in some cases can trigger 'BUG: soft lockup 
detected on CPU#0!'

Call Trace: <IRQ> <ffffffff8024dafa>{softlockup_tick+250}
       <ffffffff80236cd7>{update_process_times+87} 
<ffffffff80215ed3>{smp_local_timer_interrupt+35}
       <ffffffff80216411>{smp_apic_timer_interrupt+65} 
<ffffffff8020a866>{apic_timer_interrupt+98} <EOI>
       <ffffffff803a7100>{sock_destroy_inode+0} 
<ffffffff803e4b1f>{tcp_send_fin+207}
       <ffffffff803e4ac4>{tcp_send_fin+116} <ffffffff803d988a>{tcp_close+698}
       <ffffffff803f4a07>{inet_release+87} <ffffffff803a84e9>{sock_release+25}
       <ffffffff803a87f5>{sock_close+53} <ffffffff802767a8>{__fput+88}
       <ffffffff8027382d>{filp_close+93} 
<ffffffff8022ee2e>{put_files_struct+110}
       <ffffffff8023025a>{do_exit+650} 
<ffffffff80237bee>{__dequeue_signal+478}
       <ffffffff80230998>{do_group_exit+200} 
<ffffffff80239c6a>{get_signal_to_deliver+1178}
       <ffffffff80209d47>{sysret_signal+28} <ffffffff80209001>{do_signal+129}
       <ffffffff8028d623>{dput+35} <ffffffff803a92db>{sys_accept+443}
       <ffffffff80241eec>{add_wait_queue+28} <ffffffff802ec581>{__up_write+33}
       <ffffffff80209d47>{sysret_signal+28} 
<ffffffff8020a033>{ptregscall_common+103}

This patch makes sure a cond_resched() call is done every 32 (or 64) files 
closed. This also helps reducing number of files waiting in RCU queues for 
final freeing as call_rcu() might have called force_quiescent_state()

Signed-off-by: Eric Dumazet <dada1@cosmosbay.com>

--Boundary-00=_zk7VERA5O9hg3PW
Content-Type: text/plain;
  charset="iso-8859-1";
  name="close_files.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="close_files.patch"

--- a/kernel/exit.c	2006-05-02 17:31:39.000000000 +0200
+++ b/kernel/exit.c	2006-05-02 17:32:06.000000000 +0200
@@ -445,20 +445,21 @@
 		set = fdt->open_fds->fds_bits[j++];
 		while (set) {
 			if (set & 1) {
 				struct file * file = xchg(&fdt->fd[i], NULL);
 				if (file)
 					filp_close(file, files);
 			}
 			i++;
 			set >>= 1;
 		}
+		cond_resched();
 	}
 }
 
 struct files_struct *get_files_struct(struct task_struct *task)
 {
 	struct files_struct *files;
 
 	task_lock(task);
 	files = task->files;
 	if (files)

--Boundary-00=_zk7VERA5O9hg3PW--
