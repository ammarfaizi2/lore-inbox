Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751252AbWIUGBl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751252AbWIUGBl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 02:01:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751251AbWIUGBl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 02:01:41 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:15234 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S1751249AbWIUGBk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 02:01:40 -0400
Date: Thu, 21 Sep 2006 10:00:44 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Ashwini Kulkarni <ashwini.kulkarni@intel.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       christopher.leech@intel.com
Subject: Re: [RFC 0/6] TCP socket splice
Message-ID: <20060921060044.GA23532@2ka.mipt.ru>
References: <20060920210711.17480.92354.stgit@gitlost.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20060920210711.17480.92354.stgit@gitlost.site>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Thu, 21 Sep 2006 10:00:45 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 20, 2006 at 02:07:11PM -0700, Ashwini Kulkarni (ashwini.kulkarni@intel.com) wrote:
> Using TCP socket splice:
> 
>                     Application Control
>                          |
>         _________________|__________________________________
>                          |
>                          |   TCP socket splice
>                          | +---------------------+
>                          | |     Direct path     |
>                          V |                     V
>                        Network              File System
>                        Buffer                  Buffer
>                          ^                       |
>                          |                       |
>         _________________|_______________________|__________
>                      DMA |                       | DMA
>                          |                       |
>        Hardware          |                       |
>                          |                       V
>                         NIC                     SATA
>                                                                     
> In this method, the objective is to use TCP socket splicing to create a direct
> path in the kernel from the network buffer to the file system buffer via a pipe
> buffer. The pages will migrate from the network buffer (which is associated
> with the socket) into the pipe buffer for an optimized path. From the pipe
> buffer, the pages will then be migrated to the output file address space page
> cache. This will enable to create a LAN to file-system API which will avoid the
> memcpy operations in user space and thus create a fast path from the network
> buffer to the storage buffer.
> 
> Open Issues (currently being addressed):
> There is a performance drop when transferring bigger files (usually larger than
> 65536 bytes in size). Performance drop increases with the size of the file.
> Work is in progress to identify the source of this issue.
> 
> We encourage the community to review our TCP socket splice project. Feedback
> would be greatly appreciated.

First of all it is not zero-copy, most of the time when mtu is not
changed skb does not have fragments, which means that you need to copy,
and you do it in skb_splice_bits() after skb_headlen() check.

Additionally to copy you add kmap/kunmap overhead, which can be very
noticeble. I would not be surprised that exactly that part introduces
described above performance drop compared to copy_*_user() approach. 
Did you checked it with (hacked) drivers, which put data into fragment
list? Could you post your benchamrks.

And your coding style is broken noticebly...
Also do not check for every possible error case, negative return value
always meant error, otherwise it is ok in your case to proceed.

> --
> Ashwini Kulkarni

-- 
	Evgeniy Polyakov
