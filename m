Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267385AbUHSUjN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267385AbUHSUjN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 16:39:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267391AbUHSUjN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 16:39:13 -0400
Received: from fw.osdl.org ([65.172.181.6]:62179 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267385AbUHSUi5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 16:38:57 -0400
Date: Thu, 19 Aug 2004 13:37:14 -0700
From: Andrew Morton <akpm@osdl.org>
To: Dimitri Sivanich <sivanich@sgi.com>
Cc: manfred@colorfullife.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] Improve cache_reap hotplug cpu support
Message-Id: <20040819133714.7e2dbfd1.akpm@osdl.org>
In-Reply-To: <20040819202652.GA11050@sgi.com>
References: <20040819202652.GA11050@sgi.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dimitri Sivanich <sivanich@sgi.com> wrote:
>
> I found that there was room for improvement in the hotplug cpu code
> in cache_reap.

"improvement" is not an adequate description for your change, and it is
unobvious from the diff what it is intended to do, and why, and what the
expected and observed results were.

Please describe your work more carefully.


The patch adds even more ifdefs.  Suggest you open-code this:

> +#ifdef CONFIG_HOTPLUG_CPU
> +static void stop_cpu_timer(int cpu)
> +{
> +	struct work_struct *reap_work = &per_cpu(reap_work, cpu);
> +
> +	/* Null out this otherwise unused pointer for checking in cache_reap */
> +	reap_work->data = NULL;
> +}
> +#endif

in here:

>  static struct array_cache *alloc_arraycache(int cpu, int entries, int batchcount)
>  {
>  	int memsize = sizeof(void*)*entries+sizeof(struct array_cache);
> @@ -670,6 +680,7 @@ static int __devinit cpuup_callback(stru
>  		break;
>  #ifdef CONFIG_HOTPLUG_CPU
>  	case CPU_DEAD:
> +		stop_cpu_timer(cpu);
>  		/* fall thru */
>  	case CPU_UP_CANCELED:
>  		down(&cache_chain_sem);

thereby removing one of them.

