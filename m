Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293276AbSDQQCI>; Wed, 17 Apr 2002 12:02:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293337AbSDQQCH>; Wed, 17 Apr 2002 12:02:07 -0400
Received: from seldon.terminus.sk ([195.146.17.130]:2947 "EHLO
	seldon.terminus.sk") by vger.kernel.org with ESMTP
	id <S293276AbSDQQCF>; Wed, 17 Apr 2002 12:02:05 -0400
Date: Wed, 17 Apr 2002 18:06:48 +0200 (CEST)
From: Marek Zelem <marek@terminus.sk>
To: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] + story;) on POSIX capabilities and SUID bit
In-Reply-To: <a9g1fb$onq$1@abraham.cs.berkeley.edu>
Message-ID: <Pine.LNX.4.33.0204171529380.25235-100000@seldon.terminus.sk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 16 Apr 2002, David Wagner wrote:

> Marek Zelem  wrote:
> >Our new formula:
> >  * (***) pP' = (fP & X) | (fI & pI)
> >  *       pI' = pP'
> >  *       pE' = ((pP' & pE) | fP) & X & fE
>
> Can you say anything about why this is safe and doesn't introduce
> vulnerabilities?  (The capabilities misfeature that caused sendmail
> 8.10.1 to leak root privilege really drove home for me the subtlety of
> this stuff.)

New 'permitted' capabilities for process are computed by the same formula as
the original because there is the primary aspiration to preserve the original
POSIX formula.
Most significat difference is in computation of 'inheritable' capabilities.
Original formula just keeps process 'inheritable' capabilities untouched.
(This fact was major problem of consolidate POSIX capabilities and SUID bit.)
New formula set the 'inheritable' capabilities to correspond with the new
'permitted'.
There can occur four situations:
	1) capability was in pI and will be in pI' - this correspond with
		the original formula
	2) capability wasn't in pI and will not be in pI' - this also
		correspond with the original formula
	3) capability was in pI and will not be in pI' - (so is not set
		in new pP) - meaning: proces is NOT able to raise self pP by
		executing "nosuid" binary. In this case is new formula
		more restrictive then original.
	4) capability wasn't in pI and will be in pI' - this can occure
		only if this capability is in fP. In this case this
		capability is also in pP'. And if is in 'permitted' caps
		then process is allowed to add this capability into
		'inheritable' caps. So we do nothin wrong if we set this
		capability into pI'.
Finally, difference in computation of pE' only aspirate to reflect pE.
Major principle was preserved: pE' = pP' & fE. In new formula was pP'
replaced by more complex term. But it's always true that
	(((pP' & pE) | fP) & X & fE) IS SUBSET of (pP' & fE).
So I think this is safe.

>
> Also, the meaning of fE and fP seem backwards from what I would have
> expected.  Maybe this reflects a lack in my understanding in capabilities,
> but I thought 'effective' refers to capabilities you're allowed to invoke
> at the moment, whereas 'permitted' refers to an upper bound on what
> capabilities you're allowed enable in 'effective', consequently I would
> have swapped the treatment of fE and fP.  Can you clear up my confusion?

File capabilities are little different from process capabilities. Meaninig
of file capabilities is:
	fP - capafilities which are "forced" to process by exec().
	     (sometimes called 'forced' capabilities)
	fI - capabilities which is "allowed" to remain in process 'permited'.
	     (sometimes called 'allowed' capabilities)
	fE - capabilities which select which of 'permited' will be
	     initially also 'effective'. (afrer exec() of course.)

>
> Finally, what's the story behind the changes to CAP_INIT_EFF_SET and
> CAP_INIT_INH_SET, and the business with CAP_SETPCAP?  If I understand
> correctly, one side-effect of this change is that you've changed cap_bset
> (X, the global bound on capabilities above) to add CAP_SETPCAP to it.
> Is this safe?  What motivated this change?  Did I understand correctly?

Yes, you understand correctly. Enabling CAP_SETPCAP is safe exactly as
enabling the CAP_SYS_MODULE, which is enabled by default. Capability
CAP_SYS_MODULE allows process to modify the cap_bset. Maybe I am wrong,
but my opinion is not to do inconsequential restrictions. So, this is
reason why I decide to change CAP_INIT_EFF_SET.

					Marek Zelem
--
  e-mail: marek@terminus.sk
  web: http://www.terminus.sk/~marek/
  pgp key: http://www.terminus.sk/~marek/gpg.txt




