Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135686AbRD2HOy>; Sun, 29 Apr 2001 03:14:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135687AbRD2HOo>; Sun, 29 Apr 2001 03:14:44 -0400
Received: from freya.yggdrasil.com ([209.249.10.20]:28100 "EHLO
	ns1.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S135686AbRD2HOf>; Sun, 29 Apr 2001 03:14:35 -0400
Date: Sun, 29 Apr 2001 00:14:31 -0700
From: "Adam J. Richter" <adam@yggdrasil.com>
To: bug-bash@gnu.org
Cc: linux-kernel@vger.kernel.org
Subject: Patch(?): bash-2.05/jobs.c loses interrupts
Message-ID: <20010429001431.A3729@adam.yggdrasil.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="uAKRQypu60I7Lcqm"
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--uAKRQypu60I7Lcqm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

	Linux-2.4.4 has a change, for which I must accept blame,
where fork() runs the child first, reducing unnecessary copy-on-write
page duplications, because the child will usually promptly do an
exec().  I understand this is pretty standard in most unixes.

	Peter Osterlund noticed an annoying side effect of this,
which I think is a bash bug.  He wrote:

> Another thing is that the bash loop "while true ; do /bin/true ; done" is
> not possible to interrupt with ctrl-c.

	I have reproduced this problem on a single CPU system.
I also modified my kernel to sometimes run the fork child first
and sometimes not.  In that case, that loop would sometimes
abort on a control-C and sometimes ignore it, but ignoring it
would not make the loop less likely to abort on another control-C.
I'm pretty sure the control-C was being delivered only to the child
due to a race condition in bash, which may be mandated by posix.

	I am pretty sure that the reason for this behavior is that
is that make_child() in bash-2.05/jobs.c has the child define itself
as a new process group and set the terminal's process group to it.
The parent will eventually also set its pgid to the child's pid when
it finally runs, but, in this example, /bin/true will probably run to
completion before that.  So, there is a period of time when the
child has set itself up as a distinct process group and pointed
the terminal to it, but the parent has not yet joined that process
group, so only the child will receive a ^C that happens during this
time.  This is the case basically 100% of the time if you do
a "while true ; do /bin/true ; done" loop under linux-2.4.4 on a
1GHz Pentium III (slower CPU's may not have enough cycles per time
slice to make this race happen reliably, as I do not see it on a
similar 866MHz Pentium III).

	I think the correct fix is for bash to have the parent
set the controlling process of the terminal, not to have the child
do it.  In fact, there are comments to this effect in bash-2.05/jobs.c,
although they do not explain why this is not currently done.  I have
attached a patch which is my guess at how to implement the change.
I know it fixes the "while true ; do /bin/true ; done" example.
I think that there may be some other loose ends to clean up, though.
For example, there is now potentially a time window when only the
parent will receive a control-C, so it may be necessary for the
parent to signal the child if the parent sees a signal as soon as
it has unblocked them.

-- 
Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."

--uAKRQypu60I7Lcqm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="bash.diff"

--- bash-2.05/jobs.c	Mon Mar 26 10:08:24 2001
+++ bash/jobs.c	Sat Apr 28 23:51:33 2001
@@ -1202,17 +1202,6 @@
 #if defined (PGRP_PIPE)
 	  if (pipeline_pgrp == mypid)
 	    {
-#endif
-	      /* By convention (and assumption above), if
-		 pipeline_pgrp == shell_pgrp, we are making a child for
-		 command substitution.
-		 In this case, we don't want to give the terminal to the
-		 shell's process group (we could be in the middle of a
-		 pipeline, for example). */
-	      if (async_p == 0 && pipeline_pgrp != shell_pgrp)
-		give_terminal_to (pipeline_pgrp, 0);
-
-#if defined (PGRP_PIPE)
 	      pipe_read (pgrp_pipe);
 	    }
 #endif
@@ -1251,9 +1240,14 @@
 	  if (pipeline_pgrp == 0)
 	    {
 	      pipeline_pgrp = pid;
-	      /* Don't twiddle terminal pgrps in the parent!  This is the bug,
-		 not the good thing of twiddling them in the child! */
-	      /* give_terminal_to (pipeline_pgrp, 0); */
+	      /* By convention (and assumption above), if
+		 pipeline_pgrp == shell_pgrp, we are making a child for
+		 command substitution.
+		 In this case, we don't want to give the terminal to the
+		 shell's process group (we could be in the middle of a
+		 pipeline, for example). */
+	      if (async_p == 0 && pipeline_pgrp != shell_pgrp)
+		give_terminal_to (pipeline_pgrp, 0);
 	    }
 	  /* This is done on the recommendation of the Rationale section of
 	     the POSIX 1003.1 standard, where it discusses job control and

--uAKRQypu60I7Lcqm--
