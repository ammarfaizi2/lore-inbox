Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265701AbUHAKXm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265701AbUHAKXm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Aug 2004 06:23:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265724AbUHAKXl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Aug 2004 06:23:41 -0400
Received: from mail-relay-4.tiscali.it ([213.205.33.44]:8901 "EHLO
	mail-relay-4.tiscali.it") by vger.kernel.org with ESMTP
	id S265701AbUHAKXb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Aug 2004 06:23:31 -0400
Date: Sun, 1 Aug 2004 12:22:31 +0200
From: Andrea Arcangeli <andrea@cpushare.com>
To: Hans Reiser <reiser@namesys.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: secure computing for 2.6.7
Message-ID: <20040801102231.GB6295@dualathlon.random>
References: <20040704173903.GE7281@dualathlon.random> <40EC4E96.9090800@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40EC4E96.9090800@namesys.com>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 07, 2004 at 12:27:18PM -0700, Hans Reiser wrote:
> Am I right to think that this could complement nicely our plans 
> described at www.namesys.com/blackbox_security.html
> 
> ?

sounds like yes. However what I'm doing with the seccomp [2] mode is
much order of magnitude simpler and less generic, so I don't expect it
will be useful to many apps. When you mention in your document that
chroot "... is currently too much work for it to see as much usage as I
would like it to.", the seccomp mode doesn't help here since it's an
order of magnitude harder to jail stuff inside the seccomp mode than it
is for chroot, however the security guarantees are many more orders of
magnitude better than the ones provided by chroot so it very much worth
to use the seccomp mode it if you really need the maximal degree of
security like I do.

the seccomp mode is pratically only about computing securely inside an
"unbreakable" jail, not much else. Everything can be offloaded to a
seccomp computing process in theory and you can build an API with file
descriptors communicating with pipes or sockets. However it's not easy
to implement for general purpose applications like web browsers where
the untrusted scripts normally have to draw on the screen something too,
which means the API to the seccomp task would be quite huge, plus the
slowdown could be significant (though you could in theory very well
share xshm of the xserver with the seccomp-mode task). I've put a
demostration code in the website [3] that shows a task running in seccomp
mode, that is the right way to use it, no execve involved. Possibly the
only minor dependency is about the popen3 to close all file descriptors
before starting the task, but I've a quick check in the child too that
bugs out if something went wrong shall the behaviour ever change on the
python side.

Note that to get maximum security I cannot even trust the elf loader in
the kernel. there were bugs in the past that crashed the kernel by just
executing ./vmlinux on x86 ;). That code is way too complex to remotely
trust it. In short there's no way I can trust the ELF parsing and the
exec syscall at all.  All I trust is read/write/sigreturn/exit + the cpu
hardware and the context switch. I feel I can trust that just fine.
Statistically speaking the only thing that could have escaped seccomp
mode was the mmx feature that wasn't backwards compatible with previous
x86 cpus and people could sniff the mmx status of the other tasks, I was
involved myself in the kernel fix for that a few years ago, that's the
only scary bit (i.e. the cpu hardware dependency). well in theory I
could run an interpreter in seccomp mode, but that would be hundred
times slower and nuking 99/100 of the power of the thing isn't exactly
nice, so I'm going to trust the cpu hardware for now.

Note that I don't care much about whatever _DoS_ in the cpus like f00f
or kernel bugs leading to DoS like the TF bitflag being set in the
instruction before lcall or the fnclex, those will be autodetected and
stopped immediatly and IP address and time of the bad guy will be
trivial to identify. When any bad guy does attack the system it's
trivial to catch, the only thing I couldn't catch is the mmx sniffing
if nobody notices it from the sourcecode, but I'm confortable there are
no bugs like that anymore.

Now the last thing that would be nice to have on the kernel side as far
as cpushare is concerned (and the main reason for this email) is that
I'd like a more reliable way to know if a certain kernel is secure
enough to run stuff in seccomp mode. This is about disaster recovery,
after something very bad has happened if the seccomp mode jail broke.
Let's assume there's another cpu bug in the future in some future cpu
that will be shipped years from now, that will allow sniffing data from
other tasks like it happened with the mmx in the past. cpushare will
react to any security bug immediatly as soon as they're disclosed.
But then to restart the thing I need to identify reliably which users
can still run stuff in seccomp mode safely. I could use the kernel
version returned by uname -r, but think if an user applies his security
fix to his previous kernel and reboots the machine with the "fixed"
patch after a minute or if a vendor doesn't change its uname -r string
after applying a fix (not the case for SUSE of course, we always bump
the uname -r string after an update, but I don't know if every possible
vendor does that and I don't know if every possible linux user is using
vendor kernels).  If there was something like
/proc/sys/kernel/security_sequence [1] or anything like that that we
could increase every time we fix a kernel bug (note, it's not mandatory
to increase it every time, and we could increase it even weeks after the
bug has been fixed after somebody ask for it, and it would still work
fine) that would make life much easier since I wouldn't need to build an
ugly database of all kernel releases covering every possible
distribution (and I couldn't cover the people using self-built kernels
or cvs/bk-revisions).  Some ugly database may be needed anyways
eventually, like if the bug can only happen on a certain cpu revision, I
sure don't want to force everyone to upgrade nuking all userbase at
once, if the user enabled auto-upgrade I'd offload some python bytecode
that will check the cpu and it will give a warning to the users with the
"old cpus" and I'd only really stop the "new cpus" from executing in
seccomp mode unless they fix the bug and they bump the security_sequence
accordingly.  If the bug is very very bad and it can even modify stuff
outside the jail (I cannot exclude that could ever happen and I must be
ready to react for it anytime) I'd have to ask the user to reinstall his
machine from scratch (I'll keep track of every user security_sequence
and cpu revision of course). If it's an hardware bug and it cannot be
worked around in the kernel then I'll giveup even before checking the
security_sequence.

Especially considering the spread of virus on the internet in some
insecure OS (and considering nobody should ever trust an antivirus or a
virus definition installed _after_ a virus has already spread on the
machine), and considering the probability that the seccomp jail could
break, I believe cpushare is very safe and I couldn't be designed in a
safer way with current x86 hardware.

Somebody suggested ptrace could do something similar, but the tracer
could get killed with an oom, I need something unbreakable. The selinux
could do something similar but not everyone has it enabled and it
slowsdown things a bit (fixable for some big spinlock) but the seccomp
mode is also much simpler and in turn more secure than selinux (of
course this leads it to be less generic but I can live with that).

If people forgets to bump the sequence number with the fix that's fine
too, nothing bad will happen, but maybe Linus will get a patch from me
after a while that bumps the security number. The one thing I care is to
identify the buggy kernels reliably, I don't need to identify the secure
kernels reliably, fase positives are fine, false negatives not, and a
sequence number would work fine for that.

I could call it /proc/sys/kernel/seccomp_security_sequence too, but I
thought that calling it security_sequence and to have it more generic
would be fine. I will check that it's higher than a certain number, but
even if it's even higher I'm fine. I mean I don't expect to ever check
that sysctl for a value > 0, but I'm fine if every single security
bugfix bumps the kernel version, but it's up to the security people to
evaluate if it makes any sense to bump the kernel version or not.

To make an example when sendmail broke because they were the only ones
using the capability syscall of the kernel, they could have changed
their source to check for security_sequence to be > something.  Then
everybody downloading the new sendmail version would had no risk to run
their application on a insecure kernel. Checking for a certain
security_sequence at daemon-startup seems low-overhead enough that may
be useful not just for cpushare (under an #ifdef __linux__).

Note: I don't even need this patch applied right now, since I can
very easily interpret the missing "sysctl" as security_sequence -1, but
after a bug like fnclex that happened a few months ago I would need to
have this patch applied or I'd be _forced_ in a very big `uname -r`
total nightmare.

this wastes 4 bytes for the integer and a few bytes for the sysctl data
structure.

Comments/suggestions?

security_sequence patch against kernel CVS follows:

Signed-off-by: Andrea Arcangeli <andrea@cpushare.com>

Index: security-sequence/include/linux/sysctl.h
===================================================================
RCS file: /home/andrea/crypto/cvs/linux-2.5/include/linux/sysctl.h,v
retrieving revision 1.75
diff -u -p -r1.75 sysctl.h
--- security-sequence/include/linux/sysctl.h	24 Jun 2004 15:54:04 -0000	1.75
+++ security-sequence/include/linux/sysctl.h	1 Aug 2004 09:20:58 -0000
@@ -133,6 +133,7 @@ enum
 	KERN_NGROUPS_MAX=63,	/* int: NGROUPS_MAX */
 	KERN_SPARC_SCONS_PWROFF=64, /* int: serial console power-off halt */
 	KERN_HZ_TIMER=65,	/* int: hz timer on or off */
+	KERN_SECURITY_SEQUENCE=66,	/* int: security sequence number */
 };
 
 
Index: security-sequence/kernel/sysctl.c
===================================================================
RCS file: /home/andrea/crypto/cvs/linux-2.5/kernel/sysctl.c,v
retrieving revision 1.83
diff -u -p -r1.83 sysctl.c
--- security-sequence/kernel/sysctl.c	31 Jul 2004 05:49:36 -0000	1.83
+++ security-sequence/kernel/sysctl.c	1 Aug 2004 09:55:44 -0000
@@ -71,6 +71,15 @@ static int minolduid;
 
 static int ngroups_max = NGROUPS_MAX;
 
+/*
+ * bump this sequence number after fixing any kernel security bug
+ * that could render insecure some userspace application. This
+ * way future versions of the userpace application will be able
+ * to reliably make sure to run on a secure kernel.
+ * I hope 31bit are enough... ;).
+ */
+static int security_sequence;
+
 #ifdef CONFIG_KMOD
 extern char modprobe_path[];
 #endif
@@ -620,6 +629,14 @@ static ctl_table kern_table[] = {
 		.mode		= 0444,
 		.proc_handler	= &proc_dointvec,
 	},
+	{
+		.ctl_name	= KERN_SECURITY_SEQUENCE,
+		.procname	= "security_sequence",
+		.data		= &security_sequence,
+		.maxlen		= sizeof (int),
+		.mode		= 0444,
+		.proc_handler	= &proc_dointvec,
+	},
 	{ .ctl_name = 0 }
 };
 


[1]	http://www.us.kernel.org/pub/linux/kernel/people/andrea/patches/v2.6/2.6.8-rc2/security_sequence-1
[2]	http://www.us.kernel.org/pub/linux/kernel/people/andrea/patches/v2.6/2.6.8-rc2/seccomp-2
[3]	http://www.cpushare.com/download/download.php
