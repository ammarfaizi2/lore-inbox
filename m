Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264502AbTLCMET (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 07:04:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264504AbTLCMET
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 07:04:19 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.104]:59548 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264502AbTLCMD4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 07:03:56 -0500
Date: Wed, 3 Dec 2003 17:32:44 +0530
From: Maneesh Soni <maneesh@in.ibm.com>
To: James W McMechan <mcmechanjw@juno.com>
Cc: hugh@veritas.com, linux-kernel@vger.kernel.org, wli@holomorphy.com,
       viro@parcelfarce.linux.theplanet.co.uk, akpm@osdl.org
Subject: Re: Oops with tmpfs on both 2.4.22 & 2.6.0-test11
Message-ID: <20031203120244.GA1311@in.ibm.com>
Reply-To: maneesh@in.ibm.com
References: <20031203.030618.-346209.0.mcmechanjw@juno.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031203.030618.-346209.0.mcmechanjw@juno.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 03, 2003 at 03:06:14AM -0800, James W McMechan wrote:
[..]

> > 
> > The cursor adjustment in dcache_dir_lseek() (fs/libfs.c: line 90) 
> > always puts the cursor just before the last looked dentry in the
> > while loop. 
> > 
> > But it is problematic when we have an empty directory and 
> > (file->f_pos == 2)
> > In this case we have the loop counter p pointing to the cursor and 
> > doing list_del and list_add_tail of the same list node results in oops.
> > 
> This is where I get mildly lost, from what you are saying here I
> would have expected a test on list_empty rather than on
> fpos==2 also this occurs in every file, will starting in a different
> pos in the list cause problems?

The cursor dentry is added in d_subdirs list in the ->open call for 
the directory. So even if directory is empty from a user point
of view, the d_subdirs list will ateast have the cursor dentry. 
In other words when we come to ->lseek or ->readdir call, we will not have 
empty d_subdirs list.

> 
> With further testing it also Oops even when the dir is not empty
> I did a "touch /dev/shm/1 /dev/shm/2 /dev/shm/3" to put some
> entries in the dir first and the original still oops at offset 2
> 
> I should do more testing, to see if I can find out what happens
> on non empty dirs, because I was thinking it was due to the
> dir being empty, which now appears not to be true.

humm.. yeah.. the original case will always oops for offset 2 irrespective
of whether directory is empty or not. Because in case of non-empty dir
also we will have p pointing to cursor dentry for offset 2.
Thanks for letting me know one more fact.

> 
> > The following patch takes (file->f_post == 2) as a special case and 
> > adjusts the cursor dentry by putting it right at the beginning of the 
> > d_subdirs list.
> > 
> Also is the new variable dentry needed or just a optimization?
> It looks functionally equivalent, but perhaps it is needed for 
> something I am not seeing at the moment.
That's just to make code readable, without this it will have line beyond 80
columns and also it has to de-reference multiple levels of pointers.


Thanks
Maneesh

-- 
Maneesh Soni
Linux Technology Center, 
IBM Software Lab, Bangalore, India
email: maneesh@in.ibm.com
Phone: 91-80-5044999 Fax: 91-80-5268553
T/L : 9243696
