Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269466AbSIRWzU>; Wed, 18 Sep 2002 18:55:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269468AbSIRWzU>; Wed, 18 Sep 2002 18:55:20 -0400
Received: from air-2.osdl.org ([65.172.181.6]:6528 "EHLO cherise.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S269466AbSIRWzS>;
	Wed, 18 Sep 2002 18:55:18 -0400
Date: Wed, 18 Sep 2002 16:01:53 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise.pdx.osdl.net
To: Stuart MacDonald <stuartm@connecttech.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: linux-2.5.36 Oops on power-down
In-Reply-To: <058401c25f61$25245640$294b82ce@connecttech.com>
Message-ID: <Pine.LNX.4.44.0209181558440.968-100000@cherise.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Unable to handle kernel NULL pointer dereference at virtual address 00000000
> 00000000
> *pde = 00000000
> Oops: 0000
> CPU:    0
> EIP:    0060: [<00000000>]    Not tainted
> Using defaults from ksymoops -t elf32-i386 -a i386
> EFLAGS: 00010246
> eax: c034f808   ebx: 00000008   ecx: c034f4e0   edx: c034f4e0
> esi: c11978a0   edi: c11ed800   ebp: c034f808   esp: c362be68
> ds: 0068   es: 0068   ss: 0068
> Stack: c019b8bd c11ed800 c034f808 00000000 c11ed850 c11ed850 c11ed450
> bffffd18
>        c0194db9 c11ed800 c11ed850 c019fc7d c11ed850 01234567 c362a000
> fee1dead
>        c01228fb c03d7128 00000001 00000000 c139da80 00000000 00000000
> c222f464
> Call Trace: [<c019b8bd>] [<c0194db9>] [<c019fc7d>] [<c01228fb>] [<c01515ae>]
>    [<c01513e2>] [<c014fb6c>] [<c013d91d>] [<c013bee9>] [<c013bf5d>]
> [<c0107493>]
> Code: Bad EIP value.
> 
> >>EIP; 00000000 Before first symbol
> Trace; c019b8bd <pci_remove_one+3d/60>
> Trace; c0194db9 <pci_device_remove+19/30>
> Trace; c019fc7d <device_shutdown+4d/7e>
> Trace; c01228fb <sys_reboot+fb/280>
> Trace; c01515ae <clear_inode+e/b0>
> Trace; c01513e2 <destroy_inode+32/50>
> Trace; c014fb6c <dput+1c/160>
> Trace; c013d91d <__fput+bd/e0>
> Trace; c013bee9 <filp_close+99/b0>
> Trace; c013bf5d <sys_close+5d/70>
> Trace; c0107493 <syscall_call+7/b>

It appears that the 8250_pci serial driver needs a check for NULL when 
calling the device's re-init function. Could you try the attached patch 
and let us know if it works for you? 

Thanks,

	-pat

===== drivers/serial/8250_pci.c 1.8 vs edited =====
--- 1.8/drivers/serial/8250_pci.c	Mon Jul 29 07:52:41 2002
+++ edited/drivers/serial/8250_pci.c	Wed Sep 18 15:51:32 2002
@@ -771,7 +771,8 @@
 		for (i = 0; i < priv->nr; i++)
 			unregister_serial(priv->line[i]);
 
-		priv->board->init_fn(dev, priv->board, 0);
+		if (priv->board->init_fn)
+			priv->board->init_fn(dev, priv->board, 0);
 
 		pci_disable_device(dev);
 

