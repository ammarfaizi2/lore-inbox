Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261452AbTICCyO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 22:54:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261447AbTICCyO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 22:54:14 -0400
Received: from fw.osdl.org ([65.172.181.6]:30368 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261452AbTICCyH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 22:54:07 -0400
Date: Tue, 2 Sep 2003 19:54:17 -0700
From: Andrew Morton <akpm@osdl.org>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: rusty@rustcorp.com.au, jamie@shareable.org, hugh@veritas.com,
       mingo@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] Futex non-page-pinning fix
Message-Id: <20030902195417.7bee7569.akpm@osdl.org>
In-Reply-To: <1062554090.28952.41.camel@nighthawk>
References: <20030902065144.GC7619@mail.jlokier.co.uk>
	<20030903010318.0A46B2C0FC@lists.samba.org>
	<20030902181653.721a41ea.akpm@osdl.org>
	<1062554090.28952.41.camel@nighthawk>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen <haveblue@us.ibm.com> wrote:
>
> On Tue, 2003-09-02 at 18:16, Andrew Morton wrote:
> > Rusty Russell <rusty@rustcorp.com.au> wrote:
> > >
> > >  I don't know of a rule which says "thou shalt not wake a random thread
> > >  in the kernel": for all I know wierd things like CPU hotplug or
> > >  software suspend may do this in the future.
> > 
> > pdflush is sensitive to that.  It emits angry squeaks if unexpectedly woken.
> > 
> > And up until a couple of months ago there were sporadic squeaking reports,
> > but they seem to have gone away.
> 
> I still run into the pdflush problem once a month or so, but only with
> boxes that are up for a week or more.  It usually takes the box down if
> for no other reason than it's too busy prink()ing to do anything else. 

That serves you right for not telling me!

> I haven't been able to sysrq it and the particular box that it happens
> on doesn't like NMIs so kgdb and the NMI oopser are out.
> 
> Are there any good reasons not to do something like the attached patch? 
> It would at least keep pdflush from evicting everthing interesting that
> may have preceded it in dmesg.  

I'd prefer a more intricate patch which does something like the below.

Seriously, please: this shouldn't be happening.  We need to work out the
cause.



 mm/pdflush.c |   18 +++++++++++++++++-
 1 files changed, 17 insertions(+), 1 deletion(-)

diff -puN mm/pdflush.c~pdflush-diag mm/pdflush.c
--- 25/mm/pdflush.c~pdflush-diag	2003-09-02 19:50:13.000000000 -0700
+++ 25-akpm/mm/pdflush.c	2003-09-02 19:53:38.000000000 -0700
@@ -84,6 +84,8 @@ struct pdflush_work {
 	unsigned long when_i_went_to_sleep;
 };
 
+static int wakeup_count = 100;
+
 static int __pdflush(struct pdflush_work *my_work)
 {
 	daemonize("pdflush");
@@ -112,7 +114,10 @@ static int __pdflush(struct pdflush_work
 
 		spin_lock_irq(&pdflush_lock);
 		if (!list_empty(&my_work->list)) {
-			printk("pdflush: bogus wakeup!\n");
+			if (wakeup_count > 0) {
+				wakeup_count--;
+				printk("pdflush: bogus wakeup!\n");
+			}
 			my_work->fn = NULL;
 			continue;
 		}
@@ -182,6 +187,7 @@ int pdflush_operation(void (*fn)(unsigne
 {
 	unsigned long flags;
 	int ret = 0;
+	static int poke_count = 0;
 
 	if (fn == NULL)
 		BUG();		/* Hard to diagnose if it's deferred */
@@ -190,9 +196,19 @@ int pdflush_operation(void (*fn)(unsigne
 	if (list_empty(&pdflush_list)) {
 		spin_unlock_irqrestore(&pdflush_lock, flags);
 		ret = -1;
+		if (wakeup_count < 100 && poke_count < 10) {
+			printk("%s: no threads\n", __FUNCTION__);
+			dump_stack();
+			poke_count++;
+		}
 	} else {
 		struct pdflush_work *pdf;
 
+		if (wakeup_count < 100 && poke_count < 10) {
+			printk("%s: found a thread\n", __FUNCTION__);
+			dump_stack();
+			poke_count++;
+		}
 		pdf = list_entry(pdflush_list.next, struct pdflush_work, list);
 		list_del_init(&pdf->list);
 		if (list_empty(&pdflush_list))

_

