Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262267AbVBSXdj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262267AbVBSXdj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Feb 2005 18:33:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262275AbVBSXdi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Feb 2005 18:33:38 -0500
Received: from gate.crashing.org ([63.228.1.57]:29631 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262267AbVBSXdh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Feb 2005 18:33:37 -0500
Subject: Re: Current bk on ppc32: kernel text corruption
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Paul Mackerras <paulus@samba.org>,
       "Antonino A. Daplas" <adaplas@hotpop.com>
In-Reply-To: <1108710554.5587.1.camel@gaston>
References: <1108710554.5587.1.camel@gaston>
Content-Type: text/plain
Date: Sun, 20 Feb 2005 10:32:12 +1100
Message-Id: <1108855933.5584.2.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-02-18 at 18:09 +1100, Benjamin Herrenschmidt wrote:
> Ok, we may not be over with memory corruption bugs yet. ppc64 now seem
> stable running LTP overnight, but my laptop has a page of kernel .text
> replaced with zero's as soon as I launch X (and just X, no need to launc
> the whole desktop environment).
> 
> I suspect remap_pfn_range() but I haven't checked yet.

Ok, I found it. It's a bug that was there forever it seems, where
radeonfb accel ops may corrupt kernel memory (via bus master from the
radeon chip) when switching back from X, due to X remapping some areas
of the card vs. fbcon calling some radeonfb accel ops before radeonfb
has a chance to re-initialize the chip (when switching back from X).

I'm cooking a workaround patch for 2.6.11, will be ready as soon as I
have tested. Proper fix is to make sure fbcon never calls any fbdev
accel op before the chip has been properly restored (by a set_var call),
but that is beyond the scope of 2.6.11 I suppose...

Ben.


