Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131338AbRBLQVq>; Mon, 12 Feb 2001 11:21:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131346AbRBLQVh>; Mon, 12 Feb 2001 11:21:37 -0500
Received: from ausmtp01.au.ibm.COM ([202.135.136.97]:12051 "EHLO
	ausmtp01.au.ibm.com") by vger.kernel.org with ESMTP
	id <S131338AbRBLQV3>; Mon, 12 Feb 2001 11:21:29 -0500
From: bsuparna@in.ibm.com
X-Lotus-FromDomain: IBMIN@IBMAU
To: Linus Torvalds <torvalds@transmeta.com>
cc: Martin Dalecki <dalecki@evision-ventures.com>,
        Ben LaHaise <bcrl@redhat.com>, "Stephen C. Tweedie" <sct@redhat.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Manfred Spraul <manfred@colorfullife.com>, Steve Lord <lord@sgi.com>,
        linux-kernel@vger.kernel.org, kiobuf-io-devel@lists.sourceforge.net,
        Ingo Molnar <mingo@redhat.com>
Message-ID: <CA2569F1.0059C07B.00@d73mta03.au.ibm.com>
Date: Mon, 12 Feb 2001 20:26:17 +0530
Subject: Re: [Kiobuf-io-devel] RFC: Kernel mechanism: Compound event wait
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Going through all the discussions once again and trying to look at this
from the point of view of just basic requirements for data structures and
mechanisms, that they imply.

1. Should have a data structure that represents a  memory chain , which may
not be contiguous in physical memory, and which can be passed down as a
single unit all the way  through to lowest level drivers
     - e.g for direct i/o to/from a contiguous virtual address range in
user space (without any intermediate copies)

(Networking and block i/o seem may have require different optimizations in
the design of such a data structure, due to differences in the kind of
patterns expected, as is apparent from the zero-copy networking fragments
vs raw i/o kiobuf/kiovec patches. There are situations when such a data
structure may be passed between subsystems as in the i2o example)

This data structure could be part of an I/O container.

2.  I/O containers may get split or merged as they pass through various
layers --- so any completion mechanism and i/o container design should be
able to account for both cases. At any point, a request could be
     - a collection of several higher level requests,
          or
     - could be one among several sub-requests of a single higher level
request.
(Just as appropriate "clustering"  could happen at each level, appropriate
"splitting" may also take place depending on the situation. It may make
sense to delay splitting as far down the chain as possible in many
situations, where the higher level is only interested in the i/o in its
entirety and not in partial completion )
When caching/buffers are involved, sometimes the sub-requests of a single
higher level request may have individual completion requirements (even when
no merges were involved), because the sub-request buffers may be used to
service other requests alongside. With raw i/o that might not be the case.

3. It is desirable that layers which process the requests along the way
without splitting/merging, be able to pass along the same I/O container
without any duplication or cloning, and intercept async i/o completions for
post processing.

4. (Optional) It would be nice if different kinds of I/O containers or
buffer structures could be used at different levels, without having
explicit linkage fields (like bh --> page, for example) , and in a way that
intermediate drivers or layers can work transparently.

3 & 4 are more of layering related items, which gets a little specific, but
do 1 and 2 cover the general things we are looking for ?

Regards
Suparna

  Suparna Bhattacharya
  Systems Software Group, IBM Global Services, India
  E-mail : bsuparna@in.ibm.com
  Phone : 91-80-5267117, Extn : 2525


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://vger.kernel.org/lkml/
