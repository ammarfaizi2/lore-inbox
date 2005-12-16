Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932326AbVLPPZU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932326AbVLPPZU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 10:25:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932331AbVLPPZU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 10:25:20 -0500
Received: from mx1.redhat.com ([66.187.233.31]:55446 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932326AbVLPPZS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 10:25:18 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20051216124924.23264.qmail@science.horizon.com> 
References: <20051216124924.23264.qmail@science.horizon.com> 
To: linux@horizon.com
Cc: dhowells@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation 
X-Mailer: MH-E 7.84; nmh 1.1; GNU Emacs 22.0.50.1
Date: Fri, 16 Dec 2005 15:24:42 +0000
Message-ID: <19559.1134746682@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux@horizon.com wrote:

> > Can be turned into:
> > 
> > 	1,C,A	x = LL()
> > 	1,C,A	x |= 2;
> > 	1,C,A	SC(3) [success]
> > 	3,C,A	...
> 
> ... which can be turned back into
> 
>  	1,C,A	x = load()
>  	1,C,A	x' = x | 2;
>  	1,C,A	cmpxchg(x,x') [success]
>  	3,C,A	...

Which would be totally pointless.

If you have LL/SC, then the odds are you _don't_ have CMPXCHG, and that
CMPXCHG is implemented using LL/SC, so what you end up with is:


 	1,C,A	x = load()
 	1,C,A	x' = x | 2;
	1,C,A	y = LL()
	1,C,A	if (y == x)
	1,X,A		SC(x');
 	3,C,A	...

David
