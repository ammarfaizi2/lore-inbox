Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274865AbRIZHmG>; Wed, 26 Sep 2001 03:42:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274866AbRIZHl4>; Wed, 26 Sep 2001 03:41:56 -0400
Received: from [194.100.11.136] ([194.100.11.136]:58496 "HELO 136.quartal.com")
	by vger.kernel.org with SMTP id <S274865AbRIZHlo>;
	Wed, 26 Sep 2001 03:41:44 -0400
Subject: 2.4.10 swap behaviour
From: Osma Ahvenlampi <oa@iki.fi>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.14.99+cvs.2001.09.22.08.08 (Preview Release)
Date: 26 Sep 2001 10:41:48 +0300
Message-Id: <1001490108.1444.34.camel@136.quartal.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cheers,

Yesterday, after upgrading to 2.4.10 and deciding it was significantly
better about memory usage under light load than 2.4.9, I ran a
pathological test case with rather interesting results..

My machine is a 900MHz P3 laptop with 512MB of memory (just upgraded
from 256M - most of my experience with earlier 2.4 kernels up to 2.4.9
is with 256M, which adds some variability into the subjective
experience..). I ran these tests with a vanilla 2.4.9 kernel and 2.4.10
patched with Robert Love's 2.4.10-preempt patches.

Under both kernels, I ran a simulated medium-load session (Ximian Gnome,
Evolution, a Java server, XEmacs and a 128MB VMware session open but not
particularly active, no net connection), and then started a cat /dev/dvd
>/dev/null process, watching the memory usage pattern with vmstat and
free. Before the cat, I had about 190 megs of memory used (disregarding
buffers/cache) - the VMware session had not allocated all of it's 128MB
limit, remaining around 80 megs at the point.

2.4.9 would gradually increase its buffer and cache memory until were
around 150-200 megs. At this point, a lot of the applications had been
swapped out, with 60 megs of swap in use, and the system was very
sluggish. I aborted the cat with a ctrl-c and the system regained
responsiveness fairly quickly (paging heavily until most code was back
in).

2.4.10 remained more responsive in the beginning, and I noticed that the
buffer allocation would actually drop from the initial 15 megs to under
5. However, the cache usage kept on going up, until about 440 megs of
RAM was used by the cache (and less than a meg in buffers!). At this
point, about 90 megs of swap had been allocated, and the machine quite
quickly lost all response. The mouse pointer would not move, the active
terminal window showed no response to keyboard, I could not switch to
another VC. Except for the constant disk access, the machine might as
well been completely hung, and for a moment I thought it was. Eventually
I was forced to eject the entire DVD drive from the machine (good thing
I was testing on a laptop! :)), at which point the cat process obviously
would be aborted. After that, it took about 20-30 seconds until the
terminal started to respond (slowly), and a couple of minutes before the
all the applications were again usable (after heavy paging again,
obviously).

Conclusion: 2.4.10 buffer behaviour is dramatically different, and the
system remains responsive somewhat longer under medium load - some of
that might be attributed to the preempt patches, however. Under heavy
sequential IO load, the cache still has a pathological behaviour of
forcing everything else out of memory, which can make the system act as
if completely dead, unless the IO process can be aborted. The improved
behaviour under moderate load makes the transition from "paging but
decent" to "completely unusable" somewhat delayed but more sudden when
it does happen.

let me know if you want me to test something different..

-- 
Osma Ahvenlampi <oa@iki.fi>

