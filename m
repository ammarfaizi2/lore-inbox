Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271566AbTGQViO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 17:38:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271574AbTGQVhA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 17:37:00 -0400
Received: from pirx.hexapodia.org ([208.42.114.113]:65335 "EHLO
	pirx.hexapodia.org") by vger.kernel.org with ESMTP id S271566AbTGQVgp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 17:36:45 -0400
Date: Thu, 17 Jul 2003 16:51:39 -0500
From: Andy Isaacson <adi@hexapodia.org>
To: linux-kernel@vger.kernel.org
Subject: typecast bug in sched.c bites reschedule_idle on alpha
Message-ID: <20030717165139.B12164@hexapodia.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-PGP-Fingerprint: 48 01 21 E2 D4 E4 68 D1  B8 DF 39 B2 AF A3 16 B9
X-PGP-Key-URL: http://web.hexapodia.org/~adi/pgp.txt
X-Domestic-Surveillance: money launder bomb tax evasion
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On SMP Alpha, a saturated system (with one busy userland process per
CPU) becomes almost completely unusable.  The busy loops don't have to
be doing anything more complicated than "while(1) ;".  The symptom is
that even logging into the system (with ssh) takes on the order of 30
seconds.  (Tested on an ES40 with 4 processors, 2.4.18.)

It turns out that the problem is in kernel/schedule.c:reschedule_idle.

        cycles_t oldest_idle;
...
        oldest_idle = (cycles_t) -1;
...
                        if (oldest_idle == -1ULL) {

Since asm-alpha/timex.h defines cycles_t as unsigned int, this
comparison is always false.  Changing it to (cycles_t)-1 fixes the
problem.

Patch below.  I'd like this to go into 2.4.22, if nobody has a problem
with that.  I would like confirmation from other eyes -- this patch
doesn't break semantics on any architecture, does it?

-andy

--- linux-2.4.21/kernel/sched.c	Thu Jul 17 16:43:37 2003
+++ linux-2.4.21-idle-fix/kernel/sched.c	Thu Jul 17 16:23:25 2003
@@ -282,7 +282,7 @@
 				target_tsk = tsk;
 			}
 		} else {
-			if (oldest_idle == -1ULL) {
+			if (oldest_idle == (cycles_t)-1) {
 				int prio = preemption_goodness(tsk, p, cpu);
 
 				if (prio > max_prio) {
@@ -294,7 +294,7 @@
 	}
 	tsk = target_tsk;
 	if (tsk) {
-		if (oldest_idle != -1ULL) {
+		if (oldest_idle != (cycles_t)-1) {
 			best_cpu = tsk->processor;
 			goto send_now_idle;
 		}
