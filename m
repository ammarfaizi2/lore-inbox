Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315547AbSECD3a>; Thu, 2 May 2002 23:29:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315548AbSECD33>; Thu, 2 May 2002 23:29:29 -0400
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:43662 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S315547AbSECD32>; Thu, 2 May 2002 23:29:28 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Date: Fri, 3 May 2002 13:28:41 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15570.1001.804006.353135@notabene.cse.unsw.edu.au>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] umem.c - Re: Linux 2.4.19-pre8: compile failure - umem.c, sdla_fr.c
In-Reply-To: message from Eyal Lebedinsky on Friday May 3
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday May 3, eyal@eyal.emu.id.au wrote:
> Marcelo Tosatti wrote:
> > Here goes the pre8. I plan just one more -pre before starting the -rc
> > stage.
> 
> I do not have the time to investigate this, so just the failure reports
> follow.
> 

Thanks.  The following patch should fix the umem problems, however....
> 
> gcc -D__KERNEL__ -I/data2/usr/local/src/linux-2.4-pre/include -Wall
> -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
> -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686
> -malign-functions=4  -DMODULE -DMODVERSIONS -include
> /data2/usr/local/src/linux-2.4-pre/include/linux/modversions.h 
> -nostdinc -I /usr/lib/gcc-lib/i386-linux/2.95.4/include
> -DKBUILD_BASENAME=umem  -c -o umem.o umem.c
> umem.c:955: warning: `set_bh_page' redefined
> /data2/usr/local/src/linux-2.4-pre/include/linux/modules/buffer.ver:8:
> warning: this is the location of the previous definition
> umem.c:136: field `tasklet' has incomplete type
> umem.c: In function `mm_start_io':
> umem.c:343: warning: right shift count >= width of type

I don't think that this one is fix-able (good that it is only a
warning).
Depending on CONFIG options, dma_addr_t could be 32 bits (producing a
warning) or could be 64 bits (and so requiring the code).

NeilBrown

### Comments for ChangeSet
Fix some compiling problems with umem.c

1/ set_bh_page is now exported, so we don't need our own copy
2/ linux/interrupt.h needed to be included.



 ----------- Diffstat output ------------
 ./drivers/block/umem.c |   21 +--------------------
 1 files changed, 1 insertion(+), 20 deletions(-)

--- ./drivers/block/umem.c	2002/05/03 03:05:45	1.1
+++ ./drivers/block/umem.c	2002/05/03 03:27:12	1.2
@@ -39,6 +39,7 @@
 #include <linux/ioctl.h>
 #include <linux/module.h>
 #include <linux/init.h>
+#include <linux/interrupt.h>
 #include <linux/smp_lock.h>
 #include <linux/timer.h>
 #include <linux/pci.h>
@@ -945,26 +946,6 @@
 {
 	mark_buffer_uptodate(bh, uptodate);
 	unlock_buffer(bh);
-}
-
-/* following copied from buffer.c
- * when it gets exported, as it should be, this
- * can be removed.
- */
-/* #define avoids compiler complaints */
-#define set_bh_page mm_set_bh_page
-static void set_bh_page (struct buffer_head *bh, struct page *page, unsigned long offset)
-{
-	bh->b_page = page;
-	if (offset >= PAGE_SIZE)
-		BUG();
-	if (PageHighMem(page))
-		/*
-		 * This catches illegal uses and preserves the offset:
-		 */
-		bh->b_data = (char *)(0 + offset);
-	else
-		bh->b_data = page_address(page) + offset;
 }
 
  
