Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275376AbTHITrK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Aug 2003 15:47:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275392AbTHITrK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Aug 2003 15:47:10 -0400
Received: from waste.org ([209.173.204.2]:16601 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S275376AbTHITqg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Aug 2003 15:46:36 -0400
Date: Sat, 9 Aug 2003 14:46:27 -0500
From: Matt Mackall <mpm@selenic.com>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org, jmorris@intercode.com.au
Subject: Re: [RFC][PATCH] Make cryptoapi non-optional?
Message-ID: <20030809194627.GV31810@waste.org>
References: <20030809074459.GQ31810@waste.org> <20030809010418.3b01b2eb.davem@redhat.com> <20030809140542.GR31810@waste.org> <20030809103910.7e02037b.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030809103910.7e02037b.davem@redhat.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 09, 2003 at 10:39:10AM -0700, David S. Miller wrote:
> On Sat, 9 Aug 2003 09:05:42 -0500
> Matt Mackall <mpm@selenic.com> wrote:
> 
> > All of which is a big waste of time if the answer to "is making
> > cryptoapi mandatory ok?" is no. So before embarking on the hard part,
> > I thought I'd ask the hard question.
> 
> I'm personally OK with it, and in fact I talked about this with James
> (converting random.c over to the crypto API and the implications)
> early on while we were first working on the crypto kernel bits.
> 
> But I fear some embedded folks might bark.  Especially if the
> resulting code size is significantly larger.

An alternate approach is:

- pull the minimum parts of SHA (and perhaps MD5) out of their
  respective cryptoapi modules into the core
- call that code directly from random, bypassing cryptoapi (and
  avoiding all the dynamic allocation and potential sleeping stuff)

Combined with a patch that does non-unrolled SHA, this should be about
the same as the present code.

> We could make it a config option CONFIG_RANDOM_CRYPTOAPI.

As the primary benefit here is elimination of duplicate code, I think
that's a non-starter.
 
> All of this analysis nearly requires a working implementation so
> someone can do a code-size and performance comparison between
> the two cases.  I know this is what you're trying to avoid, having
> to code up what might be just thrown away :(

Ok, can I export some more cryptoapi primitives?

  __crypto_lookup_alg(const char *name);
  __crypto_alg_tfm_size(const char *name);
  __crypto_setup_tfm(struct crypto_alg *alg, char *buf, int size, int flags);
  __crypto_exit_ops(...)
  __crypto_alg_put(...);

This would let me do alg lookup in my init and avoid the dynamic
allocation sleeping and performance hits.

Also, I posted to cryptoapi-devel that I need a way to disable the
unconditional padding on the hash functions.

-- 
Matt Mackall : http://www.selenic.com : of or relating to the moon
