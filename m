Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261552AbTJWB5u (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Oct 2003 21:57:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261555AbTJWB5u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Oct 2003 21:57:50 -0400
Received: from smtp6.Stanford.EDU ([171.67.16.33]:59795 "EHLO
	smtp6.Stanford.EDU") by vger.kernel.org with ESMTP id S261552AbTJWB5r
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Oct 2003 21:57:47 -0400
Message-ID: <3F973590.5040707@stanford.edu>
Date: Wed, 22 Oct 2003 18:57:36 -0700
From: Andy Lutomirski <luto@stanford.edu>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5b; MultiZilla v1.5.0.1) Gecko/20030827
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Michael Glasgow <glasgowNOSPAM@beer.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: posix capabilities inheritance
References: <fa.f9mv0tb.27sf3j@ifi.uio.no> <200310230136.h9N1aZfn002145@dark.beer.net>
In-Reply-To: <200310230136.h9N1aZfn002145@dark.beer.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Glasgow wrote:
> Andy Lutomirski wrote:
> 
>>Maybe I misread the spec, but I thought it explicitly stated
>>pP' = (fP & X) | (fI & pI)
>>(I can't find it right now, though...)
> 
> 
> I don't see *any* rules for capabilities evolution explicitly
> defined.  There are some limitations and some mandatory characteristics
> that any rules of evolution must possess, and these seem to make
> sense to me as far as they go.  But there's no explicit "pP' = blah";
> perhaps there needs to be.

Section 3, line 36 or so of my copy of POSIX draft 1003.1e gives:

I1 = I0
P1 = (Pf && X) || (If && I0)
E1 = Ef && P1
[where P0 is pP and p1 is pP']

Not sure how relevant this is, though.

>>I would hope that, on a system that supports file capabilities, a
>>file w/o capabilities set and w/o setuid would behave exactly like
>>a file with some "default" capabilities.  In my patch, these
>>capabilities are (=ei).  In mainline Linux, there is no such
>>capability set (witness the logic in cap_binprm_set_security).
> 
> 
> I agree for the most part, but why would you choose (=ei) rather
> than just (=i)?

I don't really see the point of fE in any case, but, since traditional POSIX 
apps have no concept of disables capabilities, I figured that all capabilities 
enabled should be the default.

In any case, it could be useful to use (=i) to mean "this process shouldn't use 
capabilities by default" or (=ip) to mean "this process is privileged, but it 
shouldn't use those privileges without knowing what it's doing".  Neither 
version seems to offer any real security benefit, but if (=i) were the default, 
then I don't see the benefit of (=ei).



> [...] Also, what in your opinion should be the meaning
> of (fE != 0 && fP=0) versus (fE != 0 && fP = fE)?

fP (in my mind) means "this file gets these capabilities always" while fE means 
"if this file has these capabilities after exec evolution rules, then they 
should be enabled _unless they were already disabled."  I could easily be 
convinced that I'm wrong, though.

>>With the (POSIX) rule pE' = pP' & fE, the dumpcap process would
>>have been uid=0, euid=500, and all caps effective, which is
>>inconsistant with traditional semantics.  Linux currently works
>>correctly because fE and fP are dependent on initial uid and euid.
> 
> 
> I do not think that rule is specified by the POSIX 1003.1e draft
> either, although it is compliant.  Necessary distinction because
> I believe we can change the rules in various ways and still be
> compliant, if that is important.

I don't think it really matters, but I changed my patch to be closer to the 
rules quoted above.  Remember that this draft is withdrawn.


> Also, it is clear that the inconsistency you point out is due to
> your assumption that a file with no capabilities is (=ei) by default.
> If it were (=i), then this problem goes away, right?

I think this just changes the problem.  The POSIX rule (assuming my copy isn't 
bogus) gives pE = pP' & fE, which means that (if fE==0) any program that root 
wants to run with caps (most often CAP_DAC_OVERRIDE I presume) needs to either 
have fE explicitly set to full or be rewritten to enable its capabilities.  This 
breaks userspace.


Andy

