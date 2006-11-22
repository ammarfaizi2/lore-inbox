Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756726AbWKVTek@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756726AbWKVTek (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 14:34:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756723AbWKVTek
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 14:34:40 -0500
Received: from gilford.textdrive.com ([207.7.108.53]:52422 "EHLO
	gilford.textdrive.com") by vger.kernel.org with ESMTP
	id S1756726AbWKVTej (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 14:34:39 -0500
Date: Wed, 22 Nov 2006 11:34:08 -0800
From: Ira Snyder <kernel@irasnyder.com>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sparse fix: add many lock annotations
Message-Id: <20061122113408.98310698.kernel@irasnyder.com>
In-Reply-To: <20061122183306.GA4970@martell.zuzino.mipt.ru>
References: <20061122001146.95a56c72.kernel@irasnyder.com>
	<20061122183306.GA4970@martell.zuzino.mipt.ru>
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.10.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Nov 2006 21:33:07 +0300
Alexey Dobriyan <adobriyan@gmail.com> wrote:

> On Wed, Nov 22, 2006 at 12:11:46AM -0800, Ira Snyder wrote:
> > This patch adds many lock annotations to the kernel source to quiet
> > warnings from sparse. In almost every case, it quiets the warning caused
> > by locks that are intentionally grabbed in one function and released in
> > another.
> >
> > In the other cases, __acquire() and __release() are used to make sparse
> > believe that a lock was grabbed (even though it was not), in order to
> > make all exit points have equal lock counts. These follow the style in
> > kernel/sched.c.
> 
> > --- a/arch/i386/kernel/smp.c
> > +++ b/arch/i386/kernel/smp.c
> > @@ -507,11 +507,13 @@ struct call_data_struct {
> >  };
> >
> >  void lock_ipi_call_lock(void)
> > +__acquires(call_lock)
> >  {
> >  	spin_lock_irq(&call_lock);
> >  }
> >
> >  void unlock_ipi_call_lock(void)
> > +__releases(call_lock)
> >  {
> >  	spin_unlock_irq(&call_lock);
> >  }
> 
> Wrong place. Prototypes should be marked instead. How else would you
> know about:
> 
> 	lock_ipi_call_lock();
> 	if (foo)
> 		return -E;
> 	lock_ipi_call_lock();
> 
> on another compilation unit?
> 

Are you saying I should use something like this instead?:
diff --git a/include/asm-i386/smp.h b/include/asm-i386/smp.h
index bd59c15..9489602 100644
--- a/include/asm-i386/smp.h
+++ b/include/asm-i386/smp.h
@@ -38,8 +38,8 @@ extern cpumask_t cpu_core_map[];
 
 extern void (*mtrr_hook) (void);
 extern void zap_low_mappings (void);
-extern void lock_ipi_call_lock(void);
-extern void unlock_ipi_call_lock(void);
+extern void lock_ipi_call_lock(void) __acquires(call_lock);
+extern void unlock_ipi_call_lock(void) __releases(call_lock);
 
 #define MAX_APICID 256
 extern u8 x86_cpu_to_apicid[];

If so, it doesn't remove the warning from sparse, it still shows:
  CHECK
arch/i386/kernel/smp.c arch/i386/kernel/smp.c:509:6: warning: context
imbalance in 'lock_ipi_call_lock' - wrong count at exit
arch/i386/kernel/smp.c:514:6: warning: context imbalance in
'unlock_ipi_call_lock' - unexpected unlock 

Those go away with the original patch.

I was following some examples currently in the source, such as in
arch/i386/kernel/efi.c on function efi_call_phys_prelog(). Or
expand_fdtable() in fs/file.c is another good example.

> > --- a/drivers/acpi/osl.c
> > +++ b/drivers/acpi/osl.c
> > @@ -1004,6 +1004,7 @@ EXPORT_SYMBOL(max_cstate);
> >   */
> >
> >  acpi_cpu_flags acpi_os_acquire_lock(acpi_spinlock lockp)
> > +__acquires(lockp)
> >  {
> >  	acpi_cpu_flags flags;
> >  	spin_lock_irqsave(lockp, flags);
> > @@ -1015,6 +1016,7 @@ acpi_cpu_flags acpi_os_acquire_lock(acpi
> >   */
> >
> >  void acpi_os_release_lock(acpi_spinlock lockp, acpi_cpu_flags flags)
> > +__releases(lockp)
> >  {
> >  	spin_unlock_irqrestore(lockp, flags);
> >  }
> 
> Again, wrong. IMO, sparse should deduce itself that lock is grabbed in such
> trivial cases.
> 

I'm not sure that it can. See: http://lwn.net/Articles/109066/ where
Linus talks about addings __acquires(lockname) and __releases(lockname)
to functions whose purpose is to grab and hold a lock at exit.

Anyway, this is my first patch on the LKML, so I'd like to try and get
it right.

Thanks,
Ira
