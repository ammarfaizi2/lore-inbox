Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261217AbVEZFhN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261217AbVEZFhN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 01:37:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261218AbVEZFhN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 01:37:13 -0400
Received: from fmr18.intel.com ([134.134.136.17]:45228 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S261217AbVEZFhC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 01:37:02 -0400
Subject: Re: Hotplug CPU printk issue
From: Shaohua Li <shaohua.li@intel.com>
To: akpm <akpm@osdl.org>
Cc: Pavel Machek <pavel@ucw.cz>, lkml <linux-kernel@vger.kernel.org>,
       David Mosberger <davidm@napali.hpl.hp.com>
In-Reply-To: <20050525204828.70acc1b5.akpm@osdl.org>
References: <1113467253.2568.10.camel@sli10-desk.sh.intel.com>
	 <1117076334.4086.11.camel@linux-hp.sh.intel.com>
	 <20050525204828.70acc1b5.akpm@osdl.org>
Content-Type: text/plain
Date: Thu, 26 May 2005 13:43:31 +0800
Message-Id: <1117086211.7657.10.camel@linux-hp.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-05-25 at 20:48 -0700, Andrew Morton wrote:
> >  > --- a/kernel/printk.c   2005-04-12 10:12:19.000000000 +0800 
> >  > +++ b/kernel/printk.c   2005-04-13 17:22:40.912897328 +0800 
> >  > @@ -624,8 +624,7 @@ asmlinkage int vprintk(const char *fmt,  
> >  >                         log_level_unknown = 1; 
> >  >         } 
> >  >   
> >  > -       if (!cpu_online(smp_processor_id()) && 
> >  > -           system_state != SYSTEM_RUNNING) { 
> >  > +       if (!cpu_online(smp_processor_id())) { 
> >  >                 /* 
> >  >                  * Some console drivers may assume that per-cpu resources have 
> >  >                  * been allocated.  So don't allow them to be called by this
> >  Andrew,
> >  Could above patch be put into mm tree?
> 
> Well not in that form.  I'd appreciate being sent patches which are
> applyable rather than mangled messes, please.
> 
> > It fixes the oops of CPU hotplug
> >  with radeon fb enabled.
> >  The reason is the per-cpu data (radeon fb calls kmalloc) isn't
> >  initialized when CPU hotplug is processing. system_state is
> >  SYSTEM_RUNNING for cpu hotplug.
> 
> That system_state test was explicitly added by davidm a year ago:
> 
> "- Allow printk on down cpus once system is running."
> 
> Please confirm that we in fact do not want to allow downed CPUs to
> print things, then send a patch.
Yep. In the cpu hotplug case, per-cpu data possibly isn't initialized
even the system state is 'running'. As the comments say in the original
code, some console drivers assume per-cpu resources have been allocated.
radeon fb is one such driver, which uses kmalloc. After a CPU is down,
the per-cpu data of slab is freed, so the system crashed when printing
some info.

Thanks,
Shaohua

---

 linux-2.6.11-rc5-mm1-root/kernel/printk.c |    3 +--
 1 files changed, 1 insertion(+), 2 deletions(-)

diff -puN kernel/printk.c~printk kernel/printk.c
--- linux-2.6.11-rc5-mm1/kernel/printk.c~printk	2005-05-26 13:11:47.333540352 +0800
+++ linux-2.6.11-rc5-mm1-root/kernel/printk.c	2005-05-26 13:11:47.336539896 +0800
@@ -588,8 +588,7 @@ asmlinkage int vprintk(const char *fmt, 
 			log_level_unknown = 1;
 	}
 
-	if (!cpu_online(smp_processor_id()) &&
-	    system_state != SYSTEM_RUNNING) {
+	if (!cpu_online(smp_processor_id())) {
 		/*
 		 * Some console drivers may assume that per-cpu resources have
 		 * been allocated.  So don't allow them to be called by this
_


