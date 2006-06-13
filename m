Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750843AbWFMJp2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750843AbWFMJp2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 05:45:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750853AbWFMJp2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 05:45:28 -0400
Received: from nz-out-0102.google.com ([64.233.162.206]:31768 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1750843AbWFMJp1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 05:45:27 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=YfY4ycXOIZ/5f2dHHauFqFrARKZyclZIZDYRINcaFYCZK8A2L6PLviCiOJ3IIGHN1jZmJNHtUO6ig6CMbSgkYG9FX38dLio+S9PXABpbFGrpmlIpWadI/WQ2nEt5vdR5ULOaR5V5lxf3nSvkgC5L3cbG/6/CfVLtapuece1YAHo=
Message-ID: <b0943d9e0606130245me8ff210h672a8c3360ad6944@mail.gmail.com>
Date: Tue, 13 Jun 2006 10:45:25 +0100
From: "Catalin Marinas" <catalin.marinas@gmail.com>
To: "Pekka J Enberg" <penberg@cs.helsinki.fi>
Subject: Re: [PATCH 2.6.17-rc6 7/9] Remove some of the kmemleak false positives
Cc: "Ingo Molnar" <mingo@elte.hu>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.58.0606131052400.15861@sbz-30.cs.Helsinki.FI>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060611111815.8641.7879.stgit@localhost.localdomain>
	 <84144f020606112219m445a3ccas7a95c7339ca5fa10@mail.gmail.com>
	 <b0943d9e0606120111v310f8556k30b6939d520d56d8@mail.gmail.com>
	 <Pine.LNX.4.58.0606121111440.7129@sbz-30.cs.Helsinki.FI>
	 <20060612105345.GA8418@elte.hu>
	 <b0943d9e0606120556h185f2079x6d5a893ed3c5cd0f@mail.gmail.com>
	 <20060612192227.GA5497@elte.hu>
	 <Pine.LNX.4.58.0606130850430.15861@sbz-30.cs.Helsinki.FI>
	 <b0943d9e0606122359q6ffabdbdqada9a6c79642cf2a@mail.gmail.com>
	 <Pine.LNX.4.58.0606131052400.15861@sbz-30.cs.Helsinki.FI>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/06/06, Pekka J Enberg <penberg@cs.helsinki.fi> wrote:
> Hi Catalin,
>
> On Tue, 13 Jun 2006, Catalin Marinas wrote:
> > The gc roots are the data and bss sections (and maybe task kernel
> > stacks) and all the slab-allocated blocks are scanned if a link to
> > them is found from the roots (and all of them are usually scanned). If
> > no link is found, they would be reported as memory leaks (and not
> > scanned). You can't really avoid the scanning of allocated blocks
> > since they may contain pointers to other blocks.
>
> I am not sure you're agreeing or disagreeing :-).

I'm not sure either :-). Doing some quick statistics on an ARM
platform shows that there are plenty of values (almost 15%) in the
scanned memory that look like pointers (i.e. between 3GB and
3GB+128MB) but do not point to any allocated block:

total scanned values = 932102
total detected pointers = 6270
detected by alias (i.e. in-block address) = 2096
looking like pointer = 135675

I'll add a test to see how many of the look-like pointers actually
point to a valid in-block address. If this is considerable larger than
the detected by alias above, it shouldn't be implemented.

> As far as I understood, Ingo is worried about:
>
>         struct s { /* some fields */; char *buf; };
>
>         struct s *p = kmalloc(sizeof(struct s) + BUF_SIZE);
>         p->buf = p + sizeof(struct s);
>
> Which could lead to false negative due to p->buf pointing to p.  However,
> for us to even _find_ p->buf, we would need an incoming pointer _to_ p
> which makes me think this is not a problem in practice.  Hmm?

Not exactly. In the above case, Ingo (and me) is worried about having
a incoming pointer (from other block) equal to p->buf and therefore
inside the block allocated with kmalloc. It doesn't matter whether any
value in a block point to locations inside the block since the actual
block first needs to be accessible on the directed graph starting from
the root.

-- 
Catalin
