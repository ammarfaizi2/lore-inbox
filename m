Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261412AbUL2TIT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261412AbUL2TIT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Dec 2004 14:08:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261390AbUL2TIR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Dec 2004 14:08:17 -0500
Received: from rproxy.gmail.com ([64.233.170.197]:27077 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261412AbUL2TIA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Dec 2004 14:08:00 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=BOlpfEhZW6OozY6W8zgCR3vjQdQbdIRiCdi/mpElTT15ASteaWbFd8Jz7Ca1BzTlUL1zO+uZ9zzd87m63lhe46pqjyVEHltvIhDFPGsUzgzDvTp0sEIV4yPVUBRT+tfIJcTdmCtd1wq93LE309fqx1uM3szNh/ifv/vr/LnWOsw=
Message-ID: <2cd57c9004122911073dea0d2c@mail.gmail.com>
Date: Thu, 30 Dec 2004 03:07:59 +0800
From: Coywolf Qi Hunt <coywolf@gmail.com>
Reply-To: Coywolf Qi Hunt <coywolf@gmail.com>
To: William Lee Irwin III <wli@holomorphy.com>
Subject: [patch] fix sparc64 cpu_idle()
Cc: Oleg Nesterov <oleg@tv-sign.ru>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, James.Bottomley@hansenpartnership.com,
       paulus@samba.org, davem@davemloft.net, lethal@linux-sh.org,
       davidm@hpl.hp.com, schwidefsky@de.ibm.com, takata@inux-m32r.org,
       ak@suse.de, rth@twiddle.net, matthew@wil.cx
In-Reply-To: <20041227160848.GC771@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <41D033FE.7AD17627@tv-sign.ru>
	 <20041227160848.GC771@holomorphy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Dec 2004 08:08:48 -0800, William Lee Irwin III
<wli@holomorphy.com> wrote:
> On Mon, Dec 27, 2004 at 07:10:38PM +0300, Oleg Nesterov wrote:
> > cpu_idle() declared/defined in
> > init/main.c:                          void cpu_idle(void)
> > i386/kernel/process.c                 void cpu_idle(void)
> > i386/kernel/smpboot.c:                int  cpu_idle(void)
> > i386/mach-voyager/voyager_smp.c:      int  cpu_idle(void)
> > ppc/kernel/idle.c:                    int  cpu_idle(void)
> > ppc/kernel/smp.c:                     int  cpu_idle(void *unused)
> > ppc64/kernel/idle.c:                  int  cpu_idle(void)
> > ppc64/kernel/smp.c:                   int  cpu_idle(void *unused)
> > sparc/kernel/process.c:               int  cpu_idle(void)
> > sparc64/kernel/process.c:             int  cpu_idle(void)
> > sh/kernel/process.c:                  void cpu_idle(void *unused)
> > sh/kernel/smp.c:                      int  cpu_idle(void *unused)
> > ia64/kernel/smpboot.c:                int  cpu_idle(void)
> > ia64/kernel/process.c:                void cpu_idle(void *unused)
> 
> It's remarkable that several arches are internally inconsistent. Anyway,
> this will likely be a shoo-in, as it removes more code than it adds. The
> mess surrounding cpu_idle() has been aggravating for some time.


It's not flexible to enforce  'void cpu_idle(void)'  all over. What If
someday someone would want cpu_idle() to return value for some arch.


Currently sparch64's UP cpu_idel() returns -EPERM. This is paranoia. 

Signed-off-by: Coywolf Qi Hunt <coywolf@gmail.com>
diff -Nurp 2.6.10/arch/sparc64/kernel/process.c
2.6.10-cy/arch/sparc64/kernel/process.c
--- 2.6.10/arch/sparc64/kernel/process.c	2004-12-30 02:52:40.000000000 +0800
+++ 2.6.10-cy/arch/sparc64/kernel/process.c	2004-12-30 02:57:40.000000000 +0800
@@ -60,11 +60,8 @@ void default_idle(void)
 /*
  * the idle loop on a Sparc... ;)
  */
-int cpu_idle(void)
+void cpu_idle(void)
 {
-	if (current->pid != 0)
-		return -EPERM;
-
 	/* endless idle loop with no priority at all */
 	for (;;) {
 		/* If current->work.need_resched is zero we should really
@@ -80,7 +77,6 @@ int cpu_idle(void)
 		schedule();
 		check_pgt_cache();
 	}
-	return 0;
 }
 
 #else

-- 
Coywolf Qi Hunt
Homepage http://sosdg.org/~coywolf/
