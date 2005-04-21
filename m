Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261462AbVDUIxK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261462AbVDUIxK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 04:53:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261684AbVDUIvt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 04:51:49 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:23563 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261615AbVDUIvT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 04:51:19 -0400
Date: Thu, 21 Apr 2005 09:51:09 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: jdavis@accessline.com, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Bad rounding in timeval_to_jiffies [was: Re: Odd Timer behavior in 2.6 vs 2.4  (1 extra tick)]
Message-ID: <20050421095109.A25431@flint.arm.linux.org.uk>
Mail-Followup-To: Steven Rostedt <rostedt@goodmis.org>,
	jdavis@accessline.com, Linus Torvalds <torvalds@osdl.org>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <E29E71BB437ED411B12A0008C7CF755B2BC9BE@mail.accessline.com> <1114052315.5058.13.camel@localhost.localdomain> <1114054816.5996.10.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1114054816.5996.10.camel@localhost.localdomain>; from rostedt@goodmis.org on Wed, Apr 20, 2005 at 11:40:16PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 20, 2005 at 11:40:16PM -0400, Steven Rostedt wrote:
> Is 11 jiffies correct for 10ms?

Consider the 1 jiffy case.  How long does waiting one jiffy actually wait?

j=0            1              2
+--------------+--------------+--> t
 A     B      C D

If you start timing one jiffy from A, you're looking for j=1, so your
timer expires close to D and you have waited one jiffy.

If you start timing one jiffy from B, you're still looking for j=1.
Your timer expires at the same point (D) but you've waited less than
one jiffy.

If you start timing one jiffy from C, it's the same - expires at D.
This time, you've waited virtually no time at all.

The problem is that when you add a timer, you don't have any idea
which point you're going to be starting your timer at.

This is why we always round up to the next jiffy when we convert
times to jiffies - this ensures that you will get at _least_ the
timeout you requested, which is in itself a very important
guarantee.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
