Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263895AbTI2R3Q (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 13:29:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263899AbTI2R2z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 13:28:55 -0400
Received: from gaia.cela.pl ([213.134.162.11]:15369 "EHLO gaia.cela.pl")
	by vger.kernel.org with ESMTP id S263895AbTI2R0m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 13:26:42 -0400
Date: Mon, 29 Sep 2003 19:25:53 +0200 (CEST)
From: Maciej Zenczykowski <maze@cela.pl>
To: Valdis.Kletnieks@vt.edu
cc: Jamie Lokier <jamie@shareable.org>, Muli Ben-Yehuda <mulix@mulix.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] document optimizing macro for translating PROT_ to VM_
 bits 
In-Reply-To: <200309291551.h8TFpZtH028192@turing-police.cc.vt.edu>
Message-ID: <Pine.LNX.4.44.0309291918070.26827-100000@gaia.cela.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > +/* Optimisation macro, used to be defined as: */
> > > +/* ((bit1 == bit2) ? (x & bit1) : (x & bit1) ? bit2 : 0) */ 
> > > +/* but this version is faster */ 
> > > +/* "check if bit1 is on in 'x'. If it is, return bit2" */ 
> > >  #define _calc_vm_trans(x,bit1,bit2) \
> > >    ((bit1) <= (bit2) ? ((x) & (bit1)) * ((bit2) / (bit1)) \
> > >     : ((x) & (bit1)) / ((bit1) / (bit2)))
> > 
> > I agree with the intent of that comment, but the code in it is
> > unnecessarily complex.  See if you like this, and if you do feel free
> > to submit it as a patch:
> > 
> > /* Optimisation macro.  It is equivalent to:
> >       (x & bit1) ? bit2 : 0
> >    but this version is faster.  ("bit1" and "bit2" must be single bits). */
> 
> Is this supposed to return the bitmask bit2, or (x & bit2)?  If the former,
> then your code is right.  If the latter,  (x & bit1) ? (x & bit2) : 0
> 
> I'm totally failing to see why the original did the bit1 == bit2 compare,
> so maybe mhyself and Jamie are both missing some subtlety?

I'd guess since the majority of the time bit1 and bit2 are compile time 
constants and the comparison can be resolved during compilation into more 
effective code in the bit1==bit2 case, thus effectively decreasing not 
increasing the amount of generated object code.

That probably also explains why the convoluted long code with division
above is faster - the division and multiplication most likely gets
resolved during compile (since we're dealing with compile time constants)
into a single shift and results in an execution of bitop 'and' followed by
'shift left/right', which due to lacking and conditional branches
(necessary for ?:) is usually significantly faster due to a lack of 
branch mispredictions.

MaZe.


