Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261464AbUATDiX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 22:38:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261889AbUATDiX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 22:38:23 -0500
Received: from fw.osdl.org ([65.172.181.6]:58089 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261464AbUATDiV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 22:38:21 -0500
Date: Mon, 19 Jan 2004 19:38:37 -0800
From: Andrew Morton <akpm@osdl.org>
To: Oliver Kiddle <okiddle@yahoo.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: page allocation failure
Message-Id: <20040119193837.6369d498.akpm@osdl.org>
In-Reply-To: <7641.1074512162@gmcs3.local>
References: <7641.1074512162@gmcs3.local>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oliver Kiddle <okiddle@yahoo.co.uk> wrote:
>
> There seems to be a problem with 2.6.1 on my machine. It will be fine
>  for a matter of a few days and then this error will appear on the
>  console. The message then appears repeatedly and continuously. The
>  first I know is that my remote login shell ceases to respond. About the
>  only thing I can do is switch between virtual consoles (until I hit the
>  reset button).
> 
>  /var/log/messages shows:
>  kernel: cat: page allocation failure. order:0, mode:0x20
> 
>  Then the same for lots of other processes (pdflush, syslogd, klogd,
>  kswapd0, nfsd to name a few). I expect that after a point it is unable
>  to even log stuff so syslog is quiet after a while.
> 
>  It has happened three times now and on all occasions, I was untarring a
>  huge file on an XFS partition. I assume the problem is something to do
>  with VM. The machine has 1GB of RAM which should be plenty. For the
>  most part it is just serving NFS and NIS (to no more than about 10
>  clients).

Does the machine actually recover, or does it grind to a halt and need
resetting?

Is there much network receive happening at the time?

Are you using gig-E with large MTU's?

> If anyone can suggest any /proc variables I might change to reduce the
> risk of it doing this again, I would appreciate it. I tried increasing
> /proc/sys/vm/min_free_kbytes after the first time this happened. Not
> that I understand what that does: I searched the archives and it was
> mentioned in a vaguely relevant looking post.

Yup, min_free_kbytes is the right thing to increase.  Try it again, perhaps
increasing it by more - to 10000 or something like that.

min_free_kbytes will increase the amount of memory which the VM keeps in
reserve to satisfy interrupt-time memory allocation attempts - most
especially network receive.


You probably should apply this patch to tell us where the allocation
failures are coming from.  Make sure that CONFIG_KALLSYMS is enabled in
kernel config.


diff -puN mm/page_alloc.c~a mm/page_alloc.c
--- 25/mm/page_alloc.c~a	Mon Jan 19 19:34:09 2004
+++ 25-akpm/mm/page_alloc.c	Mon Jan 19 19:34:21 2004
@@ -674,6 +674,7 @@ nopage:
 		printk("%s: page allocation failure."
 			" order:%d, mode:0x%x\n",
 			p->comm, order, gfp_mask);
+		dump_stack();
 	}
 	return NULL;
 got_pg:

_

