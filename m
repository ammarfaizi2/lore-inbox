Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262451AbVE0NAv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262451AbVE0NAv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 09:00:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262471AbVE0M5y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 08:57:54 -0400
Received: from imf17aec.mail.bellsouth.net ([205.152.59.65]:64448 "EHLO
	imf17aec.mail.bellsouth.net") by vger.kernel.org with ESMTP
	id S262462AbVE0MzA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 08:55:00 -0400
Message-ID: <008801c562c2$b1094780$2800000a@pc365dualp2>
From: <cutaway@bellsouth.net>
To: <linux-kernel@vger.kernel.org>
References: <007001c56290$25dd4d00$2800000a@pc365dualp2> <200505271235.41353.vda@ilport.com.ua> <Pine.LNX.4.61L.0505271318580.14679@blysk.ds.pg.gda.pl>
Subject: Re: 387 emulator hack - mutant AAD trick - any objections?
Date: Fri, 27 May 2005 09:47:50 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1478
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1478
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Maciej W. Rozycki" <macro@linux-mips.org>
>
>  But certainly not worse than the alternatives for these processors which
> actually lack the x87 subset.
>

What I'm looking for is reasonable compromise on the space issue.  I'm
willing to spend a few bytes to help out the weak CPU's this will run on.
The embedded market (and whatever low end desktop machines are still out
there) is fairly size sensitive.  Cutting a few pages out might be the
difference between thrashing and not thrashing ;->  I've also got some GCC
hacks in mind so it can treat the SX differently than 386DX.  Right now it
doesn't distinguish and makes some very poor (for the SX) choices even when
told to space optimize.  Being hyper memory constrained, even something like
the ubiquitous MOV EAX,1 (5 bytes) is slower on the SX than XOR EAX,EAX (2
bytes)  / INC EAX (1 byte) - in fact the MOV is about 30% slower than the
XOR/INC :O  The situation reverses on the DX and 486.  386SX really needs
*completely* different code gen rules than DX or 486.

I just benchmarked the AAD performance versus alternatives on a 386SLC(a
modestly cached 386SX variation IBM produced) and the the AAD is visible
loser.  Using the AAM is a win over the existing code though.

I pondered on the the extended precision divide routine that's being called
in this loop and with a little underhanded treachery managed to eliminate a
push/pop of ESI from it by recycling EBP to address its parms once the frame
was no longer needed. This is an awsome trick when the code is simple enough
that you can get away with doing it and don't need to reference a bunch of
parameters.  In this case it only needed two, so you can peel the first off
using the normal EBP, then peel the second directly into EBP itself (which
destroys its usability to address the frame of course, but you've already
got what you wanted and don't care at that point<g>).  Then use EPB as you
might use ESI from then on and eliminate the save/restore of ESI.  Its
sneaky, but it works.

For a modest number of EBP references (less than 6 or so) the occasional
instruction plumping necessary with implied 0 displacements is well offset
by the elimination of sloshing a couple of dwords on and off the stack to
save a register.  push/pop dwords really hurt the SX .

