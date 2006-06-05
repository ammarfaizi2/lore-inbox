Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1751253AbWFER72@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751253AbWFER72 (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 13:59:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751251AbWFER71
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 13:59:27 -0400
Received: from wildsau.enemy.org ([193.170.194.34]:18332 "EHLO
	wildsau.enemy.org") by vger.kernel.org with ESMTP id S1751249AbWFER70
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 13:59:26 -0400
From: Herbert Rosmanith <kernel@wildsau.enemy.org>
Message-Id: <200606051753.k55HrpRl010049@wildsau.enemy.org>
Subject: Re: UDF: buggy? libdvdread vs. udf fs driver
In-Reply-To: <200606051708.k55H84dC010037@wildsau.enemy.org>
To: Herbert Rosmanith <kernel@wildsau.enemy.org>
Date: Mon, 5 Jun 2006 19:53:51 +0200 (MET DST)
CC: linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL100 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>     > UDFScanDir (1) Dir.Length=92 (2) FileName=VIDEO_TS
>       UDFScanDir:595
>       enter while: Dir.Length=92
>       TagID=257 101
>       filename=
>       TagID=257 101
>       filename=lost+found
>     X UDFScanDir:638
> 
>     what? it still stops after "lost+found", which just has been removed?

okidok ... having seen this, I had the idea of modyfing mkudffs just
to see what's going to happen.

since "lost+found" is so persistent and remains allthough having been removed
before, I changed "udftools-1.0.0b3/mkudffs/mkudffs.c" not to create
"lost+found", but "VIDEO_TS" instead:

   642          //desc = udf_mkdir(disc, pspace, "\x08" "lost+found", 11, offset+1, desc);
   643          desc = udf_mkdir(disc, pspace, "\x08" "VIDEO_TS", 9, offset+1, desc);

good.

now:
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
    bash-2.05# find /mnt
    /mnt
    /mnt/VIDEO_TS

good, that's what I wanted. now create dvd:

    bash-2.05# dvdauthor -o /mnt -x foo.xml 
    DVDAuthor::dvdauthor, version 0.6.11.
    Build options: gnugetopt freetype
    Send bugs to <dvdauthor-users@lists.sourceforge.net>
    
    INFO: dvdauthor creating VTS
    STAT: Picking VTS 01
    STAT: Processing foo.mpg...
    ...
    INFO: dvdauthor creating table of contents
    INFO: Scanning /mnt/VIDEO_TS/VTS_01_0.IFO

all files in place?
    bash-2.05# find /mnt
    /mnt
    /mnt/VIDEO_TS
    /mnt/VIDEO_TS/VTS_01_1.VOB
    /mnt/VIDEO_TS/VTS_01_0.IFO
    /mnt/VIDEO_TS/VTS_01_0.BUP
    /mnt/VIDEO_TS/VIDEO_TS.IFO
    /mnt/VIDEO_TS/VIDEO_TS.BUP
    /mnt/AUDIO_TS

indeed.

now for libdvdread:
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
      after switch: ad->Length=88
    < UDFFileEntry, ad->Length=88
    < UDFMapICB:530, return 1(ok)
      887: File.length=88 token=VIDEO_TS
    > UDFScanDir (1) Dir.Length=88 (2) FileName=VIDEO_TS
      UDFScanDir:595
      enter while: Dir.Length=88
      TagID=257 101
      filename=
      TagID=257 101
      filename=VIDEO_TS
      ^^^^^^^^^^^^^^^^^

libdvdread now finds VIDEO_TS, which it failed to before.

but:

    > UDFMapICB
    > UDFFileEntry
      ad->Length=0
      L_EA=0 L_AD=8
      before switch: ad->Length=0
      flags=0000
      flags=>UDFShortAD
      after switch: ad->Length=40
    < UDFFileEntry, ad->Length=40
    < UDFMapICB:530, return 1(ok)
      887: File.length=40 token=VIDEO_TS.IFO
    > UDFScanDir (1) Dir.Length=40 (2) FileName=VIDEO_TS.IFO
      UDFScanDir:595
      enter while: Dir.Length=40
      TagID=257 101
      filename=
    > UDFMapICB
    < UDFMapICB:514, return 1(ok)
    X UDFScanDir:638

 ... it fails to find "VIDEO_TS.IFO", allthough:

    bash-2.05# mount -o loop 24M /mnt
    bash-2.05# ls -l /mnt/VIDEO_TS/VIDEO_TS.IFO 
    -rw-r--r--   1 root     root         6144 Jun  5 19:33 /mnt/VIDEO_TS/VIDEO_TS.IFO

... the udf-fs driver _does_ see that file.

kind regards,
h.rosmanith
