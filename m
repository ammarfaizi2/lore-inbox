Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261181AbUJYRUg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261181AbUJYRUg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 13:20:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261152AbUJYRSc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 13:18:32 -0400
Received: from notes.hallinto.turkuamk.fi ([195.148.215.149]:49937 "EHLO
	notes.hallinto.turkuamk.fi") by vger.kernel.org with ESMTP
	id S261174AbUJYRQn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 13:16:43 -0400
Message-ID: <417D35F0.1070501@kolumbus.fi>
Date: Mon, 25 Oct 2004 20:20:48 +0300
From: =?ISO-8859-1?Q?Mika_Penttil=E4?= <mika.penttila@kolumbus.fi>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mike Waychison <michael.waychison@sun.com>
CC: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       raven@themaw.net
Subject: Re: [PATCH 13/28] VFS: Introduce soft reference counts
References: <10987154731896@sun.com> <10987155032816@sun.com>
In-Reply-To: <10987155032816@sun.com>
X-MIMETrack: Itemize by SMTP Server on marconi.hallinto.turkuamk.fi/TAMK(Release 5.0.8 |June
 18, 2001) at 25.10.2004 20:18:01,
	Serialize by Router on notes.hallinto.turkuamk.fi/TAMK(Release 5.0.10 |March
 22, 2002) at 25.10.2004 20:18:45,
	Serialize complete at 25.10.2004 20:18:45
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Waychison wrote:

>This patch introduces the concept of a 'soft' reference count for a vfsmount.
>This type of reference count allows for references to be held on mountpoints
>that do not affect their busy states for userland unmounting.  Some might
>argue that this is wrong because 'when I unmount a filesystem, I want the
>resources associated with it to go away too', but this way of thinking was
>deprecated with the addition of namespaces and --bind back in the 2.4 series.
>
>A future addition may see a callback mechanism so that in kernel users can
>use a given mountpoint and have it deregistered some way (quota and
>accounting come to mind).
>
>These soft reference counts are used by a later patch that adds an interface
>for holding and manipulating mountpoints using filedescriptors.
>
>Signed-off-by: Mike Waychison <michael.waychison@sun.com>
> 
>+static inline struct vfsmount *mntsoftget(struct vfsmount *mnt)
>+{
>+	if (mnt) {
>+		read_lock(&vfsmountref_lock);
>+		atomic_inc(&mnt->mnt_softcount);
>+		mntgroupget(mnt);
>+		read_unlock(&vfsmountref_lock);
>+	}
>+	return mnt;
>+}
>+
>+static inline void mntsoftput(struct vfsmount *mnt)
>+{
>+	struct vfsmount *cleanup;
>+	might_sleep();
>+	if (mnt) {
>+		if (atomic_dec_and_test(&mnt->mnt_count))
>+			__mntput(mnt);
>+		read_lock(&vfsmountref_lock);
>+		cleanup = mntgroupput(mnt);
>+		atomic_dec(&mnt->mnt_softcount);
>+		read_unlock(&vfsmountref_lock);
>+		if (cleanup)
>+			__mntgroupput(cleanup);
>+	}
>+}
>+
> extern void free_vfsmnt(struct vfsmount *mnt);
>  
>
What is this against? What are mntgroupput and mntgroupget? Why does 
soft put decrement mnt_count which isn't increment by soft get? How do 
soft references allow userland umount? I don't see soft references used 
anywhere...

--Mika

