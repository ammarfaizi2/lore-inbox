Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932139AbWIZPwl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932139AbWIZPwl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 11:52:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932137AbWIZPwk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 11:52:40 -0400
Received: from py-out-1112.google.com ([64.233.166.179]:41291 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932139AbWIZPwh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 11:52:37 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=WeJT+009XIu2XGXeE8rLojG0eXSs+EwpD7Y9D0BbQzQxvy1xFYJCyI3+MQFikZ/VFBc1Y5F8fpZm0vLS9XeR82i5pFZE67t44+NXUJRUgCuTo5MyV0piJ+t5Zj7mqifdAN3bo5H5mnU1E2FfvjG/T/007ARqHVQgxe4IZKMfUMg=
Message-ID: <4354d3270609260852maec46abh6755a17522797b65@mail.gmail.com>
Date: Tue, 26 Sep 2006 18:52:37 +0300
From: "=?ISO-8859-1?Q?T=F6r=F6k_Edvin?=" <edwintorok@gmail.com>
To: "Phillip Susi" <psusi@cfl.rr.com>
Subject: Re: [PATCH][RFC] Rearranging files to improve disk performanc
Cc: linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk
In-Reply-To: <451836CC.2010003@cfl.rr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <4354d3270609231211r6b9227fdhb88a6dc8822fc803@mail.gmail.com>
	 <451836CC.2010003@cfl.rr.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/25/06, Phillip Susi <psusi@cfl.rr.com> wrote:
> This ability is already available at least for ext2/3 in the old defrag
> package, which can take a list of files and priorities to assign to
> them, and it will pack them in the order given at the start of the disk.

My idea was to use existing filesystem calls to move files around. That is why
the basic idea is to have online defragmentation.
If it is possible to use the code from the old ext2/3 defrag to create
an online defragmentation program, excellent. But I'd like a general
solution, that would work
/could be made to work with all filesystems in the future.
That is why I asked for comments on my suggestion of a (real) simple
filesystem rearranger (or defragmenter if you want to call it that
way).

> As for your idea, if there is going to be online defrag support in the
> kernel ( and yes, this is a form of defragmenting ) I'd rather see the
> ability to move files around deterministically rather than just give a
> hint and pray, similar to how windows handles online defragmenting.

I agree with this, and maybe sysfs is a bad choice for what I'd like
to accomplish. Maybe a netlink based api would be better, as we would
have a more obvious way of reporting errors?

Anyway, regardless of the user to kernel communication, IMHO it should
be established _what_ will userspace communicate to kernel, and
viceversa (i.e. an API).


1. Determine current file location on disk.
We already have this: FIBMAP ioctl.

2. For determining where to put files, we need to know the free extents.
'debugreiserfs -m <partition>' already accomplishes this, but it
should be made more general.

3. Ascertaining the optimal location for files.
Can be done entirely in userspace, once you have the information from
steps 1 and 2.

4. Notifying userspace on writes to disk/pending writes to disk.
Can be done via inotify/dnotify. This is needed, so that userspace
knows to refresh its idea of
free extents, and possibly the defrag strategy.

5. Once a defrag strategy has been determined, tell the kernel to
reserve those blocks
for our files. (preallocation?) This can be useful if you are
defragmenting a system under load, and can't afford to shut down
processes that write to the disk. And also refreshing the fs bitmap
would be expensive.

6. It should be easy to reclaim blocks preallocated in step 5. (in the
(unlikely?) event the defrag program crashes/needs to be restarted, or
if defrag is aborted).

7. An API to move files around, or at least chunks of it.
This is the critical part. If space has been preallocated in step 5,
it should be as easy as copy the file to new place/ delete from old
place. (relocate_inode(inode,newlocation)).

8. Have the ability to submit multiple move request simultaneously to
take advantage of ncq/tcq/write-read merges,...

9. Take advantage of blocks freed up after moving files. Thus if
multiple requests are issued, they must not operate on the same block
(obviously).

10. Status reports on the success of preallocation, file moves,...
especially the reason why an operation was not possible.


I welcome any comments/suggestions on the above. Feel free to improve
on it, or to rewrite the defrag-api-ideas from scratch.
I would really appreciate if somebody could point out problems with
certain assumptions I made above, and of course welcome any criticism
too.


Best regards,
Edwin
