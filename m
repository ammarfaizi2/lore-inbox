Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267523AbUIGILL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267523AbUIGILL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 04:11:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267708AbUIGIJe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 04:09:34 -0400
Received: from colin2.muc.de ([193.149.48.15]:29192 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S267523AbUIGIHO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 04:07:14 -0400
Date: 7 Sep 2004 10:07:10 +0200
Date: Tue, 7 Sep 2004 10:07:10 +0200
From: Andi Kleen <ak@muc.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Paul Jackson <pj@sgi.com>, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix argument checking in sched_setaffinity
Message-ID: <20040907080710.GA22895@muc.de>
References: <20040904171417.67649169.pj@sgi.com> <Pine.LNX.4.58.0409041717230.4735@ppc970.osdl.org> <20040904180548.2dcdd488.pj@sgi.com> <Pine.LNX.4.58.0409041827280.2331@ppc970.osdl.org> <20040904204850.48b7cfbd.pj@sgi.com> <Pine.LNX.4.58.0409042055460.2331@ppc970.osdl.org> <20040904211749.3f713a8a.pj@sgi.com> <20040904215205.0a067ab8.pj@sgi.com> <20040906182330.GA79122@muc.de> <Pine.LNX.4.58.0409061147220.28608@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0409061147220.28608@ppc970.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 06, 2004 at 11:48:46AM -0700, Linus Torvalds wrote:
> 
> 
> On Mon, 6 Sep 2004, Andi Kleen wrote:
> > 
> > The only change I would like to have is to check the excess bytes
> > to make sure they don't contain some random value. They should
> > be either all 0 or all 0xff. 
> 
> I hate the "byte at a time" interface.

I looked at doing it, but it would be far too complicated
for such a single operation with the two necessary alignment and
fix up left over bytes at the end loops and other fixup code. 
And this should not really be performance critical in any ways. 
long handling would be easy if the interface had been designed in longs, 
but it wasn't.

> That said, I think the "long at a time" interface we have now for bitmaps 
> ends up being a compatibility problem, where the compat layer has to worry 
> about big-endian 32-bit "long" lookign different from big-endian 64-bit 
> "long".
> 
> So there are other issues here.

In this special case not - big endian and little endian 0 and -1 are both
identical :-)

-Andi

Here's the byte at a time code again in case you change your mind.

--------------------------------------------------------------

Check that excess bytes passed by the user process to 
sched_setaffinity contain all 0 (no cpus) or all ones (all cpus)

diff -u linux-2.6.8/kernel/sched.c-o linux-2.6.8/kernel/sched.c
--- linux-2.6.8/kernel/sched.c-o	2004-09-06 20:06:58.000000000 +0200
+++ linux-2.6.8/kernel/sched.c	2004-09-06 20:16:33.940579241 +0200
@@ -3368,6 +3368,19 @@
 	if (len < sizeof(cpumask_t)) {
 		memset(new_mask, 0, sizeof(cpumask_t));
 	} else if (len > sizeof(cpumask_t)) {
+		unsigned i;
+		unsigned char val, initval;
+		if (len > PAGE_SIZE)
+			return -EINVAL;
+		/* excess bytes must be all 0 or all 0xff */
+		for (i = sizeof(cpumask_t); i < len; i++) { 
+			if (get_user(val, (char *)new_mask + i))
+				return -EFAULT; 
+			if (i == sizeof(cpumask_t))
+				initval = val;
+			if (!(val == 0 || val == 0xff) || val != initval)
+				return -EINVAL; 
+		} 
 		len = sizeof(cpumask_t);
 	}
 	return copy_from_user(new_mask, user_mask_ptr, len) ? -EFAULT : 0;


