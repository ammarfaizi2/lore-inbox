Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263217AbUB1AjZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 19:39:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263226AbUB1AjZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 19:39:25 -0500
Received: from waste.org ([209.173.204.2]:63644 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S263217AbUB1AjW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 19:39:22 -0500
Date: Fri, 27 Feb 2004 18:39:00 -0600
From: Matt Mackall <mpm@selenic.com>
To: Christophe Saout <christophe@saout.de>
Cc: Jean-Luc Cooke <jlcooke@certainkey.com>, linux-kernel@vger.kernel.org,
       James Morris <jmorris@intercode.com.au>
Subject: Re: [PATCH/proposal] dm-crypt: add digest-based iv generation mode
Message-ID: <20040228003900.GN3883@waste.org>
References: <1077651839.11170.4.camel@leto.cs.pocnet.net> <20040224203825.GV3883@waste.org> <20040225214308.GD3883@waste.org> <1077824146.14794.8.camel@leto.cs.pocnet.net> <20040226200244.GH3883@waste.org> <1077897901.29711.44.camel@leto.cs.pocnet.net> <20040227200214.GK3883@waste.org> <1077912813.2505.8.camel@leto.cs.pocnet.net> <20040227205501.GM3883@waste.org> <1077916595.2773.17.camel@leto.cs.pocnet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1077916595.2773.17.camel@leto.cs.pocnet.net>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 27, 2004 at 10:16:36PM +0100, Christophe Saout wrote:
> Am Fr, den 27.02.2004 schrieb Matt Mackall um 21:55:
> 
> > I certainly understand the issues of deep vs shallow copy. What I'm
> > saying is we should try to avoid needing deep copies in the first
> > place. They invite lots of complexity and for something as
> > straightforward as a cipher or digest should not be necessary.
> 
> Right. But we should still keep the ->init, ->copy, ->exit mechanism
> complete then, just because it's there and not having them fore some
> cases makes things just incomplete. Or we set the methods to NULL and
> the copy function only works if both init and exit are null, so we don't
> need the copy method because it also would be NULL and we know the
> algorithm doesn't use external structures. This would work for "fixed
> up" cipher and digest algorithms.
> 
> There's just one small difficulty with having some of the structures in
> the context: Their size is variable. But known after the init function.
> So the cra_ctxsize isn't sufficient to describe the length of a tfm
> strucure. So we need another per-algorithm-category method that returns
> the additional size required. They might just return iv_size or iv_size
> + omac_pad_size for ciphers and hmac_pad_size for digests or something
> like this.

Hmmm, crypto_alloc_tfm does:

        tfm = kmalloc(sizeof(*tfm) + alg->cra_ctxsize, GFP_KERNEL);

So I'm not clear on how the necessary size can be anything else at
copy time?
 
> > > Hmm. It should be there, but could return -EOPNOTSUPP. Copying a
> > > compress tfm doesn't make much sense. We need a way to detect things
> > > that are bad in a generic way, everything else is hacky.
> > 
> > Some way of preventing copies of some TFMs is called for, agreed.
> 
> What about the idea above?
> 
> I could think we could start from my patch and simple throw 70% away. ;)
> (or yours, it isn't too far either)

Either way.

> I'd like too keep my names: (init), copy, exit vs. alloc, clone and
> free.

Not terribly concerned about the naming, so long as the header file
makes it clear that every copy needs a matching cleanup call and not a
free.

-- 
Matt Mackall : http://www.selenic.com : Linux development and consulting
