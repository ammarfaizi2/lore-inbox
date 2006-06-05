Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1751229AbWFERNk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751229AbWFERNk (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 13:13:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751231AbWFERNk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 13:13:40 -0400
Received: from wildsau.enemy.org ([193.170.194.34]:16796 "EHLO
	wildsau.enemy.org") by vger.kernel.org with ESMTP id S1751229AbWFERNj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 13:13:39 -0400
From: Herbert Rosmanith <kernel@wildsau.enemy.org>
Message-Id: <200606051708.k55H84dC010037@wildsau.enemy.org>
Subject: Re: UDF: buggy? libdvdread vs. udf fs driver
In-Reply-To: <200606051300.k55D0lXE009972@wildsau.enemy.org>
To: Herbert Rosmanith <kernel@wildsau.enemy.org>
Date: Mon, 5 Jun 2006 19:08:04 +0200 (MET DST)
CC: linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL100 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> ok, at least I managed to get a Dir.Length > 0 using long or short "ad"
> instead of inicb -- whatever that means. "AD" like "allocation descriptor"?
> long or short ADs, or ADs in the INICB? what exactly does that mean?
> 
> so:
> 
>         mkudffs --ad=long --noefe 24M
> or:     mkudffs --ad=short --noefe 24M
> 
> will get me a step further, but UDFFindFile will now fail at some other place.

back again ...

I've made an observation which I think is somewhat strange ...

(1) make udf filesystem on loopbackimage
    bash-2.05# dd if=/dev/zero of=24M bs=1M count=24
    24+0 records in
    24+0 records out
    bash-2.05# mkudffs --vid="The Entropy Movie" --udfrev=0x0102 --ad=short --noefe 24M
    start=0, blocks=16, type=RESERVED 
    start=16, blocks=3, type=VRS 
    start=19, blocks=237, type=USPACE 
    start=256, blocks=1, type=ANCHOR 
    start=257, blocks=16, type=PVDS 
    start=273, blocks=1, type=LVID 
    start=274, blocks=11757, type=PSPACE 
    start=12031, blocks=1, type=ANCHOR 
    start=12032, blocks=239, type=USPACE 
    start=12271, blocks=16, type=RVDS 
    start=12287, blocks=1, type=ANCHOR 
    bash-2.05# mount -o loop 24M /mnt
    bash-2.05# dmesg
    UDF-fs INFO UDF 0.9.8.1 (2004/29/09) Mounting volume 'The Entropy Movie', timestamp 2006/06/05 19:02 (1078)
    bash-2.05# df
    Filesystem           1K-blocks      Used Available Use% Mounted on
    /dev/hda3              1011960    700312    260240  73% /
    /dev/hda4            152640480  60730108  84156600  42% /data
    /data/root/src/24M       23514        12     23502   1% /mnt

(2) /mnt contains:
    bash-2.05# find /mnt
    /mnt
    /mnt/lost+found

(3) libdvdread will now ...
    bash-2.05# ogle 24M 
    libdvdread: Using libdvdcss version 1.2.9 for DVD access
    > UDFFindFile filename=/VIDEO_TS/VIDEO_TS.IFO
      UDFFindFile:856
    > UDFMapICB
    > UDFFileEntry
      ad->Length=0
      L_EA=0 L_AD=8
      before switch: ad->Length=0
      flags=0000
      flags=>UDFShortAD
      after switch: ad->Length=92
    < UDFFileEntry, ad->Length=92
    < UDFMapICB:530, return 1(ok)
      887: File.length=92 token=VIDEO_TS
    > UDFScanDir (1) Dir.Length=92 (2) FileName=VIDEO_TS
      UDFScanDir:595
      enter while: Dir.Length=92
      TagID=257 101
      filename=
      TagID=257 101
      filename=lost+found
    X UDFScanDir:638

    .... will now stop after arriving at the lost+found directory.
    please noteice "ad->Length=92".

(4) now, create dvd-files:
    bash-2.05# mount -o loop 24M /mnt
    bash-2.05# dvdauthor -o /mnt -x foo.xml 
    DVDAuthor::dvdauthor, version 0.6.11.
    ...
    INFO: dvdauthor creating table of contents
    INFO: Scanning /mnt/VIDEO_TS/VTS_01_0.IFO

(5) the image now contains:
    bash-2.05# find /mnt
    /mnt
    /mnt/lost+found
    /mnt/VIDEO_TS
    /mnt/VIDEO_TS/VTS_01_1.VOB
    /mnt/VIDEO_TS/VTS_01_0.IFO
    /mnt/VIDEO_TS/VTS_01_0.BUP
    /mnt/VIDEO_TS/VIDEO_TS.IFO
    /mnt/VIDEO_TS/VIDEO_TS.BUP
    /mnt/AUDIO_TS

(6) but this is what libdvdread sees:
    bash-2.05# umount  /mnt
    bash-2.05# ogle 24M 
    libdvdread: Using libdvdcss version 1.2.9 for DVD access
    > UDFFindFile filename=/VIDEO_TS/VIDEO_TS.IFO
      UDFFindFile:856
    > UDFMapICB
    > UDFFileEntry
      ad->Length=0
      L_EA=0 L_AD=8
      before switch: ad->Length=0
      flags=0000
      flags=>UDFShortAD
      after switch: ad->Length=92
    < UDFFileEntry, ad->Length=92
    < UDFMapICB:530, return 1(ok)
      887: File.length=92 token=VIDEO_TS
    > UDFScanDir (1) Dir.Length=92 (2) FileName=VIDEO_TS
      UDFScanDir:595
      enter while: Dir.Length=92
      TagID=257 101
      filename=
      TagID=257 101
      filename=lost+found
    X UDFScanDir:638

    strange - Dir.Length is still 92, same as above in (3), and
    libdvdread will stop after reading "lost+found".

(7) remove lost+found and try again:
    bash-2.05# mount -o loop 24M /mnt
    bash-2.05# rmdir /mnt/lost+found/
    bash-2.05# find /mnt  
    /mnt
    /mnt/VIDEO_TS
    /mnt/VIDEO_TS/VTS_01_1.VOB
    /mnt/VIDEO_TS/VTS_01_0.IFO
    /mnt/VIDEO_TS/VTS_01_0.BUP
    /mnt/VIDEO_TS/VIDEO_TS.IFO
    /mnt/VIDEO_TS/VIDEO_TS.BUP
    /mnt/AUDIO_TS
    bash-2.05# umount /mnt
    bash-2.05# ogle 24M 
    libdvdread: Using libdvdcss version 1.2.9 for DVD access
    > UDFFindFile filename=/VIDEO_TS/VIDEO_TS.IFO
      UDFFindFile:856
    > UDFMapICB
    > UDFFileEntry
      ad->Length=0
      L_EA=0 L_AD=8
      before switch: ad->Length=0
      flags=0000
      flags=>UDFShortAD
      after switch: ad->Length=92
    < UDFFileEntry, ad->Length=92
    < UDFMapICB:530, return 1(ok)
      887: File.length=92 token=VIDEO_TS
    > UDFScanDir (1) Dir.Length=92 (2) FileName=VIDEO_TS
      UDFScanDir:595
      enter while: Dir.Length=92
      TagID=257 101
      filename=
      TagID=257 101
      filename=lost+found
    X UDFScanDir:638

    what? it still stops after "lost+found", which just has been removed?

(8) am I using the wrong image?
    bash-2.05# pwd
    /data/root/src
    bash-2.05# ls -l 24M 
    -rw-r--r--   1 root     root     25165824 Jun  5 19:02 24M
    bash-2.05# df
    Filesystem           1K-blocks      Used Available Use% Mounted on
    /dev/hda3              1011960    698656    261896  73% /
    /dev/hda4            152640480  60730116  84156592  42% /data
    bash-2.05# mount -o loop 24M /mnt
    bash-2.05# df
    Filesystem           1K-blocks      Used Available Use% Mounted on
    /dev/hda3              1011960    698656    261896  73% /
    /dev/hda4            152640480  60730116  84156592  42% /data
    /data/root/src/24M       23514      1660     21854   8% /mnt

    no. the image libdvd sees is the same that is mounted and that
    dvdauthor is operating upon.

what's wrong here?

kind regards,
h.rosmanith
