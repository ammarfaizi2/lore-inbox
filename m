Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262909AbUEBBQx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262909AbUEBBQx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 May 2004 21:16:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262910AbUEBBQx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 May 2004 21:16:53 -0400
Received: from ozlabs.org ([203.10.76.45]:58552 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262909AbUEBBQw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 May 2004 21:16:52 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16532.19426.521556.52852@cargo.ozlabs.ibm.com>
Date: Sun, 2 May 2004 11:16:18 +1000
From: Paul Mackerras <paulus@samba.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>, bunk@fs.tum.de, eyal@eyal.emu.id.au,
       linux-dvb-maintainer@linuxtv.org, linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-rc3: modular DVB tda1004x broken
In-Reply-To: <20040501175134.243b389c.akpm@osdl.org>
References: <Pine.LNX.4.58.0404271858290.10799@ppc970.osdl.org>
	<408F9BD8.8000203@eyal.emu.id.au>
	<20040501201342.GL2541@fs.tum.de>
	<Pine.LNX.4.58.0405011536300.18014@ppc970.osdl.org>
	<20040501161035.67205a1f.akpm@osdl.org>
	<Pine.LNX.4.58.0405011653560.18014@ppc970.osdl.org>
	<20040501175134.243b389c.akpm@osdl.org>
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton writes:

> diff -puN include/asm-ppc64/unistd.h~kernel-syscalls-retval-fix include/asm-ppc64/unistd.h
> --- 25/include/asm-ppc64/unistd.h~kernel-syscalls-retval-fix	2004-05-01 17:06:01.187628160 -0700
> +++ 25-akpm/include/asm-ppc64/unistd.h	2004-05-01 17:21:43.897314504 -0700
> @@ -286,6 +286,17 @@
>  
>  #ifndef __ASSEMBLY__
>  
> +#ifdef __KERNEL__
> +#define __syscall_return	/* */

For ppc and ppc64 a syscall that returns an error puts the positive
error number in r3 and sets the SO bit in CR0.  So if we are expecting
the negative error number as the return value for syscalls in the
kernel we will need this instead:

#define __syscall_return		\
	if (__sc_err & 0x10000000)	\
		__sc_ret = - __sc_ret;

for the #ifdef __KERNEL__ case for both ppc and ppc64.

Thanks,
Paul.
