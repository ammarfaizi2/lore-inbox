Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267289AbSKSVGk>; Tue, 19 Nov 2002 16:06:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267350AbSKSVGk>; Tue, 19 Nov 2002 16:06:40 -0500
Received: from crack.them.org ([65.125.64.184]:58269 "EHLO crack.them.org")
	by vger.kernel.org with ESMTP id <S267289AbSKSVGi>;
	Tue, 19 Nov 2002 16:06:38 -0500
Date: Tue, 19 Nov 2002 16:14:53 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Chris Wright <chris@wirex.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] sys_capget should use current if the pid argument is 0
Message-ID: <20021119211453.GA20562@nevyn.them.org>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	Chris Wright <chris@wirex.com>, linux-kernel@vger.kernel.org
References: <20021010144715.A30806@figure1.int.wirex.com> <Pine.LNX.4.44.0210111954280.5671-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0210111954280.5671-100000@home.transmeta.com>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 11, 2002 at 07:58:46PM -0700, Linus Torvalds wrote:
> 
> On Thu, 10 Oct 2002, Chris Wright wrote:
> > 
> > The patch below fixes my oversight.  The locking is left the way it was,
> > and just the pid 0 part is fixed as well as the duplicate code removed.
> 
> All right, call me stupid, but twhere is the "duplication" in the code you 
> removed?
> 
> I see the "security/capability.c" thing, yes, but I also look at
> "security/dummy.c", and it appears that at least for that case nobody
> would ever initialize the capabilities that we return to user space at
> all.
> 
> So there's a bug somewhere there, and removing the duplication makes 
> things worse (admittedly for a case which isn't enabled in the regular 
> kernel, but still..)
> 
> So I'd ask you to have patience with me, and send a third patch that gets 
> this thing right too.. 

Since this is still broken a month later... I don't know what to do
about the "duplication" question, but I'll leave that to Chris.  This
is the uncontroversial portion of Chris's patch; its affect is to
change my zsh shell prompt back to a '%' as I'd expect.

Linus, please apply.

[PATCH] sys_capget should use current if the pid argument is 0

===== kernel/capability.c 1.6 vs edited =====
--- 1.6/kernel/capability.c	Sat Sep 14 09:18:49 2002
+++ edited/kernel/capability.c	Tue Nov 19 16:10:59 2002
@@ -33,7 +33,7 @@
      int ret = 0;
      pid_t pid;
      __u32 version;
-     task_t *target;
+     task_t *target = current;
      struct __user_cap_data_struct data;
 
      if (get_user(version, &header->version))
@@ -54,10 +54,12 @@
      spin_lock(&task_capability_lock);
      read_lock(&tasklist_lock); 
 
-     target = find_task_by_pid(pid);
-     if (!target) {
-          ret = -ESRCH;
-          goto out;
+     if (pid && pid != current->pid) {
+             target = find_task_by_pid(pid);
+             if (!target) {
+                  ret = -ESRCH;
+                  goto out;
+            }
      }
 
      data.permitted = cap_t(target->cap_permitted);

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
