Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270291AbTHQPbD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Aug 2003 11:31:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270295AbTHQPbD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Aug 2003 11:31:03 -0400
Received: from waste.org ([209.173.204.2]:39044 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S270291AbTHQPa7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Aug 2003 11:30:59 -0400
Date: Sun, 17 Aug 2003 10:30:44 -0500
From: Matt Mackall <mpm@selenic.com>
To: James Morris <jmorris@intercode.com.au>
Cc: "Theodore Ts'o" <tytso@mit.edu>, Jamie Lokier <jamie@shareable.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, davem@redhat.com,
       "Adam J. Richter" <adam@yggdrasil.com>
Subject: Re: [RFC][PATCH] Make cryptoapi non-optional?
Message-ID: <20030817153044.GM325@waste.org>
References: <20030816155110.GH325@waste.org> <Mutt.LNX.4.44.0308180036570.1683-100000@excalibur.intercode.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Mutt.LNX.4.44.0308180036570.1683-100000@excalibur.intercode.com.au>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 18, 2003 at 12:37:29AM +1000, James Morris wrote:
> On Sat, 16 Aug 2003, Matt Mackall wrote:
> 
> > Yes, but it's introduced by the requirements imposed by cryptoapi. The
> > current code uses the stack (though currently rather a lot of it),
> > which lets it be fully re-entrant. Not an option with cryptoapi.
> 
> This will be possible with your api flags patch, right?

No, it's a mostly orthogonal problem.

Let's say we start with:

int foo(char *a) {
      char *tmp[N]; /* context stored on stack */

      return nativehash(a, tmp);
}

The above is fully reentrant, interrupt safe and preemptible. Hurray
for stacks. We convert this to cryptoapi something like this
(simplified, don't try this at home kids):

int foo2(char *a) {
    crypto_tfm *hash;
    int ret;

    hash=crypto_alloc_tfm("hash");
    ret=crypto_digest_digest(hash, a);
    crypto_free(hash);

    return ret;
}

This is also fully reentrant, but its not safe to call in irq
contexts because of the allocation. So we do something like this:

static DEFINE_PER_CPU(struct crypto_tfm *, hash);

int foo_cpu_notify(cpu) {
{
	per_cpu(hash, (long)hcpu) = crypto_alloc_tfm("hash", 0);
}

int foo_init()
{
	/* set up per_cpu vars */
	foo_cpu_notify(smp_processor_id());
        register_cpu_notifier(&foo_nb);
}

int foo3(char *a) {
    crypto_tfm *hash;
    int ret;

    hash=get_cpu_var("hash");
    ret=crypto_digest_digest(hash, a);
    put_cpu_var(hash);

    return ret;
}

Now (ignoring the internals of the digest function, we can be called
from interrupt contexts and different CPUs safely and more
efficiently, but we've lost the property of being reentrant (either
via preemption or interrupt handlers) during hashing because there's
now only one context per cpu. So this is a regression from foo1.

[And this is where the other patch comes in: the per_cpu vars code
know that stuff using it is inherently unpreemptible so it increments
the preempt count. Cryptoapi's yielding code gets into trouble because
it's doing conditional rescheduling without being able to know that
its in a safe context. Consider spinlock critical sections on
UP/non-preempt for another example. The new flag sez "don't ever sleep
unless I tell you its safe"]

So my earlier suggestion was to add a couple functions to regain the
fully reentrant properties of foo1:

static crypto_alg alg;

int foo_init() {
    alg=crypto_alg_get("hash");
}

int foo4(char *a) {
    char tfm_buf[SIZE];

    hash=__crypto_init_tfm(alg, tfm_buff, SIZE);
    return crypto_digest_digest(hash, a);
}

There are other ways around the preempt problem, obviously, but this
is almost surely the simplest way with cryptoapi. And apparently the
cryptoloop folks would like something similar.

Now Dave can remind us why he doesn't like it.

-- 
Matt Mackall : http://www.selenic.com : of or relating to the moon
