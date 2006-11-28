Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935312AbWK1Oc4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935312AbWK1Oc4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 09:32:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935314AbWK1Oc4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 09:32:56 -0500
Received: from mx1.redhat.com ([66.187.233.31]:51891 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S935312AbWK1Ocz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 09:32:55 -0500
Date: Tue, 28 Nov 2006 09:32:14 -0500
From: Jakub Jelinek <jakub@redhat.com>
To: Jan Beulich <jbeulich@novell.com>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] work around gcc4 issue with -Os in Dwarf2 stack unwind code
Message-ID: <20061128143214.GD6570@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <456C51D8.76E4.0078.0@novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <456C51D8.76E4.0078.0@novell.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 28, 2006 at 02:12:24PM +0000, Jan Beulich wrote:
> This fixes a problem with gcc4 mis-compiling the stack unwind code under
> -Os, which resulted in 'stuck' messages whenever an assembly routine was
> encountered.

"mis-compiling" and "work around" are wrong words, the code had undefined
behavior (there is no sequence point between evaluation of ptr and
get_uleb128(&ptr, end) and ptr is modified twice, so the compiler can
evaluate it e.g. as:
temp = ptr;
temp = temp + get_uleb128(&ptr, end);
ptr = temp;
or
temp = get_uleb128(&ptr, end);
ptr += temp;
While gcc has some warnings for sequence point semantics violations
(-Wsequence-point), this can't be one of the cases at least until IPA moves
much further, because get_uleb128 might very well not modify the variable
and at that point the code would be ok).

> Signed-off-by: Jan Beulich <jbeulich@novell.com>
> 
> --- linux-2.6.19-rc6/kernel/unwind.c	2006-11-22 14:54:10.000000000 +0100
> +++ 2.6.19-rc6-unwind-stuck/kernel/unwind.c	2006-11-28 15:02:15.000000000 +0100
> @@ -938,8 +938,11 @@ int unwind(struct unwind_frame_info *fra
>  		else {
>  			retAddrReg = state.version <= 1 ? *ptr++ : get_uleb128(&ptr, end);
>  			/* skip augmentation */
> -			if (((const char *)(cie + 2))[1] == 'z')
> -				ptr += get_uleb128(&ptr, end);
> +			if (((const char *)(cie + 2))[1] == 'z') {
> +				uleb128_t augSize = get_uleb128(&ptr, end);
> +
> +				ptr += augSize;
> +			}
>  			if (ptr > end
>  			   || retAddrReg >= ARRAY_SIZE(reg_info)
>  			   || REG_INVALID(retAddrReg)

	Jakub
