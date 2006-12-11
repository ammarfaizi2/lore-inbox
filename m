Return-Path: <linux-kernel-owner+w=401wt.eu-S1763006AbWLKS3L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763006AbWLKS3L (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 13:29:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763005AbWLKS3L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 13:29:11 -0500
Received: from MAIL.13thfloor.at ([213.145.232.33]:46314 "EHLO
	MAIL.13thfloor.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763007AbWLKS3J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 13:29:09 -0500
Date: Mon, 11 Dec 2006 19:29:08 +0100
From: Herbert Poetzl <herbert@13thfloor.at>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Olaf Hering <olaf@aepfle.de>, Andy Whitcroft <apw@shadowen.org>,
       Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Steve Fox <drfickle@us.ibm.com>
Subject: Re: 2.6.19-git13: uts banner changes break SLES9 (at least)
Message-ID: <20061211182908.GC7256@MAIL.13thfloor.at>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Olaf Hering <olaf@aepfle.de>, Andy Whitcroft <apw@shadowen.org>,
	Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, Steve Fox <drfickle@us.ibm.com>
References: <457D750C.9060807@shadowen.org> <20061211163333.GA17947@aepfle.de> <Pine.LNX.4.64.0612110840240.12500@woody.osdl.org> <Pine.LNX.4.64.0612110852010.12500@woody.osdl.org> <20061211180414.GA18833@aepfle.de> <20061211181813.GB18963@aepfle.de> <Pine.LNX.4.64.0612111022140.12500@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0612111022140.12500@woody.osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 11, 2006 at 10:26:13AM -0800, Linus Torvalds wrote:
> 
> 
> On Mon, 11 Dec 2006, Olaf Hering wrote:
> > 
> > Hmm, even moving this to linux_banner doesnt work, just because
> > __initdata is in a different section.
> 
> Heh. Let's just change the "version_read_proc" string to not trigger.
> 
> Something like this instead (which replaces the "Linux" with "%s" in 
> /proc, and just takes it from "utsname()->sysname" instead. So now you can 
> lie and call yourself "OS X" in your virtual partition if you want to ;)

cool!

should definitely work for all 'known' cases

thanks,
Herbert

> 		Linus
> 
> diff --git a/fs/proc/proc_misc.c b/fs/proc/proc_misc.c
> index dc3e580..92ea774 100644
> --- a/fs/proc/proc_misc.c
> +++ b/fs/proc/proc_misc.c
> @@ -47,6 +47,7 @@
>  #include <linux/vmalloc.h>
>  #include <linux/crash_dump.h>
>  #include <linux/pid_namespace.h>
> +#include <linux/compile.h>
>  #include <asm/uaccess.h>
>  #include <asm/pgtable.h>
>  #include <asm/io.h>
> @@ -253,8 +254,15 @@ static int version_read_proc(char *page, char **start, off_t off,
>  {
>  	int len;
>  
> -	len = sprintf(page, linux_banner,
> -		utsname()->release, utsname()->version);
> +	/* FIXED STRING! Don't touch! */
> +	len = snprintf(page, PAGE_SIZE,
> +		"%s version %s"
> +		" (" LINUX_COMPILE_BY "@" LINUX_COMPILE_HOST ")"
> +		" (" LINUX_COMPILER ")"
> +		" %s\n",
> +		utsname()->sysname,
> +		utsname()->release,
> +		utsname()->version);
>  	return proc_calc_metrics(page, start, off, count, eof, len);
>  }
>  
> diff --git a/include/linux/kernel.h b/include/linux/kernel.h
> index e8bfac3..b0c4a05 100644
> --- a/include/linux/kernel.h
> +++ b/include/linux/kernel.h
> @@ -17,8 +17,6 @@
>  #include <asm/byteorder.h>
>  #include <asm/bug.h>
>  
> -extern const char linux_banner[];
> -
>  #define INT_MAX		((int)(~0U>>1))
>  #define INT_MIN		(-INT_MAX - 1)
>  #define UINT_MAX	(~0U)
> diff --git a/init/main.c b/init/main.c
> index 036f97c..c783695 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -483,6 +483,12 @@ void __init __attribute__((weak)) smp_setup_processor_id(void)
>  {
>  }
>  
> +static char __initdata linux_banner[] =
> +	"Linux version " UTS_RELEASE
> +	" (" LINUX_COMPILE_BY "@" LINUX_COMPILE_HOST ")"
> +	" (" LINUX_COMPILER ")"
> +	" " UTS_VERSION "\n";
> +
>  asmlinkage void __init start_kernel(void)
>  {
>  	char * command_line;
> @@ -509,7 +515,7 @@ asmlinkage void __init start_kernel(void)
>  	boot_cpu_init();
>  	page_address_init();
>  	printk(KERN_NOTICE);
> -	printk(linux_banner, UTS_RELEASE, UTS_VERSION);
> +	printk(linux_banner);
>  	setup_arch(&command_line);
>  	unwind_setup();
>  	setup_per_cpu_areas();
> diff --git a/init/version.c b/init/version.c
> index 2a5dfcd..9d96d36 100644
> --- a/init/version.c
> +++ b/init/version.c
> @@ -33,8 +33,3 @@ struct uts_namespace init_uts_ns = {
>  	},
>  };
>  EXPORT_SYMBOL_GPL(init_uts_ns);
> -
> -const char linux_banner[] =
> -	"Linux version %s (" LINUX_COMPILE_BY "@"
> -	LINUX_COMPILE_HOST ") (" LINUX_COMPILER ") %s\n";
> -
