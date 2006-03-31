Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751373AbWCaOwB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751373AbWCaOwB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 09:52:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751376AbWCaOwB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 09:52:01 -0500
Received: from mx1.redhat.com ([66.187.233.31]:13277 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751373AbWCaOwA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 09:52:00 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <200603310055.k2V0trkY013523@murzim.cs.pdx.edu> 
References: <200603310055.k2V0trkY013523@murzim.cs.pdx.edu> 
To: Suzanne Wood <suzannew@cs.pdx.edu>
Cc: dhowells@redhat.com, linux-kernel@vger.kernel.org, paulmck@us.ibm.com
Subject: Re: [PATCH] Document Linux's memory barriers [try #5] 
X-Mailer: MH-E 7.92+cvs; nmh 1.1; GNU Emacs 22.0.50.4
Date: Fri, 31 Mar 2006 15:51:44 +0100
Message-ID: <19707.1143816704@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Suzanne Wood <suzannew@cs.pdx.edu> wrote:

> OK, you can dispense with a store if the value is not used before another
> store to the same memory location.  So if, for some other reason, X = *A
> goes away, you discard *A = W.

What I was actually thinking of is:

	*A = Y;
	Z = *A;

Can be changed by the compiler or the CPU into:

	*A = Y;
	Z = Y;

Which would eliminate the externally visible "Z = LOAD *A" entirely by
combination with the store.

However, that's reintroducing the concept of caching back into the abstract
CPU again - which complicates things once again.

I've decided to rewrite what I was trying to say to the attached.

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

and assuming no intervention by an external influence, it can be assumed that
the final result will appear to be:

	U == the original value of *A
	X == W
	Z == Y
	*A == Y

The code above may cause the CPU to generate the full sequence of memory
accesses:

	U=LOAD *A, STORE *A=V, STORE *A=W, X=LOAD *A, STORE *A=Y, Z=LOAD *A

in that order, but, without intervention, the sequence may have almost any
combination of elements combined or discarded, provided the program's view of
the world remains consistent.

The compiler may also combine, discard or defer elements of the sequence before
the CPU even sees them.

For instance:

	*A = V;
	*A = W;

may be reduced to:

	*A = W;

since, without a write barrier, it can be assumed that the effect of the
storage of V to *A is lost.  Similarly:

	*A = Y;
	Z = *A;

may, without a memory barrier, be reduced to:

	*A = Y;
	Z = Y;

and the LOAD operation never appear outside of the CPU.
