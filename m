Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275419AbTHNRe3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 13:34:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275414AbTHNRe1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 13:34:27 -0400
Received: from fw.osdl.org ([65.172.181.6]:51597 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S275411AbTHNRcr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 13:32:47 -0400
Date: Thu, 14 Aug 2003 10:32:35 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Roland McGrath <roland@redhat.com>
cc: Andrew Morton <akpm@osdl.org>, Matt Wilson <msw@redhat.com>,
       <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>,
       Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH] revert zap_other_threads breakage, disallow CLONE_THREAD
 without CLONE_DETACHED
In-Reply-To: <200308120752.h7C7qQT20085@magilla.sf.frob.com>
Message-ID: <Pine.LNX.4.44.0308141023480.8148-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 12 Aug 2003, Roland McGrath wrote:
>
> Please apply this patch to get us back out of this useless quagmire and
> disallow the problematic case that noone wants to try to use any more.
> 
> -	if ((clone_flags & CLONE_THREAD) && !(clone_flags & CLONE_SIGHAND))
> +	if ((clone_flags & CLONE_THREAD) &&
> +	    (clone_flags & (CLONE_SIGHAND|CLONE_DETACHED)) != (CLONE_SIGHAND|CLONE_DETACHED))
>  		return ERR_PTR(-EINVAL);
>  	if ((clone_flags & CLONE_DETACHED) && !(clone_flags & CLONE_THREAD))

Look at the condition that follows: it disallows CLONE_DETACHED for 
non-threads.

Which really means that together with the first change, CLONE_DETACHED is 
always the same thing as CLONE_THREAD: you can't have one without the 
other. 

Which means that they are logically not separate bits any more, and we
should just get rid of CLONE_DETACHED altogether, and use CLONE_THREAD in
all cases where it is tested for.

I'd really prefer not to keep a bit around that has to mean the same thing 
as another bit - that way just lies madness. So I'll document 
CLONE_DETACHED as being a no-op, and change the _one_ place that used it 
to just use CLONE_THREAD instead.

		Linus

