Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267026AbTGKW2v (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 18:28:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267044AbTGKW2v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 18:28:51 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:51138 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id S267026AbTGKW2p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 18:28:45 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Matthew Wilcox <willy@debian.org>
Date: Sat, 12 Jul 2003 08:42:18 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16143.15690.106092.770785@gargle.gargle.HOWL>
Cc: Bernardo Innocenti <bernie@develer.com>, Andrew Morton <akpm@zip.com.au>,
       linux-kernel@vger.kernel.org
Subject: Re: do_div vs sector_t
In-Reply-To: message from Matthew Wilcox on Friday July 11
References: <20030711223359.GP20424@parcelfarce.linux.theplanet.co.uk>
X-Mailer: VM 7.16 under Emacs 21.3.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday July 11, willy@debian.org wrote:
> 
> # define do_div(n,base) ({                              \
>         uint32_t __base = (base);                       \
>         uint32_t __rem;                                 \
>         if (likely(((n) >> 32) == 0)) {                 \
> 
> so if we call do_div() on a u32, the compiler emits nasal daemons.
> and we do this -- in the antcipatory scheduler:
> 
>                 if (aic->seek_samples) {
>                         aic->seek_mean = aic->seek_total + 128;
>                         do_div(aic->seek_mean, aic->seek_samples);
>                 }
> 
> seek_mean is a sector_t so sometimes it's 64-bit on a 32-bit platform.
> so we can't avoid calling do_div().
> 
> This almost works (the warning is harmless since gcc optimises away the call)
> 
> # define do_div(n,base) ({                                              \
>         uint32_t __base = (base);                                       \
>         uint32_t __rem;                                                 \
>         if ((sizeof(n) < 8) || (likely(((n) >> 32) == 0))) {            \
>                 __rem = (uint32_t)(n) % __base;                         \
>                 (n) = (uint32_t)(n) / __base;                           \
>         } else                                                          \
>                 __rem = __div64_32(&(n), __base);                       \
>         __rem;                                                          \
>  })
> 
> Better ideas?

sector_div, defined in blkdev.h, is probably what you want.

NeilBrown
