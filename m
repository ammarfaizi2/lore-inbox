Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936875AbWLEWqs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936875AbWLEWqs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 17:46:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936890AbWLEWqs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 17:46:48 -0500
Received: from rgminet01.oracle.com ([148.87.113.118]:44791 "EHLO
	rgminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936875AbWLEWqr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 17:46:47 -0500
Date: Tue, 5 Dec 2006 14:47:09 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [patch] add ignore_loglevel boot option
Message-Id: <20061205144709.9c50194d.randy.dunlap@oracle.com>
In-Reply-To: <20061205120954.GA30154@elte.hu>
References: <20061205120954.GA30154@elte.hu>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Dec 2006 13:09:54 +0100 Ingo Molnar wrote:

> Subject: [patch] add ignore_loglevel boot option
> From: Ingo Molnar <mingo@elte.hu>
> 
> sometimes the kernel prints something interesting while userspace
> bootup keeps messages turned off via loglevel. Enable the printing
> of /all/ kernel messages via the "ignore_loglevel" boot option.
> Off by default.

Hi,

Is this equivalent to using the "debug" kernel parameter
except that userspace (init scripts) cannot muck it up (modify
the setting)?

I've seen init scripts modify the loglevel, much to my
dismay.

I'd say that this is useful, but it's really userspace
that needs to be fixed.

> Signed-off-by: Ingo Molnar <mingo@elte.hu>
> ---
>  Documentation/kernel-parameters.txt |    4 ++++
>  kernel/printk.c                     |   14 +++++++++++++-
>  2 files changed, 17 insertions(+), 1 deletion(-)
> 
> Index: linux/kernel/printk.c
> ===================================================================
> --- linux.orig/kernel/printk.c
> +++ linux/kernel/printk.c
> @@ -352,13 +352,25 @@ static void __call_console_drivers(unsig
>  	touch_critical_timing();
>  }
>  
> +static int __read_mostly ignore_loglevel;
> +
> +int __init ignore_loglevel_setup(char *str)
> +{
> +	ignore_loglevel = 1;
> +	printk(KERN_INFO "debug: ignoring loglevel setting.\n");
> +
> +	return 1;
> +}
> +
> +__setup("ignore_loglevel", ignore_loglevel_setup);
> +
>  /*
>   * Write out chars from start to end - 1 inclusive
>   */
>  static void _call_console_drivers(unsigned long start,
>  				unsigned long end, int msg_log_level)
>  {
> -	if (msg_log_level < console_loglevel &&
> +	if ((msg_log_level < console_loglevel || ignore_loglevel) &&
>  			console_drivers && start != end) {
>  		if ((start & LOG_BUF_MASK) > (end & LOG_BUF_MASK)) {
>  			/* wrapped write */
> -

---
~Randy
