Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751058AbWDJHIp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751058AbWDJHIp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 03:08:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751059AbWDJHIp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 03:08:45 -0400
Received: from mx1.redhat.com ([66.187.233.31]:6113 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751057AbWDJHIo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 03:08:44 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Oleg Nesterov <oleg@tv-sign.ru>
X-Fcc: ~/Mail/linus
Cc: linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>,
       Ingo Molnar <mingo@elte.hu>, "Paul E. McKenney" <paulmck@us.ibm.com>,
       Andrew Morton <akpm@osdl.org>, Lee Revell <rlrevell@joe-job.com>
Subject: Re: [PATCH rc1-mm 2/3] coredump: shutdown current process first
In-Reply-To: Oleg Nesterov's message of  Sunday, 9 April 2006 04:11:27 +0400 <20060409001127.GA101@oleg>
X-Antipastobozoticataclysm: When George Bush projectile vomits antipasto on the Japanese.
Message-Id: <20060410070840.26AE41809D1@magilla.sf.frob.com>
Date: Mon, 10 Apr 2006 00:08:40 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This patch optimize zap_threads() for the case when there are
> no ->mm users except the current's thread group. In that case
> we can avoid 'for_each_process()' loop.

This is a very good optimization.  Please don't use a goto here when a
simple if block and some reindenting works just fine.

I would be inclined to restructure the inner loop something like this:

		p = g;
		while (unlikely(p->mm == NULL)) {
			p = next_thread(p);
			if (p == g)
				break;
		}
		if (p->mm == mm) {
			/*
			 * p->sighand can't disappear, but
			 * may be changed by de_thread()
			 */
			lock_task_sighand(p, &flags);
			zap_process(p);
			unlock_task_sighand(p, &flags);
		}

But that is just taste.

> It also adds a useful invariant: SIGNAL_GROUP_EXIT (if checked
> under ->siglock) always implies that all threads (except may be
> current) have pending SIGKILL.

I agree that's a sensible thing to be able to rely on (though I don't know
of a practical difference it makes atm).  If this is merged with by
SIGNAL_GROUP_EXEC change, then the invariant is that SIGNAL_GROUP_EXIT
always means that all threads (including current) either have pending
SIGKILL or are already calling do_group_exit/do_exit.


Thanks,
Roland
