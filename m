Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757769AbWK2DI3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757769AbWK2DI3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 22:08:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757734AbWK2DI3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 22:08:29 -0500
Received: from rwcrmhc13.comcast.net ([216.148.227.153]:25984 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S1757545AbWK2DI2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 22:08:28 -0500
Subject: Re: [patch 2.6.19-rc6] Stop gcc 4.1.0 optimizing wait_hpet_tick
	away
From: Nicholas Miell <nmiell@comcast.net>
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <19133.1164766923@kao2.melbourne.sgi.com>
References: <19133.1164766923@kao2.melbourne.sgi.com>
Content-Type: text/plain
Date: Tue, 28 Nov 2006 19:08:25 -0800
Message-Id: <1164769705.2825.4.camel@entropy>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.0.njm.1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-11-29 at 13:22 +1100, Keith Owens wrote:
> Compiling 2.6.19-rc6 with gcc version 4.1.0 (SUSE Linux),
> wait_hpet_tick is optimized away to a never ending loop and the kernel
> hangs on boot in timer setup.
> 
> 0000001a <wait_hpet_tick>:
>   1a:   55                      push   %ebp
>   1b:   89 e5                   mov    %esp,%ebp
>   1d:   eb fe                   jmp    1d <wait_hpet_tick+0x3>
> 
> This is not a problem with gcc 3.3.5.  Adding barrier() calls to
> wait_hpet_tick does not help, making the variables volatile does.
> 
> Signed-off-by: Keith Owens <kaos@ocs.com.au>
> 
> ---
>  arch/i386/kernel/time_hpet.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Index: linux-2.6/arch/i386/kernel/time_hpet.c
> ===================================================================
> --- linux-2.6.orig/arch/i386/kernel/time_hpet.c
> +++ linux-2.6/arch/i386/kernel/time_hpet.c
> @@ -51,7 +51,7 @@ static void hpet_writel(unsigned long d,
>   */
>  static void __devinit wait_hpet_tick(void)
>  {
> -	unsigned int start_cmp_val, end_cmp_val;
> +	unsigned volatile int start_cmp_val, end_cmp_val;
>  
>  	start_cmp_val = hpet_readl(HPET_T0_CMP);
>  	do {

When you examine the inlined functions involved, this looks an awful lot
like http://gcc.gnu.org/bugzilla/show_bug.cgi?id=22278

Perhaps SUSE should fix their gcc instead of working around compiler
problems in the kernel?

-- 
Nicholas Miell <nmiell@comcast.net>

