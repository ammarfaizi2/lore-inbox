Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750910AbVKLBU1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750910AbVKLBU1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 20:20:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750890AbVKLBU1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 20:20:27 -0500
Received: from smtp.osdl.org ([65.172.181.4]:24291 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750837AbVKLBU1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 20:20:27 -0500
Date: Fri, 11 Nov 2005 17:20:14 -0800
From: Chris Wright <chrisw@osdl.org>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Chris Wright <chrisw@osdl.org>, Avi Kivity <avi@argo.co.il>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: local denial-of-service with file leases
Message-ID: <20051112012014.GC5856@shell0.pdx.osdl.net>
References: <43737CBE.2030005@argo.co.il> <20051111084554.GZ7991@shell0.pdx.osdl.net> <1131718887.8805.33.camel@lade.trondhjem.org> <20051111183512.GV5856@shell0.pdx.osdl.net> <1131737127.8793.46.camel@lade.trondhjem.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1131737127.8793.46.camel@lade.trondhjem.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Trond Myklebust (trond.myklebust@fys.uio.no) wrote:
> On Fri, 2005-11-11 at 10:35 -0800, Chris Wright wrote:
> > * Trond Myklebust (trond.myklebust@fys.uio.no) wrote:
> > > Bruce has a simpler patch (see attachment). The call to fasync_helper()
> > > in order to free active structures will have already been done in
> > > locks_delete_lock(), so in principle, all we want to do is to skip the
> > > fasync_helper() call in fcntl_setlease().
> > 
> > Yes, that's better, thanks.  Will you make sure it gets to Linus?
> 
> Sure, but I'd like a mail from Avi confirming that this patch too fixes
> his problem, please.

OK, I tested with Avi's test program, and a couple other's I cobbled
together, and they seem to work fine.  But didn't test the samba case
(shouldn't be different...but...).  BTW, the bit below looks like
debugging code.  It's a way for users to spam the kernel log (granted
there is some bit of throttling):

thanks,
-chris
--

Remove time_out_leases() printk that's easily triggered by users.

Signed-off-by: Chris Wright <chrisw@osdl.org>
---

diff --git a/fs/locks.c b/fs/locks.c
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -1105,7 +1105,6 @@ static void time_out_leases(struct inode
 			before = &fl->fl_next;
 			continue;
 		}
-		printk(KERN_INFO "lease broken - owner pid = %d\n", fl->fl_pid);
 		lease_modify(before, fl->fl_type & ~F_INPROGRESS);
 		if (fl == *before)	/* lease_modify may have freed fl */
 			before = &fl->fl_next;



