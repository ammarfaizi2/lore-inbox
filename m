Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272000AbRHVNWT>; Wed, 22 Aug 2001 09:22:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272001AbRHVNWK>; Wed, 22 Aug 2001 09:22:10 -0400
Received: from ns.suse.de ([213.95.15.193]:50190 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S272000AbRHVNV7>;
	Wed, 22 Aug 2001 09:21:59 -0400
Date: Wed, 22 Aug 2001 15:22:03 +0200
From: Andi Kleen <ak@suse.de>
To: Brian Gerst <bgerst@didntduck.org>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org, set@pobox.com,
        alan@lxorguk.ukuu.org.uk, Wilfried.Weissmann@gmx.at
Subject: Re: [OOPS] repeatable 2.4.8-ac7, 2.4.7-ac6 just run xdos
Message-ID: <20010822152203.A18873@gruyere.muc.suse.de>
In-Reply-To: <20010819004703.A226@squish.home.loc.suse.lists.linux.kernel> <3B831CDF.4CC930A7@didntduck.org.suse.lists.linux.kernel> <oupn14sny4f.fsf@pigdrop.muc.suse.de> <3B839E47.874F8F64@didntduck.org> <20010822141058.A18043@gruyere.muc.suse.de> <3B83A17C.CB8ABC53@didntduck.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3B83A17C.CB8ABC53@didntduck.org>; from bgerst@didntduck.org on Wed, Aug 22, 2001 at 08:11:40AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 22, 2001 at 08:11:40AM -0400, Brian Gerst wrote:
> Andi Kleen wrote:
> > 
> > On Wed, Aug 22, 2001 at 07:57:59AM -0400, Brian Gerst wrote:
> > > Yes.  What happened here is that %ds and %es were not being updated
> > > atomically.  Under normal operation, this would just leave %es with
> > > USER_DS, which is sufficiently equivalent to KERNEL_DS to not cause a
> > > fault.  Coming out of vm86 mode however forces the data segment
> > > registers to null after saving the real mode values on the stack.  If an
> > > interrupt happened between setting %ds and %es (what are the odds?) then
> > > that assumption would fail and leave %es null, causing the next string
> > > instruction to go boom.  The same fix should be applied to entry.S as
> > > well.
> > 
> > No that's not the problem. interrupt gates come in with interrupts off,
> > so there are no other interrupts that could race here. The syscall entry
> > always updates %ds/%es unconditionally and %ds first, so there is no
> > race.
> > 
> > It was much simpler. It assumed that __KERNEL_DS could not be loaded
> > from user space because of the segment register priviledge checking; and
> > that was obviously not true from vm86 mode.
> > 
> > -Andi
> 
> The kernel was initially entered throught the general protection fault
> trap gate, with interupts on.  The syscall entry was left on the stack
> because of the way sys_vm86 works.

The GPF handler first sets %ds then %es. Interrupt checks %ds first.
I don't see any race, as soon as %ds is changed the interrupt handler does
the right thing (not reloading), and before that also.

The check I added with the previous patch for ds and es being out of 
sync however was also missing from exception handler entry. That probably
caused the crash.

Here is a new patch with both checks.


--- include/asm-i386/hw_irq.h-SEG2	Mon Aug 20 02:54:53 2001
+++ include/asm-i386/hw_irq.h	Wed Aug 22 13:02:16 2001
@@ -114,8 +114,10 @@
 	"cmpl %eax,7*4(%esp)\n\t"  \
 	"je 1f\n\t"  \
 	"movl %eax,%ds\n\t" \
+	"1: cmpl %eax,8*4(%esp)\n\t" \
+	"je 2f\n\t" \
 	"movl %eax,%es\n\t" \
-	"1:\n\t"
+	"2:\n\t"
 
 #define IRQ_NAME2(nr) nr##_interrupt(void)
 #define IRQ_NAME(nr) IRQ_NAME2(IRQ##nr)
--- arch/i386/kernel/entry.S-SEG2	Sat Aug 18 08:41:53 2001
+++ arch/i386/kernel/entry.S	Wed Aug 22 15:07:44 2001
@@ -292,8 +292,11 @@
 	cmpl %edx,%ecx
 	jz	1f
 	movl %edx,%ds
+1:	movl %ds,%ecx
+	cmpl $(__KERNEL_DS),%edx
+	jz   2f	
 	movl %edx,%es
-1:	GET_CURRENT(%ebx)
+2:	GET_CURRENT(%ebx)
 	call *%edi
 	addl $8,%esp
 	jmp ret_from_exception


-Andi
