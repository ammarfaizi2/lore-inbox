Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750803AbWCQQq1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750803AbWCQQq1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 11:46:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751188AbWCQQq1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 11:46:27 -0500
Received: from orfeus.profiwh.com ([82.100.20.117]:59400 "EHLO
	orfeus.profiwh.com") by vger.kernel.org with ESMTP id S1750803AbWCQQq0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 11:46:26 -0500
Message-ID: <441AE7EE.2050701@gmail.com>
Date: Fri, 17 Mar 2006 17:46:15 +0059
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 1.5 (X11/20060210)
MIME-Version: 1.0
To: Ian Kent <raven@themaw.net>
CC: Jiri Slaby <xslaby@fi.muni.cz>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: BUG: atomic counter underflow [Was: 2.6.16-rc6-mm1]
References: <E1FIYLc-00080b-00@decibel.fi.muni.cz> <Pine.LNX.4.64.0603131330210.21830@eagle.themaw.net>
In-Reply-To: <Pine.LNX.4.64.0603131330210.21830@eagle.themaw.net>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-SpamReason: {}-{0,00}-{0,00}-{0,00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Ian Kent napsal(a):
> On Sun, 12 Mar 2006, Jiri Slaby wrote:
> 
>> Andrew Morton wrote:
>>> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc6/2.6.16-rc6-mm1/
>> [snip]
>>> +remove-redundant-check-from-autofs4_put_super.patch
>>> +autofs4-follow_link-missing-funtionality.patch
>>>
>>> Update autofs4 patches in -mm.
>> Hello, 
>>
>> I caught this during ftp browsing autofs-bind-mounted directories. I don't know
>> circumstancies and if the patches above are source of problem. I also don't know
>> if -rc6-mm1 is the first one.
> 
> btw what do you mean autofs-bind-mounted ?
For the first, sorry for the delay, I am going now to test it and gain more info
how to reproduce it. Come back soon.
> 
>> BUG: atomic counter underflow at:
>>  [<c0104736>] show_trace+0x13/0x15
>>  [<c0104873>] dump_stack+0x1e/0x20
>>  [<c01d6c97>] autofs4_wait+0x751/0x93a
>>  [<c01d543b>] try_to_fill_dentry+0xca/0x11c
>>  [<c01d59b3>] autofs4_revalidate+0xe1/0x148
>>  [<c0171338>] do_lookup+0x40/0x157
>>  [<c0172ec4>] __link_path_walk+0x804/0xe8c
>>  [<c017359c>] link_path_walk+0x50/0xe8
>>  [<c01738b7>] do_path_lookup+0x10f/0x26d
>>  [<c017429c>] __user_walk_fd+0x33/0x50
>>  [<c016d226>] vfs_stat_fd+0x1e/0x50
>>  [<c016d30d>] vfs_stat+0x20/0x22
>>  [<c016d328>] sys_stat64+0x19/0x2d
>>  [<c0103127>] syscall_call+0x7/0xb
>>
> 
> There's some suspicious code in waitq.c.
> Could you try the following patch for me please?
> 
> --- linux-2.6.16-rc6-mm1/fs/autofs4/waitq.c.notify-bug	2006-03-13 13:23:52.000000000 +0800
> +++ linux-2.6.16-rc6-mm1/fs/autofs4/waitq.c	2006-03-13 13:25:40.000000000 +0800
> @@ -263,7 +263,7 @@ int autofs4_wait(struct autofs_sb_info *
>  		wq->tgid = current->tgid;
>  		wq->status = -EINTR; /* Status return if interrupted */
>  		atomic_set(&wq->wait_ctr, 2);
> -		atomic_set(&wq->notified, 1);
> +		atomic_set(&wq->notify, 1);
>  		mutex_unlock(&sbi->wq_mutex);
>  	} else {
>  		atomic_inc(&wq->wait_ctr);
> @@ -273,9 +273,11 @@ int autofs4_wait(struct autofs_sb_info *
>  			(unsigned long) wq->wait_queue_token, wq->len, wq->name, notify);
>  	}
>  
> -	if (notify != NFY_NONE && atomic_dec_and_test(&wq->notified)) {
> +	if (notify != NFY_NONE && atomic_read(&wq->notify)) {
>  		int type;
>  
> +		atomic_dec(&wq->notify);
> +
>  		if (sbi->version < 5) {
>  			if (notify == NFY_MOUNT)
>  				type = autofs_ptype_missing;
> --- linux-2.6.16-rc6-mm1/fs/autofs4/autofs_i.h.notify-bug	2006-03-13 13:23:39.000000000 +0800
> +++ linux-2.6.16-rc6-mm1/fs/autofs4/autofs_i.h	2006-03-13 13:24:08.000000000 +0800
> @@ -85,7 +85,7 @@ struct autofs_wait_queue {
>  	pid_t tgid;
>  	/* This is for status reporting upon return */
>  	int status;
> -	atomic_t notified;
> +	atomic_t notify;
>  	atomic_t wait_ctr;
>  };
>  
> 
> 
> 

thanks,
- --
Jiri Slaby         www.fi.muni.cz/~xslaby
\_.-^-._   jirislaby@gmail.com   _.-^-._/
B67499670407CE62ACC8 22A032CC55C339D47A7E
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.1 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFEGueJMsxVwznUen4RAh2NAKCn3If6/WX0/Ps/EGVM1TigT47zLgCfeftr
idL2GKQBfiW0MPCmsea9ZkI=
=24hQ
-----END PGP SIGNATURE-----
