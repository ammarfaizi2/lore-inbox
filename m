Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932361AbWBFUGT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932361AbWBFUGT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 15:06:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932360AbWBFUGT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 15:06:19 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:42112 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932361AbWBFUGR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 15:06:17 -0500
To: <linux-kernel@vger.kernel.org>
Cc: <vserver@list.linux-vserver.org>, Herbert Poetzl <herbert@13thfloor.at>,
       "Serge E. Hallyn" <serue@us.ibm.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Dave Hansen <haveblue@us.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>,
       Suleiman Souhlal <ssouhlal@FreeBSD.org>,
       Hubertus Franke <frankeh@watson.ibm.com>,
       Cedric Le Goater <clg@fr.ibm.com>, Kyle Moffett <mrmacman_g4@mac.com>,
       Kirill Korotaev <dev@sw.ru>, Greg <gkurz@fr.ibm.com>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Greg KH <greg@kroah.com>, Rik van Riel <riel@redhat.com>,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
       Andrey Savochkin <saw@sawoct.com>, Kirill Korotaev <dev@openvz.org>,
       Andi Kleen <ak@suse.de>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Jeff Garzik <jgarzik@pobox.com>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Jes Sorensen <jes@sgi.com>
Subject: [RFC][PATCH 17/20] usb: Fixup usb so it works with pspaces.
References: <m11wygnvlp.fsf@ebiederm.dsl.xmission.com>
	<m1vevsmgvz.fsf@ebiederm.dsl.xmission.com>
	<m1lkwomgoj.fsf_-_@ebiederm.dsl.xmission.com>
	<m1fymwmgk0.fsf_-_@ebiederm.dsl.xmission.com>
	<m1bqxkmgcv.fsf_-_@ebiederm.dsl.xmission.com>
	<m17j88mg8l.fsf_-_@ebiederm.dsl.xmission.com>
	<m13biwmg4p.fsf_-_@ebiederm.dsl.xmission.com>
	<m1y80ol1gh.fsf_-_@ebiederm.dsl.xmission.com>
	<m1u0bcl1ai.fsf_-_@ebiederm.dsl.xmission.com>
	<m1psm0l170.fsf_-_@ebiederm.dsl.xmission.com>
	<m1lkwol133.fsf_-_@ebiederm.dsl.xmission.com>
	<m1hd7cl0yp.fsf_-_@ebiederm.dsl.xmission.com>
	<m1d5i0l0ua.fsf_-_@ebiederm.dsl.xmission.com>
	<m18xsol0p9.fsf_-_@ebiederm.dsl.xmission.com>
	<m14q3cl0mk.fsf_-_@ebiederm.dsl.xmission.com>
	<m1zml4jlzk.fsf_-_@ebiederm.dsl.xmission.com>
	<m1vevsjlxa.fsf_-_@ebiederm.dsl.xmission.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Mon, 06 Feb 2006 13:03:57 -0700
In-Reply-To: <m1vevsjlxa.fsf_-_@ebiederm.dsl.xmission.com> (Eric W.
 Biederman's message of "Mon, 06 Feb 2006 13:02:09 -0700")
Message-ID: <m1r76gjlua.fsf_-_@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>


---

 drivers/usb/core/devio.c |   12 ++++++++++--
 drivers/usb/core/inode.c |    4 +++-
 drivers/usb/core/usb.h   |    1 +
 3 files changed, 14 insertions(+), 3 deletions(-)

94873f6924179bc2ee782f6fb72d5e855c780a1b
diff --git a/drivers/usb/core/devio.c b/drivers/usb/core/devio.c
index 2b68998..7bccb9a 100644
--- a/drivers/usb/core/devio.c
+++ b/drivers/usb/core/devio.c
@@ -47,6 +47,7 @@
 #include <linux/usbdevice_fs.h>
 #include <linux/cdev.h>
 #include <linux/notifier.h>
+#include <linux/pspace.h>
 #include <asm/uaccess.h>
 #include <asm/byteorder.h>
 #include <linux/moduleparam.h>
@@ -61,6 +62,7 @@ static struct class *usb_device_class;
 struct async {
 	struct list_head asynclist;
 	struct dev_state *ps;
+	struct pspace *pspace;
 	pid_t pid;
 	uid_t uid, euid;
 	unsigned int signr;
@@ -224,6 +226,7 @@ static struct async *alloc_async(unsigne
 
 static void free_async(struct async *as)
 {
+	put_pspace(as->pspace);
 	kfree(as->urb->transfer_buffer);
 	kfree(as->urb->setup_packet);
 	usb_free_urb(as->urb);
@@ -316,8 +319,8 @@ static void async_completed(struct urb *
 		sinfo.si_errno = as->urb->status;
 		sinfo.si_code = SI_ASYNCIO;
 		sinfo.si_addr = as->userurb;
-		kill_proc_info_as_uid(as->signr, &sinfo, as->pid, as->uid, 
-				      as->euid);
+		kill_proc_info_as_uid(as->signr, &sinfo, as->pspace, as->pid,
+					 as->uid, as->euid);
 	}
 	snoop(&urb->dev->dev, "urb complete\n");
 	snoop_urb(urb, as->userurb);
@@ -571,6 +574,8 @@ static int usbdev_open(struct inode *ino
 	INIT_LIST_HEAD(&ps->async_completed);
 	init_waitqueue_head(&ps->wait);
 	ps->discsignr = 0;
+	ps->disc_pspace = current->pspace;
+	get_pspace(ps->disc_pspace);
 	ps->disc_pid = current->pid;
 	ps->disc_uid = current->uid;
 	ps->disc_euid = current->euid;
@@ -601,6 +606,7 @@ static int usbdev_release(struct inode *
 	destroy_all_async(ps);
 	usb_unlock_device(dev);
 	usb_put_dev(dev);
+	put_pspace(ps->disc_pspace);
 	ps->dev = NULL;
 	kfree(ps);
         return 0;
@@ -1054,6 +1060,8 @@ static int proc_do_submiturb(struct dev_
 		as->userbuffer = NULL;
 	as->signr = uurb->signr;
 	as->ifnum = ifnum;
+	as->pspace = current->pspace;
+	get_pspace(as->pspace);
 	as->pid = current->pid;
 	as->uid = current->uid;
 	as->euid = current->euid;
diff --git a/drivers/usb/core/inode.c b/drivers/usb/core/inode.c
index 3cf945c..94c91b3 100644
--- a/drivers/usb/core/inode.c
+++ b/drivers/usb/core/inode.c
@@ -700,7 +700,9 @@ static void usbfs_remove_device(struct u
 			sinfo.si_errno = EPIPE;
 			sinfo.si_code = SI_ASYNCIO;
 			sinfo.si_addr = ds->disccontext;
-			kill_proc_info_as_uid(ds->discsignr, &sinfo, ds->disc_pid, ds->disc_uid, ds->disc_euid);
+			kill_proc_info_as_uid(ds->discsignr, &sinfo,
+						ds->disc_pspace, ds->disc_pid,
+						ds->disc_uid, ds->disc_euid);
 		}
 	}
 }
diff --git a/drivers/usb/core/usb.h b/drivers/usb/core/usb.h
index 4647e1e..512c5c7 100644
--- a/drivers/usb/core/usb.h
+++ b/drivers/usb/core/usb.h
@@ -73,6 +73,7 @@ struct dev_state {
 	struct list_head async_completed;
 	wait_queue_head_t wait;     /* wake up if a request completed */
 	unsigned int discsignr;
+	struct pspace *disc_pspace;
 	pid_t disc_pid;
 	uid_t disc_uid, disc_euid;
 	void __user *disccontext;
-- 
1.1.5.g3480

