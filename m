Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932313AbVKPJq0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932313AbVKPJq0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 04:46:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932592AbVKPJq0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 04:46:26 -0500
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:21179 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932313AbVKPJqZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 04:46:25 -0500
Subject: Re: [PATCH -rt] race condition in fs/compat.c with compat_sys_ioctl
From: Steven Rostedt <rostedt@goodmis.org>
To: Andi Kleen <ak@suse.de>
Cc: pavel@suse.cz, LKML <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>
In-Reply-To: <p73y83pp25r.fsf@verdi.suse.de>
References: <1131821278.5047.8.camel@localhost.localdomain>
	 <5bdc1c8b0511121725u6df7ad9csb9cb56777fa6fe64@mail.gmail.com>
	 <Pine.LNX.4.58.0511122149020.25152@localhost.localdomain>
	 <5bdc1c8b0511121914v12dc4402u424fbaf416bf3710@mail.gmail.com>
	 <1131853456.5047.14.camel@localhost.localdomain>
	 <5bdc1c8b0511130634h501fb565v58906bdfae788814@mail.gmail.com>
	 <1131994030.5047.17.camel@localhost.localdomain>
	 <5bdc1c8b0511141057l60a2e778x89155cd5484d532f@mail.gmail.com>
	 <1132115386.5047.61.camel@localhost.localdomain>
	 <p73y83pp25r.fsf@verdi.suse.de>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Wed, 16 Nov 2005 04:46:10 -0500
Message-Id: <1132134370.5047.73.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-11-16 at 06:55 +0100, Andi Kleen wrote:
> Steven Rostedt <rostedt@goodmis.org> writes:
> > 
> > That's the problem. I found out that one ioctl might sleep holding the
> > sem and won't be woken up until another process calls another ioctl to
> > wake it up. But unfortunately, the one waking up the sleeper will block
> > on the sem.  (the killer was tty_wait_until_sent)
> 
> You should have looked into mainline first. The semaphore is already gone
> because it wasn't even needed anymore.

It's still there in 2.6.15-rc1-git3 (the sem is the down_read of
ioctl32_sem in fs/compat.c).

No, the problem was unique to the rt patch.  In -rt the default
down_read is just like a down (since it is very hard to do PI on readers
and writer locks).  So the solution in -rt was to convert this back to a
normal RW sem.

-- Steve


