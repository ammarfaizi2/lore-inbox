Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265315AbUGMPjl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265315AbUGMPjl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 11:39:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265359AbUGMPjl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 11:39:41 -0400
Received: from rzfoobar.is-asp.com ([217.11.194.155]:1196 "EHLO mail.isg.de")
	by vger.kernel.org with ESMTP id S265315AbUGMPjh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 11:39:37 -0400
Message-ID: <40F40238.3080103@isg.de>
Date: Tue, 13 Jul 2004 17:39:36 +0200
From: Lutz Vieweg <lkv@isg.de>
Organization: Innovative Software AG
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040322 wamcom.org
X-Accept-Language: de, German, en
MIME-Version: 1.0
To: Michael Clark <michael@metaparadigm.com>
Cc: Robin Holt <holt@sgi.com>, linux-kernel@vger.kernel.org
Subject: Re: How to find out which pages were copied-on-write?
References: <40EACC0C.6060606@isg.de> <20040709113125.GA8897@lnx-holt.americas.sgi.com> <40EF0346.4040407@isg.de> <40EFA4C8.1050409@metaparadigm.com> <40F2C882.7070406@isg.de> <40F36216.1080603@metaparadigm.com> <40F3DDC4.7060104@isg.de> <40F3F993.6040602@metaparadigm.com>
In-Reply-To: <40F3F993.6040602@metaparadigm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Clark wrote:
> On 07/13/04 21:04, Lutz Vieweg wrote:
> 
>>> You don't use mmap for speed but rather for convenience.
>>
>> But isn't an advantage with mmap() that there's no need for the kernel
>> to copy what is to be written to a dedicated buffer? The kernel
>> could initiate DMA writes directly from the working memory...
> 
> Yes, but page faults are expensive too. Each time a page is written
> out it needs to be marked read only again and will cause a page fault
> for the next write access from userspace. For certain workloads this
> can easily add up to more than copy_(to|from)_user in read/write.

But I would need exactly the same number of pagefaults if I implemented
the "mark-dirty-on-write" logic in userspace using SIGSEGV and signal
handlers, as it is done by the LPSM software...

> read/write also gives you more explicit control on IO batching and
> scheduling (when to read or write). Less need for the kernel to employ
> tricks to effectively coaslesce IOs on dirtied pages or sense
> streaming access patterns.

But if the kernel would turn a private copy of a c-o-w page into a
"dirty"-page that is marked for writing out to disk, another process
could mmap() the very same page even before it has been written to disk,
while if I write out dirty pages using write() in userspace, other
processes probably won't notice before all the data has reached the disk,
which could take quite some time.

And unlike the user space application, the kernel knows which writes
go to which physical disk so it can e.g. make better use of striping.

Regards,

Lutz Vieweg



