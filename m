Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030310AbWGJORY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030310AbWGJORY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 10:17:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030389AbWGJORY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 10:17:24 -0400
Received: from stat9.steeleye.com ([209.192.50.41]:23702 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S1030310AbWGJORY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 10:17:24 -0400
Subject: Re: [PATCH 1/3] stack overflow safe kdump (2.6.18-rc1-i386) -
	safe_smp_processor_id
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Fernando Luis =?ISO-8859-1?Q?V=E1zquez?= Cao 
	<fernando@oss.ntt.co.jp>
Cc: vgoyal@in.ibm.com, "Eric W. Biederman" <ebiederm@xmission.com>,
       akpm@osdl.org, ak@suse.de, linux-kernel@vger.kernel.org,
       fastboot@lists.osdl.org
In-Reply-To: <1152517852.2120.107.camel@localhost.localdomain>
References: <1152517852.2120.107.camel@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Date: Mon, 10 Jul 2006 09:16:28 -0500
Message-Id: <1152540988.7275.7.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-07-10 at 16:50 +0900, Fernando Luis Vázquez Cao wrote:
> diff -urNp linux-2.6.18-rc1/include/asm-i386/smp.h
> linux-2.6.18-rc1-sof/include/asm-i386/smp.h
> --- linux-2.6.18-rc1/include/asm-i386/smp.h     2006-07-10
> 11:00:05.000000000 +0900
> +++ linux-2.6.18-rc1-sof/include/asm-i386/smp.h 2006-07-10
> 15:34:26.000000000 +0900
> @@ -89,12 +89,20 @@ static __inline int logical_smp_processo
>  
>  #endif
>  
> +#ifdef CONFIG_X86_VOYAGER
> +extern int hard_smp_processor_id(void);
> +#define safe_smp_processor_id() hard_smp_processor_id()
> +#else
> +extern int safe_smp_processor_id(void);
> +#endif
> +

Argh, no, don't do this.  The Subarchitecture specific code should never
appear in the standard include directory (that was about the whole
point).  The extern for hard_smp_processor_id should just be global,
since it's common to all architectures, and the voyager specific define
should be in a voyager specific header file.

As an aside, it shows the problems x86 got itself into with it's
inconsistent direction of physical vs logical CPUs.  The idea was that
smp_processor_id() and hard_smp_processor_id() were supposed to return
the same thing, only hard_... went to the actual SMP registers to get
it.

James


