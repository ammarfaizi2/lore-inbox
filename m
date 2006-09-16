Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964789AbWIPW4K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964789AbWIPW4K (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Sep 2006 18:56:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964791AbWIPW4K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Sep 2006 18:56:10 -0400
Received: from smtp.osdl.org ([65.172.181.4]:47499 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964789AbWIPW4I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Sep 2006 18:56:08 -0400
Date: Sat, 16 Sep 2006 15:55:22 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       Jes Sorensen <jes@sgi.com>, Roman Zippel <zippel@linux-m68k.org>,
       tglx@linutronix.de, karim@opersys.com, Paul Mundt <lethal@linux-sh.org>,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Ingo Molnar <mingo@redhat.com>, Greg Kroah-Hartman <gregkh@suse.de>,
       Tom Zanussi <zanussi@us.ibm.com>, ltt-dev@shafik.org,
       Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: [patch] kprobes: optimize branch placement
Message-Id: <20060916155522.4d493363.akpm@osdl.org>
In-Reply-To: <20060916202939.GA4520@elte.hu>
References: <20060915181907.GB17581@elte.hu>
	<Pine.LNX.4.64.0609152111030.6761@scrub.home>
	<20060915200559.GB30459@elte.hu>
	<20060915202233.GA23318@Krystal>
	<450BCAF1.2030205@sgi.com>
	<20060916172419.GA15427@Krystal>
	<20060916173552.GA7362@elte.hu>
	<20060916175606.GA2837@Krystal>
	<20060916191043.GA22558@elte.hu>
	<20060916193745.GA29022@elte.hu>
	<20060916202939.GA4520@elte.hu>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 16 Sep 2006 22:29:39 +0200
Ingo Molnar <mingo@elte.hu> wrote:

> --- linux.orig/arch/i386/kernel/kprobes.c
> +++ linux/arch/i386/kernel/kprobes.c
> @@ -220,7 +220,7 @@ int __kprobes kprobe_handler(struct pt_r
>  	kcb = get_kprobe_ctlblk();
>  
>  	/* Check we're not actually recursing */
> -	if (kprobe_running()) {
> +	if (unlikely(kprobe_running())) {
>  		p = get_kprobe(addr);

This function does two calls to get_kprobe() (in the recurring-trap case)
where only one is needed.
