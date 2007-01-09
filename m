Return-Path: <linux-kernel-owner+w=401wt.eu-S932419AbXAIV50@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932419AbXAIV50 (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 16:57:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932421AbXAIV50
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 16:57:26 -0500
Received: from wx-out-0506.google.com ([66.249.82.235]:20660 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932419AbXAIV5Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 16:57:25 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:subject:date:message-id:mime-version:content-type:content-transfer-encoding:x-mailer:in-reply-to:x-mimeole:thread-index;
        b=s1RefwU0Zd/zxqyvOKOFuAcxBV7jq6McEor7nf4LkMVKYbew6KlkJUJ9MPTmeYgIIZREbE//siYEU7PixhecQYy5MkNyMHpg7IyGI/zOQe4MbXfjdEFMFoNPMXBkRZfMf48l1pMvta4uj/MAyJowD0P4NLL/cEts9ofF0XsAog8=
From: "Hua Zhong" <hzhong@gmail.com>
To: "'Hugh Dickins'" <hugh@veritas.com>
Cc: <linux-kernel@vger.kernel.org>, <hch@infradead.org>,
       <kenneth.w.chen@intel.com>, <akpm@osdl.org>, <torvalds@osdl.org>,
       <mjt@tls.msk.ru>
Subject: RE: [PATCH] support O_DIRECT in tmpfs/ramfs
Date: Tue, 9 Jan 2007 13:57:29 -0800
Message-ID: <000901c73439$297f3050$6721100a@nuitysystems.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
In-Reply-To: <Pine.LNX.4.64.0701092002350.21638@blonde.wat.veritas.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.3028
Thread-Index: Acc0LvZgriAwRfOoT26/fPZtheBmFgACDkAg
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Here is a simple patch that does it.
> 
> Looks more likely to work than Ken's - which I didn't try, 
> but I couldn't see what magic prevented it from just going BUG.
> 
> But I have to say, having seen the ensuing requests for this 
> to impose the same constraints as other implementations of 
> O_DIRECT (though NFS does not), I've veered right back to my 
> original position: this all just seems silly to me.  O_DIRECT 
> is and always has been rather an awkward hack (Linus 
> described it in stronger terms!), supported by many but not 
> all filesystems: shall we just leave it at that?

So I take your word that NFS does not impose this restraint,
which means filesystems could choose their own alignment
requirement that makes sense. So it would not be too horrible
if tmpfs chooses to be liberal.

In fact, in the O_DIRECT man page it says:

 O_DIRECT
              [....]  Under Linux 2.4 transfer sizes, and the  alignment  of
              user  buffer and file offset must all be multiples of the logi-
              cal block size of the file system. Under Linux 2.6 alignment to
              512-byte boundaries suffices.

So even Linux 2.4 and 2.6 are different - 2.6 is less restrictive.

My point is that as long as we don't put more restrictions, it should
not cause real problems.

And about Linus..let's put his comment aside because O_DIRECT
is there to stay. :-) In fact, since O_DIRECT is not the most 
beaufitul piece of code in the kernel, what I try to do is just to 
make software developer's life easier by making filesystem 
behavior as close to each other as possible with the minimal
effort.

> In particular, having now looked into the code, I'm amused to 
> be reminded that one of its particular effects is to 
> invalidate the pagecache for the area directly written.  
> Well, it's hardly going to be worth replicating that 
> behaviour with tmpfs or ramfs; yet if we don't, then we stand 
> accused of it behaving misleadingly differently on them.
> 
> I think Michael, who started off this discussion, did just the right
> thing: used a direct_IO filesystem on a loop device on a tmpfs file.

That's a rather heavy-weight workaround don't you think?

> > 1. A new fs flag FS_RAM_BASED is added and the O_DIRECT 
> flag is ignored
> >    if this flag is set (suggestions on a better name?)
> > 
> > 2. Specify FS_RAM_BASED for tmpfs and ramfs.
> 
> If this is pursued (not my preference, but let me stand aside 
> now), you'd want to add in at least hugetlbfs and 
> tiny-shmem.c.  And set your (renamed) FS_RAM_BASED flag in 
> ext2_aops_xip: that seems to be what they're wanting, then 
> you can remove that strange test for 
> f->f_mapping->a_ops->get_xip_page from __dentry_open.
> 
> > 
> > 3. When EINVAL is returned only a fput is done. I changed it to go
> >    through cleanup_all. But there is still a cleanup problem:
> 
> Is that change correct?  Are you saying that the existing 
> code leaks some structures?  If so, please do send a patch to 
> fix just that as soon as you can.  But are you sure?

Having looked at the code more closely, the change is probably
not correct. fput(f) apparently does everything cleanup_all does,
and more, despite it's a single call. I guess those names are 
a bit confusing at first glance. :-)

> > If a new file is created and then EINVAL is returned due to
> > O_DIRECT, the file is still left on the disk. I am not exactly
> > sure how to fix it other than adding another fs flag so we 
> > could check O_DIRECT support at a much earlier stage. 
> > Comments on how to fix it?
> 
> None from me, sorry.  It's untidy, but not a new issue you 
> have to fix.

Well, looks like people are not in consensus to add the tmpfs
direct-io support, but since I've looked at the code, it would be
nice to fix this bug though.

The get_xip_page thing you mentioned makes it a bit more
complicated since XIP support is a mount option, not a
register_filesystem time option. If we ought to add a flag somewhere,
where is the right place? vfsmount?

I can cook up a patch for this bug if people think it's worth fixing.

