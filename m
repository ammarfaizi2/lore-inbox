Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262225AbUCVSvU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 13:51:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262226AbUCVSvU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 13:51:20 -0500
Received: from fw.osdl.org ([65.172.181.6]:4553 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262225AbUCVSvR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 13:51:17 -0500
Subject: Re: 2.6.5-rc1-mm2 and direct_read_under and wb
From: Daniel McNeil <daniel@osdl.org>
To: Chris Mason <mason@suse.com>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "linux-aio@kvack.org" <linux-aio@kvack.org>
In-Reply-To: <1079980512.11058.524.camel@watt.suse.com>
References: <20040314172809.31bd72f7.akpm@osdl.org>
	 <1079461971.23783.5.camel@ibm-c.pdx.osdl.net>
	 <1079474312.4186.927.camel@watt.suse.com>
	 <20040316152106.22053934.akpm@osdl.org>
	 <20040316152843.667a623d.akpm@osdl.org>
	 <20040316153900.1e845ba2.akpm@osdl.org>
	 <1079485055.4181.1115.camel@watt.suse.com>
	 <1079487710.3100.22.camel@ibm-c.pdx.osdl.net>
	 <20040316180043.441e8150.akpm@osdl.org>
	 <1079554288.4183.1938.camel@watt.suse.com>
	 <20040317123324.46411197.akpm@osdl.org>
	 <1079563568.4185.1947.camel@watt.suse.com>
	 <20040317150909.7fd121bd.akpm@osdl.org>
	 <1079566076.4186.1959.camel@watt.suse.com>
	 <20040317155111.49d09a87.akpm@osdl.org>
	 <1079568387.4186.1964.camel@watt.suse.com>
	 <20040317161338.28b21c35.akpm@osdl.org>
	 <1079569870.4186.1967.camel@watt.suse.com>
	 <20040317163332.0385d665.akpm@osdl.org>
	 <1079572511.6930.5.camel@ibm-c.pdx.osdl.net>
	 <1079632431.6930.30.camel@ibm-c.pdx.osdl.net>
	 <1079635678.4185.2100.camel@watt.suse.com>
	 <1079637004.6930.42.camel@ibm-c.pdx.osdl.net>
	 <1079714990.6930.49.camel@ibm-c.pdx.osdl.net>
	 <1079715901.6930.52.camel@ibm-c.pdx.osdl.net>
	 <1079879799.11062.348.camel@watt.suse.com>
	 <1079979016.6930.62.camel@ibm-c.pdx.osdl.net>
	 <1079980512.11058.524.camel@watt.suse.com>
Content-Type: text/plain
Organization: 
Message-Id: <1079981473.6930.71.camel@ibm-c.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 22 Mar 2004 10:51:13 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was thinking about this also, since this is included in the patch.
As long as the page stays dirty in radix tree so the sync writer
can find it, then the sync writer can wait on the locked buffers.

I am giving it a try and will let you know.

Daniel


On Mon, 2004-03-22 at 10:35, Chris Mason wrote:
> On Mon, 2004-03-22 at 13:10, Daniel McNeil wrote:
> > Andrew and Chris,
> > 
> > I re-ran the direct_read_under tests over the weekend on ext3 with
> > the attached wb_rwsema patch and ran without errors.
> > 
> > It looks like the same thing as before -- async writebacks are causing
> > the sync writebacks to miss pages.
> > 
> > Thoughts?
> > 
> This hunk alone should be enough to force the sync writers to find a
> page with locked but clean buffers.
> 
> diff -rup linux-2.6.5-rc1-mm2.orig/fs/buffer.c linux-2.6.5-rc1-mm2/fs/buffer.c
> --- linux-2.6.5-rc1-mm2.orig/fs/buffer.c        2004-03-22 09:51:08.780141187 -0800
> +++ linux-2.6.5-rc1-mm2/fs/buffer.c     2004-03-19 16:24:57.000000000 -0800
> @@ -1814,8 +1814,7 @@ static int __block_write_full_page(struc
>                         lock_buffer(bh);
>                 } else {
>                         if (test_set_buffer_locked(bh)) {
> -                               if (buffer_dirty(bh))
> -                                       __set_page_dirty_nobuffers(page);
> +                               __set_page_dirty_nobuffers(page);
>                                 continue;
>                         }
>                 }
> 
> 
> -chris

