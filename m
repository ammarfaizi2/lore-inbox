Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271817AbRHWNeb>; Thu, 23 Aug 2001 09:34:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270159AbRHWNeW>; Thu, 23 Aug 2001 09:34:22 -0400
Received: from ns.suse.de ([213.95.15.193]:34568 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S270154AbRHWNeR>;
	Thu, 23 Aug 2001 09:34:17 -0400
Date: Thu, 23 Aug 2001 15:34:19 +0200
From: Andi Kleen <ak@suse.de>
To: Paul <set@pobox.com>, Andi Kleen <ak@suse.de>,
        Brian Gerst <bgerst@didntduck.org>, linux-kernel@vger.kernel.org,
        alan@lxorguk.ukuu.org.uk, Wilfried.Weissmann@gmx.at
Subject: Re: [OOPS] repeatable 2.4.8-ac7, 2.4.7-ac6 just run xdos
Message-ID: <20010823153419.A8743@gruyere.muc.suse.de>
In-Reply-To: <20010819004703.A226@squish.home.loc.suse.lists.linux.kernel> <3B831CDF.4CC930A7@didntduck.org.suse.lists.linux.kernel> <oupn14sny4f.fsf@pigdrop.muc.suse.de> <3B839E47.874F8F64@didntduck.org> <20010822141058.A18043@gruyere.muc.suse.de> <3B83A17C.CB8ABC53@didntduck.org> <20010822152203.A18873@gruyere.muc.suse.de> <20010822155226.A228@squish.home.loc>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010822155226.A228@squish.home.loc>; from set@pobox.com on Wed, Aug 22, 2001 at 03:52:26PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 22, 2001 at 03:52:26PM -0400, Paul wrote:
> Andi Kleen <ak@suse.de>, on Wed Aug 22, 2001 [03:22:03 PM] said:
> > 
> > Here is a new patch with both checks.
> > 
> 
> 	Dear Andi;
> 
> 	Well, with this patch, the kernel doesnt oops, but vm86
> seems to be busted now. save_v86_state() pops out:
> 	'vm86: could not access userspace vm86_info'
> and gives dosemu a segv.

I found the problem in the previous patch. Here is an updated one.
Please test again. Again against -ac7 (or later if Alan hasn't applied 
the earlier patch) 


-Andi




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
+++ arch/i386/kernel/entry.S	Thu Aug 23 15:20:21 2001
@@ -291,9 +291,11 @@
 	movl $(__KERNEL_DS),%edx
 	cmpl %edx,%ecx
 	jz	1f
-	movl %edx,%ds
 	movl %edx,%es
-1:	GET_CURRENT(%ebx)
+1:	cmpl %edx,9*4(%esp)	# check ds on the stack
+	jz   2f	
+	movl %edx,%ds
+2:	GET_CURRENT(%ebx)
 	call *%edi
 	addl $8,%esp
 	jmp ret_from_exception
