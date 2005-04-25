Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262562AbVDYHpq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262562AbVDYHpq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 03:45:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262560AbVDYHpq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 03:45:46 -0400
Received: from ppsw-2.csi.cam.ac.uk ([131.111.8.132]:2019 "EHLO
	ppsw-2.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S262557AbVDYHoq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 03:44:46 -0400
Subject: Re: [patch] fix race in __block_prepare_write (again)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: nickpiggin@yahoo.com.au, linux-kernel@vger.kernel.org, andrea@suse.de
In-Reply-To: <20050424142439.3b45bdbc.akpm@osdl.org>
References: <1114064046.5182.13.camel@npiggin-nld.site>
	 <Pine.LNX.4.60.0504210757220.3348@hermes-1.csi.cam.ac.uk>
	 <1114067401.11293.3.camel@imp.csi.cam.ac.uk>
	 <1114068058.5182.22.camel@npiggin-nld.site>
	 <1114068704.12751.8.camel@imp.csi.cam.ac.uk>
	 <20050424142439.3b45bdbc.akpm@osdl.org>
Content-Type: text/plain
Organization: Computing Service, University of Cambridge, UK
Date: Mon, 25 Apr 2005 08:44:40 +0100
Message-Id: <1114415080.18436.14.camel@imp.csi.cam.ac.uk>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 7bit
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-04-24 at 14:24 -0700, Andrew Morton wrote:
> Anton Altaparmakov <aia21@cam.ac.uk> wrote:
> >
> > mm/filemap.c::file_buffered_write():
> > 
> >  - It calls fault_in_pages_readable() which is completely bogus if
> >  @nr_segs > 1.  It needs to be replaced by a to be written
> >  "fault_in_pages_readable_iovec()".
> > 
> >  - It increments @buf even in the iovec case thus @buf can point to
> >  random memory really quickly (in the iovec case) and then it calls
> >  fault_in_pages_readable() on this random memory.  Ouch...
> 
> hmm, yes.  Like this?

Yes, certainly a big improvement over what is there at the moment.

> diff -puN mm/filemap.c~generic_file_buffered_write-fixes mm/filemap.c
> --- 25/mm/filemap.c~generic_file_buffered_write-fixes	2005-04-24 14:18:58.445943000 -0700
> +++ 25-akpm/mm/filemap.c	2005-04-24 14:20:21.995241576 -0700
> @@ -1944,7 +1944,7 @@ generic_file_buffered_write(struct kiocb
>  		buf = iov->iov_base + written;
>  	else {
>  		filemap_set_next_iovec(&cur_iov, &iov_base, written);
> -		buf = iov->iov_base + iov_base;
> +		buf = cur_iov->iov_base + iov_base;
>  	}
>  
>  	do {
> @@ -2002,9 +2002,11 @@ generic_file_buffered_write(struct kiocb
>  				count -= status;
>  				pos += status;
>  				buf += status;
> -				if (unlikely(nr_segs > 1))
> +				if (unlikely(nr_segs > 1)) {
>  					filemap_set_next_iovec(&cur_iov,
>  							&iov_base, status);
> +					buf = cur_iov->iov_base + iov_base;
> +				}
>  			}
>  		}
>  		if (unlikely(copied != bytes))

Best regards,

        Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

