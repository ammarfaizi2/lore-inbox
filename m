Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262852AbUCRStT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 13:49:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262866AbUCRStT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 13:49:19 -0500
Received: from fw.osdl.org ([65.172.181.6]:7114 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262852AbUCRStI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 13:49:08 -0500
Message-Id: <200403181849.i2IIn2E26720@mail.osdl.org>
Date: Thu, 18 Mar 2004 10:48:59 -0800 (PST)
From: markw@osdl.org
Subject: Re: 2.6.4-mm2
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040318100615.7f2943ea.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 18 Mar, Andrew Morton wrote:
> markw@osdl.org wrote:
>>
>> Sorry I'm falling behind...  I see about a 10% decrease in throughput
>> with our dbt2 workload when comparing 2.6.4-mm2 to 2.6.3.  I'm wondering
>> if this might be a result of the changes to the pagecache, radix-tree
>> and writeback code since you mentioned it could affect i/o scheduling in
>> 2.6.4-mm1.
> 
> Could be.  Have you run tests without LVM in the picture?

No I haven't and I'm hesitant to.  I have 52 single drives in one volume
and 14 single drives the other.  Because it's PostgreSQL, my options are
to either run on a single drive (and not be able to drive the system as
hard) or to reconfigure my drives using hardware raid.  I could do the
latter if you think it'll help.  It's just a bit time consuming.

>> PostgreSQL is using 8KB blocks and the characteristics of the i/o should
>> be that one lvm2 volume is experiencing mostly sequential writes, while
>> another has random reading and writing.  Both these volumes are using
>> ext2.  I'll summarize the throughput results here, with the lvm2 stripe
>> width varying across the columns:
>> 
>> kernel          16 kb   32 kb   64 kb   128 kb  256 kb  512 kb
>> 2.6.3                           2308    2335    2348    2334
>> 2.6.4-mm2       2028    2048    2074    2096    2082    2078
>> 
>> Here's a page with links to profile, oprofile, etc of each result:
>> 	http://developer.osdl.org/markw/linux/2.6-pagecache.html
>> 
>> Comparing one pair of readprofile results, I find it curious that
>> dm_table_unplug_all and dm_table_any_congested show up near the top of a
>> 2.6.4-mm2 profile when they haven't shown up before in 2.6.3.
> 
> 14015190 poll_idle                                241641.2069
> 175162 generic_unplug_device                    1317.0075
> 165480 __copy_from_user_ll                      1272.9231
> 161151 __copy_to_user_ll                        1342.9250
> 152106 schedule                                  85.0705
> 142395 DAC960_LP_InterruptHandler               761.4706
> 113677 dm_table_unplug_all                      1386.3049
>  65420 __make_request                            45.5571
>  64832 dm_table_any_congested                   697.1183
>  37913 try_to_wake_up                            32.2939
> 
> That's broken.  How many disks are involve in the DM stack?
> 
> The relevant code was reworked subsequent to 2.6.4-mm2.  Maybe we fixed
> this, but I cannot immediately explain what you're seeing here.

