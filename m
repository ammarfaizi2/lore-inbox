Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292391AbSBUOdu>; Thu, 21 Feb 2002 09:33:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292394AbSBUOdo>; Thu, 21 Feb 2002 09:33:44 -0500
Received: from [66.150.46.254] ([66.150.46.254]:24251 "EHLO mail.tvol.net")
	by vger.kernel.org with ESMTP id <S292391AbSBUOdb>;
	Thu, 21 Feb 2002 09:33:31 -0500
Date: Thu, 21 Feb 2002 09:33:25 -0500 (EST)
Message-Id: <200202211433.g1LEXP813292@sinz.eng.tvol.net>
To: linux-kernel@vger.kernel.org
Cc: alan@redhat.com, torvalds@transmeta.com, msinz@wgate.com
From: "Michael Sinz" <msinz@wgate.com>
Subject: [PATCH] kernel 2.5.5 - coredump sysctl
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

coredump name format control via sysctl

Provides for a way to securely move where core files show up and to
set the name pattern for core files to include the UID, Program,
Hostname, and/or PID of the process that caused the core dump.
This is very handy for diskless clusters where all of the core
dumps go to the same disk and for production servers where core
dumps want to be segregated from the main production disks.

-- Patch background and how it works --

What I did with this patch is provide a new sysctl that lets you
control the name of the core file.  The this name is actually a format
string such that certain values from the process can be included.
If the sysctl is not used to change the format string, the behavior
is exactly the same as the current kernel coredump behavior.  (The
default pattern is set to "core" which produces the same result
as the current kernels do - thus you can use the sysctl to even put
back the current behavior if you change it - the current behavior is
not a special case)

The sysctl is kernel.core_name_format and is a string up to 63 characters
(plus 1 for the null)

The following format options are available in that string:

	%P	The Process ID (current->pid)
	%U	The UID of the process (current->uid)
	%N	The command name of the process (current->comm)
	%H	The nodename of the system (system_utsname.nodename)
	%%	A "%"

For example, in my clusters, I have an NFS R/W mount at /coredumps
that all nodes have access to.  The format string I use is:

	sysctl -w "kernel.core_name_format=/coredumps/%H-%N-%P.core"

This then causes core dumps to be of the format:

	/coredumps/whale.sinz.org-badprogram-13917.core

Old behavior of appending the PID to the "core" name is still
supported with the added logic of only doing so if the PID is
not already part of the name format.  The default name format
is still just "core" to match old behavior.

The attached patch is for Linux 2.4.17 but should patch relatively
easily to other versions.  I tried to comment the code a bit
to explain the how and why.

Some notes on security:

This patch does add the ability of a system administrator to make
a core dump format string that could cause problems.  If the format
string is set to be a fixed file name of say, "/bin/sh" it would
be a "bad thing" to have a core dump happen :-)

There is always the problem of someone with root access making
a bad setting in the sysctl.  But then, if they have root, they don't
need to set some sysctl in order to cause damage.

However, I have also worked through the security and reliability of
the code assuming that the system administrator does not set a
blatantly bad pattern.  In addition to the standard prevention of
buffer over-runs and the like, I also make sure that any user
adjustable input gets filtered to remove "/" characters such that
directories can not be changed via a program name of, say "../foo/x"
(assuming that some program goes and changes its process name to that)

So it does not prevent someone from making a name format that
would be bad (such as "/bin/sh" or "/usr/bin/%N") but then "rm -rf" still
works too :-)

One thing that I do feel is very good about this is that you can now
segregate your core files to a different partition and thus prevent
the writing to and/or filling up of your important partitions.  For
the diskless cluster situation, it also provides a way to track who
caused the core dump and, in our cluster, a place to write it since
all of the other disks are read-only or /dev/tmpfs devices.

Michael Sinz -- msinz@wgate.com -- http://www.sinz.org
A master's secrets are only as good as
	the master's ability to explain them to others.

-------------------------------------------------------------------------------

diff -urP linux-2.5.5/fs/exec.c linux-2.5.5-patch/fs/exec.c
--- linux-2.5.5/fs/exec.c	Wed Feb 20 09:48:41 2002
+++ linux-2.5.5-patch/fs/exec.c	Wed Feb 20 09:56:20 2002
@@ -35,6 +35,7 @@
 #include <linux/highmem.h>
 #include <linux/spinlock.h>
 #include <linux/personality.h>
+#include <linux/utsname.h>
 #include <linux/binfmts.h>
 #define __NO_VERSION__
 #include <linux/module.h>
@@ -49,6 +50,12 @@
 
 int core_uses_pid;
 
+/* The format string for the core file name...
+   We default to "core" such that past behavior
+   remains unchanged.  The 64 character limit is
+   arbitrary but must match the sysctl table. */
+char core_name_format[64] = {"core"};
+
 static struct linux_binfmt *formats;
 static rwlock_t binfmt_lock = RW_LOCK_UNLOCKED;
 
@@ -937,14 +944,37 @@
 		__MOD_DEC_USE_COUNT(old->module);
 }
 
+/* This is the maximum expanded core file name.  We use
+   a reasonable number here since we use the stack to
+   do the expansion.  However, the number should be big
+   enough to handle a reasonable command name plus PID
+   and/or UID in addition to the file name part that
+   is in the core_name_format string. */
+#define MAX_CORE_NAME (160)
+
 int do_coredump(long signr, struct pt_regs * regs)
 {
 	struct linux_binfmt * binfmt;
-	char corename[6+sizeof(current->comm)+10];
 	struct file * file;
 	struct inode * inode;
 	int retval = 0;
 
+	int fmt_i;
+	int name_n;
+	int addPID;
+	char *cname;
+
+	/* The +11 is here to simplify the code path.  What
+	   we do is always check that we are less than MAX
+	   but there are times when we also need to append
+	   a number (such as the PID or UID).  Rather than
+	   using another temporary buffer, we provide for
+	   enough extra space such that those numbers can
+	   be added in one gulp even if we are just under
+	   the MAX_CORE_NAME.  Reduction in complexity of
+	   the code path means a more reliable implementation. */
+	char corename[MAX_CORE_NAME + 1 + 11];
+
 	lock_kernel();
 	binfmt = current->binfmt;
 	if (!binfmt || !binfmt->core_dump)
@@ -955,10 +985,92 @@
 	if (current->rlim[RLIMIT_CORE].rlim_cur < binfmt->min_coredump)
 		goto fail;
 
-	memcpy(corename,"core.", 5);
-	corename[4] = '\0';
- 	if (core_uses_pid || atomic_read(&current->mm->mm_users) != 1)
- 		sprintf(&corename[4], ".%d", current->pid);
+	/* Set this to true if we are going to add the PID.  If the PID
+	   already is added in the format we will end up clearing this.
+	   The purpose is to provide for the old behavior of adding the
+	   PID to the core file name but to not add it if it already
+	   was included via the file name format pattern. */
+	addPID = (core_uses_pid || atomic_read(&current->mm->mm_users) != 1);
+
+	/* Build the core file name as needed from the format string */
+	for (fmt_i=0, name_n=0;
+	     name_n < MAX_CORE_NAME && core_name_format[fmt_i];
+	     fmt_i++)
+	{
+		switch (core_name_format[fmt_i])
+		{
+		case '%':	/* A format character */
+			fmt_i++;
+			switch (core_name_format[fmt_i])
+			{
+			case '%': /* The way we get this character */
+				corename[name_n++] = '%';
+				break;
+
+			case 'N': /* Process name */
+				cname=current->comm;
+
+				/* Only copy as much as will fit within the
+				   MAX_CORE_NAME */
+				while (*cname && (name_n < MAX_CORE_NAME))
+				{
+					if (*cname != '/')
+						corename[name_n++] = *cname;
+					cname++;
+				}
+				break;
+
+			case 'H': /* Node name */
+				cname=system_utsname.nodename;
+
+				/* Only copy as much as will fit within the
+				   MAX_CORE_NAME */
+				while (*cname && (name_n < MAX_CORE_NAME))
+				{
+					if (*cname != '/')
+						corename[name_n++] = *cname;
+					cname++;
+				}
+				break;
+
+			case 'P': /* Process PID */
+				/* Since we are adding it here, don't append */
+				addPID=0;
+
+				/* We don't need to pre-check that the number
+				   fits since we added a padding of 11
+				   characters to the end of the string buffer
+				   just so that we don't need to do an extra
+				   check */
+				name_n += sprintf(&corename[name_n],"%d",current->pid);
+				break;
+
+			case 'U': /* UID of the process */
+				/* We don't need to pre-check that the number
+				   fits since we added a padding of 11
+				   characters to the end of the string buffer
+				   just so that we don't need to do an extra
+				   check */
+				name_n += sprintf(&corename[name_n],"%d",current->uid);
+				break;
+			}
+			break;
+
+		default:	/* Anything else just pass along */
+			corename[name_n++] = core_name_format[fmt_i];
+		}
+	}
+
+	/* If we still want to append the PID and there is room, do so */
+	/* This is to preserve current behavior */
+	if (addPID && (name_n < MAX_CORE_NAME))
+	{
+		name_n += sprintf(&corename[name_n],".%d",current->pid);
+	}
+
+	/* And make sure to null terminate the string */
+	corename[name_n]='\0';
+
 	file = filp_open(corename, O_CREAT | 2 | O_NOFOLLOW, 0600);
 	if (IS_ERR(file))
 		goto fail;
diff -urP linux-2.5.5/include/linux/sysctl.h linux-2.5.5-patch/include/linux/sysctl.h
--- linux-2.5.5/include/linux/sysctl.h	Sun Feb 10 20:50:07 2002
+++ linux-2.5.5-patch/include/linux/sysctl.h	Wed Feb 20 09:56:20 2002
@@ -124,6 +124,7 @@
 	KERN_CORE_USES_PID=52,		/* int: use core or core.%pid */
 	KERN_TAINTED=53,	/* int: various kernel tainted flags */
 	KERN_CADPID=54,		/* int: PID of the process to notify on CAD */
+	KERN_CORE_NAME_FORMAT=55, /* string: core file name format string */
 };
 
 
diff -urP linux-2.5.5/kernel/sysctl.c linux-2.5.5-patch/kernel/sysctl.c
--- linux-2.5.5/kernel/sysctl.c	Wed Feb 20 09:48:56 2002
+++ linux-2.5.5-patch/kernel/sysctl.c	Wed Feb 20 09:56:20 2002
@@ -50,6 +50,7 @@
 extern int max_queued_signals;
 extern int sysrq_enabled;
 extern int core_uses_pid;
+extern char core_name_format[];
 extern int cad_pid;
 
 /* this is needed for the proc_dointvec_minmax for [fs_]overflow UID and GID */
@@ -170,6 +171,8 @@
 	 0644, NULL, &proc_dointvec},
 	{KERN_CORE_USES_PID, "core_uses_pid", &core_uses_pid, sizeof(int),
 	 0644, NULL, &proc_dointvec},
+	{KERN_CORE_NAME_FORMAT, "core_name_format", core_name_format, 64,
+	 0644, NULL, &proc_doutsstring, &sysctl_string},
 	{KERN_TAINTED, "tainted", &tainted, sizeof(int),
 	 0644, NULL, &proc_dointvec},
 	{KERN_CAP_BSET, "cap-bound", &cap_bset, sizeof(kernel_cap_t),
