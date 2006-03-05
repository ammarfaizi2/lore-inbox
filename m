Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751495AbWCELYb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751495AbWCELYb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Mar 2006 06:24:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752017AbWCELYb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Mar 2006 06:24:31 -0500
Received: from canuck.infradead.org ([205.233.218.70]:1452 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S1751495AbWCELYb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Mar 2006 06:24:31 -0500
Subject: Re: PROBLEM:  rt_sigsuspend() does not return EINTR on 2.6.16-rc2+
From: David Woodhouse <dwmw2@infradead.org>
To: Matthew Grant <grantma@anathoth.gen.nz>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1141521960.7628.9.camel@localhost.localdomain>
References: <1141521960.7628.9.camel@localhost.localdomain>
Content-Type: text/plain
Date: Sun, 05 Mar 2006 11:24:22 +0000
Message-Id: <1141557862.3764.47.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-03-05 at 14:26 +1300, Matthew Grant wrote:
> Problem is that new sys_rt_sigsuspend in kernel/signal.c in 2.6.16-rc2+
> does not return EINTR.

It does for me -- try the trivial test case at
http://david.woodhou.se/sigsusptest.c

If you strace that under old and new kernels you'll see a difference in
the strace output, but it should be entirely cosmetic. The old code
would incestuously call do_signal() inside sys_rt_sigsuspend(), and
would never need to use the mechanism we have for restarting system
calls. Either it would know it delivered a signal and it would return
-EINTR, or it would know that it _didn't_, and it would loop for itself.
Now it behaves like all the other restartable syscalls, and ptrace will
actually see the -ERESTARTNOHAND return code which later gets converted
by the signal code either to -EINTR or to an actual restart, as
appropriate.

In short, I think what you've picked up on in the strace output is
entirely cosmetic, and shouldn't affect the behaviour of the program in
any way. In each case, it comes back from the signal and goes
immediately into gettimeofday() and then poll() -- it _has_ come out of
the sigsuspend(). You then find that poll() gives different results in
each case, and I'd be inclined to suspect that the _real_ change in
behaviour goes from that point.

> I think David woodhouse may be responsible for this....

I read lkml sporadically; usually better to Cc me when I'm to blame :)

-- 
dwmw2

