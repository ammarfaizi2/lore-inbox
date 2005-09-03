Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751111AbVICRIU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751111AbVICRIU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Sep 2005 13:08:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751252AbVICRIU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Sep 2005 13:08:20 -0400
Received: from stat9.steeleye.com ([209.192.50.41]:13776 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S1751094AbVICRIS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Sep 2005 13:08:18 -0400
Subject: Re: 2.6.13-mm1: hangs during boot ...
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Peter Williams <pwil3058@bigpond.net.au>
Cc: Reuben Farrelly <reuben-lkml@reub.net>, "Brown, Len" <len.brown@intel.com>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
In-Reply-To: <4319AA71.7090700@bigpond.net.au>
References: <fa.qs5cahs.i2khgm@ifi.uio.no> <fa.fm9i4v6.1ekchhm@ifi.uio.no>
	 <4319A402.7030705@reub.net>  <4319AA71.7090700@bigpond.net.au>
Content-Type: text/plain
Date: Sat, 03 Sep 2005 12:14:16 -0400
Message-Id: <1125764058.4615.4.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-09-03 at 23:51 +1000, Peter Williams wrote:
> > Are you seeing this "Device  not ready" message appear over and over, or 
> > just the once?
> 
> Just the once.

OK, I finally have a theory about this.  It's the everything goes via
bios code.  Previously there were several levels at which commands could
exit the SCSI stack; now we make everything go via bios, so they all
come out at the top.

get_capabilities() in sr.c is sending a TEST_UNIT_READY which will get
NOT_READY back.  Previously this was completing before it got to
scsi_io_completion(); now it doesn't.  There must be quite a few cases
like this.  The best fix is probably to use and respect REQ_QUIET for
internally generated commands.

James


