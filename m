Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263404AbRFRXgp>; Mon, 18 Jun 2001 19:36:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263416AbRFRXge>; Mon, 18 Jun 2001 19:36:34 -0400
Received: from imladris.infradead.org ([194.205.184.45]:22287 "EHLO
	infradead.org") by vger.kernel.org with ESMTP id <S263404AbRFRXg1>;
	Mon, 18 Jun 2001 19:36:27 -0400
Date: Tue, 19 Jun 2001 00:36:24 +0100 (BST)
From: Riley Williams <rhw@MemAlpha.CX>
X-X-Sender: <rhw@infradead.org>
To: Ivan Vadovic <pivo@pobox.sk>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: any good diff merging utility?
In-Reply-To: <20010618023459.C1063@ivan.doma>
Message-ID: <Pine.LNX.4.33.0106190016400.2197-100000@infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ivan.

 >>> I like to build kernels with a bunch of patches on top to test
 >>> new stuff. The problem is that it takes a lot of effort to fix
 >>> all the failed hunks during patching that really wouldn't have
 >>> to be failed if only patch was a little more inteligent and
 >>> could merge several patches into one ( if possible) or if could
 >>> take into account already applied patches.

 >> The basic problem here is that the "failed hunks" are usually there
 >> because of conflicts between the two patches in question, and as a
 >> result, they are not as easy to merge automagically as one might at
 >> first assume.

 > Very often the case is that they indeed can be merged automagically.
 > For example two patches inserting few lines right after the #include
 > lines.

 > patch1:
 > @@ 10,1 10,2 @@
 >  #include <foo.h>
 > +#include <1.h>

 > patch2:
 > @@ 10,1 10,2 @@
 >  #include <foo.h>
 > +#include <2.h>

 > The patch will fail to patch :-). But there is no real conflict
 > between the patches.

True, but how about the following (from one I had to merge recently):

 Q> patch1:
 Q> @@ 137,3 142,5
 Q>  for( ptr=head; *ptr; ptr=ptr->next ) {
 Q> +   ctr += ptr->qty;
 Q>     table[ctr] += ptr->qty;
 Q> +   total += table[ctr];
 Q>  }

 Q> patch2:
 Q> @@ 137,2 146,3
 Q>  for( ptr=head; *ptr; ptr=ptr->next ) {
 Q> +   total += table[ctr];
 Q>     table[ctr] += ptr->qty;

How would you merge those two patches?

 >>> Well, are there any utilities to merge diffs? I couldn't find
 >>> any on freshmeat. So what are you using to stack many patches
 >>> onto the kernel tree? Just manualy modify the diff? I'll try to
 >>> write something more automatic if nothing comes up.

 >> I once came across a utility called "diff3" that was designed to
 >> take a patch for one version of a package and create an
 >> equivalent patch for another version of the same package, but I
 >> haven't been able to find it again since my hard drive crashed.

 > diff3 comes from gnu diffutils
 > <ftp://ftp.gnu.org/gnu/diffutils/diffutils-2.7.tar.gz>. But all
 > it does is comparing three FILES for differencies.

If it does that, then it does all you need. Assume, for example, that
you have two patches to ORIGINAL.DOC that overlap each other, these
being PATCH1.DIFF and PATCH2.DIFF respectively...

 Q> gzip -9 < ORIGINAL.DOC > ORIGINAL.DOC.GZ
 Q> patch < PATCH1.DIFF
 Q> mv ORIGINAL.DOC ORIGINAL.DOC.V1
 Q> gunzip < ORIGINAL.DOC.GZ > ORIGINAL.DOC
 Q> patch < PATCH2.DIFF
 Q> mv ORIGINAL.DOC ORIGINAL.DOC.V2

At this point, you have copies of the patched versions of that file as
produced by the two patches separately. If my memory's right (I don't
have diff3 to hand) you then do...

 Q> diff3 ORIGINAL.DOC.V1 ORIGINAL.DOC.V2 REVISED.DOC

...and end up with REVISED.DOC being the result of taking ORIGINAL.DOC
and applying both PATCH1.DIFF and PATCH2.DIFF in parallel. You can
then do...

 Q> gunzip < ORIGINAL.DOC.GZ > ORIGINAL.DOC
 Q> diff -u ORIGINAL.DOC REVISED.DOC

...to get a consolidated diff that applies both patches.

Best wishes from Riley.

