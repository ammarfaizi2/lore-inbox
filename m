Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271878AbRIEITt>; Wed, 5 Sep 2001 04:19:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271877AbRIEITk>; Wed, 5 Sep 2001 04:19:40 -0400
Received: from imo-m08.mx.aol.com ([64.12.136.163]:8148 "EHLO
	imo-m08.mx.aol.com") by vger.kernel.org with ESMTP
	id <S271827AbRIEITe>; Wed, 5 Sep 2001 04:19:34 -0400
From: Floydsmith@aol.com
Message-ID: <32.1a68e8e6.28c739c9@aol.com>
Date: Wed, 5 Sep 2001 04:18:17 EDT
Subject: Re3: idetape broke in 2.4.x-2.4.9-ac5 (write OK but not read) 
To: mikpe@csd.uu.se, zaitcev@redhat.com
CC: linux-kernel@vger.kernel.org, linux-tape@vger.kernel.org,
        Floydsmith@aol.com, floyd.smith@lmco.com
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: AOL 4.0 for Windows 95 sub 14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>> - block size: The 2.4 ide-tape driver only works reliably if you
>>>   write data with the correct block size. If you don't write full
>>>   blocks the last block of data may not be readable.
>>
>>I fixed that some time ago, it's in current -ac
>>if not in Linus's tree.

>Sorry, but that's not correct. I just ran a test, and the bug is
>still there in 2.4.9-ac7. Maybe you're thinking of some other bug?

>ide-tape tells me it uses a 14*26KB buffer for my Seagate STT8000A.
>If I dd a 39KB (1.5 "buffer units") file with bs=1k to /dev/ht0 it tells
>me it wrote 39 blocks. If I then rewind and dd with bs=1k from /dev/ht0
>it only reads 26 blocks. The same happens in 2.2 + Hedrick's IDE patch.

>2.2 vanilla reads 56 blocks, of which the first 39 are identical to
>what I initially wrote. The last 13 contain junk but that's not a big
>problem since I back up with tar which writes its own EOF mark.
>./Mikael
>-

The output is:
ide-tape: ht0: I/O error, pc =  8, key =  5, asc = 2c, ascq =  0
for reads only.
As noted earlier, this problem occurs in 2.4.x (only) even with a very small 
test file (just the 5 character "test"). Upon sprinkling some "printk" 
statements arround in ide-tape.c I found that what happens with this error 
(under 2.4.x) is:
    if (tape->failed_pc != NULL && tape->pc->c[0] == 
IDETAPE_REQUEST_SENSE_CMD) {
        return idetape_issue_packet_command (drive, tape->failed_pc);
    }
invokes idetape_issue_packet_command (...) three times in idetape_do_request 
(...) which causes an abort in idetape_issue_packet_command (...) when 
pc->retries reaches 4.
I don't get ANY retries with the same test case under 2.2.x.

Is there any way I can find out what the error return value asc = 2c 
represents? For example, is there a URL to a "standard" for such values?

Floyd,
