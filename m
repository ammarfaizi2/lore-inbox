Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288855AbSAQOev>; Thu, 17 Jan 2002 09:34:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288835AbSAQOem>; Thu, 17 Jan 2002 09:34:42 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:2845 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S288854AbSAQOee>; Thu, 17 Jan 2002 09:34:34 -0500
Date: Thu, 17 Jan 2002 15:35:04 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Diego Calleja <grundig@teleline.es>, linux-kernel@vger.kernel.org
Subject: bugfix backed out
Message-ID: <20020117153504.J4847@athlon.random>
In-Reply-To: <20020116215449Z289156-13996+7212@vger.kernel.org> <Pine.LNX.4.33L.0201162001480.32617-100000@imladris.surriel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <Pine.LNX.4.33L.0201162001480.32617-100000@imladris.surriel.com>; from riel@conectiva.com.br on Wed, Jan 16, 2002 at 08:02:42PM -0200
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2002 at 08:02:42PM -0200, Rik van Riel wrote:
> On Wed, 16 Jan 2002, Diego Calleja wrote:
> > On Wed, 16 Jan 2002, Andrea Arcangeli wrote:
> > > attached) and most important I don't have a single bugreport about the
> > > current 2.4.18pre2aa2 VM (except perhaps the bdflush wakeup that seems
> >
> > Well, I haven't reported it yet, but booting my box with mem=4M
> > gave as result: (running 2.4.18-pre2aa2):
> > diego# cat /var/log/messages | grep gfp
> > Jan 13 15:37:10 localhost kernel: __alloc_pages: 0-order allocation failed
> > (gfp=0xf0/0)
> 
> > Each script of /etc/rc.d was killed by VM when it was started,
> 
> It seems Andrea's patch backs out a bugfix for this problem
> which marcelo and me put into the normal 2.4 kernel ...

hmm, is this the bugfix you mean? that shouldn't really matter to me as
far I can tell, I did it in an alternate way since the first place.

diff -urN 2.4.17pre8/mm/vmscan.c 2.4.17/mm/vmscan.c
--- 2.4.17pre8/mm/vmscan.c      Fri Nov 23 08:21:05 2001
+++ 2.4.17/mm/vmscan.c  Fri Dec 21 20:06:55 2001
@@ -338,7 +338,7 @@
 {
        struct list_head * entry;
        int max_scan = nr_inactive_pages / priority;
-       int max_mapped = nr_pages << (9 - priority);
+       int max_mapped = min((nr_pages << (10 - priority)), max_scan / 10);
 
        spin_lock(&pagemap_lru_lock);
        while (--max_scan >= 0 && (entry = inactive_list.prev) != &inactive_list) {

furthmore I hate those "10" hardwirded magic numbers that you keep
adding. The less of them the better. At least I put those magics in
sysctl.

see what my max_mapped is:

	int orig_max_mapped = SWAP_CLUSTER_MAX * vm_mapped_ratio,

It is controlled by the vm_mapped_ratio and by the swap-cluster. So we
unmap one swap cluster at every vm_mapped_ratio of pages scanned that
were mapped. This ensure we unmap when there's some relevant work to do.
The lower the vm_mapped_ratio, the earlier the kernel will start
swapping/paging. (ah, and of course also the SWAP_CLUSTER_MAX would
better be a sysctl but it isn't yet)

Andrea
