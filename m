Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129854AbRBYWko>; Sun, 25 Feb 2001 17:40:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129853AbRBYWkf>; Sun, 25 Feb 2001 17:40:35 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:52749 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S129850AbRBYWk2>;
	Sun, 25 Feb 2001 17:40:28 -0500
Date: Sun, 25 Feb 2001 23:39:57 +0100
From: Jens Axboe <axboe@suse.de>
To: Nate Eldredge <neldredge@hmc.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.2-ac3: loop threads in D state
Message-ID: <20010225233957.R7830@suse.de>
In-Reply-To: <15000.9242.867644.29523@mercury.st.hmc.edu> <15001.34865.543658.820963@mercury.st.hmc.edu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="H+4ONPRPur6+Ovig"
Content-Disposition: inline
In-Reply-To: <15001.34865.543658.820963@mercury.st.hmc.edu>; from neldredge@hmc.edu on Sun, Feb 25, 2001 at 02:33:21PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--H+4ONPRPur6+Ovig
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Feb 25 2001, Nate Eldredge wrote:
> Nate Eldredge writes:
>  > Kernel 2.4.2-ac3.
>  > 
>  >  FLAGS   UID   PID  PPID PRI  NI   SIZE   RSS WCHAN       STA TTY TIME COMMAND
>  >     40     0   425     1  -1 -20      0     0 down        DW< ?   0:00 (loop0)
> 
> It looks like this has been addressed in the thread "242-ac3 loop
> bug".  Jens Axboe posted a patch, but the list archive I'm reading
> mangled it.  Jens, could you make this patch available somewhere, or
> at least email me a copy?  (If it's going in an upcoming -ac patch,
> then don't bother; I can wait until then.)

Patch is here, I haven't checked whether Alan put it in ac4 yet (I
did cc him, but noone knows for sure :-).

-- 
Jens Axboe


--H+4ONPRPur6+Ovig
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename=loop_sig-1

--- drivers/block/loop.c~	Sat Feb 24 23:08:38 2001
+++ drivers/block/loop.c	Sat Feb 24 23:11:13 2001
@@ -507,7 +507,7 @@
 	sprintf(current->comm, "loop%d", lo->lo_number);
 
 	spin_lock_irq(&current->sigmask_lock);
-	siginitsetinv(&current->blocked, sigmask(SIGKILL));
+	sigfillset(&current->blocked);
 	flush_signals(current);
 	spin_unlock_irq(&current->sigmask_lock);
 
@@ -525,7 +525,7 @@
 	up(&lo->lo_sem);
 
 	for (;;) {
-		down(&lo->lo_bh_mutex);
+		down_interruptible(&lo->lo_bh_mutex);
 		if (!atomic_read(&lo->lo_pending))
 			break;
 

--H+4ONPRPur6+Ovig--
