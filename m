Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263928AbUFVOWk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263928AbUFVOWk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 10:22:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264058AbUFVOVJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 10:21:09 -0400
Received: from holomorphy.com ([207.189.100.168]:8579 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S263928AbUFVON4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 10:13:56 -0400
Date: Tue, 22 Jun 2004 07:13:51 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Jedi/Sector One <lkml@pureftpd.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Badness in futex_wait
Message-ID: <20040622141351.GA2135@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Jedi/Sector One <lkml@pureftpd.org>, linux-kernel@vger.kernel.org
References: <20040622135416.GA23543@c9x.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040622135416.GA23543@c9x.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 22, 2004 at 03:53:54PM +0159, Jedi/Sector One wrote:
> Badness in futex_wait at kernel/futex.c:542
>  [<c0128634>] futex_wait+0x180/0x18a
>  [<c0114156>] default_wake_function+0x0/0xc
>  [<c0114156>] default_wake_function+0x0/0xc
>  [<c0128862>] do_futex+0x35/0x7f
>  [<c012898c>] sys_futex+0xe0/0xec
>  [<c0112cd1>] schedule_tail+0x15/0x4c
>  [<c0103bdd>] sysenter_past_esp+0x52/0x71
>   Is it harmless?

Probably yes; however, the WARN_ON() is there because it's not intended
to happen. I'd recommend removing the warning to shut it up as a local
patch until someone participating in maintaining that code investigates
it (basically they need to decide whether they want to find and fix the
spurious wakeup or otherwise to just ignore it).

This condition will not cause application errors or negatively affect
your system, apart from syslog spam. A spurious wakeup will only mean
that a thread wakes and rechecks the condition it was waiting for, but
it can't rely on that condition remaining true between the time the
kernel checks it and when userspace is returned to. For instance, the
scheduler may choose another task to return to, and take a very long
time to run the task that was waiting. So it can't introduce new errors
into userspace (except for the possibility, which I happen to know is
not how it's implemented, that it must have undergone a state transition
through that condition being true, for the userspace code to be correct).


-- wli
