Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751114AbWCIRhd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751114AbWCIRhd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 12:37:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751116AbWCIRhd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 12:37:33 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:32732 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751114AbWCIRhc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 12:37:32 -0500
Subject: Re: Oops on ibmasm
From: Max Asbock <masbock@us.ibm.com>
To: Dave Jones <davej@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>,
       Srihari Vijayaraghavan <sriharivijayaraghavan@yahoo.com.au>,
       linux-kernel@vger.kernel.org, Vernon Mauery <vernux@us.ibm.com>
In-Reply-To: <20060309132655.GA26354@redhat.com>
References: <20060308224145.47332.qmail@web52607.mail.yahoo.com>
	 <20060309014023.2caa42d2.akpm@osdl.org> <20060309132655.GA26354@redhat.com>
Content-Type: text/plain
Message-Id: <1141925840.6240.18.camel@w-amax>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Thu, 09 Mar 2006 09:37:20 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-03-09 at 05:26, Dave Jones wrote:
> On Thu, Mar 09, 2006 at 01:40:23AM -0800, Andrew Morton wrote:
> 
>  > I assume this'll fix it?
>  > 
>  > I suspect there's no point in the locking around that kobject_put() anyway.
>  > Or if there is, it wasn't the right way to fix the race.
>  > 
>  > diff -puN drivers/misc/ibmasm/ibmasm.h~ibmasm-use-after-free-fix drivers/misc/ibmasm/ibmasm.h
>  > --- devel/drivers/misc/ibmasm/ibmasm.h~ibmasm-use-after-free-fix	2006-03-09 01:35:05.000000000 -0800
>  > +++ devel-akpm/drivers/misc/ibmasm/ibmasm.h	2006-03-09 01:35:16.000000000 -0800
>  > @@ -100,11 +100,7 @@ struct command {
>  >  
>  >  static inline void command_put(struct command *cmd)
>  >  {
>  > -	unsigned long flags;
>  > -
>  > -	spin_lock_irqsave(cmd->lock, flags);
>  >          kobject_put(&cmd->kobj);
>  > -	spin_unlock_irqrestore(cmd->lock, flags);
>  >  }
> 
> I don't think this is right.  This is just a kobject-convoluted
> use-after-free afaics.
> 
I put the locks around the kobject_put after reading
Documentation/kref.txt and after realizing that there was a race. In the
kref.txt example there is a lock around kref_put (only a mutex instead
of a spinlock). 
I still think there is a point in putting locks around kobject_put(). Or
is there a better way?
And btw, I am using kobject because this code predates kref. So maybe
one day I should just convert it to kref.
Anyway, I think the locks are necessary, the way they are implemented is
probably ugly and caused me to make the mistake in the first place. But
a while I ago posted the following patch that fixes the situation.
cmd->lock points to a persistent lock that is not freed with cmd. 

max

Original patch:

ibmasm driver:
Fix the command_put() function which uses a pointer for a spinlock that
can be freed before dereferencing it.

Signed-off-by: Max Asbock masbock@us.ibm.com

---

diff -burpN linux-2.6.16-rc1/drivers/misc/ibmasm/ibmasm.h linux-2.6.16-rc1.ibmasm/drivers/misc/ibmasm/ibmasm.h
--- linux-2.6.16-rc1/drivers/misc/ibmasm/ibmasm.h	2006-02-01 11:50:01.000000000 -0800
+++ linux-2.6.16-rc1.ibmasm/drivers/misc/ibmasm/ibmasm.h	2006-02-03 13:57:42.000000000 -0800
@@ -101,10 +101,11 @@ struct command {
 static inline void command_put(struct command *cmd)
 {
 	unsigned long flags;
+	spinlock_t *lock = cmd->lock;
 
-	spin_lock_irqsave(cmd->lock, flags);
+	spin_lock_irqsave(lock, flags);
         kobject_put(&cmd->kobj);
-	spin_unlock_irqrestore(cmd->lock, flags);
+	spin_unlock_irqrestore(lock, flags);
 }
 
 static inline void command_get(struct command *cmd)

