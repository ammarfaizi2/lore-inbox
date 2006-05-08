Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932302AbWEHFIA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932302AbWEHFIA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 May 2006 01:08:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932300AbWEHFH7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 May 2006 01:07:59 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:45580 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S932302AbWEHFH7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 May 2006 01:07:59 -0400
Date: Mon, 8 May 2006 07:07:48 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Grant Coady <gcoady.lk@gmail.com>
Cc: Jesper Juhl <jesper.juhl@gmail.com>, linux-kernel@vger.kernel.org,
       Stephen Frost <sfrost@snowman.net>, laforge@netfilter.org,
       netfilter-devel@lists.netfilter.org, marcelo@kvack.org
Subject: Re: [PATCH] fix mem-leak in netfilter
Message-ID: <20060508050748.GA11495@w.ods.org>
References: <200605070426.10405.jesper.juhl@gmail.com> <20060507093640.GF11191@w.ods.org> <egts52hm2epfu4g1b9kqkm4s9cdiv3tvt9@4ax.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <egts52hm2epfu4g1b9kqkm4s9cdiv3tvt9@4ax.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Grant,

On Mon, May 08, 2006 at 08:42:53AM +1000, Grant Coady wrote:
> On Sun, 7 May 2006 11:36:40 +0200, Willy Tarreau <willy@w.ods.org> wrote:
> 
> >On Sun, May 07, 2006 at 04:26:10AM +0200, Jesper Juhl wrote:
> >> The Coverity checker spotted that we may leak 'hold' in 
> >> net/ipv4/netfilter/ipt_recent.c::checkentry() when the following
> >> is true : 
> >>   if (!curr_table->status_proc) {
> >>     ...
> >>     if(!curr_table) {
> >>     ...
> >>       return 0;  <-- here we leak.
> >> Simply moving an existing vfree(hold); up a bit avoids the possible leak.
> >> 
> >> 
> >> (please keep me on CC when replying since I'm not subscribed 
> >>  to netfilter-devel)
> >> 
> >> 
> >> Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
> >> ---
> >> 
> >>  net/ipv4/netfilter/ipt_recent.c |    2 +-
> >>  1 files changed, 1 insertion(+), 1 deletion(-)
> >> 
> >> --- linux-2.6.17-rc3-git12-orig/net/ipv4/netfilter/ipt_recent.c	2006-05-07 03:25:38.000000000 +0200
> >> +++ linux-2.6.17-rc3-git12/net/ipv4/netfilter/ipt_recent.c	2006-05-07 04:16:26.000000000 +0200
> >> @@ -821,6 +821,7 @@ checkentry(const char *tablename,
> >>  	/* Create our proc 'status' entry. */
> >>  	curr_table->status_proc = create_proc_entry(curr_table->name, ip_list_perms, proc_net_ipt_recent);
> >>  	if (!curr_table->status_proc) {
> >> +		vfree(hold);
> >>  		printk(KERN_INFO RECENT_NAME ": checkentry: unable to allocate for /proc entry.\n");
> >>  		/* Destroy the created table */
> >>  		spin_lock_bh(&recent_lock);
> >> @@ -845,7 +846,6 @@ checkentry(const char *tablename,
> >>  		spin_unlock_bh(&recent_lock);
> >>  		vfree(curr_table->time_info);
> >>  		vfree(curr_table->hash_table);
> >> -		vfree(hold);
> >>  		vfree(curr_table->table);
> >>  		vfree(curr_table);
> >>  		return 0;
> >
> >Seems valid for 2.4.32 too. I'm queuing it up for Marcelo.
> 
> When CONFIG_PROC_FS is not set the function looks like it may exit 
> without doing the vfree()s for stuff allocated above the #ifdef 
> CONFIG_PROC_FS.  

At first, I thought you were right. But after a night long rest,
I'm doubting. In fact, I'm not even sure that we can free 'hold' :

    753         for(c = 0; c < ip_list_tot; c++) {
    754                 curr_table->table[c].last_pkts = hold + c*ip_pkt_list_tot;
    755         }
    756 

So it seems like the vfree(hold) must not be performed if curr_table
is not unlinked. If this is the case, even Jesper's patch might be
wrong. Otherwise, vfree(hold) should be called unconditionnally
after #endif CONFIG_PROC_FS.

> I wonder if the larger view of the function is also correct?  The 
> coding style is difficult to work with as my terminal only goes to 
> 156 characters wide ;)  

Agreed ! Reading this code is really painful. Even after one long
night, I have huge trouble understanding it. Here are some good
excerpts, that we might honnestly call 'obfuscation' :

    799  while( (last_table = find_table) && strncmp(info->name,find_table->name,IPT_RECENT_NAME_LEN) && (find_table = find_table->next) );
    836  while( strncmp(info->name,curr_table->name,IPT_RECENT_NAME_LEN) && (last_table = curr_table) && (curr_table = curr_table->next) );
    844  if(last_table) last_table->next = curr_table->next; else r_tables = curr_table->next;

I wonder how such unmaintainable code has been merged in the first
place. Obviously, Davem has never seen it ! He has already annoyed
me for 81-chars wide lines because his terminal is 80 columns. Or
he has given up from the very beginning. The fact is it's a tool
which has found a potential memory leak.

> Grant.

Regards,
Willy

