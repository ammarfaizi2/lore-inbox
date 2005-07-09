Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261167AbVGILH2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261167AbVGILH2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Jul 2005 07:07:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261178AbVGILH2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Jul 2005 07:07:28 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:62986 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261167AbVGILHZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Jul 2005 07:07:25 -0400
Date: Sat, 9 Jul 2005 12:07:03 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: blaisorblade@yahoo.it
Cc: akpm@osdl.org, jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [patch 1/1] uml: fix lvalue for gcc4
Message-ID: <20050709120703.C2175@flint.arm.linux.org.uk>
Mail-Followup-To: blaisorblade@yahoo.it, akpm@osdl.org, jdike@addtoit.com,
	linux-kernel@vger.kernel.org,
	user-mode-linux-devel@lists.sourceforge.net
References: <20050709110143.D59181E9EA4@zion.home.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050709110143.D59181E9EA4@zion.home.lan>; from blaisorblade@yahoo.it on Sat, Jul 09, 2005 at 01:01:33PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 09, 2005 at 01:01:33PM +0200, blaisorblade@yahoo.it wrote:
> diff -puN arch/um/sys-x86_64/signal.c~uml-fix-for-gcc4-lvalue arch/um/sys-x86_64/signal.c
> --- linux-2.6.git/arch/um/sys-x86_64/signal.c~uml-fix-for-gcc4-lvalue	2005-07-09 13:01:03.000000000 +0200
> +++ linux-2.6.git-paolo/arch/um/sys-x86_64/signal.c	2005-07-09 13:01:03.000000000 +0200
> @@ -168,7 +168,7 @@ int setup_signal_stack_si(unsigned long 
>  
>  	frame = (struct rt_sigframe __user *)
>  		round_down(stack_top - sizeof(struct rt_sigframe), 16) - 8;
> -	((unsigned char *) frame) -= 128;
> +	frame -= 128 / sizeof(frame);

Are you sure these two are identical?

The above code fragment looks suspicious anyway, particularly:

 	frame = (struct rt_sigframe __user *)
 		round_down(stack_top - sizeof(struct rt_sigframe), 16) - 8;

which will put the frame at 8 * sizeof(struct rt_sigframe) below
the point which round_down() would return (which would be 1 struct
rt_sigframe below stack_top, rounded down).

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
