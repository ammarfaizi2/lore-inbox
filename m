Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261258AbUKNIyx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261258AbUKNIyx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Nov 2004 03:54:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261262AbUKNIyx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Nov 2004 03:54:53 -0500
Received: from mail-ex.suse.de ([195.135.220.2]:18407 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261258AbUKNIy1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Nov 2004 03:54:27 -0500
Date: Sun, 14 Nov 2004 09:54:26 +0100
From: Andi Kleen <ak@suse.de>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: Andi Kleen <ak@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Dave Jones <davej@redhat.com>,
       Alan Cox <alan@redhat.com>
Subject: Re: [PATCH] lockless MCE i386 port
Message-ID: <20041114085426.GE16795@wotan.suse.de>
References: <Pine.LNX.4.61.0411090126190.3047@musoma.fsmlabs.com> <Pine.LNX.4.61.0411130627050.3062@musoma.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0411130627050.3062@musoma.fsmlabs.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +#define MCE_LOG_LEN 32
> +#define MCE_OVERFLOW 0		/* bit 0 in flags means overflow */
> +#define MCE_LOG_SIGNATURE	"MACHINECHECK"
> +#define MCE_GET_RECORD_LEN	_IOR('M', 1, int)
> +#define MCE_GET_LOG_LEN		_IOR('M', 2, int)
> +#define MCE_GETCLEAR_FLAGS	_Io


Just noticed this: 

First I think it would be better if you used the same format
(with u64) as x86-64 because this is a user visible interface,
and we get problems with 32bit emulation if it's too different.

Also it would allow to share the mcelog.c codebase.

> +
> +struct mce {
> +	u64 tsc;	/* cpu timestamp counter */
> +	u32 stsl;
> +	u32 stsh;
> +	u32 miscl;
> +	u32 misch;
> +	u32 addrl;
> +	u32 addrh;
> +	u32 mcgstl;
> +	u32 mcgsth;
> +	u32 eip;
> +	u8  cs;		/* code segment */
> +	u8  bank;	/* machine check bank */
> +	u8  cpu;	/* cpu that raised the error */
> +	u8  finished;	/* entry is valid */
> +	void *ext_arg;	/* extended feature arg */

A pointer? That doesn't make sense. This record must 
be self contained because it is passed by read() 

-Andi
