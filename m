Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932338AbWJBNsD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932338AbWJBNsD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 09:48:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932337AbWJBNsB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 09:48:01 -0400
Received: from amsfep19-int.chello.nl ([213.46.243.16]:28797 "EHLO
	amsfep17-int.chello.nl") by vger.kernel.org with ESMTP
	id S932334AbWJBNsA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 09:48:00 -0400
Subject: Re: md deadlock (was Re: 2.6.18-mm2)
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Neil Brown <neilb@suse.de>
Cc: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <1159538597.28131.97.camel@taijtu>
References: <20060928014623.ccc9b885.akpm@osdl.org>
	 <6bffcb0e0609280454n34d40c0la8786e1eba6dcdf3@mail.gmail.com>
	 <1159531923.28131.80.camel@taijtu>
	 <17693.5913.393686.223172@cse.unsw.edu.au>
	 <1159538597.28131.97.camel@taijtu>
Content-Type: text/plain
Date: Mon, 02 Oct 2006 15:47:38 +0200
Message-Id: <1159796858.28131.149.camel@taijtu>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-09-29 at 16:03 +0200, Peter Zijlstra wrote:
> On Fri, 2006-09-29 at 22:52 +1000, Neil Brown wrote:
> > On Friday September 29, a.p.zijlstra@chello.nl wrote:
> > > On Thu, 2006-09-28 at 13:54 +0200, Michal Piotrowski wrote:
> > > 
> > > Looks like a real deadlock here. It seems to me #2 is the easiest to
> > > break.
> > 
> > I guess it could deadlock if you tried to add /dev/md0 as a component
> > of /dev/md0.  I should probably check for that somewhere.
> > In other cases the array->member ordering ensures there is no
> > deadlock.
> > 
> 
> 
> 	1					2
> 
>  open(/dev/md0)
> 
> 					open(/dev/md0)
> 					- do_open() -> bdev->bd_mutex
>  ioctl(/dev/md0, hotadd) 
>  - md_ioctl() -> mddev->reconfig_mutex
>  -- hot_add_disk()
>  --- bind_rdev_to_array()
>  ---- bd_claim_by_disk()
>  ----- bd_claim_by_kobject()
> 					-- md_open()
> 					--- mddev_lock()
> 					---- mutex_lock(mddev->reconfig_mutex)
>  ------ mutex_lock(bdev->bd_mutex)
> 

D'0h, 1:bdev->bd_mutex is ofcourse rdev->bd_mutex; the slave device's
mutex.

So mddev->bd_mutex wants to be another class all-together. 

