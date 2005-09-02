Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161089AbVIBWld@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161089AbVIBWld (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 18:41:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161091AbVIBWld
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 18:41:33 -0400
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:42962 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1161089AbVIBWlc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 18:41:32 -0400
Subject: Re: [PATCH] RT: Invert some TRACE_BUG_ON_LOCKED tests
From: Steven Rostedt <rostedt@goodmis.org>
To: Tom Rini <trini@kernel.crashing.org>
Cc: linux-kernel@vger.kernel.org, dwalker@mvista.com, mingo@elte.hu
In-Reply-To: <20050902200856.GY3966@smtp.west.cox.net>
References: <1125691250.2709.2.camel@c-67-188-6-232.hsd1.ca.comcast.net>
	 <20050902200856.GY3966@smtp.west.cox.net>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Fri, 02 Sep 2005 18:40:52 -0400
Message-Id: <1125700852.5601.16.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-09-02 at 13:08 -0700, Tom Rini wrote:
> With 2.6.13-rt4 I had to do the following in order to get my paired down
> config booting on my x86 whitebox (defconfig works fine, after I enable
> enet/8250_console/nfsroot).  Daniel Walker helped me trace this down.


Tom,

TRACE_BUG_ON_LOCKED(!spin_is_locked(&lock->wait_lock));

_is_ correct.  Those locks must be locked at those cases.  If it isn't
then we wan't to trigger a bug.  Hence the "BUG_ON" part.  You can never
guarantee that a lock will be unlock since another process on another
CPU might have it.

Now if you are getting a BUG, where as one of these places the lock is
_not_ held, then that's a bug.

Hmm, I wonder if these should be switched to __raw_spin_is_locked.

Oh wait, is this a UP system?  Shoot, spin_is_locked on UP is defined as
zero so this _would_ trigger. Ouch!

Ingo, I guess we need a TRACE_BUG_ON_LOCKED_SMP() macro.

-- Steve



