Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261213AbVFNOIA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261213AbVFNOIA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Jun 2005 10:08:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261234AbVFNOH7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Jun 2005 10:07:59 -0400
Received: from vtab.com ([62.20.90.195]:12963 "EHLO gorgon.vtab.com")
	by vger.kernel.org with ESMTP id S261213AbVFNOH5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Jun 2005 10:07:57 -0400
Date: Tue, 14 Jun 2005 16:07:54 +0200
Message-Id: <200506141407.j5EE7sZ11314@virtutech.se>
From: "=?ISO-8859-1?Q?Mattias Engdeg=E5rd?=" <mattias@virtutech.se>
To: Valdis.Kletnieks@vt.edu
Cc: cfriesen@nortel.com, jakub@redhat.com, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, akpm@osdl.org, dwmw2@infradead.org,
       drepper@redhat.com
In-reply-to: <200506132023.j5DKNhoG021339@turing-police.cc.vt.edu>
	(Valdis.Kletnieks@vt.edu)
Subject: Re: Add pselect, ppoll system calls.
Content-Type: text/plain; charset=iso-8859-1
References: <200506131938.j5DJcKc10799@virtutech.se> <42ADE52E.1040705@nortel.com>
            <200506132008.j5DK8t010817@virtutech.se> <200506132023.j5DKNhoG021339@turing-police.cc.vt.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Monotonic clocks are guaranteed to not go backward. A sudden warp 35
>seconds into the future when you have timers set for 15 and 20
>seconds into the future is still ugly....

I don't have the POSIX specs handy, but I see no reason we could not let
it use a warpless monotonic clock.

The problem of timeouts going wild when time is being warped applies
to syscalls using relative timeouts as well. Even when a relative
timeout is wanted, it is usually transformed (via gettimeofday or
similar) to an absolute timeout:

   T = some_clock() + dT
   timeout = dT
   loop:
      poll(..., timeout)
      if (poll did not time out):
          now = some_clock()
          timeout = MAX(0, T - now)
          goto loop

This kind of code is very common, because the timeout is usually the
time to some event in the future. If some_clock() is subject to
warping (which is the case when gettimeofday() is used), then you have
the problem again.
