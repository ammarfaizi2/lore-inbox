Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313087AbSGBWjP>; Tue, 2 Jul 2002 18:39:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313867AbSGBWjO>; Tue, 2 Jul 2002 18:39:14 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:11933 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S313087AbSGBWjN>;
	Tue, 2 Jul 2002 18:39:13 -0400
Date: Tue, 2 Jul 2002 18:41:42 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Brian Gerst <bgerst@didntduck.org>
cc: Keith Owens <kaos@ocs.com.au>, linux-kernel@vger.kernel.org
Subject: Re: RE2: [OKS] Module removal
In-Reply-To: <3D212757.5040709@quark.didntduck.org>
Message-ID: <Pine.GSO.4.21.0207021823310.6472-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



[Apologies for over-the-head reply]

> Keith Owens wrote:
> > 1) Do the reference counting outside the module, before it is entered.
> > 
> >    This is why Al Viro added the owner: __THIS_MODULE; line to various
> >    structures.  The problem is that it spreads like a cancer.  Every
> >    structure that contains function pointers needs an owner field.
> >    Every bit of code that dereferences a function pointer must first
> >    bump the owner's use count (using atomic ops) and must cope with the
> >    owner no longer existing.

a) How many place of that kind do we have?
b) How many structures have 'owner' field?  How many instances of these
   structures exist and how large each of them is? 

> >    Not only does this pollute all structures that contain function
> >    pointers, it introduces overhead on every function dereference.  All

	Not true.  As the matter of fact, for all such structures we have
activation points - open/mount/exec/etc.  All subsequent uses are
protected by that - e.g. if ->write() is called outside of ->open()/->release()
range we are fucked regardless of modules, since ->write() can refer to the
structures created by ->open() and torn down by ->release().

	I would really like to see hard data - either from you or from
Rusty - regarding the overhead you are talking about.  As it is, the
only major class of structures that have ->owner is file_operations
of character devices.  Everything else is red herring - too few instances
to talk about (e.g. each binfmt type compiled into the kernel wastes a
word - all 4 or 5 of them).

	And with file_operations we are talking about a word in a structure
that currently consists of 18 words.  And has 200-300 instances in the
kernel with every filesystem and every driver compiled in.  In real-world
cases you'll have ~40 of these.  Pardon me when I don't take the talks about
overhead seriously in this case.  Especially since your quiescense code will
take more than a kilobyte.

	Folks, how about you give some numbers - "spreads like a cancer"
would be great on a talk show, but I'd expect something better on l-k...

