Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262751AbUJ1ESW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262751AbUJ1ESW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 00:18:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262752AbUJ1ESV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 00:18:21 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:59030 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262751AbUJ1ESP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 00:18:15 -0400
Message-ID: <418072F9.2020004@pobox.com>
Date: Thu, 28 Oct 2004 00:18:01 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
CC: Linux Kernel <linux-kernel@vger.kernel.org>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Douglas Gilbert <dougg@torque.net>, Jens Axboe <axboe@suse.de>,
       William Lee Irwin III <wli@holomorphy.com>
Subject: Re: [PATCH 2.4] the perils of kunmap_atomic
References: <417EDE4C.20003@pobox.com> <20041027161936.GC1081@logos.cnet>
In-Reply-To: <20041027161936.GC1081@logos.cnet>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti wrote:
> On Tue, Oct 26, 2004 at 07:31:24PM -0400, Jeff Garzik wrote:
> 
>>kunmap_atomic() violates the Principle of Least Surprise in a nasty way. 
>>   kmap(), kunmap(), and kmap_atomic() all take struct page* to 
>>reference the memory location.  kunmap_atomic() is the oddball of the 
>>three, and takes a kernel address.
>>
>>Ignoring the driver-related bugs that are present due to 
>>kunmap_atomic()'s weirdness, there also appears to be a big in the 
>>!CONFIG_HIGHMEM implementation in 2.4.x.
>>
>>(Bart is poking through some of the 2.6.x-related kunmap_atomic slip-ups)
>>
>>Anyway, what do people think about the attached patch to 2.4.x?  I'm 
>>surprised it has gone unnoticed until now.
>>
>>	Jeff
>>
>>===== include/linux/highmem.h 1.12 vs edited =====
>>--- 1.12/include/linux/highmem.h	2003-06-30 20:18:42 -04:00
>>+++ edited/include/linux/highmem.h	2004-10-26 19:26:14 -04:00
>>@@ -70,7 +70,7 @@
>> #define kunmap(page) do { } while (0)
>> 
>> #define kmap_atomic(page,idx)		kmap(page)
>>-#define kunmap_atomic(page,idx)		kunmap(page)
>>+#define kunmap_atomic(addr,idx)		kunmap(virt_to_page(addr))
>> 
>> #define bh_kmap(bh)			((bh)->b_data)
>> #define bh_kunmap(bh)			do { } while (0)
> 
> 
> Ugh :(

Actually, a private email to me pointed out the obvious...  kmap/kunmap 
are no-ops on !CONFIG_HIGHMEM, so it's really a cosmetic bug, and my 
patch won't fix anything but human confusion :)


> An audit of kunmap_atomic() users is needed.

agreed

	Jeff


