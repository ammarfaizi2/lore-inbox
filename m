Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136825AbRECOz6>; Thu, 3 May 2001 10:55:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136822AbRECOzt>; Thu, 3 May 2001 10:55:49 -0400
Received: from mercury.ultramaster.com ([208.222.81.163]:15004 "EHLO
	mercury.ultramaster.com") by vger.kernel.org with ESMTP
	id <S136825AbRECOzl>; Thu, 3 May 2001 10:55:41 -0400
Message-ID: <3AF17135.F52C889D@dm.ultramaster.com>
Date: Thu, 03 May 2001 10:54:45 -0400
From: David Mansfield <lkml@dm.ultramaster.com>
Organization: Ultramaster Group LLC
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: esr@thyrsus.com
CC: Alexander Viro <viro@math.psu.edu>,
        Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
        CML2 <linux-kernel@vger.kernel.org>,
        kbuild-devel@lists.sourceforge.net
Subject: Re: Why recovering from broken configs is too hard
In-Reply-To: <20010503104511.C754@nightmaster.csn.tu-chemnitz.de> <Pine.GSO.4.21.0105030452310.15957-100000@weyl.math.psu.edu> <20010503054349.C28728@thyrsus.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Eric S. Raymond" wrote:
> 
> Alexander Viro <viro@math.psu.edu>:
> > Assertion: you can split the set of variables into disjoint union of
> > small subsets X, Y_1,...,Y_m such that each constraint is concerned
> > only with variables from X and at most one of Y_i.
> >
> > IOW, there is a small "core" and for fixed values of core variables
> > constraints fall into groups, each dealing with its own _small_
> > set of variables.
> >
> > If that assertion is true the complexity is nowhere near 3^N.
> >
> > Eric, you probably have the most accurate information about the
> > existing constraints. Care to verify the assertion above? I'm
> > serious - the set of constraints is very far from generic and
> > if nothing else, such preprocessing (splitting variables into
> > core and peripherial groups) can make life easier in other
> > parts of the thing.
> 
> You're almost right.  If you counted only explicit constraints,
> created by require statements, you get a bunch of cliques that
> aren't that large.
> 
> Unfortunately....there are a huge bunch of implicit constraints
> created by dependency relationships in the menu tree.  For example,
> all SCSI cards are dependents of the SCSI symbol.  Set SCSI to N
> and all the card symbols get turned off; set any card symbol to Y or M
> and the value of SCSI goes to Y or M correspondingly.
> 


Are the dependencies for each disjoint union kept hierarchically?  Such
as:

setting C = 'y' requires B = 'y'
setting B = 'y' requires A = 'y' 

etc.

If so, given the above ruleset involving symbols A, B and C, and given
that such a ruleset is violated for some reason (you don't even care
why), use the following approach:

set C to 'n' -> are we ok?
set B to 'n' -> are we ok?
set A to 'n' -> are we ok?

Inform the user of each change.  In a massively broken configuration you
could end up with a lot of stuff set to 'n' ultimately, but I think that
this generally would just end up shutting off troublesome configuration
settings, and requiring that the user then reset them manually.

In my example above I've idealized your idealized world of tristates
into a world of bistates.  How do you like that :-)

Instead of trying all possible combinations, instead for 2000 symbols
you only need (worst case) to check 2000 - each iteration you will have
changed one setting from y to n, so the most you can do is 2000 checks.

David

-- 
David Mansfield                                           (718) 963-2020
david@ultramaster.com
Ultramaster Group, LLC                               www.ultramaster.com
