Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261676AbVCCNtZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261676AbVCCNtZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 08:49:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261678AbVCCNtX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 08:49:23 -0500
Received: from mail.daysofwonder.com ([213.186.49.53]:62154 "EHLO
	mail.daysofwonder.com") by vger.kernel.org with ESMTP
	id S261676AbVCCNof (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 08:44:35 -0500
Subject: 2.6.10-ac10 oops in journal_commit_transaction
From: Brice Figureau <brice+lklm@daysofwonder.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Thu, 03 Mar 2005 14:45:41 +0100
Message-Id: <1109857541.29075.25.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


I'm reporting an oops on a bi-Xeon database server under 2.6.10-ac10
quite similar to:
http://marc.theaimsgroup.com/?l=ext3-users&m=110848085314238&w=2

I also got another server crashing (a mail server this time), but I
couldn't get the oops/panic.

This was after more than two weeks of uptime, I was running 2.6.10-ac1
before and never got this problem.

Here are the oops information:

Unable to handle kernel NULL pointer dereference at virtual address 0000000c
 printing eip:
c01a858d
*pde = 00000000
Oops: 0002 [#1]
PREEMPT SMP 
Modules linked in: i2c_i801 i2c_core ip_conntrack_ftp ipt_LOG ipt_limit ipt_REJECT ipt_state iptable_filter ip_conntrack ip_tables
CPU:    2
EIP:    0060:[journal_commit_transaction+877/5264]    Not tainted VLI
EFLAGS: 00010286   (2.6.10-ac10) 
EIP is at journal_commit_transaction+0x36d/0x1490
eax: db38a56c   ebx: 00000000   ecx: 00000000   edx: f7779480
esi: f76fa000   edi: db38a56c   ebp: f76fbf60   esp: f76fbdc8
ds: 007b   es: 007b   ss: 0068
Process kjournald (pid: 1206, threadinfo=f76fa000 task=f7454020)
Stack: f191fadc f191fadc 00000008 00000aa2 f76fbe04 f7fea4c0 f7c305b0 00000000 
       f77794b8 f7fea414 00000000 00000000 00000000 00000000 00000000 db313efc 
       f7779480 e4079c2c 00000aa2 00000001 f76fbe28 c01239b0 00000001 f76fbea8 
Call Trace:
 [show_stack+127/160] show_stack+0x7f/0xa0
 [show_registers+351/464] show_registers+0x15f/0x1d0
 [die+256/400] die+0x100/0x190
 [do_page_fault+672/1712] do_page_fault+0x2a0/0x6b0
 [error_code+43/48] error_code+0x2b/0x30
 [kjournald+212/576] kjournald+0xd4/0x240
 [kernel_thread_helper+5/16] kernel_thread_helper+0x5/0x10
Code: 8b 85 a0 fe ff ff 85 c0 0f 85 4f 0e 00 00 8b 95 a8 fe ff ff 8b 42 18 85 c0 0f 84 85 00 00 00 be 00 e0 ff ff 21 e6 8b 78 20 8b 1f <f0> ff 43 0c 8b 03 a8 04 0f 85 de 0d 00 00 89 5c 24 04 8b 4d 08 
 <6>note: kjournald[1206] exited with preempt_count 1

The code crashes in fs/jbd/commit.c journal_commit_transaction in this
particular area at line 314:

...
/*
 * Wait for all previously submitted IO to complete.
 */
while (commit_transaction->t_locked_list) {
	struct buffer_head *bh;

	jh = commit_transaction->t_locked_list->b_tprev;
	bh = jh2bh(jh);
	get_bh(bh);                    <--- crash here because bh is NULL
	if (buffer_locked(bh)) {
		spin_unlock(&journal->j_list_lock);
		wait_on_buffer(bh);
		if (unlikely(!buffer_uptodate(bh)))
			err = -EIO;
		spin_lock(&journal->j_list_lock);
	}
	if (!inverted_lock(journal, bh)) {
		put_bh(bh);
		spin_lock(&journal->j_list_lock);
		continue;
	}
	if (buffer_jbd(bh) && jh->b_jlist == BJ_Locked) {
		__journal_unfile_buffer(jh);
		jbd_unlock_bh_state(bh);
		journal_remove_journal_head(bh);
		put_bh(bh);
	} else {
		jbd_unlock_bh_state(bh);
	}
	put_bh(bh);
	if (need_resched()) {
		spin_unlock(&journal->j_list_lock);
		cond_resched();
		spin_lock(&journal->j_list_lock);
	}
}
...

And more precisely at this stage of the code:

jh = commit_transaction->t_locked_list->b_tprev;
8b 78 20             	mov    0x20(%eax),%edi

bh = jh2bh(jh);
8b 1f                	mov    (%edi),%ebx

get_bh(bh);
f0 ff 43 0c          	lock incl 0xc(%ebx)  <-- crash because ebx is null
8b 03                	mov    (%ebx),%eax

Unfortunately I don't have the knowledge (and time to aquire it) that
will help me chase down this bug/problem.

If you need more information (including .config and other) I'll be happy
to provide it.

Can you CC: me as I'm not subscribed to the list.

Regards,
-- 
Brice Figureau <brice+lklm@daysofwonder.com>

