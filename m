Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263697AbTDTVFT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Apr 2003 17:05:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263698AbTDTVFT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Apr 2003 17:05:19 -0400
Received: from hera.cwi.nl ([192.16.191.8]:32980 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S263697AbTDTVFS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Apr 2003 17:05:18 -0400
From: Andries.Brouwer@cwi.nl
Date: Sun, 20 Apr 2003 23:17:17 +0200 (MEST)
Message-Id: <UTC200304202117.h3KLHH217162.aeb@smtp.cwi.nl>
To: aebr@win.tue.nl, viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: [CFT] more kdev_t-ectomy
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    From: viro@parcelfarce.linux.theplanet.co.uk
     
    > So, the interface with filesystems and with userspace has dev_t.
    > For kernel-internal numbers kdev_t is better than dev_t.
    > 
    > Of course it may be possible to avoid kernel-internal numbers altogether.
    > Sometimes that is an improvement, sometimes not. Pointers are more
    > complicated than numbers - they point at something that must be allocated
    > and freed and reference counted. A number is like a pointer without the
    > reference counting.

    Sigh...   And what, pray tell, do we do with these numbers?  That's
    right, at some point(s) we use them to obtain <drumroll> pointers
    to driver-supplied objects.  And that's where the lack of refcounting,
    locking, etc. bites you.

Ha, Al - did you try to understand?

Given a number, one can copy it around freely, without the need
to obtain a reference each time one copies it.
Many of these numbers are just copied around and never used.
In such a case, refcounting is a real waste of time.
But if one really wants to use the number, then a lookup is done,
and one gets a properly refcounted pointer.

So, instead of the dogmatic "numbers are bad", one might try
to estimate the cost of always refcounting versus the cost of
sometimes doing a lookup.

    Let's sort that mess out for good.  Papering over this stuff won't do
    us any good and will only bring more kludgy interfaces.  $DEITY witness,
    we already have enough of those.

[this sounds like the canonical content-free diatribe]

    It's not about pointers vs. numbers - ...

[stuff I completely agree with deleted]

    By now all uses of mk_kdev()/major()/minor()/MAJOR()/MINOR() in the drivers
    are either trivially removable or represent very real problems.  And it's
    not that there was a lot of them - in my current tree there's ~85 instances
    of kdev_t in the source.  And only one of them (->i_rdev) is widely used -
    ~500 instances, most of them go away as soon as CIDR patch gets merged.
    The rest is part noise, part real bugs that need to be fixed anyway
    (~40--80 of those).

Yes, I tend to agree. Funny that you do not mention MKDEV - that was
the thing I worked on eliminating long ago.


Andries



