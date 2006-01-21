Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932221AbWAUAyj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932221AbWAUAyj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 19:54:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932234AbWAUAyj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 19:54:39 -0500
Received: from smtp.osdl.org ([65.172.181.4]:61881 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932221AbWAUAyi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 19:54:38 -0500
Date: Fri, 20 Jan 2006 16:55:21 -0800
From: Andrew Morton <akpm@osdl.org>
To: Ravikiran G Thirumalai <kiran@scalex86.org>
Cc: linux-kernel@vger.kernel.org, matthew.e.tolentino@intel.com, ak@suse.de,
       shai@scalex86.org
Subject: Re: [bug] __meminit breaks cpu hotplug
Message-Id: <20060120165521.3c71542b.akpm@osdl.org>
In-Reply-To: <20060121004023.GB3573@localhost.localdomain>
References: <20060121004023.GB3573@localhost.localdomain>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ravikiran G Thirumalai <kiran@scalex86.org> wrote:
>
> Recent __meminit additions broke cpu hotplug when the kernel is configured 
> with  HOTPLUG_CPU but not HOTPLUG_MEMORY.   
> Although __meminit replaced __devinit functions many places, all those functions
> looked like they should have been marked with __cpuinit to begin with.  That
> is the reason I have changed the below to __cpuinit.  I leave it to Matt if he
> wants to use __devinit here instead. (Depending on where he sees __meminit
> would be used.)
> 
> Signed-off-by: Ravikiran Thirumalai <kiran@scalex86.org>
> Signed-off-by: Shai Fultheim <shai@scalex86.org>
> 
> Index: linux-2.6.16-rc1/include/linux/init.h
> ===================================================================
> --- linux-2.6.16-rc1.orig/include/linux/init.h	2006-01-17 14:12:16.000000000 -0800
> +++ linux-2.6.16-rc1/include/linux/init.h	2006-01-20 12:24:44.000000000 -0800
> @@ -247,10 +247,10 @@ void __init parse_early_param(void);
>  #define __memexit
>  #define __memexitdata
>  #else
> -#define __meminit	__init
> -#define __meminitdata __initdata
> -#define __memexit __exit
> -#define __memexitdata	__exitdata
> +#define __meminit	__cpuinit
> +#define __meminitdata __cpuinitdata
> +#define __memexit __cpuexit
> +#define __memexitdata	__cpuexitdata

This looks wrong.  The __meminit and __cpuinit definitions we have now are
OK, aren't they?  Surely the problem is that some functions/variables are
incorrectly tagged?

If some function is needed by both HOTPLUG_CPU and HOTPLUG_MEMORY then
we're rather messed up - I guess it'll need to be put inside #if
defined(..) || defined(..) and put into plain old .text.

