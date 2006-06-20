Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965027AbWFTI2F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965027AbWFTI2F (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 04:28:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965026AbWFTI2F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 04:28:05 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:65508 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S965015AbWFTI2D
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 04:28:03 -0400
Date: Tue, 20 Jun 2006 03:27:45 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: "Serge E. Hallyn" <serue@us.ibm.com>, linux-kernel@vger.kernel.org,
       Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] kthread: convert stop_machine into a kthread
Message-ID: <20060620082745.GA28092@sergelap>
References: <20060615144331.GB16046@sergelap.austin.ibm.com> <20060619201450.3434f72f.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060619201450.3434f72f.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Andrew Morton (akpm@osdl.org):
> OK.  But if we're going to convert to the kthread API then stopmachine()
> really whould be switched to the more efficient kthread_bind().

Ah, like so?

Rusty, do you feel this makes the conversion less of a step backward?
If not, Andrew, as Rusty pointed out, stop_machine.c does not fall into
the set of kernel_thread users which need to be updated either for the
deprecation or to deal with pid namespaces, and perhaps my previous
patch should not be applied after all.

thanks,
-serge

From: Serge E. Hallyn <serue@us.ibm.com>
Date: Tue, 20 Jun 2006 03:17:44 -0500
Subject: [PATCH] kthread: convert stop_machine to use kthread_bind

Convert stop_machine to use the more efficient kthread_bind()
in place of set_cpus_allowed().

Signed-off-by: Serge E. Hallyn <serue@us.ibm.com>

---

 kernel/stop_machine.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

831c955bcc8572f0aea75ab608ed5da37680df4e
diff --git a/kernel/stop_machine.c b/kernel/stop_machine.c
index 2dd5a48..a462deb 100644
--- a/kernel/stop_machine.c
+++ b/kernel/stop_machine.c
@@ -31,7 +31,7 @@ static int stopmachine(void *cpu)
 	int irqs_disabled = 0;
 	int prepared = 0;
 
-	set_cpus_allowed(current, cpumask_of_cpu((int)(long)cpu));
+	kthread_bind(current, (unsigned int)(long)cpu);
 
 	/* Ack: we are alive */
 	smp_mb(); /* Theoretically the ack = 0 might not be on this CPU yet. */
-- 
1.3.3

