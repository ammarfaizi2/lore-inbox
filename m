Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261943AbVDKV7V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261943AbVDKV7V (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 17:59:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261945AbVDKV7V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 17:59:21 -0400
Received: from ZIVLNX17.UNI-MUENSTER.DE ([128.176.188.79]:50100 "EHLO
	ZIVLNX17.uni-muenster.de") by vger.kernel.org with ESMTP
	id S261943AbVDKV7O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 17:59:14 -0400
From: Borislav Petkov <petkov@uni-muenster.de>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.12-rc2-mm3
Date: Mon, 11 Apr 2005 23:59:39 +0200
User-Agent: KMail/1.7.2
Cc: "J.A. Magallon" <jamagallon@able.es>, linux-kernel@vger.kernel.org
References: <20050411012532.58593bc1.akpm@osdl.org> <1113209793l.7664l.1l@werewolf.able.es> <20050411024322.786b83de.akpm@osdl.org>
In-Reply-To: <20050411024322.786b83de.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504112359.40487.petkov@uni-muenster.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 11 April 2005 11:43, Andrew Morton wrote:
> (Please do reply-to-all)
>
> "J.A. Magallon" <jamagallon@able.es> wrote:
> > On 04.11, Andrew Morton wrote:
> >  > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12-r
> >  >c2/2.6.12-rc2-mm3/
> >
> >  Is this not needed anymore ?
> >
> >  --- 25/arch/i386/kernel/entry.S~nmi_stack_correct-fix	2005-04-05
> > 00:02:48.000000000 -0700 +++ 25-akpm/arch/i386/kernel/entry.S	2005-04-05
> > 00:02:48.000000000 -0700
>
> Hopefully not. fix-crash-in-entrys-restore_all.patch works around the
> problem. -

Hello Andrew,
I don't know whether you remember the mysterious crashes I was telling you 
about last week and me rookiesh-ly trying to debug them with kgdb over the 
serial console. Well, today I tried for the n-th time again and after rc2-mm3 
blocked again while loading, here's what I did:

<snip>
[   12.335438] NET: Registered protocol family 17
[   12.362483] Testing NMI watchdog ... OK.
[   12.416195] Starting balanced_irq
[   12.443099] VFS: Mounted root (ext2 filesystem) readonly.
[   12.472490] Freeing unused kernel memory: 196k freed
[   12.521004] logips2pp: Detected unknown logitech mouse model 1
[   12.572581] Warning: unable to open an initial console.
[   12.972518] input: PS/2 Logitech Mouse on isa0060/serio1

Program received signal SIGTRAP, Trace/breakpoint trap.
0xc0102ee7 in resume_kernelX () at atomic.h:175 <--- this one is wrong for a 
mysterious reason
175     {
(gdb) p $eip
$1 = (void *) 0xc0102ee7

(gdb) disas 0xc0102ee7
Dump of assembler code for function resume_kernelX:
0xc0102ee7 <resume_kernelX+0>:  mov    0x30(%esp),%eax
0xc0102eeb <resume_kernelX+4>:  mov    0x38(%esp),%ah
0xc0102eef <resume_kernelX+8>:  mov    0x2c(%esp),%al
0xc0102ef3 <resume_kernelX+12>: and    $0x20403,%eax
0xc0102ef8 <resume_kernelX+17>: cmp    $0x403,%eax
0xc0102efd <resume_kernelX+22>: je     0xc0102f0c <ldt_ss>
End of assembler dump.
(gdb)  

And as we see, we're at the "mov    0x30(%esp),%eax" which accesses above the 
bottom of the stack. After applying nmi_stack_correct-fix.patch, rc2-mm3 
booted just fine, so I IMHO think that we might still be needing this, after 
all.

Regards,
Boris.
