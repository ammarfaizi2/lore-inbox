Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262178AbSJFUas>; Sun, 6 Oct 2002 16:30:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262181AbSJFUas>; Sun, 6 Oct 2002 16:30:48 -0400
Received: from daimi.au.dk ([130.225.16.1]:54193 "EHLO daimi.au.dk")
	by vger.kernel.org with ESMTP id <S262178AbSJFUar>;
	Sun, 6 Oct 2002 16:30:47 -0400
Message-ID: <3DA09EBE.D9E2E148@daimi.au.dk>
Date: Sun, 06 Oct 2002 22:36:14 +0200
From: Kasper Dupont <kasperd@daimi.au.dk>
Organization: daimi.au.dk
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.18-10smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Robert Love <rml@tech9.net>
CC: marcelo@conectiva.com.br, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4: introduce get_cpu() and put_cpu()
References: <1033933547.743.4472.camel@phantasy>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Love wrote:
> 
> diff -urN linux-2.4.20-pre9/arch/i386/kernel/ioport.c linux/arch/i386/kernel/ioport.c
> --- linux-2.4.20-pre9/arch/i386/kernel/ioport.c 2002-10-06 14:58:01.000000000 -0400
> +++ linux/arch/i386/kernel/ioport.c     2002-10-06 15:21:04.000000000 -0400
> @@ -55,12 +55,15 @@
>  asmlinkage int sys_ioperm(unsigned long from, unsigned long num, int turn_on)
>  {
>         struct thread_struct * t = &current->thread;
> -       struct tss_struct * tss = init_tss + smp_processor_id();
> +       struct tss_struct * tss;
> 
>         if ((from + num <= from) || (from + num > IO_BITMAP_SIZE*32))
>                 return -EINVAL;
>         if (turn_on && !capable(CAP_SYS_RAWIO))
>                 return -EPERM;
> +
> +       tss = init_tss + get_cpu();
> +
>         /*
>          * If it's the first ioperm() call in this thread's lifetime, set the
>          * IO bitmap up. ioperm() is much less timing critical than clone(),

To me it really looks like you are missing a put_cpu() call somewhere.
I know it is a no-op, but since you intend to show how to use it, I
it really ought to be there.

Does this look right?

diff -Nur linux.old/arch/i386/kernel/ioport.c linux.new/arch/i386/kernel/ioport.c
--- linux.old/arch/i386/kernel/ioport.c	Sun Oct  6 22:33:22 2002
+++ linux.new/arch/i386/kernel/ioport.c	Sun Oct  6 22:33:53 2002
@@ -87,6 +87,8 @@
 	set_bitmap(t->io_bitmap, from, num, !turn_on);
 	set_bitmap(tss->io_bitmap, from, num, !turn_on);
 
+	put_cpu();
+
 	return 0;
 }
 

-- 
Kasper Dupont -- der bruger for meget tid på usenet.
For sending spam use mailto:aaarep@daimi.au.dk
or mailto:mcxumhvenwblvtl@skrammel.yaboo.dk
