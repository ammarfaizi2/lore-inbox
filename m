Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131363AbRCHN1k>; Thu, 8 Mar 2001 08:27:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131364AbRCHN1c>; Thu, 8 Mar 2001 08:27:32 -0500
Received: from orange.csi.cam.ac.uk ([131.111.8.77]:44447 "EHLO
	orange.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S131357AbRCHN1Q>; Thu, 8 Mar 2001 08:27:16 -0500
Message-Id: <5.0.2.1.2.20010308131755.00a53990@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.0.2
Date: Thu, 08 Mar 2001 13:26:56 +0000
To: linux-kernel@vger.kernel.org
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Question: fs meta data, page cache and locking
Cc: linux-fsdevel@vger.kernel.org
In-Reply-To: <20010308134114.P27675@nightmaster.csn.tu-chemnitz.de>
In-Reply-To: <5.0.2.1.2.20010308110922.00a41a60@pop.cus.cam.ac.uk>
 <5.0.2.1.2.20010308095213.00a59040@pop.cus.cam.ac.uk>
 <Pine.LNX.4.33.0103071931400.1409-100000@duckman.distro.con <5.0.2.1.2.20010308095213.00a59040@pop.cus.cam.ac.uk>
 <20010308115137.M27675@nightmaster.csn.tu-chemnitz.de>
 <5.0.2.1.2.20010308110922.00a41a60@pop.cus.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It was suggested to repost the below as a new thread and to cc: linux-fsdevel.

Any comments would be appreciated.

TIA,
         Anton

So here goes:

At 12:41 08/03/01, Ingo Oeser wrote:
> > On Thu, Mar 08, 2001 at 11:39:27AM +0000, Anton Altaparmakov wrote:
>[snip, attributions lost]
> > > > >+ * During disk I/O, PG_locked is used. This bit is set before I/O
> > > > >+ * and reset when I/O completes. page->wait is a wait queue of all
> > > > >+ * tasks waiting for the I/O on this page to complete.
>[snip]
> > When the NTFS file system driver needs to modify the meta data,
> > which will be in the page cache (meta data is stored in normal files on
> > NTFS, hence the page cache is very well suited to storing it with it's
> > page->mapping and page->index fields), does the NTFS driver need to set
> > PG_locked while writing to the page?
>[snip]
>May be you should raise these issues again under a separate
>subject and CC linux-fsdevel@vger.redhat.com for this.
>
>I think it is worth it, because Linus want all fs to use page
>cache for meta data and let buffer cache die slowly.
>
>Basically the rules go like this:
>
>The VM will wait for PG_locked pages, before it accesses them or
>ignore them, if it cannot wait.
>
>It will also try to read in pages, that are not PG_uptodate.
>
>But user space will never see metadata pages anyway, so you
>should be the only one, who cares about them. Just be prepared to
>writepage() and readpage() and the like.
>
>Just use lock_page() if you can sleep and TryLockPage() + EFAULT
>(or similar) if you cannot.
>
>Then just check Page_Uptodate() before you read and do
>ClearUptodate() if you start writing to the metadata.
>
>Since these operations are atomic bit operations, it should
>suffice for your purpose.
>
>But as stated above, I'm not very sure that I understand all the
>code and know of all the races.
>
>Multiple readers are AFAICS not yet possible with the current page
>cache.
>
>Regards
>
>Ingo Oeser
>--
>10.+11.03.2001 - 3. Chemnitzer LinuxTag <http://www.tu-chemnitz.de/linux/tag>
>          <<<<<<<<<<<<       come and join the fun       >>>>>>>>>>>>




-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://sourceforge.net/projects/linux-ntfs/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

