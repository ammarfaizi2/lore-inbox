Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750944AbWFZU0v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750944AbWFZU0v (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 16:26:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750870AbWFZU0v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 16:26:51 -0400
Received: from mx1.suse.de ([195.135.220.2]:5014 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750732AbWFZU0u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 16:26:50 -0400
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, akpm@osdl.org,
       hyoshiok@miraclelinux.com
Subject: Re: [PATCH] x86: cache pollution aware __copy_from_user_ll()
References: <200606231501.k5NF1B79002899@hera.kernel.org>
	<1151160152.3181.59.camel@laptopd505.fenrus.org>
	<Pine.LNX.4.64.0606241218510.6483@g5.osdl.org>
From: Andi Kleen <ak@suse.de>
Date: 26 Jun 2006 22:26:47 +0200
In-Reply-To: <Pine.LNX.4.64.0606241218510.6483@g5.osdl.org>
Message-ID: <p734py7vf20.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> On Sat, 24 Jun 2006, Arjan van de Ven wrote:
> > 
> > while this patch will reduce the number of cycles spent in the kernel,
> > it's just pushing the cache miss to userspace (by virtue of doing a
> > cache flush effectively)... is this really the right thing? The total
> > memory bandwidth will actually increase with this patch if you're
> > unlucky (eg if userspace decides to write to this memory eventually)....
> 
> No. It's for copying _from_ user space, ie a "write()" system call. So 
> what it does is to effectively try to use non-temporal stores to the page 
> cache - since the page cache is usually not read directly afterwards (at 
> least not soon enough for L1 caches to help).
> 
> I don't generally like cache tricks either (caches tend to be better than 
> humans, or at least get there fairly soon), but this one does seem very 
> valid.

Problem is that it will likely wreck pipe and AF_UNIX (= X server) 
performance. These read the buffer quickly again.

If you do something like this it would be better to define
a special function and use it for real FS traffic only.

-Andi
