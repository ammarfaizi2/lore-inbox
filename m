Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267359AbUI2TdU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267359AbUI2TdU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 15:33:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268854AbUI2TdU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 15:33:20 -0400
Received: from [69.25.196.29] ([69.25.196.29]:36831 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S267359AbUI2TcL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 15:32:11 -0400
Date: Wed, 29 Sep 2004 15:31:17 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Jean-Luc Cooke <jlcooke@certainkey.com>
Cc: linux@horizon.com, linux-kernel@vger.kernel.org, cryptoapi@lists.logix.cz
Subject: Re: [PROPOSAL/PATCH 2] Fortuna PRNG in /dev/random
Message-ID: <20040929193117.GB6862@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Jean-Luc Cooke <jlcooke@certainkey.com>, linux@horizon.com,
	linux-kernel@vger.kernel.org, cryptoapi@lists.logix.cz
References: <20040924005938.19732.qmail@science.horizon.com> <20040929171027.GJ16057@certainkey.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040929171027.GJ16057@certainkey.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While addition of the entropy estimator helps protect the Fortuna
Random number generator against a state extension attack, /dev/urandom
is using the same entropy extraction routine as /dev/random, and so
Fortuna is still vulernable to state extension attacks.  This is
because a key aspect of the Fortuna design has been ignored in JLC's
implementation.  

This missing piece to assure that a rekey can only take place when
there has been sufficient entropy built up in the higher order pools
in order to assure a catastrophic rekey.  Otherwise, the attacker can
simply brute force a wide variety of entropy inputs from the hardware,
and see if any of them matches output from the /dev/urandom (from
which the attacker is continuously pulling output).  So in the
original design, the rekey from a higher order pool only takes place
after k*2^n seconds, where n is the order of the pool, and k is some
constant.  The idea is that after some period of time hopefully one of
the pools has built up at least 128 bits or so worth of entropy, and
so the catastrophic reseeding will prevent an attacker from trying all
possible inputs and determining the state of the pool.  (Neils
recommends that k be at least a tenth of a second; see pages 38-40 of
http://th.informatik.uni-mannheim.de/people/lucks/papers/Ferguson/Fortuna.pdf).

Unfortunately, Fortuna will call random_reseed() after every single
read from /dev/urandom.  This is not time-limited at all, so as long
as the attacker can call /dev/urandom fast enough, it can continue to
monitor the various higher-level pools.  This can be fixed easily by
simply changing the rekey function so that it only attempts a reseed
after some period of time has gone by.

There is of course the question of whether a state extension attack is
realistic.  After all, most attacks where the attacker as sufficient
privileges to obtain the complete state of the RNG is also one where
the attacker also has enough privileges to install a rootkit, or
compromise the kernel by loading a hostile loadable kernel module,
etc.  Also, there is the question about whether an attacker could read
sufficient amounts of to keep track of the the contents of the pool,
and whether the attacker can either do the brute-forcing on the local
machine, or send the large amounts of information read from
/dev/urandom to an outside machine, without using enough CPU time that
it would be noticed by a system administrator ---- but then again, the
Crypto academics that are worried about things like state extension
attacks aren't worried about practical niceties.  But then again, if
we decide that state extension attacks aren't practically possible, or
otherwise not worthy of concern, or if JLC's Fortuna implementation is
vulnerable to state extension attacks, there's no reason to use JLC's
implementation in the first place.

						- Ted
