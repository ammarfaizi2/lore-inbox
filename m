Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752253AbWCJXnM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752253AbWCJXnM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 18:43:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752254AbWCJXnM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 18:43:12 -0500
Received: from smtp.osdl.org ([65.172.181.4]:14263 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1752245AbWCJXnM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 18:43:12 -0500
Date: Fri, 10 Mar 2006 15:45:24 -0800
From: Andrew Morton <akpm@osdl.org>
To: ebiederm@xmission.com (Eric W. Biederman)
Cc: oleg@tv-sign.ru, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pidhash: Refactor the pid hash table.
Message-Id: <20060310154524.3c293b8f.akpm@osdl.org>
In-Reply-To: <m1irqmi5ma.fsf@ebiederm.dsl.xmission.com>
References: <m1irqmi5ma.fsf@ebiederm.dsl.xmission.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ebiederm@xmission.com (Eric W. Biederman) wrote:
>
> +fastcall void put_pid(struct pid *pid)
> +{
> +	if (!pid)
> +		return;
> +	if ((atomic_read(&pid->count) == 1) ||
> +	     atomic_dec_and_test(&pid->count))
> +		kmem_cache_free(pid_cachep, pid);
> +}

This looks odd.  It's an RCU callback so it's asynchronous.  It doesn't
take any locks, so if anyone else can have a ref on this thing then the
refcount can change at any time.

And both sides of the || are basically equivalent.  Perhaps you meant &&. 
But I'm more worried by the apparent raciness?
