Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262216AbVCIGaf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262216AbVCIGaf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 01:30:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262324AbVCIGae
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 01:30:34 -0500
Received: from fire.osdl.org ([65.172.181.4]:25038 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262216AbVCIG2J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 01:28:09 -0500
Date: Tue, 8 Mar 2005 22:27:37 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: linux-kernel@vger.kernel.org, axboe@suse.de
Subject: Re: Direct io on block device has performance regression on 2.6.x
 kernel
Message-Id: <20050308222737.3712611b.akpm@osdl.org>
In-Reply-To: <200503090139.j291dfg16356@unix-os.sc.intel.com>
References: <200503090139.j291dfg16356@unix-os.sc.intel.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Chen, Kenneth W" <kenneth.w.chen@intel.com> wrote:
>
> Direct I/O on block device running 2.6.X kernel is a lot SLOWER
>  than running on a 2.4 Kernel!
> 

A little bit slower, it appears.   It used to be faster.

> ...
> 
>  			synchronous I/O			AIO
>  			(pread/pwrite/read/write)	io_submit
>  2.4.21 based
>  (RHEL3)		265,122				229,810
> 
>  2.6.9			218,565				206,917
>  2.6.10		213,041				205,891
>  2.6.11		212,284				201,124

What sort of CPU?

What speed CPU?

What size requests?

Reads or writes?

At 5 usecs per request I figure that's 3% CPU utilisation for 16k requests
at 100 MB/sec.

Once you bolt this onto a real device driver the proportional difference
will fall, due to addition of the constant factor.

Once you bolt all this onto a real disk controller all the numbers will get
worse (but in a strictly proportional manner) due to the disk transfers
depriving the CPU of memory bandwidth.

The raw driver is deprecated and we'd like to remove it.  The preferred way
of doing direct-IO against a blockdev is by opening it with O_DIRECT.

Your patches don't address blockdevs opened with O_DIRECT.  What you should
do is to make def_blk_aops.direct_IO point at a new function.  That will
then work correctly with both raw and with open(/dev/hdX, O_DIRECT).


But before doing anything else, please bench this on real hardware, see if
it is worth pursuing.  And gather an oprofile trace of the existing code.


