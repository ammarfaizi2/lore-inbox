Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261723AbTJ1SOH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Oct 2003 13:14:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264066AbTJ1SOG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Oct 2003 13:14:06 -0500
Received: from fw.osdl.org ([65.172.181.6]:48027 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261723AbTJ1SMg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Oct 2003 13:12:36 -0500
Date: Tue, 28 Oct 2003 10:20:08 -0800 (PST)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
cc: George Anzinger <george@mvista.com>, Pavel Machek <pavel@suse.cz>,
       John stultz <johnstul@us.ibm.com>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [pm] fix time after suspend-to-*
In-Reply-To: <1067329994.861.3.camel@teapot.felipe-alfaro.com>
Message-ID: <Pine.LNX.4.44.0310281019280.1023-100000@cherise>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Many userspace applications are not prepared for suspension, like
> Evolution. When suspending the machine for a long time, all IMAP
> sessions are broken as their counterpart TCP sockets timeout. While
> resuming, Evolution is unable to handle this condition and simply
> informs the network connection has been dropped.
> 
> What about sending the SIGPWR signal to all userspace processes before
> suspending so applications like Evolution can be improved to handle this
> signal, drop their IMAP connections and then, when resuming, reestablish
> them?

SIGPWR already has meaning, and I do not want to overload it. Besides a
signal does not seem like the best solution - a new signal will require
each application to be recompiled, and may cause some unexpected behavior
as some otherwise stable applications break. I.e. it's too intrusive of a
requirement. Plus AFAIK, signals are delivered asynchronously, so there is
no way to know if the applications finished doing the necessary work..
                                                                                
I posted the patch below to the linux-acpi list a few weeks ago. It causes
/sbin/hotplug to be called on both suspend and resume. It's a lightweight,
non-intrusive notification mechanism that allows only the applications
that care about the events be notified of the transition.
                                                                                
It waits for the call to return, which guarantees that the applications
will have enough time to complete what ever it is they need to do (close
IMAP connections, shut down the 3d accelerator, etc).
                                                                                
AFAIK, /sbin/hotplug now also generates a D-BUS message, which the desktop
applications will receive, allowing them to transparently hook into the
sequence.


	Pat

===== kernel/power/main.c 1.16 vs edited =====
--- 1.16/kernel/power/main.c	Mon Sep  8 15:13:46 2003
+++ edited/kernel/power/main.c	Tue Sep 30 15:35:47 2003
@@ -16,6 +16,7 @@
 #include <linux/delay.h>
 #include <linux/errno.h>
 #include <linux/init.h>
+#include <linux/kmod.h>
 #include <linux/pm.h>
 
 
@@ -117,6 +118,59 @@
 
 
 
+#ifdef CONFIG_HOTPLUG
+
+
+/**
+ *	user_suspend - notify userspace of suspend.
+ *
+ *	Notify userspace that we're going to sleep, and wait for it to finish
+ *	shutting down whatever it needs before we proceed.
+ *
+ */
+	
+static int tell_userspace(char * state, int suspend)
+{
+	char * argv[3];
+	char * envp[5];
+	char env_action[16];
+	char env_state[16];
+	int error;
+
+	if (!hotplug_path[0])
+		return 0;
+
+	argv[0] = hotplug_path;
+	argv[1] = "power";
+	argv[2] = NULL;
+
+	snprintf(env_state,16,"STATE=%s",state);
+	snprintf(env_action,16,"ACTION=%s",suspend ? "suspend" : "resume");
+
+	envp[0] = "HOME=/";
+	envp[1] = "PATH=/sbin:/bin:/usr/sbin:/usr/bin";
+	envp[2] = env_action;
+	envp[3] = env_state;
+	envp[4] = NULL;
+
+	pr_debug("PM: Calling userspace: %s %s\n",env_action,env_state);
+
+	error = call_usermodehelper(argv[0],argv,envp,1);
+
+	return error;
+}
+
+
+#else /* CONFIG_HOTPLUG */
+
+
+static int tell_userspace(char * state, int suspend)
+{
+	return 0;
+}
+
+#endif 
+
 
 char * pm_states[] = {
 	[PM_SUSPEND_STANDBY]	= "standby",
@@ -150,9 +204,12 @@
 		goto Unlock;
 	}
 
+	if ((error = tell_userspace(pm_states[state],1)))
+		goto Unlock;
+
 	if (state == PM_SUSPEND_DISK) {
 		error = pm_suspend_disk();
-		goto Unlock;
+		goto Resume;
 	}
 
 	pr_debug("PM: Preparing system for suspend\n");
@@ -164,6 +221,8 @@
 
 	pr_debug("PM: Finishing up.\n");
 	suspend_finish(state);
+ Resume:
+	tell_userspace(pm_states[state],0);
  Unlock:
 	up(&pm_sem);
 	return error;

