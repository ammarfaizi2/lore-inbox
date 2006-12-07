Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1163205AbWLGTQW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1163205AbWLGTQW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 14:16:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1163215AbWLGTQW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 14:16:22 -0500
Received: from mx1.redhat.com ([66.187.233.31]:58925 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1163205AbWLGTQV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 14:16:21 -0500
Message-ID: <457865DC.3020608@redhat.com>
Date: Thu, 07 Dec 2006 14:05:00 -0500
From: Wendy Cheng <wcheng@redhat.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Steven Whitehouse <swhiteho@redhat.com>
CC: Andrew Morton <akpm@osdl.org>, cluster-devel@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: [Cluster-devel] Re: [GFS2] Don't flush everything on fdatasync
 [70/70]
References: <1164889448.3752.449.camel@quoit.chygwyn.com>	<20061130230158.174e995c.akpm@osdl.org>	<1164970738.3752.508.camel@quoit.chygwyn.com>	<20061201110927.ec6ee073.akpm@osdl.org> <1165482686.3752.816.camel@quoit.chygwyn.com>
In-Reply-To: <1165482686.3752.816.camel@quoit.chygwyn.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Whitehouse wrote:
> Hi,
>
> On Fri, 2006-12-01 at 11:09 -0800, Andrew Morton wrote:
>   
>>> I was taking my cue here from ext3 which does something similar. The
>>> filemap_fdatawrite() is done by the VFS before this is called with a
>>> filemap_fdatawait() afterwards. This was intended to flush the metadata
>>> via (eventually) ->write_inode() although I guess I should be calling
>>> write_inode_now() instead?
>>>       
>> oh I see, you're jsut trying to write the inode itself, not the pages.
>>
>> write_inode_now() will write the pages, which you seem to not want to do.
>> Whatever.  The APIs here are a bit awkward.
>>     
>
> I've added a comment to explain whats going on here, and also the
> following patch. I know it could be better, but its still an improvement
> on what was there before,
>
>
>   
Steve,

I'm in the middle of something else and don't have upstream kernel 
source handy at this moment. But I read akpm's comment as 
"write_inode_now" would do writepage and that is *not* what you want (?) 
(since vfs has done that before this call is invoked). I vaguely 
recalled I did try write_inode_now() on GFS1 once but had to replace it 
with "sync_inode" on RHEL4 (for the reason that I can't remember at this 
moment). I suggest you keep "sync_inode" (at least for a while until we 
can prove other call can do better). This "sync_inode" has been well 
tested out (with GFS1's fsync call).

There is another issue. It is a gray area. Note that you don't grab any 
glock here ... so if someone *has* written something in other nodes, 
this sync could miss it (?). This depends on how people expects a 
fsync/fdatasync should behave in a cluster filesystem. GFS1 asks for a 
shared lock here so it will force other node to flush the data (I 
personally think this is a more correct behavior). Your call though.

-- Wendy

> --------------------------------------------------------------------------------------------
>
> >From 34126f9f41901ca9d7d0031c2b11fc0d6c07b72d Mon Sep 17 00:00:00 2001
> From: Steven Whitehouse <swhiteho@redhat.com>
> Date: Thu, 7 Dec 2006 09:13:14 -0500
> Subject: [PATCH] [GFS2] Change gfs2_fsync() to use write_inode_now()
>
> This is a bit better than the previous version of gfs2_fsync()
> although it would be better still if we were able to call a
> function which only wrote the inode & metadata. Its no big deal
> though that this will potentially write the data as well since
> the VFS has already done that before calling gfs2_fsync(). I've
> also added a comment to explain whats going on here.
>
> Signed-off-by: Steven Whitehouse <swhiteho@redhat.com>
> Cc: Andrew Morton <akpm@osdl.org>
> ---
>  fs/gfs2/ops_file.c |   11 ++++++-----
>  1 files changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/fs/gfs2/ops_file.c b/fs/gfs2/ops_file.c
> index 7bd971b..b3f1e03 100644
> --- a/fs/gfs2/ops_file.c
> +++ b/fs/gfs2/ops_file.c
> @@ -510,6 +510,11 @@ static int gfs2_close(struct inode *inod
>   * is set. For stuffed inodes we must flush the log in order to
>   * ensure that all data is on disk.
>   *
> + * The call to write_inode_now() is there to write back metadata and
> + * the inode itself. It does also try and write the data, but thats
> + * (hopefully) a no-op due to the VFS having already called filemap_fdatawrite()
> + * for us.
> + *
>   * Returns: errno
>   */
>  
> @@ -518,10 +523,6 @@ static int gfs2_fsync(struct file *file,
>  	struct inode *inode = dentry->d_inode;
>  	int sync_state = inode->i_state & (I_DIRTY_SYNC|I_DIRTY_DATASYNC);
>  	int ret = 0;
> -	struct writeback_control wbc = {
> -		.sync_mode = WB_SYNC_ALL,
> -		.nr_to_write = 0,
> -	};
>  
>  	if (gfs2_is_jdata(GFS2_I(inode))) {
>  		gfs2_log_flush(GFS2_SB(inode), GFS2_I(inode)->i_gl);
> @@ -530,7 +531,7 @@ static int gfs2_fsync(struct file *file,
>  
>  	if (sync_state != 0) {
>  		if (!datasync)
> -			ret = sync_inode(inode, &wbc);
> +			ret = write_inode_now(inode, 0);
>  
>  		if (gfs2_is_stuffed(GFS2_I(inode)))
>  			gfs2_log_flush(GFS2_SB(inode), GFS2_I(inode)->i_gl);
>   

