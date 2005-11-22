Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751308AbVKVNbd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751308AbVKVNbd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 08:31:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751309AbVKVNbd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 08:31:33 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:61371 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S1751308AbVKVNbd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 08:31:33 -0500
Message-ID: <43832F1D.F56D1C00@tv-sign.ru>
Date: Tue, 22 Nov 2005 17:45:49 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: george@mvista.com
Cc: paulmck@us.ibm.com, Roland McGrath <roland@redhat.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, dipankar@in.ibm.com, mingo@elte.hu,
       suzannew@cs.pdx.edu
Subject: Re: Thread group exec race -> null pointer... HELP
References: <20051105013650.GA17461@us.ibm.com> <436CDEAF.E236BC40@tv-sign.ru> <20051106010004.GB20178@us.ibm.com> <436E1401.920A83EE@tv-sign.ru> <437BC01D.60302@mvista.com> <43826FDC.8010401@mvista.com>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

George Anzinger wrote:
>
> Still rooting around in the above.  The test program is attached.  It
> creates and arms a repeating timer and then clones a thread which does
> an exec() call.

This patch:

	http://marc.theaimsgroup.com/?l=linux-kernel&m=113138286512847

was intended to fix exactly this problem (and the same test program was
used to exploit the race and test the fix).

So, it does not help? I can't reproduce the problem.

Note: I think you also need this patch:

	http://marc.theaimsgroup.com/?l=linux-kernel&m=113059955626598

otherwise I beleive OOPS can happen while killing this program if you are
running the kernel with this change applied:

	[PATCH] Call exit_itimers from do_exit, not __exit_signal
	http://kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=25f407f0b668f5e4ebd5d13e1fb4306ba6427ead


> first instance of this, we see that the thread-group leader is dead
> and the exec code at line ~718 is setting the old leaders group-leader
> to him self.

I think this code at line ~718

	leader->group_leader = leader;

is noop, because leader->group_leader == leader here.

> -               leader->group_leader = leader;
> +               leader->group_leader = current;

This can't help, without SIGEV_THREAD_ID we don't check ->group_leader,
the signal goes to the thread group via timer->it_process, which is equal
to the old leader.

Oleg.
