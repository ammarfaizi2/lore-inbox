Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261775AbUBJWRc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 17:17:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261890AbUBJWRc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 17:17:32 -0500
Received: from gate.crashing.org ([63.228.1.57]:57745 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261775AbUBJWRb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 17:17:31 -0500
Subject: Re: [BUG] get_unmapped_area() change -> non booting machine
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andi Kleen <ak@suse.de>, Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0402100814410.2128@home.osdl.org>
References: <1076384799.893.5.camel@gaston>
	 <Pine.LNX.4.58.0402100814410.2128@home.osdl.org>
Content-Type: text/plain
Message-Id: <1076451422.866.55.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 11 Feb 2004 09:17:02 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> What I find strange is that bash passed in something else than NULL as the 
> argument in the first place. Doing a quick trace of my bash executable 
> shows non-NULL hints only for MAP_FIXED mmap's. So what triggered this? 

It's ld.so which passed the prelink'ed address as a hit on a part glibc
itself. Since glibc is prelinked below the executable on PPC and since
my prelink'ed informations are outdated (prelink somewhat broke on PPC
in latest debian SID), the library wouldn't fit, thus mmap tried to
move it upward... to the brk hole. At least that is my explanation, I
didn't trace the code in ld.so

> Random special cases in code are just evil, and end up biting us in the 
> end. Which is why I'd rather see the revert, along with more of a look at 
> _why_ bash does what it does for you.

It's not bash, it's ld.so... Note that Andi's patch also fix a potential
similar issue with the free_area_cache, if somebody does a MAP_FIXED to
low addresses, then a un-hinted mmap, then that mmap will have chances
to be put straight after brk, causing the same kind of interesting issues.

So if you don't take Andi's latest patch, maybe you should still take
the part that avoid playing with free_area_cache on MAP_FIXED mappings ?

Ben.


