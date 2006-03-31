Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751098AbWCaA4g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751098AbWCaA4g (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 19:56:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751099AbWCaA4g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 19:56:36 -0500
Received: from lead.cat.pdx.edu ([131.252.208.91]:3800 "EHLO lead.cat.pdx.edu")
	by vger.kernel.org with ESMTP id S1751098AbWCaA4f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 19:56:35 -0500
Date: Thu, 30 Mar 2006 16:55:53 -0800 (PST)
From: Suzanne Wood <suzannew@cs.pdx.edu>
Message-Id: <200603310055.k2V0trkY013523@murzim.cs.pdx.edu>
To: dhowells@redhat.com
Cc: linux-kernel@vger.kernel.org, paulmck@us.ibm.com
Subject: Re: [PATCH] Document Linux's memory barriers [try #5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.  Just minor questions below.  Thank you.

  > From: "David Howells" Thursday, March 30, 2006 12:18 PM
  > 
  > Suzanne Wood <suzannew@cs.pdx.edu> wrote:
  > 
  > > Do you mean to formalize preconditions on the value of Y and contents of A 
  > > and consider postconditions after the execution of the three statements of 
  > > the example where the value of X is the prior content of A and A contains and 
  > > Z equals the value of Y.
  > 
  > Something like that, yes.
  > 
  > How about the attached instead?  My explanation didn't give a write/write
  > example, so I've added that in too.
  > 
  > > Sorry to be unclear.  I was just asking about the explanation of the 
  > > self-consistent CPU example.  The other ideas in the document are more
  > > difficult, so thought this part might be simplified.
  > 
  > The whole subject is fraught with unclarity:-)
  > 
  > David
  > 
  > 
  > However, it is guaranteed that a CPU will be self-consistent: it will see its
  > _own_ accesses appear to be correctly ordered, without the need for a memory
  > barrier.  For instance with the following code:
  > 
  > 	U = *A;
  > 	*A = V;
  > 	*A = W;
  > 	X = *A;
  > 	*A = Y;
  > 	Z = *A;
  > 
  > and assuming no intervention by an external influence, it can be taken that the
  > final result will appear to be:
  > 
  > 	U == the original value of *A
  > 	X == W
  > 	Z == Y
  > 	*A == Y
  > 
  > The code above may cause the CPU to generate the full sequence of memory
  > accesses:
  > 
  > 	U=LOAD *A, STORE *A=V, STORE *A=W, X=LOAD *A, STORE *A=Y, Z=LOAD *A
  > 
  > But, without intervention, the sequence may have almost any combination of
  > elements barring the load of *A into U and the store of Y into *A discarded as
  > the CPU may combine or discard memory accesses as it sees fit, provided _its_
  > view of the world is consistent.  This leads to the following possible other
  > sequences:
  > 
  > 	U=LOAD *A, STORE *A=V, STORE *A=W, X=LOAD *A, STORE *A=Y
  > 	U=LOAD *A, STORE *A=V, STORE *A=W, STORE *A=Y, Z=LOAD *A
  > 	U=LOAD *A, STORE *A=V, STORE *A=W, STORE *A=Y
  > 	U=LOAD *A, STORE *A=V, STORE *A=Y, Z=LOAD *A
  > 	U=LOAD *A, STORE *A=V, STORE *A=Y
  > 	U=LOAD *A, STORE *A=W, X=LOAD *A, STORE *A=Y
  > 	U=LOAD *A, STORE *A=W, STORE *A=Y, Z=LOAD *A
  > 	U=LOAD *A, STORE *A=W, STORE *A=Y
  > 	U=LOAD *A, STORE *A=Y, Z=LOAD *A
  > 	U=LOAD *A, STORE *A=Y
  > 
  > Note:
  > 
  >  (*) STORE *A=W can only be dispensed with if X=LOAD *A is also dispensed with,
  >      otherwise X would be given the original value of *A or the value assigned
  >      there from V, and not the value assigned there from W.

OK, you can dispense with a store if the value is not used before another store 
to the same memory location.  So if, for some other reason, X = *A goes away, 
you discard *A = W.

  >  (*) STORE *A=V would probably be discarded entirely by the CPU - if not the
  >      compiler - as it's effect is overridden by STORE *A=W without anything
  >      seeing it.

Right, why include STORE *A=V on the first three possibilities?

  >  (*) STORE *A=Y may be deferred indefinitely until the CPU has some reason to
  >      perform it or discard it.

What's Z see?  Or is that load what you refer to as the reason to perform the store?

  >  (*) Even the two 'fixed' operations can be dispensed with if they can be
  >      combined or discarded with respect to the surrounding code.
  > 
  >  (*) The compiler may also combine, discard or defer elements of the sequence

Should these comments support the final result you provided above?  
E.g., X <- W may disappear in terms of your first note.
Thanks.
Suzanne
