Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316548AbSEaSkU>; Fri, 31 May 2002 14:40:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316574AbSEaSkT>; Fri, 31 May 2002 14:40:19 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:19552 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S316548AbSEaSkS>; Fri, 31 May 2002 14:40:18 -0400
Date: Fri, 31 May 2002 20:40:14 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: linux-kernel@vger.kernel.org
Cc: Andrey Nekrasov <andy@spylog.ru>
Subject: Re: 2.4.19pre9aa2
Message-ID: <20020531184014.GJ1172@dualathlon.random>
In-Reply-To: <20020531051841.GA1172@dualathlon.random> <20020531131306.GA29960@spylog.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 31, 2002 at 05:13:06PM +0400, Andrey Nekrasov wrote:
> Hello Andrea Arcangeli,
> 
> 
> Stability fine. [..]

Cool thanks :)

> [..] But something happened with interactivity. If to start the
> countable task, enter on the computer on ssh, to make "su" - bothers to wait.
> 
> On 2.4.19pre8aa3 such was not. Because of "O1"?

if it's a userspace-cpu intensive background load, most probably because
of o1. The dyn-sched (before I integraed o1 that obsoleted it) was very
good at detecting cpu hogs and to avoid them to disturb interactive
tasks like ssh-shell, of course o1 also has a sleep_time/sleep_avg
derived from the dyn-sched idea from Davide, but maybe the constants are
tuned in a different manner.

Can you try to renice at +19 the cpu hogs and see if you still get bad
interactivity?

The other possibility is that the bad interactivity is due to bad
sched-latency, so that the scheduler posts a reschedule via irq
(schedule_tick()) but the function schedule() is never invoked because
the kernel spins on a loop etc... Now the fixes to prune_icache might
have increased the sched-latency in some case when you shrink the cache
but in turn now you release the inodes and also we roll the list, so
overall should be even an improvement for sched latency for you. And I
doubt you're exercising such path so frequently that it makes a
difference (even if you're certainly exercising it to test the fix
worked). So I would suggest to run some readprofile and to see if
prune_icache/invalidate_inode_pages goes up a lot in the profiling. Also
please check if the cpu load is all in userspace during the bad
interactivity, if it's all userspace load the bad sched latency is
almost certainly not the case.

Andrea
