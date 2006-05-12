Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750995AbWELGjE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750995AbWELGjE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 02:39:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750999AbWELGjE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 02:39:04 -0400
Received: from embla.aitel.hist.no ([158.38.50.22]:25786 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S1750995AbWELGjC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 02:39:02 -0400
Message-ID: <44642CBD.4000305@aitel.hist.no>
Date: Fri, 12 May 2006 08:35:41 +0200
From: Helge Hafting <helge.hafting@aitel.hist.no>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?UTF-8?B?RGlldGVyIFN0w7xrZW4=?= <stueken@conterra.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: ext3 metadata performace
References: <4463461C.3070201@conterra.de>
In-Reply-To: <4463461C.3070201@conterra.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dieter Stüken wrote:

> after I switched from from ext2 to ext3 i observed some severe 
> performance degradation. Most discussion about this topic deals
> with tuning of data-io performance. My problem however is related to 
> metadata updates. When cloning (cp -al) or deleting directory trees I 
> find, that about 7200 files are created/deleted per minute. Seems
> this is related to some ex3 strategy, to wait for each metadata to be
> written to disk. Interestingly this occurs with my new hw-raid
> controller (3ware 9500S), which even has an battery buffered disk cache.
> Thus there is no need for synchronous IO anyway. If I disable the
> disk cache on my plain SATA disk using ext3, I also get this behavior.
>
> Would it be make sense for ext3, to disable synchronous writes even
> for metadata (similar to the "data=writeback" option)? This means, that
> ext3 won't protect the (meta) data currently written. This is needed
> if running a database or an email server, where the process performing
> the IO must be sure, the data is definitely on disk, if it returns form
> the system call. In most cases, however, you choose ex3 to ensure the
> consistency of your file system after a crash, to avoid an fsck.
> If some files, created just before the crash, vanish, does not hurt
> me too much.

Turning off synchronous writes like this won't work!
The battery-backed cache can help you in that you can consider
data "written" once it is transferred to that cache.  Metadata must still
go synchronously into the cache though, or you get a broken fs
if ever your machine crash in the middle of a transaction. (Leaving
an update halfway in that battery cache, and halfway in main memory.
Then main memory dies from the power cut / reboot.)

The caching controller should report back to the linux device driver
that "data is committed" as soon as it hits the cache - no need to
wait for it to actually hit the platters.  This can help performance with
bursty writes tremendously - but it won't help you with long-lasting writes
as you will then be limited by platter speed as soon as the battery cache
is completely full.

Helge Hafting



