Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277094AbRJHT3c>; Mon, 8 Oct 2001 15:29:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277093AbRJHT3V>; Mon, 8 Oct 2001 15:29:21 -0400
Received: from zmamail03.zma.compaq.com ([161.114.64.103]:35343 "EHLO
	zmamail03.zma.compaq.com") by vger.kernel.org with ESMTP
	id <S277094AbRJHT3K>; Mon, 8 Oct 2001 15:29:10 -0400
Message-ID: <3BC1FE35.2050704@zk3.dec.com>
Date: Mon, 08 Oct 2001 15:27:49 -0400
From: Peter Rival <frival@zk3.dec.com>
Organization: Tru64 QMG Performance Engineering
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20010913
X-Accept-Language: en-us
MIME-Version: 1.0
To: paulus@samba.org
Cc: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org, jay.estabrook@compaq.com,
        rth@twiddle.net
Subject: Re: [PATCH] change name of rep_nop
In-Reply-To: <15294.16913.2117.383987@cargo.ozlabs.ibm.com>	<1573466920.1002300846@mbligh.des.sequent.com> <15294.24873.866942.423260@cargo.ozlabs.ibm.com>
Content-Type: multipart/mixed;
 boundary="------------000807050807010901080406"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000807050807010901080406
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Paul Mackerras wrote:
<snip>

> 
> There is a race on PPC with your patch, but I can fix that by removing
> the init_idle() call from smp_callin() in arch/ppc/kernel/smp.c.
> At a quick glance it looks like alpha and sparc (sun4m) may have the
> same problem since they also call init_idle before waiting for
> smp_commence() (or smp_threads_ready != 0).


Okay, I'm attaching a patch to fix the issue on Alpha.  I've tested it 
on both a Wildfire and a Tincup (Rawhide); without the patch both hang 
due to the above race, while with it both boot just fine.  Linus, Alan - 
please apply, unless Jay or Richard come screaming with their hair on 
fire. ;)

  - Pete


--------------000807050807010901080406
Content-Type: text/plain;
 name="alpha_patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="alpha_patch"

diff -urN linux-2.4.11-pre5/arch/alpha/kernel/smp.c linux-2.4.11-pre5+fix/arch/alpha/kernel/smp.c
--- linux-2.4.11-pre5/arch/alpha/kernel/smp.c	Mon Oct  8 13:37:57 2001
+++ linux-2.4.11-pre5+fix/arch/alpha/kernel/smp.c	Mon Oct  8 14:17:50 2001
@@ -171,13 +171,6 @@
 	/* Set interrupt vector.  */
 	wrent(entInt, 0);
 
-	/* Setup the scheduler for this processor.  */
-	init_idle();
-
-	/* ??? This should be in init_idle.  */
-	atomic_inc(&init_mm.mm_count);
-	current->active_mm = &init_mm;
-
 	/* Get our local ticker going. */
 	smp_setup_percpu_timer(cpuid);
 
@@ -207,6 +200,12 @@
 	DBGS(("smp_callin: commencing CPU %d current %p\n",
 	      cpuid, current));
 
+	/* Setup the scheduler for this processor.  */
+	init_idle();
+
+	/* ??? This should be in init_idle.  */
+	atomic_inc(&init_mm.mm_count);
+	current->active_mm = &init_mm;
 	/* Do nothing.  */
 	cpu_idle();
 }

--------------000807050807010901080406--

