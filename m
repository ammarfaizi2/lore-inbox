Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263156AbTDRRWW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Apr 2003 13:22:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263160AbTDRRWW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Apr 2003 13:22:22 -0400
Received: from 216-99-218-173.dsl.aracnet.com ([216.99.218.173]:22004 "EHLO
	dyn9-47-17-132.beaverton.ibm.com") by vger.kernel.org with ESMTP
	id S263156AbTDRRWV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Apr 2003 13:22:21 -0400
Date: Fri, 18 Apr 2003 10:30:31 -0700
From: Patrick Mansfield <patmans@us.ibm.com>
To: Christian Staudenmayer <eggdropfan@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel panic with 2.5.67-ac1
Message-ID: <20030418103031.A9260@beaverton.ibm.com>
References: <20030418171806.2042.qmail@web41813.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030418171806.2042.qmail@web41813.mail.yahoo.com>; from eggdropfan@yahoo.com on Fri, Apr 18, 2003 at 10:18:06AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 18, 2003 at 10:18:06AM -0700, Christian Staudenmayer wrote:
> Note: this does not happen with 2.4.20, 2.4.21-pre7, 2.4.21-pre7-ac1 or 2.5.67-bk8
> It does, however happen with 2.5.67-ac2, but the error message is some lines longer
> and some of the addresses have changed.
> 
> I'd be really grateful for any insight on this problem.

We were plugging a queue that was about to be freed during scsi scan.

This is fixed in bk8, here is a snippit of part of the patch to scsi_lib.c
that fixed the problem, or look at the end of scsi_prep_fn, (plus the
corresponding call to blk_plug_device was removed from scsi_request_fn):

+ defer:
+       /* If we defer, the elv_next_request() returns NULL, but the
+        * queue must be restarted, so we plug here if no returning
+        * command will automatically do that. */
+       if (sdev->device_busy == 0)
+               blk_plug_device(q);
+       return BLKPREP_DEFER;
+}

-- Patrick Mansfield
