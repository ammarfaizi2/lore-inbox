Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161084AbWGIEkJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161084AbWGIEkJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 00:40:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161086AbWGIEkJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 00:40:09 -0400
Received: from gate.crashing.org ([63.228.1.57]:13208 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1161084AbWGIEkH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 00:40:07 -0400
Subject: Re: [patch] spinlocks: remove 'volatile'
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Chase Venters <chase.venters@clientec.com>
Cc: trajce nedev <trajcenedev@hotmail.com>, torvalds@osdl.org,
       acahalan@gmail.com, linux-kernel@vger.kernel.org, linux-os@analogic.com,
       khc@pm.waw.pl, mingo@elte.hu, akpm@osdl.org, arjan@infradead.org
In-Reply-To: <200607080847.12566.chase.venters@clientec.com>
References: <BAY110-F352D1029C60425661175C9B8750@phx.gbl>
	 <200607080847.12566.chase.venters@clientec.com>
Content-Type: text/plain
Date: Sun, 09 Jul 2006 14:39:20 +1000
Message-Id: <1152419961.4128.28.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Please show me how that lock is safe without a compiler memory barrier! What's 
> to stop your compiler from moving loads and stores across your inlined lock 
> code?
> 
> When you add the missing compiler memory barrier, the "volatile" classifier 
> becomes unnecessary.
> 
> Actually, please just read the thread. We've been over this already. It's 
> starting to get really old.

This is also a very good example of why pretty much every time somebody
tries to implement lock-like primitives in userland without using
libpthread, they get them wrong... we recently had to debug for a
customer a library that typically had that sort of home-made "I know how
this works" kind of locks that were actually subtley broken on machines
with deep out of order store queues. Of course, we didn't have the
source to the library and the customer was blaming the processors and/or
linux for his bugs.

There should be a real big flashing warning at the very beginning of
every computer programming course, book, whatever, compiler etc...
"Don't ever try to do locking & atomic primitives yourselves" or
something like that... In fact, I would suggest gcc to warn every time
somebody writes a function that has "lock" in the name :) Ok... maybe
not, but heh.

>From my experience, this is a very common source of bugs especially in
threaded apps. People have fantasies that they can do locks faster than
the system libraries, or have this religious-class beleif that
libpthread is bad, or whatever and they get it wrong pretty much every
single time. They are often saved by x86 which is very much in order
still but even if that is changing.

In fact, in a former life when I was still porting windows
applications/drivers to MacOS, I think pretty much ever single time I
had to port some threaded app, it happend. Ugly. Drivers writers
occasionally got smarter and uses whatever primitives the NT kernel
provides (can't remember), possibly because that's what the sample code
does :) Apps were hopeless. Every single of them.

Ben.

