Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132306AbRBRA5w>; Sat, 17 Feb 2001 19:57:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132337AbRBRA5m>; Sat, 17 Feb 2001 19:57:42 -0500
Received: from e56090.upc-e.chello.nl ([213.93.56.90]:4362 "EHLO unternet.org")
	by vger.kernel.org with ESMTP id <S132306AbRBRA50>;
	Sat, 17 Feb 2001 19:57:26 -0500
Date: Sun, 18 Feb 2001 01:57:15 +0100
From: Frank de Lange <frank@unternet.org>
To: linux-kernel@vger.kernel.org
Cc: reiser@namesys.com, mason@suse.com
Subject: Re: reiserfs on 2.4.1,2.4.2-pre (with null bytes patch) breaks mozilla compile
Message-ID: <20010218015715.A13043@unternet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> That's not good. Which compiler did you use to compile the kernel? This
> sounds lame, but reiserfs exercises the cpu/mem more than ext2, so we hit
> bad ram more often. If we run out of other things to try, please run a
> memory tester.

I use 'good old' gcc 2.95.2:

gcc -v:	gcc version 2.95.2 19991024 (release)

I just tried 2.4.1-ac18, which also gave me the same segfault. When I compare
the corrupted binary (the one compile on reiserfs) to the working one (compiled
on ext2), I notice that at position 0x1000 in the file, a block of data from
position 0x0e60 is duplicated. It seems to be inserted into the data stream, as
it is followed by data which (in the working version of libsample.so) starts at
0x1000:

(bsdiff (binary sdiff) between both files)

(actually the differences between both files start much earlier, but that seems
to be just all kinds of changed relocation information as a result of the error)

(hope my careful ASCII-formatting makes it through the list and the archives)

THE BAD                                 THE GOOD

<deletia, a lot of uninteresting data...>

0000e60  c4 20 83 c4 f4 8b 06 		0000e60  c4 20 83 c4 f4 8b 06 
0000e68  8b 40 10 ff d0 eb 06 		0000e68  8b 40 10 ff d0 eb 06 
0000e70  bf 0e 00 07 80 89 f8 		0000e70  bf 0e 00 07 80 89 f8 
0000e78  65 e8 5b 5e 5f 89 ec 		0000e78  65 e8 5b 5e 5f 89 ec 
0000e80  c3 8d 76 00 55 89 e5 		0000e80  c3 8d 76 00 55 89 e5 
0000e88  c0 89 ec 5d c3 8d 76 		0000e88  c0 89 ec 5d c3 8d 76 
0000e90  55 89 e5 31 c0 89 ec 		0000e90  55 89 e5 31 c0 89 ec 

<deletia, a lot of uninteresting data...>

0000fd8  00 00 00 00 c0 00 00 		0000fd8  00 00 00 00 c0 00 00 
0000fe0  00 00 00 46 80 a0 c0 		0000fe0  00 00 00 46 80 a0 c0 
0000fe8  68 08 d3 11 91 5f d9 		0000fe8  68 08 d3 11 91 5f d9 
0000ff0  89 d4 8e 3c 40 92 89 		0000ff0  89 d4 8e 3c 40 92 89 
0000ff8  d2 f9 d2 11 bd d6 00 		0000ff8  d2 f9 d2 11 bd d6 00 

LOOK HERE: IDENTICAL TO THE		AND THIS IS WHAT IT SHOULD
DATA AT 0000e60				LOOK LIKE...

0001000  c4 20 83 c4 f4 8b 06 	  |	0001000  64 65 73 74 86 52 38 
0001008  8b 40 10 ff d0 eb 06 	  |	0001008  c4 cb d2 11 8c ca 00 
0001010  bf 0e 00 07 80 89 f8 	  |	0001010  b0 fc 14 a3 a0 58 f1 
0001018  65 e8 5b 5e 5f 89 ec 	  |	0001018  dd ca d2 11 8c ca 00 

<deletia, a lot of uninteresting data...>

0001190  89 d4 8e 3c 40 92 89     <
0001198  d2 f9 d2 11 bd d6 00     <

AND HERE THE 'GOOD' DATA STARTS
AGAIN, THIS BLOCK IS IDENTICAL TO
THE ONE AT 0x1000 IN THE 'GOOD' FILE

00011a0  64 65 73 74 86 52 38     <
00011a8  c4 cb d2 11 8c ca 00     <
00011b0  b0 fc 14 a3 a0 58 f1     <
00011b8  dd ca d2 11 8c ca 00     <
00011c0  b0 fc 14 a3 40 a7 58     <
00011c8  dc d5 d2 11 92 fb 00     <

<deletia, a lot of uninteresting data...>

So, it seems a wrong block of data was inserted into the stream at position
0x1000, wreaking havoc on the file structure. Now 0x1000 is kind of a magic
number, isn't it? Alsmost to good to be true...

I will retry this with 'all warnings and bells and whistles' turned on in
reiserfs (on 2.4.1-ac18), and see if anything out of the ordinary is logged. I
somehow doubt it, since repeated forced reiserfsck's have turned up nothing at
all...

Oh, and both my own and my computer's memory is OK, so this is not a hardware
fault... :-)

By the way, /tmp (where most action is taking place when compiling) is hosted
on a good ext2 filesystem. Just in case you wondered...

And, also of interest, I'm using an SMP box (BP6, 2 non overclocked Celeron
466s)

Cheers//Frank

-- 
  WWWWW      _______________________
 ## o o\    /     Frank de Lange     \
 }#   \|   /                          \
  ##---# _/     <Hacker for Hire>      \
   ####   \      +31-320-252965        /
           \    frank@unternet.org    /
            -------------------------
 [ "Omnis enim res, quae dando non deficit, dum habetur
    et non datur, nondum habetur, quomodo habenda est."  ]
