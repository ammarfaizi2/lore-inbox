Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750857AbWFMKiA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750857AbWFMKiA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 06:38:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750898AbWFMKiA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 06:38:00 -0400
Received: from nz-out-0102.google.com ([64.233.162.195]:2752 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1750847AbWFMKh7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 06:37:59 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fAnQaiNpsUBAnYpBxniLT471Lgg2BlQiZHfGu6krZrZhLqgzB5kriaeFtOIEQ/9XPFAw3kzNo5AHxVK0AaWrdO06JwfBHWQU9uYtMCegd7DM/T+8k24Z6bjMzAvDJAqXBotQm4/uKL8lpo+YGlvQPZRAMr3m7kyYN99ICC2zALY=
Message-ID: <b0943d9e0606130337l32a0ee69vc0812a829f4025af@mail.gmail.com>
Date: Tue, 13 Jun 2006 11:37:58 +0100
From: "Catalin Marinas" <catalin.marinas@gmail.com>
To: "Pekka Enberg" <penberg@cs.helsinki.fi>
Subject: Re: [PATCH 2.6.17-rc6 7/9] Remove some of the kmemleak false positives
Cc: "Ingo Molnar" <mingo@elte.hu>, linux-kernel@vger.kernel.org
In-Reply-To: <84144f020606130304s7420c642wababc4ce40edbcec@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060611111815.8641.7879.stgit@localhost.localdomain>
	 <Pine.LNX.4.58.0606121111440.7129@sbz-30.cs.Helsinki.FI>
	 <20060612105345.GA8418@elte.hu>
	 <b0943d9e0606120556h185f2079x6d5a893ed3c5cd0f@mail.gmail.com>
	 <20060612192227.GA5497@elte.hu>
	 <Pine.LNX.4.58.0606130850430.15861@sbz-30.cs.Helsinki.FI>
	 <b0943d9e0606122359q6ffabdbdqada9a6c79642cf2a@mail.gmail.com>
	 <Pine.LNX.4.58.0606131052400.15861@sbz-30.cs.Helsinki.FI>
	 <b0943d9e0606130245me8ff210h672a8c3360ad6944@mail.gmail.com>
	 <84144f020606130304s7420c642wababc4ce40edbcec@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/06/06, Pekka Enberg <penberg@cs.helsinki.fi> wrote:
> On 13/06/06, Pekka J Enberg <penberg@cs.helsinki.fi> wrote:
> > > As far as I understood, Ingo is worried about:
> > >
> > >         struct s { /* some fields */; char *buf; };
> > >
> > >         struct s *p = kmalloc(sizeof(struct s) + BUF_SIZE);
> > >         p->buf = p + sizeof(struct s);
> > >
> > > Which could lead to false negative due to p->buf pointing to p.  However,
> > > for us to even _find_ p->buf, we would need an incoming pointer _to_ p
> > > which makes me think this is not a problem in practice.  Hmm?
>
> On 6/13/06, Catalin Marinas <catalin.marinas@gmail.com> wrote:
> > Not exactly. In the above case, Ingo (and me) is worried about having
> > a incoming pointer (from other block) equal to p->buf and therefore
> > inside the block allocated with kmalloc.
>
> Ah, right, I overlooked that case. But, is it really a leak? That is,
> even though we currently don't have a pointer to the beginning fo the
> block, we don't know for sure it was a leak. You're now allowed to do:
>
>     p = kmalloc(...);
>     p = p + HDR_SIZE;
>
>     /* ... */
>
>     kfree(p - HDR_SIZE);
>
> Do you think we should ban the above?

I don't think you can ban this because of places where the structure
needs to be aligned to a certain value. Look in the false positives
patch for the memleak_padding() calls with the 2nd argument not zero.

-- 
Catalin
