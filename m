Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269285AbUICF5V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269285AbUICF5V (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 01:57:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269282AbUICF5V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 01:57:21 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:62133 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S269280AbUICF5L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 01:57:11 -0400
Message-ID: <413807B4.8070802@namesys.com>
Date: Thu, 02 Sep 2004 22:57:08 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Masover <ninja@slaphack.com>
CC: Linus Torvalds <torvalds@osdl.org>, Jamie Lokier <jamie@shareable.org>,
       Horst von Brand <vonbrand@inf.utfsm.cl>, Adrian Bunk <bunk@fs.tum.de>,
       viro@parcelfarce.linux.theplanet.co.uk, Christoph Hellwig <hch@lst.de>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: The argument for fs assistance in handling archives
References: <20040826150202.GE5733@mail.shareable.org> <200408282314.i7SNErYv003270@localhost.localdomain> <20040901200806.GC31934@mail.shareable.org> <Pine.LNX.4.58.0409011311150.2295@ppc970.osdl.org> <20040902002431.GN31934@mail.shareable.org> <413694E6.7010606@slaphack.com> <Pine.LNX.4.58.0409012037300.2295@ppc970.osdl.org> <4136A14E.9010303@slaphack.com> <Pine.LNX.4.58.0409012259340.2295@ppc970.osdl.org> <4136C876.5010806@namesys.com> <Pine.LNX.4.58.0409020030220.2295@ppc970.osdl.org> <4137C4B1.40308@slaphack.com>
In-Reply-To: <4137C4B1.40308@slaphack.com>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The reason for supporting transactions in the kernel is that there is a 
whole slew of security bugs that have their origins in fs semantics 
being non-transactional.  rename does not cut it as a transactions API.  
rename results in horribly performing apps that engage in contortions 
that cost a lot of programmer time to code them to stuff a transaction 
into a file that can be renamed.  Most of the time programmers who 
should use a transaction/rename are just too busy to do it, and they 
take the risk that the user will lose data and be less secure rather 
than write the code to do it right.  When they do do it, because it is 
complex code, they often screw it up.

That said, there is a whole slew of reasons for not supporting 
transactions in the kernel:

* the history of the literature stars transactional filesystems that 
paid too high a cost in performance

* isolation is very tricky to do without killing performance

* transactions which are kept open too long are a problem

* avoiding problems with locking shared data structures long enough to 
cause painful exclusion of things that should be able to run in parallel 
just fine

Reiser4, by being very modest in its ambitions, manages to not pay a 
performance cost.   We say, isolation and rollback are for user space to 
manage until we can find a clever implementation, if such an 
implementation can even be found.  Even if such an implementation can be 
found, there are plenty of cases where special case knowledge of what 
the app is doing can improve performance a lot, and thus for that app it 
will belong in user space.

All reiser4 does, is allow you to guarantee (using sys_reiser4) that a 
limited size set of fs operations will be fused into one atom together, 
and therefor will either all survive a crash or none will survive.  This 
does however meet a lot of apps needs.

Hans

David Masover wrote:

> Linus Torvalds wrote:
> [...]
> | It's much saner (from _any_ app standpoint) to roll their own 
> database in
> | user space - that way it just works.
>
> Then why do we have apps which use Windows' Internet Options where it
> can, and otherwise ask the user for proxy settings?
>
> |
> | In other words, nobody is really ever going to take advantage of this.
> | This is _not_ how technical advanncement happens. The way you get people
> | to take advantage of something is to have a nice gradual ramp-up, not a
> | sudden new feature that they can't realistically use.
> |
> | So before you do transactions in the filesystem, you have to be able
> to do
> | them in user space - and then make the filesystem version be 
> _compatible_
> | with that user space library. That way you can get people to use the
> | library ("hey, it works anywhere") and then you can get them to use your
> | filesystem ("hey, if you use our super-duper filesystem, you can do what
> | you are already doing five times faster").
>
> Why not:
>     do transactions in the filesystem
>     write a library to talk to that filesystem
>     have the library do emulation on other systems
>
> in that order.
>
> | See? You're starting at the wrong end. Give me a portable interface to
> use
> | _first_. Then do transactions in the filesystem.
>
> If you're going to have to do both the portable interface and the fs
> support, does it really matter which order you do them in?
>
> Again, this is curiosity, not sarcasm.  Here my reasons for wanting the
> fs support first:
>
> You don't always know exactly how the filesystem transactions will work.
> ~ You don't know until it's done whether you'll deviate from your design,
> cut certain features, replace them with others...
>
> And if you write the portable library first, and it ends up supporting
> features a, b, and c, while the kernel supports features b, c, and d,
> which obsoletes a, you have to add some features and remove some
> features from the portable library to make it sane.
>
> It'd be like writing OpenGL entirely in software, before hardware
> accelerators work, and at the last minute have to change the library to
> use triangles instead of splines.  What's more, every single app now has
> to be rewritten or use the library's emulation -- that's assuming many
> apps would consider using a 3D library that doesn't have hardware accel
> support yet.

