Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750988AbVKJFkV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750988AbVKJFkV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 00:40:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751113AbVKJFkV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 00:40:21 -0500
Received: from ns.suse.de ([195.135.220.2]:10388 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750988AbVKJFkU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 00:40:20 -0500
From: Neil Brown <neilb@suse.de>
To: Chris Boot <bootc@bootc.net>
Date: Thu, 10 Nov 2005 16:40:13 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17266.56637.123797.468396@cse.unsw.edu.au>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.14-mm1 RAID-1 in D< state
In-Reply-To: message from Chris Boot on Wednesday November 9
References: <4371FA5B.6030900@bootc.net>
	<17266.30440.930561.902428@cse.unsw.edu.au>
	<3356B173-1C22-4C46-8CC4-1A08C303C63D@bootc.net>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Thanks for the trace.  I see what is happening.
I changed
  wait_event_timeout_interruptible 
in md.c(md_thread) to
  wait_event_timeout

as the thread no longer needs to be able to respond the signals.
However that has the side-effect of putting the process in the 'D'
state and adding to the 'uptime'.

I guess I'll put that back...

NeilBrown


Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./drivers/md/md.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff ./drivers/md/md.c~current~ ./drivers/md/md.c
--- ./drivers/md/md.c~current~	2005-11-10 16:39:04.000000000 +1100
+++ ./drivers/md/md.c	2005-11-10 16:39:28.000000000 +1100
@@ -3439,10 +3439,11 @@ static int md_thread(void * arg)
 	allow_signal(SIGKILL);
 	while (!kthread_should_stop()) {
 
-		wait_event_timeout(thread->wqueue,
-				   test_bit(THREAD_WAKEUP, &thread->flags)
-				   || kthread_should_stop(),
-				   thread->timeout);
+		wait_event_timeout_interruptible
+			(thread->wqueue,
+			 test_bit(THREAD_WAKEUP, &thread->flags)
+			 || kthread_should_stop(),
+			 thread->timeout);
 		try_to_freeze();
 
 		clear_bit(THREAD_WAKEUP, &thread->flags);
