Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758553AbWLDB6S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758553AbWLDB6S (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Dec 2006 20:58:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758530AbWLDB6S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Dec 2006 20:58:18 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:12240 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1758553AbWLDB6R
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Dec 2006 20:58:17 -0500
Date: Sun, 3 Dec 2006 17:58:08 -0800
From: "Kurtis D. Rader" <krader@us.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: Re: data corruption with nvidia nForce 4 chipsets and IDE/SATA drives
Message-ID: <20061204015808.GA2800@us.ibm.com>
References: <4570CF26.8070800@scientia.net> <20061203011737.GA2729@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061203011737.GA2729@us.ibm.com>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-12-02 17:17:37, Kurtis D. Rader wrote:
> I'm also experiencing silent data corruption on writes to SATA disks
> connected to a Nvidia controller (nForce 4 chipset). The problem is
> 100% reproducible. Details of my configuration (mainboard model, lspci,
> etc.) are near the bottom of this message. What follows is a summation
> of my findings.

I ran more tests today. This is definitely not due to faulty memory.
Also, clearly this is not a problem with the nVidia SATA controller that
is part of the nForce 4 chipset since the problem can be reproduced with
a Promise TX2 controller in a PCI slot.

The key question is whether this is a HW quirk of the nForce 4 chipset
that the kernel can and should be working around? What tests can I run that
will help narrow the field of investigation or provide more useful data?

I put one disk on my Promise TX2 SATA controller and the other on the
onboard nVidia controller. As reported before corruption occurs when
writing to either disk but at a lower probability when writing to the
disk on the Promise TX2. Also, if I use a PATA disk as the source of the
copy the probabability of corruption is also greatly reduced (the PATA
disk has about 1/3 the throughput of the SATA disks).

I removed half the memory (two 1 GiB DIMMs from the second bank).
Corruption still occurs. I Replaced the DIMMs in the first bank with the
two removed from the second bank (leaving the second bank unpopulated as
before). Corruption still occurs. I verified by inspection of the e820
map that all memory is mapped below the 4 GiB boundary.  I've also been
running prime95 all day with the options "-B2 -t". No errors have been
reported. Coupled with previous clean runs of memtest86 and the symptoms
there seems no reason to believe that faulty memory is the cause of
the corruption.

I should stress that my system is not overclocked. The memory is top of the
line matched pairs of Corsair CMX1024-3200PT DDR2 400 Mhz. The power supply
is an Antec True 380S (380 watts).  According to the BIOS temperature
and voltage monitoring everthing is well within operational limits. All
components are less than a year old. I buy the best components and am very
conservative when building a system that I depend upon for doing my job.

I also performed some additional copies of the problematic files using
a program whose core is a direct read, write, verify loop:

    ifd = open(source_path, O_RDONLY | O_DIRECT);
    ofd = open(dest_path, O_RDWR | O_DIRECT);
    while (1) {
        if (read( ifd, buf1, blocksize ) != blocksize) exit(0);
again:
        write( ofd, buf1, blocksize );
        lseek( ofd, -blocksize, SEEK_CUR );
        read( ofd, buf2, blocksize );
        for (i = 0; i < blocksize; i++) {
            if (buf1[i] != buf2[i]) {
                fprintf( stderr, "blk %6d offset 0x%04x good %02x bad %02x\n",
                    blk, i, buf1[i], buf2[i] );
                lseek( ofd, -blocksize, SEEK_CUR );
                goto again;
            }
        }
    }

It reports corruption at a very low rate (a single block out of 15 GiB).
Rewriting the corrupted block always succeeds on the first try.  Note that
the test involves seven 2 GiB and one 1 GiB file (VMware Windows XP guest
image split on 2 GiB boundaries). Of the eight files four have never been
corrupted. Those four are mostly free space (i.e., blocks of nulls). The
four files which consistently show corruption have few free blocks.
Which is further evidence that this involves some subtle HW design fault
that requires a specific pattern of data and bus transactions.

It's interesting to note that running prime95 at the same time as the
disk write test reduces the number of corrupted bytes.

The test loop computes a md5sum for each copied file and compares that to
the known correct md5sum. If any md5sums don't match it then performs a
"cmp -l" of the original file and the copy. 

In the "cmp -l" output below the middle column is the good value and the
right-hand column is the bad value from the just created copy of the file.
As reported before all corruption involves the second 32-bit word of a
16-byte aligned region.  Note that the offsets reported by cmp(1) start
at one so you need to subtract one to get a proper offset from the start
of the file. So subtract one then convert to hex.

Below are the results of one test with 2 GiB of memory. I'll buy a beer
for the person who can find a pattern to the corruption. Results from
other test runs can be provided upon request. Most corruption involves
only a few bytes in a given 2 GiB file. But I've had a couple of runs
where hundreds, and in one case thousands, of bytes have been corrupted.

iteration 1
1c1
< 748b7ad615a62e41a88a6b5d47bb5581  Windows XP-f001.vmdk
---
> 8aff2d3a23e4f08d9a3145d011368e93  Windows XP-f001.vmdk
3,5c3,5
< 6bbe96c7da14487adab7e0c13b7e54f6  Windows XP-f003.vmdk
< bf7c45c7a6c24bda251a34e73b0cbe9c  Windows XP-f004.vmdk
< 241c45aa023556d0bb0b864b3a83a800  Windows XP-f005.vmdk
---
> e08d9b8194a1aac41de611a3ba782e03  Windows XP-f003.vmdk
> 8aa16afaf6bae8dcdeb2bb5595cbc76f  Windows XP-f004.vmdk
> e65f5de0bd69d76d40d23593f9221f36  Windows XP-f005.vmdk
Windows XP-f001.vmdk
 327748952 115 117
 657644309 327 100
 657644310 105   0
 657644311 221   0
 657644312 127   0
 778889238 145  45
 778889240 350 312
Windows XP-f002.vmdk
Windows XP-f003.vmdk
1025312597  70  60
1622579125 164 174
1622579126 135 125
1622579128 170 140
Windows XP-f004.vmdk
1129237493  50 104
1129237494   1  15
1922382310  14   4
1922382312 321 333
1936442328 236 224
2004252949  37 215
2004252950   0   4
2004252951 200  26
2004252952 371 212
2004430229 200 270
2004430230  16 107
2004430231   0 340
2004430232 242 317
2056253589 164 160
2056253590 340 200
2056253592 151 101
Windows XP-f005.vmdk
 113235864  71  73
 536394981   1  24
 536394982 203  13
 536394983 310 376
 536394984   2 161
 764048760   2   0
Windows XP-f006.vmdk
Windows XP-f007.vmdk
Windows XP-f008.vmdk

-- 
Kurtis D. Rader, Linux level 3 support  email: krader@us.ibm.com
IBM Integrated Technology Services      DID: +1 503-578-3714
15300 SW Koll Pkwy, MS RHE2-O2          service: 800-IBM-SERV
Beaverton, OR 97006-6063                http://www.ibm.com
