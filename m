Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261853AbSJ2L65>; Tue, 29 Oct 2002 06:58:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261854AbSJ2L65>; Tue, 29 Oct 2002 06:58:57 -0500
Received: from mailout07.sul.t-online.com ([194.25.134.83]:34001 "EHLO
	mailout07.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S261853AbSJ2L64>; Tue, 29 Oct 2002 06:58:56 -0500
To: Andreas Gruenbacher <agruen@suse.de>
Cc: <chris@scary.beasts.org>, <linux-kernel@vger.kernel.org>,
       Ulrich Drepper <drepper@redhat.com>, <bug-glibc@gnu.org>
Subject: Re: __libc_enable_secure check (was: [PATCH][RFC] 2.5.44 (1/2):
 Filesystem capabilities kernel patch)
References: <Pine.LNX.4.33.0210282327520.8990-100000@sphinx.mythic-beasts.com>
	<200210290323.09565.agruen@suse.de> <87n0oxmrhn.fsf@goat.bogus.local>
From: Olaf Dietsche <olaf.dietsche#list.linux-kernel@t-online.de>
Mail-Followup-To: <agruen@suse.de>, <chris@scary.beasts.org>,
 <drepper@redhat.com>, <bug-glibc@gnu.org>,
 <olaf.dietsche#list.linux-kernel@t-online.de>
Date: Tue, 29 Oct 2002 13:04:58 +0100
Message-ID: <87fzupmowl.fsf@goat.bogus.local>
User-Agent: Gnus/5.090005 (Oort Gnus v0.05) XEmacs/21.4 (Honest Recruiter,
 i386-debian-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Olaf Dietsche <olaf.dietsche#list.linux-kernel@t-online.de> writes:

> Andreas Gruenbacher <agruen@suse.de> writes:
>
>> On Tuesday 29 October 2002 00:36, chris@scary.beasts.org wrote:
>>> I'm not sure what the current glibc security check is, but it used to be
>>> simple *uid() vs. *euid() checks. This would not catch an executable with
>>> filesystem capabilities.
>>> Have a look at
>>> http://security-archive.merton.ox.ac.uk/security-audit-199907/0192.html
> [...]
>>> I think the eventual plan was that we pass the kernel's current->dumpable
>>> as an ELF note. Not sure if it got done. Alternatively glibc could use
>>> prctl(PR_GET_DUMPABLE).
>>
>> Sorry, I don't know exactly what was your plan here. Could you please explain?
>
> Judging from the mail archive above: instead of checking uid vs. euid
> and gid vs. egid, ask the kernel and grant or deny LD_PRELOAD
> according to the dumpable flag (see prctl(2)). This flag is set to
> false, if uid != euid, etc. So, this flag could be used/cleared by
> capabilities as well.

I'm a bit lost in the glibc sources, but tried my best anyway :-).
Here is an untested patch against glibc 2.3.1. Can someone from the
glibc team please comment? Would this be acceptable or do you have any
objections against it? Could this be included even into glibc 2.2.x?

TIA
Regards, Olaf.

--- glibc-2.3.1/sysdeps/generic/dl-sysdep.c~	Sat Jul 20 19:30:48 2002
+++ glibc-2.3.1/sysdeps/generic/dl-sysdep.c	Tue Oct 29 12:47:55 2002
@@ -140,6 +140,9 @@
   DL_SYSDEP_OSCHECK (dl_fatal);
 #endif
 
+#ifdef DL_SECURE_INIT
+  DL_SECURE_INIT;
+#else
   /* Fill in the values we have not gotten from the kernel through the
      auxiliary vector.  */
 #ifndef HAVE_AUX_XID
@@ -154,6 +157,7 @@
   /* If one of the two pairs of IDs does not mattch this is a setuid
      or setgid run.  */
   INTUSE(__libc_enable_secure) = uid | gid;
+#endif
 
 #ifndef HAVE_AUX_PAGESIZE
   if (GL(dl_pagesize) == 0)
--- glibc-2.3.1/sysdeps/unix/sysv/linux/dl-sysdep.c~	Thu May 16 07:43:08 2002
+++ glibc-2.3.1/sysdeps/unix/sysv/linux/dl-sysdep.c	Tue Oct 29 12:47:53 2002
@@ -20,9 +20,11 @@
 /* Linux needs some special initialization, but otherwise uses
    the generic dynamic linker system interface code.  */
 
+#include <sys/prctl.h>
 #include <unistd.h>
 
 #define DL_SYSDEP_INIT frob_brk ()
+#define DL_SECURE_INIT INTUSE(__libc_enable_secure) = prctl (PR_GET_DUMPABLE) == 0
 
 static inline void
 frob_brk (void)
