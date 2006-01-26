Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932269AbWAZKEm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932269AbWAZKEm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 05:04:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932260AbWAZKEm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 05:04:42 -0500
Received: from post-25.mail.nl.demon.net ([194.159.73.195]:48611 "EHLO
	post-25.mail.nl.demon.net") by vger.kernel.org with ESMTP
	id S932254AbWAZKEl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 05:04:41 -0500
Date: Thu, 26 Jan 2006 11:04:25 +0100
From: Rutger Nijlunsing <rutger@nospam.com>
To: Balbir Singh <bsingharora@gmail.com>
Cc: Akinobu Mita <mita@miraclelinux.com>, Grant Grundler <iod00d@hp.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       linux-ia64@vger.kernel.org
Subject: Re: [PATCH 8/12] generic hweight{32,16,8}()
Message-ID: <20060126100425.GA12345@nospam.com>
Reply-To: linux-kernel@tux.tmfweb.nl
References: <20060125112625.GA18584@miraclelinux.com> <20060125113206.GD18584@miraclelinux.com> <20060125200250.GA26443@flint.arm.linux.org.uk> <20060125205907.GF9995@esmail.cup.hp.com> <20060126032713.GA9984@miraclelinux.com> <20060126033613.GG11138@miraclelinux.com> <661de9470601252312m1f9c9256peb79451e49fc8662@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <661de9470601252312m1f9c9256peb79451e49fc8662@mail.gmail.com>
Organization: M38c
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[snip]
> >  /*
> >   * hweightN: returns the hamming weight (i.e. the number
> >   * of bits set) of a N-bit word
> >   */
> >
> > -#define hweight32(x) generic_hweight32(x)
> > -#define hweight16(x) generic_hweight16(x)
> > -#define hweight8(x) generic_hweight8(x)
> > +static inline unsigned int hweight32(unsigned int w)
> > +{
> > +        unsigned int res = (w & 0x55555555) + ((w >> 1) & 0x55555555);
> > +        res = (res & 0x33333333) + ((res >> 2) & 0x33333333);
> > +        res = (res & 0x0F0F0F0F) + ((res >> 4) & 0x0F0F0F0F);
> > +        res = (res & 0x00FF00FF) + ((res >> 8) & 0x00FF00FF);
> > +        return (res & 0x0000FFFF) + ((res >> 16) & 0x0000FFFF);
> > +}
> > +
> 
> This can be replaced with
> 
>   register int res=w;
>   res=res-((res>>1)&0x55555555);
>   res=(res&0x33333333)+((res>>2)&0x33333333);
>   res=(res+(res>>4))&0x0f0f0f0f;
>   res=res+(res>>8);
>   return (res+(res>>16)) & 0xff;
> 
> Similar optimizations can be applied to the routines below. Please see
> http://www-cs-faculty.stanford.edu/~knuth/mmixware.html errata and the code
> in mmix-arith.w for the complete set of optimizations and credits.
> 
> http://www.jjj.de/fxt/fxtbook.pdf is another inspirational source for
> such algorithms.

Ah, the joys of bit twiddling!

http://graphics.stanford.edu/~seander/bithacks.html
...has some more.

-- 
Rutger Nijlunsing ---------------------------------- eludias ed dse.nl
never attribute to a conspiracy which can be explained by incompetence
----------------------------------------------------------------------
