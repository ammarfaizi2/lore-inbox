Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262545AbUBYBMm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 20:12:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262561AbUBYBMm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 20:12:42 -0500
Received: from fw.osdl.org ([65.172.181.6]:61360 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262545AbUBYBMh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 20:12:37 -0500
Date: Tue, 24 Feb 2004 17:00:24 -0800
From: Andrew Morton <akpm@osdl.org>
To: Corey Minyard <minyard@acm.org>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [PATCH] IPMI driver updates, part 1b
Message-Id: <20040224170024.4e75a85c.akpm@osdl.org>
In-Reply-To: <403BE39D.2080207@acm.org>
References: <403B57B8.2000008@acm.org>
	<403BE39D.2080207@acm.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Corey Minyard <minyard@acm.org> wrote:
>
> It helps to actually attach the code.

Got there eventually.

Patches seem reasonable, thanks.  I'm not sure how to judge the suitability
of the socket interface but it only touches your code..

- Several instances of IPMI_MAX_MSG_LENGTH-sized local arrays.  It's not
  toooo large, but watch out for the stack space.

- You should convert the MODULE_PARMs to module_param() sometime.

- Be aware that the bitfields in struct seq_table will all fall into the
  same word and the compiler doesn't access them atomically.  You must
  provide your own locking to prevent updates to them from scribbling on
  each other.  Or make them integers.

- You misspelt breadcrumbs!

- This:

	extern struct si_sm_handlers kcs_smi_handlers;

  should be in a header file.

- kcs_event_handler() sets `time = 0;' but never uses it again.

- status2txt() should take the caller's char* rather than use a static buffer.

- In ipmi_bt_sm.c:

	volatile unsigned char status;

  The volatile is a red flag.   It seems to be unneeded.

- We have #ifdef CONFIG_HIGH_RES_TIMERS code in there?

- drivers/char/ipmi/ipmi_si.c has lots of

        struct smi_info *smi_info = (struct smi_info *) send_info;

  You don't need to cast a void* and it's actually a harmful thing to do:
  it suppresses useful warnings if someone goes and changes the type of the
  rhs.

- ipmi_wait_for_queue() doesn't need set_current_state(TASK_RUNNING);
  after schedule_timeout() (I removed it)

- There's a locking bug in ipmi_recvmsg(): it can unlock i_lock when it
  isn't held.   I added this:

diff -puN net/ipmi/af_ipmi.c~af_ipmi-locking-fix net/ipmi/af_ipmi.c
--- 25/net/ipmi/af_ipmi.c~af_ipmi-locking-fix	Tue Feb 24 16:56:36 2004
+++ 25-akpm/net/ipmi/af_ipmi.c	Tue Feb 24 16:57:00 2004
@@ -336,6 +336,7 @@ static int ipmi_recvmsg(struct kiocb *io
 		}
 
 		timeo = ipmi_wait_for_queue(i, timeo);
+		spin_lock_irqsave(&i->lock, flags);
 	}
 
 	rcvmsg = list_entry(i->msg_list.next, struct ipmi_recv_msg, link);


 which may or may not be correct.


Anyway, that's all fairly trivial.  Please retest this code in the next
-mm, send me any updates against that as appropriate and we'll get this
merged up, thanks.


