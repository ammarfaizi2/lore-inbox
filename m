Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263645AbUCUNZl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Mar 2004 08:25:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263646AbUCUNZl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Mar 2004 08:25:41 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:54756
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S263645AbUCUNZj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Mar 2004 08:25:39 -0500
Date: Sun, 21 Mar 2004 14:26:30 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: linux-kernel@vger.kernel.org, Jens Axboe <axboe@suse.de>
Subject: Re: 2.6.5-rc1-aa3
Message-ID: <20040321132630.GO10787@dualathlon.random>
References: <20040320210306.GA11680@dualathlon.random> <2910700000.1079849836@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2910700000.1079849836@[10.10.2.4]>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 20, 2004 at 10:17:16PM -0800, Martin J. Bligh wrote:
> > Fixed the sigbus in nopage and improved the page_t layout per Hugh's
> > suggestion. BUG() with discontigmem disabled if somebody returns non-ram
> > via do_no_page, that cannot work right on numa anyways.
> 
> OK, well it doesn't oops any more. But sshd still dies as soon as it starts,
> so accessing the box is tricky ;-) And now I have no obvious diagnostics
> either ...

Jens sent me the perfect strace log, after his help it has not been
difficult to spot the bug. this incremental should fix it
MAP_SHARED|MAP_ANONYMOUS isn't very common and my userspace never
triggered it. I placed the pgoff anon setting in the path of the shared
memory too, that generated the sigbus. Leaving the setting only in the
MAP_PRIVATE should fix it, the anonymous memory is only MAP_PRIVATE.

patch is untested at the moment, as soon as I get confirmation I'll
upload an update.

thanks!

--- x/mm/mmap.c.~1~	2004-03-20 22:12:43.000000000 +0100
+++ x/mm/mmap.c	2004-03-21 14:15:17.269882800 +0100
@@ -622,11 +622,11 @@ unsigned long do_mmap_pgoff(struct file 
 			return -EINVAL;
 		case MAP_PRIVATE:
 			vm_flags &= ~(VM_SHARED | VM_MAYSHARE);
-			/* fall through */
+			pgoff = addr >> PAGE_SHIFT;
+			break;
 		case MAP_SHARED:
 			break;
 		}
-		pgoff = addr >> PAGE_SHIFT;
 	}
 
 	error = security_file_mmap(file, prot, flags);
