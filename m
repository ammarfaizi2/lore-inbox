Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750878AbWHGL7W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750878AbWHGL7W (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 07:59:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750864AbWHGL7W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 07:59:22 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:38072 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750818AbWHGL7V convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 07:59:21 -0400
Subject: Re: [PATCH] UTF-8 input: composing non-latin1 characters, and
	copy-paste
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Alexander E. Patrakov" <patrakov@ums.usu.ru>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <44D71C25.6090301@ums.usu.ru>
References: <44D71C25.6090301@ums.usu.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Date: Mon, 07 Aug 2006 13:18:38 +0100
Message-Id: <1154953118.25998.31.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Llu, 2006-08-07 am 16:55 +0600, ysgrifennodd Alexander E. Patrakov:
> * CAPS LOCK does not work (silently ignored) for non-ASCII.

Capslock is indeed hard.

> argument. This means that only characters present in Latin-1 (i.e., with 
> codes <256) can be produced by composing while the keyboard is in 
> Unicode mode. This is certainly unacceptable for Eastern Europe (i.e., 
> former ISO-8859-2 users) who need to get ^+ Z = Ž.

Its not useful for most of Western europe either nowdays.

> While the proper way to get the later two issues resolved is definitely 
> to extend struct kbdiacr to produce a Unicode value, not a byte, as the 

This IMHO is the right thing to do

> result, this would require making incompatible changes to kbd. Instead, 

Absolutely.

> Copy-and-paste is handled by guessing which Unicode character most 
> likely corresponds to the glyph on the screen. Guesswork is needed 
> because many characters can map to the same glyph.

Is there a reason for not biting the bullet here and storing the
unmapped symbol then mapping it to the glyph when rendering. The days
where we had to worry about 8K more memory for the scrollback buffer are
dead and gone.

Basically I'd rather see us:
- Expand the kbd code to support the full set of behaviour (within
reason). It looks like the old behaviour can be expressed by keeping the
old format and allowing a new format (or mapping the old to the new when
the ioctl loads it)
- Expand the kbd code to allow caps/shift mapping by loaded table
- Store the true symbol not the glyph so we can cut/paste right
- Do the render mapping of symbols when needed when we actually render

That also means we get the right results if you move a live console from
text mode to graphical mode, or load different fonts and refresh.

Alan

