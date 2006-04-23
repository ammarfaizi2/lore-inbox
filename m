Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750973AbWDWDs3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750973AbWDWDs3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Apr 2006 23:48:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750985AbWDWDs3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Apr 2006 23:48:29 -0400
Received: from nz-out-0102.google.com ([64.233.162.200]:33749 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1750964AbWDWDs3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Apr 2006 23:48:29 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=G/KJQLCJiZGzDvhGFHtlceLgj5X6929e/bRU/iNorg+oA9YBbwPzGDZ0xDiMifa3JZTItxa1LAKnXuwFrNJwZ6ORgIFNz2eW6US83gHkE0hmnvK23wyMlkqtO6I6dBoljAdWubdor4uAEb1K3ITCGM0u4ir4UGUFgkO/jjCUlaA=
Message-ID: <4789af9e0604222048g5a10b573pf687f137a2e99042@mail.gmail.com>
Date: Sat, 22 Apr 2006 21:48:28 -0600
From: "Jim Ramsay" <kernel@jimramsay.com>
To: "Thiago Galesi" <thiagogalesi@gmail.com>
Subject: Re: Possible MTD bug in 2.6.15
Cc: "Linux Kernel" <linux-kernel@vger.kernel.org>
In-Reply-To: <82ecf08e0604221008ieb22a4cuc59be570cf025bba@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1145723704.3524.TMDA@mail.tag.jimramsay.com>
	 <4789af9e0604220949i2757e408qa5de3a9e728e966f@mail.gmail.com>
	 <82ecf08e0604221008ieb22a4cuc59be570cf025bba@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/04/06, Thiago Galesi <thiagogalesi@gmail.com> wrote:
> > > > Ok, a couple of comments/questions
> > > >
> > > > 1 - Wouldn't it be better to map all flash, and leave the unneeded
> > > > part as read only?
> >
> > In general, yes.  But this should either be enforced somewhere nicer
> > (ie, die gracefully) so the kernel doesn't panic later, or be allowed
> > as in my patch.
>
> The fundamental problem there seems to be a mismatch between what is
> set by the user and what is read from the flash chip. As you mention
> in your first message, (what it came across is that) you don't have
> (physical / electrical) access to all the flash; not something I would
> recommend (that is, having limited electrical connection to the flash)

Yes, that is exactly what is going on - we have only have electrical
access to 32M of addresses regardless of the size of the actual chip
installed, and unfortunately I can't change that.  However, it's not
really a problem from the electrical side of things - We can still
access the lowest 32M on the chip, just the highest address pin isn't
connected to anything.

> As for the options you propose - enforce and die gracefully (that is,
> if there is a size mismatch, warning and purposely not working) seems
> more correct than the second option.

I don't see why - The size mismatch doesn't prevent the flash chip
from functioning.  Isn't it better to help things work in more
circumstances rather than in less?

And really, it's not a big stretch from what the code currently does
to what my patch changes.  At this point in the code, we know for a
fact that we already have at least one flash chip.  The math that's
going on here with the 'max_chips' variable is to check if there is
actually more than one physical chip implementing the entire reported
size.  The only mistake is that the math goes too far, shifting the
count down to zero if the reported size is too small.  This
'max_chips' should never be allowed to be lower than 1, because we
really do know that there is at least one flash chip.

I agree with you that it's probably "more correct" to actually specify
the real size of the chip in the 'map' struct before the CFI probe,
but I can't think of any reason why specifying a smaller size should
die (even gracefully) when it still works just fine.

Of course, maybe there are some models of flash chips where this
wouldn't work and a graceful prevention of this would be important. 
But with our CFI-compliant chip, we don't see any problem with my
patch applied.

--
Jim Ramsay
"Me fail English?  That's unpossible!"
