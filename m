Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261383AbULHWcZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261383AbULHWcZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 17:32:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261390AbULHWcY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 17:32:24 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:34230 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261383AbULHWcS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 17:32:18 -0500
Date: Thu, 9 Dec 2004 09:31:56 +1100
From: Greg Banks <gnb@sgi.com>
To: John Levon <levon@movementarian.org>
Cc: Akinobu Mita <amgta@yacht.ocn.ne.jp>, phil.el@wanadoo.fr,
       linux-kernel@vger.kernel.org
Subject: Re: [mm patch] oprofile: backtrace operation does not initialized
Message-ID: <20041208223156.GB4239@sgi.com>
References: <200412081830.51607.amgta@yacht.ocn.ne.jp> <20041208160055.GA82465@compsoc.man.ac.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="EeQfGwPcQSOJBaQU"
Content-Disposition: inline
In-Reply-To: <20041208160055.GA82465@compsoc.man.ac.uk>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 08, 2004 at 04:00:55PM +0000, John Levon wrote:
> On Wed, Dec 08, 2004 at 06:30:51PM +0900, Akinobu Mita wrote:
> 
> > When I forced the oprofile to use timer interrupt with specifying
> > "timer=1" module parameter. "oprofile_operations->backtrace" did
> > not initialized on i386.
> > 
> > Please apply this patch, or make oprofile initialize the backtrace
> > operation in case of using timer interrupt in your preferable way.
> 
> I don't like this patch. The arches should just set the backtrace
> always, then try to init the hardware. oprofile_init() should then force
> the timer ops as needed.
> 
> Greg?

Agreed, that's a cleaner approach.  The attached patch (untested)
implements that.  Akinobu-san, can you please test the patch?

Greg.
-- 
Greg Banks, R&D Software Engineer, SGI Australian Software Group.
I don't speak for SGI.

--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=oprofile-timer-backtrace-fix

Allow stack tracing to work when sampling on timer is forced
using the timer=1 boot option.  Reported by Akinobu Mita.

Signed-off-by: Greg Banks <gnb@melbourne.sgi.com>
---
 oprof.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)


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

--EeQfGwPcQSOJBaQU--
