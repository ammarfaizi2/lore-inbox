Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262595AbREOBWg>; Mon, 14 May 2001 21:22:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262597AbREOBW0>; Mon, 14 May 2001 21:22:26 -0400
Received: from a-pr5-32.tin.it ([212.216.131.223]:34689 "EHLO
	eris.discordia.loc") by vger.kernel.org with ESMTP
	id <S262595AbREOBWR>; Mon, 14 May 2001 21:22:17 -0400
Date: Tue, 15 May 2001 03:18:00 +0200 (CEST)
From: Lorenzo Marcantonio <lomarcan@tin.it>
To: <linux-kernel@vger.kernel.org>
Subject: SCSI Tape Corruption - 2nd round experiment result
Message-ID: <Pine.LNX.4.31.0105150027290.24946-100000@eris.discordia.loc>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Again battling with my SDT-9000, tonight first experiment was:

- Moderately huge file (339443712 bytes). Obtained cat'ing some large
  tar.bz2, so essentially 'random data'
- Fixed block size (dd bs=32KB, mt bs=512=default)
- HW data compression at default (enabled)
- Variable machine load (varying disk access to stimulate the I/O subsys)
- New AIC7xxx driver

Test sequence:
--------------
mt rewind
dd if=blob.dat of=/dev/tape bs=32k
mt rewind
dd if=/dev/tape of=blob.da1
md5sum blob.dat blob.da1

/dev/tape is symlinked to /dev/tapes/tape0/mtn
First test was done with very light load
Second test was done with a kernel compilation in background
Third test was done with HEAVY disk I/O in background (some mkisofs)

SCSI driver says this at start&end (seems harmless,
SDTR=SetDataTransferRate?):

(scsi1:A:4:0): Sending SDTR period 19, offset f
(scsi1:A:4:0): Received SDTR period 19, offset f
Filtered to period 19, offset f

Only the third test got the file 100% right. Seeing that as suspicious
(I've never got a good tar on this machine), I ran a fourth test (same
conditions as the third).

The differences:
----------------
(File offsets in hex, patterns were found without other matches in
the file)

First test:
64 bytes at D9E0800 (found starting at D9D8800, 32KB before)

Second test:
64 bytes at 2F187C0 (found starting at 2F107C0, 32KB before)
64 bytes at A8643C0 (found starting at A8343C0, 192KB before[!])

Third test:
No differences (sheer luck?)

Fourth test:
32 bytes at B937640 (found starting at B8D7640, 384KB before[!!])

Conclusions (IMO):
------------------

It's the first time I see 64 consecutive corrupted bytes. Also, on the
fourth test the data were from MUCH earlier in the file... (maybe in some
remote cache area... I've got 512MB RAM, 1024MB swap)

The Second Experiment (As Suggested By Alex Q Chen)
---------------------------------------------------

This time I've played with mt options. Since I was almost sleeping, I've
tried something radical:

mt stoptions debug  # It should have disabled EVERYTHING but debug

It says:
st0: Mode 0 options: buffer writes: 0, async writes: 0, read ahead: 0
st0:    can bsr: 0, two FMs: 0, fast mteom: 0, auto lock: 0,
st0:    defs for wr: 0, no block limits: 0, partitions: 0, s2 log: 0
st0:    sysv: 0

Then tested as before (same three load conditions)...

First test:
No differences

Second test:
No differences

Third test:
No differences

Fourth test (par condicio :):
64 bytes at 1039A840 (found starting at 10262840, 1248KB before)

Final Conclusion:
-----------------

Disabling the st options hasn't resolved the problem (which is at least
very elusive). Still, I can do more tests (not today, it's 3:14 AM here...
zzzz). Good night

				-- Lorenzo Marcantonio

