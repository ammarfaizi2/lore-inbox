Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933835AbWK0Vw0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933835AbWK0Vw0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 16:52:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933836AbWK0Vw0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 16:52:26 -0500
Received: from smtpout.mac.com ([17.250.248.177]:44260 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S933835AbWK0VwY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 16:52:24 -0500
In-Reply-To: <ekfifg$n41$1@taverner.cs.berkeley.edu>
References: <ek2nva$vgk$1@sea.gmane.org> <456B3483.4010704@cfl.rr.com> <ekfehh$kbu$1@taverner.cs.berkeley.edu> <456B4CD2.7090208@cfl.rr.com> <ekfifg$n41$1@taverner.cs.berkeley.edu>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <EB3E5F09-6529-4AB9-B7EF-DFCACC6D445E@mac.com>
Cc: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: Entropy Pool Contents
Date: Mon, 27 Nov 2006 16:52:19 -0500
To: daw-usenet@taverner.cs.berkeley.edu (David Wagner)
X-Mailer: Apple Mail (2.752.2)
X-Brightmail-Tracker: AAAAAA==
X-Brightmail-scanned: yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 27, 2006, at 15:40:16, David Wagner wrote:
> Phillip Susi  wrote:
>> David Wagner wrote:
>>> Nope, I don't think so.  If they could, that would be a security  
>>> hole, but /dev/{,u}random was designed to try to make this  
>>> impossible, assuming the cryptographic algorithms are secure.

Actually, our current /dev/random implementation is secure even if  
the cryptographic algorithms can be broken under traditional  
circumstances.  Essentially /dev/random will refuse to output any  
more data well before enough could be revealed to predict the current  
pool state, such that it is fairly secure even in the event of total  
failure of the cryptographic primatives.

>>> After all, some of the entropy sources come from untrusted  
>>> sources and could be manipulated by an external adversary who  
>>> doesn't have any account on your machine (root or non-root), so  
>>> the scheme has to be secure against introduction of maliciously  
>>> chosen samples in any event.

The way the /dev/random pool works is that writes are always  
guaranteed to add entropy to the pool (or at least never remove it),  
even if someone runs "dd if=/dev/zero of=/dev/random".  The initial  
state for any given write is secure, and when hashing a random value  
for which a significant part of the state has not even been  
theoretically revealed with a known value, the result is still  
random.  Even beyond that, the random pool also hashes the current  
value of the cycle-counter or time of day into the pool with each  
call, adding a bit of extra entropy in any case.  The same hashing of  
the time of day also occurs on reads.

>> Assuming it works because it would be a bug if it didn't is a  
>> logical fallacy.  Either the new entropy pool is guaranteed to be  
>> improved by injecting data or it isn't.  If it is, then only root  
>> should be allowed  to inject data.  If it isn't, then the entropy  
>> estimate should increase when the pool is stirred.

Well, actually the entropy pool is guaranteed not to lose entropy  
when it is stirred with data, but the whole point is to ensure that  
no userspace program *ever* has enough knowledge of the state of the  
pool to even begin a theoretical attack against past or future random  
values.  As a result it is perfectly OK for programs to dump whatever  
data they want into the random pool as extra security for _itself_,  
but the kernel does not trust it as extra security for itself.  Only  
root may inject guaranteed entropy and even then only using a  
specific ioctl, but any program may stir up the entropy pool however  
much it likes.

> I am satisfied that it is safe to feed in entropy samples from  
> malicious sources, as long as you don't bump up the entropy counter  
> when you do so.  Doing so can't do any harm, and cannot reduce the  
> entropy in the pool.  However, there is no guarantee that it will  
> increase the entropy.  If the adversary knows what bytes you are  
> feeding into the pool, then it doesn't increase the entropy count,  
> and the entropy estimate should not be increased.

Exactly.

> Note that, in any event, the vast majority of applications should  
> be using /dev/urandom (not /dev/random!), so in an ideal world,  
> most of these issues should be pretty much irrelevant to the vast  
> majority of applications.  Sadly, in practice many applications  
> wrongly use /dev/random when they really should be using /dev/ 
> urandom, either out of ignorance, or because of serious flaws in  
> the /dev/random man page.

Precisely.  Personally I generate my random passwords using a little  
perl script reading from /dev/random (as opposed to /dev/urandom) but  
that's more due to personal paranoia than any practical reason.

When generating long-term cryptographic private keys, however, you  
*should* use /dev/random as it provides better guarantees about  
theoretical randomness security than does /dev/urandom.  Such  
guarantees are useful when the random data will be used as a  
fundamental cornerstone of data security for a server or network  
(think your root CA certificate or HTTPS certificate for your million- 
dollar-per-year web store).

Cheers,
Kyle Moffett

