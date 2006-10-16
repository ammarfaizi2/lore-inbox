Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422739AbWJPTbm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422739AbWJPTbm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 15:31:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422854AbWJPTbm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 15:31:42 -0400
Received: from rhlx01.fht-esslingen.de ([129.143.116.10]:30349 "EHLO
	rhlx01.fht-esslingen.de") by vger.kernel.org with ESMTP
	id S1422739AbWJPTbl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 15:31:41 -0400
Date: Mon, 16 Oct 2006 21:31:40 +0200
From: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: "Randy.Dunlap" <rdunlap@xenotime.net>, Andrew Morton <akpm@osdl.org>,
       Erik Frederiksen <erik_frederiksen@pmc-sierra.com>,
       linux-kernel@vger.kernel.org
Subject: Re: IS_ERR Threshold Value
Message-ID: <20061016193140.GA6422@rhlx01.fht-esslingen.de>
References: <1151528227.3904.1110.camel@girvin.pmc-sierra.bc.ca> <20060628140825.692f31be.rdunlap@xenotime.net> <20060629181013.GA18777@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060629181013.GA18777@linux-mips.org>
User-Agent: Mutt/1.4.2.1i
X-Priority: none
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jun 29, 2006 at 07:10:13PM +0100, Ralf Baechle wrote:
> On Wed, Jun 28, 2006 at 02:08:25PM -0700, Randy.Dunlap wrote:
> 
> > Hi,
> > Peter Anvin mentioned just a few days ago that this threshold value
> > should be 4095 for all arches.  I think we need to get that patch
> > done & submitted to Andrew for -mm.
> 
> So here the patch is:
> 
>  o Raise the maximum error number in IS_ERR_VALUE to 4095.
>  o Make that number available as a new constant MAX_ERRNO.
> 
> Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
> 
> diff --git a/include/linux/err.h b/include/linux/err.h
> index ff71d2a..cd3b367 100644
> --- a/include/linux/err.h
> +++ b/include/linux/err.h
> @@ -13,7 +13,9 @@ #include <asm/errno.h>
>   * This should be a per-architecture thing, to allow different
>   * error and pointer decisions.
>   */
> -#define IS_ERR_VALUE(x) unlikely((x) > (unsigned long)-1000L)
> +#define MAX_ERRNO	4095
> +
> +#define IS_ERR_VALUE(x) unlikely((x) >= (unsigned long)-MAX_ERRNO)
>  
>  static inline void *ERR_PTR(long error)
>  {

# cat /proc/likely_prof |grep -v "^ "

Likely Profiling Results
[+- ] Type | # True | # False | Function:Filename@Line
+unlikely |     1872|        0  IS_ERR()@:include/linux/err.h@34
-likely   |       88|     1033  remove_from_swapped_list()@:mm/swap_prefetch.c@140
-likely   |      311|     2679  tcp_transmit_skb()@:net/ipv4/tcp_output.c@372
-likely   |        0|   175176  __switch_to_xtra()@:arch/i386/kernel/process.c@569
+unlikely |       20|       19  remap_pte_range()@:mm/memory.c@1282
+unlikely |        9|        0  signal_pending()@:include/linux/sched.h@1543
+unlikely |        9|        0  signal_pending()@:include/linux/sched.h@1543
-likely   |    15591|    44490  generic_file_buffered_write()@:mm/filemap.c@2350
+unlikely |       45|        0  ll_front_merge_fn()@:block/ll_rw_blk.c@1505
+unlikely |        1|        0  simple_pin_fs()@:fs/libfs.c@419
+unlikely |      216|        0  inotify_find_update_watch()@:fs/inotify.c@597
+unlikely |     1820|        0  get_locked_pte()@:mm/memory.c@1194
+unlikely |    82529|        0  ll_back_merge_fn()@:block/ll_rw_blk.c@1467
+unlikely |   416831|   116869  need_resched()@:include/linux/sched.h@1548
+unlikely | 28334365| 23531065  __lock_acquire()@:kernel/lockdep.c@1994

# uname -a
Linux andi 2.6.19-rc1-mm1 #1 Thu Oct 19 23:55:19 CEST 2006 i686 GNU/Linux

Athlon 1200, Debian


Hmmmmmm...
(I strongly believe I've seen this particular unlikely place trigger sometime
before already!)


Could this be because

+#define IS_ERR_VALUE(x) unlikely((x) >= (unsigned long)-MAX_ERRNO)

should be made to be
#define IS_ERR_VALUE(x) unlikely((unsigned long)(x) >= (unsigned long)-MAX_ERRNO)
similar to what some other code in this discussion thread does?
(don't ask me which code is actually invoking this macro; obviously this
might be a problem due to unexpected (non-)failure which seems to be happening
here)


And some other (un)likely results here seem fishy as well, no matter
what kind of load I throw at my box... (pondering sending some patches
for the worst excesses). Any comments about those results above?

My results seem to strongly indicate that nobody else is doing unlikely
profiling??

Andreas Mohr
