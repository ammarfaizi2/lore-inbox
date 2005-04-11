Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261781AbVDKLgQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261781AbVDKLgQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 07:36:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261780AbVDKLgQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 07:36:16 -0400
Received: from mx2.elte.hu ([157.181.151.9]:57052 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261777AbVDKLfo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 07:35:44 -0400
Date: Mon, 11 Apr 2005 13:35:23 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Petr Baudis <pasky@ucw.cz>, "Randy.Dunlap" <rddunlap@osdl.org>,
       Ross Vandegrift <ross@jose.lug.udel.edu>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>, git@vger.kernel.org
Subject: [rfc] git: combo-blobs
Message-ID: <20050411113523.GA19256@elte.hu>
References: <Pine.LNX.4.58.0504091208470.6947@ppc970.osdl.org> <20050409200709.GC3451@pasky.ji.cz> <Pine.LNX.4.58.0504091320490.1267@ppc970.osdl.org> <Pine.LNX.4.58.0504091404350.1267@ppc970.osdl.org> <Pine.LNX.4.58.0504091617000.1267@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0504091617000.1267@ppc970.osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


i think all of the 'repository size' and 'bandwidth' concerns could be 
solved via a new (and pretty much simple and transparent) object type: 
the 'combo-blob'.

Summary:
--------

This is a space/bandwidth-efficient blob that 'includes' arbitrary 
portions of (one, two, or more) simple blobs by reference [1], with byte 
granularity, plus an optional followup portion that includes the full 
constructed state, uncompressed. [2] It can also conserve more RAM 
compared to the current repository format.

Representation:
---------------

A combo-blob would have the 'simplest possible' and thus most obvious 
representation: a list (the 'include-table') of "include X bytes at 
offset Y from parent Z" operations:

  <parent-blob-ID> <offset> <size>
  [optional full constructed state]

e.g.:

  6d11b2dd7f169c29664ac0553090865b7b020973 0 64444
  6d374c972c04a0b1894cc6898dffa8ab0b273fcb 0 100
  6d11b2dd7f169c29664ac0553090865b7b020973 64545 163656

'punches' 100 bytes out of blob 6d1* at offset 64444, and replaces it 
with blob 6d3*'s 100 bytes. [offset/size would be stored in a binary 
form to have constant record sizes.]

in OS terms it's similar to an iovec representation. [3]

The hash of a combo-blob is calculated off the include-table alone: i.e.  
it's _not_ equivalent to the hash of the included contents. I.e. you 
cannot 'collapse' a combo-blob after the fact, it's an immutable part of
the history of the repository, similar to other stored objects. You can
freely cache/uncache (blow-up/collapse) it on the other hand.

[ NOTE: further below you can find a 'Notes' section as well, which
  might address some of the issues/ideas you might have at this point. ]

Cons:
-----

there are a number of disadvantages:

- performance hit. Linus is perfectly right, in terms of performance, 
  nothing beats having full objects.

  Hence i kept the option to include the full constructed blob [4]
  (uncompressed) as well in the combo-blob. When all combo-blobs are
  'blown up' then they can be better in terms of performance than the 
  current repository format. [they still carry the small slice & dice
  information as well]

  the performance hit can be reduced in a finegrained way by introducing 
  occasional full objects in the history. E.g. after every 8 steps one
  would include a full blob, to limit the number of blobs necessary to
  construct a previously unconstructed combo-blob. This would still cut
  the overhead of the current format substantially.

  clearly, the most important cache is the current directory cache, 
  which this abstraction does not hurt.

- complexity. It's all pretty straightforward, but checking the
  consistency of a combo object is not as simple as checking the 
  consistency of a simple object, as it would have to recursively check 
  all parent IDs as well. I think it's worth the price though.

- repository has optional components: the 'blown up' (cached) portion of 
  a combo-blob can be freely destructed. This means that two 
  repositories can now not only differ in their directory-cache, but 
  also in their objects/ hierarchy. I dont think this is a big issue, 
  BYMMV.

Pros:
-----

- the main advantage is space/bandwith: it's pretty much as efficient as 
  it gets: it can be used to represent compressed binary deltas. A fully 
  trimmed (uncached) repository is very efficient.

- the optional 'fully constructed' portion is not compressed, so once a
  repository is 'cached', it is faster to process (in areas outside the
  current directory cache) than the current repository format. (In fact,
  when a previously unused portion of a repository is accessed _first_, 
  it is IO-bound by nature - so we can very well spend the extra CPU
  cycles on uncompressing things.)

- a 'combo' blob will be more memory-efficient as well. So with given 
  amount of RAM one could access more history, with a small CPU cost - 
  as long as the level of 'history recursion' is kept in check (e.g. via 
  the previously mentioned 'at most 8-deep combinations').  
  Straightforward iovecs could be passed to Linux system-calls, when 
  constructing a 'view' of a file, without having to cache every step of 
  the file's history.

- a combo-blob directly represents the way humans code: combining 
  pre-existing pieces of information and adding relatively low amount of 
  new stuff. Having a natural representation for the type of activity 
  that a tool supports cannot hurt.

( - combo-blobs enable a per-chunk (or per-line) edit history. It's not
    an important feature though.  )

Notes:
------

[1] the combo-blob is not a 'delta' thing. It combines pre-existing 
parents. One of the parents may of course be a 'delta' that acts upon 
the other parent - but the combo-blob does not know and does not care.  
(A combo-blob might as well represent an act of someone consolidating 
multiple small files into a big file, or splitting up a big file into 
smaller files. Or a combo-blob might represent the trimming of a 
preexisting file.)

[2]: a combo-blob is conceptually still a simple object with blob data 
in it, nothing more. It can be referenced in other object types 
equivalently to other blobs. It just happens to be a combination of 
existing blobs, and hence the 'git filesystem' has to work harder (but 
still quite efficiently) to get to the contents.

[3]: a combo-blob might reference any parent blob, including combo 
blobs. This means that e.g. multiple small deltas can be represented 
via:

   <blob-#1>
      |
      |-----<blob-#2>
      |
   <combo-blob-#1>
      |
      |-----<blob-#3>
      |
   <combo-blob-#2>

where combo-blob-#2 is thus a combination of blob-#1,blob-#2,blob-#3.

[4] alternatively, it might also make sense to extend the simple 
combo-blob concept with the concept of a 'cache-blob': a cache-blob 
'blows up' combo blobs in that it fully constructs the blob contents, 
but it is otherwise identical to the blob it caches. Simple (non-combo) 
blob types are a cache of themselves.

	Ingo
