Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932611AbVKXBvH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932611AbVKXBvH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 20:51:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932613AbVKXBvH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 20:51:07 -0500
Received: from gate.crashing.org ([63.228.1.57]:59365 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S932611AbVKXBvG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 20:51:06 -0500
Subject: Re: Console rotation problems
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: adaplas@gmail.com
Cc: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <1132793556.26560.361.camel@gaston>
References: <1132793150.26560.357.camel@gaston>
	 <1132793556.26560.361.camel@gaston>
Content-Type: text/plain
Date: Thu, 24 Nov 2005 12:47:11 +1100
Message-Id: <1132796831.26560.392.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-11-24 at 11:52 +1100, Benjamin Herrenschmidt wrote:
> On Thu, 2005-11-24 at 11:45 +1100, Benjamin Herrenschmidt wrote:
> > Hi Antonio !
> > 
> > I decided to give a quick test to console rotation on my g5 (radeonfb)
> > and couldn't get it to work.
> > 
> > When I tried echo'ing something in con_rotate, something very strange
> > happened:
> > 
> > pogo:/sys/class/graphics/fb0# echo "1" >con_rotate
> > benh@pogo:~$
> 
>   .../...
> 
> And here is the Oops that explains the shell exit and that I didn't see
> the first time :)
> 
> Trap 0x600 is an alignment exception, which is a bit weird, I'll try to
> dig a bit more, it could be a problem with the alignment trap handler on
> ppc.

Ok, looks like an unaligned set_bit() or atomic_or(). You can't do
atomic operations on non-aligned quantities. Let me check the code ...

OUCH !

Is there any reason why you are using set_bit & friends all over the
place over there in fbcon_rotate.h ? Are you actually trying to perform
atomic operations ?

set_bit(), clear_bit() etc... are

1) atomic. that mean slow, won't work on uncached memory (like
framebuffer), and won't work if not aligned propertly

2) won't guarantee the bit position, they are consistent within an
architecture but not accross.

If you want bit manipulation of pixel data, use your own routines, using
set_bit/clear_bit & friends is completely bogus.

The __xxx versions will fix 1), but not 2) btw.

Ben.


