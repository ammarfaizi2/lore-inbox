Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965159AbVLOGyX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965159AbVLOGyX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 01:54:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965158AbVLOGyX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 01:54:23 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:16278
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S965162AbVLOGyX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 01:54:23 -0500
Date: Wed, 14 Dec 2005 22:45:44 -0800 (PST)
Message-Id: <20051214.224544.56187291.davem@davemloft.net>
To: torvalds@osdl.org
Cc: bunk@stusta.de, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] offer CC_OPTIMIZE_FOR_SIZE only if EXPERIMENTAL
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <Pine.LNX.4.64.0512141528140.3292@g5.osdl.org>
References: <Pine.LNX.4.64.0512141429030.3292@g5.osdl.org>
	<20051214224406.GI23349@stusta.de>
	<Pine.LNX.4.64.0512141528140.3292@g5.osdl.org>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Linus Torvalds <torvalds@osdl.org>
Date: Wed, 14 Dec 2005 15:32:28 -0800 (PST)

> Of course, the really right thing would be to chase down what goes
> wrong with -Os.

It turns out to be a sparc64 bug, technically, in my case.

What happens is that with -Os gcc _INLINES_ schedule() into
wait_for_completion().  No that's not a typo, when optimizing
for space it inlines a huge function like schedule() whereas
without -Os it does not. :-/

Anyways, switch_to() in sparc64 (and sparc) does not work properly
when this happens.  schedule() needs to execute in it's own stack
frame for the stack switching in switch_to() to work.

Would anyone be against adding "noinline" to kernel/sched.c:schedule()?
I'm about to test that, but I'm extremely positive that it makes the
problem go away.
