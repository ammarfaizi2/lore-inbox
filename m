Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317240AbSFCBB0>; Sun, 2 Jun 2002 21:01:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317241AbSFCBBZ>; Sun, 2 Jun 2002 21:01:25 -0400
Received: from ausmtp01.au.ibm.COM ([202.135.136.97]:20893 "EHLO
	ausmtp01.au.ibm.com") by vger.kernel.org with ESMTP
	id <S317240AbSFCBBX>; Sun, 2 Jun 2002 21:01:23 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] AUDIT 2.5.19: Continuing copy_to/from_user & clear_user
Date: Sun, 02 Jun 2002 13:48:19 +1000
Message-Id: <E17EMLr-0000XH-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus' "more powerful interface" continues to bite.

But I'm sure the authors of those non-existent programs which
deliberately read into unmapped regions are grateful.

I *think* this is all of them,
Rusty.

diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.19/arch/ppc/kernel/syscalls.c working-2.5.19-copyuser/arch/ppc/kernel/syscalls.c
--- linux-2.5.19/arch/ppc/kernel/syscalls.c	Sat Nov  3 12:43:54 2001
+++ working-2.5.19-copyuser/arch/ppc/kernel/syscalls.c	Sun Jun  2 12:05:36 2002
@@ -117,7 +117,7 @@
 			if ((ret = verify_area (VERIFY_READ, ptr, sizeof(tmp)))
 			    || (ret = copy_from_user(&tmp,
 						(struct ipc_kludge *) ptr,
-						sizeof (tmp))))
+						sizeof (tmp)) ? -EFAULT : 0)
 				break;
 			ret = sys_msgrcv (first, tmp.msgp, second, tmp.msgtyp,
 					  third);
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.19/arch/s390/kernel/debug.c working-2.5.19-copyuser/arch/s390/kernel/debug.c
--- linux-2.5.19/arch/s390/kernel/debug.c	Sat May 25 14:34:39 2002
+++ working-2.5.19-copyuser/arch/s390/kernel/debug.c	Sun Jun  2 12:43:26 2002
@@ -424,7 +424,6 @@
 {
 	size_t count = 0;
 	size_t entry_offset, size = 0;
-	int rc;
 	file_private_info_t *p_info;
 
 	p_info = ((file_private_info_t *) file->private_data);
@@ -440,9 +439,9 @@
 		size = MIN((len - count), (size - entry_offset));
 
 		if(size){
-			if ((rc = copy_to_user(user_buf + count, 
-					p_info->temp_buf + entry_offset, size)))
-			return rc;
+			if (copy_to_user(user_buf + count, 
+					p_info->temp_buf + entry_offset, size))
+			return -EFAULT;
 		}
 		count += size;
 		entry_offset = 0;
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.19/arch/s390/kernel/ptrace.c working-2.5.19-copyuser/arch/s390/kernel/ptrace.c
--- linux-2.5.19/arch/s390/kernel/ptrace.c	Wed Sep 19 09:58:03 2001
+++ working-2.5.19-copyuser/arch/s390/kernel/ptrace.c	Sun Jun  2 12:11:16 2002
@@ -116,14 +116,14 @@
 	{
 		if(writeuser)
 		{
-			retval=copy_from_user((void *)realuseraddr,(void *)copyaddr,len);
+			retval=copy_from_user((void *)realuseraddr,(void *)copyaddr,len) ? -EFAULT : 0;
 		}
 		else
 		{
 			if(realuseraddr==(addr_t)NULL)
-				retval=(clear_user((void *)copyaddr,len)==-EFAULT ? -EIO:0);
+				retval=(clear_user((void *)copyaddr,len) ? -EIO:0);
 			else
-				retval=(copy_to_user((void *)copyaddr,(void *)realuseraddr,len)==-EFAULT ? -EIO:0);
+				retval=(copy_to_user((void *)copyaddr,(void *)realuseraddr,len) ? -EIO:0);
 		}      
 	}
 	else
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.19/arch/s390/kernel/signal.c working-2.5.19-copyuser/arch/s390/kernel/signal.c
--- linux-2.5.19/arch/s390/kernel/signal.c	Thu May 30 10:00:49 2002
+++ working-2.5.19-copyuser/arch/s390/kernel/signal.c	Sun Jun  2 12:49:43 2002
@@ -141,7 +141,7 @@
 
 
 
-
+/* Returns non-zero on fault. */
 static int save_sigregs(struct pt_regs *regs,_sigregs *sregs)
 {
 	int err;
@@ -157,6 +157,7 @@
 	
 }
 
+/* Returns positive number on error */
 static int restore_sigregs(struct pt_regs *regs,_sigregs *sregs)
 {
 	int err;
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.19/arch/s390/math-emu/math.c working-2.5.19-copyuser/arch/s390/math-emu/math.c
--- linux-2.5.19/arch/s390/math-emu/math.c	Fri Oct 12 02:04:57 2001
+++ working-2.5.19-copyuser/arch/s390/math-emu/math.c	Sun Jun  2 12:42:49 2002
@@ -86,13 +86,13 @@
 
 #define mathemu_copy_from_user(d, s, n)\
         do { \
-                if (copy_from_user((d),(s),(n)) == -EFAULT) \
+                if (copy_from_user((d),(s),(n)) != 0) \
                         return SIGSEGV; \
         } while (0)
 
 #define mathemu_copy_to_user(d, s, n) \
         do { \
-                if (copy_to_user((d),(s),(n)) == -EFAULT) \
+                if (copy_to_user((d),(s),(n)) != 0) \
                         return SIGSEGV; \
         } while (0)
 
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.19/arch/s390x/kernel/debug.c working-2.5.19-copyuser/arch/s390x/kernel/debug.c
--- linux-2.5.19/arch/s390x/kernel/debug.c	Sat May 25 14:34:39 2002
+++ working-2.5.19-copyuser/arch/s390x/kernel/debug.c	Sun Jun  2 12:43:40 2002
@@ -427,7 +427,6 @@
 {
 	size_t count = 0;
 	size_t entry_offset, size = 0;
-	int rc;
 	file_private_info_t *p_info;
 
 	p_info = ((file_private_info_t *) file->private_data);
@@ -443,9 +442,9 @@
 		size = MIN((len - count), (size - entry_offset));
 
 		if(size){
-			if ((rc = copy_to_user(user_buf + count, 
-					p_info->temp_buf + entry_offset, size)))
-			return rc;
+			if (copy_to_user(user_buf + count, 
+					p_info->temp_buf + entry_offset, size))
+			return -EFAULT;
 		}
 		count += size;
 		entry_offset = 0;
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.19/arch/s390x/kernel/ptrace.c working-2.5.19-copyuser/arch/s390x/kernel/ptrace.c
--- linux-2.5.19/arch/s390x/kernel/ptrace.c	Wed Sep 19 09:56:19 2001
+++ working-2.5.19-copyuser/arch/s390x/kernel/ptrace.c	Sun Jun  2 12:44:17 2002
@@ -122,7 +122,7 @@
 				retval = clear_user(copyptr, len);
 			else
 				retval = copy_to_user(copyptr,realuserptr,len);
-                        retval = (retval == -EFAULT) ? -EIO : 0;
+                        retval = retval ? -EIO : 0;
 		}      
 	} else {
 		if (writeuser)
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.19/arch/s390x/kernel/signal.c working-2.5.19-copyuser/arch/s390x/kernel/signal.c
--- linux-2.5.19/arch/s390x/kernel/signal.c	Thu May 30 10:00:49 2002
+++ working-2.5.19-copyuser/arch/s390x/kernel/signal.c	Sun Jun  2 12:50:02 2002
@@ -141,7 +141,7 @@
 
 
 
-
+/* Returns non-zero on fault */
 static int save_sigregs(struct pt_regs *regs,_sigregs *sregs)
 {
 	int err;
@@ -157,6 +157,7 @@
 	
 }
 
+/* Returns positive number on error */
 static int restore_sigregs(struct pt_regs *regs,_sigregs *sregs)
 {
 	int err;
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.19/arch/sparc/kernel/sys_sunos.c working-2.5.19-copyuser/arch/sparc/kernel/sys_sunos.c
--- linux-2.5.19/arch/sparc/kernel/sys_sunos.c	Sun May 19 12:07:29 2002
+++ working-2.5.19-copyuser/arch/sparc/kernel/sys_sunos.c	Sun Jun  2 12:39:30 2002
@@ -487,7 +487,7 @@
 		ret |= __copy_to_user(&name->mach[0], &system_utsname.machine[0], sizeof(name->mach) - 1);
 	}
 	up_read(&uts_sem);
-	return ret;
+	return ret ? -EFAULT : 0;
 }
 
 asmlinkage int sunos_nosys(void)
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.19/arch/sparc64/kernel/sys_sparc.c working-2.5.19-copyuser/arch/sparc64/kernel/sys_sparc.c
--- linux-2.5.19/arch/sparc64/kernel/sys_sparc.c	Mon Apr 15 11:47:16 2002
+++ working-2.5.19-copyuser/arch/sparc64/kernel/sys_sparc.c	Sun Jun  2 12:41:07 2002
@@ -252,7 +252,7 @@
 	int ret = sys_newuname(name);
 	
 	if (current->personality == PER_LINUX32 && !ret) {
-		ret = copy_to_user(name->machine, "sparc\0\0", 8);
+		ret = copy_to_user(name->machine, "sparc\0\0", 8) ? -EFAULT : 0;
 	}
 	return ret;
 }
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.19/drivers/char/rio/rioctrl.c working-2.5.19-copyuser/drivers/char/rio/rioctrl.c
--- linux-2.5.19/drivers/char/rio/rioctrl.c	Sat May 25 14:34:43 2002
+++ working-2.5.19-copyuser/drivers/char/rio/rioctrl.c	Sat Jun  1 23:36:33 2002
@@ -139,7 +139,7 @@
 
   rio_dprintk (RIO_DEBUG_CTRL, "Copying %d bytes from user %p to %p.\n", siz, (void *)arg, dp);
   rv = copy_from_user (dp, (void *)arg, siz);
-  if (rv < 0) return COPYFAIL;
+  if (rv) return COPYFAIL;
   else return rv;
 }
 
@@ -150,7 +150,7 @@
 
   rio_dprintk (RIO_DEBUG_CTRL, "Copying %d bytes to user %p from %p.\n", siz, (void *)arg, dp);
   rv = copy_to_user ((void *)arg, dp, siz);
-  if (rv < 0) return COPYFAIL;
+  if (rv) return COPYFAIL;
   else return rv;
 }
 
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.19/drivers/ieee1394/pcilynx.c working-2.5.19-copyuser/drivers/ieee1394/pcilynx.c
--- linux-2.5.19/drivers/ieee1394/pcilynx.c	Mon Apr 15 11:47:21 2002
+++ working-2.5.19-copyuser/drivers/ieee1394/pcilynx.c	Sun Jun  2 12:37:45 2002
@@ -880,7 +880,7 @@
         retval = copy_to_user(buffer, md->lynx->mem_dma_buffer, count);
         up(&md->lynx->mem_dma_mutex);
 
-        if (retval < 0) return retval;
+        if (retval) return -EFAULT;
         *offset += count;
         return count;
 }
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.19/drivers/s390/misc/chandev.c working-2.5.19-copyuser/drivers/s390/misc/chandev.c
--- linux-2.5.19/drivers/s390/misc/chandev.c	Fri Mar  8 14:49:21 2002
+++ working-2.5.19-copyuser/drivers/s390/misc/chandev.c	Sat Jun  1 23:41:19 2002
@@ -3151,7 +3151,7 @@
 	buff=vmalloc(count+1);
 	if(buff)
 	{
-		rc = copy_from_user(buff,buffer,count);
+		rc = copy_from_user(buff,buffer,count) ? -EFAULT : 0;
 		if (rc)
 			goto chandev_write_exit;
 		chandev_do_setup(FALSE,buff,count);
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.19/drivers/sbus/char/openprom.c working-2.5.19-copyuser/drivers/sbus/char/openprom.c
--- linux-2.5.19/drivers/sbus/char/openprom.c	Sat May 25 14:34:48 2002
+++ working-2.5.19-copyuser/drivers/sbus/char/openprom.c	Sun Jun  2 12:35:12 2002
@@ -408,9 +408,9 @@
 
 		tmp[len] = '\0';
 
-		error = __copy_to_user((void *)arg, &op, sizeof(op));
-		if (!error)
-			error = copy_to_user(op.op_buf, tmp, len);
+		if (__copy_to_user((void *)arg, &op, sizeof(op)) != 0
+		    || copy_to_user(op.op_buf, tmp, len) != 0)
+			error = -EFAULT;
 
 		kfree(tmp);
 		kfree(str);
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.19/sound/isa/sb/sb16_csp.c working-2.5.19-copyuser/sound/isa/sb/sb16_csp.c
--- linux-2.5.19/sound/isa/sb/sb16_csp.c	Wed Feb 20 17:57:23 2002
+++ working-2.5.19-copyuser/sound/isa/sb/sb16_csp.c	Sun Jun  2 12:46:27 2002
@@ -215,7 +215,7 @@
 		info.run_width = p->run_width;
 		info.version = p->version;
 		info.state = p->running;
-		err = copy_to_user((void *) arg, &info, sizeof(info));
+		err = copy_to_user((void *) arg, &info, sizeof(info)) ? -EFAULT : 0;
 		break;
 
 		/* load CSP microcode */

--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
