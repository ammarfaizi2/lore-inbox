Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261530AbTCOUck>; Sat, 15 Mar 2003 15:32:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261539AbTCOUck>; Sat, 15 Mar 2003 15:32:40 -0500
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:15075 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S261530AbTCOUci>; Sat, 15 Mar 2003 15:32:38 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Andrew Morton <akpm@digeo.com>
Date: Sun, 16 Mar 2003 07:42:34 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15987.36922.848433.245061@notabene.cse.unsw.edu.au>
Cc: Helge Hafting <helgehaf@aitel.hist.no>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: 2.5.64-mm7 - dies on smp with raid
In-Reply-To: message from Andrew Morton on Saturday March 15
References: <20030315011758.7098b006.akpm@digeo.com>
	<3E736505.2000106@aitel.hist.no>
	<20030315120343.71faf732.akpm@digeo.com>
X-Mailer: VM 7.08 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday March 15, akpm@digeo.com wrote:
> 
> A lot of md updates went into Linus's tree overnight.  Can you get some more
> details for Neil?
> 
> Here is a wild guess:
> 
> diff -puN drivers/md/md.c~a drivers/md/md.c
> --- 25/drivers/md/md.c~a	2003-03-15 12:02:04.000000000 -0800
> +++ 25-akpm/drivers/md/md.c	2003-03-15 12:02:14.000000000 -0800
> @@ -2818,6 +2818,8 @@ int md_thread(void * arg)
>  
>  void md_wakeup_thread(mdk_thread_t *thread)
>  {
> +	if (!thread)
> +		return;
>  	dprintk("md: waking up MD thread %p.\n", thread);
>  	set_bit(THREAD_WAKEUP, &thread->flags);
>  	wake_up(&thread->wqueue);
> 

Looks like a good guess to me.

I hadn't considered raid0/linear properly in that last change suite.
They don't have a thread so there is nothing to wake up.

There are two places where the wrong thing will happen:
  do_md_run where it also calls md_update_sb which doesn't
    hurt but isn't really needed (there is never any point
    updating the superblock metadata for raid0/linear).
  restart_array where we switch back to read/write and wakeup
    the thread to see if there is anything to do.

We either need this "if(!thread)" test inside md_wakeup_thread
or at those two call sites, in which case we can avoid md_update_sb
as well.

I send one to Linus later...

Thanks,
NeilBrown
