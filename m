Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264903AbTASUNa>; Sun, 19 Jan 2003 15:13:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264925AbTASUN3>; Sun, 19 Jan 2003 15:13:29 -0500
Received: from esperi.demon.co.uk ([194.222.138.8]:19467 "EHLO
	esperi.demon.co.uk") by vger.kernel.org with ESMTP
	id <S264903AbTASUN0>; Sun, 19 Jan 2003 15:13:26 -0500
To: ultralinux@vger.kernel.org
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Trond Myklebust <trond.myklebust@fys.uio.no>
Subject: Re: strange sparc64 -> i586 intermittent but reproducible NFS write errors to one and only one fs
References: <87bs2q3paq.fsf@amaterasu.srvr.nix>
	<200301100658.h0A6vxs14580@Port.imtp.ilyichevsk.odessa.ua>
X-Emacs: featuring the world's first municipal garbage collector!
From: Nix <nix@esperi.demon.co.uk>
Date: 19 Jan 2003 20:21:57 +0000
In-Reply-To: <200301100658.h0A6vxs14580@Port.imtp.ilyichevsk.odessa.ua>
Message-ID: <87iswkx53u.fsf@amaterasu.srvr.nix>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Military Intelligence)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Large amount of quoting to provide useful context; see below.]

On Fri, 10 Jan 2003, Denis Vlasenko recommended:
> On 10 January 2003 00:56, Nix wrote:
>> When I rebooted my systems into 2.4.20 (from 2.4.19), I started
>> seeing EIO write() errors to files in my ext3 home directory
>> (NFS-mounted, exported async).
>>
>> So I knocked up a test program (included below) to try to track the
>> failing writes down, and got more confused.
>>
>> The properties of the failing writes that I've been able to determine
>> thus far are as follows; look out, they're weird as hell:
>>
>>  - the failures are definitely from write(), not open().
>>
>>  - writes from sparc64 to one filesystem, and only one filesystem, on
>>    i586, both running 2.4.20, UDP NFSv3; rquotad and quotas are on,
>> but I am well within my quota. (quota 3.06, nfs-utils 1.0). Writes to
>> other filesystems on the same machine, even if they too are using
>> ext3, even if they too have user quotas for the same user.
>>
>>    What differs between filesystems that work and the one that fails
>> I can't tell; other FSen *on the same block device* work... (the
>> block device is an un-RAIDed SCSI disk.)
>>
>>  - local writes to the same filesystem, with the same test program,
>>    never fail.
>>
>>  - writes from another IA32 box (all these boxes are near-clones of
>>    each other as far as software is concerned) to the NFS server box
>>    never fail.
>>
>>  - It happens if I mount the fs with -o soft (my default for all NFS
>>    mounts for robustness-in-the-presence-of-machine-failure reasons),
>>    but also if I mount with -o hard :(( besides, the timeouts happen
>>    far too fast for it to be major timeout expiry that casues the EIOs.
>>
>>  - The failure always occurs for writes that cross the 2^21 byte
>>    boundary, but not all such writes fail. You seem to need to have
>>    done a lot of write()s before, perhaps even starting with O_TRUNC
>>    and write()ing like mad from there on up (the WRITES_PER_OPEN
>>    #define is a way to test that; I've never had a failure for a file
>>    opened with O_APPEND, even if it crossed the 2^21 byte boundary).
>>
>>  - It happens whether _LARGEFILE_SOURCE / _FILE_OFFSET_BITS are
>>    defined or not (I'd be amazed if this affected it, actually, but
>>    it never hurts to check).
>>
>>  - Despite the EIO, the write actually *succeeds* most of the time
>>    (perhaps not all the time; again, I'm not sure yet). In fact...
>>
>>  - It is quite thoroughly inconsistent. If you #define REPRODUCE to 1
>>    in the test program and fill out sizes_to_reproduce[] with a set
>>    of write() sizes that have caused the error in the past, the error
>>    happens again, but not always:

[and more; see <http://www.uwsg.iu.edu/hypermail/linux/kernel/0301.1/0597.html>;
 note that I have seen errors on writes to files of total size <2Mb --- e.g.,
 my mail overview databases --- but I can't reproduce them with a test program
 yet.]

> This beast is most probably Sparc64 or 64-bit arch specific.

That seems very likely.

> Try to pin down the first 2.4.20-preN where it appears.
> Then inform NFS and Sparc64 folks.

Done. Sorry for the delay; this box is quite hard to arrange to reboot :(

Anyway, the problem appears in 2.4.20-pre10; I suspect

Trond Myklebust <trond.myklebust@fys.uio.no>:
  o Workaround NFS hangs introduced in 2.4.20-pre

(so Cc:ed)

Does anyone have a pointer to this patch so I can try reversing it from
2.4.20pre10? (I can't see it on l-k, but since I don't know what it
looks like it's hard to find it in the archives; I don't have bitkeeper
on this machine, and can't, as one of my current projects involves
version-control filesystems).

Anyone got any other ideas, suggestions, or anything?


Thanks!

-- 
`I knew that there had to be aliens somewhere in the universe.  What I
 did not know until now was that they read USENET.' --- Mark Hughes,
      on those who unaccountably fail to like _A Fire Upon The Deep_
