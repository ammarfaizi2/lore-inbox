Return-Path: <linux-kernel-owner+w=401wt.eu-S965144AbWLVJhh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965144AbWLVJhh (ORCPT <rfc822;w@1wt.eu>);
	Fri, 22 Dec 2006 04:37:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946011AbWLVJhh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Dec 2006 04:37:37 -0500
Received: from smtpa2.aruba.it ([62.149.128.211]:39291 "HELO smtpa2.aruba.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965144AbWLVJhg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Dec 2006 04:37:36 -0500
X-Greylist: delayed 396 seconds by postgrey-1.27 at vger.kernel.org; Fri, 22 Dec 2006 04:37:35 EST
Subject: Re: [Bug 7505] Linux-2.6.18 fails to boot on AMD64 machine
From: Stefano Takekawa <take@libero.it>
To: Andrew Morton <akpm@osdl.org>
Cc: Ard -kwaak- van Breemen <ard@telegraafnet.nl>,
       "Zhang, Yanmin" <yanmin.zhang@intel.com>,
       Chuck Ebbert <76306.1226@compuserve.com>,
       Yinghai Lu <yinghai.lu@amd.com>, agalanin@mera.ru,
       linux-kernel@vger.kernel.org, bugme-daemon@bugzilla.kernel.org,
       "Eric W. Biederman" <ebiederm@xmission.com>
In-Reply-To: <20061222003029.4394bd9a.akpm@osdl.org>
References: <117E3EB5059E4E48ADFF2822933287A401F2EB70@pdsmsx404.ccr.corp.intel.com>
	 <20061222082248.GY31882@telegraafnet.nl>
	 <20061222003029.4394bd9a.akpm@osdl.org>
Content-Type: text/plain
Date: Fri, 22 Dec 2006 10:32:51 +0100
Message-Id: <1166779971.16097.8.camel@proton.twominds.it>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 
Content-Transfer-Encoding: 7bit
X-Spam-Rating: smtpa2.aruba.it 1.6.2 0/1000/N
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Il giorno ven, 22/12/2006 alle 00.30 -0800, Andrew Morton ha scritto:
> On Fri, 22 Dec 2006 09:22:48 +0100
> Ard -kwaak- van Breemen <ard@telegraafnet.nl> wrote:
> 
> > Hello,
> > On Fri, Dec 22, 2006 at 12:41:46PM +0800, Zhang, Yanmin wrote:
> > > I think parse_args enables irq when it calls callbacks.
> > > Could you try below?
> > > 1) Test Andrew's patch of sema down_write;
> > > 2) Apply below patch and see what the output is when booting. If the output has
> > > "[BUG]..address.", Pls. map the address to function name by System.map.
> > Without proof^H^H^H^H^Hpasting my dmesg and the "diff", I already
> > concluded that ide_setup was the culprit. (I've debuged
> > parse_one, and it barfed around the 3rd parameter which is
> > hdb=noprobe).
> > Anyway, a bad night of sleep reminds me that our EM64T boxes also
> > have this line (which actually is a remainder of our VA1220 boxes
> > ;-) ), and they don't barf, so it must be either the combination
> > of the sata_nv together with the pata driver part, *or* just the
> > pata driver part. (Our opteron != nforce chipsets also works).
> > 
> 
> I expect that you'll find that the ide code ends up doing
> down_write(pci_bus_sem), which will enable interrupts.
> 
> (We don't know which interrupt is pending this early - that'd be
> interesting to find out, but we shouldn't be enabling interrupts in there).
> 
> To whom do I have to pay how much to get this darn patch tested?
> 
> 
> 
> --- a/lib/rwsem-spinlock.c~down_write-preserve-local-irqs
> +++ a/lib/rwsem-spinlock.c
> @@ -195,13 +195,14 @@ void fastcall __sched __down_write_neste
>  {
>  	struct rwsem_waiter waiter;
>  	struct task_struct *tsk;
> +	unsigned long flags;
>  
> -	spin_lock_irq(&sem->wait_lock);
> +	spin_lock_irqsave(&sem->wait_lock, flags);
>  
>  	if (sem->activity == 0 && list_empty(&sem->wait_list)) {
>  		/* granted */
>  		sem->activity = -1;
> -		spin_unlock_irq(&sem->wait_lock);
> +		spin_unlock_irqrestore(&sem->wait_lock, flags);
>  		goto out;
>  	}
>  
> @@ -216,7 +217,7 @@ void fastcall __sched __down_write_neste
>  	list_add_tail(&waiter.list, &sem->wait_list);
>  
>  	/* we don't need to touch the semaphore struct anymore */
> -	spin_unlock_irq(&sem->wait_lock);
> +	spin_unlock_irqrestore(&sem->wait_lock, flags);
>  
>  	/* wait to be given the lock */
>  	for (;;) {
> _
> 
Applied to 2.6.19 it doesn't change anything. It still panics.

How can I have something similar to a serial console on a laptop without
serial port but with a parallel one? Will netconsole work?



-- 
Stefano Takekawa
take@libero.it

Frank:  And why do days get longer in the summer?
Ernest: Because heat makes things expand!


