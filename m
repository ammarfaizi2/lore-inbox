Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269897AbRHQIEO>; Fri, 17 Aug 2001 04:04:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269981AbRHQIEH>; Fri, 17 Aug 2001 04:04:07 -0400
Received: from elin.scali.no ([195.139.250.10]:24841 "EHLO elin.scali.no")
	by vger.kernel.org with ESMTP id <S269897AbRHQIDx>;
	Fri, 17 Aug 2001 04:03:53 -0400
Subject: Re: [PATCH] processes with shared vm
From: Terje Eggestad <terje.eggestad@scali.no>
To: Robert Love <rml@tech9.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <998035017.663.13.camel@phantasy>
In-Reply-To: <997973469.7632.10.camel@pc-16> 
	<998035017.663.13.camel@phantasy>
Content-Type: multipart/mixed; boundary="=-w/TTAizVxO3h75/IP+xY"
X-Mailer: Evolution/0.12 (Preview Release)
Date: 17 Aug 2001 10:04:04 +0200
Message-Id: <998035444.7627.4.camel@pc-16.office.scali.no>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-w/TTAizVxO3h75/IP+xY
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

OK

Den 17 Aug 2001 03:56:49 -0400, skrev Robert Love:
> On 17 Aug 2001 09:50:06 +0200, Terje Eggestad wrote:
> > I figured out that it's difficult to find out from /proc
> > which processes that share VM (created with clone(CLONE_VM)). 
> 
> good idea, but use diff -u
> 
> -- 
> Robert M. Love
> rml at ufl.edu
> rml at tech9.net


--- array.c     Thu Aug 16 16:33:56 2001
+++ array.c.orig        Mon Mar 19 21:34:55 2001
@@ -50,12 +50,6 @@
  * Al Viro & Jeff Garzik :  moved most of the thing into base.c and
  *                      :  proc_misc.c. The rest may eventually go into
  *                      :  base.c too.
- *
- * Terje Eggestad    :  added in /proc/<pid>/status a VmClones: n
- *                   :  that tells how many proc that uses the same VM
(mm_struct).
- *                   :  if there are clones add another field
VmFirstClone with the
- *                   :  clone with the lowest pid. Needed for things
like gtop that adds 
- *                   :  mem usage of groups of proc, or else they add
up the usage of threads.
  */
 
 #include <linux/config.h>
@@ -184,7 +178,7 @@
 static inline char * task_mem(struct mm_struct *mm, char *buffer)
 {
        struct vm_area_struct * vma;
-       unsigned long data = 0, stack = 0;
+       unsigned long data = 0, stack = 0;
        unsigned long exec = 0, lib = 0;
 
        down_read(&mm->mmap_sem);
@@ -212,24 +206,12 @@
                "VmData:\t%8lu kB\n"
                "VmStk:\t%8lu kB\n"
                "VmExe:\t%8lu kB\n"
-               "VmLib:\t%8lu kB\n"
-               "VmClones:\t%d\n",
+               "VmLib:\t%8lu kB\n",
                mm->total_vm << (PAGE_SHIFT-10),
                mm->locked_vm << (PAGE_SHIFT-10),
                mm->rss << (PAGE_SHIFT-10),
                data - stack, stack,
-               exec - lib, lib, 
-               mm->mm_users.counter-2);
-       /* if we've vm clones, find the lowest/first pid of the clones
*/
-       if (mm->mm_users.counter > 2) {
-         struct task_struct *p;
-         read_lock(&tasklist_lock);
-         for_each_task(p) {
-           if (p->mm == mm) break;
-         };
-         buffer += sprintf(buffer, "VmFirstClone:\t%d\n", p->pid);
-         read_unlock(&tasklist_lock);
-       };
+               exec - lib, lib);
        up_read(&mm->mmap_sem);
        return buffer;
 }


-- 
_________________________________________________________________________

Terje Eggestad                  terje.eggestad@scali.no
Scali Scalable Linux Systems    http://www.scali.com

Olaf Helsets Vei 6              tel:    +47 22 62 89 61 (OFFICE)
P.O.Box 70 Bogerud                      +47 975 31 574  (MOBILE)
N-0621 Oslo                     fax:    +47 22 62 89 51
NORWAY            
_________________________________________________________________________

--=-w/TTAizVxO3h75/IP+xY
Content-Type: text/plain
Content-Disposition: attachment; filename=vmclone.patch
Content-ID: <998035339.7609.1.camel@pc-16.office.scali.no>
Content-Transfer-Encoding: 7bit

--- array.c	Thu Aug 16 16:33:56 2001
+++ array.c.orig	Mon Mar 19 21:34:55 2001
@@ -50,12 +50,6 @@
  * Al Viro & Jeff Garzik :  moved most of the thing into base.c and
  *			 :  proc_misc.c. The rest may eventually go into
  *			 :  base.c too.
- *
- * Terje Eggestad    :  added in /proc/<pid>/status a VmClones: n
- *                   :  that tells how many proc that uses the same VM (mm_struct).
- *                   :  if there are clones add another field VmFirstClone with the
- *                   :  clone with the lowest pid. Needed for things like gtop that adds 
- *                   :  mem usage of groups of proc, or else they add up the usage of threads.
  */
 
 #include <linux/config.h>
@@ -184,7 +178,7 @@
 static inline char * task_mem(struct mm_struct *mm, char *buffer)
 {
 	struct vm_area_struct * vma;
- 	unsigned long data = 0, stack = 0;
+	unsigned long data = 0, stack = 0;
 	unsigned long exec = 0, lib = 0;
 
 	down_read(&mm->mmap_sem);
@@ -212,24 +206,12 @@
 		"VmData:\t%8lu kB\n"
 		"VmStk:\t%8lu kB\n"
 		"VmExe:\t%8lu kB\n"
-		"VmLib:\t%8lu kB\n"
-		"VmClones:\t%d\n",
+		"VmLib:\t%8lu kB\n",
 		mm->total_vm << (PAGE_SHIFT-10),
 		mm->locked_vm << (PAGE_SHIFT-10),
 		mm->rss << (PAGE_SHIFT-10),
 		data - stack, stack,
-		exec - lib, lib, 
-		mm->mm_users.counter-2);
-	/* if we've vm clones, find the lowest/first pid of the clones */	
-	if (mm->mm_users.counter > 2) {
-	  struct task_struct *p;
-	  read_lock(&tasklist_lock);
-	  for_each_task(p) {
-	    if (p->mm == mm) break;
-	  };
-	  buffer += sprintf(buffer, "VmFirstClone:\t%d\n", p->pid);
-	  read_unlock(&tasklist_lock);
-	};
+		exec - lib, lib);
 	up_read(&mm->mmap_sem);
 	return buffer;
 }

--=-w/TTAizVxO3h75/IP+xY--

