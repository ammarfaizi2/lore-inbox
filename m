Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265152AbTLCUIi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 15:08:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265153AbTLCUIi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 15:08:38 -0500
Received: from fw.osdl.org ([65.172.181.6]:57051 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265152AbTLCUIg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 15:08:36 -0500
Date: Wed, 3 Dec 2003 12:08:07 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
cc: Srivatsa Vaddagiri <vatsa@in.ibm.com>, Raj <raju@mailandnews.com>,
       linux-kernel@vger.kernel.org, lhcs-devel@lists.sourceforge.net,
       Manfred Spraul <manfred@colorfullife.com>
Subject: Re: kernel BUG at kernel/exit.c:792!
In-Reply-To: <Pine.LNX.4.58.0312032059040.4438@earth>
Message-ID: <Pine.LNX.4.58.0312031203430.7406@home.osdl.org>
References: <20031203153858.C14999@in.ibm.com> <3FCDCEA3.1020209@mailandnews.com>
 <20031203182319.D14999@in.ibm.com> <Pine.LNX.4.58.0312032059040.4438@earth>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 3 Dec 2003, Ingo Molnar wrote:
>
> only the starting point should be checked. If the starting point is wrong
> then we have no access to the 'thread list' anymore. If the starting point
> is alive then all the thread-list walking within the tasklist_lock is
> safe.

I'm not sure that's true. The starting point is not necessarily the thread
group leader, and then following the chain can see a zombie thread group
leader in the _middle_ without a sighandler pointer - at which point we
BUG() out again.

Guys, that BUG() is _incorrect_.

This is one reason I hate some assert() with a passion. I've seen this way
too often: somebody added an assert for something he thought was a bug,
and then people are too damn afraid to just admit that it wasn't a bug at
all, and just get rid of the f-ing assert. So instead, you add code to
avoid the assert. And that code itself is non-obvious and broken.

So as far as I can tell, the patch from Ingo and Srivatsa just paper over
the _real_ bug. And the real fix is to get rid of the debugging helper
completely, since it no longer serves any purpose, and it is WRONG!

So tell me why it isn't wrong?

		Linus
