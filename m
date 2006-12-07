Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1163558AbWLGWuV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1163558AbWLGWuV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 17:50:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1163537AbWLGWuV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 17:50:21 -0500
Received: from smtpout.eastlink.ca ([24.222.0.30]:55926 "EHLO
	smtpout.eastlink.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1163558AbWLGWuS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 17:50:18 -0500
Date: Thu, 07 Dec 2006 18:50:13 -0400
From: Peter Cordes <peter@cordes.ca>
Subject: Re: [PATCH 1/4] [x86] Add command line option to enable/disable
 hyper-threading.
To: linux-kernel@vger.kernel.org
Message-id: <20061207225013.GA11890@cordes.ca>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Ah4FAKIpeEUY3umUVWdsb2JhbACNOAEr
X-IronPort-AV: i="4.09,511,1157338800";   d="scan'208";
 a="37488707:sNHT204153660"
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 (I'm not subscribed to the list, so this message looks like a normal reply,
but it isn't.  I didn't try to hack up an In-Reply-To: header...)

On Dec 1 2006, Linus Torvalds wrote:
>On Fri, 1 Dec 2006, Arjan van de Ven wrote:
>>
>> I would suggest you drop the patch; openssl has been long fixed, and it
>> was only a theoretical attack in the first place...
>> I'm not saying the attack isn't something that should be addressed.. but
>> it is, and disabling hyperthreading is not the right fix.
>
>I concur. A lot of these "timing attacks" may be slightly easier on HT
>CPU's than other CPU's, but they are still pretty damn theoretical (the
>more recent branch predictor one is even more so, since it apparently
>requires access to the branch predictor state itself, which you need
>CPL0 to get - and once you have CPL0, why the hell bother with the branch
>predictors at all, since you might as well just read the state directly
>from the process..)

 I recently read the paper by Aciicmez, Koc, and Seifert.
http://eprint.iacr.org/2006/351 (full text PDF available; It's a fairly
interesting read, with some background and overview of this kind of attack).

 They have a clever method for gathering information about the branch
predictor state, to attack one particular branch in the RSA code, which is
taken or not depending on the key bit.
- RSA and the attacker thread run on the same physical CPU.

- The attacker thread runs a loop that contains enough branches to ensure the
  branch being attacked is flushed from the branch target buffer.  Thus the
  CPU has to speculate that it's not taken.  If that's the case, then
  nothing special happens.

- If the branch is taken, then one of the attack loop's branches is evicted
  from the BTB.  When the attack loop hits that misprediction, it causes a
  cascade of mispredictions and BTB evictions, leading to a change in loop
  execution time greater than the noise.  They have plots showing some good
  runs and some noisier runs...

- That gives them enough resolution to get most of the key bits in a single
  run, so they don't have to average over multiple runs with the same input
  data.

- They attacked 512bit keys on OpenSSL 0.9.7e, with some modifications to
  make it simpler.  It's unclear from their wording whether they attacked
  both their simplified and the original, or if both their versions (with
  and without a balanced Montgomery powering ladder) were the result of
  modifying OpenSSL.

>So I think people have blown those SSL timing attacks _way_ out of
>proportion, just because it sounds technical and cool.

 I think this attack is technical and cool, regardless of whether it's
useful in the real world.  Obviously it requires running custom code on the
same machine as the process under attack, which can't happen in a lot of
server applications.  It could be effective against SSH on a multi-user
machine, though.

>Besides, most of the time you can disable HT in the BIOS, which is better
>anyway if you don't want it.

 If someone is trying to find a way to turn off HT, for security or
performance, it's better if they have to do it in a way that doesn't hurt
performance.  I don't like options that look useful but when you read the
fine print turn out to be non-optimal.

 If there was support for actually setting up the CPU the same way BIOSes do
when you HT is disabled that way, that would be cool.  It's always nice to
be able to change things without walking down to the machine room to get a
console on our cluster that doesn't have remote access to the BIOS setup.

-- 
#define X(x,y) x##y
Peter Cordes ;  e-mail: X(peter@cor , des.ca)

"The gods confound the man who first found out how to distinguish the hours!
 Confound him, too, who in this place set up a sundial, to cut and hack
 my day so wretchedly into small pieces!" -- Plautus, 200 BC
