Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262719AbUDAGLy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 01:11:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262709AbUDAGLy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 01:11:54 -0500
Received: from sccrmhc13.comcast.net ([204.127.202.64]:12963 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S262721AbUDAGLW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 01:11:22 -0500
Subject: [PATCH] multiple namespaces
From: Albert Cahalan <albert@users.sf.net>
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: 
Message-Id: <1080799866.1593.2.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 01 Apr 2004 01:11:06 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch lets a task have access to multiple namespaces.
You can create extra namespaces with the included SUBST command.
Then, from the bash prompt, you can switch from one namespace
to another by typing commands like "C" or "D". The default
namespace is "C" for compatibility reasons. You could assign
the "D" namespace to /mnt/cdrom for example. Unlike a similar
and inferior concept found in Windows, Linux namespaces are
case-sensitive for twice the power.

The POSIX-standard "//../" escape prefix hasn't been done yet.
Sorry. Avoiding setuid mounts would be a good idea as well,
until setuid execution can be blocked when not running in
the 'C' namespace.

In the usage example below, note that /bin/pwd has the
correct directory. Somebody who knows the bash code well
will need to unconfuse the shell about namespace changes.

################### EXAMPLE USAGE ######################
root 0 ~# /bin/pwd
/root
root 0 ~# PS1='\D:\w> '
C:~> subst D: /mnt/cdrom
C:~> D
D:~> ls -og
total 38292
-rw-r--r--    1  2557952 Apr  1  2004 ADrives-Abort_Retry_Fail.mp3
-rw-r--r--    1  3719000 Apr  1  2004 AlViro-13th_Floor_Balcony.mp3
-rw-r--r--    1  4046098 Apr  1  2004 AlViro-Another_Seizure.mp3
-rw-r--r--    1  6297937 Apr  1  2004 AlViro-Drive_Me_Insane.mp3
-rw-r--r--    1  4648960 Apr  1  2004 AlViro-Kill_Me_Again_Today.mp3
-rw-r--r--    1  3704718 Apr  1  2004 AlViro-See_Colon.mp3
-rw-r--r--    1  2557952 Apr  1  2004 AndrewTridgell-Samba_Like_A_Fool.mp3
-rw-r--r--    1  3348608 Apr  1  2004 BillyG-One_Microsoft_Way.mp3
-rw-r--r--    1  3362944 Apr  1  2004 DarlMcBride-You_Can_Have_This_One.mp3
-rw-r--r--    1  3794944 Apr  1  2004 LinusAndThePenguins-Case_Sensitivity.mp3
-rw-r--r--    1  1092545 Apr  1  2004 RMS-Be_Freeeeeee.mp3
D:~> /bin/pwd
/mnt/cdrom
D:~> cat /proc/$$/status
Name:   bash
State:  S (sleeping)
SleepAVG:       91%
Tgid:   969
Pid:    969
PPid:   694
TracerPid:      0
Uid:    0       0       0       0
Gid:    0       0       0       0
Drive:  D
FDSize: 256
Groups: 0 
VmSize:     2968 kB
VmLck:         0 kB
VmRSS:      1520 kB
VmData:      168 kB
VmStk:        24 kB
VmExe:       612 kB
VmLib:      1720 kB
Threads:        1
SigPnd: 0000000000000000
ShdPnd: 0000000000000000
SigBlk: 0000000000010000
SigIgn: 8000000000384004
SigCgt: 000000004b813efb
CapInh: 0000000000000000
CapPrm: 00000000fffffeff
CapEff: 00000000fffffeff
D:~> 
###############################################################

///////////////// The SUBST Program //////////////////////////
#include <sys/prctl.h>
#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>

#ifndef PR_SUBST_DESTROY
#define PR_GET_DRIVE 42     /* get the current drive */
#define PR_SET_DRIVE 69     /* set the current drive */
#define PR_SUBST_CREATE 666   /* associate a drive letter with something */
#define PR_SUBST_DESTROY 20040401   /* kill a drive letter */
#endif

static void usage(void){
  fprintf(stderr,
    "SUBST DRIVE PATH\n"
    "SUBST DRIVE\n"        /* we use this for deletion */
  );
}

int main(int argc, char *argv[]){
  switch(argc){
    default:
      usage();
      exit(19);
    case 2:
      if(!prctl(PR_SUBST_DESTROY, argv[1][0]))
        exit(0);
      perror("PR_SUBST_DESTROY");
      exit(33);
    case 3:
      if(chdir(argv[2])){
        perror("chdir");
        exit(88);
      }
      if(!prctl(PR_SUBST_CREATE, argv[1][0]))
        exit(0);
      perror("PR_SUBST_CREATE");
      exit(33);
  }
}
///////////////////////////////////////////////////////////////

Here is a bash-2.05a patch. It's bad enough that I made it gzipped,
uuencoded, and rot13 encrypted... though I must admit that the bash
code does not become significantly more evil with my changes. Also I
didn't want somebody to accidentally apply this patch to the kernel.

ortva 644 onfu-2.05n.cngpu.tm
Z'KY(`"Z=:G`"`^68:I_:2!2&/^-?<=2A!,08&\CR"7Y)I$M+-U6(EIMR)B*.
Z/0.K-38:SF91H?^^9\F-29EQW'DPO+#]FBP,.7KKQ?D2;F(!V4>6T$+U4\4N
ZG4EVRX4M49IRL\=>$*QA+5,I@8!]>I%:4N3RR0OLWW;5%$H7]`V43Y]X]7--
Z*IA;`8V6HF1)RA57=TU<VT9>GL^$A;@`13\Z-4#&[GU5+OKQQ."Z%[P^QP+K
Z/8WV%L9T?M(WV]3[2%HC-_;%#.W30!1^/;"'HY@I!]H_+%11\@+I0(7&&4MC
Z@'U32<;/;W,JL;(W2O%!L)5T;DKSC3@/QO1$ZUISE+:VRMW5EPV=+KP!V<3D
ZS?I5\*@RQV5Q]9?&X@!\`NFO&;/=)><YO.HB(?_O!5,;=>;&(;]/:V%_MKE[
Z5M-A#^[C_'+<,G;=/R[8:ECU#Z_J!_@Q^@;<C2>\^H:2#:DKEO(1'EPJBP+C
Z61CF7Y;R5Y\4<;$M2=M&@8+B17%1QQ&,?_Y#G[[W#Q=C(A26)']?FK`J*22(
Z"SQ`)<P?L4A@X?M*SF`KBA].<7`6+FTA97IGP+&UC[LY=M_&`MB8IWJ[(;);
ZT:UWG!"+\+`2/')B.S4<UEO<$;V9=#SC+"O\^"1JK5]<!T\Q5%W[!)KS/!C;
ZNP4<OU@_'A`DGJP,3#FSBTP,@^$DPDI/Q<9P9.(D]Y5P'`E/<>DK.SQ\T4C\
ZT7JD=`M&VJ/Y>-VV/.H,/.H]\;0/NW=]['N(&@_)D$/ID4,.NU<<.DKTP<?)
ZD./YO\<L&![TI/&K:3DA)NLJ7FFAC?"KDKM'VB'03#DG7FFG8'PUQ>)1H5]]
Z$99@HK$4+J8ZA(,,M1L$EYXHH>I:-7J>.RT@IFUXJF\I,Z9ERR6ETTVWQ52;
Z/I.1/'A[?V9VP33XO=R0+MI]NX?K^]UK%T-EZE#D+'$X5VK&W"=C/>N_A![9
ZC]&@IJZTSL;1-EGK47_2/JS7M9]Y5:N54_K);)8,+'Z@Z4H[H/_;MA64Y[/=
Z5*]B6D^BI[GN\YUV%2C+5VL/ULXK*'V#XL::26IL&L)FS.]#@42ALK'6+`W1
ZL5PQQ@7;EXW>M#27]"M)&3K2,,Q]?`P%$:\T(9\3;-[<P9R[J.#OHRSOFY(U
Z#YO<C7*1-`]*$K]',?D7FUZ5[D^Y$YXT1`S6<C>;+)C`<6,1^'/U1*AOSYH:
Z4R3F5-A86;RH6['LKR/R%NYU?M/R6HZ]&A+6N%([CA8-VURHR$EL)&+O;?D\
Z?;G*@?<7J!TN<%*\SD/?#HGU5$6XV;?1D#;;_G%;>"5Z]7S\/)65_%D6\PXN
Z558!9@6B9*476C^+3[(*0ZB'TK7-W(==.K6_<.,@#^=KK+P__FW+[>;S%```
`
raq


CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC

Here is the kernel patch. Enjoy. (linux-2.6.5-rc3 based)

diff -Naurd old/fs/namespace.c new/fs/namespace.c
--- old/fs/namespace.c	2004-03-30 18:31:40.000000000 -0500
+++ new/fs/namespace.c	2004-03-31 17:30:07.000000000 -0500
@@ -32,6 +32,122 @@
 static int hash_mask, hash_bits;
 static kmem_cache_t *mnt_cache; 
 
+static struct fs_struct *drive_array[128];
+spinlock_t drive_array_lock __cacheline_aligned_in_smp = SPIN_LOCK_UNLOCKED;
+
+#if 0
+void shutdown_drive_array(void)
+{
+	int i == sizeof(drive_array)/sizeof(drive_array[0]);
+	spin_lock(&drive_array_lock);
+		while (i--) {
+			if (drive_array[i]) {
+				put_fs_struct(drive_array[i]);
+				drive_array[i] = NULL;
+			}
+		}
+	spin_unlock(&drive_array_lock);
+}
+#endif
+
+long set_current_drive(int drive)
+{
+	struct fs_struct *src;
+	struct fs_struct *dst;
+	int ret = -EINVAL;
+	if (drive=='C' || drive<'A' || drive>'z')
+		return -EINVAL;
+	spin_lock(&drive_array_lock);
+	dst = current->fs;
+	src = drive_array[drive];
+	write_lock(&dst->lock);
+
+	if (src || drive=='C') {
+		if (dst->currentdrive == 'C') {
+			dst->c_rootmnt    = dst->rootmnt;
+			dst->c_root       = dst->root;
+			dst->c_pwdmnt     = dst->pwdmnt;
+			dst->c_pwd        = dst->pwd;
+			dst->c_altrootmnt = dst->altrootmnt;
+			dst->c_altroot    = dst->altroot;
+		} else {
+			dput(dst->root);
+			mntput(dst->rootmnt);
+			dput(dst->pwd);
+			mntput(dst->pwdmnt);
+			if (dst->altroot) {
+				dput(dst->altroot);
+				mntput(dst->altrootmnt);
+			}
+		}
+
+		ret = 0;
+		dst->currentdrive = drive;
+
+		if (drive=='C') {
+			dst->rootmnt    = dst->c_rootmnt;
+			dst->root       = dst->c_root;
+			dst->pwdmnt     = dst->c_pwdmnt;
+			dst->pwd        = dst->c_pwd;
+			dst->altrootmnt = dst->c_altrootmnt;
+			dst->altroot    = dst->c_altroot;
+		} else {
+			dst->rootmnt = mntget(src->rootmnt);
+			dst->root    = dget(src->root);
+			dst->pwdmnt  = mntget(src->pwdmnt);
+			dst->pwd     = dget(src->pwd);
+			if (src->altroot) {
+				dst->altrootmnt = mntget(src->altrootmnt);
+				dst->altroot    = dget(src->altroot);
+			} else {
+				dst->altrootmnt = NULL;
+				dst->altroot    = NULL;
+			}
+		}
+
+	}
+
+	write_unlock(&dst->lock);
+	spin_unlock(&drive_array_lock);
+	return ret;
+}
+
+long subst_drive_create(int drive)
+{
+	struct fs_struct *fs;
+	printk("sizeof(drive_array) is %u\n", (unsigned)sizeof(drive_array));
+	printk("asked for drive '%c' 0x%02u %d\n", (char)drive, (unsigned)drive, drive);
+	if (drive=='C' || drive<'A' || drive>'z')
+		return -EINVAL;
+	spin_lock(&drive_array_lock);
+	fs = drive_array[drive];
+	drive_array[drive] = copy_fs_struct(current->fs);
+	printk("fs is %u\n", (unsigned)fs);
+	if (fs)
+		put_fs_struct(fs);
+	printk("debug 1\n");
+	spin_unlock(&drive_array_lock);
+	printk("debug 1\n");
+	return 0;
+}
+
+long subst_drive_destroy(int drive)
+{
+	struct fs_struct *fs;
+	int ret = -EINVAL;
+	if (drive=='C' || drive<'A' || drive>'z')
+		return -EINVAL;
+	spin_lock(&drive_array_lock);
+	fs = drive_array[drive];
+	if (fs) {
+		ret = 0;
+		drive_array[drive] = NULL;
+		put_fs_struct(fs);
+	}
+	spin_unlock(&drive_array_lock);
+	return ret;
+}
+
 static inline unsigned long hash(struct vfsmount *mnt, struct dentry *dentry)
 {
 	unsigned long tmp = ((unsigned long) mnt / L1_CACHE_BYTES);
@@ -810,7 +926,7 @@
 	if (!(flags & CLONE_NEWNS))
 		return 0;
 
-	if (!capable(CAP_SYS_ADMIN)) {
+	if (fs->currentdrive != 'C' || !capable(CAP_SYS_ADMIN)) {
 		put_namespace(namespace);
 		return -EPERM;
 	}
diff -Naurd old/fs/proc/array.c new/fs/proc/array.c
--- old/fs/proc/array.c	2004-03-10 21:55:33.000000000 -0500
+++ new/fs/proc/array.c	2004-03-31 14:42:34.000000000 -0500
@@ -171,8 +171,10 @@
 	read_unlock(&tasklist_lock);	
 	task_lock(p);
 	buffer += sprintf(buffer,
+		"Drive:\t%c\n"
 		"FDSize:\t%d\n"
 		"Groups:\t",
+		p->fs->currentdrive,
 		p->files ? p->files->max_fds : 0);
 	task_unlock(p);
 
diff -Naurd old/include/linux/fs_struct.h new/include/linux/fs_struct.h
--- old/include/linux/fs_struct.h	2004-03-10 21:55:36.000000000 -0500
+++ new/include/linux/fs_struct.h	2004-03-31 16:24:27.000000000 -0500
@@ -10,14 +10,26 @@
 	int umask;
 	struct dentry * root, * pwd, * altroot;
 	struct vfsmount * rootmnt, * pwdmnt, * altrootmnt;
+
+	int currentdrive;
+
+	struct dentry * c_root, * c_pwd, * c_altroot;
+	struct vfsmount * c_rootmnt, * c_pwdmnt, * c_altrootmnt;
 };
 
 #define INIT_FS {				\
 	.count		= ATOMIC_INIT(1),	\
 	.lock		= RW_LOCK_UNLOCKED,	\
 	.umask		= 0022, \
+	.currentdrive	= 'C', \
 }
 
+extern struct fs_struct *drive_array[];
+extern void shutdown_drive_array(void);
+extern long set_current_drive(int drive);
+extern long subst_drive_create(int drive);
+extern long subst_drive_destroy(int drive);
+
 extern void exit_fs(struct task_struct *);
 extern void set_fs_altroot(void);
 extern void set_fs_root(struct fs_struct *, struct vfsmount *, struct dentry *);
diff -Naurd old/include/linux/prctl.h new/include/linux/prctl.h
--- old/include/linux/prctl.h	2004-03-10 21:55:28.000000000 -0500
+++ new/include/linux/prctl.h	2004-03-31 16:38:10.000000000 -0500
@@ -43,5 +43,11 @@
 # define PR_TIMING_TIMESTAMP    1       /* Accurate timestamp based
                                                    process timing */
 
+/* drive letter support */
+#define PR_GET_DRIVE 42     /* get the current drive */
+#define PR_SET_DRIVE 69     /* set the current drive */
+#define PR_SUBST_CREATE 666   /* associate a drive letter with something */
+#define PR_SUBST_DESTROY 20040401   /* kill a drive letter */
+
 
 #endif /* _LINUX_PRCTL_H */
diff -Naurd old/kernel/exit.c new/kernel/exit.c
--- old/kernel/exit.c	2004-03-30 18:31:46.000000000 -0500
+++ new/kernel/exit.c	2004-03-31 14:29:58.000000000 -0500
@@ -434,6 +434,16 @@
 			dput(fs->altroot);
 			mntput(fs->altrootmnt);
 		}
+		if (fs->currentdrive != 'C') {
+			dput(fs->c_root);
+			mntput(fs->c_rootmnt);
+			dput(fs->c_pwd);
+			mntput(fs->c_pwdmnt);
+			if (fs->c_altroot) {
+				dput(fs->c_altroot);
+				mntput(fs->c_altrootmnt);
+			}
+		}
 		kmem_cache_free(fs_cachep, fs);
 	}
 }
diff -Naurd old/kernel/fork.c new/kernel/fork.c
--- old/kernel/fork.c	2004-03-10 21:55:22.000000000 -0500
+++ new/kernel/fork.c	2004-03-31 14:35:13.000000000 -0500
@@ -585,7 +585,9 @@
 		atomic_set(&fs->count, 1);
 		fs->lock = RW_LOCK_UNLOCKED;
 		fs->umask = old->umask;
+
 		read_lock(&old->lock);
+
 		fs->rootmnt = mntget(old->rootmnt);
 		fs->root = dget(old->root);
 		fs->pwdmnt = mntget(old->pwdmnt);
@@ -597,6 +599,23 @@
 			fs->altrootmnt = NULL;
 			fs->altroot = NULL;
 		}
+
+		fs->currentdrive = old->currentdrive;
+
+		if (old->currentdrive != 'C') {
+			fs->c_rootmnt = mntget(old->c_rootmnt);
+			fs->c_root = dget(old->c_root);
+			fs->c_pwdmnt = mntget(old->c_pwdmnt);
+			fs->c_pwd = dget(old->c_pwd);
+			if (old->c_altroot) {
+				fs->c_altrootmnt = mntget(old->c_altrootmnt);
+				fs->c_altroot = dget(old->c_altroot);
+			} else {
+				fs->c_altrootmnt = NULL;
+				fs->c_altroot = NULL;
+			}
+		}
+
 		read_unlock(&old->lock);
 	}
 	return fs;
diff -Naurd old/kernel/sys.c new/kernel/sys.c
--- old/kernel/sys.c	2004-03-10 21:55:22.000000000 -0500
+++ new/kernel/sys.c	2004-03-31 17:20:39.000000000 -0500
@@ -1631,6 +1631,24 @@
 			}
 			current->keep_capabilities = arg2;
 			break;
+
+		case PR_GET_DRIVE:
+			error = current->fs->currentdrive;
+			break;
+		case PR_SET_DRIVE:
+			error = set_current_drive(arg2);
+			break;
+		case PR_SUBST_CREATE:
+			if (!capable(CAP_SYS_ADMIN))
+				return -EPERM;
+			error = subst_drive_create(arg2);
+			break;
+		case PR_SUBST_DESTROY:
+			if (!capable(CAP_SYS_ADMIN))
+				return -EPERM;
+			error = subst_drive_destroy(arg2);
+			break;
+
 		default:
 			error = -EINVAL;
 			break;




