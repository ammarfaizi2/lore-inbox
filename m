Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030326AbVI3O5f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030326AbVI3O5f (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Sep 2005 10:57:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030309AbVI3O5f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 10:57:35 -0400
Received: from smtp.osdl.org ([65.172.181.4]:64954 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030308AbVI3O5e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 10:57:34 -0400
Date: Fri, 30 Sep 2005 07:56:59 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Harald Welte <laforge@gnumonks.org>
cc: Sergey Vlasov <vsu@altlinux.ru>, linux-usb-devel@lists.sourceforge.net,
       vendor-sec@lst.de, linux-kernel@vger.kernel.org, greg@kroah.com,
       security@linux.kernel.org
Subject: Re: [linux-usb-devel] Re: [Security] [vendor-sec] [BUG/PATCH/RFC]
 Oops while completing async USB via usbdevio
In-Reply-To: <20050930104749.GN4168@sunbeam.de.gnumonks.org>
Message-ID: <Pine.LNX.4.64.0509300752530.3378@g5.osdl.org>
References: <20050925151330.GL731@sunbeam.de.gnumonks.org>
 <Pine.LNX.4.58.0509270746200.3308@g5.osdl.org> <20050927160029.GA20466@master.mivlgu.local>
 <Pine.LNX.4.58.0509270904140.3308@g5.osdl.org> <20050927165206.GB20466@master.mivlgu.local>
 <Pine.LNX.4.58.0509270959380.3308@g5.osdl.org> <20050930104749.GN4168@sunbeam.de.gnumonks.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 30 Sep 2005, Harald Welte wrote:
> 
> I'm probably the person in this thread who understands the least about
> the USB stack and the scheduler, but if there is no implementation of
> Linus' suggested "PID approach" yet, I'd be willing to write a patch and
> test it. Please let me know.

Here's a totally untested patch. It's guaranteed not to do the "right 
thing", simply because it doesn't _use_ the uid/euid information. But it's 
in the right kind of direction.

If you change the "kill_proc_info()" into a "kill_proc_info_as_uid()" 
call, and add that to kernel/signal.c (which is basically kill_proc_info() 
except it uses the passed-in uid/euid for the "check_kill_permission()" 
tests instead), it should be correct.

As-is, it won't work, because it will use a _random_ uid (whatever is the 
currently running process) for the kill permission. So this really is just 
a "use this as a template" kind of patch, DO NOT APPLY!

		Linus

---
diff --git a/drivers/usb/core/devio.c b/drivers/usb/core/devio.c
--- a/drivers/usb/core/devio.c
+++ b/drivers/usb/core/devio.c
@@ -58,7 +58,8 @@ static struct class *usb_device_class;
 struct async {
 	struct list_head asynclist;
 	struct dev_state *ps;
-	struct task_struct *task;
+	pid_t pid;
+	uid_t uid, euid;
 	unsigned int signr;
 	unsigned int ifnum;
 	void __user *userbuffer;
@@ -290,7 +291,14 @@ static void async_completed(struct urb *
 		sinfo.si_errno = as->urb->status;
 		sinfo.si_code = SI_ASYNCIO;
 		sinfo.si_addr = as->userurb;
-		send_sig_info(as->signr, &sinfo, as->task);
+		/*
+		 * We should have a 
+		 *
+		 *  kill_proc_info_as_uid(signr, info, pid, uid, euid);
+		 *
+		 * but we don't.
+		 */
+		kill_proc_info(as->signr, &sinfo, as->pid);
 	}
         wake_up(&ps->wait);
 }
@@ -988,7 +996,9 @@ static int proc_do_submiturb(struct dev_
 		as->userbuffer = NULL;
 	as->signr = uurb->signr;
 	as->ifnum = ifnum;
-	as->task = current;
+	as->pid = current->pid;
+	as->uid = current->uid;
+	as->euid = current->euid;
 	if (!(uurb->endpoint & USB_DIR_IN)) {
 		if (copy_from_user(as->urb->transfer_buffer, uurb->buffer, as->urb->transfer_buffer_length)) {
 			free_async(as);
