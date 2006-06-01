Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751780AbWFAFGK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751780AbWFAFGK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 01:06:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751783AbWFAFGK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 01:06:10 -0400
Received: from fep30-0.kolumbus.fi ([193.229.0.32]:28597 "EHLO
	fep30-app.kolumbus.fi") by vger.kernel.org with ESMTP
	id S1751780AbWFAFGI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 01:06:08 -0400
Date: Thu, 1 Jun 2006 08:05:49 +0300 (EEST)
From: Kai Makisara <Kai.Makisara@kolumbus.fi>
X-X-Sender: makisara@kai.makisara.local
To: James Bottomley <James.Bottomley@SteelEye.com>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
cc: linux-scsi <linux-scsi@vger.kernel.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PATCH] scsi bug fixes for 2.6.17-rc5
In-Reply-To: <1149092818.22134.45.camel@mulgrave.il.steeleye.com>
Message-ID: <Pine.LNX.4.63.0606010757400.4387@kai.makisara.local>
References: <1149092818.22134.45.camel@mulgrave.il.steeleye.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 May 2006, James Bottomley wrote:

> This is my current slew of small bug fixes which either fix serious
> bugs, or are completely safe for this -rc5 stage of the kernel.  I've
> added one more since I last sent you this pull request (the fix memory
> building non-aligned sg lists)
> 
> The patch is available from:
> 
> master.kernel.org:/pub/scm/linux/kernel/git/jejb/scsi-rc-fixes-2.6.git
> 
> The short changelog is:
> 
> Bryan Holty:
>   o fix memory building non-aligned sg lists
> 
I looked at 
www.kernel.org/git/?p=linux/kernel/git/jejb/scsi-rc-fixes-2.6.git;.

This patch does the following change:

- int nr_pages = (bufflen + PAGE_SIZE - 1) >> PAGE_SHIFT;
+ int nr_pages = PAGE_ALIGN(bufflen + sgl[0].offset);

This seems to wrong: the new version is missing the right shift. For 
instance, offset=0 and bufflen=4096 results in 4096 and not 1!

(Using asm-x86_64, the new version translates to
((bufflen + sgl[0].offset+PAGE_SIZE-1)&(~(PAGE_SIZE-1)))
)

According to the original patch by Brian, the change should probably have 
been to (or something equivalent):

+       int nr_pages = (bufflen + sgl[0].offset + PAGE_SIZE - 1) >> 
PAGE_SHIFT;

This was tested by several people. Did anyone test the version put into 
scsi-rc-fixes-2.6.git?

-- 
Kai
