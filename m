Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267521AbUIGTAH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267521AbUIGTAH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 15:00:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268528AbUIGS50
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 14:57:26 -0400
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36]:52094 "HELO
	smtp005.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S267521AbUIGSxu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 14:53:50 -0400
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
To: user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [uml-devel] Re: [patch 1/3] uml-ubd-no-empty-queue
Date: Tue, 7 Sep 2004 20:50:25 +0200
User-Agent: KMail/1.6.1
Cc: Jens Axboe <axboe@suse.de>, akpm@osdl.org, jdike@addtoit.com,
       linux-kernel@vger.kernel.org
References: <20040906174447.238788D1E@zion.localdomain> <20040907093559.GL6323@suse.de>
In-Reply-To: <20040907093559.GL6323@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200409072050.25814.blaisorblade_spam@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 07 September 2004 11:35, Jens Axboe wrote:
> On Mon, Sep 06 2004, blaisorblade_spam@yahoo.it wrote:

> Patch is correct.
Ok, thanks. Do you see anything else that needs fixing? The code the patch 
below removes has hidden this bug, so there could be other serious bugs (and 
by serious I mean Oopses or data loss).

Known issues:
- need to port to BIOs (a bit hard because I need first to understand the 
request mangling - see cowify_req. The code idea is to redirect each sector 
independently either to the UBD backing file or to the COW file. COW stand 
for Copy On Write: it allows to have the UBD read only and a COW file 
containing just the changes).

- Uml SMP support does not compile from sometimes so spinlocking is broken in 
ubd_finish (only in some cases - when called by do_ubd_request and thread_fd 
== -1). To see this, add ubd=sync on command line and turn spinlock debugging 
on.

--- uml-linux-2.6.8.1/arch/um/drivers/ubd_kern.c~uml-ubd-any-elevator   
2004-08-29 14:40:53.731043416 +0200
+++ uml-linux-2.6.8.1-paolo/arch/um/drivers/ubd_kern.c  2004-08-29 
14:40:53.733043112 +0200
@@ -749,8 +749,6 @@ int ubd_init(void)
                return -1;
        }
                
-       elevator_init(ubd_queue, &elevator_noop);
-
        if (fake_major != MAJOR_NR) {
                char name[sizeof("ubd_nnn\0")];
 
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
