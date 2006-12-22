Return-Path: <linux-kernel-owner+w=401wt.eu-S1161112AbWLVKAV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161112AbWLVKAV (ORCPT <rfc822;w@1wt.eu>);
	Fri, 22 Dec 2006 05:00:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946018AbWLVKAU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Dec 2006 05:00:20 -0500
Received: from sorrow.cyrius.com ([65.19.161.204]:53635 "EHLO
	sorrow.cyrius.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161116AbWLVKAT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Dec 2006 05:00:19 -0500
Date: Fri, 22 Dec 2006 11:00:04 +0100
From: Martin Michlmayr <tbm@cyrius.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Gordon Farquharson <gordonfarquharson@gmail.com>,
       Andrew Morton <akpm@osdl.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Hugh Dickins <hugh@veritas.com>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Arjan van de Ven <arjan@infradead.org>,
       Andrei Popa <andrei.popa@i-neo.ro>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Florian Weimer <fw@deneb.enyo.de>,
       Marc Haber <mh+linux-kernel@zugschlus.de>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       Heiko Carstens <heiko.carstens@de.ibm.com>,
       Arnd Bergmann <arnd.bergmann@de.ibm.com>
Subject: Re: [PATCH] mm: fix page_mkclean_one (was: 2.6.19 file content corruption on ext3)
Message-ID: <20061222100004.GC10273@deprecation.cyrius.com>
References: <Pine.LNX.4.64.0612200928090.6766@woody.osdl.org> <20061220175309.GT30106@deprecation.cyrius.com> <Pine.LNX.4.64.0612201043170.6766@woody.osdl.org> <Pine.LNX.4.64.0612201139280.3576@woody.osdl.org> <97a0a9ac0612202332p1b90367bja28ba58c653e5cd5@mail.gmail.com> <Pine.LNX.4.64.0612202352060.3576@woody.osdl.org> <97a0a9ac0612210117v6f8e7aefvcfb76de1db9120bb@mail.gmail.com> <20061221012721.68f3934b.akpm@osdl.org> <97a0a9ac0612212020i6f03c3cem3094004511966e@mail.gmail.com> <Pine.LNX.4.64.0612212033120.3671@woody.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0612212033120.3671@woody.osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Linus Torvalds <torvalds@osdl.org> [2006-12-21 20:54]:
> But it sounds like I probably misunderstood something, because I thought
> that Martin had acknowledged that this patch actually worked for him.

That's what I thought too but now I can confirm what Gordon sees.  But
it's pretty weird.  Our testcase is to run Debian installer on the
NSLU2 arm device and apt-get would either segfault or hang at this
particular spot in the installation (when apt is first run).  With
your patch, apt works correctly where it normally fails (at least for
me).  I stopped the installation at this point and repeated it several
more times to make sure it's really working.  And, yes, I can repeat
this result.

This time, however, I let the installer continue and it seems that
with your patch apt now works where it failed in the past, but it
hangs later on.  It's pretty weird because I cannot even kill the
process:

sh-3.1# ps aux | grep 31126
root     31126  5.7 20.6  16240  6076 ?        R+   04:45   0:21 apt-get -o APT::Status-Fd=4 -o APT::Keep-Fds::=5 -o APT::Keep-Fds::=6 -q -y -f install popularity-contest
root     31157  0.0  1.6   1516   492 ttyS0    S+   04:51   0:00 grep 31126
sh-3.1# kill -9 31126
sh-3.1# kill -9 31126
sh-3.1# ps aux | grep 31126
root     31126  5.6 20.6  16240  6076 ?        R+   04:45   0:21 apt-get -o APT::Status-Fd=4 -o APT::Keep-Fds::=5 -o APT::Keep-Fds::=6 -q -y -f install popularity-contest
root     31159  0.0  1.6   1516   492 ttyS0    S+   04:51   0:00 grep 31126
sh-3.1#

> Which sounded very similar to your setup (he has a 32M ARM box too, no?)

It's the same device, a Linksys NSLU2.

> Author: Andrew Morton <akpm@osdl.org>

This patch makes it even worse for me.

> -	if (TestClearPageDirty(page) && account_size)
> +	if (TestClearPageDirty(page) && account_size) {
> +		dec_zone_page_state(page, NR_FILE_DIRTY);
>  		task_io_account_cancelled_write(account_size);
> +	}

This hunk (on top of git from about 2 days ago and your latest patch)
results in the installer hanging right at the start.  The Linux kernel
boots fine, the debian-installer is loaded into a ramdisk but when
ncurses is being started it just hangs.  Reverting this hunk makes it
start again.

Does that help or confuse you even more?
-- 
Martin Michlmayr
http://www.cyrius.com/
