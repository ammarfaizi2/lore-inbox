Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264176AbUDRVXy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Apr 2004 17:23:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264186AbUDRVXx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Apr 2004 17:23:53 -0400
Received: from us01smtp2.synopsys.com ([198.182.44.80]:17376 "EHLO
	kiruna.synopsys.com") by vger.kernel.org with ESMTP id S264176AbUDRVXs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Apr 2004 17:23:48 -0400
Date: Sun, 18 Apr 2004 14:23:46 -0700
From: Venkata Ravella <Venkata.Ravella@synopsys.com>
To: linux-kernel@vger.kernel.org
Cc: Ramki Balasubramanian <Ramki.Balasubramanium@synopsys.com>,
       ab@californiadigital.com, hpa@zytor.com
Subject: Automount/NFS issues causing executables to appear corrupted
Message-ID: <20040418212346.GA23560@rearview.synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The current kernel we use is default 7.2 kernel with two modifications:
1) BM patch applied to extend address space for a single process to 3.6GB
2) mnt patch applied to allow upto 1024 nfs mount points

uname -r output:
2.4.7-10mntBMsmp

Here is the detailed description of the problem, it's symptoms and few
observations. Let me know where I should look for solutions, pointers 
that can help further debug this problem more and any possible solutions.
Unfortunately, upgrading to a newer kernel is not an option for us at the
moment. 


The problem Description:
The executables on a particular nfs directory appear corrupted. The problem
is limited to that one nfs filesystem only. Analysis done so far is pointing to 
automount/nfs on the local host as the culprit.  Until a permanent fix can be 
found, the nfs directory has to be unmounted and re-mounted or the automount 
has to be restarted to clear the problem.  This problem is not reproducible 
but, showing up on our systems at random.


Symptoms:
The following are the symptoms of this problem. These symptoms may be very
misleading to the user.

Symptom 1
---------
executable gives one of the following errors and fail:

error while loading shared libraries: unexpected PLT reloc type 0x00
or
error while loading shared libraries: unsupported version 0 of Verneed record
or
Memory fault, Segmentation fault or Illegal instruction

Symptom 2
---------
executable gives the following kind of errors and fail:

/lib/libdl.so.2: version `' not found
/lib/i686/libm.so.6: version `' not found
/lib/i686/libpthread.so.0: version `' not found
/lib/i686/libc.so.6: version `' not found


Symptom 3
---------
SGE generated job output logs are truncated.



Detailed Analysis [Data Points Only]:

Sum produces wrong result
-------------------------
Example comparison of sum output of the same executable extracted from a good
system with the executable extracted from a bad one:

$ sum qqq*
50340  1147 qqq.bad
48019  1147 qqq.good
$


Executable dies at at relocation phase
--------------------------------------
The following is the tail output from the executable run with LD_DEBUG=all
setting:

24416:  symbol=stderr;  lookup in file=/lib/i686/libm.so.6
24416:  symbol=stderr;  lookup in file=/lib/i686/libc.so.6
24416:  binding file ./qqq.bad to /lib/i686/libc.so.6: normal symbol `stderr'
[GLIBC_2.0]
24416:  symbol=__ctype_toupper;  lookup in file=/lib/i686/libm.so.6
24416:  symbol=__ctype_toupper;  lookup in file=/lib/i686/libc.so.6
24416:  binding file ./qqq.bad to /lib/i686/libc.so.6: normal symbol
`__ctype_toupper' [GLIBC_2.0]
24416:  symbol=__ctype_b;  lookup in file=/lib/i686/libm.so.6
24416:  symbol=__ctype_b;  lookup in file=/lib/i686/libc.so.6
24416:  binding file ./qqq.bad to /lib/i686/libc.so.6: normal symbol
`__ctype_b' [GLIBC_2.0]
./qqq.bad: error while loading shared libraries: unexpected PLT reloc type
0x00


cmp output between good and bad executable differ
-------------------------------------------------
$ cmp  qqq.bad qqq.good
qqq.bad qqq.good differ: char 12289, line 40


Object dump on bad executable shows null bytes from 12289
---------------------------------------------------------
$ od -j 12250 qqq.bad | head -10
0027732 004023 142007 000000 037340 004023 142407 000000 037344
0027752 004023 143007 000000 037350 004023 143407 000000 037354
0027772 004023 144007 000000 000000 000000 000000 000000 000000
0030012 000000 000000 000000 000000 000000 000000 000000 000000
*
0037772 000000 000000 000000 175750 000316 164400 127560 000000
0040012 133215 000000 000000 106613 174324 177777 161676 010033
0040032 135410 015743 004020 010613 153611 003271 000000 176000
0040052 140061 123363 002164 140031 000414 140205 013564 164676
0040072 010033 104410 134727 000006 000000 124374 171400 007646

$ od -j 12250 qqq.good  | head -10
0027732 004023 142007 000000 037340 004023 142407 000000 037344
0027752 004023 143007 000000 037350 004023 143407 000000 037354
0027772 004023 144007 000000 037360 004023 144407 000000 037364
0030012 004023 145007 000000 037370 004023 145407 000000 037374
0030032 004023 146007 000000 037400 004023 146407 000000 037404
0030052 004023 147007 000000 037410 004023 147407 000000 037414
0030072 004023 151007 000000 037420 004023 151407 000000 037424
0030112 004023 152007 000000 037430 004023 152407 000000 037434
0030132 004023 153007 000000 037440 004023 153407 000000 037444
0030152 004023 154007 000000 037450 004023 156407 000000 037454


Other Observations:

- sum output comparison of the executable between two different systems
experiencing this behaviour is
  different.

- This affects only executables. Text files seem to be fine.

- copying any binary into the affected nfs partition gives input/output
error:

$ cp /tmp/ppp.good .
cp: writing `./ppp.good': Input/output error
cp: closing `./ppp.good': Input/output error

$ cp /usr/bin/archive .
cp: closing `./archive': Input/output error



