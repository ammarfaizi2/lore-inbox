Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316997AbSEWTwq>; Thu, 23 May 2002 15:52:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316999AbSEWTwp>; Thu, 23 May 2002 15:52:45 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:37901 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S316997AbSEWTwn>;
	Thu, 23 May 2002 15:52:43 -0400
Message-ID: <3CED4843.2783B568@zip.com.au>
Date: Thu, 23 May 2002 12:51:31 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "chen, xiangping" <chen_xiangping@emc.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Poor read performance when sequential write presents
In-Reply-To: <FA2F59D0E55B4B4892EA076FF8704F553D1A7A@srgraham.eng.emc.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"chen, xiangping" wrote:
> 
> Hi,
> 
> I did a IO test with one sequential read and one sequential write
> to different files. I expected somewhat similar throughput on read
> and write. But it seemed that the read is blocked until the write
> finishes. After the write process finished, the read process slowly
> picks up the speed. Is Linux buffer cache in favor of write? How
> to tune it?
> 

Reads and writes are very different beasts - writes deal with
the past and have good knowledge of what to do.  But reads
must predict the future.

You need to do two things:

1: Configure the device for a really big readahead window.

   Configuring readahead in 2.4 is a pig.  Try one of the
   following:

     echo file_readahead:N > /proc/ide/hda/settings   (N is kilobytes)
     blockdev --setra M /dev/hda                      (M is in 512 byte sectors)
     echo K > /prov/sys/vm/max-readahead              (K is in pages - 4k on x86)

   You'll find that one of these makes a difference.

2: Apply http://www.zip.com.au/~akpm/linux/patches/2.4/2.4.19-pre5/read-latency2.patch
   which will prevent reads from being penalised by writes.
   Or use a -ac kernel, which already has this patch.

-
