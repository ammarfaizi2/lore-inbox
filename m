Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1751074AbWFEMu5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751074AbWFEMu5 (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 08:50:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751080AbWFEMu5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 08:50:57 -0400
Received: from wildsau.enemy.org ([193.170.194.34]:14236 "EHLO
	wildsau.enemy.org") by vger.kernel.org with ESMTP id S1751074AbWFEMu5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 08:50:57 -0400
From: Herbert Rosmanith <kernel@wildsau.enemy.org>
Message-Id: <200606051244.k55CilhJ009962@wildsau.enemy.org>
Subject: UDF: buggy? libdvdread vs. udf fs driver
To: linux-kernel@vger.kernel.org
Date: Mon, 5 Jun 2006 14:44:47 +0200 (MET DST)
CC: Herbert Rosmanith <kernel@wildsau.enemy.org>
X-Mailer: ELM [version 2.4ME+ PL100 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


good afternoon,

background:
==========

  I'm trying to burn a video-dvd using udf. for testing, I used
  (1) a loopback image (2) a DVD-Rewriteable (3) a write-only dvd.
  all tests showed the same behaviour: "it does not work" ;-)

  using udf, I'm not able to play video-dvds, neither (1) via software
  ("ogle") nor (2) via a dvd-player connected to a TV.

  on the other hand, using iso9660 (via mkisofs -dvd-video) , ogle and
  the dvd-player work and display my small testmovie.

what exactly does not work:
==========================

  the dvd-player always complains about "no disc inserted", just to
  mention, anyway, the dvd-player is not a practicable debugging device ;-)

  the better debugging source is libdvdread. ogle complains that it
  cannot find "VIDEO_TS.IFO", allthough it _is_ there. I used the "printf"
  -debugger on libdvdread and found that it behaves differently when
  using a commercial DVD, opposed to the loopback-image I formatted with
  mkudffs.

how to reproduce the "bug":
==========================

  well, I'm not 100% sure if the problem exists because I don't understand
  how to use all these software (with the right options, in particular when
  using mkudffs) or if there's really a bug.

  (1) I created an udf-formated loopback image without extended file entries.
     "Why no extened file entries?", I hear you ask. Answer: because libdvdread
     doesnt like them, I'm afraid. Have a look in
     libdvdread/dvdread/dvd_udf.c, look for "UDFMapICB", somewhere around
     line 500. The do { } while loop checks for TagID 261 and ignores all
     other Tags. TagID 261 means "TAG_IDENT_FE", and when using "EFE"s, then
     UDFMapICB() will always see TagID = 0x10a (TAG_IDENT_EFE).
     Since I'm not really sure if the problem is related to FE vs. EFE, I
     used a filesystem with EFEs one time, and one without another time: both
     file systems showed the same behaviour (="VIDEO_ITS.IFO not found")

     ok, here we go:

        bash-2.05# dd if=/dev/zero of=24M bs=1M count=24
        24+0 records in
        24+0 records out

        bash-2.05# mkudffs 24M
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

    or:

        bash-2.05# mkudffs --noefe 24M

    I also used various other options like --bridgea --media-type etc.,
    but it didn't help.

  (2) next I created the dvd-structure using "dvdauthor":

        bash-2.05# mount -o loop 24M /mnt
        bash-2.05# dvdauthor -o /mnt -x foo.xml 
        DVDAuthor::dvdauthor, version 0.6.11.
        ...
        INFO: dvdauthor creating table of contents
        INFO: Scanning /mnt/VIDEO_TS/VTS_01_0.IFO
        ...

     "foo.xml" just contains:
        bash-2.05# cat foo.xml 
        <dvdauthor>
            <vmgm />
            <titleset>
                <titles>
                    <pgc>
                        <vob file="foo.mpg" />
                    </pgc>
                </titles>
            </titleset>
        </dvdauthor>

     "foo.mpg" is just a sequence of random pictures converted from /dev/urandom
     with mplex, mpeg2enc, et al.


  (3) to be sure the data has been written to the image, I unmount it (shouldn't
     be neccessary, right?), and then ogle will fail and say:

        bash-2.05# ogle 24M 
        libdvdread: Can't open file VIDEO_TS.IFO.
        ERROR[ogle_nav]: faild to read VIDEO_TS.IFO
        DVDSetDVDRoot:: Root not set

     but:
        bash-2.05# find /mnt -name VIDEO_TS.IFO
        /mnt/VIDEO_TS/VIDEO_TS.IFO
        bash-2.05# ls -li /mnt/VIDEO_TS/VIDEO_TS.IFO 
           1097 -rw-r--r--   1 root     root         6144 Jun  5 14:14
           /mnt/VIDEO_TS/VIDEO_TS.IFO

     in fact, the file *is* there. or, to be a bit more precise: libdvdread cannot 
     find the file, while the udf-fs driver does. of course it does - it should
     be able to find files it has created itself (via dvdauthor in (2)).

the printf debugger:
===================

  Since I'm still not used to using fullscreen-debuggers, I've added some
  printf()s to libdvdread/dvdread/udf.c and saw that a particular length-field
  is always zero when using the image, and non-zero using a commercial dvd.

  here's what I get:

  commercial DVD:
        # ogle /dev/hdc
        > UDFFindFile filename=/VIDEO_TS/VIDEO_TS.IFO
          UDFFindFile 841
        > UDFMapICB
        > UDFFileEntry
          ad->Length=0
          L_EA=132 L_AD=8
          before switch: ad->Length=0
          flags=0230
          after switch: ad->Length=292
        < UDFFileEntry, ad->Length=292

  howebrew loopback image:
        bash-2.05# ogle ~/src/24M 
        libdvdread: Using libdvdcss version 1.2.9 for DVD access
        > UDFFindFile filename=/VIDEO_TS/VIDEO_TS.IFO
          UDFFindFile 841
        > UDFMapICB
        > UDFFileEntry
          ad->Length=0
          L_EA=0 L_AD=188
          before switch: ad->Length=0
          flags=0003
          after switch: ad->Length=0
        < UDFFileEntry, ad->Length=0
          527: return 1
          872: File.length=0 token=VIDEO_TS
        > UDFScanDir (1) Dir.Length=0 (2) FileName=VIDEO_TS
          UDFScanDir:592
          enter while: Dir.Length=0
        X UDFFindFile 880

  "the X UDFFindFile" means that libdvdread did not find the file.
  you'll probably notice that Dir.Length remains zero always, which is the
  reason that UDFFindFile fails.

  one (big?) difference is that "L_EA=132 L_AD=8" in the first case
  and "L_EA=0 L_AD=188". I don't know if this should be that way. I've just
  downloaded ecma-167 and then decided to file this report without further
  looking into the problem.

conclusion:
==========

  the udf-fs-driver and libdvdread (and my dvd-player as well) seem to have a
  different idea on how to interpret udf. I can only guess why (= I have no
  proof).

  or is the source of the problem rather myself and I'm missing a crucial
  option?

kind regards,
h.rosmanith

