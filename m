Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750751AbWH1MuL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750751AbWH1MuL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 08:50:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750765AbWH1MuL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 08:50:11 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:30160 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750751AbWH1MuJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 08:50:09 -0400
Date: Mon, 28 Aug 2006 07:50:06 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Julio Auto <mindvortex@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, Solar Designer <solar@openwall.com>,
       Willy Tarreau <w@1wt.eu>, linux-kernel@vger.kernel.org,
       "Serge E. Hallyn" <serue@us.ibm.com>
Subject: Re: [PATCH] loop.c: kernel_thread() retval check - 2.6.17.9
Message-ID: <20060828125006.GC8282@sergelap.austin.ibm.com>
References: <18d709710608232341x491b4bf6g87f74ef830a203@mail.gmail.com> <20060828035556.GA27902@openwall.com> <20060827214141.db40620d.akpm@osdl.org> <18d709710608272203q740962rd0c3f2a3be95138b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <18d709710608272203q740962rd0c3f2a3be95138b@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Julio Auto (mindvortex@gmail.com):
> On 8/28/06, Andrew Morton <akpm@osdl.org> wrote:
> >The plan is to stop using the deprecated kernel_thread() in loop 
> >altogether.
> >
> >Please review
> >
> >>ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc4/2.6.18-rc4-mm3/broken-out/kthread-convert-loopc-to-kthread.patch
> >
> 
> Well, the reason behind this patch is just adding a little bit of
> cleanup code (ie., cleaning the 'lo' object) to the case when the
> kernel thread creation fails, regardless of what implementation
> loop_set_fd() uses to accomplish this.
> In fact, I think the concept it's still usable after applying the
> patch you mentioned, since after changing kernel_thread() for
> kthread_create(), the only cleanup code added is setting lo->lo_thread
> to NULL.
> 
> Cheers,
> 
>    Julio Auto

The attached patch does the same resource checks in the kthread version
from 2.6.18-rc4-mm2.

thanks,
-serge

Subject: [PATCH] loop: forward-port resource leak checks from Solar

Forward port of the patch by Solar and ported by Julio, ported
to the -mm tree.

Compiles, boots, and passes my looptorturetest.sh.

Signed-off-by: Serge E. Hallyn <serue@us.ibm.com>

---

 drivers/block/loop.c |   13 +++++++++++--
 1 files changed, 11 insertions(+), 2 deletions(-)

1a32f47ff67796d8ee8d088d3ba6f54e834e6004
diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index ced8a78..c2e1862 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -826,13 +826,22 @@ static int loop_set_fd(struct loop_devic
 						lo->lo_number);
 	if (IS_ERR(lo->lo_thread)) {
 		error = PTR_ERR(lo->lo_thread);
-		lo->lo_thread = NULL;
-		goto out_putf;
+		goto out_clr;
 	}
 	lo->lo_state = Lo_bound;
 	wake_up_process(lo->lo_thread);
 	return 0;
 
+out_clr:
+	lo->lo_thread = NULL;
+	lo->lo_device = NULL;
+	lo->lo_backing_file = NULL;
+	lo->lo_flags = 0;
+	set_capacity(disks[lo->lo_number], 0);
+	invalidate_bdev(bdev, 0);
+	bd_set_size(bdev, 0);
+	mapping_set_gfp_mask(mapping, lo->old_gfp_mask);
+	lo->lo_state = Lo_unbound;
  out_putf:
 	fput(file);
  out:
-- 
1.1.6
