Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265912AbUA1LdP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jan 2004 06:33:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265915AbUA1LdP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jan 2004 06:33:15 -0500
Received: from tolkor.sgi.com ([198.149.18.6]:7591 "EHLO tolkor.sgi.com")
	by vger.kernel.org with ESMTP id S265912AbUA1LdM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jan 2004 06:33:12 -0500
Date: Wed, 28 Jan 2004 05:31:37 -0600
From: Robin Holt <holt@sgi.com>
To: Tim Hockin <thockin@sun.com>
Cc: Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: NGROUPS 2.6.2rc2
Message-ID: <20040128113137.GA23445@lnx-holt>
References: <20040127225311.GA9155@sun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040127225311.GA9155@sun.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 27, 2004 at 02:53:11PM -0800, Tim Hockin wrote:

For the every declaration of struct group_info *info, is there a
more descriptive name than info available.  This will make
searchs simpler in the long run.


+#define NGROUPS_SMALL          32
+#define NGROUPS_BLOCK          ((int)(EXEC_PAGESIZE / sizeof(gid_t)))

Can this be changed to NGROUPS_PER_EPAGE.  NGROUPS_BLOCK seems to
indicate a location of a block or the block or some block given an offset.
NGROUPS_PER_EPAGE is very explicit.

+void groups_free(struct group_info *info)
 {
+       if (info->ngroups > NGROUPS_SMALL) {

Why not use info->nblocks > 0.  These are more clearly tied to each
other than ngroups and NGROUPS_SMALL.


+                       while (left >= 0 && GROUP_AT(info, left) > tmp) {
+                               GROUP_AT(info, right) = GROUP_AT(info, left);
+                               left -= stride;
+                               right = left + stride;

For the above in groups_sort, why not just have
                                right = stride;
                                left -= stride;



@@ -1102,54 +1256,43 @@

        if (gidsetsize < 0)
                return -EINVAL;
-       i = current->ngroups;
+       i = current->group_info->ngroups;
        if (gidsetsize) {
                if (i > gidsetsize)
                        return -EINVAL;
-               if (copy_to_user(grouplist, current->groups, sizeof(gid_t)*i))
+               if (groups_to_user(grouplist, current->group_info))
                        return -EFAULT;
        }

Shouldn't there be a get/put pair around this.  Especially with the
copy_to_user call buried in groups_to_user, we could spend quite some time
waiting for the page fault and another thread could free our structure.
Or maybe I am missing something...


+       if (info->ngroups > TASK_SIZE/sizeof(group))
+               return -EFAULT;

I don't understand the TASK_SIZE usage.  Maybe this is a difference
between ia64 and i386, but these checks don't make any sense to
me.  Consider them not looked at.


 asmlinkage long sys_getgroups16(int gidsetsize, old_gid_t __user *grouplist)
 {
-       old_gid_t groups[NGROUPS];
-       int i,j;
+       int i = 0;

        if (gidsetsize < 0)
                return -EINVAL;
-       i = current->ngroups;
+       i = current->group_info->ngroups;
        if (gidsetsize) {
                if (i > gidsetsize)
                        return -EINVAL;
-               for(j=0;j<i;j++)
-                       groups[j] = current->groups[j];
-               if (copy_to_user(grouplist, groups, sizeof(old_gid_t)*i))
+               if (groups16_to_user(grouplist, current->group_info))

Again with the get/put.

===== fs/proc/array.c 1.55 vs edited =====
--- 1.55/fs/proc/array.c        Tue Oct 14 14:00:09 2003
+++ edited/fs/proc/array.c      Tue Jan 27 12:40:02 2004
@@ -176,8 +176,8 @@
                p->files ? p->files->max_fds : 0);
        task_unlock(p);

-       for (g = 0; g < p->ngroups; g++)
-               buffer += sprintf(buffer, "%d ", p->groups[g]);
+       for (g = 0; g < min(p->group_info->ngroups,NGROUPS_SMALL); g++)
+               buffer += sprintf(buffer, "%d ", GROUP_AT(p->group_info,g));

        buffer += sprintf(buffer, "\n");
        return buffer;


Again with the get/put.

All of the sunrpc mods appear to need get/put.

