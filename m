Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751339AbWIDKGL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751339AbWIDKGL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 06:06:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751337AbWIDKGL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 06:06:11 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:25816 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1751331AbWIDKGJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 06:06:09 -0400
Date: Mon, 4 Sep 2006 12:06:03 +0200
From: Jan Kara <jack@suse.cz>
To: Sergey Vlasov <vsu@altlinux.ru>
Cc: Ben Fennema <bfennema@falcon.csc.calpoly.edu>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: UDF 1GB file size limit after CVE-2006-4145 fix
Message-ID: <20060904100603.GF4710@atrey.karlin.mff.cuni.cz>
References: <20060903151108.GA27102@procyon.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060903151108.GA27102@procyon.home>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hello,

> On Tue, Aug 15, 2006 at 01:56:26PM +0200, Jan Kara wrote:
> > UDF code is not really ready to handle extents larger that 1GB. This is
> > the easy way to forbid creating those.
> > 
> > Also truncation code did not count with the case when there are no
> > extents in the file and we are extending the file.
> > 
> > Signed-off-by: Jan Kara <jack@suse.cz>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
> > ---
> >  fs/udf/super.c    |    2 +-
> >  fs/udf/truncate.c |   64 ++++++++++++++++++++++++++++++++---------------------
> >  2 files changed, 40 insertions(+), 26 deletions(-)
> > 
> > diff --git a/fs/udf/super.c b/fs/udf/super.c
> > index 7de172e..fcce1a2 100644
> > --- a/fs/udf/super.c
> > +++ b/fs/udf/super.c
> > @@ -1659,7 +1659,7 @@ #endif
> >  		iput(inode);
> >  		goto error_out;
> >  	}
> > -	sb->s_maxbytes = MAX_LFS_FILESIZE;
> > +	sb->s_maxbytes = 1<<30;
> [... rest of patch skipped ...]
> 
> After this change the size of files which can be created on an UDF
> filesystem becomes limited to 1GB.  This is very unfortunate - in
> particular, it means that there will be no way to write a file larger
> than 4GB to a DVD under Linux (mkisofs -udf does not support files
> larger than 4GB, so the typical workaround was to use mkudffs and
> mount -o loop).  In fact, this change may be considered as a
> regression - large files on UDF seemed to work before (at least in
> simple cases), and now they are forbidden.
  Actually I've been trying this and I have not been able to create file
larger than 1GB on my computer without UDF corrupting slab or doing some
other nasty thing. OK, maybe if you created it in 1GB pieces it could
work but anyway the problem is that currently if you have UDF rw-mounted,
ordinary user could make UDF corrupt kernel memory... So consider this
limitation more as a hotfix to the security problem - real fix is to
rewrite UDF write path to not create extents larger than 1 GB but that
is quite some work and will definitely need more testing.

> Files larger than 1GB can be read even after this patch (because
> s_maxbytes is not checked in read paths, and udf does not use
> generic_file_lseek()), so old disks at least can be read.
> 
> What issues with files larger than 1GB have been found in the code?
  See above.

> Is someone working to fix these problems?
  Yes, I plan to have a look into a proper fix of this problem (i.e. fix
UDF write path).

								Honza
-- 
Jan Kara <jack@suse.cz>
SuSE CR Labs

-- 
VGER BF report: H 0.000799476
