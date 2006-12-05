Return-Path: <linux-kernel-owner+willy=40w.ods.org-S968475AbWLERYN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968475AbWLERYN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 12:24:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968486AbWLERYN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 12:24:13 -0500
Received: from MAIL.13thfloor.at ([213.145.232.33]:41114 "EHLO
	MAIL.13thfloor.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S968475AbWLERYL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 12:24:11 -0500
Date: Tue, 5 Dec 2006 18:24:09 +0100
From: Herbert Poetzl <herbert@13thfloor.at>
To: "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@osdl.org>,
       Linux Containers <containers@lists.osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix linux banner utsname information
Message-ID: <20061205172407.GA15450@MAIL.13thfloor.at>
Mail-Followup-To: "Eric W. Biederman" <ebiederm@xmission.com>,
	Andrew Morton <akpm@osdl.org>,
	Linux Containers <containers@lists.osdl.org>,
	linux-kernel@vger.kernel.org
References: <m1hcwlmqmp.fsf@ebiederm.dsl.xmission.com> <20061127202211.GB26108@MAIL.13thfloor.at> <m1y7pwldi4.fsf@ebiederm.dsl.xmission.com> <20061128143250.GA23131@MAIL.13thfloor.at> <m1y7pvinta.fsf@ebiederm.dsl.xmission.com> <20061204223248.GA31399@MAIL.13thfloor.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061204223248.GA31399@MAIL.13thfloor.at>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 04, 2006 at 11:32:48PM +0100, Herbert Poetzl wrote:
> 
> utsname information is shown in the linux banner, which
> also is used for /proc/version (which can have different
> utsname values inside a uts namespaces). this patch
> makes the varying data arguments and changes the string
> to a format string, using those arguments.
> 
> best,
> Herbert

d'oh! just figured I lost the two new includes required
in main.c, will send an updated version shortly

best,
Herbert

> Signed-off-by: Herbert Poetzl <herbert@13thfloor.at>
> 
> --- linux-2.6.19/fs/proc/proc_misc.c	2006-11-30 21:19:28 +0100
> +++ linux-2.6.19/fs/proc/proc_misc.c	2006-12-04 07:16:28 +0100
> @@ -252,8 +252,8 @@ static int version_read_proc(char *page,
>  {
>  	int len;
>  
> -	strcpy(page, linux_banner);
> -	len = strlen(page);
> +	len = sprintf(page, linux_banner,
> +		utsname()->release, utsname()->version);
>  	return proc_calc_metrics(page, start, off, count, eof, len);
>  }
>  
> --- linux-2.6.19/init/main.c	2006-11-30 21:19:43 +0100
> +++ linux-2.6.19/init/main.c	2006-12-04 07:18:44 +0100
> @@ -501,7 +501,7 @@ asmlinkage void __init start_kernel(void
>  	boot_cpu_init();
>  	page_address_init();
>  	printk(KERN_NOTICE);
> -	printk(linux_banner);
> +	printk(linux_banner, UTS_RELEASE, UTS_VERSION);
>  	setup_arch(&command_line);
>  	unwind_setup();
>  	setup_per_cpu_areas();
> --- linux-2.6.19/init/version.c	2006-11-30 21:19:43 +0100
> +++ linux-2.6.19/init/version.c	2006-12-04 07:14:19 +0100
> @@ -35,5 +35,6 @@ struct uts_namespace init_uts_ns = {
>  EXPORT_SYMBOL_GPL(init_uts_ns);
>  
>  const char linux_banner[] =
> -	"Linux version " UTS_RELEASE " (" LINUX_COMPILE_BY "@"
> -	LINUX_COMPILE_HOST ") (" LINUX_COMPILER ") " UTS_VERSION "\n";
> +	"Linux version %s (" LINUX_COMPILE_BY "@"
> +	LINUX_COMPILE_HOST ") (" LINUX_COMPILER ") %s\n";
> +
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
