Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263285AbTFDMm0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 08:42:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263293AbTFDMm0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 08:42:26 -0400
Received: from web9602.mail.yahoo.com ([216.136.129.181]:44855 "HELO
	web9602.mail.yahoo.com") by vger.kernel.org with SMTP
	id S263285AbTFDMmZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 08:42:25 -0400
Message-ID: <20030604125554.95340.qmail@web9602.mail.yahoo.com>
Date: Wed, 4 Jun 2003 05:55:54 -0700 (PDT)
From: Steve G <linux_4ever@yahoo.com>
Subject: Re: Swapoff w/regular file causes Oops
To: daniel.sobe@epost.de
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200305260630.39443.daniel.sobe@epost.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Well, I had this problem when using RH8, but using kernel
>2.4.20-8 from RH9.

OK, I've investigated this further. It seems that all Red
Hat 2.4.18 kernels are immune to the swapoff problem. All
2.4.20 kernels (include the brand new one) have this bug. I
don't think anyone has tried the program I sent since it
would have caused an Oops and you'd see what I mean. I
don't think this is a Red Hat problem either, I think this
is generic to recent kernels.

Looking at the source for 2.4.20 kernel mm/swapfile.c
sys_swapoff function, the bug goes like this...swapoff
checks permissions, this is OK, it then gets the nameidata
entry for the filename, it checks to see if the file is on
the swap list, but its not (remember mkswap was never
called). err is set to -EINVAL and it jumps to out_dput
line 792. The kernel is unlocked and path_release() is
called (fs/namei.c line 253).

path_release() will unmount the entry and this is where the
Oops occurs. It was never mounted. It is simply a regular
file. It seems like there should be some check if err ==
-EINVAL that the file is in fact mounted. Looking at
__mntput (which is an inline function & maybe that's why
its not in the Oops call stack), it implicitly trusts that
the mnt parameter is not NULL & is valid. dput() at least
checks for NULL and does nothing.

I'm not too familiar with the kernel internals, but maybe
someone else can take what I've said and figure out the
right fix.

Best Regards,
-Steve Grubb


__________________________________
Do you Yahoo!?
Yahoo! Calendar - Free online calendar with sync to Outlook(TM).
http://calendar.yahoo.com
