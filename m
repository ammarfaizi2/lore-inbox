Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268665AbUIGVYz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268665AbUIGVYz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 17:24:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268675AbUIGVWn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 17:22:43 -0400
Received: from cantor.suse.de ([195.135.220.2]:32210 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S268680AbUIGVUZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 17:20:25 -0400
Date: Tue, 7 Sep 2004 23:16:26 +0200
From: Andi Kleen <ak@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andi Kleen <ak@suse.de>, akpm@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       bastian@suse.de
Subject: Re: [PATCH] Add prctl to modify current->comm
Message-ID: <20040907211626.GB15043@wotan.suse.de>
References: <20040907142753.GA20981@wotan.suse.de> <1094577168.9599.13.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1094577168.9599.13.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 07, 2004 at 06:12:48PM +0100, Alan Cox wrote:
> > +		case PR_SET_NAME: {
> > +			struct task_struct *me = current;
> > +			me->comm[sizeof(me->comm)-1] = 0;
> > +			if (strncpy_from_user(me->comm, (char *)arg2, sizeof(me->comm)-1) < 0)
> > +				return -EFAULT;
> > +			return 0;
> > +		}
> 
> If the strncpy_from_user faults the state of current->comm is undefined.

I didn't see it as a big issue because the result will be 0 terminated
anyways. 

> This strikes me as bad design.

Here's is a new patch with this fixed. 

-Andi

--------------------------------------------------------------------

Allow a program to change its current->comm

Useful for KDE & kdeinit. 


diff -u linux-2.6.8-5/kernel/sys.c-o linux-2.6.8-5/kernel/sys.c
--- linux-2.6.8-5/kernel/sys.c-o	2004-08-14 07:36:16.000000000 +0200
+++ linux-2.6.8-5/kernel/sys.c	2004-09-07 23:09:56.000000000 +0200
@@ -1660,6 +1660,15 @@
 			}
 			current->keep_capabilities = arg2;
 			break;
+		case PR_SET_NAME: {
+			struct task_struct *me = current;
+			unsigned char ncomm[sizeof(me->comm)];
+			ncomm[sizeof(me->comm)-1] = 0;
+			if (strncpy_from_user(ncomm, (char *)arg2, sizeof(me->comm)-1) < 0)
+				return -EFAULT;
+			memcpy(me->comm, ncomm, sizeof(me->comm));
+			return 0;
+		}
 		default:
 			error = -EINVAL;
 			break;
diff -u linux-2.6.8-5/include/linux/prctl.h-o linux-2.6.8-5/include/linux/prctl.h
--- linux-2.6.8-5/include/linux/prctl.h-o	2004-08-14 07:37:14.000000000 +0200
+++ linux-2.6.8-5/include/linux/prctl.h	2004-09-07 23:09:44.000000000 +0200
@@ -49,5 +49,6 @@
 # define PR_TIMING_TIMESTAMP    1       /* Accurate timestamp based
                                                    process timing */
 
+#define PR_SET_NAME    15		/* Set process name. */
 
 #endif /* _LINUX_PRCTL_H */

