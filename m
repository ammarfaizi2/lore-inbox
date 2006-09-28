Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161357AbWI1WuI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161357AbWI1WuI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 18:50:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161359AbWI1WuH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 18:50:07 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:59063 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1161357AbWI1WuF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 18:50:05 -0400
Subject: Re: 2.6.18-rt1
From: john stultz <johnstul@us.ibm.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: "K.R. Foley" <kr@cybsft.com>, tglx@linutronix.de,
       linux-kernel@vger.kernel.org, "Paul E. McKenney" <paulmck@us.ibm.com>,
       Dipankar Sarma <dipankar@in.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>
In-Reply-To: <1159404123.5532.3.camel@localhost>
References: <20060920141907.GA30765@elte.hu> <45118EEC.2080700@cybsft.com>
	 <20060920194958.GA24691@elte.hu> <4511A57D.9070500@cybsft.com>
	 <1158784863.5724.1027.camel@localhost.localdomain>
	 <4511A98A.4080908@cybsft.com>
	 <1158866166.12028.9.camel@localhost.localdomain>
	 <20060922115854.GA12684@elte.hu>  <1159404123.5532.3.camel@localhost>
Content-Type: text/plain
Date: Thu, 28 Sep 2006 15:48:51 -0700
Message-Id: <1159483731.25415.12.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-09-27 at 17:42 -0700, john stultz wrote:
> On Fri, 2006-09-22 at 13:58 +0200, Ingo Molnar wrote: 
> > * john stultz <johnstul@us.ibm.com> wrote:
> > 
> > > I'm seeing a similar issue. Although the log is a bit futzed. Maybe 
> > > its the sd_mod?
> > > 
> > >  at virtual address 75010000le kernel paging requestproc filesystem
> > 
> > would be nice to figure out why it crashes - unfortunately i cannot 
> > trigger it. Could it be some build tool incompatibility perhaps? Some 
> > sizing issue (some module struct gets too large)?
> 
> Been looking a bit deeper into this again:
[snip]
> c03879e8 r __ksymtab_find_next_bit
> c03879f0 r __ksymtab_find_next_zero_bit
> c03879f8 R __write_lock_failed
> c0387a18 R __read_lock_failed
> c0387a2c r __ksymtab___delay
> c0387a34 r __ksymtab___const_udelay
> c0387a3c r __ksymtab___udelay
> c0387a44 r __ksymtab___ndelay
> 
> That __read/__write_lock_failed bit looks wrong.


So it seems gcc 3.4.4 misplaces the __write_lock_failed function into
the ksymtab. It doesn't happen w/ 4.0.3. 

Anyway, this patch explicitly defines the section and fixes the issue
for me. Would the other reporters of this issue give it a whirl as well?

thanks
-john


Index: linux-rtj14/arch/i386/lib/bitops.c
===================================================================
--- linux-rtj14.orig/arch/i386/lib/bitops.c	2006-09-28 15:24:08.000000000 -0700
+++ linux-rtj14/arch/i386/lib/bitops.c	2006-09-28 15:35:29.000000000 -0700
@@ -75,6 +75,7 @@
  */
 #ifdef CONFIG_SMP
 asm(
+".section .sched.text\n"
 ".align	4\n"
 ".globl	__write_lock_failed\n"
 "__write_lock_failed:\n\t"
@@ -88,6 +89,7 @@
 );
 
 asm(
+".section .sched.text\n"
 ".align	4\n"
 ".globl	__read_lock_failed\n"
 "__read_lock_failed:\n\t"


