Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261197AbVFFGjm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261197AbVFFGjm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 02:39:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261196AbVFFGjm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 02:39:42 -0400
Received: from fmr17.intel.com ([134.134.136.16]:29925 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S261197AbVFFGj0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 02:39:26 -0400
From: "Yu, Luming" <luming.yu@intel.com>
Reply-To: luming.yu@intel.com
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [linux-pm] Re: swsusp: Not enough free pages
Date: Mon, 6 Jun 2005 14:39:02 +0800
User-Agent: KMail/1.6.1
Cc: ACPI devel <acpi-devel@lists.sourceforge.net>, linux-pm@lists.osdl.org
References: <3ACA40606221794F80A5670F0AF15F84041AC1A8@pdsmsx403> <20050530091419.GA7922@linux.sh.intel.com> <20050530150157.GC2207@elf.ucw.cz>
In-Reply-To: <20050530150157.GC2207@elf.ucw.cz>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <200506061439.03023.luming.yu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > > So far, yes. I just tried 2 times.
> >
> > always. (I check that swap dev is on)
> >
> > Sometimes, my ia32 laptop free 0 pages too.
> > I think we should always free some pages
> > from various caches.
>
> Try this hack... it is basically mm problem I don't know how to fix,
> but this seems to help.
> 								Pavel

Thanks Pavel, this hack works.
..
Freeing memory...  ^Hdone (0 pages freed)
Freeing memory...  ^H-^Hdone (4636 pages freed)
Freeing memory...  ^Hdone (0 pages freed)
Freeing memory...  ^H-^Hdone (914 pages freed)
Freeing memory...  ^Hdone (0 pages freed)
Freezing CPUs (at 0)...ok

Any mm guru know how to fix this?

>
> Index: kernel/power/disk.c
> ===================================================================
> --- 805a02ec2bcff3671d7b1e701bd1981ad2fa196c/kernel/power/disk.c 
> (mode:100644) +++
> ecd8559cc08319bb16a42aac06cf7d664157643a/kernel/power/disk.c  (mode:100644)
> @@ -88,23 +92,25 @@
>
>  static void free_some_memory(void)
>  {
> -	unsigned int i = 0;
> -	unsigned int tmp;
> -	unsigned long pages = 0;
> -	char *p = "-\\|/";
> -
> -	printk("Freeing memory...  ");
> -	while ((tmp = shrink_all_memory(10000))) {
> -		pages += tmp;
> -		printk("\b%c", p[i]);
> -		i++;
> -		if (i > 3)
> -			i = 0;
> +	int i;
> +	for (i=0; i<5; i++) {
> +		int i = 0, tmp;
> +		long pages = 0;
> +		char *p = "-\\|/";
> +
> +		printk("Freeing memory...  ");
> +		while ((tmp = shrink_all_memory(10000))) {
> +			pages += tmp;
> +			printk("\b%c", p[i]);
> +			i++;
> +			if (i > 3)
> +				i = 0;
> +		}
> +		printk("\bdone (%li pages freed)\n", pages);
> +		msleep_interruptible(200);
>  	}
> -	printk("\bdone (%li pages freed)\n", pages);
>  }
>
> -
>  static inline void platform_finish(void)
>  {
>  	if (pm_disk_mode == PM_DISK_PLATFORM) {

