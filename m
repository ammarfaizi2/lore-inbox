Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262300AbVGMWb0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262300AbVGMWb0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 18:31:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262779AbVGMW3X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 18:29:23 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:26809 "EHLO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with ESMTP
	id S262799AbVGMWXy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 18:23:54 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Paul Slootman <paul+nospam@wurtel.net>
Date: Thu, 14 Jul 2005 08:23:32 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17109.37988.800325.47795@cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: Oops when running mkreiserfs on large (9TB) raid0 set on AMD64 SMP
In-Reply-To: message from Paul Slootman on Wednesday July 13
References: <20050713084152.GA5765@wurtel.net>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
X-CSE-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on 
	tone.orchestra.cse.unsw.EDU.AU
X-CSE-Spam-Level: 
X-CSE-Spam-Status: No, score=-4.5 required=5.0 tests=ALL_TRUSTED,BAYES_00 
	autolearn=ham version=3.0.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday July 13, paul+nospam@wurtel.net wrote:
> After having installed a base system (Debian) on our shiny new AMD64 SMP
> system, with 2 x 3ware 9000 SATA controllers for a total of 24 disks
> (excluding the 2 connected to the motherboard), I wanted as a "quick"
> test to put them all in a raid0 and put a reiserfs on it (just to see
> the 'df' output :-). It all went OK up to the mkreiserfs, when an Oops
> happened,.....
....
> Output from kern.log:
> 
> Aug  9 20:08:37 localhost kernel: raid0: done.
> Aug  9 20:08:37 localhost kernel: raid0 : md_size is 9374734848 blocks.
> Aug  9 20:08:37 localhost kernel: raid0 : conf->hash_spacing is 9374734848 blocks.
> Aug  9 20:08:37 localhost kernel: raid0 : nb_zone is 12.
> Aug  9 20:08:37 localhost kernel: raid0 : Allocating 96 bytes for hash.
> Aug  9 20:09:18 localhost kernel: Unable to handle kernel NULL pointer dereference at 0000000000000028 RIP:
> Aug  9 20:09:18 localhost kernel: <ffffffff8808eb98>{:raid0:raid0_make_request+472}

Looks like the problem is at:
		sector_div(x, (unsigned long)conf->hash_spacing);
		zone = conf->hash_table[x];

I had (naively) assumed that sector_div divided a "sector_t" by an
"unsigned long".  This is partly based on the code in
include/linux/blkdev.h:

#ifdef CONFIG_LBD
# include <asm/div64.h>
# define sector_div(a, b) do_div(a, b)
#else
# define sector_div(n, b)( \
{ \
	int _res; \
	_res = (n) % (b); \
	(n) /= (b); \
	_res; \
} \
)
#endif 

which suggests (to me) that on a 64bit arch, anything that the
compiler copes with it OK.

However, CONFIG_LBD is defined for x86-64, and asm/div64.h includes
asm-generic/div64.h which says:

#if BITS_PER_LONG == 64

# define do_div(n,base) ({					\
	uint32_t __base = (base);				\
	uint32_t __rem;						\
	__rem = ((uint64_t)(n)) % __base;			\
	(n) = ((uint64_t)(n)) / __base;				\
	__rem;							\
 })


which is a significantly different macro and suggests that the divisor
must be 32 bit.

A bit more documentation and a bit less code duplication would go a
long way here.
(and WHY do we have uint32_t, u32, and __u32 all actively used in the
kernel???)

Anyway, the following patch, if it compiles, might changed the
behaviour of raid0 -- possibly even improve it :-)

Thanks for the report.

Success/failure reports of this patch would be most welcome.

NeilBrown
--
Fix raid0's attempt to divide by 64bit numbers

Apparently sector_div is only guaranteed to work with a 32bit divisor,
even on 64bit architectures.  So allow for this in raid0.

Signed-off-by: Neil Brown <neilb@cse.unsw.edu.au>

### Diffstat output
 ./drivers/md/raid0.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff ./drivers/md/raid0.c~current~ ./drivers/md/raid0.c
--- ./drivers/md/raid0.c~current~	2005-07-14 08:18:48.000000000 +1000
+++ ./drivers/md/raid0.c	2005-07-14 08:18:53.000000000 +1000
@@ -314,16 +314,16 @@ static int raid0_run (mddev_t *mddev)
 		sector_t space = conf->hash_spacing;
 		int round;
 		conf->preshift = 0;
-		if (sizeof(sector_t) > sizeof(unsigned long)) {
+		if (sizeof(sector_t) > sizeof(u32)) {
 			/*shift down space and s so that sector_div will work */
-			while (space > (sector_t) (~(unsigned long)0)) {
+			while (space > (sector_t) (~(u32)0)) {
 				s >>= 1;
 				space >>= 1;
 				s += 1; /* force round-up */
 				conf->preshift++;
 			}
 		}
-		round = sector_div(s, (unsigned long)space) ? 1 : 0;
+		round = sector_div(s, (u32)space) ? 1 : 0;
 		nb_zone = s + round;
 	}
 	printk("raid0 : nb_zone is %d.\n", nb_zone);
@@ -443,7 +443,7 @@ static int raid0_make_request (request_q
 		volatile
 #endif
 		sector_t x = block >> conf->preshift;
-		sector_div(x, (unsigned long)conf->hash_spacing);
+		sector_div(x, (u32)conf->hash_spacing);
 		zone = conf->hash_table[x];
 	}
  
