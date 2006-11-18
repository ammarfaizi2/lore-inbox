Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756102AbWKRA1g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756102AbWKRA1g (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 19:27:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756104AbWKRA1g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 19:27:36 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:22150 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1756102AbWKRA1g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 19:27:36 -0500
Date: Sat, 18 Nov 2006 01:27:10 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Vivek Goyal <vgoyal@in.ibm.com>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Reloc Kernel List <fastboot@lists.osdl.org>, ebiederm@xmission.com,
       akpm@osdl.org, ak@suse.de, hpa@zytor.com, magnus.damm@gmail.com,
       lwang@redhat.com, dzickus@redhat.com, rjw@sisk.pl
Subject: Re: [PATCH 9/20] x86_64: 64bit PIC SMP trampoline
Message-ID: <20061118002710.GF9188@elf.ucw.cz>
References: <20061117223432.GA15449@in.ibm.com> <20061117224535.GJ15449@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061117224535.GJ15449@in.ibm.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> that long mode is supported.  Asking if long mode is implemented is
> down right silly but we have traditionally had some of these checks,
> and they can't hurt anything.  So when the totally ludicrous happens
> we just might handle it correctly.

Well, it is silly, and it is 50 lines of dense assembly. can we get
rid of it or get it shared with bootup version?

The REQUIRED_MASK1/2 look like something that could get out of sync,
for example.

The rest of patch looks okay.

(The traditional checks were unneeded, so it is okay to drop them...)

								Pavel

> +	.code16
> +verify_cpu:
> +	pushl	$0			# Kill any dangerous flags
> +	popfl
> +
> +	/* minimum CPUID flags for x86-64 */
> +	/* see http://www.x86-64.org/lists/discuss/msg02971.html */
> +#define REQUIRED_MASK1 ((1<<0)|(1<<3)|(1<<4)|(1<<5)|(1<<6)|(1<<8)|\
> +			   (1<<13)|(1<<15)|(1<<24)|(1<<25)|(1<<26))
> +#define REQUIRED_MASK2 (1<<29)
> +
> +	pushfl				# check for cpuid
> +	popl	%eax
> +	movl	%eax, %ebx
> +	xorl	$0x200000,%eax
> +	pushl	%eax
> +	popfl
> +	pushfl
> +	popl	%eax
> +	pushl	%ebx
> +	popfl
> +	cmpl	%eax, %ebx
> +	jz	no_longmode
> +
> +	xorl	%eax, %eax		# See if cpuid 1 is implemented
> +	cpuid
> +	cmpl	$0x1, %eax
> +	jb	no_longmode
> +
> +	movl	$0x01, %eax		# Does the cpu have what it takes?
> +	cpuid
> +	andl	$REQUIRED_MASK1, %edx
> +	xorl	$REQUIRED_MASK1, %edx
> +	jnz	no_longmode
> +
> +	movl	$0x80000000, %eax	# See if extended cpuid is implemented
> +	cpuid
> +	cmpl	$0x80000001, %eax
> +	jb	no_longmode
> +
> +	movl	$0x80000001, %eax	# Does the cpu have what it takes?
> +	cpuid
> +	andl	$REQUIRED_MASK2, %edx
> +	xorl	$REQUIRED_MASK2, %edx
> +	jnz	no_longmode
> +
> +	ret				# The cpu supports long mode
> +
> +no_longmode:
> +	hlt
> +	jmp no_longmode
> +

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
