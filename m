Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261989AbVCARfx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261989AbVCARfx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 12:35:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261987AbVCARfx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 12:35:53 -0500
Received: from mail.codeweavers.com ([216.251.189.131]:696 "EHLO
	mail.codeweavers.com") by vger.kernel.org with ESMTP
	id S261989AbVCARfo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 12:35:44 -0500
Message-ID: <4224A7E9.2070204@codeweavers.com>
Date: Tue, 01 Mar 2005 11:35:37 -0600
From: Jeremy White <jwhite@codeweavers.com>
User-Agent: Debian Thunderbird 1.0 (X11/20050118)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Content-Type: multipart/mixed;
 boundary="------------060306080209080207080907"
X-SA-Exim-Connect-IP: 216.251.189.140
X-SA-Exim-Mail-From: jwhite@codeweavers.com
Subject: Apparent bug in sound/oss/via82cxxx_audio.c GETOPTR ioctl
X-SA-Exim-Version: 4.2 (built Tue, 25 Jan 2005 19:36:50 +0100)
X-SA-Exim-Scanned: Yes (on mail.codeweavers.com)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060306080209080207080907
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

In trying to fix Wine's dsound implementation which uses mmap and
DSP_SND_GETOPTR to write data out to the driver, I uncovered what
appears to be a bug in the via82cxx_audio.c driver.

Specifically, via_sg_offset appears to return the number of bytes
not yet consumed within the current block; we use it to adjust from blocks
to a precise block count.  However, it appears as though it returns 0
to indicate that no bytes have been consumed.

I was seeing results where I would get an OPTR return along the
lines of 0x1c00, 0x1e00, 0x2800, and then 0x2100.  Needless to say,
having info.ptr go backwards causes Wine's code to have a serious
hissy fit.

The attached patch fixes the problem for me, but I would appreciate
review by an expert on this.

Cheers,

Jeremy

--------------060306080209080207080907
Content-Type: text/x-patch;
 name="via82cxxx_audio.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="via82cxxx_audio.diff"

--- via82cxxx_audio.c	2005-03-01 11:27:07.525265232 -0600
+++ via82cxxx_audio.c.orig	2005-03-01 11:27:24.700654176 -0600
@@ -2831,8 +2831,6 @@
 		unsigned long extra;
 		info.ptr = atomic_read (&chan->hw_ptr) * chan->frag_size;
 		extra = chan->frag_size - via_sg_offset(chan);
-                if (extra == chan->frag_size)
-                    extra = 0;
 		info.ptr += extra;
 		info.bytes += extra;
 	} else {

--------------060306080209080207080907--
