Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263847AbTIBRzn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 13:55:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263751AbTIBRzQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 13:55:16 -0400
Received: from fw.osdl.org ([65.172.181.6]:39307 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263847AbTIBRi1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 13:38:27 -0400
Date: Tue, 2 Sep 2003 10:38:44 -0700
From: Dave Olien <dmo@osdl.org>
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: Petri Koistinen <petri.koistinen@iki.fi>, linux-kernel@vger.kernel.org
Subject: Re: Sparse warning: bitmap.h: bad constant expression
Message-ID: <20030902173844.GA20578@osdl.org>
References: <Pine.LNX.4.56.0309012249230.14789@dsl-hkigw4a35.dial.inet.fi> <20030902015702.GA10265@osdl.org> <20030902095628.GB7616@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030902095628.GB7616@wohnheim.fh-wedel.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I was lazy with my problem summary yesterday.  The sparse warning is actually
about the declaration of the functions bitmap_shift_right() and
bitmap_shift_left() in bitmap.h.  In these cases, the bits argument to
DECLARE_BITMAP() was an argument to the function, and th variable sized
array is in the scope of that function.

The only uses of these functions I can find are in the macros
physids_shift_right, physids_shift_left, in mpsec.h, and cpus_shift_rigt
and cpus_shift_left, in cpumask_array.h.

In all uses, the "bits" argument eventually resolves to being a constant.
It would require the inline expansion of the bitmap_shift_*() functions
to take advantage of that.

Otherwise, as has been pointed out, this is valid C99.

On Tue, Sep 02, 2003 at 11:56:28AM +0200, Jörn Engel wrote:
> 
> Not quite true.  The above is an implicit call to alloca and should
> not exist in the kernel.  No need to hack support into sparse.
> 
> Petri's code below has constant array bounds, once the preprocessing
> is done, that should be fixed in sparse.
> 
> > On Mon, Sep 01, 2003 at 10:59:21PM +0300, Petri Koistinen wrote:
> > > Hi!
> > > 
> > > If I try to compile latest kernel with "make C=1" I'll get many warning
> > > messages from sparse saying:
> > > 
> > > warning: include/linux/bitmap.h:85:2: bad constant expression
> > > warning: include/linux/bitmap.h:98:2: bad constant expression
> > > 
> > > Sparse doesn't seem to like DECLARE_BITMAP macros.
> > > 
> > > #define DECLARE_BITMAP(name,bits) \
> > >         unsigned long name[BITS_TO_LONGS(bits)]
> > > 
> > > So what is wrong with this and how it could be fixed so that sparse
> > > wouldn't complain?
> 
> Sorry, I've just had a casual glance at sparse so far.  Looks like a
> preprocessing problem, that's all I can say.
> 
> Jörn
> 
> -- 
> Fancy algorithms are slow when n is small, and n is usually small.
> Fancy algorithms have big constants. Until you know that n is
> frequently going to be big, don't get fancy.
> -- Rob Pike
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
