Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750825AbVHLE1p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750825AbVHLE1p (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 00:27:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750834AbVHLE1p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 00:27:45 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:49110 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1750825AbVHLE1o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 00:27:44 -0400
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andi Kleen <ak@suse.de>, Chris Wright <chrisw@osdl.org>,
       linux-kernel@vger.kernel.org, stable@kernel.org,
       Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, "Randy.Dunlap" <rdunlap@xenotime.net>,
       Chuck Wolber <chuckw@quantumlinux.com>, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk
Subject: [PATCH] x86_64: Fix apicid versus cpu# confusion.
References: <20050811225445.404816000@localhost.localdomain>
	<20050811225609.058881000@localhost.localdomain>
	<20050811233302.GA8974@wotan.suse.de>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Thu, 11 Aug 2005 22:26:25 -0600
In-Reply-To: <20050811233302.GA8974@wotan.suse.de> (Andi Kleen's message of
 "Fri, 12 Aug 2005 01:33:02 +0200")
Message-ID: <m1hddvwzke.fsf_-_@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok being impatient not wanting this tiny bug to be forgotten for
2.6.13.  Linus please apply this micro patch.

> >  static void __cpuinit tsc_sync_wait(void)
> >  {
> >  	if (notscsync || !cpu_has_tsc)
> >  		return;
> > - printk(KERN_INFO "CPU %d: Syncing TSC to CPU %u.\n", smp_processor_id(),
> > -			boot_cpu_id);
> > -	sync_tsc();
> > +	sync_tsc(boot_cpu_id);
>
> I actually found a bug in this today. This should be sync_tsc(0), not
> sync_tsc(boot_cpu_id)
> Can you just fix it in your tree or should I submit a new patch?
>
> -Andi

Oops.  I knew I didn't have the physical versus logical cpu identifiers right
when I generated that patch.  It's not nearly as bad as I feared at the time
though.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---

 arch/x86_64/kernel/smpboot.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

5192895f71c7eff7e1335cd9d6a775dda2bb5d52
diff --git a/arch/x86_64/kernel/smpboot.c b/arch/x86_64/kernel/smpboot.c
--- a/arch/x86_64/kernel/smpboot.c
+++ b/arch/x86_64/kernel/smpboot.c
@@ -334,7 +334,7 @@ static void __cpuinit tsc_sync_wait(void
 {
 	if (notscsync || !cpu_has_tsc)
 		return;
-	sync_tsc(boot_cpu_id);
+	sync_tsc(0);
 }
 
 static __init int notscsync_setup(char *s)
