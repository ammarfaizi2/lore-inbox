Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265470AbTANXGA>; Tue, 14 Jan 2003 18:06:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265484AbTANXGA>; Tue, 14 Jan 2003 18:06:00 -0500
Received: from packet.digeo.com ([12.110.80.53]:38786 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S265470AbTANXF7> convert rfc822-to-8bit;
	Tue, 14 Jan 2003 18:05:59 -0500
Content-Type: text/plain; charset=US-ASCII
From: Andrew Morton <akpm@digeo.com>
To: Brian Kelly <bkelly@sulaco.com>, linux-kernel@vger.kernel.org
Subject: Re: How to setup a buffer_head in a driver
Date: Tue, 14 Jan 2003 15:14:35 -0800
User-Agent: KMail/1.4.1
References: <200301142235.RAA23806@temetra.com>
In-Reply-To: <200301142235.RAA23806@temetra.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200301141514.35825.akpm@digeo.com>
X-OriginalArrivalTime: 14 Jan 2003 23:14:25.0851 (UTC) FILETIME=[AE45B8B0:01C2BC22]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 14 January 2003 02:35 pm, Brian Kelly wrote:
>
> Hi,
> I'm writing a device driver that among other things needs to write data,
> manufactured by the driver itself, to a block device.
> 
> I have this data in block sized kmalloc()'d chunks. So what I'm doing is
> allocating a struct buffer_head, initialising it, fill out it's various
> fields and send it to generic_make_request().

It's probably better to use submit_bh().  Set the BH_Lock and BH_Mapped bits,
also set up b_end_io.  Then do a wait_on_buffer(), wait for the IO to
complete.  There's some similar code in
fs/jbd/journal.c:journal_write_metadata_buffer().

However, what you're doing is an odd thing.  If there is already pagecache
against that block device then the kernel doesn't know that you've changed
the bytes on-disk and will cheerfully proceed to use (and write out) the
cached data.  You'll lose your modifications..

It would be better to use sb_getblk() or bread(), to lock the returned
buffer_head, then copy your data into it and to then write it back with
submit_bh() or ll_rw_block().  Or just leave it dirty and let the kernel
write it out in due course.



