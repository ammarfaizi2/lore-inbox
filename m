Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292229AbSCXNK3>; Sun, 24 Mar 2002 08:10:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292855AbSCXNKK>; Sun, 24 Mar 2002 08:10:10 -0500
Received: from yellow.csi.cam.ac.uk ([131.111.8.67]:41114 "EHLO
	yellow.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S292229AbSCXNKB>; Sun, 24 Mar 2002 08:10:01 -0500
Message-Id: <5.1.0.14.2.20020324125307.02899da0@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Sun, 24 Mar 2002 13:10:58 +0000
To: pavel@suse.cz
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: NBD client/server broken?
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have been trying to get nbd to work, the server is 2.4.18-pre7-ac2 and 
the client is 2.5.7, and the exported device is /dev/hda1 a 15GiB partition.

I found and downloaded nbd.14.tar.gz. Is this the latest and greatest?

Compiling the package gives several warnings and indeed the nbd-server 
doesn't work. The size auto detection code is completely bogus because it 
submits 64 bit variables via their address to system calls which only take 
32 bit variables so you see silly things like

es = (u64)-1

turning into

es = 0xffffffff01d4b139

instead of

es = 0x000000000whatever

You either need to use 64 bit variants of the calls or you need to submit a 
32bit variable to the call, e.g. es32, and then expand it via es = (u64)es32.

So I got past this and fixed size detection for myself.

Now I get it to serve the first request but then it dies.

On the server I see:

[aia21@storm:~/nbd]$ ./nbd-server 5555 /dev/hda1 -r
Entering request loop!
1: *READ from 0 (0) len 4096, exp->buf, buf->net, +OK!
2: *[aia21@storm:~/nbd]$

And on the client I see:

[aia21@drop nbd]$ dd if=/dev/nd1 of=ffff bs=1024 count=8
NBD: receive - sock=-301251788 at buf=-65871580, size=16 returned 0.
NBD: Recv control failed.(result 0)
req should never be null
Kernel call returned.Closing: que, sock, done
NBD, minor 0: Request when not-ready.
dd: reading `/dev/nd0': Input/output error
4+0 records in
4+0 records out
[aia21@drop nbd]$

The contents of the 4kiB of data transmitted are correct so we are 
definitely on the right track but something seems to be aborting the 
request loop in the server program.

I will be looking into this as I _need_ this functionality very urgently 
but I thought I would ask in case I have an out of data package of the nbd 
utilities or someone has already fixed this and would like to share their 
code with me...

Best regards,

Anton


-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

