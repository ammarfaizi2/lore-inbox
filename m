Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278928AbRJ2BBq>; Sun, 28 Oct 2001 20:01:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278930AbRJ2BB0>; Sun, 28 Oct 2001 20:01:26 -0500
Received: from t10-09.ra.uc.edu ([129.137.228.225]:30080 "EHLO cartman")
	by vger.kernel.org with ESMTP id <S278928AbRJ2BBS>;
	Sun, 28 Oct 2001 20:01:18 -0500
Date: Sun, 28 Oct 2001 20:01:53 -0500
To: jgarzik@mandrakesoft.com, linux-kernel@vger.kernel.org
Subject: [PATCH] 8139too reparent_to_init() race
Message-ID: <20011028200153.A331@cartman>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
From: Robert Kuebel <kuebelr@email.uc.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello all,

lately i noticed this message during boot-up (when the network
interfaces were being configured) ...

"task `ifconfig' exit_signal 17 in reparent_to_init"

this happens only about 1/2 of the time.

after some digging this is what i found...
sometimes ifconfig's parent exits before ifconfig reaches
rtl8139_thread().  when this happens, ifconfig's exit_signal is set to
SIGCHLD (in forget_original_parent), because its new parent is init.
then rlt8139_thread() is reached it calls reparent_to_init(), which
complains that exit_signal is already non-zero.

basically this patch stops rtl8139_thread() from calling
reparent_to_init() when its parent is already init.

is this the right way to fix the problem?
should reparent_to_init() check that the parent is not already init?

as a budding kernel hacker i would appreciate any comment on this
change.

please, cc me on replies.  i can only handle the digest form of this
list.

thanks.
rob.

--- linux-2.4.13/drivers/net/8139too.orig.c	Sun Oct 28 18:16:48 2001
+++ linux-2.4.13/drivers/net/8139too.c	Sun Oct 28 18:18:47 2001
@@ -1654,7 +1654,8 @@
 	unsigned long timeout;
 
 	daemonize ();
-	reparent_to_init();
+	if (current->p_opptr != child_reaper)
+		reparent_to_init();
 	spin_lock_irq(&current->sigmask_lock);
 	sigemptyset(&current->blocked);
 	recalc_sigpending(current);
