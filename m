Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129881AbRCFJAV>; Tue, 6 Mar 2001 04:00:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129986AbRCFJAO>; Tue, 6 Mar 2001 04:00:14 -0500
Received: from mandrakesoft.mandrakesoft.com ([216.71.84.35]:45432 "EHLO
	mandrakesoft.mandrakesoft.com") by vger.kernel.org with ESMTP
	id <S129835AbRCFJAA>; Tue, 6 Mar 2001 04:00:00 -0500
Date: Tue, 6 Mar 2001 02:59:31 -0600
From: Philipp Rumpf <prumpf@mandrakesoft.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Kenn Humborg <kenn@linux.ie>, Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: kmalloc() alignment
Message-ID: <20010306025931.A12655@mandrakesoft.mandrakesoft.com>
In-Reply-To: <20010304221711.A1023@excalibur.research.wombat.ie> <E14Zh5G-0005tP-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4us
In-Reply-To: <E14Zh5G-0005tP-00@the-village.bc.nu>; from Alan Cox on Sun, Mar 04, 2001 at 10:34:31PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 04, 2001 at 10:34:31PM +0000, Alan Cox wrote:
> > Does kmalloc() make any guarantees of the alignment of allocated
> > blocks?  Will the returned block always be 4-, 8- or 16-byte
> > aligned, for example?
> 
> There are people who assume 16byte alignment guarantees. I dont think anyone
> has formally specified the guarantee beyond 4 bytes tho

Userspace malloc is "suitably aligned for any kind of variable", so I think
expecting 8 bytes alignment (long long on 32-bit platforms) should be okay.

>From reading the code it seems as though we actually use L1_CACHE_BYTES,
and I think it might be a good idea to document the current behaviour (as
long as there's no good reason to change it ?)

diff -ur linux/mm/slab.c linux-prumpf/mm/slab.c
--- linux/mm/slab.c	Tue Mar  6 00:54:38 2001
+++ linux-prumpf/mm/slab.c	Tue Mar  6 01:00:47 2001
@@ -1525,9 +1525,10 @@
  * @flags: the type of memory to allocate.
  *
  * kmalloc is the normal method of allocating memory
- * in the kernel.  Note that the @size parameter must be less than or
- * equals to %KMALLOC_MAXSIZE and the caller must ensure this. The @flags
- * argument may be one of:
+ * in the kernel.  It returns a pointer (aligned to a hardware cache line
+ * boundary) to the allocated memory, or %NULL in case of failure. Note that
+ * the @size parameter must be less than or equal to %KMALLOC_MAXSIZE and
+ * the caller must ensure this. The @flags argument may be one of:
  *
  * %GFP_USER - Allocate memory on behalf of user.  May sleep.
  *
