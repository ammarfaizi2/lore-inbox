Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263991AbSLSR3W>; Thu, 19 Dec 2002 12:29:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264940AbSLSR3W>; Thu, 19 Dec 2002 12:29:22 -0500
Received: from air-2.osdl.org ([65.172.181.6]:22717 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S263991AbSLSR3V>;
	Thu, 19 Dec 2002 12:29:21 -0500
Subject: Re: [PATCH] (4/5) improved notifier callback mechanism - read copy
	update
From: Stephen Hemminger <shemminger@osdl.org>
To: vamsi@in.ibm.com, John Levon <levon@movementarian.org>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021219181929.A5265@in.ibm.com>
References: <1040249652.14364.192.camel@dell_ss3.pdx.osdl.net>
	 <20021219181929.A5265@in.ibm.com>
Content-Type: text/plain
Organization: Open Source Devlopment Lab
Message-Id: <1040319430.23567.15.camel@dell_ss3.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 19 Dec 2002 09:37:10 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks, will look into it in more detail. Perhaps figuring out how to do
oprofile without sleeping would be best.

On Thu, 2002-12-19 at 04:49, Vamsi Krishna S . wrote:
> Hi Stephen,
> 
> On Wed, Dec 18, 2002 at 11:06:08PM +0000, Stephen Hemminger wrote:
> > The notifier interface was only partially locked. The
> > notifier_call_chain needs to be called in places where it is impossible
> > to safely without having deadlocks; for example, NMI watchdog timeout.
> > 
> > This patch uses read-copy-update to manage the list.  One extra bit of
> > safety is using a reference count on the notifier_blocks to allow for
> > cases like oprofile which need to sleep in a callback.
> > 
> <snip>
> >   
> >  int notifier_call_chain(struct list_head *list, unsigned long val, void
> > *v)
> >  {
> > -	struct list_head *p;
> > +	struct list_head *p, *nxtp;
> >  	int ret = NOTIFY_DONE;
> >  
> > -	list_for_each(p, list) {
> > +	rcu_read_lock();
> > +	list_for_each_safe_rcu(p, nxtp, list) {
> >  		struct notifier_block *nb =
> >  			list_entry(p, struct notifier_block, link);
> >  
> > +		atomic_inc(&nb->inuse);
> >  		ret = nb->notifier_call(nb,val,v);
> > +		atomic_dec(&nb->inuse);
> > +
> 
> There could be a small problem here. When rcu_read_lock() is called,
> it bumps the preempt_count, so when the called handler attempts
> to sleep, it will oops with "Bad: scheduling in atomic region".
-- 
Stephen Hemminger <shemminger@osdl.org>
Open Source Devlopment Lab

