Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316795AbSILSnc>; Thu, 12 Sep 2002 14:43:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317005AbSILSnc>; Thu, 12 Sep 2002 14:43:32 -0400
Received: from packet.digeo.com ([12.110.80.53]:51393 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S316795AbSILSnb>;
	Thu, 12 Sep 2002 14:43:31 -0400
Message-ID: <3D80E139.ACC1719D@digeo.com>
Date: Thu, 12 Sep 2002 11:47:21 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Hirokazu Takahashi <taka@valinux.co.jp>
CC: linux-kernel@vger.kernel.org, janetmor@us.ibm.com
Subject: Re: [patch] readv/writev rework
References: <3D7EFF0F.89F7D585@digeo.com> <20020912.220041.82105437.taka@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 12 Sep 2002 18:47:24.0009 (UTC) FILETIME=[D549A590:01C25A8C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hirokazu Takahashi wrote:
> 
> Hello,
> 
> Your readv/writev patch interested me and I checked it.
> I found we also have a chance to improve normal writev.
> 
> a_ops->prepare_write() and a_ops->commit_write will have a
> penalty when I/O size isn't PAGE_SIZE.
> With following patch generic_file_write_nolock() will try to
> make each I/O size become PAGE_SIZE.
> 

Certainly makes a lot of sense.  If an application has a large
number of small objects which are to be appended to a file, and
they are not contiguous in user memory then this patch makes
writev() a very attractive way of doing that.  Tons faster.

However I'd be a little concerned over the increased work which a boring
old write() has to do.  Perhaps we could add a special code path
for it:

	struct iovstate {
		unsigned rest;
		unsigned copy;
		unsigned off;
		struct iovec    *work_iov;
		char            *work_buf;
		unsigned         work_iov_bytes;
	} iovstate;

	if (nr_segs != 1) {
		initialise iovstate;
	}

	...

	if (nr_segs == 1)
		page_fault = filemap_copy_from_user(page, offset, buf, bytes);
	else
		page_fault = iov_copy_from_user(&arg1, &arg2, &bytes, &iovstate);
	status = a_ops->commit_write(file, page, offset, offset+bytes);


then we can do all that fancy stuff in iov_copy_from_user().  That
function should be inlined so we don't really pass all those arguments
around.  That's just a cleanliness thing, and branching around the complex
code in the simple case.  We should be able to get the impact on the
common case down to a single taken branch per page.
