Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750803AbWC3USr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750803AbWC3USr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 15:18:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750804AbWC3USr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 15:18:47 -0500
Received: from mx1.redhat.com ([66.187.233.31]:42370 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750803AbWC3USq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 15:18:46 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <200603292051.k2TKpCde027872@baham.cs.pdx.edu> 
References: <200603292051.k2TKpCde027872@baham.cs.pdx.edu> 
To: Suzanne Wood <suzannew@cs.pdx.edu>
Cc: dhowells@redhat.com, linux-kernel@vger.kernel.org, paulmck@us.ibm.com
Subject: Re: [PATCH] Document Linux's memory barriers [try #5] 
X-Mailer: MH-E 7.92+cvs; nmh 1.1; GNU Emacs 22.0.50.4
Date: Thu, 30 Mar 2006 21:18:24 +0100
Message-ID: <27311.1143749904@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Suzanne Wood <suzannew@cs.pdx.edu> wrote:

> Do you mean to formalize preconditions on the value of Y and contents of A 
> and consider postconditions after the execution of the three statements of 
> the example where the value of X is the prior content of A and A contains and 
> Z equals the value of Y.

Something like that, yes.

How about the attached instead?  My explanation didn't give a write/write
example, so I've added that in too.

> Sorry to be unclear.  I was just asking about the explanation of the 
> self-consistent CPU example.  The other ideas in the document are more
> difficult, so thought this part might be simplified.

The whole subject is fraught with unclarity:-)

David


However, it is guaranteed that a CPU will be self-consistent: it will see its
_own_ accesses appear to be correctly ordered, without the need for a memory
barrier.  For instance with the following code:

	U = *A;
	*A = V;
	*A = W;
	X = *A;
	*A = Y;
	Z = *A;

and assuming no intervention by an external influence, it can be taken that the
final result will appear to be:

	U == the original value of *A
	X == W
	Z == Y
	*A == Y

The code above may cause the CPU to generate the full sequence of memory
accesses:

	U=LOAD *A, STORE *A=V, STORE *A=W, X=LOAD *A, STORE *A=Y, Z=LOAD *A

But, without intervention, the sequence may have almost any combination of
elements barring the load of *A into U and the store of Y into *A discarded as
the CPU may combine or discard memory accesses as it sees fit, provided _its_
view of the world is consistent.  This leads to the following possible other
sequences:

	U=LOAD *A, STORE *A=V, STORE *A=W, X=LOAD *A, STORE *A=Y
	U=LOAD *A, STORE *A=V, STORE *A=W, STORE *A=Y, Z=LOAD *A
	U=LOAD *A, STORE *A=V, STORE *A=W, STORE *A=Y
	U=LOAD *A, STORE *A=V, STORE *A=Y, Z=LOAD *A
	U=LOAD *A, STORE *A=V, STORE *A=Y
	U=LOAD *A, STORE *A=W, X=LOAD *A, STORE *A=Y
	U=LOAD *A, STORE *A=W, STORE *A=Y, Z=LOAD *A
	U=LOAD *A, STORE *A=W, STORE *A=Y
	U=LOAD *A, STORE *A=Y, Z=LOAD *A
	U=LOAD *A, STORE *A=Y

Note:

 (*) STORE *A=W can only be dispensed with if X=LOAD *A is also dispensed with,
     otherwise X would be given the original value of *A or the value assigned
     there from V, and not the value assigned there from W.

 (*) STORE *A=V would probably be discarded entirely by the CPU - if not the
     compiler - as it's effect is overridden by STORE *A=W without anything
     seeing it.

 (*) STORE *A=Y may be deferred indefinitely until the CPU has some reason to
     perform it or discard it.

 (*) Even the two 'fixed' operations can be dispensed with if they can be
     combined or discarded with respect to the surrounding code.

 (*) The compiler may also combine, discard or defer elements of the sequence
