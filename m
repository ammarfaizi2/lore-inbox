Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269149AbUIYA1Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269149AbUIYA1Z (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 20:27:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269151AbUIYA1V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 20:27:21 -0400
Received: from fw.osdl.org ([65.172.181.6]:5600 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269149AbUIYA0U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 20:26:20 -0400
Date: Fri, 24 Sep 2004 17:26:11 -0700
From: Chris Wright <chrisw@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org
Subject: Re: mlock(1)
Message-ID: <20040924172611.Y1973@build.pdx.osdl.net>
References: <41547C16.4070301@pobox.com> <20040924141731.7ced31f7.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="/04w6evG8XlLl3ft"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20040924141731.7ced31f7.akpm@osdl.org>; from akpm@osdl.org on Fri, Sep 24, 2004 at 02:17:31PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Andrew Morton (akpm@osdl.org) wrote:
> Jeff Garzik <jgarzik@pobox.com> wrote:
> >
> > How feasible is it to create an mlock(1) utility, that would allow 
> >  priveleged users to execute a daemon such that none of the memory the 
> >  daemon allocates will ever be swapped out?
> 
> It used to be the case that mlockall(MCL_FUTURE) was inherited across fork,
> which would do what you want.
> 
> But that was a bug and we fixed it a couple of years back, sadly.
> 
> I guess we could add a new mlockall mode which _is_ inherited across fork.

Here's a simple (bit ugly) hack that does it (esp. the exec part).
Seems to miss one page, probably from the arguments or so.  Not sure if
it's worth pursuing, but here it is ;-)

$ ./mlock /bin/cat /proc/self/status | grep Vm
VmSize:     3436 kB
VmLck:      3432 kB
VmRSS:      3436 kB
VmData:      144 kB
VmStk:         8 kB
VmExe:        13 kB
VmLib:      1195 kB

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net

===== fs/binfmt_elf.c 1.88 vs edited =====
--- 1.88/fs/binfmt_elf.c	2004-09-22 13:34:05 -07:00
+++ edited/fs/binfmt_elf.c	2004-09-24 17:15:53 -07:00
@@ -83,6 +83,9 @@
 
 #define BAD_ADDR(x)	((unsigned long)(x) > TASK_SIZE)
 
+#define MCL_FOREVER	4
+#define PF_MEMLOCK	0x00400000
+
 static int set_brk(unsigned long start, unsigned long end)
 {
 	start = ELF_PAGEALIGN(start);
@@ -704,7 +707,7 @@
 	current->mm->end_code = 0;
 	current->mm->mmap = NULL;
 	current->flags &= ~PF_FORKNOEXEC;
-	current->mm->def_flags = def_flags;
+	current->mm->def_flags = (current->flags & PF_MEMLOCK) ? VM_LOCKED : 0;
 
 	/* Do this immediately, since STACK_TOP as used in setup_arg_pages
 	   may depend on the personality.  */
===== mm/mlock.c 1.9 vs edited =====
--- 1.9/mm/mlock.c	2004-08-23 01:15:25 -07:00
+++ edited/mm/mlock.c	2004-09-24 16:07:16 -07:00
@@ -8,6 +8,8 @@
 #include <linux/mman.h>
 #include <linux/mm.h>
 
+#define MCL_FOREVER	4
+#define PF_MEMLOCK	0x00400000
 
 static int mlock_fixup(struct vm_area_struct * vma, 
 	unsigned long start, unsigned long end, unsigned int newflags)
@@ -150,6 +152,9 @@
 		def_flags = VM_LOCKED;
 	current->mm->def_flags = def_flags;
 
+	if (flags & MCL_FOREVER)
+		current->flags |= PF_MEMLOCK;
+
 	error = 0;
 	for (vma = current->mm->mmap; vma ; vma = vma->vm_next) {
 		unsigned int newflags;
@@ -170,7 +175,7 @@
 	int ret = -EINVAL;
 
 	down_write(&current->mm->mmap_sem);
-	if (!flags || (flags & ~(MCL_CURRENT | MCL_FUTURE)))
+	if (!flags || (flags & ~(MCL_CURRENT | MCL_FUTURE | MCL_FOREVER)))
 		goto out;
 
 	lock_limit = current->rlim[RLIMIT_MEMLOCK].rlim_cur;

--/04w6evG8XlLl3ft
Content-Type: text/x-c++src; charset=us-ascii
Content-Disposition: attachment; filename="mlock.c"

#include <unistd.h>
#include <stdio.h>
#include <sys/mman.h>

#define MCL_FOREVER 	4

int main(int argc, char *argv[], char *envp[])
{
	int rc;
	int c, do_fork = 0;

	while ((c = getopt(argc, argv, "f")) != -1) {
		switch(c) {
		case 'f':
			do_fork = 1;
			break;
		default:
			printf("usage:\t%s [-f] program_to_exec\n", argv[0]);
		}
	}
	argv += optind;

	rc = mlockall(MCL_FUTURE|MCL_FOREVER);
	if (rc == -1)
		perror("mlockall");

	if (do_fork) {
		int pid = fork();
		if (pid > 0)
			exit(0);
		else if (pid < 0) {
			perror("fork");
			exit(1);
		}
	}
	execve(argv[0], argv, envp);
	perror("execve");
	exit(1);
}

--/04w6evG8XlLl3ft--
