Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264536AbTLCLPU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 06:15:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264539AbTLCLPU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 06:15:20 -0500
Received: from m17.lax.untd.com ([64.136.30.80]:7657 "HELO m17.lax.untd.com")
	by vger.kernel.org with SMTP id S264536AbTLCLPP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 06:15:15 -0500
To: maneesh@in.ibm.com
Cc: hugh@veritas.com, linux-kernel@vger.kernel.org, wli@holomorphy.com,
       viro@parcelfarce.linux.theplanet.co.uk, akpm@osdl.org
Date: Wed, 3 Dec 2003 03:06:14 -0800
Subject: Re: Oops with tmpfs on both 2.4.22 & 2.6.0-test11
Message-ID: <20031203.030618.-346209.0.mcmechanjw@juno.com>
X-Mailer: Juno 5.0.33
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: James W McMechan <mcmechanjw@juno.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi,
> 
> I hope nobody minds me jumping in this thread. I have been looking 
> at this code for some time and hope I have got the facts correct.
> 
Thank you, so far it is no longer crashing :)

> The two list_xxx macros as mentioned (fs/libfs.c:line 137) adjusts 
> the cursor dentry to the beginning of the d_subdirs list needed for 
> (file->f_pos == 2) as there can be additions in the d_subdirs list 
> after the open call and before ->lseek or ->readdir call.
> 
> The cursor adjustment in dcache_dir_lseek() (fs/libfs.c: line 90) 
> always puts the cursor just before the last looked dentry in the
> while loop. 
> 
> But it is problematic when we have an empty directory and 
> (file->f_pos == 2)
> In this case we have the loop counter p pointing to the cursor and 
> doing list_del and list_add_tail of the same list node results in oops.
> 
This is where I get mildly lost, from what you are saying here I
would have expected a test on list_empty rather than on
fpos==2 also this occurs in every file, will starting in a different
pos in the list cause problems?

With further testing it also Oops even when the dir is not empty
I did a "touch /dev/shm/1 /dev/shm/2 /dev/shm/3" to put some
entries in the dir first and the original still oops at offset 2

I should do more testing, to see if I can find out what happens
on non empty dirs, because I was thinking it was due to the
dir being empty, which now appears not to be true.

> The following patch takes (file->f_post == 2) as a special case and 
> adjusts the cursor dentry by putting it right at the beginning of the 
> d_subdirs list.
> 
Also is the new variable dentry needed or just a optimization?
It looks functionally equivalent, but perhaps it is needed for 
something I am not seeing at the moment.
> 
> Thanks
> Maneesh

________________________________________________________________
The best thing to hit the internet in years - Juno SpeedBand!
Surf the web up to FIVE TIMES FASTER!
Only $14.95/ month - visit www.juno.com to sign up today!
