Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261586AbUJ0CnJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261586AbUJ0CnJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 22:43:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261587AbUJ0CnI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 22:43:08 -0400
Received: from fw.osdl.org ([65.172.181.6]:16553 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261586AbUJ0Cmv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 22:42:51 -0400
Date: Tue, 26 Oct 2004 19:40:43 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jason Baron <jbaron@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix altsysrq deadlock
Message-Id: <20041026194043.5f39e140.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.44.0410261311590.12088-100000@dhcp83-105.boston.redhat.com>
References: <Pine.LNX.4.44.0410261311590.12088-100000@dhcp83-105.boston.redhat.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jason Baron <jbaron@redhat.com> wrote:
>
> 
> This patch fixes a deadlock in the handle_sysrq function.
> ...
>> -	__sysrq_lock_table();
> +	if(!__sysrq_trylock_table()) {
> +		if(in_interrupt())
> +			return;
> +		else
> +			__sysrq_lock_table();
> +	}
> +

This is only a partial solution - __sysrq_trylock_table() is exported to
modules which do who know what with it and they don't know how to handle
locking failures - they'll just go ahead and do a spin_unlock() of an
unlocked lock and mayhem will ensue.

What we need to do is to move all those inlined functions out of sysrq.h,
into sysrq.c then withdraw all those exported-to-modules helper functions
then remove __sysrq_trylock_table() altogether and then use
spin_lock_irqsave() in the appropriate places.
