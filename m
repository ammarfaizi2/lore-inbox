Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267160AbSKTAvE>; Tue, 19 Nov 2002 19:51:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267161AbSKTAvE>; Tue, 19 Nov 2002 19:51:04 -0500
Received: from cerebus.wirex.com ([65.102.14.138]:51185 "EHLO
	figure1.int.wirex.com") by vger.kernel.org with ESMTP
	id <S267160AbSKTAvD>; Tue, 19 Nov 2002 19:51:03 -0500
Date: Tue, 19 Nov 2002 16:55:56 -0800
From: Chris Wright <chris@wirex.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Chris Wright <chris@wirex.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sys_capget should use current if the pid argument is 0
Message-ID: <20021119165556.A5806@figure1.int.wirex.com>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	Chris Wright <chris@wirex.com>, linux-kernel@vger.kernel.org
References: <20021010144715.A30806@figure1.int.wirex.com> <Pine.LNX.4.44.0210111954280.5671-100000@home.transmeta.com> <20021119211453.GA20562@nevyn.them.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20021119211453.GA20562@nevyn.them.org>; from dan@debian.org on Tue, Nov 19, 2002 at 04:14:53PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Daniel Jacobowitz (dan@debian.org) wrote:
> On Fri, Oct 11, 2002 at 07:58:46PM -0700, Linus Torvalds wrote:
> > 
> > On Thu, 10 Oct 2002, Chris Wright wrote:
> > > 
> > > The patch below fixes my oversight.  The locking is left the way it was,
> > > and just the pid 0 part is fixed as well as the duplicate code removed.
> > 
> > All right, call me stupid, but twhere is the "duplication" in the code you 
> > removed?
> > 
> > I see the "security/capability.c" thing, yes, but I also look at
> > "security/dummy.c", and it appears that at least for that case nobody
> > would ever initialize the capabilities that we return to user space at
> > all.
> > 
> > So there's a bug somewhere there, and removing the duplication makes 
> > things worse (admittedly for a case which isn't enabled in the regular 
> > kernel, but still..)
> > 
> > So I'd ask you to have patience with me, and send a third patch that gets 
> > this thing right too.. 
> 
> Since this is still broken a month later... I don't know what to do
> about the "duplication" question, but I'll leave that to Chris.  This
> is the uncontroversial portion of Chris's patch; its affect is to
> change my zsh shell prompt back to a '%' as I'd expect.

Thanks Daniel.  I've been using the patch below, which differs only
slightly from the one you posted (code style matches the same lookup in
sys_capset).  I'll follow up with the patch that removes the duplicate
code.

[PATCH] sys_capget should use current if the pid argument is 0

===== kernel/capability.c 1.5 vs edited =====
--- 1.5/kernel/capability.c	Sun Sep 15 12:19:29 2002
+++ edited/kernel/capability.c	Tue Nov 19 15:57:15 2002
@@ -54,11 +54,14 @@
      spin_lock(&task_capability_lock);
      read_lock(&tasklist_lock); 
 
-     target = find_task_by_pid(pid);
-     if (!target) {
-          ret = -ESRCH;
-          goto out;
-     }
+     if (pid && pid != current->pid) {
+	     target = find_task_by_pid(pid);
+	     if (!target) {
+	          ret = -ESRCH;
+	          goto out;
+	     }
+     } else
+	     target = current;
 
      data.permitted = cap_t(target->cap_permitted);
      data.inheritable = cap_t(target->cap_inheritable); 
