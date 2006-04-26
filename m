Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751160AbWDZHxw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751160AbWDZHxw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 03:53:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751151AbWDZHxv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 03:53:51 -0400
Received: from rhlx01.fht-esslingen.de ([129.143.116.10]:56750 "EHLO
	rhlx01.fht-esslingen.de") by vger.kernel.org with ESMTP
	id S1751160AbWDZHxu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 03:53:50 -0400
Date: Wed, 26 Apr 2006 09:53:49 +0200
From: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
To: Pekka Enberg <penberg@cs.helsinki.fi>
Cc: Hua Zhong <hzhong@gmail.com>, linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] likely cleanup: remove unlikely for kfree(NULL)
Message-ID: <20060426075349.GA28823@rhlx01.fht-esslingen.de>
References: <Pine.LNX.4.64.0604251120420.5810@localhost.localdomain> <84144f020604260030v26f42b0bke639053928d5e471@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84144f020604260030v26f42b0bke639053928d5e471@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
X-Priority: none
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Apr 26, 2006 at 10:30:17AM +0300, Pekka Enberg wrote:
> On 4/25/06, Hua Zhong <hzhong@gmail.com> wrote:
> > diff --git a/mm/slab.c b/mm/slab.c
> > index e6ef9bd..0fbc854 100644
> > --- a/mm/slab.c
> > +++ b/mm/slab.c
> > @@ -3380,7 +3380,7 @@ void kfree(const void *objp)
> >         struct kmem_cache *c;
> >         unsigned long flags;
> >
> > -       if (unlikely(!objp))
> > +       if (!objp)
> >                 return;
> 
> NAK. Fix the callers instead.

I don't know. Why then did Wine decide in a lengthy discussion to allow
bogus NULL calls to HeapFree() instead of having NULL checks repeated all over
the place, thus leading to some form of code size bloat?

exit:
	if (foobuffer)
		kfree(foobuffer);
	if (frobbledma)
		kfree(frobbledma);
	if (init_sequence)
		kfree(init_sequence);

	return result;

sure sounds worse than

exit:
	kfree(foobuffer);
	kfree(frobbledma);
	kfree(init_sequence);

	return result;
	
	

Perhaps one way to resolve this would be to add an explanatory comment
to the kfree() NULL check that says that the most frequent NULL abusers
should be fixed (e.g. via call trace profiling), and *only those*?

And drop the (un)likely() in that case, of course, since it's a relatively
"average" decision here.

Andreas Mohr
