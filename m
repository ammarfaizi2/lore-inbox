Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268447AbUIFSXe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268447AbUIFSXe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Sep 2004 14:23:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268448AbUIFSXe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Sep 2004 14:23:34 -0400
Received: from colin2.muc.de ([193.149.48.15]:2322 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S268447AbUIFSXb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Sep 2004 14:23:31 -0400
Date: 6 Sep 2004 20:23:30 +0200
Date: Mon, 6 Sep 2004 20:23:30 +0200
From: Andi Kleen <ak@muc.de>
To: Paul Jackson <pj@sgi.com>
Cc: torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix argument checking in sched_setaffinity
Message-ID: <20040906182330.GA79122@muc.de>
References: <20040831183655.58d784a3.pj@sgi.com> <20040904133701.GE33964@muc.de> <20040904171417.67649169.pj@sgi.com> <Pine.LNX.4.58.0409041717230.4735@ppc970.osdl.org> <20040904180548.2dcdd488.pj@sgi.com> <Pine.LNX.4.58.0409041827280.2331@ppc970.osdl.org> <20040904204850.48b7cfbd.pj@sgi.com> <Pine.LNX.4.58.0409042055460.2331@ppc970.osdl.org> <20040904211749.3f713a8a.pj@sgi.com> <20040904215205.0a067ab8.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040904215205.0a067ab8.pj@sgi.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 04, 2004 at 09:52:05PM -0700, Paul Jackson wrote:
> > starting with backing out the changes made to it this week.
> 
> Andi,
> 
> Given that Linus has gutted most of your patch to sched_setaffinity,
> do you have a preference between where the code started the week,
> and where it ended?
> 
> If I'm reading Linus' mind right (well ... there's a first time
> for everything) then your preference, either way, would likely
> carry the day.

The only change I would like to have is to check the excess bytes
to make sure they don't contain some random value. They should
be either all 0 or all 0xff. 

-Andi

Here's a patch for bk12: 

Linus, does this look better?

--------------------------------------------------------

For excess cpumask bits passed from user space ensure
they are all zero or all one.  This minimizes binary incompatibilities
when the kernel is recompiled with a bigger cpumask_t type.

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
