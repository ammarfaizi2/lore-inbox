Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270200AbTHQNa4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Aug 2003 09:30:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270097AbTHQNa4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Aug 2003 09:30:56 -0400
Received: from c210-49-248-224.thoms1.vic.optusnet.com.au ([210.49.248.224]:13029
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S270200AbTHQNax (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Aug 2003 09:30:53 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Voluspa <voluspa@comhem.se>
Subject: [RFC] Re: Blender profiling-1 O16.2int
Date: Sun, 17 Aug 2003 23:36:42 +1000
User-Agent: KMail/1.5.3
References: <20030817003128.04855aed.voluspa@comhem.se> <200308171142.33131.kernel@kolivas.org> <20030817073859.51021571.voluspa@comhem.se>
In-Reply-To: <20030817073859.51021571.voluspa@comhem.se>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Mike Galbraith <efault@gmx.de>, Andrew Morton <akpm@osdl.org>,
       William Lee Irwin III <wli@holomorphy.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308172336.42593.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've investigated this starvation issue now that I've been given a testcase. 
First some background.  Mats reported that he could elicit starvation in 
blender so I downloaded that and have been thrashing it out trying to find 
out what happens. Here are relevant excerpts from the discussion.

On Sun, 17 Aug 2003 15:38, Voluspa wrote:
> Ah, the freezes has been there with all 2.6s, just shorter (1/2 - 2
> seconds). Where I didn't see them was in the older blender version of
> 2.23. I'll investigate it more thorough.

This struck me as interesting because the starvation was there in the vanilla 
scheduler anyway, but for a shorter period. Even more interesting was the 
suggestion that it didn't happen with previous versions of blender.

Reproducing it was:

> Voluspa <voluspa@comhem.se> wrote:
>Thusly: Start program, move mouse to get rid of splash screen. Click and
>hold down 3rd mouse button (unless you use simulate 3 buttons in X, then
>it's left-right-mousebutton simultaniously) anywhere on the white grid
>(first view is top-down) and move mouse around... That is how you rotate
>the world plane around an axes. Doing this quickly, or slowly for a
>longer period, I freeze.

Which I tried for some time and eventually managed to get locally. In the 
meantime,

> Voluspa <voluspa@comhem.se> wrote:
> But not in 2.23, not even with this O16.2! Don't see any freezes with
> that older Blender version.

So I had my suspicions about what was happening already based on that 
information. Anyway I ran top in batch mode, reproduced the starvation and 
got this (just X and 3[blender] at one second intervals):

   PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  Command
 782 root      16   0  109m  39m  77m R 80.5  7.9   2:37.17 X
12553 con       15   0 12648 6252 9072 S 19.9  1.2   0:07.98 3

  782 root      16   0  109m  39m  77m R 73.6  7.9   2:37.91 X
12553 con       15   0 12648 6252 9072 R 23.9  1.2   0:08.22 3

  782 root      16   0  109m  39m  77m R 79.5  7.9   2:38.71 X
12553 con       15   0 12648 6252 9072 S 20.9  1.2   0:08.43 3

Starvation starts here:
  782 root      16   0  109m  39m  77m R 95.4  7.9   2:39.67 X
12553 con       15   0 12648 6252 9072 S  3.0  1.2   0:08.46 3

12553 con       16   0 12648 6252 9072 R 73.6  1.2   0:09.20 3
  782 root      17   0  109m  39m  77m R 25.8  7.9   2:39.93 X

12553 con       16   0 12648 6252 9072 R 98.4  1.2   0:10.19 3
 782 root      17   0  109m  39m  77m R  0.0  7.9   2:39.93 X
 
12553 con       16   0 12648 6252 9072 R 99.4  1.2   0:11.19 3
  782 root      17   0  109m  39m  77m R  0.0  7.9   2:39.93 X

12553 con       16   0 12648 6252 9072 R 99.4  1.2   0:12.19 3
  782 root      17   0  109m  39m  77m R  0.0  7.9   2:39.93 X

12553 con       16   0 12648 6252 9072 R 99.9  1.2   0:13.20 3
  782 root      17   0  109m  39m  77m R  0.0  7.9   2:39.93 X

[snip some more seconds]
and ends here:
12553 con       15   0 12648 6252 9072 S 39.8  1.2   0:23.59 3
  782 root      16   0  109m  39m  77m S 16.9  7.9   2:40.10 X

  782 root      15   0  109m  39m  77m S  8.9  7.9   2:40.19 X
12553 con       15   0 12964 6576 9072 S  2.0  1.3   0:23.61 3

Now for those that can't see what this is, blender and X are interactive tasks 
and getting high priority (PRI < 18) which makes sense. During heavy usage of 
blender, it is X that gets pegged for cpu usage (ie it is doing the work for 
blender), and eventually it gets expired onto the expired array for being 
naughty and stops doing anything till all other tasks have finished working 
on the active array. Now normally, blender should just sleep and wait till X 
comes alive again before it does anything. However here it shows clearly that 
it is spinning madly looking for something from X, and poor X can't do 
anything. This is the busy on wait I've described. Meanwhile, since blender 
was seen as an interactive task (which it is), it preempts everything lower 
priority than it till it also gets booted. 

Now in O16.2 I managed to minimise this happening by not allowing tasks to 
preempt their waker, but this has no effect if X gets expired. The evidence I 
really needed was that this also happened to the vanilla scheduler to a 
lesser degree and that it is a software flaw. This same thing happens to 
2.6.0-test3 for 1-2 seconds, and doesn't happen at all with a previous 
version of blender.

So where does this leave us? 

Well first I can remove entirely the not preempting the waker in O16s since 
that is faulty for smp, and doesn't really fix the problem. 

Second, any applications that exhibit this should be fixed since it is a bug. 

Finally I still need to find a way to prevent this from transiently starving 
the system without undoing the interactive improvements to normal 
applications; I certainly don't intend to make them "work nicely" just for 
the sake of it.

I do have some ideas about how to progress with this (some Mike has suggested 
to me previously), but so far most of them involve some detriment to the 
interactive performance on other apps. So I'm appealing to others for ideas.

Comments?

Con

