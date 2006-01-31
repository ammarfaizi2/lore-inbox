Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750874AbWAaPDh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750874AbWAaPDh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 10:03:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750873AbWAaPDh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 10:03:37 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:63121 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1750872AbWAaPDg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 10:03:36 -0500
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: Kirill Korotaev <dev@sw.ru>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org, Jeff Dike <jdike@addtoit.com>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 2/3] pidhash: don't use zero pids
References: <43DDF323.4517C349@tv-sign.ru>
	<m1r76p5u7m.fsf@ebiederm.dsl.xmission.com> <43DEFFB7.6010404@sw.ru>
	<43DF3BB7.B423AC08@tv-sign.ru>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Tue, 31 Jan 2006 08:02:12 -0700
In-Reply-To: <43DF3BB7.B423AC08@tv-sign.ru> (Oleg Nesterov's message of
 "Tue, 31 Jan 2006 13:28:07 +0300")
Message-ID: <m1lkww4f0r.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Nesterov <oleg@tv-sign.ru> writes:

> Hello Kirill,
>
> Kirill Korotaev wrote:
>> 
>> Hello Oleg,
>> 
>> I had quite the same comment, but had no time to check it.
>> I can't understand what problem do you solve, or just making code
>> cleaner (from your point of view)?
>
> Please look at http://marc.theaimsgroup.com/?t=113851660700001
>
>> For me it was quite natural that pid=0 is used by idle, and I'm very
>> suspicuos about such changes.
>
> This patch does not change idle's pid, it is still 0. It changes ->pgrp
> and ->session only from 0 to 1. Currently kernel threads run with 0,0
> unless they call daemonize() which does set_special_pids(1, 1).


daemonize consuming pids (1,1) then consumes pgrp 1.  So that when
/sbin/init calls setsid() it thinks /sbin/init is a process group
leader and setsid() fails.  So /sbin/init wants pgrp 1 session 1
but doesn't get it.  I am pretty certain daemonize did not exist so
/sbin/init got pgrp 1 session 1 in 2.4.

That is the bug that is being fixed.

This patch takes things one step farther and essentially calls
setsid() for pid == 1 before init is execed.  That is new behavior
but it cleans up the kernel as we now do not need to support the
case of a process without a process group or a session.

The only process that could have possibly cared was /sbin/init
and it already calls setsid() because it doesn't want that.

If this was going to break anything noticeable the change in behavior
from 2.4 to 2.6 would have already done that.

Hopefully that is sufficiently comprehensible to everyone.

Eric






