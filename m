Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750740AbWGQLXs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750740AbWGQLXs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jul 2006 07:23:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750741AbWGQLXs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jul 2006 07:23:48 -0400
Received: from [212.70.42.180] ([212.70.42.180]:1546 "EHLO raad.intranet")
	by vger.kernel.org with ESMTP id S1750740AbWGQLXs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jul 2006 07:23:48 -0400
From: Al Boldi <a1426z@gawab.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH for 2.6.18-rc2] [2/8] i386/x86-64: Don't randomize stack top when no randomization personality
Date: Mon, 17 Jul 2006 14:24:49 +0300
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200607171424.49827.a1426z@gawab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * Andi Kleen <ak@suse.de> wrote:
> >  unsigned long arch_align_stack(unsigned long sp)
> >  {
> > -     if (randomize_va_space)
> > +     if (!(current->personality & ADDR_NO_RANDOMIZE) &&
> > randomize_va_space) sp -= get_random_int() % 8192;
> >       return sp & ~0xf;
>
> i'm not opposing this patch at all, but didnt the performance problems
> go away when the 0xf was changed to 0x7f?

Yes, 0x7f is critical, but I'm not sure about side-effects.

> looks good otherwise.

except this one

> --- linux.orig/fs/binfmt_elf.c
> +++ linux/fs/binfmt_elf.c
> @@ -515,7 +515,8 @@ static unsigned long randomize_stack_top
>  {
>         unsigned int random_variable = 0;
>
> -       if (current->flags & PF_RANDOMIZE) {
> +       if ((current->flags & PF_RANDOMIZE) &&
> +               !(current->personality & ADDR_NO_RANDOMIZE)) {
>                 random_variable = get_random_int() & STACK_RND_MASK;
>                 random_variable <<= PAGE_SHIFT;
>         }

Why are you testing twice?

Thanks!

--
Al

