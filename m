Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268251AbUIWS45@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268251AbUIWS45 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 14:56:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268293AbUIWS45
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 14:56:57 -0400
Received: from ms-smtp-04.texas.rr.com ([24.93.47.43]:8172 "EHLO
	ms-smtp-04.texas.rr.com") by vger.kernel.org with ESMTP
	id S268251AbUIWS4r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 14:56:47 -0400
Date: Thu, 23 Sep 2004 13:56:40 -0500 (CDT)
From: Ray Bryant <raybry@austin.com>
To: Andi Kleen <ak@suse.de>
Cc: Ray Bryant <raybry@austin.com>, William Lee Irwin III <wli@holomorphy.com>,
       Andrew Morton <akpm@osdl.org>, linux-mm <linux-mm@kvack.org>,
       Ray Bryant <raybry@austin.rr.com>, Jesse Barnes <jbarnes@sgi.com>,
       Dan Higgins <djh@sgi.com>, Dave Hansen <haveblue@us.ibm.com>,
       lse-tech <lse-tech@lists.sourceforge.net>,
       Brent Casavant <bcasavan@sgi.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Ray Bryant <raybry@sgi.com>, Paul Jackson <pj@sgi.com>,
       Nick Piggin <piggin@cyberone.com.au>
Message-Id: <20040923185654.2667.61429.84128@raybryhome.rayhome.net>
Subject: [PATCH 1/2] mm: page cache mempolicy for page cache allocation
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleene <ak@suse.de> wrote:

>Overall when I look at all the complications you add for the per process
>page policy which doesn't even have a demonstrated need I'm not sure
>it is really worth it.

Andi,

I guess the only argument I can make is that if I special case the page
cache allocation policy to not have a per process component, I'm either
going to have to create a separate set of stuff to get/set/use it, or I am
going to have to gunk up the existing code with logic like the following:

struct page *
alloc_pages_by_policy(unsigned gfp, unsigned order, unsigned policy)
{
	struct mempolicy *pol;
 
	if (policy >= NR_MEM_POLICIES)
		BUG();
+	if (policy == 0)
+ 		pol = current->mempolicy;
	if (!pol)
		pol = default_policy[policy];
	. . .

All in all, >>I<< think it is a wash either way, but given that I
can't point at an application that uses this requirement, I can't make
a strong argument.  I would observe again that a file server process
on a big HPC machine would likely want to have a different page cache
allocation policy than the HPC applications, but you could get the same
effect by creating a single node cpuset to hold the file server process.

(If we do find such an application, it is going to result in an API
change, assuming we don't support a per process page cache replacement
policy at the present time.)

(Also, what are we going to do if some OTHER policy class comes along
that does have a justifiable need for a per process override? To keep
all of this straight is going to be a mess.)

Just for comparison, I did a patch that removes the per process page
cache policy and annotated it with the changes.  (This patch is on
top of the previous 2 patches I sent.)  This patch can be found below.
Removing support for the per process page cache policy results in a net
change of one line (total) less code; it results in 8 changed lines, most
of these are such things as removing the subscript on current->mempolicy.

Given the above, if you still prefer no per process page cache allocation
policy, I'll merge this patch into the page cache policy patch and send
it out.

(I'm also asking around to see if I can find a suitable justification
for this general per process mempolicy stuff.)

I'll hold off sending out a new version of the patch that includes your
other suggestions until I hear back on this.

======================================================================
Index: linux-2.6.9-rc2-mm1/mm/mempolicy.c
===================================================================
--- linux-2.6.9-rc2-mm1.orig/mm/mempolicy.c	2004-09-23 10:52:34.000000000 -0700
+++ linux-2.6.9-rc2-mm1/mm/mempolicy.c	2004-09-23 11:03:33.000000000 -0700
@@ -418,6 +417,8 @@ asmlinkage long sys_set_mempolicy(int re
 
 	if ((mode > MPOL_MAX) || (policy >= NR_MEM_POLICIES))
 		return -EINVAL;
+	if (!request_policy_default && (policy > 0))            /* process add 2 */
+		return -EINVAL;
 	if (request_policy_default && !capable(CAP_SYS_ADMIN))
 		return -EPERM;
 	err = get_nodes(nodes, nmask, maxnode, mode);
@@ -430,8 +431,8 @@ asmlinkage long sys_set_mempolicy(int re
 		mpol_free(default_policy[policy]);
 		default_policy[policy] = new;
 	} else {
-		mpol_free(current->mempolicy[policy]);
-		current->mempolicy[policy] = new;
+		mpol_free(current->mempolicy);			/* process change 2 */
+		current->mempolicy = new;
 	}
 	if (new && new->policy == MPOL_INTERLEAVE)
 		current->il_next = current->pid % MAX_NUMNODES;
@@ -521,9 +522,7 @@ asmlinkage long sys_get_mempolicy(int __
 		goto copy_policy_to_user;
 	}
 	if (policy_type>0) {
-		pol = current->mempolicy[policy_type];
-		if (!pol)
-			pol = default_policy[policy_type];
+		pol = default_policy[policy_type];		/* process del 2 */
 		goto copy_policy_to_user;
 	}
 
@@ -550,7 +549,7 @@ asmlinkage long sys_get_mempolicy(int __
 			if (err < 0)
 				goto out;
 			pval = err;
-		} else if (pol == current->mempolicy[policy_type] &&
+		} else if (pol == current->mempolicy &&		/* process change 1 */
 				pol->policy == MPOL_INTERLEAVE) {
 			pval = current->il_next;
 		} else {
@@ -662,7 +661,7 @@ asmlinkage long compat_mbind(compat_ulon
 static struct mempolicy *
 get_vma_policy(struct vm_area_struct *vma, unsigned long addr)
 {
-	struct mempolicy *pol = current->mempolicy[POLICY_PAGE];
+	struct mempolicy *pol = current->mempolicy;		/* process change 1 */
 
 	if (vma) {
 		if (vma->vm_ops && vma->vm_ops->get_policy)
@@ -831,7 +830,8 @@ alloc_pages_by_policy(unsigned gfp, unsi
   
  	if (policy >= NR_MEM_POLICIES)
  		BUG();
- 	pol = current->mempolicy[policy];
+ 	if (policy == POLICY_PAGE)				/* process add 1 */
+ 		pol = current->mempolicy;                       /* process change 1 */
  	if (!pol)
  		pol = default_policy[policy];
 	if (!in_interrupt())
Index: linux-2.6.9-rc2-mm1/kernel/fork.c
===================================================================
--- linux-2.6.9-rc2-mm1.orig/kernel/fork.c	2004-09-23 10:52:34.000000000 -0700
+++ linux-2.6.9-rc2-mm1/kernel/fork.c	2004-09-23 10:58:07.000000000 -0700
@@ -865,14 +865,12 @@ static task_t *copy_process(unsigned lon
 	p->io_wait = NULL;
 	p->audit_context = NULL;
 #ifdef CONFIG_NUMA
-	for(i=0;i<NR_MEM_POLICIES;i++) {
-		p->mempolicy[i] = mpol_copy(p->mempolicy[i]);
-		if (IS_ERR(p->mempolicy[i])) {
-			retval = PTR_ERR(p->mempolicy[i]);
-			p->mempolicy[i] = NULL;
-			goto bad_fork_cleanup;
-		}
-	}
+ 	p->mempolicy = mpol_copy(p->mempolicy);		/* process del 2 */
+ 	if (IS_ERR(p->mempolicy)) {                     /* process change 3 */
+ 		retval = PTR_ERR(p->mempolicy);
+ 		p->mempolicy = NULL;
+ 		goto bad_fork_cleanup;
+ 	}
 	/* randomize placement of first page across nodes */
 	p->il_next = p->pid % MAX_NUMNODES;
 #endif
@@ -1042,8 +1040,7 @@ bad_fork_cleanup_security:
 	security_task_free(p);
 bad_fork_cleanup_policy:
 #ifdef CONFIG_NUMA
-	for(i=0;i<NR_MEM_POLICIES;i++)
-		mpol_free(p->mempolicy[i]);
+	mpol_free(p->mempolicy);		/* process del 1 */
 #endif
 bad_fork_cleanup:
 	if (p->binfmt)
Index: linux-2.6.9-rc2-mm1/include/linux/sched.h
===================================================================
--- linux-2.6.9-rc2-mm1.orig/include/linux/sched.h	2004-09-23 10:45:48.000000000 -0700
+++ linux-2.6.9-rc2-mm1/include/linux/sched.h	2004-09-23 11:04:33.000000000 -0700
@@ -30,7 +30,7 @@
 #include <linux/completion.h>
 #include <linux/pid.h>
 #include <linux/percpu.h>
-#include <linux/mempolicy.h>
+// #include <linux/mempolicy.h>		/* process del 1 */
 
 struct exec_domain;
 
@@ -743,7 +743,7 @@ struct task_struct {
  */
 	wait_queue_t *io_wait;
 #ifdef CONFIG_NUMA
-  	struct mempolicy *mempolicy[NR_MEM_POLICIES];
+  	struct mempolicy *mempolicy;		/* process change 1 */
   	short il_next;		/* could be shared with used_math */
 #endif
 #ifdef CONFIG_CPUSETS
Index: linux-2.6.9-rc2-mm1/kernel/exit.c
===================================================================
--- linux-2.6.9-rc2-mm1.orig/kernel/exit.c	2004-09-23 10:42:02.000000000 -0700
+++ linux-2.6.9-rc2-mm1/kernel/exit.c	2004-09-23 10:57:42.000000000 -0700
@@ -831,10 +831,8 @@ asmlinkage NORET_TYPE void do_exit(long 
 	tsk->exit_code = code;
 	exit_notify(tsk);
 #ifdef CONFIG_NUMA
-	for (i=0; i<NR_MEM_POLICIES; i++) {
-		mpol_free(tsk->mempolicy[i]);
-		tsk->mempolicy[i] = NULL;
-	}
+	mpol_free(tsk->mempolicy);		/* process del 2 */
+	tsk->mempolicy = NULL;			/* process change 2 */
 #endif
 	schedule();
 	BUG();
