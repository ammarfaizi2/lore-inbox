Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261531AbVCaQOY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261531AbVCaQOY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 11:14:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261533AbVCaQOY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 11:14:24 -0500
Received: from rzfoobar.is-asp.com ([217.11.194.155]:51074 "EHLO mail.isg.de")
	by vger.kernel.org with ESMTP id S261531AbVCaQOR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 11:14:17 -0500
Message-ID: <424C21D7.5010302@is-teledata.com>
Date: Thu, 31 Mar 2005 18:14:15 +0200
From: Lutz Vieweg <lutz.vieweg@is-teledata.com>
Organization: Innovative Software AG
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040322 wamcom.org
X-Accept-Language: de, German, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>
Subject: Re: select() not returning though pipe became readable
References: <4242E0E2.4050407@is-teledata.com> <20050324170731.70a31f99.akpm@osdl.org>
In-Reply-To: <20050324170731.70a31f99.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lutz Vieweg <lutz.vieweg@is-teledata.com> wrote:

>I'm currently investigating the following problem, which seems to indicate
>a misbehaviour of the kernel:
>
>A server software we implemented is sporadically "hanging" in a select()
>call since we upgraded from kernel 2.4 to (currently) 2.6.9 (we have to wait
>for 2.6.12 before we can upgrade again due to the shared-mem-not-dumped-into-
>core-files problem addressed there).
>
>What's suspicious is that whenever we attach with gdb to such a hanging process,
>we can see that a pipe, whose file-descriptor is definitely included in the
>fd_set "readfds" (and "n" is also high enough) has a byte in it available for
>reading - and just leaving gdb again is enough to let the server continue just
>fine.
>
>We are using that pipe, which is known only to the same one process, to cause
>select() to return immediately if a signal (SIGUSR1) had been delivered to the
>process (by another process), there's a signal handler installed that does
>nothing but a (non-blocking) write of 1 byte to the writing end of the pipe.
>
>This mechanism worked fine before kernel 2.6, and it is still working in 99.99% of
>the cases, but under heavy load, every few hours, we'll see the hanging select()
>as mentioned above.

Following up on my own (yes, still using kernel 2.6.9, we will try it with .12 later -
but I wanted to share the latest results on my investigation nevertheless):

We found that when the server process hangs inside the select() call, the
kernel structure flags indicate a situation where select() shall indeed return:

The result of
 > ps -eo cmd,pid,sig_pend,sig_block,sig_catch,sig_ignore

for the hanging process is:

  CMD                PID           SIGNAL          BLOCKED          CATCHED          IGNORED
  ./csn io_child   10972 0000000000000200 0000000000000000 000000001181764b 0000000000000000

which means that SIGUSR1 is known to be pending (and of course SIGUSR1 is also catched
as there's a signal handler installed as described above).

Correct me if I'm wrong, but isn't it a clear sign of something being wrong
with select() if it does not return in this situation?

Sending the hanging process another "kill -s SIGUSR1 10972" does not change the
situation, the process keeps hanging and the values printed above do not change.

Sending a different signal or attaching/detaching gdb causes select() to return,
with the pending value returning to 0 as expected.

So my suspicion is that there's a race condition where select() goes to sleep
even though SIGUSR1 just arrives.

Will follow up once we could upgrade to 2.6.12 or gained significant news,
I'm thankful for any ideas on this issue at any time.

Regards,

Lutz Vieweg


