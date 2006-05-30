Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932207AbWE3SZE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932207AbWE3SZE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 14:25:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932298AbWE3SZE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 14:25:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:38104 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932207AbWE3SZC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 14:25:02 -0400
Date: Tue, 30 May 2006 20:24:53 +0200
From: Olaf Hering <olh@suse.de>
To: linux-kernel@vger.kernel.org, Al Viro <viro@ftp.linux.org.uk>
Subject: Re: cramfs corruption after BLKFLSBUF on loop device
Message-ID: <20060530182453.GA8701@suse.de>
References: <20060529214011.GA417@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20060529214011.GA417@suse.de>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Mon, May 29, Olaf Hering wrote:

> This script will cause cramfs decompression errors, on SMP at least:
> 
> #!/bin/bash
> while :;do blockdev --flushbufs /dev/loop0;done </dev/null &>/dev/null&
> while :;do ps faxs  </dev/null &>/dev/null&done </dev/null &>/dev/null&
> while :;do dmesg    </dev/null &>/dev/null&done </dev/null &>/dev/null&
> while :;do find /mounts/instsys -type f -print0|xargs -0 cat &>/dev/null;done
> 
> ...
> Error -3 while decompressing!
> c0000000009592a2(2649)->c0000000edf87000(4096)
> Error -3 while decompressing!
> c000000000959298(2520)->c0000000edbc7000(4096)
> Error -3 while decompressing!
> c000000000959c70(2489)->c0000000f1482000(4096)
> Error -3 while decompressing!
> c00000000095a629(2355)->c0000000edaff000(4096)
> Error -3 while decompressing!
> ...
> 
> evms_access does the ioctl (lots of them) on the loop device.
> Its a long standing bug, 2.6.5 fails as well. cramfs_read() clears parts
> of the src buffer because the page is not uptodate. invalidate_bdev()
> touched the page last.
> cramfs_read() was called from line 480 or 490 when the
> PageUptodate(page) test fails.

Al, you added the PageUptodate check for 2.6.2.

http://linux.bkbits.net:8080/linux-2.6/gnupatch@400c1cddyzRoKomOj57xxUAmKnMbZQ

Should there be some locking for blockdev --flushbufs, or is the check
just bogus? 
