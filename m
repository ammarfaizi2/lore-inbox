Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264297AbUF1R1u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264297AbUF1R1u (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 13:27:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265095AbUF1R1u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 13:27:50 -0400
Received: from cfcafw.sgi.com ([198.149.23.1]:56382 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S264297AbUF1R1r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 13:27:47 -0400
Date: Mon, 28 Jun 2004 12:27:40 -0500
From: Dean Nelson <dcn@sgi.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] replace assorted ASSERT()s by something officially  sanctioned
Message-ID: <20040628172740.GA27441@sgi.com>
References: <40D9D09D.mailx49E1J10NF@aqua.americas.sgi.com> <40D9DE1C.8020005@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40D9DE1C.8020005@pobox.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 23, 2004 at 03:46:36PM -0400, Jeff Garzik wrote:
> Dean Nelson wrote:
> >--- linux.orig/include/asm-i386/bug.h
> >+++ linux/include/asm-i386/bug.h
> >@@ -21,6 +21,12 @@
> >
> > #define BUG_ON(condition) do { if (unlikely((condition)!=0)) BUG(); }
> > while(0)
> >
> >+#ifdef DEBUG
> >+#define DBUG_ON(condition)	BUG_ON(condition)
> >+#else
> >+#define DBUG_ON(condition)
> >+#endif
>
> This won't work as it often needs to be driver-granular.  Also,

I agree that most often the granularity of debugging needs to be at the driver
level. But I was just taking my lead from dev_dbg(), which uses '#ifdef DEBUG'
in the same way I've proposed. I would argue that the enabling/disabling of
dev_dbg() is also something one would want to control at the driver level. I'm
assuming people do this by adding a '#define DEBUG' prior to the driver's
#include of <linux/kernel.h> which has a #include of <asm/bug.h>.
 
The dev_printk() family of macros is a good example of what I'm interested in.
They have a set of macros (dev_err(), dev_warn(), dev_info()) that are always
enabled. Then there is dev_dbg() which is only enabled if DEBUG is defined.
(I'm not defending the choice of DEBUG as the enabling switch. I'm merely
interested in having the ability to enable/disable BUG_ON() when the driver
is built.)


> WARN_ON() is often the closer implementation of assert(), than BUG_ON()

I would agree that there are two basic flavors of ASSERT()-like macros; one
that printks some info and then Oops the system, and the other that simply
printks some info. So I would suggest providing both options, something like:
 
    #ifdef DEBUG
    #define DBUG_ON(condition)  BUG_ON(condition)
    #define DWARN_ON(condition) WARN_ON(condition)
    #else
    #define DBUG_ON(condition)  do { if (condition) { /* nothing */ } } while (0)
    #define DWARN_ON(condition) do { if (condition) { /* nothing */ } } while (0)
    #endif
 
(I really don't care what the names of these macros end up being. Again, I'm
just interested in a BUG_ON()/WARN_ON()-like mechanism that is conditionally
compiled in (enabled) by some type of #ifdef switch (like DEBUG) and is
'sanctioned' by the community for use by drivers.)
 
Thanks,
Dean
