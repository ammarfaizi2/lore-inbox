Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269390AbRHQIPf>; Fri, 17 Aug 2001 04:15:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269274AbRHQIP1>; Fri, 17 Aug 2001 04:15:27 -0400
Received: from elin.scali.no ([195.139.250.10]:31241 "EHLO elin.scali.no")
	by vger.kernel.org with ESMTP id <S269390AbRHQIPT>;
	Fri, 17 Aug 2001 04:15:19 -0400
Subject: Re: [PATCH] processes with shared vm
From: Terje Eggestad <terje.eggestad@scali.no>
To: Robert Love <rml@tech9.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <998035750.1013.15.camel@phantasy>
In-Reply-To: <997973469.7632.10.camel@pc-16> 
	<998035017.663.13.camel@phantasy> 
	<998035444.7627.4.camel@pc-16.office.scali.no> 
	<998035750.1013.15.camel@phantasy>
Content-Type: multipart/mixed; boundary="=-L6iLOYILsDzljNLIi035"
X-Mailer: Evolution/0.12 (Preview Release)
Date: 17 Aug 2001 10:15:30 +0200
Message-Id: <998036130.7627.12.camel@pc-16.office.scali.no>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-L6iLOYILsDzljNLIi035
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Man......

Is there any other way I can do this wrong!?!?, guess I need to write
more patches :-)

--- array.c.orig	Mon Mar 19 21:34:55 2001
+++ array.c	Thu Aug 16 16:33:56 2001
@@ -50,6 +50,12 @@
  * Al Viro & Jeff Garzik :  moved most of the thing into base.c and
  *			 :  proc_misc.c. The rest may eventually go into
  *			 :  base.c too.
+ *
+ * Terje Eggestad    :  added in /proc/<pid>/status a VmClones: n
+ *                   :  that tells how many proc that uses the same VM (mm_struct).
+ *                   :  if there are clones add another field VmFirstClone with the
+ *                   :  clone with the lowest pid. Needed for things like gtop that adds 
+ *                   :  mem usage of groups of proc, or else they add up the usage of threads.
  */
 
 #include <linux/config.h>
@@ -178,7 +184,7 @@
 static inline char * task_mem(struct mm_struct *mm, char *buffer)
 {
 	struct vm_area_struct * vma;
-	unsigned long data = 0, stack = 0;
+ 	unsigned long data = 0, stack = 0;
 	unsigned long exec = 0, lib = 0;
 
 	down_read(&mm->mmap_sem);
@@ -206,12 +212,24 @@
 		"VmData:\t%8lu kB\n"
 		"VmStk:\t%8lu kB\n"
 		"VmExe:\t%8lu kB\n"
-		"VmLib:\t%8lu kB\n",
+		"VmLib:\t%8lu kB\n"
+		"VmClones:\t%d\n",
 		mm->total_vm << (PAGE_SHIFT-10),
 		mm->locked_vm << (PAGE_SHIFT-10),
 		mm->rss << (PAGE_SHIFT-10),
 		data - stack, stack,
-		exec - lib, lib);
+		exec - lib, lib, 
+		mm->mm_users.counter-2);
+	/* if we've vm clones, find the lowest/first pid of the clones */	
+	if (mm->mm_users.counter > 2) {
+	  struct task_struct *p;
+	  read_lock(&tasklist_lock);
+	  for_each_task(p) {
+	    if (p->mm == mm) break;
+	  };
+	  buffer += sprintf(buffer, "VmFirstClone:\t%d\n", p->pid);
+	  read_unlock(&tasklist_lock);
+	};
 	up_read(&mm->mmap_sem);
 	return buffer;
 }
Den 17 Aug 2001 04:08:53 -0400, skrev Robert Love:
> On 17 Aug 2001 10:04:04 +0200, Terje Eggestad wrote:
> > OK
> 
> the patch is backwards :) i think your original one was too
> 
> diff -u <old> <new>
> 
> -- 
> Robert M. Love
> rml at ufl.edu
> rml at tech9.net
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
_________________________________________________________________________

Terje Eggestad                  terje.eggestad@scali.no
Scali Scalable Linux Systems    http://www.scali.com

Olaf Helsets Vei 6              tel:    +47 22 62 89 61 (OFFICE)
P.O.Box 70 Bogerud                      +47 975 31 574  (MOBILE)
N-0621 Oslo                     fax:    +47 22 62 89 51
NORWAY            
_________________________________________________________________________

--=-L6iLOYILsDzljNLIi035
Content-Type: text/plain
Content-Disposition: attachment; filename=vmclone.patch
Content-ID: <998036033.7609.9.camel@pc-16.office.scali.no>
Content-Transfer-Encoding: 7bit

--- array.c.orig	Mon Mar 19 21:34:55 2001
+++ array.c	Thu Aug 16 16:33:56 2001
@@ -50,6 +50,12 @@
  * Al Viro & Jeff Garzik :  moved most of the thing into base.c and
  *			 :  proc_misc.c. The rest may eventually go into
  *			 :  base.c too.
+ *
+ * Terje Eggestad    :  added in /proc/<pid>/status a VmClones: n
+ *                   :  that tells how many proc that uses the same VM (mm_struct).
+ *                   :  if there are clones add another field VmFirstClone with the
+ *                   :  clone with the lowest pid. Needed for things like gtop that adds 
+ *                   :  mem usage of groups of proc, or else they add up the usage of threads.
  */
 
 #include <linux/config.h>
@@ -178,7 +184,7 @@
 static inline char * task_mem(struct mm_struct *mm, char *buffer)
 {
 	struct vm_area_struct * vma;
-	unsigned long data = 0, stack = 0;
+ 	unsigned long data = 0, stack = 0;
 	unsigned long exec = 0, lib = 0;
 
 	down_read(&mm->mmap_sem);
@@ -206,12 +212,24 @@
 		"VmData:\t%8lu kB\n"
 		"VmStk:\t%8lu kB\n"
 		"VmExe:\t%8lu kB\n"
-		"VmLib:\t%8lu kB\n",
+		"VmLib:\t%8lu kB\n"
+		"VmClones:\t%d\n",
 		mm->total_vm << (PAGE_SHIFT-10),
 		mm->locked_vm << (PAGE_SHIFT-10),
 		mm->rss << (PAGE_SHIFT-10),
 		data - stack, stack,
-		exec - lib, lib);
+		exec - lib, lib, 
+		mm->mm_users.counter-2);
+	/* if we've vm clones, find the lowest/first pid of the clones */	
+	if (mm->mm_users.counter > 2) {
+	  struct task_struct *p;
+	  read_lock(&tasklist_lock);
+	  for_each_task(p) {
+	    if (p->mm == mm) break;
+	  };
+	  buffer += sprintf(buffer, "VmFirstClone:\t%d\n", p->pid);
+	  read_unlock(&tasklist_lock);
+	};
 	up_read(&mm->mmap_sem);
 	return buffer;
 }

--=-L6iLOYILsDzljNLIi035--

