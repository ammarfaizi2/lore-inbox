Return-Path: <linux-kernel-owner+w=401wt.eu-S1753435AbWLOUkX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753435AbWLOUkX (ORCPT <rfc822;w@1wt.eu>);
	Fri, 15 Dec 2006 15:40:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753437AbWLOUkX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Dec 2006 15:40:23 -0500
Received: from mx1.redhat.com ([66.187.233.31]:51739 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753435AbWLOUkW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Dec 2006 15:40:22 -0500
Subject: [RFC] make reading /proc/sys/kernel/cap-bould not require
	CAP_SYS_MODULE
From: Eric Paris <eparis@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: sds@tycho.nsa.gov, James Morris <jmorris@redhat.com>, chrisw@sous-sol.org
Content-Type: text/plain
Date: Fri, 15 Dec 2006 15:39:48 -0500
Message-Id: <1166215188.20187.22.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Reading /proc/sys/kernel/cap-bound requires CAP_SYS_MODULE.  (see
proc_dointvec_bset in kernel/sysctl.c)

sysctl appears to drive all over proc reading everything it can get it's
hands on and is complaining when it is being denied access to read
cap-bound.  Clearly writing to cap-bound should be a sensitive operation
but requiring CAP_SYS_MODULE to read cap-bound seems a bit to strong.  I
believe the information could with reasonable certainty be obtained by
looking at a bunch of the output of /proc/pid/status which has very low
security protection, so at best we are just getting a little obfuscation
of information.

Currently SELinux policy has to 'dontaudit' capability checks for
CAP_SYS_MODULE for things like sysctl which just want to read cap-bound.
In doing so we also as a by product have to hide warnings of potential
exploits such as if at some time that sysctl actually tried to load a
module.  I wondered if anyone would have a problem opening cap-bound up
to read from anyone?  Possibly with something like the patch below?

-Eric

 kernel/sysctl.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6-upstream/kernel/sysctl.c.cap.sys.module
+++ linux-2.6-upstream/kernel/sysctl.c
@@ -2020,7 +2020,7 @@ int proc_dointvec_bset(ctl_table *table,
 {
 	int op;
 
-	if (!capable(CAP_SYS_MODULE)) {
+	if (write && !capable(CAP_SYS_MODULE)) {
 		return -EPERM;
 	}
 


