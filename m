Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261284AbTCJK4V>; Mon, 10 Mar 2003 05:56:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261287AbTCJK4U>; Mon, 10 Mar 2003 05:56:20 -0500
Received: from mailout06.sul.t-online.com ([194.25.134.19]:40419 "EHLO
	mailout06.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S261284AbTCJK4U>; Mon, 10 Mar 2003 05:56:20 -0500
Date: Mon, 10 Mar 2003 12:06:35 +0100
From: Andi Kleen <ak@muc.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Jamie Lokier <jamie@shareable.org>, linux-kernel@vger.kernel.org,
       ak@muc.de
Subject: Re: [Bug 350] New: i386 context switch very slow compared to 2.4 due to wrmsr (performance)
Message-ID: <20030310110635.GA2148@averell>
References: <20030212101206.GA10422@bjl1.jlokier.co.uk> <Pine.LNX.4.44.0303091858530.1420-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0303091858530.1420-100000@home.transmeta.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 10, 2003 at 04:07:36AM +0100, Linus Torvalds wrote:
>  since you've been interested in the past, I thought I'd ask you to test
> the current context switch stuff. Andi cleaned up some FPU reload stuff
> (and I fixed a bug in it, tssk tssk Andi - you'd obviously not actually
> timed your cleanups), and I just committed and pushed out my "cache the

You mean the TIF->_TIF thing? Yes that was wrong in the first patch,
but fixed in the patches later. Unfortunately the patch still 
has the problem pointed out by Manfred Spraul: if you're unlucky
it could destroy the _TIF_SIGPENDING set by another CPU with the
non atomic access. Really thread_info should have two flag words:
one that is truly local and can be accessed without LOCK and 
one that can be changed at will by external users too.

After some discussion with him I think the right fix for now is to 
move it it back to PF_USEDFPU into task_struct->flags.

Will submit a patch for that later after I was able to test it.

-Andi
