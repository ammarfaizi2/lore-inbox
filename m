Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263130AbUB0VQs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 16:16:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263131AbUB0VQs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 16:16:48 -0500
Received: from websrv.werbeagentur-aufwind.de ([213.239.197.241]:62681 "EHLO
	mail.werbeagentur-aufwind.de") by vger.kernel.org with ESMTP
	id S263130AbUB0VQm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 16:16:42 -0500
Subject: Re: [PATCH/proposal] dm-crypt: add digest-based iv generation mode
From: Christophe Saout <christophe@saout.de>
To: Matt Mackall <mpm@selenic.com>
Cc: Jean-Luc Cooke <jlcooke@certainkey.com>, linux-kernel@vger.kernel.org,
       James Morris <jmorris@intercode.com.au>
In-Reply-To: <20040227205501.GM3883@waste.org>
References: <20040221021724.GA8841@leto.cs.pocnet.net>
	 <20040224191142.GT3883@waste.org>
	 <1077651839.11170.4.camel@leto.cs.pocnet.net>
	 <20040224203825.GV3883@waste.org> <20040225214308.GD3883@waste.org>
	 <1077824146.14794.8.camel@leto.cs.pocnet.net>
	 <20040226200244.GH3883@waste.org>
	 <1077897901.29711.44.camel@leto.cs.pocnet.net>
	 <20040227200214.GK3883@waste.org>
	 <1077912813.2505.8.camel@leto.cs.pocnet.net>
	 <20040227205501.GM3883@waste.org>
Content-Type: text/plain
Message-Id: <1077916595.2773.17.camel@leto.cs.pocnet.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 27 Feb 2004 22:16:36 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Fr, den 27.02.2004 schrieb Matt Mackall um 21:55:

> I certainly understand the issues of deep vs shallow copy. What I'm
> saying is we should try to avoid needing deep copies in the first
> place. They invite lots of complexity and for something as
> straightforward as a cipher or digest should not be necessary.

Right. But we should still keep the ->init, ->copy, ->exit mechanism
complete then, just because it's there and not having them fore some
cases makes things just incomplete. Or we set the methods to NULL and
the copy function only works if both init and exit are null, so we don't
need the copy method because it also would be NULL and we know the
algorithm doesn't use external structures. This would work for "fixed
up" cipher and digest algorithms.

There's just one small difficulty with having some of the structures in
the context: Their size is variable. But known after the init function.
So the cra_ctxsize isn't sufficient to describe the length of a tfm
strucure. So we need another per-algorithm-category method that returns
the additional size required. They might just return iv_size or iv_size
+ omac_pad_size for ciphers and hmac_pad_size for digests or something
like this.

> > Hmm. It should be there, but could return -EOPNOTSUPP. Copying a
> > compress tfm doesn't make much sense. We need a way to detect things
> > that are bad in a generic way, everything else is hacky.
> 
> Some way of preventing copies of some TFMs is called for, agreed.

What about the idea above?

I could think we could start from my patch and simple throw 70% away. ;)
(or yours, it isn't too far either)

I'd like too keep my names: (init), copy, exit vs. alloc, clone and
free.

Since the crypto_lookup_alg_tfm_size -> crypto_init_tfm thing is racy we
shouldn't implement it (at least for now). A solution would be to keep
an algorithm reference between both functions but that's ugly and
unintuitive. And if you want to do something like I suggested before you
can also use the copy mechanism.

So, we have an agreement then? :)


