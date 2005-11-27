Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751038AbVK0Ujq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751038AbVK0Ujq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Nov 2005 15:39:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751092AbVK0Ujq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Nov 2005 15:39:46 -0500
Received: from tirith.ics.muni.cz ([147.251.4.36]:53740 "EHLO
	tirith.ics.muni.cz") by vger.kernel.org with ESMTP id S1751038AbVK0Ujp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Nov 2005 15:39:45 -0500
Date: Sun, 27 Nov 2005 21:39:24 +0100
From: Jan Kasprzak <kas@fi.muni.cz>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Andrew Morton <akpm@osdl.org>, nickpiggin@yahoo.com.au,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.14 kswapd eating too much CPU
Message-ID: <20051127203924.GE27805@fi.muni.cz>
References: <20051122163550.160e4395.akpm@osdl.org> <20051123010122.GA7573@fi.muni.cz> <4383D1CC.4050407@yahoo.com.au> <20051123051358.GB7573@fi.muni.cz> <20051123131417.GH24091@fi.muni.cz> <20051123110241.528a0b37.akpm@osdl.org> <20051123202438.GE28142@fi.muni.cz> <20051123123531.470fc804.akpm@osdl.org> <20051124083141.GJ28142@fi.muni.cz> <20051127084231.GC20701@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051127084231.GC20701@logos.cnet>
User-Agent: Mutt/1.4.1i
X-Muni-Spam-TestIP: 147.251.48.3
X-Muni-Envelope-From: kas@fi.muni.cz
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti wrote:
: Out of curiosity, what is the size of the inode cache from /proc/slabinfo 
: at this moment? 
: 
: Because even though the traces shows kswapd trying to reclaim i-cache, the percentage
: of i-cache is really small:
: 
: inode_cache         1164   1224    600    6    1 : tunables   54   27    8 : slabdata    204    204      0
: dentry_cache       44291  48569    224   17    1 : tunables  120   60    8 : slabdata   2857   2857     51
: 
	The size of icache is similar to that shown above:

# egrep '^(inode|dentry)_cache' /proc/slabinfo

inode_cache         1189   1326    600    6    1 : tunables   54   27    8 : slabdata    221    221      0
dentry_cache       41845  45509    224   17    1 : tunables  120   60    8 : slabdata   2677   2677      0

inode_cache         1212   1326    600    6    1 : tunables   54   27    8 : slabdata    221    221      0
dentry_cache       42662  48892    224   17    1 : tunables  120   60    8 : slabdata   2876   2876    288

	However, the traces I have sent are traces of kswapd1, which at that
time was eating around 50% of CPU, while kswapd0 was at >95%. I have not
managed to get the trace of kswapd0 yet.

	I have tried to bind the serial IRQ to CPU0 to get the trace of
kswapd0 (echo 1 >/proc/irq/4/smp_affinity). After sysrq-p I get the dump
of registers at CPU0, but the strange thing is, that I get the stack trace
of kacpid instead of kswapd0 (kacpid is not even visible in top(1) output,
and it has a total of 0 seconds of CPU time consumed since boot, while kswapd0
is first in top(1) eating >95% of CPU). Why kacpid? When I bind the serial IRQ
to CPU1, I get the trace of PID 0 (swapper).

	The task that probably triggers this problem is a cron job
doing full-text indexing of mailing list archive, so it accesses lots
of small files, and then recreates the inverted index, which is one big
file. So maybe inode cache shrinking or something may be the problem there.
However, the cron job does an incremental reindexing only, so I think it
reads less than 100 files per each run.
: 
: Maybe you should also try profile/oprofile during the kswapd peeks?
: 
	Do you have any details on it? I can of course RTFdocs of oprofile,
but should I try to catch something special?

-Yenya

-- 
| Jan "Yenya" Kasprzak  <kas at {fi.muni.cz - work | yenya.net - private}> |
| GPG: ID 1024/D3498839      Fingerprint 0D99A7FB206605D7 8B35FCDE05B18A5E |
| http://www.fi.muni.cz/~kas/    Journal: http://www.fi.muni.cz/~kas/blog/ |
> Specs are a basis for _talking_about_ things. But they are _not_ a basis <
> for implementing software.                              --Linus Torvalds <
