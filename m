Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267038AbTBXUAV>; Mon, 24 Feb 2003 15:00:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267132AbTBXUAV>; Mon, 24 Feb 2003 15:00:21 -0500
Received: from phoenix.infradead.org ([195.224.96.167]:2061 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S267038AbTBXUAU>; Mon, 24 Feb 2003 15:00:20 -0500
Date: Mon, 24 Feb 2003 20:10:30 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Linus Torvalds <torvalds@transmeta.com>, pam.delaney@lsil.com
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.63
Message-ID: <20030224201030.A13503@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Linus Torvalds <torvalds@transmeta.com>, pam.delaney@lsil.com,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0302241127050.13335-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0302241127050.13335-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Mon, Feb 24, 2003 at 11:32:07AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> <pam.delaney@lsil.com>:
>   o Fusion Driver 2.05.00.03 against 2.5.62bk3

This update is broken and strange in many ways, it would have been
nice if you actually sent this to some list for review before submitting..

(1) there's stuff like:

#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,58)
#define mpt_inc_use_count()
#define mpt_dec_use_count()
#else
#define mpt_inc_use_count() MOD_INC_USE_COUNT
#define mpt_dec_use_count() MOD_DEC_USE_COUNT
#endif

but even if the old-style refcounting is deprecated now you can't
just simply remove it!  you need to rearchitecture your code to
work with try_module_get/module_put

(2) and like this:

+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,59)
 MODULE_PARM(PortIo, "0-1i");
 MODULE_PARM_DESC(PortIo, "[0]=Use mmap, 1=Use port io");
+#endif

Again. just because old-style module paramters are deprecated you can't
just remove them without replacement, use module_param() instead.

(3) you remove backward copatiblity code in one place but add lots more
    in other places.  this doesn't make sense - either you have a nice or
    all releases driver, but not one that doesn't work everywhere _and_ looks
    horrible.


