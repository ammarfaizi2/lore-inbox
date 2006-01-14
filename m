Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945947AbWANB0x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945947AbWANB0x (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 20:26:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423254AbWANB0v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 20:26:51 -0500
Received: from smtp.osdl.org ([65.172.181.4]:39566 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1423253AbWANB0u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 20:26:50 -0500
Date: Fri, 13 Jan 2006 17:28:46 -0800
From: Andrew Morton <akpm@osdl.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/17] fuse: add number of waiting requests attribute
Message-Id: <20060113172846.3ea49670.akpm@osdl.org>
In-Reply-To: <20060114004114.241169000@dorka.pomaz.szeredi.hu>
References: <20060114003948.793910000@dorka.pomaz.szeredi.hu>
	<20060114004114.241169000@dorka.pomaz.szeredi.hu>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> +	/** The number of requests waiting for completion */
> +	atomic_t num_waiting;

This doesn't get initialised anywhere.

Presumably you're relying on a memset somewhere.  That might work on all
architectures, AFAIK.  But in theory it's wrong.  If, for example, the
architecture implements atomic_t via a spinlock-plus-integer, and that
spinlock's unlocked state is not all-bits-zero, we're dead.

So we should initialise it with

	foo->num_waiting = ATOMIC_INIT(0);



nb: it is not correct to initialise an atomic_t with

	atomic_set(a, 0);

because in the above theoretical case case where the arch uses a spinlock
in the atomic_t, that spinlock doesn't get initialised.  I bet we've got code
in there which does this.
