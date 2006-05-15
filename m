Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965239AbWEOVTl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965239AbWEOVTl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 17:19:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965245AbWEOVTk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 17:19:40 -0400
Received: from prgy-npn2.prodigy.com ([207.115.54.38]:13593 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S965239AbWEOVTi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 17:19:38 -0400
Message-ID: <4468F022.4090409@tmr.com>
Date: Mon, 15 May 2006 17:18:26 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.2) Gecko/20060409 SeaMonkey/1.0.1
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, Valdis.Kletnieks@vt.edu, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: 2.6.17-rc3 - fs/namespace.c issue
References: <200605012106.k41L6GNc007543@turing-police.cc.vt.edu> <20060501143344.3952ff53.akpm@osdl.org> <20060501235637.GB12543@MAIL.13thfloor.at>
In-Reply-To: <20060501235637.GB12543@MAIL.13thfloor.at>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

has other stuff Herbert Poetzl wrote:
> On Mon, May 01, 2006 at 02:33:44PM -0700, Andrew Morton wrote:
>> Valdis.Kletnieks@vt.edu wrote:
>>> There seems to have been a bug introduced in this changeset:
>>>
>>> http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=f6422f17d3a480f21917a3895e2a46b968f56a08
>>>
>>> Am running 2.6.17-rc3-mm1.  When this changeset is applied, 'mount --bind'
>>> misbehaves:
>>>
>>>> # mkdir /foo
>>>> # mount -t tmpfs -o rw,nosuid,nodev,noexec,noatime,nodiratime none /foo
>>>> # mkdir /foo/bar
>>>> # mount --bind /foo/bar /foo
>>>> # tail -2 /proc/mounts
>>>> none /foo tmpfs rw,nosuid,nodev,noexec,noatime,nodiratime 0 0
>>>> none /foo tmpfs rw 0 0
>>> Reverting this changeset causes both mounts to have the same options.
>>>
>>> (Thanks to Stephen Smalley for tracking down the changeset...)
> 
> well, IMHO there are several open questions regarding semantics
> 
> first, what do we expect from --bind mounts regarding
> vfs (mount) level flags like noatime, noexec, nodev?
> 
>  - should they be propagated from the original mfs/mount?
>  - should they only restrict the original set?
>  - should they allow to modify the existing flags?

What does it mean if the flags can be modified? If I mount a tree ro, do 
I want to open the can of worms from allowing part of it to be rw 
elsewhere? And what checking is done, or should be done? If I do a ro 
mount with something like NFS, what should happen if I mount part of it 
rw? Substitute any of the other above flags, is there a security issue 
here, and can I shoot myself in the foot?

Can I apply the "user" attribute in fstab to a bind mount? If I let a 
user bind /foo/bar to /bazfaz/zot, what happens if I have the wrong 
thing mounted on /foo? Or if /bazfaz is NFS exported read only?
>  
> IMHO, it makes perfect sense to mount something noatime
> and change that rule later for a subtree like this:
> 
>  mkdir /foo
>  mount -t tmpfs -o rw,noatime none /foo
>  mkdir /foo/bar
>  mount --bind -o atime /foo/bar /foo/bar
> 
> second, has the kernel to decide what flags userspace
> can request and/or change, depending on the original?
> 
> and finally, how to handle --rbind mounts at a level
> deeper than the top?
> 
> so I do not consider the example above a misbehaviour. 
> what I consider a misbehaviour is that mount (userspace)
> blindly assumes that --bind mounts are independant, so
> it does not check the existing flags, and thus, does not
> preserve them (instead it replaces them with the default)
> 
> removing the mnt->mnt_flags = mnt_flags; assignment
> is sufficient to _only_ allow the identical attributes
> of the original mount, as they are copied in the
> clone_mnt() operation, of course, this also makes it
> impossible to have any flags/changes to the --bind mounts
> over the original

That certainly is a lot less likely to violate Plauger's law of least 
astonishment.
> 
> as this patch was torn out of a much larger patch set
> to allow for such attribute changes at --bind mount time
> I'd sugegst the following untested 'fix'
> 
> best,
> Herbert

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
