Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758834AbWK2NPX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758834AbWK2NPX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 08:15:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758835AbWK2NPX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 08:15:23 -0500
Received: from mail.suse.de ([195.135.220.2]:55528 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1758834AbWK2NPW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 08:15:22 -0500
From: Andi Kleen <ak@suse.de>
To: "Jan Beulich" <jbeulich@novell.com>
Subject: Re: [PATCH] more sanity checks in Dwarf2 unwinder
Date: Wed, 29 Nov 2006 14:14:55 +0100
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org
References: <456D7985.76E4.0078.0@novell.com>
In-Reply-To: <456D7985.76E4.0078.0@novell.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611291414.56268.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 29 November 2006 12:13, Jan Beulich wrote:
> Tighten the requirements on both input to and output from the Dwarf2
> unwinder.

Thanks for doing this.

>  	while (unwind(info) == 0 && UNW_PC(info)) {
>  		n++;
>  		oad->ops->address(oad->data, UNW_PC(info));
>  		if (arch_unw_user_mode(info))
>  			break;
> +		if ((sp & ~(PAGE_SIZE - 1)) == (UNW_SP(info) & ~(PAGE_SIZE - 1))
> +		    && sp > UNW_SP(info))
> +			break;

Hmm, but that wouldn't catch the case when the SP is completely
corrupted for some reason.
Maybe it would be better to just run a brute force check here like 
the old in_exception_stack(). Similar on x86-64.

> +	if (UNW_PC(frame) % state.codeAlign
> +	    || UNW_SP(frame) % sleb128abs(state.dataAlign)
> +	    || (pc == UNW_PC(frame) && sp == UNW_SP(frame)))
> +		return -EIO;

Would it be possible to add printks for the EIOs? We want to know 
when dwarf2 is corrupted.

-Andi
