Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135886AbREIHBB>; Wed, 9 May 2001 03:01:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135885AbREIHAw>; Wed, 9 May 2001 03:00:52 -0400
Received: from mons.uio.no ([129.240.130.14]:8654 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S135870AbREIHAg>;
	Wed, 9 May 2001 03:00:36 -0400
MIME-Version: 1.0
Message-ID: <15096.60176.549962.187256@charged.uio.no>
Date: Wed, 9 May 2001 09:00:32 +0200
To: Andrea Arcangeli <andrea@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: nfs MAP_SHARED corruption fix
In-Reply-To: <20010509044826.B2506@athlon.random>
In-Reply-To: <20010508160050.F543@athlon.random>
	<shs3dafvpcx.fsf@charged.uio.no>
	<20010509044826.B2506@athlon.random>
X-Mailer: VM 6.89 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
User-Agent: SEMI/1.13.7 (Awazu) CLIME/1.13.6 (=?ISO-2022-JP?B?GyRCQ2YbKEI=?=
 =?ISO-2022-JP?B?GyRCJU4+MRsoQg==?=) MULE XEmacs/21.1 (patch 14) (Cuyahoga
 Valley) (i386-redhat-linux)
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Andrea Arcangeli <andrea@suse.de> writes:

     > On Tue, May 08, 2001 at 05:21:02PM +0200, Trond Myklebust
     > wrote:
    >> AFAICs this fix will clearly deadlock...

     > yeah, it didn't triggered because it probably needs to be the
     > same page writepaged and in the dirty list at the same time. I
     > hooked it very deep into the writeback logic to keep it generic
     > (it wasn't going to add a significant overhead) but it didn't
     > need to be _that_ deep.

     > Even worse I think it was partly wrong because it was only in
     > the close(2) path but not in the fput path that is the one
     > walked by munmap.

     > This looks better to me, what do you think?

Just 2 comments.

 - You should use nfs_wb_all() here rather than nfs_wb_file() since
writepage() unfortunately can't initialize the NFS writeback structure
with the correct vma->vm_file.

 - Are we allowed to protect the filemap_fdatasync() + nfs_wb_all() by
grabbing the inode->i_sem in nfs_file_close_vma()? If so, this should
be done as well.

 Otherwise, that patch looked fine to me... I'll test it out...

Cheers,
   Trond
