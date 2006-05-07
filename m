Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932102AbWEGWnA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932102AbWEGWnA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 May 2006 18:43:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932237AbWEGWnA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 May 2006 18:43:00 -0400
Received: from relay02.mail-hub.dodo.com.au ([202.136.32.45]:2996 "EHLO
	relay02.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S932102AbWEGWnA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 May 2006 18:43:00 -0400
From: Grant Coady <gcoady.lk@gmail.com>
To: Willy Tarreau <willy@w.ods.org>
Cc: Jesper Juhl <jesper.juhl@gmail.com>, linux-kernel@vger.kernel.org,
       Stephen Frost <sfrost@snowman.net>, laforge@netfilter.org,
       netfilter-devel@lists.netfilter.org, marcelo@kvack.org
Subject: Re: [PATCH] fix mem-leak in netfilter
Date: Mon, 08 May 2006 08:42:53 +1000
Organization: http://bugsplatter.mine.nu/
Message-ID: <egts52hm2epfu4g1b9kqkm4s9cdiv3tvt9@4ax.com>
References: <200605070426.10405.jesper.juhl@gmail.com> <20060507093640.GF11191@w.ods.org>
In-Reply-To: <20060507093640.GF11191@w.ods.org>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 7 May 2006 11:36:40 +0200, Willy Tarreau <willy@w.ods.org> wrote:

>On Sun, May 07, 2006 at 04:26:10AM +0200, Jesper Juhl wrote:
>> The Coverity checker spotted that we may leak 'hold' in 
>> net/ipv4/netfilter/ipt_recent.c::checkentry() when the following
>> is true : 
>>   if (!curr_table->status_proc) {
>>     ...
>>     if(!curr_table) {
>>     ...
>>       return 0;  <-- here we leak.
>> Simply moving an existing vfree(hold); up a bit avoids the possible leak.
>> 
>> 
>> (please keep me on CC when replying since I'm not subscribed 
>>  to netfilter-devel)
>> 
>> 
>> Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
>> ---
>> 
>>  net/ipv4/netfilter/ipt_recent.c |    2 +-
>>  1 files changed, 1 insertion(+), 1 deletion(-)
>> 
>> --- linux-2.6.17-rc3-git12-orig/net/ipv4/netfilter/ipt_recent.c	2006-05-07 03:25:38.000000000 +0200
>> +++ linux-2.6.17-rc3-git12/net/ipv4/netfilter/ipt_recent.c	2006-05-07 04:16:26.000000000 +0200
>> @@ -821,6 +821,7 @@ checkentry(const char *tablename,
>>  	/* Create our proc 'status' entry. */
>>  	curr_table->status_proc = create_proc_entry(curr_table->name, ip_list_perms, proc_net_ipt_recent);
>>  	if (!curr_table->status_proc) {
>> +		vfree(hold);
>>  		printk(KERN_INFO RECENT_NAME ": checkentry: unable to allocate for /proc entry.\n");
>>  		/* Destroy the created table */
>>  		spin_lock_bh(&recent_lock);
>> @@ -845,7 +846,6 @@ checkentry(const char *tablename,
>>  		spin_unlock_bh(&recent_lock);
>>  		vfree(curr_table->time_info);
>>  		vfree(curr_table->hash_table);
>> -		vfree(hold);
>>  		vfree(curr_table->table);
>>  		vfree(curr_table);
>>  		return 0;
>
>Seems valid for 2.4.32 too. I'm queuing it up for Marcelo.

When CONFIG_PROC_FS is not set the function looks like it may exit 
without doing the vfree()s for stuff allocated above the #ifdef 
CONFIG_PROC_FS.  

I wonder if the larger view of the function is also correct?  The 
coding style is difficult to work with as my terminal only goes to 
156 characters wide ;)  

Grant.
