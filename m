Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750724AbWHAX2w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750724AbWHAX2w (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 19:28:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750751AbWHAX2v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 19:28:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:4321 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750750AbWHAX2u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 19:28:50 -0400
From: Andreas Schwab <schwab@suse.de>
To: Dave Jones <davej@redhat.com>
Cc: Alexey Dobriyan <adobriyan@gmail.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: single bit flip detector.
References: <20060801184451.GP22240@redhat.com>
	<1154470467.15540.88.camel@localhost.localdomain>
	<20060801223011.GF22240@redhat.com>
	<20060801223622.GG22240@redhat.com>
	<20060801230003.GB14863@martell.zuzino.mipt.ru>
	<20060801231603.GA5738@redhat.com>
X-Yow: - if it GLISTENS, gobble it!!
Date: Wed, 02 Aug 2006 01:28:49 +0200
In-Reply-To: <20060801231603.GA5738@redhat.com> (Dave Jones's message of "Tue,
	1 Aug 2006 19:16:03 -0400")
Message-ID: <jebqr4f32m.fsf@sykes.suse.de>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones <davej@redhat.com> writes:

> diff --git a/mm/slab.c b/mm/slab.c
> index 21ba060..39f1183 100644
> --- a/mm/slab.c
> +++ b/mm/slab.c
> @@ -1638,10 +1638,29 @@ static void poison_obj(struct kmem_cache
>  static void dump_line(char *data, int offset, int limit)
>  {
>  	int i;
> +	unsigned char total = 0, bad_count = 0, errors = 0;

No need to initialize errors here.

>  	printk(KERN_ERR "%03x:", offset);
> -	for (i = 0; i < limit; i++)
> +	for (i = 0; i < limit; i++) {
> +		if (data[offset + i] != POISON_FREE) {
> +			total += data[offset + i];
> +			bad_count++;
> +		}
>  		printk(" %02x", (unsigned char)data[offset + i]);
> +	}
>  	printk("\n");
> +
> +	if (bad_count == 1) {
> +		errors = total ^ POISON_FREE;
> +		if (errors && !(errors & (errors-1))) {
> +			printk (KERN_ERR "Single bit error detected. Probably bad RAM.\n");
> +#ifdef CONFIG_X86
> +			printk (KERN_ERR "Run memtest86+ or similar memory test tool.\n");
> +#else
> +			printk (KERN_ERR "Run a memory test tool.\n");
> +#endif
> +			return;

Useless return.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
PGP key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
