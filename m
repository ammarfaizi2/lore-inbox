Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263544AbTJVTlP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Oct 2003 15:41:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263553AbTJVTlO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Oct 2003 15:41:14 -0400
Received: from smtp4.Stanford.EDU ([171.67.16.29]:17368 "EHLO
	smtp4.Stanford.EDU") by vger.kernel.org with ESMTP id S263544AbTJVTlJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Oct 2003 15:41:09 -0400
Message-ID: <3F96DD46.2030206@stanford.edu>
Date: Wed, 22 Oct 2003 12:40:54 -0700
From: Andy Lutomirski <luto@stanford.edu>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5b; MultiZilla v1.5.0.1) Gecko/20030827
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Michael Glasgow <glasgow@beer.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: posix capabilities inheritance
References: <fa.f36f4t9.1rg8j3v@ifi.uio.no> <200310220711.h9M7BKAf099719@dark.beer.net>
In-Reply-To: <200310220711.h9M7BKAf099719@dark.beer.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Michael Glasgow wrote:

> 
> Certainly with the current rule as implemented in 2.4, it looks as
> though you can regain permitted flags: pP' = (fP & X) | (fI & pI)
> 
> Is this what you mean when you say they can reappear? 

yes.  Intuitively, a process w/o some permitted capability should _never_ 
(unless fP != 0) get that capability back by calling exec.  This happens in 2.4 
and 2.6 in a worse way right now, though.  Any uid=0 process that calls exec (if 
cap_bset is untouched) will regain all capabilities, making it (mostly) 
ineffective to restrict root processes.  At the same time, non-root processes 
with extra caps can't usefully call helpers.  I think this is the problem you 
originally noticed.

> [...] WRT the
> spec itself, I don't see this assumption.  The rule could just as
> easily be:  pP' = (fP & X) | (pP & fI & pI)  (just an example)
> The rule in your patch seems like it should be compliant as well.

Maybe I misread the spec, but I thought it explicitly stated
pP' = (fP & X) | (fI & pI)
(I can't find it right now, though...)

>>2. If a process has pE < pP (i.e. some caps disabled, e.g. uid=0,
>>euid!=0), and exec's fE=full, then its capabilities get re-enabled.
>>This seems like a pretty serious breakage of userspace.
> 
> 
> How is this any different from traditional *nix setuid semantics?
> I suppose I can see your point somewhat if you are concerned
> specifically about the case where pE < pP execs fE=full && fP=0,
> but I am unconvinced this constitutes serious breakage.  On the
> contrary, I think it seems most reasonable for those caps to be
> reenabled, especially for caps where fI=1, but perhaps even when
> fI=0.


I would hope that, on a system that supports file capabilities, a file w/o 
capabilities set and w/o setuid would behave exactly like a file with some 
"default" capabilities.  In my patch, these capabilities are (=ei).  In mainline 
Linux, there is no such capability set (witness the logic in 
cap_binprm_set_security).

As a test, this is IMHO correct: (-test-6 + my patch + both options on)

$ cp `which bash` .
$ chmod 4755 bash
$ su
Password:
# ./bash -p
$ dumpcap [a trivial program I wrote]
         Real        Eff
User    0           500
Group   0           0

Caps: =ip

The bash -p process has uid = 0, euid = 500.  When it execs dumpcap, neither its 
uid nor its euid change, so, in traditional POSIX, it should have no effective 
capabilities (as it acts like uid 500).  (Should it have CAP_SETUID?  My patch 
doesn't change this behavior, but I'm not sure it's correct right now.)

With the (POSIX) rule pE' = pP' & fE, the dumpcap process would have been uid=0, 
euid=500, and all caps effective, which is inconsistant with traditional 
semantics.  Linux currently works correctly because fE and fP are dependent on 
initial uid and euid.


--Andy

