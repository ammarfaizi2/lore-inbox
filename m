Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932211AbWIEXT2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932211AbWIEXT2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 19:19:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932212AbWIEXT2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 19:19:28 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:3757 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932210AbWIEXT0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 19:19:26 -0400
Message-ID: <44FE05FA.2000406@us.ibm.com>
Date: Tue, 05 Sep 2006 16:19:22 -0700
From: Mingming Cao <cmm@us.ibm.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.3) Gecko/20040910
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Badari Pulavarty <pbadari@us.ibm.com>
CC: Will Simoneau <simoneau@ele.uri.edu>, akpm@osdl.org,
       lkml <linux-kernel@vger.kernel.org>, ext4 <linux-ext4@vger.kernel.org>
Subject: Re: BUG: warning at fs/ext3/inode.c:1016/ext3_getblk()
References: <20060905171049.GB27433@ele.uri.edu>	 <44FDE6E5.3090009@us.ibm.com>  <20060905214703.GA16449@ele.uri.edu> <1157496228.23501.21.camel@dyn9047017100.beaverton.ibm.com>
In-Reply-To: <1157496228.23501.21.camel@dyn9047017100.beaverton.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Badari Pulavarty wrote:
> On Tue, 2006-09-05 at 17:47 -0400, Will Simoneau wrote:
> 
>>On 14:06 Tue 05 Sep     , Badari Pulavarty wrote:
>>
>>>Will Simoneau wrote:
>>>
>>>>Has anyone seen this before? These three traces occured at different times
>>>>today when three new user accounts (and associated quotas) were created. 
>>>>This
>>>>machine is an NFS server which uses quotas on an ext3 fs (dir_index is on).
>>>>Kernel is 2.6.17.11 on an x86 smp w/64G highmem; 4G ram is installed. The
>>>>affected filesystem is on a software raid1 of two hardware raid0 volumes 
>>>
>>>>from a
>>>
>>>>megaraid card.
>>>>
>>>>BUG: warning at fs/ext3/inode.c:1016/ext3_getblk()
>>>><c01c5140> ext3_getblk+0x98/0x2a6  <c03b2806> md_wakeup_thread+0x26/0x2a
>>>><c01c536d> ext3_bread+0x1f/0x88  <c01cedf9> ext3_quota_read+0x136/0x1ae
>>>><c018b683> v1_read_dqblk+0x61/0xac  <c0188f32> dquot_acquire+0xf6/0x107
>>>><c01ceaba> ext3_acquire_dquot+0x46/0x68  <c01897d4> dqget+0x155/0x1e7
>>>><c018a97b> dquot_transfer+0x3e0/0x3e9  <c016fe52> dput+0x23/0x13e
> 
> 
> I think, we found your problem.
> 
> ext3_getblk() is not handling HOLE correctly. Does this patch help ?
> Mingming, what do you think ?

Looks correct to me, ext3_get_blocks_handle() returning 0 is a valid 
case when the block is not being mapped(hole).

It would be nice to add a WARN_ON() in the ext3_get_blocks_handle() code 
when we allocating more than requested (maxblocks) blocks...:)

Mingming


> Badari
> 
> ext3_get_blocks_handle() returns number of blocks it mapped.
> It returns 0 in case of HOLE. ext3_getblk() should handle
> HOLE properly (currently its dumping warning stack and
> returning -EIO).
> 
> Signed-off-by: Badari Pulavarty <pbadari@us.ibm.com>
> ---
>  fs/ext3/inode.c |    9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> Index: linux-2.6.18-rc5/fs/ext3/inode.c
> ===================================================================
> --- linux-2.6.18-rc5.orig/fs/ext3/inode.c	2006-08-27 20:41:48.000000000 -0700
> +++ linux-2.6.18-rc5/fs/ext3/inode.c	2006-09-05 15:32:57.000000000 -0700
> @@ -1009,11 +1009,12 @@ struct buffer_head *ext3_getblk(handle_t
>  	buffer_trace_init(&dummy.b_history);
>  	err = ext3_get_blocks_handle(handle, inode, block, 1,
>  					&dummy, create, 1);
> -	if (err == 1) {
> +	/*
> +	 * ext3_get_blocks_handle() returns number of blocks
> +	 * mapped. 0 in case of a HOLE.
> +	 */
> +	if (err > 0) {
>  		err = 0;
> -	} else if (err >= 0) {
> -		WARN_ON(1);
> -		err = -EIO;
>  	}
>  	*errp = err;
>  	if (!err && buffer_mapped(&dummy)) {
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-ext4" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


