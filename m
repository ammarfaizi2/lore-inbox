Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269276AbUIHSMq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269276AbUIHSMq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 14:12:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269272AbUIHSMp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 14:12:45 -0400
Received: from fw.osdl.org ([65.172.181.6]:46553 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269276AbUIHSMO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 14:12:14 -0400
Date: Wed, 8 Sep 2004 11:12:04 -0700
From: Chris Wright <chrisw@osdl.org>
To: blaisorblade_spam@yahoo.it
Cc: akpm@osdl.org, jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [patch 1/1] uml:fix ubd deadlock on SMP
Message-ID: <20040908111204.I1973@build.pdx.osdl.net>
References: <20040908172503.384144933@zion.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20040908172503.384144933@zion.localdomain>; from blaisorblade_spam@yahoo.it on Wed, Sep 08, 2004 at 07:25:02PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* blaisorblade_spam@yahoo.it (blaisorblade_spam@yahoo.it) wrote:
> 
> Trivial: don't lock the queue spinlock when called from the request function.
> Since the faulty function must use spinlock in another case, double-case it.
> And since we will never use both functions together, let no object code be
> shared between them.

Why not add a helper which locks around the core function.  Then either
call helper or core function directly depending on locking needs?

Smth. along the lines of below.

===== arch/um/drivers/ubd_kern.c 1.36 vs edited =====
--- 1.36/arch/um/drivers/ubd_kern.c	2004-08-24 02:08:18 -07:00
+++ edited/arch/um/drivers/ubd_kern.c	2004-09-08 11:06:54 -07:00
@@ -396,14 +396,20 @@
  */
 int intr_count = 0;
 
-static void ubd_finish(struct request *req, int error)
+static inline void ubd_finish(struct request *req, int error)
+{
+ 	spin_lock(&ubd_io_lock);
+	__ubd_finish(req, error);
+	spin_unlock(&ubd_io_lock);
+}
+
+/* call ubd_finish if you need to serialize */
+static void __ubd_finish(struct request *req, int error)
 {
 	int nsect;
 
 	if(error){
- 		spin_lock(&ubd_io_lock);
 		end_request(req, 0);
- 		spin_unlock(&ubd_io_lock);
 		return;
 	}
 	nsect = req->current_nr_sectors;
@@ -412,9 +418,7 @@
 	req->errors = 0;
 	req->nr_sectors -= nsect;
 	req->current_nr_sectors = 0;
-	spin_lock(&ubd_io_lock);
 	end_request(req, 1);
-	spin_unlock(&ubd_io_lock);
 }
 
 static void ubd_handler(void)
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
