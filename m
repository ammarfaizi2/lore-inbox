Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261528AbTIYSgY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 14:36:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261586AbTIYSgY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 14:36:24 -0400
Received: from smtp.bitmover.com ([192.132.92.12]:54415 "EHLO
	smtp.bitmover.com") by vger.kernel.org with ESMTP id S261528AbTIYSgT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 14:36:19 -0400
Date: Thu, 25 Sep 2003 11:34:15 -0700
From: Larry McVoy <lm@bitmover.com>
To: Dave Jones <davej@redhat.com>, "Eric W. Biederman" <ebiederm@xmission.com>,
       Linus Torvalds <torvalds@osdl.org>, andrea@kernel.org,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Matthew Wilcox <willy@debian.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>,
       Larry McVoy <lm@bitmover.com>
Subject: Re: log-buf-len dynamic
Message-ID: <20030925183415.GB18749@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Dave Jones <davej@redhat.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Linus Torvalds <torvalds@osdl.org>, andrea@kernel.org,
	Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Matthew Wilcox <willy@debian.org>,
	Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>,
	Larry McVoy <lm@bitmover.com>
References: <Pine.LNX.4.44.0309231924540.27467-100000@home.osdl.org> <m1n0csiybu.fsf@ebiederm.dsl.xmission.com> <20030925173648.GA19626@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030925173648.GA19626@redhat.com>
User-Agent: Mutt/1.4i
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam (whitelisted), SpamAssassin (score=0.3,
	required 7, AWL)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 25, 2003 at 06:36:48PM +0100, Dave Jones wrote:
> On Thu, Sep 25, 2003 at 11:15:33AM -0600, Eric W. Biederman wrote:
> 
>  > And for the core kernel development this is true.  There are subprojects
>  > that are currently using BK that you can't even get the code without
>  > BK.  And the only reason they are using BK is they are attempting to
>  > following how Linux is managed.  So having the Linux kernel
>  > development use BK does have some down sides.
> 
> I was expecting this to come up when Linus first made sparse publically
> available only by bitkeeper, so I started the nightly snapshots.

Qwest is taking forever with our T1 lines but once that problem is solved
we'll put up a version of the BK server on bkbits that will give you
either GNU style patches or tarballs of an exported tree.  Then *all*
projects mirrored on bkbits are automagically exported to good old plain 
text format.

And, because people might want to build their own gateways (we can only
hope) the diffs can be extracted with checkin comments as shown below.
That ought to be sufficient so that you can do whatever you want.  I'm
pretty sure that patch(1) will just ignore all the leading comments.

How's that?

===== panic.c 1.12 vs + =====
2003/08/07 10:29:13 akpm@osdl.org 1.13 +6 -1
   Don't trigger NMI watchdog for panic delay

--- 1.12/kernel/panic.c Mon May 12 11:11:38 2003
+++ +/kernel/panic.c    Thu Aug  7 10:29:13 2003
@@ -16,6 +16,7 @@
 #include <linux/init.h>
 #include <linux/sysrq.h>
 #include <linux/interrupt.h>
+#include <linux/nmi.h>
 
 asmlinkage void sys_sync(void);        /* it's really int */
 
@@ -71,12 +72,16 @@ NORET_TYPE void panic(const char * fmt, 
 
        if (panic_timeout > 0)
        {
+               int i;
                /*
                 * Delay timeout seconds before rebooting the machine. 
                 * We can't use the "normal" timers since we just panicked..
                 */
                printk(KERN_EMERG "Rebooting in %d seconds..",panic_timeout);
-               mdelay(panic_timeout*1000);
+               for (i = 0; i < panic_timeout; i++) {
+                       touch_nmi_watchdog();
+                       mdelay(1000);
+               }
                /*
                 *      Should we run the reboot notifier. For the moment Im
                 *      choosing not too. It might crash, be corrupt or do


