Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263218AbSJOQxb>; Tue, 15 Oct 2002 12:53:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263289AbSJOQxb>; Tue, 15 Oct 2002 12:53:31 -0400
Received: from smtp01.uc3m.es ([163.117.136.121]:9993 "HELO smtp.uc3m.es")
	by vger.kernel.org with SMTP id <S263218AbSJOQx3>;
	Tue, 15 Oct 2002 12:53:29 -0400
Date: Tue, 15 Oct 2002 16:58:44 +0000
From: Eduardo =?iso-8859-1?Q?P=E9rez?= <100018135@alumnos.uc3m.es>
To: Michal Kara <lemming@atrey.karlin.mff.cuni.cz>
Cc: linux-kernel@vger.kernel.org
Subject: fork() wait semantics
Message-ID: <34f5602687bbb910752d5becee9c9aa1@alumnos.uc3m.es>
References: <20021015115517.GA2514@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="2oS5YaxWCcQjTEyO"
Content-Disposition: inline
In-Reply-To: <20021015115517.GA2514@atrey.karlin.mff.cuni.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On 2002-10-15 13:55:17 +0200, Michal Kara wrote:
>   Several times I had real problems with batch jobs failing with EAGAIN,
> printed as "Resource temporarily unavailable". Not with the failure, but to
> determine the real cause is really a pain. Usually, the problem is in
> resource limits (rlimit, set by ulimit), but the returned error code is
> misleading.

I've investigated the use of the fork() system call across some
programs in Debian GNU/Linux and I've found that the current fork
semantics are not very good.

When Linux can't fork() returns a fork error that the application
usually sees as a fatal error. Instead of the fatal error fork
should wait for resources to be available, thus never returning an
error. If the current user has exceeded one of its limits the program
should block waiting for another program of the same user to free
resources. There's a possible user deadlock in this approach that the
kernel should signal.

As no application waits for fork to be available most applications threat
a fork() error as fatal.

A possible fork interface would be waiting for resources to be available
and only returning with error in case of deadlock.

This needs to be fixed in the kernel as there's no interfaces in user
space to wait for fork() availability or signaling deadlocks.

This interface is also applicable to any other memory requesting system
call (like brk) that can return ENOMEM (instead of waiting for memory to
be available), or falling on deadlock.

As an example consider bash. In case of fork() error the program
isn't even run thus causing a fatal error. If fork() waited for
resources to be available there wouldn't be any problem.

Is there a syscall to wait for fork to be available instead of sleeping
an amount of time between fork()?

Attached is a bash patch that works but it's not optimal without a proper
kernel interface as it waits a fixed amount of time betteen fork()
attemps and can't detect deadlocks.

--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="bash_no_crash_on_fork.diff"

--- jobs.c~	Mon Nov  5 14:56:17 2001
+++ jobs.c	Mon Mar 25 10:04:39 2002
@@ -1178,18 +1178,11 @@
 #endif /* BUFFERED_INPUT */
 
   /* Create the child, handle severe errors. */
-  if ((pid = fork ()) < 0)
+  while ((pid = fork ()) < 0)
     {
-      sys_error ("fork");
-
-      /* Kill all of the processes in the current pipeline. */
-      terminate_current_pipeline ();
-
-      /* Discard the current pipeline, if any. */
-      if (the_pipeline)
-	kill_current_pipeline ();
-
-      throw_to_top_level ();	/* Reset signals, etc. */
+      sleep(1);   /* This time shouldn't be hardcoded */
+                  /* It would be better to have a primitive in the kernel */
+                  /* that sleeps until fork() is available */
     }
 
   if (pid == 0)
--- nojobs.c~	Mon Oct 22 18:12:45 2001
+++ nojobs.c	Mon Mar 25 10:12:17 2002
@@ -478,11 +478,7 @@
 #endif /* BUFFERED_INPUT */
 
   /* Create the child, handle severe errors. */
-#if defined (HAVE_WAITPID)
-  retry_fork:
-#endif /* HAVE_WAITPID */
-
-  if ((pid = fork ()) < 0)
+  while ((pid = fork ()) < 0)
     {
 #if defined (HAVE_WAITPID)
       /* Posix systems with a non-blocking waitpid () system call available
@@ -491,13 +487,12 @@
 	{
 	  reap_zombie_children ();
 	  retry = 0;
-	  goto retry_fork;
-	}
+	} else
 #endif /* HAVE_WAITPID */
 
-      sys_error ("fork");
-
-      throw_to_top_level ();
+      sleep(1);   /* This time shouldn't be hardcoded */
+                  /* It would be better to have a primitive in the kernel */
+                  /* that sleeps until fork() is available */
     }
 
   if (pid == 0)

--2oS5YaxWCcQjTEyO--
