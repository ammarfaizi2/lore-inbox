Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261432AbULIBun@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261432AbULIBun (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 20:50:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261433AbULIBun
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 20:50:43 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:27112 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261432AbULIBub (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 20:50:31 -0500
Date: Thu, 9 Dec 2004 12:50:24 +1100
From: Greg Banks <gnb@sgi.com>
To: John Levon <levon@movementarian.org>
Cc: Greg Banks <gnb@sgi.com>, Philippe Elie <phil.el@wanadoo.fr>,
       Akinobu Mita <amgta@yacht.ocn.ne.jp>, linux-kernel@vger.kernel.org
Subject: Re: [mm patch] oprofile: backtrace operation does not initialized
Message-ID: <20041209015024.GG4239@sgi.com>
References: <200412081830.51607.amgta@yacht.ocn.ne.jp> <20041208160055.GA82465@compsoc.man.ac.uk> <20041208223156.GB4239@sgi.com> <20041208235623.GA563@zaniah> <20041209003906.GE4239@sgi.com> <20041209014622.GB48804@compsoc.man.ac.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="ZfOjI3PrQbgiZnxM"
Content-Disposition: inline
In-Reply-To: <20041209014622.GB48804@compsoc.man.ac.uk>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ZfOjI3PrQbgiZnxM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 09, 2004 at 01:46:22AM +0000, John Levon wrote:
> On Thu, Dec 09, 2004 at 11:39:06AM +1100, Greg Banks wrote:
> 
> > But for now I don't see any drama with leaving in the ->setup() and
> > ->shutdown() methods when rewriting the ops structure.  Ditto for
> > the ->create_files() methods.
> 
> Wouldn't this mean that we try to set up the NMI stuff regardless of
> forcing the timer ? I can imagine a flaky system where somebody needs to
> avoid going near that stuff.
> 
> timer_init() making sure to set all fields seems reasonable to me.  Or
> oprofile_init() could grab ->backtrace, memset the structure, then
> replace ->backtrace...

Ok, how about this patch?

Greg.
-- 
Greg Banks, R&D Software Engineer, SGI Australian Software Group.
I don't speak for SGI.

--ZfOjI3PrQbgiZnxM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=oprofile-timer-backtrace-fix-2

Allow stack tracing to work when sampling on timer is forced
using the timer=1 boot option.  Reported by Akinobu Mita.

Signed-off-by: Greg Banks <gnb@melbourne.sgi.com>
---
 oprof.c     |    6 ++----
 timer_int.c |    3 +++
 2 files changed, 5 insertions(+), 4 deletions(-)

Index: linux/drivers/oprofile/oprof.c
===================================================================
--- linux.orig/drivers/oprofile/oprof.c	2004-12-04 19:43:37.%N +1100
+++ linux/drivers/oprofile/oprof.c	2004-12-09 09:25:02.%N +1100
@@ -155,13 +155,11 @@ static int __init oprofile_init(void)
 {
 	int err = 0;
 
-	/* this is our fallback case */
-	oprofile_timer_init(&oprofile_ops);
+	oprofile_arch_init(&oprofile_ops);
 
 	if (timer) {
 		printk(KERN_INFO "oprofile: using timer interrupt.\n");
-	} else {
-		oprofile_arch_init(&oprofile_ops);
+		oprofile_timer_init(&oprofile_ops);
 	}
 
 	err = oprofilefs_register();
Index: linux/drivers/oprofile/timer_int.c
===================================================================
--- linux.orig/drivers/oprofile/timer_int.c	2004-12-04 19:43:37.%N +1100
+++ linux/drivers/oprofile/timer_int.c	2004-12-09 12:48:52.%N +1100
@@ -37,6 +37,9 @@ static void timer_stop(void)
 
 void __init oprofile_timer_init(struct oprofile_operations * ops)
 {
+	ops->create_files = NULL;
+	ops->setup = NULL;
+	ops->shutdown = NULL;
 	ops->start = timer_start;
 	ops->stop = timer_stop;
 	ops->cpu_type = "timer";

--ZfOjI3PrQbgiZnxM--
