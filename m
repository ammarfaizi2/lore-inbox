Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263752AbTH0QRe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 12:17:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263716AbTH0QQY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 12:16:24 -0400
Received: from aneto.able.es ([212.97.163.22]:2224 "EHLO aneto.able.es")
	by vger.kernel.org with ESMTP id S263531AbTH0QOY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 12:14:24 -0400
Date: Wed, 27 Aug 2003 18:14:21 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "J.A. Magallon" <jamagallon@able.es>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.4: always_inline for gcc3
Message-ID: <20030827161421.GA9204@werewolf.able.es>
References: <Pine.LNX.4.44.0308260850170.3191@logos.cnet> <20030826162454.GE2023@werewolf.able.es> <1061995054.22721.31.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <1061995054.22721.31.camel@dhcp23.swansea.linux.org.uk>; from alan@lxorguk.ukuu.org.uk on Wed, Aug 27, 2003 at 16:37:35 +0200
X-Mailer: Balsa 2.0.13
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 08.27, Alan Cox wrote:
> On Maw, 2003-08-26 at 17:24, J.A. Magallon wrote:
> > gcc3 did not inline big functions, even if they were marked as inline
> > Thread:
> > http://marc.theaimsgroup.com/?t=103632325600005&r=1&w=2
> > Things like memcpy and copy_to/from_user were affected.
> > They were not inlined and you got tons of instances in vmlinux.
> 
> The more interesting question you want to answer first is - was
> gcc right. Repeated code is bad for cache
> 

That would be true for a regular function, too much inlining can be bad.
But __constant_c_and_count_memset is special, you know.
It is written like a big switch:

copy( size )
	switch (size)
		case 1: ...
		case 2: ...
		...

Author and users relay on gcc's optimizer:
- gcc inlines it
- control variable in switch is constant at compile time
- switch is killed and just the suitable case stays.
(\label{1})

If gcc does not inline it, there are a ton of users of copy_to/from
and memset that execute the full switch() (w/o the patch, 150 out-of-line
instances of __constant_c_and_count_memset stay, with the patch
only 16, so it means gcc failed to inline about 140...).
Depending on which users are not inlined, this can be more or less
harmfull in terms of performance, but sure it is not the designed
behaviour.

And of course, I can be totally wrong. Comments welcome.

Ah, all this supposing that gcc still does correctly what I said
in \ref{1} ;)

-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.2 (Cooker) for i586
Linux 2.4.22-jam1m (gcc 3.3.1 (Mandrake Linux 9.2 3.3.1-1mdk))
