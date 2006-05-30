Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751207AbWE3Dgl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751207AbWE3Dgl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 23:36:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751213AbWE3Dgl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 23:36:41 -0400
Received: from pne-smtpout2-sn2.hy.skanova.net ([81.228.8.164]:16856 "EHLO
	pne-smtpout2-sn2.hy.skanova.net") by vger.kernel.org with ESMTP
	id S1751207AbWE3Dgl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 23:36:41 -0400
Date: Tue, 30 May 2006 05:36:31 +0200
From: Voluspa <lista1@comhem.se>
To: wfg@mail.ustc.edu.cn
Cc: Valdis.Kletnieks@vt.edu, linux-kernel@vger.kernel.org
Subject: Re: Adaptive Readahead V14 - statistics question...
Message-Id: <20060530053631.57899084.lista1@comhem.se>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Sorry about the top-post, I'm not subscribed.

On 2006-05-30 0:37:57 Wu Fengguang wrote:
> On Mon, May 29, 2006 at 03:44:59PM -0400, Valdis Kletnieks wrote:
[...]
>> doing anything useful? (One thing I've noticed is that xmms, rather
>> than gobble up 100K of data off disk every 10 seconds or so, snarfs
>> a big 2M chunk every 3-4 minutes, often sucking in an entire song at
>> (nearly) one shot...)
>
> Hehe, it's resulted from the enlarged default max readahead size(128K
> => 1M). Too much aggressive? I'm interesting to know the recommended
> size for desktops, thanks. For now you can adjust it through the
> 'blockdev --setra /dev/hda' command.

And notebooks? I'm running a 64bit system with 2gig memory and a 7200
RPM disk. Without your patches a movie like Elephants_Dream_HD.avi
causes a continuous silent read. After patching 2.6.17-rc5 (more on that
later) there's a slow 'click-read-click-read-click-etc' during the
same movie as the head travels _somewhere_ to rest(?) between reads.

Distracting in silent sequences, and perhaps increased disk wear/tear.
I'll try adjusting the readahead size towards silence tomorrow.

But as size slides in a mainstream direction, whence will any benefit
come - in this Joe-average case? It's not a faster 'cp' at least:

_Cold boot between tests - Copy between different partitions_

2.6.17-rc5-proper (Elephants_Dream_HD.avi 854537054 bytes)

real    0m44.050s
user    0m0.076s
sys     0m6.344s

2.6.17-rc5-patched

real    0m49.353s
user    0m0.075s
sys     0m6.287s

2.6.17-rc5-proper (compiled kernel tree linux-2.6.17-rc5 ~339M)

real    0m47.952s
user    0m0.198s
sys     0m6.118s

2.6.17-rc5-patched

real    0m46.513s
user    0m0.200s
sys     0m5.827s

Of course, my failure to see speed-ups could well be 'cos of a botched
patch transfer (or some kind of missing groundwork only available in
-mm). There was one reject in particular which made me pause. I'm no
programmer... and 'continue;' is a weird direction. At the end I settled
on:

[mm/readahead.c]
@@ -184,8 +289,10 @@
 					page->index, GFP_KERNEL)) {
 			ret = mapping->a_ops->readpage(filp, page);
 			if (ret != AOP_TRUNCATED_PAGE) {
-				if (!pagevec_add(&lru_pvec, page))
+				if (!pagevec_add(&lru_pvec, page)) {
+					cond_resched();
 					__pagevec_lru_add(&lru_pvec);
+				}
 				continue;
 			} /* else fall through to release */
 		}

The full 82K experiment can temprarily be found at this location:
http://web.comhem.se/~u46139355/storetmp/adaptive-readahead-v14-linux-2.6.17-rc5-part-01to28of32.patch

At least it hasn't eaten my (backed up) disk yet ;-)

Mvh
Mats Johannesson
--
