Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262539AbUCOKdJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 05:33:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262537AbUCOKdJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 05:33:09 -0500
Received: from moutng.kundenserver.de ([212.227.126.176]:30933 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S262539AbUCOKdF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 05:33:05 -0500
Date: Mon, 15 Mar 2004 11:33:00 +0100 (MET)
From: Armin Schindler <armin@melware.de>
To: Manfred Spraul <manfred@colorfullife.com>
cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.4] sys_select() return error on bad file
In-Reply-To: <4054A213.6010402@colorfullife.com>
Message-ID: <Pine.LNX.4.31.0403151111020.21744-100000@phoenix.one.melware.de>
Organization: Cytronics & Melware
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:4f0aeee4703bc17a8237042c4702a75a
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 14 Mar 2004, Manfred Spraul wrote:
> Marcelo wrote:
>
> >>
> >> Anyway, I don't see how your proposal would do better performance?
> >> My patch just adds a new variable on the stack, which should not make any
> >> difference in performance. And later, it is the same if the new or another
> >> variable gets changed or checked.
> >
> >Curiosity: Does SuS/POSIX define behaviour for "all fds are closed" ?
> >
> >
> I'd interpret SuS that a closed fd is ready for reading and writing:
>  From the select page:
> <<<
> A descriptor shall be considered ready for reading when a call to an
> input function with O_NONBLOCK clear would not block, whether or not the
> function would transfer data successfully. (The function might return
> data, an end-of-file indication, or an error other than one indicating
> that it is blocked, and in each of these cases the descriptor shall be
> considered ready for reading.)
> <<<
> read(fd,,) will return immediately with EBADF, thus the fd is ready.
>
> But that's a grey area, especially if you close the fd during the select
> call. For example HP UX just kills the current process if an fd that is
> polled is closed by overwriting it with dup2. I didn't test select, but
> I'd expect a similar behavior.
>
> Armin: did you compare the Linux behavior with other unices? Are there
> other unices that return EBADF for select() if all fds are closed?

No, I didn't compare yet, but I could not find any definition on that. It
really seems to be a "grey area".

> Attached is an untested proposal, against 2.6, but I'm not sure if it's
> really a good idea to change the current code - it might break existing
> apps.

This patch should also work on 2.4 and looks good to me, if "ready" should
be returned instead of EBADF. I don't think this would break existing
apps. Without such a patch, the app would sleep forever unless a signal
arrives. If any app depends on that behavior, I think it is bad coded.

Armin

