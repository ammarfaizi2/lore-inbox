Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261652AbVBHUKD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261652AbVBHUKD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Feb 2005 15:10:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261654AbVBHUIh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Feb 2005 15:08:37 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:51630 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261653AbVBHUIC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Feb 2005 15:08:02 -0500
Date: Tue, 8 Feb 2005 14:08:01 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Valdis.Kletnieks@vt.edu
Cc: Michael Halcrow <mhalcrow@us.ibm.com>, Chris Wright <chrisw@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] BSD Secure Levels: claim block dev in file struct rather than inode struct, 2.6.11-rc2-mm1 (3/8)
Message-ID: <20050208200801.GA2444@IBM-BWN8ZTBWA01.austin.ibm.com>
References: <20050207192108.GA776@halcrow.us> <20050207193129.GB834@halcrow.us> <20050207142603.A469@build.pdx.osdl.net> <20050208172450.GA3598@halcrow.us> <200502081747.j18Hlt54012728@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200502081747.j18Hlt54012728@turing-police.cc.vt.edu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Valdis.Kletnieks@vt.edu (Valdis.Kletnieks@vt.edu):
> On Tue, 08 Feb 2005 11:24:50 CST, Michael Halcrow said:
> 
> > While the program is waiting for a keystroke, mount the block device.
> > Enter a keystroke.  The result without the patch is 1, which is a
> > security violation.  This occurs because the bd_release function will
> > bd_release(bdev) and set inode->i_security to NULL on the close(fd1).
> 
> Sounds like a bug, not a feature.  Should it be zeroing out inode->i_security
> for an inode with a non-zero reference count?

Valdis,

inode->i_security is no longer used after the patch.  Does your question
still apply with the proposed patch, %s/inode->i_security/file->f_security/?

Nevertheless, note that the thing being enforced is "no simultaneous
write access to a block device and mount of that block device."  The
file->f_security is just used as a flag to seclvl that when this file
is closed, we can bd_release the device to allow a mount or another
open(O_RDWR) of the file.  So references to the inode don't matter,
provided the other references are read accesses.  Which they have to
be, since otherwise the seclvl_bd_claim() would have failed on the
second open(O_RDWR) call.

I hope I'm at least remotely answering your question :)

-serge

