Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262190AbUCVSZM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 13:25:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262202AbUCVSZM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 13:25:12 -0500
Received: from ns.suse.de ([195.135.220.2]:21461 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262190AbUCVSZE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 13:25:04 -0500
Subject: Re: 2.6.5-rc1-mm2 and direct_read_under and wb
From: Chris Mason <mason@suse.com>
To: Daniel McNeil <daniel@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "linux-aio@kvack.org" <linux-aio@kvack.org>
In-Reply-To: <1079979800.11055.514.camel@watt.suse.com>
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
	 <1079979800.11055.514.camel@watt.suse.com>
Content-Type: text/plain
Message-Id: <1079980049.11061.519.camel@watt.suse.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 22 Mar 2004 13:27:29 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-03-22 at 13:23, Chris Mason wrote:
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
> 
> It does seem clear that's what is happening, but the part I don't
> understand is exactly where they are racing.

Wait, maybe I do see it.

In __block_write_full_page, if the buffers are locked by ll_rw_block and
under io, they are clean.  The page is only redirtied in this case
because the buffers are clean.

So we set_page_writeback and nr_underway == 0.  Then, in the if
(nr_underway == 0) code, we clear page writeback even though the buffers
are still locked and under io.

-chris


