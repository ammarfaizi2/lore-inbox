Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268329AbUIWIrx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268329AbUIWIrx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 04:47:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268330AbUIWIrw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 04:47:52 -0400
Received: from are.twiddle.net ([64.81.246.98]:8323 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id S268329AbUIWIru (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 04:47:50 -0400
Date: Thu, 23 Sep 2004 01:47:46 -0700
From: Richard Henderson <rth@twiddle.net>
To: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: __attribute__((always_inline)) fiasco
Message-ID: <20040923084746.GA9101@twiddle.net>
Mail-Followup-To: linux-kernel@vger.kernel.org, torvalds@osdl.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm displeased with someone's workaround for decisions made by
the (rather weak) inliner in gcc 3.[123].  In particular, that
someone doesn't understand all of the implications of always_inline.

This attribute was invented to handle certain cases in <altivec.h>
and <xmmintrin.h> that contain assembly instructions that require
constant arguments.  These instructions *cannot* be emitted unless
the user of the function supplies a constant.  Which, under normal
usage situations is not a problem -- when the user doesn't give us
a constant, we error and that's the end.  But it does mean that 
the compiler is specifically *not* allowed to emit an out-of-line
copy of such a function, since there is in fact no way to legally
do so.

In the Alpha port I have a number of places in which I have 
functions that I would like inlined when they are called directly,
but I also need to take their address so that they may be registered
as part of a dispatch vector for the specific machine model.

This scheme fails because my functions got marked always_inline
behind my back, which means they didn't get emitted in the right
place.

Rather than fight the unwinnable fight to remove this hack entirely,
may I ask that at least one of the different names for inline, e.g.
__inline__, be left un-touched so that it can be used by those that
understand what the keyword is supposed to mean?

Of course, there does not exist a variant that isn't used by all
sorts of random code, so presumably all existing occurences would
have to get renamed to plan "inline" in order to keep people happy...


r~
