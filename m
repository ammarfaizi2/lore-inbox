Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275552AbRJYRCy>; Thu, 25 Oct 2001 13:02:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275680AbRJYRCj>; Thu, 25 Oct 2001 13:02:39 -0400
Received: from [64.92.133.94] ([64.92.133.94]:24333 "HELO boxxtech.com")
	by vger.kernel.org with SMTP id <S275552AbRJYRCU> convert rfc822-to-8bit;
	Thu, 25 Oct 2001 13:02:20 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.4417.0
content-class: urn:content-classes:message
Subject: 2.4.13-pre5-aa1 O_DIRECT drastic HIGHMEM performance hit
Date: Thu, 25 Oct 2001 11:57:08 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-ID: <3B6867E6CB09B24385A73719A50C7C9A01797E@athena.boxxtech.com>
Thread-Topic: 2.4.13-pre5-aa1 O_DIRECT drastic HIGHMEM performance hit
Thread-Index: AcFddkFxhmzWfcldEdW/cQCQJ5vCsg==
From: "Marvin Justice" <Mjustice@boxxtech.com>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We're looking into setting up an HD video editing solution with the
following hardware:

dual 1GHz P3, 2GB RAM
Serverworks HeSL based board
dual U160 Adaptec SCSI card
5 68gb Fujitsu drives on each SCSI channel

The 10 drives are software raid0 striped with a 68k chunk size. For an
initial benchmark I got a copy of lmdd and modified it to open files
using O_DIRECT (also hacked it to work on W2K with FILE_FLAG_NO_BUFFER).
Here are the average results in MB/sec for 2.4.13-pre5-aa1 streaming
chunks of data 4MB at a time to RAM where they are immediately
discarded:

                     w           r
no O_DIRECT         136         132
O_DIRECT            111          96

I experimented around a bit and discovered that increasing
KIO_MAX_ATOMIC_IO from 512 to 4096 gave a significant performance boost
for the O_DIRECT read case:
                     w           r
no O_DIRECT         117         124
O_DIRECT            111         165


Next I recompiled without HIGHMEM support and was quite suprised
(numbers are with KIO_MAX_ATOMIC_IO=4096)

                     w           r
no O_DIRECT         138         125
O_DIRECT            221         182

XFS shows similar behavior: (XFS barfs if you change KIO_MAX_ATOMIC_IO
from 512)

                           w         r
O_DIRECT w/ HIGHMEM       114       146
O_DIRECT w/o HIGHMEM      218       248


(Incidentally, W2k reads and writes at a smooth 255 MB/sec on identical
hardware.) 

Are we stuck with a low mem configuration or are there workarounds that
would allow us to stick with the initial 2GB of RAM and still get ~200
MB/sec.
 


--------------------------
Marvin Justice
Software Developer
BOXX Technologies, Inc.
www.boxxtech.com
mjustice@boxxtech.com
(V) (512)225-6318
(F) (512)835-0434
