Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264104AbTICBz4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 21:55:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264115AbTICBz4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 21:55:56 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:61899 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S264104AbTICBzx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 21:55:53 -0400
Subject: Re: [PATCH 2/2] Futex non-page-pinning fix
From: Dave Hansen <haveblue@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Rusty Russell <rusty@rustcorp.com.au>, jamie@shareable.org,
       hugh@veritas.com, mingo@redhat.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030902181653.721a41ea.akpm@osdl.org>
References: <20030902065144.GC7619@mail.jlokier.co.uk>
	 <20030903010318.0A46B2C0FC@lists.samba.org>
	 <20030902181653.721a41ea.akpm@osdl.org>
Content-Type: multipart/mixed; boundary="=-0ozQw07S3WX9sJu1rp2b"
Organization: 
Message-Id: <1062554090.28952.41.camel@nighthawk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 02 Sep 2003 18:54:51 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-0ozQw07S3WX9sJu1rp2b
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, 2003-09-02 at 18:16, Andrew Morton wrote:
> Rusty Russell <rusty@rustcorp.com.au> wrote:
> >
> >  I don't know of a rule which says "thou shalt not wake a random thread
> >  in the kernel": for all I know wierd things like CPU hotplug or
> >  software suspend may do this in the future.
> 
> pdflush is sensitive to that.  It emits angry squeaks if unexpectedly woken.
> 
> And up until a couple of months ago there were sporadic squeaking reports,
> but they seem to have gone away.

I still run into the pdflush problem once a month or so, but only with
boxes that are up for a week or more.  It usually takes the box down if
for no other reason than it's too busy prink()ing to do anything else. 
I haven't been able to sysrq it and the particular box that it happens
on doesn't like NMIs so kgdb and the NMI oopser are out.

Are there any good reasons not to do something like the attached patch? 
It would at least keep pdflush from evicting everthing interesting that
may have preceded it in dmesg.  
-- 
Dave Hansen
haveblue@us.ibm.com

--=-0ozQw07S3WX9sJu1rp2b
Content-Disposition: attachment; filename=shut-up-pdflush-2.6.0-test3.patch
Content-Type: text/plain; name=shut-up-pdflush-2.6.0-test3.patch; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 7bit

--- mm/pdflush.c.orig	Tue Sep  2 18:50:39 2003
+++ mm/pdflush.c	Tue Sep  2 18:52:11 2003
@@ -112,7 +112,11 @@
 
 		spin_lock_irq(&pdflush_lock);
 		if (!list_empty(&my_work->list)) {
-			printk("pdflush: bogus wakeup!\n");
+			static int wakeup_count = 100;
+			if (wakeup_count > 0) {
+				wakeup_count--;
+				printk("pdflush: bogus wakeup!\n");
+			}
 			my_work->fn = NULL;
 			continue;
 		}

--=-0ozQw07S3WX9sJu1rp2b--

