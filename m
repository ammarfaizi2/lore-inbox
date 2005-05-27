Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261435AbVE0CMH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261435AbVE0CMH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 22:12:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261439AbVE0CMH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 22:12:07 -0400
Received: from ylpvm29-ext.prodigy.net ([207.115.57.60]:21424 "EHLO
	ylpvm29.prodigy.net") by vger.kernel.org with ESMTP id S261435AbVE0CL5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 22:11:57 -0400
X-ORBL: [63.202.173.158]
Date: Thu, 26 May 2005 19:11:42 -0700
From: Chris Wedgwood <cw@f00f.org>
To: blaisorblade@yahoo.it
Cc: akpm@osdl.org, jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net, mingo@redhat.com
Subject: Re: [patch 1/1] [RFC] uml: add and use generic hw_controller_type->release
Message-ID: <c915b004e775ff68517f3be2c95c6f93.IBX@taniwha.stupidest.org>
References: <20050527003926.1FD861AEE92@zion.home.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050527003926.1FD861AEE92@zion.home.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 27, 2005 at 02:39:26AM +0200, blaisorblade@yahoo.it wrote:

> From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>, Chris Wedgwood <cw@f00f.org>
> CC: Ingo Molnar <mingo@redhat.com>

[...]

> This is heavily based on some work by Chris Wedgwood, which however
> didn't get the patch merged for something I'd call a
> "misunderstanding" (the need for this patch wasn't cleanly
> explained, thus adding the generic hook was felt as undesirable).

Looks very reasonable to me and your explaination is much better than
mine was :-)

> diff -puN kernel/irq/manage.c~uml-gen-irq-release kernel/irq/manage.c
> --- linux-2.6.git/kernel/irq/manage.c~uml-gen-irq-release	2005-05-25 01:15:46.000000000 +0200
> +++ linux-2.6.git-paolo/kernel/irq/manage.c	2005-05-25 01:15:46.000000000 +0200
> @@ -255,6 +255,10 @@ void free_irq(unsigned int irq, void *de
>  
>  			/* Found it - now remove it from the list of entries */
>  			*pp = action->next;
> +
> +			if (desc->handler->release)
> +				desc->handler->release(irq, dev_id);
> +

Because right now we know the *only* port that needs a release method
is UML I wonder if we could do save a couple of bytes & cycles for
everyone else by doing something like #ifdef CONFIG_IRQ_HAS_RELEASE,
#endif around that and then letting the Kconfig magic set
CONFIG_IRQ_HAS_RELEASE as required?  If other arches need it thay can
do the same and if eventually almost everyone does we can kill the
#ifdef crud?

Longer term I wonder if some of the irq mechanics in UML couldn't end
up being a bit more like the s390 stuff too?
