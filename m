Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267928AbUICOhW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267928AbUICOhW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 10:37:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268989AbUICOhW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 10:37:22 -0400
Received: from cantor.suse.de ([195.135.220.2]:51685 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S267928AbUICOhT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 10:37:19 -0400
Date: Fri, 3 Sep 2004 16:37:19 +0200
From: Andi Kleen <ak@suse.de>
To: Roland Dreier <roland@topspin.com>
Cc: Andi Kleen <ak@suse.de>, jakub@redhat.com, ecd@skynet.be, pavel@suse.cz,
       discuss@x86-64.org, linux-kernel@vger.kernel.org
Subject: Re: [discuss] Re: [PATCH] fs/compat.c: rwsem instead of BKL around ioctl32_hash_table
Message-ID: <20040903143718.GB4699@wotan.suse.de>
References: <20040901072245.GF13749@mellanox.co.il> <524qmi2e1s.fsf@topspin.com> <20040902211448.GE16175@wotan.suse.de> <52isawtihi.fsf@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52isawtihi.fsf@topspin.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 02, 2004 at 03:26:49PM -0700, Roland Dreier wrote:
>     Andi> It does not make much sense because the ioctl will take the
>     Andi> BKL anyways.
> 
> True, but it seems pretty ugly to protect the ioctl32 hash with the
> BKL.  I think the greater good of reducing use of the BKL should be
> looked at.

Replacing one lock with two is IMHO a bad idea. Making the number
of locks smaller and avoiding the locking wall IMHO has priority
even over BKL removal. 

> 
>     Andi> If you wanted to fix it properly better make it use RCU -
>     Andi> but it cannot work for the case of calling a compat handler.
> 
> I'm not sure I follow what you're saying.  When I looked at this, at
> first I thought RCU would be better for the hash lookup, but I didn't
> see a way to prevent a compat handler from being removed while it was
> running.  That's why I moved to a semaphore, which would hold off the
> removal until the handler was done running.  Is this what you mean?
> Do you see a way to uose RCU here?

The code currently assumes that the compat code is either 
in the kernel or in the same module who implements the
device (then the high level module count handling for
the file descriptor takes care of it) 

The BKL couldn't protect again removal of sleeping compat 
handlers anyways because the BKL is dropped during a 
schedule, and they all can sleep in user accesses.
During this scheduling window the module could be unloaded
if its count was zero. But with the assumption above this
cannot happen.

So basically the locking there is not to protect against
running handlers, just to ensure consistency during
the list walking. The list isn't touched anymore
after the compat handler runs, so the sleeping in there
is no problem.

RCU could be used as well to protect the list because
there is no sleep involved.

-Andi
