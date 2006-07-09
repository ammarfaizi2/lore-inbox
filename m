Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030434AbWGIIdZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030434AbWGIIdZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 04:33:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030435AbWGIIdZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 04:33:25 -0400
Received: from mx1.redhat.com ([66.187.233.31]:25815 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030434AbWGIIdY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 04:33:24 -0400
Message-ID: <44B0BF4F.7070102@redhat.com>
Date: Sun, 09 Jul 2006 04:33:19 -0400
From: Rik van Riel <riel@redhat.com>
Organization: Red Hat, Inc
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Ask List <askthelist@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Runnable threads on run queue
References: <loom.20060708T220409-206@post.gmane.org>
In-Reply-To: <loom.20060708T220409-206@post.gmane.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ask List wrote:
> Have an issue maybe someone on this list can help with. 
> 
> At times of very high load the number of processes on the run queue drops to
>  0 then jumps really high and then drops to 0 and back and forth. It seems to
> last 10 seconds or so.

Are you using sendmail by any chance? :)

We start out with a low load averag, so sendmail forks as many
spamassassins as it can...

> procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
>  r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
> 83  0   1328 301684  37868 1520632    0    0     0   264  400  1332 98  2  0  0
> 17  0   1328 293936  37868 1520688    0    0     0     0  537   979 97  3  0  0
> 73  0   1328 293688  37868 1520712    0    0     0     0  268  2643 98  2  0  0
> 80  0   1328 277220  37868 1520756    0    0     0     0  351   824 98  2  0  0
> 49  0   1328 262452  37868 1520800    0    0     0     0  393  1882 97  3  0  0
> 45  0   1328 246796  37868 1520828    0    0     0   304  302  1631 96  4  0  0
> 55  0   1328 243852  37868 1520872    0    0     0     0  356  1101 99  1  0  0
> 17  0   1328 228672  37868 1520916    0    0     0     0  336   748 97  3  0  0
>  0  0   1328 299948  37868 1520956    0    0     0     0  299   821 78  3 19  0
>  0  0   1328 299184  37868 1520960    0    0     0     0  168    78  8  0 92  0

... and guess what?

The load average went through the roof, so sendmail stops forking
spamassassins.  Now nothing is running, and sendmail will not start
forking new spamassassins again until after the load average has
decayed to an acceptable level.

After that, it will fork way too many at once again, and the load
average will go through the roof.  Lather, rinse, repeat.

You'd probably be better off limiting the number of simultaneous
local mail deliveries to something reasonable, so the load average
always stays at an acceptable level - and more importantly, all of
the CPU capacity could be used if needed...

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan
