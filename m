Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319476AbSIMBVV>; Thu, 12 Sep 2002 21:21:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319477AbSIMBVU>; Thu, 12 Sep 2002 21:21:20 -0400
Received: from sv1.valinux.co.jp ([202.221.173.100]:35336 "HELO
	sv1.valinux.co.jp") by vger.kernel.org with SMTP id <S319476AbSIMBVS>;
	Thu, 12 Sep 2002 21:21:18 -0400
Date: Fri, 13 Sep 2002 10:18:26 +0900 (JST)
Message-Id: <20020913.101826.32726068.taka@valinux.co.jp>
To: akpm@digeo.com
Cc: linux-kernel@vger.kernel.org, janetmor@us.ibm.com
Subject: Re: [patch] readv/writev rework
From: Hirokazu Takahashi <taka@valinux.co.jp>
In-Reply-To: <3D80E139.ACC1719D@digeo.com>
References: <3D7EFF0F.89F7D585@digeo.com>
	<20020912.220041.82105437.taka@valinux.co.jp>
	<3D80E139.ACC1719D@digeo.com>
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.0 (HANANOEN)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

> > Your readv/writev patch interested me and I checked it.
> > I found we also have a chance to improve normal writev.
> > 
> > a_ops->prepare_write() and a_ops->commit_write will have a
> > penalty when I/O size isn't PAGE_SIZE.
> > With following patch generic_file_write_nolock() will try to
> > make each I/O size become PAGE_SIZE.
> > 
> 
> Certainly makes a lot of sense.  If an application has a large
> number of small objects which are to be appended to a file, and
> they are not contiguous in user memory then this patch makes
> writev() a very attractive way of doing that.  Tons faster.

Yeah, I realized syslogd is using writev against logfiles which are
opened with O_SYNC flag! I think heavy loaded mail-servers or
web-servers may get good performance with the new writev
as they are logging too much.

And I'd also like to make knfsd use it as a recevied nfs request may
be splited into some IP fragments.

> However I'd be a little concerned over the increased work which a boring
> old write() has to do.  Perhaps we could add a special code path
> for it:

It sounds nice.
I'll rewrite it soon.

> 	struct iovstate {
> 		unsigned rest;
> 		unsigned copy;
> 		unsigned off;
> 		struct iovec    *work_iov;
> 		char            *work_buf;
> 		unsigned         work_iov_bytes;
> 	} iovstate;
> 
> 	if (nr_segs != 1) {
> 		initialise iovstate;
> 	}
> 
> 	...
> 
> 	if (nr_segs == 1)
> 		page_fault = filemap_copy_from_user(page, offset, buf, bytes);
> 	else
> 		page_fault = iov_copy_from_user(&arg1, &arg2, &bytes, &iovstate);
> 	status = a_ops->commit_write(file, page, offset, offset+bytes);
> 
> 
> then we can do all that fancy stuff in iov_copy_from_user().  That
> function should be inlined so we don't really pass all those arguments
> around.  That's just a cleanliness thing, and branching around the complex
> code in the simple case.  We should be able to get the impact on the
> common case down to a single taken branch per page.
