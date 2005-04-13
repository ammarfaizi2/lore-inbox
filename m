Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261260AbVDMT2v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261260AbVDMT2v (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 15:28:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261403AbVDMT1p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Apr 2005 15:27:45 -0400
Received: from fire.osdl.org ([65.172.181.4]:54723 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261258AbVDMT0p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Apr 2005 15:26:45 -0400
Date: Wed, 13 Apr 2005 12:26:14 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Yves Crespin <crespin.quartz@wanadoo.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: read failed EINVAL with O_DIRECT flag
Message-Id: <20050413122614.32d1a382.rddunlap@osdl.org>
In-Reply-To: <425D1B83.50809@wanadoo.fr>
References: <425ACC89.3090207@wanadoo.fr>
	<20050411204948.26ab87f0.rddunlap@osdl.org>
	<425BF468.1040403@wanadoo.fr>
	<20050412094752.0f4d88a5.rddunlap@osdl.org>
	<425D1B83.50809@wanadoo.fr>
Organization: OSDL
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: SvC&!/v_Hr`MvpQ*|}uez16KH[#EmO2Tn~(r-y+&Jb}?Zhn}c:Eee&zq`cMb_[5`tT(22ms
 (.P84,bq_GBdk@Kgplnrbj;Y`9IF`Q4;Iys|#3\?*[:ixU(UR.7qJT665DxUP%K}kC0j5,UI+"y-Sw
 mn?l6JGvyI^f~2sSJ8vd7s[/CDY]apD`a;s1Wf)K[,.|-yOLmBl0<axLBACB5o^ZAs#&m?e""k/2vP
 E#eG?=1oJ6}suhI%5o#svQ(LvGa=r
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Apr 2005 15:15:47 +0200 Yves Crespin wrote:

| 
|  >| How can I obtains an buffer alignement from a "user program" ?
|  >
|  >I actually left that as an exercise (after I did it at home
|  >last night).  Did you read the hint (below)?
| 
| Well ... either with malloc() and alignement or posix_memalign(),
| read() still failed!
| My read buffer is in user space, so it's copy to kernel space.
| Inside the read() call, it's the kernel buffer which must be aligned?

No, it's the userspace buffer.  However...
the check below isn't even reached for ext3 filesystems in
Linux 2.4.  I.e., 2.4 does not support O_DIRECT for ext3fs.
mount a partition as -t ext2 and your (modified) program
works fine.  Or use 2.6.current...

Sorry to mislead you somewhat, although you do still need
the buffer alignment fixes.


|  >| >In fs/buffer.c, it wants the buffer & the length (size) to be aligned:
|  >| >
|  >| >function: brw_kiovec()
|  >| >
|  >| >    /*
|  >| >     * First, do some alignment and validity checks
|  >| >     */
|  >| >    for (i = 0; i < nr; i++) {
|  >| >        iobuf = iovec[i];
|  >| >        if ((iobuf->offset & (size-1)) ||
|  >| >            (iobuf->length & (size-1)))
|  >| >            return -EINVAL;
|  >| >        if (!iobuf->nr_pages)
|  >| >            panic("brw_kiovec: iobuf not initialised");
|  >| >    }
|  >| >
|  >| >so in your program, malloc() the buf [pointer] (larger than needed)
|  >| >and then align it to a page boundary and pass that aligned pointer
|  >| >to read().


---
~Randy
