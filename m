Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261538AbUJYGI0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261538AbUJYGI0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 02:08:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261521AbUJYGI0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 02:08:26 -0400
Received: from ozlabs.org ([203.10.76.45]:30085 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261538AbUJYGIM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 02:08:12 -0400
Subject: Re: [RFC/PATCH] Per-device parameter support (13/16)
From: Rusty Russell <rusty@rustcorp.com.au>
To: Tejun Heo <tj@home-tj.org>
Cc: mochel@osdl.org, lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20041023043138.GN3456@home-tj.org>
References: <20041023043138.GN3456@home-tj.org>
Content-Type: text/plain
Date: Mon, 25 Oct 2004 16:08:10 +1000
Message-Id: <1098684490.8098.54.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-10-23 at 13:31 +0900, Tejun Heo wrote:
> +/* For some reason, gcc aligns structures which contain other
> +   structures to 32-byte boundary even when __alignof__() the strucure
> +   is smaller than that.  As we're gonna assemble paramset array
> +   manually, we need to set alignment explicitly.  Also, we put all
> +   paramset array elements into .data.1 to avoid intervening variables
> +   of different types (kparam_string, kparam_array for now). */

You need __attribute__((aligned(sizeof(void *))): see moduleparam.h.
The padding between structures is arch-dependent (x86-64 found out the
hard way when we changed kernel_param previously).  Not sure why you're
using a separate section here anyway.

> +/* Bit flag */
> +#define __DEVICE_PARAM_FLAG(Name, Field, Flag, Dfl, Inv, Perm, Desc)	\
> +	param_check_uint(__devparam_data(Name),				\
> +			 &(((__devparam_type *)0)->Field));		\
> +	static struct kparam_flag __devparam_data(__param_flag_##Name)	\
> +	__devparam_extra_section = { 0, Flag, Inv };			\
> +	__DEVICE_PARAM_CALL_RANGED(Name, param_set_flag, param_get_flag,\
> +		&__devparam_data(__param_flag_##Name),			\
> +		sizeof(struct kparam_flag), 1, 0, Dfl, 0, Perm, Desc,	\
> +		offsetof(struct kparam_flag, pflags),			\
> +		offsetof(__devparam_type, Field), -1, -1)
> +
> +#define DEVICE_PARAM_FLAG(Name, Field, Flag, Dfl, Perm, Desc)		\
> +	__DEVICE_PARAM_FLAG(Name, Field, Flag, Dfl, 0, Perm, Desc)

Haven't read closely, but why is FLAG special?

I think your macros might be better off always having the range, which
would reduce the number of functions..  I like including the description
in the macros: that's an improvement.

I always disliked the _NAMED versions (if it's a good name for users,
it's usually a good name for the variable and vice versa), but you might
want to consider always having it if that's the common case.

Cheers,
Rusty.
-- 
A bad analogy is like a leaky screwdriver -- Richard Braakman

