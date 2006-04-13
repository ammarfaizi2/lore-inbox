Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965030AbWDMXLl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965030AbWDMXLl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 19:11:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964998AbWDMXLM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 19:11:12 -0400
Received: from ns1.suse.de ([195.135.220.2]:3782 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S965017AbWDMXKK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 19:10:10 -0400
Date: Thu, 13 Apr 2006 16:09:09 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       Ulrich Weigand <uweigand@de.ibm.com>, Cliff Wickman <cpw@sgi.com>,
       Ingo Molnar <mingo@elte.hu>
Subject: [patch 17/22] RLIMIT_CPU: fix handling of a zero limit
Message-ID: <20060413230909.GR5613@kroah.com>
References: <20060413230141.330705000@quad.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="RLIMIT_CPU-fix-handling-of-a-zero-limit.patch"
In-Reply-To: <20060413230637.GA5613@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------

At present the kernel doesn't honour an attempt to set RLIMIT_CPU to zero
seconds.  But the spec says it should, and that's what 2.4.x does.

Fixing this for real would involve some complexity (such as adding a new
it-has-been-set flag to the task_struct, and testing that everwhere, instead
of overloading the value of it_prof_expires).

Given that a 2.4 kernel won't actually send the signal until one second has
expired anyway, let's just handle this case by treating the caller's
zero-seconds as one second.

Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Ulrich Weigand <uweigand@de.ibm.com>
Cc: Cliff Wickman <cpw@sgi.com>
Acked-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Linus Torvalds <torvalds@osdl.org>

---

 kernel/sys.c |   14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

e0661111e5441995f7a69dc4336c9f131cb9bc58
--- linux-2.6.16.5.orig/kernel/sys.c
+++ linux-2.6.16.5/kernel/sys.c
@@ -1657,7 +1657,19 @@ asmlinkage long sys_setrlimit(unsigned i
 	    (cputime_eq(current->signal->it_prof_expires, cputime_zero) ||
 	     new_rlim.rlim_cur <= cputime_to_secs(
 		     current->signal->it_prof_expires))) {
-		cputime_t cputime = secs_to_cputime(new_rlim.rlim_cur);
+		unsigned long rlim_cur = new_rlim.rlim_cur;
+		cputime_t cputime;
+
+		if (rlim_cur == 0) {
+			/*
+			 * The caller is asking for an immediate RLIMIT_CPU
+			 * expiry.  But we use the zero value to mean "it was
+			 * never set".  So let's cheat and make it one second
+			 * instead
+			 */
+			rlim_cur = 1;
+		}
+		cputime = secs_to_cputime(rlim_cur);
 		read_lock(&tasklist_lock);
 		spin_lock_irq(&current->sighand->siglock);
 		set_process_cpu_timer(current, CPUCLOCK_PROF,

--
