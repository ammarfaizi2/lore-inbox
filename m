Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263665AbUFBRSG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263665AbUFBRSG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 13:18:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263679AbUFBRSF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 13:18:05 -0400
Received: from mail.fh-wedel.de ([213.39.232.194]:1686 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S263665AbUFBRSA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 13:18:00 -0400
Date: Wed, 2 Jun 2004 19:17:32 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Horst von Brand <vonbrand@inf.utfsm.cl>, Pavel Machek <pavel@suse.cz>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjanv@redhat.com>,
       Ingo Molnar <mingo@elte.hu>, Andrea Arcangeli <andrea@suse.de>,
       Rik van Riel <riel@redhat.com>, linux-kernel@vger.kernel.org,
       Greg KH <greg@kroah.com>
Subject: Re: [RFC PATCH] explicitly mark recursion count
Message-ID: <20040602171732.GA30427@wohnheim.fh-wedel.de>
References: <20040602131623.GA23017@wohnheim.fh-wedel.de> <Pine.LNX.4.58.0406020712180.3403@ppc970.osdl.org> <20040602142748.GA25939@wohnheim.fh-wedel.de> <Pine.LNX.4.58.0406020743260.3403@ppc970.osdl.org> <20040602150440.GA26474@wohnheim.fh-wedel.de> <Pine.LNX.4.58.0406020807270.3403@ppc970.osdl.org> <20040602152741.GC26474@wohnheim.fh-wedel.de> <Pine.LNX.4.58.0406020839230.3403@ppc970.osdl.org> <20040602161721.GA29296@wohnheim.fh-wedel.de> <Pine.LNX.4.58.0406020921220.3403@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.58.0406020921220.3403@ppc970.osdl.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 June 2004 09:25:50 -0700, Linus Torvalds wrote:
> 
> Well, multiple recursion around the same function seems to be solvable two 
> different ways:
>  - "don't do that then". It really seems broken, but maybe there are 
>    really really good reasons _why_ it's not broken and why it happens.
>  - make sure that the separate loops are broken in some _other_ place than 
>    in the function they share.
> 
> A combination of the two may work well.
> 
> I say "may", because maybe I'm wrong, and the condition is common and hard
> to avoid limiting in the shared function. I don't have your data (and I'm
> lazy, so quite frankly I'd much rather you do the analysis anyway ;).

You *do* have my data, but I buy the lazy argument. ;)

> That said, I just don't see any sane alternatives to my "break in one
> place" thing. I believe that anything more complex that tries to explain
> the whole loop is just going to be a nightmare to maintain, and fragile as
> hell except for totally static legacy code that nobody touches any more.

Amen, brother.  Anything complicated will contain bugs tomorrow, if
not already today.

Let's see.  Right now, we have two cases of multiple recursions:
WARNING: multiple recursions around check_sig()
WARNING: multiple recursions around usb_audio_recurseunit()

check_sig() is bad code and can be cleaned up.

Leaves usb_audio_recurseunit() as the only function in question, that
one could actually be sane, although it looks rather interesting:
WARNING: trivial recursion detected:
       0  usb_audio_recurseunit
WARNING: recursion detected:
      16  usb_audio_selectorunit
       0  usb_audio_recurseunit
WARNING: multiple recursions around usb_audio_recurseunit()
WARNING: recursion detected:
       0  usb_audio_recurseunit
       0  usb_audio_processingunit

Greg, can you say whether this construct makes sense?

Jörn

-- 
Eighty percent of success is showing up.
-- Woody Allen
