Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933575AbWK0Uq6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933575AbWK0Uq6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 15:46:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933627AbWK0Uq6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 15:46:58 -0500
Received: from taverner.CS.Berkeley.EDU ([128.32.168.222]:31179 "EHLO
	taverner.cs.berkeley.edu") by vger.kernel.org with ESMTP
	id S933575AbWK0Uq5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 15:46:57 -0500
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: daw@cs.berkeley.edu (David Wagner)
Newsgroups: isaac.lists.linux-kernel
Subject: Re: Entropy Pool Contents
Date: Mon, 27 Nov 2006 20:40:16 +0000 (UTC)
Organization: University of California, Berkeley
Message-ID: <ekfifg$n41$1@taverner.cs.berkeley.edu>
References: <ek2nva$vgk$1@sea.gmane.org> <456B3483.4010704@cfl.rr.com> <ekfehh$kbu$1@taverner.cs.berkeley.edu> <456B4CD2.7090208@cfl.rr.com>
Reply-To: daw-usenet@taverner.cs.berkeley.edu (David Wagner)
NNTP-Posting-Host: taverner.cs.berkeley.edu
X-Trace: taverner.cs.berkeley.edu 1164660016 23681 128.32.168.222 (27 Nov 2006 20:40:16 GMT)
X-Complaints-To: news@taverner.cs.berkeley.edu
NNTP-Posting-Date: Mon, 27 Nov 2006 20:40:16 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: daw@taverner.cs.berkeley.edu (David Wagner)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Phillip Susi  wrote:
>David Wagner wrote:
>> Nope, I don't think so.  If they could, that would be a security hole,
>> but /dev/{,u}random was designed to try to make this impossible, assuming
>> the cryptographic algorithms are secure.
>> 
>> After all, some of the entropy sources come from untrusted sources and
>> could be manipulated by an external adversary who doesn't have any
>> account on your machine (root or non-root), so the scheme has to be
>> secure against introduction of maliciously chosen samples in any event.
>
>Assuming it works because it would be a bug if it didn't is a logical 
>fallacy.  Either the new entropy pool is guaranteed to be improved by 
>injecting data or it isn't.  If it is, then only root should be allowed 
>to inject data.  If it isn't, then the entropy estimate should increase 
>when the pool is stirred.

Sorry, but I disagree with just about everything you wrote in this
message.  I'm not committing any logical fallacies.  I'm not assuming
it works because it would be a bug if it didn't; I'm just trying to
help you understand the intuition.  I have looked at the algorithm
used by /dev/{,u}random, and I am satisfied that it is safe to feed in
entropy samples from malicious sources, as long as you don't bump up the
entropy counter when you do so.  Doing so can't do any harm, and cannot
reduce the entropy in the pool.  However, there is no guarantee that
it will increase the entropy.  If the adversary knows what bytes you
are feeding into the pool, then it doesn't increase the entropy count,
and the entropy estimate should not be increased.

Therefore:
  - It is safe to allow non-root users to inject data into the pool
    by writing to /dev/random, as long as you don't bump up the entropy
    estimate.  Doing so cannot decrease the amount of entropy in the
    pool.
  - It is not a good idea to bump up the entropy estimate when non-root
    users write to /dev/random.  If a malicious non-root user writes
    the first one million digits of pi to /dev/random, then this hasn't
    increased the uncertainty that this attacker has in the pool, so
    you shouldn't increase the entropy estimate.
  - Whether you automatically bump up the entropy estimate when
    root users write to /dev/random is a design choice where you could
    reasonably go either way.  On the one hand, you might want to ensure
    that root has to take some explicit action to allege that it is
    providing a certain degree of entropy, and you might want to insist
    that root tell /dev/random how much entropy it added (since root
    knows best where the data came from and how much entropy it is likely
    to contain).  On the other hand, you might want to make it easier
    for shell scripts to add entropy that will count towards the overall
    entropy estimate, without requiring them to go through weird
    contortions to call various ioctl()s.  I can see arguments both
    ways, but the current behavior seems reasonable and defensible.

Note that, in any event, the vast majority of applications should be
using /dev/urandom (not /dev/random!), so in an ideal world, most of
these issues should be pretty much irrelevant to the vast majority of
applications.  Sadly, in practice many applications wrongly use
/dev/random when they really should be using /dev/urandom, either out
of ignorance, or because of serious flaws in the /dev/random man page.
