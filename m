Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129319AbQLOVwR>; Fri, 15 Dec 2000 16:52:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129352AbQLOVwH>; Fri, 15 Dec 2000 16:52:07 -0500
Received: from lsb-catv-1-p021.vtxnet.ch ([212.147.5.21]:33040 "EHLO
	almesberger.net") by vger.kernel.org with ESMTP id <S129319AbQLOVv5>;
	Fri, 15 Dec 2000 16:51:57 -0500
Date: Fri, 15 Dec 2000 22:21:17 +0100
From: Werner Almesberger <Werner.Almesberger@epfl.ch>
To: LA Walsh <law@sgi.com>
Cc: Alexander Viro <viro@math.psu.edu>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linus's include file strategy redux
Message-ID: <20001215222117.S573@almesberger.net>
In-Reply-To: <20001215152137.K599@almesberger.net> <NBBBJGOOMDFADJDGDCPHAENMCJAA.law@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <NBBBJGOOMDFADJDGDCPHAENMCJAA.law@sgi.com>; from law@sgi.com on Fri, Dec 15, 2000 at 10:10:39AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

LA Walsh wrote:
> 	I think in my specific case, perhaps, linux/malloc.h *is* a public
> interface that is to be included by module writers and belongs in the
> 'public interface dir -- and that's great.  But it includes files like
> 'slab.h' which are kernel mm-specific that may change in the future.

As far as I understand the scenario you're describing, this seems to
be the only problem. <public>/malloc.h shouldn't need to include
<private>/slab.h.

If there's anything <private>/slab.h provides (either directly or
indirectly) that is needed in <public>/malloc.h, that should either be
in another public header, or malloc.h actually shouldn't depend on it.

Exception: opaque types; there one would have to go via a __ identifier,
i.e.

<public>/foo.h defines  struct __foo ...;
<public>/bar.h includes <public>/foo.h
               and uses #define FOOSIZE sizeof(struct __foo)
<private>/foo.h either  typedef struct __foo foo_t;
                or      #define foo __foo  /* ugly */

Too bad there's no  typedef struct __foo struct foo;

I don't think restructuring the headers in this way would cause
a long period of instability. The main problem seems to be to
decide what is officially private and what isn't.

> 	Any other solution, as I see it, would break existing module code.

Hmm, I think what I've outlined above wouldn't break more code than
your approach. Obviously, modiles currently using "private" interfaces
are in trouble either way.

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, ICA, EPFL, CH           Werner.Almesberger@epfl.ch /
/_IN_N_032__Tel_+41_21_693_6621__Fax_+41_21_693_6610_____________________/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
