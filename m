Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261380AbUDCAFl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Apr 2004 19:05:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261416AbUDCAFl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Apr 2004 19:05:41 -0500
Received: from ns.suse.de ([195.135.220.2]:22498 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261380AbUDCAF3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Apr 2004 19:05:29 -0500
Date: Sat, 3 Apr 2004 02:04:47 +0200
From: Kurt Garloff <garloff@suse.de>
To: Andrew Morton <akpm@osdl.org>, Rik van Riel <riel@redhat.com>
Cc: Linux kernel list <linux-kernel@vger.kernel.org>
Subject: oom-killer adjustments
Message-ID: <20040403000447.GU3328@tpkurt.garloff.de>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
	Andrew Morton <akpm@osdl.org>, Rik van Riel <riel@redhat.com>,
	Linux kernel list <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ECAkxgSy0pGoHfdA"
Content-Disposition: inline
X-Operating-System: Linux 2.6.4-4-KG i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: SUSE/Novell
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ECAkxgSy0pGoHfdA
Content-Type: multipart/mixed; boundary="Zll6mx50Q8J7qlLQ"
Content-Disposition: inline


--Zll6mx50Q8J7qlLQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Andrew, Rik,

the oom-killer in Linux does not seem to cope well with all situations.

This is no wonder: It can't know what the admin really considers as
important, so it can't always take the right decision. It can only
do some heuristics and make sure that the killing at least will mitigate
the OOM situation. It takes some other factors into account and of course
one could argue about tweaking it some more. But probably what we have=20
nowadays is as good as it can get.

Attached patch does not try to tweak the heuristics, but leaves it as it
is. Instead it allows the sysadmin (CAP_SYS_RESOURCE) to adjust the
outcome of the oom score calculation by a power of two in=20
1 << [-16 .. 15], thus allowing the sysadmin to mark the importance of
a process.=20
One could argue that then we should get rid of the heuristics completely.=
=20
I disagree: If a process start to leak mem after some time, the score
still increases which is an important property of the current score=20
calculation that should not be dropped in favour of static values.
Thus the adjustment factor.
Tha adjustment is done per process via /proc/$PID/oom_adj

The patch does two other things:
* It also exports the oom_score to userspace in /proc/$PID/oom_score
* It does try to kill the process by SIGTERM first, before sending
  SIGKILL. If we're lucky, the process exits gracefully before the
  SIGKILL is needed.

Please consider applying,
--=20
Kurt Garloff  <garloff@suse.de>                            Cologne, DE=20
SUSE LINUX AG, Nuernberg, DE                          SUSE Labs (Head)

--Zll6mx50Q8J7qlLQ
Content-Type: text/plain; charset=us-ascii
Content-Description: protect-pids-from-oom2.diff
Content-Disposition: attachment; filename=protect-pids-from-oom2
Content-Transfer-Encoding: quoted-printable

diff -uNrp linux-2.6.4.old/fs/proc/base.c linux-2.6.4/fs/proc/base.c
--- linux-2.6.4.old/fs/proc/base.c	2004-04-01 19:57:29.000000000 +0200
+++ linux-2.6.4/fs/proc/base.c	2004-04-02 12:01:52.000000000 +0200
@@ -69,6 +69,8 @@ enum pid_directory_inos {
 	PROC_TGID_ATTR_FSCREATE,
 #endif
 	PROC_TGID_FD_DIR,
+	PROC_TGID_OOM_SCORE,
+	PROC_TGID_OOM_ADJUST,
 	PROC_TID_INO,
 	PROC_TID_STATUS,
 	PROC_TID_MEM,
@@ -96,6 +98,8 @@ enum pid_directory_inos {
         PROC_TGID_DELAY_ACCT,
 #endif
 	PROC_TID_FD_DIR =3D 0x8000,	/* 0x8000-0xffff */
+	PROC_TID_OOM_SCORE,
+	PROC_TID_OOM_ADJUST,
 };
=20
 struct pid_entry {
@@ -134,6 +138,8 @@ static struct pid_entry tgid_base_stuff[
 #ifdef CONFIG_KALLSYMS
 	E(PROC_TGID_WCHAN,     "wchan",   S_IFREG|S_IRUGO),
 #endif
+	E(PROC_TGID_OOM_SCORE, "oom_score",S_IFREG|S_IRUSR),
+	E(PROC_TGID_OOM_ADJUST,"oom_adj", S_IFREG|S_IRUSR|S_IWUSR),
 	{0,0,NULL,0}
 };
 static struct pid_entry tid_base_stuff[] =3D {
@@ -159,6 +165,8 @@ static struct pid_entry tid_base_stuff[]
 #ifdef CONFIG_KALLSYMS
 	E(PROC_TID_WCHAN,      "wchan",   S_IFREG|S_IRUGO),
 #endif
+	E(PROC_TID_OOM_SCORE,  "oom_score",S_IFREG|S_IRUSR),
+	E(PROC_TID_OOM_ADJUST, "oom_adj", S_IFREG|S_IRUSR|S_IWUSR),
 	{0,0,NULL,0}
 };
=20
@@ -416,6 +424,14 @@ static int proc_pid_wchan(struct task_st
 }
 #endif /* CONFIG_KALLSYMS */
=20
+/* The badness from the OOM killer */
+int badness(struct task_struct *p);
+static int proc_oom_score(struct task_struct *task, char *buffer)
+{
+	int points =3D badness(task);
+	return sprintf(buffer, "%i\n", points);
+}
+
 /************************************************************************/
 /*                       Here the fs part begins                        */
 /************************************************************************/
@@ -753,6 +769,55 @@ static struct file_operations proc_mapba
 };
 #endif /* __HAS_ARCH_PROC_MAPPED_BASE */
=20
+static ssize_t oom_adjust_read(struct file * file, char * buf,
+				size_t count, loff_t *ppos)
+{
+	struct task_struct *task =3D proc_task(file->f_dentry->d_inode);
+	char buffer[8];
+	size_t len;
+	int oom_adjust =3D task->oomkilladj;
+
+	len =3D sprintf(buffer, "%i\n", oom_adjust) + 1;
+	if (*ppos >=3D len)
+		return 0;
+	if (count > len-*ppos)
+		count =3D len-*ppos;
+	if (copy_to_user(buf, buffer + *ppos, count))=20
+		return -EFAULT;
+	*ppos +=3D count;
+	return count;
+}
+
+static ssize_t oom_adjust_write(struct file * file, const char * buf,
+				size_t count, loff_t *ppos)
+{
+	struct task_struct *task =3D proc_task(file->f_dentry->d_inode);
+	char buffer[8], *end;
+	int oom_adjust;
+
+	if (!capable(CAP_SYS_RESOURCE))
+		return -EPERM;
+	memset(buffer, 0, 8);=09
+	if (count > 6)
+		count =3D 6;
+	if (copy_from_user(buffer, buf, count))=20
+		return -EFAULT;
+	oom_adjust =3D simple_strtol(buffer, &end, 0);
+	if (oom_adjust < -16 || oom_adjust > 15)
+		return -EINVAL;
+	if (*end =3D=3D '\n')
+		end++;
+	task->oomkilladj =3D oom_adjust;
+	if (end - buffer =3D=3D 0)=20
+		return -EIO;
+	return end - buffer;
+}
+
+static struct file_operations proc_oom_adjust_operations =3D {
+	read:		oom_adjust_read,
+	write:		oom_adjust_write,
+};
+
 static struct inode_operations proc_mem_inode_operations =3D {
 	.permission	=3D proc_permission,
 };
@@ -1467,6 +1532,15 @@ static struct dentry *proc_pident_lookup
 			ei->op.proc_read =3D proc_pid_delay;
 			break;
 #endif
+		case PROC_TID_OOM_SCORE:=09
+		case PROC_TGID_OOM_SCORE:
+			inode->i_fop =3D &proc_info_file_operations;
+			ei->op.proc_read =3D proc_oom_score;
+			break;
+		case PROC_TID_OOM_ADJUST:
+		case PROC_TGID_OOM_ADJUST:
+			inode->i_fop =3D &proc_oom_adjust_operations;
+			break;
 		default:
 			printk("procfs: impossible type (%d)",p->type);
 			iput(inode);
diff -uNrp linux-2.6.4.old/include/linux/sched.h linux-2.6.4/include/linux/=
sched.h
--- linux-2.6.4.old/include/linux/sched.h	2004-04-01 19:57:29.000000000 +02=
00
+++ linux-2.6.4/include/linux/sched.h	2004-04-02 11:33:10.305376136 +0200
@@ -442,7 +442,9 @@ struct task_struct {
 	struct user_struct *user;
 /* limits */
 	struct rlimit rlim[RLIM_NLIMITS];
-	unsigned short used_math;
+	unsigned short used_math:1;
+	unsigned short rcvd_sigterm:1;	/* Received SIGTERM by oom killer already =
*/
+	short oomkilladj:5;		/* OOM kill score adjustment (bit shift) */
 	char comm[16];
 /* file system info */
 	int link_count, total_link_count;
diff -uNrp linux-2.6.4.old/mm/oom_kill.c linux-2.6.4/mm/oom_kill.c
--- linux-2.6.4.old/mm/oom_kill.c	2004-03-11 03:55:28.000000000 +0100
+++ linux-2.6.4/mm/oom_kill.c	2004-04-02 11:37:34.802253850 +0200
@@ -41,7 +41,7 @@
  *    of least surprise ... (be careful when you change it)
  */
=20
-static int badness(struct task_struct *p)
+int badness(struct task_struct *p)
 {
 	int points, cpu_time, run_time, s;
=20
@@ -93,6 +93,20 @@ static int badness(struct task_struct *p
 	 */
 	if (cap_t(p->cap_effective) & CAP_TO_MASK(CAP_SYS_RAWIO))
 		points /=3D 4;
+
+	/*=20
+	 * Adjust the score by oomkilladj.
+	 */
+	if (p->oomkilladj)
+		if (p->oomkilladj > 0)
+			points <<=3D p->oomkilladj;
+		else
+			points >>=3D -(p->oomkilladj);
+	/*=20
+	 * One point for already having received a warning=20
+	 */
+	points +=3D p->rcvd_sigterm;
+	=09
 #ifdef DEBUG
 	printk(KERN_DEBUG "OOMkill: task %d (%s) got %d points\n",
 	p->pid, p->comm, points);
@@ -152,11 +166,13 @@ static void __oom_kill_task(task_t *p)
 	p->flags |=3D PF_MEMALLOC | PF_MEMDIE;
=20
 	/* This process has hardware access, be more careful. */
-	if (cap_t(p->cap_effective) & CAP_TO_MASK(CAP_SYS_RAWIO)) {
+	if (cap_t(p->cap_effective) & CAP_TO_MASK(CAP_SYS_RAWIO))
 		force_sig(SIGTERM, p);
-	} else {
+	else if (p->rcvd_sigterm++)
 		force_sig(SIGKILL, p);
-	}
+	else
+		force_sig(SIGTERM, p);
+
 }
=20
 static struct mm_struct *oom_kill_task(task_t *p)

--Zll6mx50Q8J7qlLQ--

--ECAkxgSy0pGoHfdA
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFAbf+fxmLh6hyYd04RAiZMAKCk4aKRznaAmAhy4cF63+dDIEXReQCeMVfR
pAPv7J1ui53QB58fRW7e6CM=
=TMWD
-----END PGP SIGNATURE-----

--ECAkxgSy0pGoHfdA--
