Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261371AbVBWA67@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261371AbVBWA67 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Feb 2005 19:58:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261373AbVBWA67
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Feb 2005 19:58:59 -0500
Received: from mail-in-03.arcor-online.net ([151.189.21.43]:4010 "EHLO
	mail-in-03.arcor-online.net") by vger.kernel.org with ESMTP
	id S261371AbVBWA65 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Feb 2005 19:58:57 -0500
From: Bodo Eggert <7eggert@gmx.de>
Subject: Re: uninterruptible sleep lockups
To: linux-os@analogic.com, linux-kernel@vger.kernel.org,
       theant@nodivisions.com
Reply-To: 7eggert@gmx.de
Date: Wed, 23 Feb 2005 01:59:28 +0100
References: <fa.duv6ag6.p5mth0@ifi.uio.no> <fa.irk349q.1c3si2o@ifi.uio.no>
User-Agent: KNode/0.7.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Message-Id: <E1D3ksD-0001NH-MI@be1.7eggert.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux-os <linux-os@analogic.com> wrote:

> You don't seem to understand. A process that's stuck in 'D' state
> shows a SEVERE error, usually with a hardware driver.

Or a network filesystem mount to a no longer existing server or share.

> For instance, 
> somebody may have coded something in a critical section that will
> wait forever for some bit to be set when, in fact, that bit may
> never be set because of a hardware glitch. Such problems must
> be found. One can't just suck some process out of the 'D' state.

But you can easily fall into one, e.g. by mounting a SMB share to ~/mnt,
working until after the windows box breaks down and trying to save the
work of the last hour (which involves enumerating and stat()ing all
entries in ~).

> The 'D' state usually stands for 'Down' where a task
> was 'down()' on a semaphore. To get out of that state,
> that task (and none other) needs to execute `up()`.
> This means that whatever that task was waiting for
> needs to happen or it won't call 'up()'.

Maybe the device/mountpoint causing the processes to hang can be declared
dead (This is the more important part to me) and/or the syscall can be
forced to fail. If it involves wasting some MB of RAM for copying all
possibly affected memory in order to avoid corrupting used RAM, that
will be the price to pay for not losing your data.

How to clean up the stuck processes: (This requires a MMU)
Add an error path to each syscall (or create some generic error paths) and
keep the original stack frame. On errors, you can "longjump" (not exactly,
but similar) to the error path after copying the memory. The semaphore will
not be taken, and the code depending on the semaphore will not be executed.



BTW: Your Reply-To: should be omited if it's equal to the From:
