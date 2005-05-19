Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262496AbVESNhV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262496AbVESNhV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 May 2005 09:37:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262495AbVESNhV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 May 2005 09:37:21 -0400
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:37791 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S262496AbVESNhN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 May 2005 09:37:13 -0400
Subject: Why yield in coredump_wait? [was: Re: Resent: BUG in RT 45-01 when
	RT program dumps core]
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: kus Kusche Klaus <kus@keba.com>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org
In-Reply-To: <1116503763.15866.9.camel@localhost.localdomain>
References: <AAD6DA242BC63C488511C611BD51F367323212@MAILIT.keba.co.at>
	 <1116503763.15866.9.camel@localhost.localdomain>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Thu, 19 May 2005 09:37:00 -0400
Message-Id: <1116509820.15866.28.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In the function coredump_wait there's a yield called:

static void coredump_wait(struct mm_struct *mm)
{
[...]
        /* give other threads a chance to run: */
        yield();

        zap_threads(mm);
[...]

I don't see any reason for this.  Although the comment says it's giving
other threads a chance to run, but the zap_threads below it will just
send a kill signal to all those sharing the mm and then this thread will
wait for completion (if there were threads to wait on).

Now if there were no other threads to wait on it would just continue.
So, is there some real reason that this yield is there? Or is it just
trying to be nice, as in saying, "I'm dieing now and just don't want to
waste others time" (which I highly doubt is the case).

The reason I'm asking this, is that RT tasks should not call yield,
since it is pretty much meaningless, since an RT task won't yield to any
task of lesser priority, and in Ingo's current kernel the yield will
send a bug message if it was called by an RT task.

Thanks,

-- Steve



