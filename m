Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267880AbUGaAol@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267880AbUGaAol (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jul 2004 20:44:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267882AbUGaAol
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jul 2004 20:44:41 -0400
Received: from taverner.CS.Berkeley.EDU ([128.32.168.222]:11721 "EHLO
	taverner.CS.Berkeley.EDU") by vger.kernel.org with ESMTP
	id S267880AbUGaAoj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jul 2004 20:44:39 -0400
From: David Wagner <daw@cs.berkeley.edu>
Message-Id: <200407310044.i6V0iOZe032440@taverner.CS.Berkeley.EDU>
Subject: Re: [PATCH] Delete cryptoloop
To: linux-kernel@vger.kernel.org
Date: Fri, 30 Jul 2004 17:44:24 -0700 (PDT)
In-Reply-To: <1091193219.11944.17.camel@leto.cs.pocnet.net> from "Christophe Saout" at Jul 30, 2004 03:13:39 PM
Secret-Bounce-Tag: 9a029cbee41caf2ca77a77efa3c13981
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> But we identified more problems (I don't if these are all real issues).
> Assuming the attacker has access to both plaintext and the encrypted
> disk. (shared storage, user account on the machine or something)
[...]

Yes, there are a host of potential attacks in this scenario.  That's why I
wrote that, if you find yourself in this threat model, it would be prudent
to assume that the current disk encryption scheme can potentially be
defeated.  Does anyone care about these threat models?  From the design,
I had assumed that no one cared, but if they are relevant in practice,
then it might make sense to investigate additional defenses.

The natural defense against these attacks would be to add a MAC, but this
has the disadvantage of increasing ciphertext lengths and thus may be
unsuitable for disk encryption.  Also, a MAC might still be susceptible
to some attacks based on cutting and splicing old ciphertext sectors
with new ciphertext sectors, or somesuch.  In other words, a vanilla MAC
does not ensure freshness (it doesn't stop replaying old ciphertexts),
unless it is augmented with additional mechanisms.  It is not clear to
me whether this would matter in practice.

An alternative possibility would be to use a tweakable block cipher.
The block width would be the size of the sector, and the sector number
would be used as the tweak.  This doesn't prevent the attacker from
fooling around with ciphertexts; it just ensures that if the attacker
changes what is on disk to some new value, then its decryption will be
randomized and unpredictable to the attacker.  One would have to spend
a little time thinking about whether this is good enough in practice.
Note that a tweakable block cipher retains the potential for replaying
old ciphertexts just like a MAC would.

Also, I haven't said anything about traffic analysis threats.  If the
attacker can observe the encrypted data on your hard disk at multiple
times, he may be able to identify some partial information about which
sectors or blocks of data have changed at which times.  There may be
some things one could do about this, if it matters to anyone.
