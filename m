Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130994AbQJ2M1i>; Sun, 29 Oct 2000 07:27:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131032AbQJ2M13>; Sun, 29 Oct 2000 07:27:29 -0500
Received: from dialup183.canberra.net.au ([203.33.188.55]:10244 "EHLO
	didi.localnet") by vger.kernel.org with ESMTP id <S130994AbQJ2M1R>;
	Sun, 29 Oct 2000 07:27:17 -0500
Message-ID: <001801c041a3$1c9538b0$0200a8c0@W2K>
From: "Nick Piggin" <s3293115@student.anu.edu.au>
To: "Linux-Kernel" <linux-kernel@vger.kernel.org>
Subject: [patch]  BSD process accounting: new locking
Date: Sun, 29 Oct 2000 23:23:57 +1100
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0015_01C041FF.4FB63120"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_0015_01C041FF.4FB63120
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

I have attached a very small patch (test9) to remove the kernel lock from
kernel/acct.c. If I am missing something major (a brain?), I apologise in
advance. I have tested this on my UP x86 with spinlock debugging. I would
appreciate comments or an explanation of why this can't be done if you have
the time. Thanks.

Nick

------=_NextPart_000_0015_01C041FF.4FB63120
Content-Type: application/octet-stream;
	name="bsdacct.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="bsdacct.patch"

--- linux/kernel/acct.c	Fri Oct 27 13:22:39 2000=0A=
+++ v2.4.0-test9/linux/kernel/acct.c	Sun Oct 29 22:58:11 2000=0A=
@@ -41,6 +41,10 @@=0A=
  *	Oh, fsck... Oopsable SMP race in do_process_acct() - we must hold=0A=
  * ->mmap_sem to walk the vma list of current->mm. Nasty, since it leaks=0A=
  * a struct file opened for write. Fixed. 2/6/2000, AV.=0A=
+ *=0A=
+ *  2000-10-27 Modified by Nick Piggin to remove usage of the big kernel=0A=
+ *             lock in favour of local spinlocks=0A=
+ *=0A=
  */=0A=
 =0A=
 #include <linux/config.h>=0A=
@@ -77,6 +81,7 @@=0A=
 static struct file *acct_file;=0A=
 static struct timer_list acct_timer;=0A=
 static void do_acct_process(long, struct file *);=0A=
+static spinlock_t acct_lock =3D SPIN_LOCK_UNLOCKED;=0A=
 =0A=
 /*=0A=
  * Called whenever the timer says to check the free space.=0A=
@@ -95,11 +100,11 @@=0A=
 	int res;=0A=
 	int act;=0A=
 =0A=
-	lock_kernel();=0A=
+        spin_lock(&acct_lock);=0A=
 	res =3D acct_active;=0A=
 	if (!file || !acct_needcheck)=0A=
-		goto out;=0A=
-	unlock_kernel();=0A=
+		goto out_unlock;=0A=
+        spin_unlock(&acct_lock);=0A=
 =0A=
 	/* May block */=0A=
 	if (vfs_statfs(file->f_dentry->d_inode->i_sb, &sbuf))=0A=
@@ -113,14 +118,14 @@=0A=
 		act =3D 0;=0A=
 =0A=
 	/*=0A=
-	 * If some joker switched acct_file under us we'ld better be=0A=
+	 * If some joker switched acct_file under us we'd better be=0A=
 	 * silent and _not_ touch anything.=0A=
 	 */=0A=
-	lock_kernel();=0A=
+        spin_lock(&acct_lock);=0A=
 	if (file !=3D acct_file) {=0A=
 		if (act)=0A=
 			res =3D act>0;=0A=
-		goto out;=0A=
+		goto out_unlock;=0A=
 	}=0A=
 =0A=
 	if (acct_active) {=0A=
@@ -140,8 +145,8 @@=0A=
 	acct_timer.expires =3D jiffies + ACCT_TIMEOUT*HZ;=0A=
 	add_timer(&acct_timer);=0A=
 	res =3D acct_active;=0A=
-out:=0A=
-	unlock_kernel();=0A=
+out_unlock:=0A=
+        spin_unlock(&acct_lock); =0A=
 	return res;=0A=
 }=0A=
 =0A=
@@ -182,7 +187,7 @@=0A=
 	}=0A=
 =0A=
 	error =3D 0;=0A=
-	lock_kernel();=0A=
+        spin_lock(&acct_lock);=0A=
 	if (acct_file) {=0A=
 		old_acct =3D acct_file;=0A=
 		del_timer(&acct_timer);=0A=
@@ -200,7 +205,7 @@=0A=
 		acct_timer.expires =3D jiffies + ACCT_TIMEOUT*HZ;=0A=
 		add_timer(&acct_timer);=0A=
 	}=0A=
-	unlock_kernel();=0A=
+        spin_unlock(&acct_lock);=0A=
 	if (old_acct) {=0A=
 		do_acct_process(0,old_acct);=0A=
 		filp_close(old_acct, NULL);=0A=
@@ -214,10 +219,12 @@=0A=
 =0A=
 void acct_auto_close(kdev_t dev)=0A=
 {=0A=
-	lock_kernel();=0A=
-	if (acct_file && acct_file->f_dentry->d_inode->i_dev =3D=3D dev)=0A=
+        spin_lock(&acct_lock);=0A=
+	if (acct_file && acct_file->f_dentry->d_inode->i_dev =3D=3D dev) {=0A=
+                spin_unlock(&acct_lock);=0A=
 		sys_acct(NULL);=0A=
-	unlock_kernel();=0A=
+        } else =0A=
+            spin_unlock(&acct_lock);=0A=
 }=0A=
 =0A=
 /*=0A=
@@ -348,15 +355,15 @@=0A=
 int acct_process(long exitcode)=0A=
 {=0A=
 	struct file *file =3D NULL;=0A=
-	lock_kernel();=0A=
+        spin_lock(&acct_lock);=0A=
 	if (acct_file) {=0A=
 		file =3D acct_file;=0A=
 		get_file(file);=0A=
-		unlock_kernel();=0A=
+                spin_unlock(&acct_lock);=0A=
 		do_acct_process(exitcode, acct_file);=0A=
 		fput(file);=0A=
 	} else=0A=
-		unlock_kernel();=0A=
+                spin_unlock(&acct_lock);=0A=
 	return 0;=0A=
 }=0A=
 =0A=

------=_NextPart_000_0015_01C041FF.4FB63120--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
