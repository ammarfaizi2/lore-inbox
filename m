Return-Path: <linux-kernel-owner+w=401wt.eu-S1754932AbXABVfN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754932AbXABVfN (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 16:35:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754966AbXABVfN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 16:35:13 -0500
Received: from atlrel9.hp.com ([156.153.255.214]:39735 "EHLO atlrel9.hp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754932AbXABVfL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 16:35:11 -0500
From: Paul Moore <paul.moore@hp.com>
Organization: Hewlett-Packard
To: Andrew Morton <akpm@osdl.org>
Subject: Re: selinux networking: sleeping functin called from invalid context in 2.6.20-rc[12]
Date: Tue, 2 Jan 2007 16:14:17 -0500
User-Agent: KMail/1.9.5
Cc: "Adam J. Richter" <adam@yggdrasil.com>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
References: <20061225052124.A10323@freya> <20061224162511.eaac4a89.akpm@osdl.org>
In-Reply-To: <20061224162511.eaac4a89.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701021614.18148.paul.moore@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday, December 24 2006 7:25 pm, Andrew Morton wrote:
> On Mon, 25 Dec 2006 05:21:24 +0800
>
> "Adam J. Richter" <adam@yggdrasil.com> wrote:
> > 	Under 2.6.20-rc1 and 2.6.20-rc2, I get the following complaint
> > for several network programs running on my system:
> >
> > [  156.381868] BUG: sleeping function called from invalid context at
> > net/core/sock.c:1523 [  156.381876] in_atomic():1, irqs_disabled():0
> > [  156.381881] no locks held by kio_http/9693.
> > [  156.381886]  [<c01057a2>] show_trace_log_lvl+0x1a/0x2f
> > [  156.381900]  [<c0105dab>] show_trace+0x12/0x14
> > [  156.381908]  [<c0105e48>] dump_stack+0x16/0x18
> > [  156.381917]  [<c011e30f>] __might_sleep+0xe5/0xeb
> > [  156.381926]  [<c025942a>] lock_sock_nested+0x1d/0xc4
> > [  156.381937]  [<c01cc570>] selinux_netlbl_inode_permission+0x5a/0x8e
> > [  156.381946]  [<c01c2505>] selinux_file_permission+0x96/0x9b
> > [  156.381954]  [<c0175a0a>] vfs_write+0x8d/0x167
> > [  156.381962]  [<c017605a>] sys_write+0x3f/0x63
> > [  156.381971]  [<c01040c0>] syscall_call+0x7/0xb
> > [  156.381980]  =======================
>
> There's a glaring bug in selinux_netlbl_inode_permission() - taking
> lock_sock() inside rcu_read_lock().

Sorry for the delay, I'm finally back at a machine where I can look at the 
code.

I've been thinking about Parag Warudkar's and Ingo Molnar's patches as well as 
what the selinux_netlbl_inode_permission() function actually needs to do; I 
think the best answer isn't so much to change the socket locking calls, but 
to restructure the function a bit.

Currently the function does the following (in order):

 1. do some quick sanity checks (is the inode a socket, etc)
 2. rcu_read_lock()
 3. check the nlbl_state is set to NLBL_REQUIRE (otherwise return)
 4. lock_sock()
 5. netlabel magic
 6. release_sock()
 7. rcu_read_unlock()

I propose changing it to the following (in order):

  1. do some quick sanity checks (is the inode a socket, etc)
  2. rcu_read_lock()
  3. check the nlbl_state is set to NLBL_REQUIRE (otherwise return)
  4. rcu_read_unlock()
  5. lock_sock()
  6. rcu_read_lock()
  7. verify that nlbl_state is still set to NLBL_REQUIRE (otherwise return)
  8. netlabel magic
  9. rcu_read_unlock()
 10. release_sock()

This way we no longer need to worry about any special socket locking.  I 
realize this adds a bit of duplicated work but it is my understanding that 
RCU lock/unlock operations are *very* fast so the extra RCU lock operations 
shouldn't be too bad and the extra nlbl_state check should be of minimal 
cost.

However, I'm not the expert here, just a guy learning as he goes so any 
comments/feedback on the above proposal are welcome.  If it turns out this 
approach has some merit I'll put together a patch and send it out.

Once again, sorry for the regression.

-- 
paul moore
linux security @ hp
