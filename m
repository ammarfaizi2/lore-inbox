Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261625AbSJFOWF>; Sun, 6 Oct 2002 10:22:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261631AbSJFOWF>; Sun, 6 Oct 2002 10:22:05 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:37902 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S261625AbSJFOWE>;
	Sun, 6 Oct 2002 10:22:04 -0400
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Meelis Roos <mroos@linux.ee>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.20-pre9: oopses on PPC 
In-reply-to: Your message of "Sat, 05 Oct 2002 19:14:28 +0300."
             <Pine.GSO.4.44.0210051905030.20309-100000@math.ut.ee> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 07 Oct 2002 00:27:30 +1000
Message-ID: <31034.1033914450@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 5 Oct 2002 19:14:28 +0300 (EEST), 
Meelis Roos <mroos@linux.ee> wrote:
>Looks like PPC oops output does not contain code, so ksymoops complains.
>No idea though why it complains about sunrpc symbols.

Thanks to Meelis Roos for diagnostics off list.

>Warning (compare_maps): mismatch on symbol xchg_u32  , ksyms_base says c000b88c, System.map says c0006424.

Two functions called xchg_u32, one static, one global.  ksyms contains
c000b88c, System.map contains both c0006424 (arch/ppc/kernel/misc.S,
global) and c000b88c (include/asm-ppc/system.h, static).  Just to
confuse things even more, it is the static version that is exported to
modules.

Kernel coding error, having two functions with the same name but
different scope is just asking for trouble.  Fix the ppc code.

>Warning (compare_maps): mismatch on symbol nlmsvc_ops
>Warning (compare_maps): mismatch on symbol nfs_debug
>Warning (compare_maps): mismatch on symbol nfsd_debug
>Warning (compare_maps): mismatch on symbol nlm_debug
>Warning (compare_maps): mismatch on symbol rpc_debug
>Warning (compare_maps): mismatch on symbol packet_socks_nr
>Warning (compare_maps): mismatch on symbol usb_devfs_handle

Exported symbols that are in sbss, rather than bss.  Neither modutils
nor ksymoops handle sbss, they only handle bss.  I will do new versions
of both packages to handle sbss.

