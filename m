Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266218AbUJUJkx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266218AbUJUJkx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 05:40:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268971AbUJUJgp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 05:36:45 -0400
Received: from fw.osdl.org ([65.172.181.6]:30955 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268961AbUJUJdm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 05:33:42 -0400
Date: Thu, 21 Oct 2004 02:31:35 -0700
From: Andrew Morton <akpm@osdl.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org, rusty@rustcorp.com.au
Subject: Re: Am I paranoid or is everyone out to break my kernel builds
 (Breakage in drivers/pcmcia)
Message-Id: <20041021023135.074c7988.akpm@osdl.org>
In-Reply-To: <20041021100903.A3089@flint.arm.linux.org.uk>
References: <20041021100903.A3089@flint.arm.linux.org.uk>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King <rmk+lkml@arm.linux.org.uk> wrote:
>
> It would appear that this change:
> 
> -module_param_array(irq_list, int, irq_list_count, 0444);
> +module_param_array(irq_list, int, &irq_list_count, 0444);
> 
> given:
> 
> static int irq_list[16];
> static int irq_list_count;
> 
> breaks PCMCIA drivers.  Why?
> 
> #define module_param_array(name, type, num, perm)               \
>         module_param_array_named(name, name, type, num, perm)
> 
> #define module_param_array_named(name, array, type, num, perm)          \
>         static struct kparam_array __param_arr_##name                   \
>         = { ARRAY_SIZE(array), &num, param_set_##type, param_get_##type,\
>             sizeof(array[0]), array };                                  \
>         module_param_call(name, param_array_set, param_array_get,       \
>                           &__param_arr_##name, perm)
> 
> Take special note of the '&' before 'num' in the above initialiser, and
> check the structure:

Something's out of whack with your tree.  You should have:

#define module_param_array_named(name, array, type, nump, perm)		\
	static struct kparam_array __param_arr_##name			\
	= { ARRAY_SIZE(array), nump, param_set_##type, param_get_##type,\
	    sizeof(array[0]), array };					\
	module_param_call(name, param_array_set, param_array_get, 	\
			  &__param_arr_##name, perm)


