Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266190AbUAQXeP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jan 2004 18:34:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266195AbUAQXeP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jan 2004 18:34:15 -0500
Received: from mtvcafw.SGI.COM ([192.48.171.6]:50712 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id S266190AbUAQXeN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jan 2004 18:34:13 -0500
Date: Sat, 17 Jan 2004 15:33:44 -0800
From: Paul Jackson <pj@sgi.com>
To: joe.korty@ccur.com
Cc: linux-kernel@vger.kernel.org, colpatch@us.ibm.com, akpm@osdl.org,
       paulus@samba.org
Subject: Re: [PATCH] bitmap parsing routines, version 3
Message-Id: <20040117153344.1072ae7c.pj@sgi.com>
In-Reply-To: <20040117153615.GA16385@tsunami.ccur.com>
References: <20040114150331.02220d4d.pj@sgi.com>
	<20040115002703.GA20971@tsunami.ccur.com>
	<20040114204009.3dc4c225.pj@sgi.com>
	<20040115081533.63c61d7f.akpm@osdl.org>
	<20040115181525.GA31086@tsunami.ccur.com>
	<20040115161732.458159f5.pj@sgi.com>
	<400873EC.2000406@us.ibm.com>
	<20040117063618.GA14829@tsunami.ccur.com>
	<20040117020815.3ac17c46.pj@sgi.com>
	<20040117145545.GA16318@tsunami.ccur.com>
	<20040117153615.GA16385@tsunami.ccur.com>
Organization: SGI
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On reflection, I reverse my position -- this should really be done in
> bitmap_clear et all as an attribute of bitmaps in general,

You're right.  Good point.

Having the various bitop routines cease treating the unused high bits as
a garbage dump is a separate task.  I don't like the way it is, as it
seems to open the door for some random bugs, in case some hapless code
is depending on these high bits in ways it shouldn't.

This whole mechanism seems to have a design confusion - whether to
specify and honor a specific bit count, or not.

My preference would have been to have these masks be officially some
multiple of "unsigned long" words; but instead we have ended up with a
data type that is ill-defined.  Sometimes it honors bit counts, and
sometimes it doesn't.  Some calls take a bit count (and may or may not
behave predictably in handling the high bits in the last word above the
count); some don't even admit of a bit count argument.  In some ways, it
is supposed to be just a hidden internal implementation detail that
these masks are an array of unsigned longs.  But some ops leave garbage
in the "unused" high bits, and some ops react to these high bits.

As one example, the CPU_MASK_ALL initializer (the cpumask_t type sits on
these masks) sets exactly NR_CPUS bits on small systems, but some
multiple of 8*sizeof(unsigned long) bits on large systems (masks more
than one word).

We're cruising for a bruising; but I lack the clarity of vision and
energy to remedy the situation.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
