Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262687AbTJDSwA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Oct 2003 14:52:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262690AbTJDSv7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Oct 2003 14:51:59 -0400
Received: from twinlark.arctic.org ([168.75.98.6]:9698 "EHLO
	twinlark.arctic.org") by vger.kernel.org with ESMTP id S262687AbTJDSv6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Oct 2003 14:51:58 -0400
Date: Sat, 4 Oct 2003 11:51:57 -0700 (PDT)
From: dean gaudet <dean-list-linux-kernel@arctic.org>
To: Matt Mackall <mpm@selenic.com>
cc: Erlend Aasland <erlend-a@ux.his.no>, Steven French <sfrench@us.ibm.com>,
       James Morris <jmorris@intercode.com.au>,
       Samba Technical Mailing List <samba-technical@samba.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH CIFS] use CryptoAPI MD4/MD5
In-Reply-To: <20031004182417.GC13573@waste.org>
Message-ID: <Pine.LNX.4.58.0310041127020.5954@twinlark.arctic.org>
References: <OF9C1504BB.5FB00D5A-ON87256DB3.0015672E-86256DB3.001798AE@us.ibm.com>
 <20031002113759.GA19824@badne3.ux.his.no> <Pine.LNX.4.58.0310041058000.5954@twinlark.arctic.org>
 <20031004182417.GC13573@waste.org>
X-comment: visit http://arctic.org/~dean/legal for information regarding copyright and disclaimer.
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 4 Oct 2003, Matt Mackall wrote:

> On Sat, Oct 04, 2003 at 11:00:01AM -0700, dean gaudet wrote:
> > what about CryptoAPI is so expensive that you can't use a stack-based
> > context?
>
> The alloc functions hide a bunch of module lookup details and the size
> of the context structures vary from one alg to the next. They also
> tend to hide block-sized buffers to deal with fragments. So it's a
> little ugly but not insurmountable.

by "block-sized" you mean like 64 bytes for MD5 and SHA1, 16 bytes for
AES, and so forth?  if so that's no biggie, those are already present
in most simple library implementations of these algos.  but if "block"
means 4096 bytes then, aiee.

if module lookup is expensive then perhaps a much better api would be one
which yields a module handle -- and the module handle can be used in a
much less expensive allocator to create contexts where they're required.
it seems that the module handle could be a read-only structure and
therefore shared without locking.


> > this seems pretty dumb converting a stack-based md5 context to multiple
> > instances in multiple structures.
> >
> > the stack is almost guaranteed to be in L1 cache.
> >
> > multiplying that structure by N connections is just a waste of memory
> > bandwidth.  not to mention the locking crud you seem to need to do... the
> > stack is implicitly locked.
> >
> > is CryptoAPI really this broken?
>
> It's a bit inflexible in this regard, yes.

this really sounds like two steps backwards and one step forward.

this CIFS patch alone replaces 89 lines with 250 lines of code!  the new
code does not look anywhere near as readable as the original.  but perhaps
that's just because i've dealt with the same trivial MD5Init/Update/Final
API for years.

i gather a lot of this comes from the desire to have run-time selectable
sw and hw implementations of various algorithms for "optimal" performance.
but there generally isn't an optimal algorithm for all situations.
for small short digests like passwords it's probably more overhead to
use the cryptoapi than is saved from any blindingly fast implementation
behind the scenes.

-dean
