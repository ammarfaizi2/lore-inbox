Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752360AbWKAUvy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752360AbWKAUvy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 15:51:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752363AbWKAUvy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 15:51:54 -0500
Received: from iriserv.iradimed.com ([69.44.168.233]:47425 "EHLO iradimed.com")
	by vger.kernel.org with ESMTP id S1752360AbWKAUvx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 15:51:53 -0500
Message-ID: <454908F9.80905@cfl.rr.com>
Date: Wed, 01 Nov 2006 15:52:09 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
MIME-Version: 1.0
To: =?ISO-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>
CC: Holden Karau <holden@pigscanfly.ca>,
       Josef Sipek <jsipek@fsl.cs.sunysb.edu>, hirofumi@mail.parknet.co.jp,
       linux-kernel@vger.kernel.org, Holden Karau <holdenk@xandros.com>,
       "akpm@osdl.org" <akpm@osdl.org>, linux-fsdevel@vger.kernel.org,
       Nick Piggin <nickpiggin@yahoo.com.au>, Matthew.Wilcox@vax.1wt.eu
Illegal-Object: Syntax error in CC: address found on vger.kernel.org:
	CC:	Matthew Wilcox
			^-extraneous tokens in address
Illegal-Object: Syntax error in CC: address found on vger.kernel.org:
	CC:	Matthew Wilcox
			^-extraneous tokens in address
Subject: Re: [PATCH 1/1] fat: improve sync performance by grouping writes
 revised again
References: <4548C8AE.2090603@pigscanfly.ca> <20061101164715.GC16154@wohnheim.fh-wedel.de> <f46018bb0611011002h1b3b6e5fjdc6cc032a7503dbd@mail.gmail.com> <20061101202400.GA6888@wohnheim.fh-wedel.de>
In-Reply-To: <20061101202400.GA6888@wohnheim.fh-wedel.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 01 Nov 2006 20:52:05.0873 (UTC) FILETIME=[96FFBE10:01C6FDF7]
X-TM-AS-Product-Ver: SMEX-7.2.0.1122-3.6.1039-14788.000
X-TM-AS-Result: No--10.996500-5.000000-31
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think this is getting into micro-optimization, which is usually bad. 
Also moving the assignment of err outside the body of the if only 
results in slightly faster code in the case where there is an error, 
since you can test and _maybe_ conditionally jump directly to the error: 
label if it is not very far away.  With the assignment in the body, the 
conditional jump must jump to the assignment followed by an 
unconditional jump to the label.

In other words, the only time this micro optimization will be of benefit 
is if you are erroring out most of the time rather than only under 
exceptional conditions, AND the error label isn't too far away for a 
conditional branch to reach.  In other words, just don't do it ;)

Jörn Engel wrote:
> On Wed, 1 November 2006 13:02:12 -0500, Holden Karau wrote:
>> On 11/1/06, Jörn Engel <joern@wohnheim.fh-wedel.de> wrote:
>>> Result would be something like:
>>>        c_bh = kmalloc(...
>>>        err = -ENOMEM;
>>>        if (!c_bh)
>>>                goto error;
>> That wouldn't work so well since we always return err,
> 
> I don't quite follow.  If the branch is taken, err is -ENOMEM.  If the
> branch is not taken, err is set to 0 with the next instruction.
> 
> Both methods definitely work.  Whether one is preferrable over the
> other is imo 90% taste and maybe 10% better code on some architecture.
> So just pick what you prefer.
> 
> Jörn
> 

