Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751156AbVJ2OSE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751156AbVJ2OSE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Oct 2005 10:18:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751159AbVJ2OSE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Oct 2005 10:18:04 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:6152 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751156AbVJ2OSD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Oct 2005 10:18:03 -0400
Date: Sat, 29 Oct 2005 15:17:57 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Michal Srajer <michal@mat.uni.torun.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] include/linux/etherdevice.h, kernel 2.6.14
Message-ID: <20051029141757.GA14039@flint.arm.linux.org.uk>
Mail-Followup-To: Michal Srajer <michal@mat.uni.torun.pl>,
	linux-kernel@vger.kernel.org
References: <20051029141046.GA17715@ultra60.mat.uni.torun.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051029141046.GA17715@ultra60.mat.uni.torun.pl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 29, 2005 at 04:10:46PM +0200, Michal Srajer wrote:
> Description: Very small optimization patch for include/linux/etherdevice.h in 2.6.14 kernel.

How is this an optimisation?

typedef unsigned char u8;
 
static int is_zero_ether_addr1(const u8 *addr)
{
       return !(addr[0] | addr[1] | addr[2] | addr[3] | addr[4] | addr[5]);
}
 
static int is_zero_ether_addr2(const u8 *addr)
{
       return !(addr[0] || addr[1] || addr[2] || addr[3] || addr[4] || addr[5]);
}

produces on x86:

is_zero_ether_addr1:
        pushl   %ebp
        movl    %esp, %ebp
        movl    8(%ebp), %edx
        movb    1(%edx), %al
        orb     (%edx), %al
        orb     2(%edx), %al
        orb     3(%edx), %al
        orb     4(%edx), %al
        orb     5(%edx), %al
        sete    %al
        movzbl  %al, %eax
        leave
        ret

is_zero_ether_addr2:
        pushl   %ebp
        movl    %esp, %ebp
        movl    8(%ebp), %edx
        xorl    %eax, %eax
        cmpb    $0, (%edx)
        jne     .L3
        cmpb    $0, 1(%edx)
        jne     .L3
        cmpb    $0, 2(%edx)
        jne     .L3
        cmpb    $0, 3(%edx)
        jne     .L3
        cmpb    $0, 4(%edx)
        jne     .L3
        cmpb    $0, 5(%edx)
        jne     .L3
        movl    $1, %eax
.L3:
        leave
        ret

and on ARM:

is_zero_ether_addr1:
        ldrb    r1, [r0, #1]    @ zero_extendqisi2
        ldrb    r3, [r0, #0]    @ zero_extendqisi2
        ldrb    r2, [r0, #2]    @ zero_extendqisi2
        orr     r3, r3, r1
        ldrb    r1, [r0, #3]    @ zero_extendqisi2
        orr     r2, r2, r3
        ldrb    r3, [r0, #4]    @ zero_extendqisi2
        orr     r1, r1, r2
        ldrb    r2, [r0, #5]    @ zero_extendqisi2
        orr     r3, r3, r1
        orrs    r2, r2, r3
        movne   r0, #0
        moveq   r0, #1
        mov     pc, lr

is_zero_ether_addr2:
        ldrb    r3, [r0, #0]    @ zero_extendqisi2
        mov     r2, #0
        cmp     r3, r2
        bne     .L3
        ldrb    r3, [r0, #1]    @ zero_extendqisi2
        cmp     r3, r2
        bne     .L3
        ldrb    r3, [r0, #2]    @ zero_extendqisi2
        cmp     r3, r2
        bne     .L3
        ldrb    r3, [r0, #3]    @ zero_extendqisi2
        cmp     r3, r2
        bne     .L3
        ldrb    r3, [r0, #4]    @ zero_extendqisi2
        cmp     r3, r2
        bne     .L3
        ldrb    r3, [r0, #5]    @ zero_extendqisi2
        cmp     r3, r2
        movne   r2, #0
        moveq   r2, #1
.L3:
        mov     r0, r2
        mov     pc, lr

The former looks far more optimised in both cases.  In fact, the
latter on ARM is many times less efficient due to the LDR result
delays being incurred for every test.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
