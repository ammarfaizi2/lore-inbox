Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315341AbSEAIxI>; Wed, 1 May 2002 04:53:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315342AbSEAIxH>; Wed, 1 May 2002 04:53:07 -0400
Received: from mx0.gmx.net ([213.165.64.100]:56133 "HELO mx0.gmx.net")
	by vger.kernel.org with SMTP id <S315341AbSEAIxG>;
	Wed, 1 May 2002 04:53:06 -0400
Date: Wed, 1 May 2002 10:15:16 +0200 (MEST)
From: Michael Kerrisk <m.kerrisk@gmx.net>
To: linux-kernel@vger.kernel.org
Cc: willy@linuxcare.com, sfr@canb.auug.org.au
MIME-Version: 1.0
Subject: Problems/bugs with file leases (F_SETLEASE)?
X-Priority: 3 (Normal)
X-Authenticated-Sender: #0005657596@gmx.net
X-Authenticated-IP: [212.224.52.76]
Message-ID: <10557.1020240916@www57.gmx.net>
X-Mailer: WWW-Mail 1.5 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gidday,
    
Now I gather that Linux file leases (fcntl(fd, F_SETLEASE, lease)  
and fcntl(fd, F_GETLEASE)) are provided for Samba support.

I'm investigating if they're more generally useful, and I've
run into a couple of issues which are either bugs, or failures in my
understanding (possible, since there is no documentation that I can find
explaining how file leases _should_ operate - I have by now had a good
look at the source code, but the intent of the code is not clear).

I'll describe two scenarios, and my expectations, and ask 5 questions.

Cheers,

Michael


The following experiments were conducted on kernel 2.4.18, Intel x86.

SCENARIO A:
===========

1. Process A (PID 13912) opens file X for reading.

2. Process B (PID 13912) opens file X for reading.

3. Process A sets a READ lease on file X.

4. Process B sets a READ lease on file X.

We now see the following in /proc/locks:

$ cat /proc/locks | grep LEASE
1: LEASE  MANDATORY READ  13912 03:0b:72627 0 EOF c1f72d54 c02cbae8 c1f72e10
00000000 c1f72d60
2: LEASE  MANDATORY READ  13910 03:0b:72627 0 EOF c1f72e0c c1f72d58 c1f72f80
c1f72d54 c1f72e18

5. Process C (PID 13924) opens file X read-write - this blocks,
   process A gets a SIGIO (or other) signal.

QUESTION 1: Why doesn't process B (which also holds a WRITE lease) 
get signalled at this point?

$ cat /proc/locks | grep LEASE
1: LEASE  MANDATORY READ  13912 03:0b:72627 0 EOF c1f72d54 c02cbae8 c1f72e10
00000000 c1f72d60
2: LEASE  MANDATORY READ  13910 03:0b:72627 0 EOF c1f72e0c c1f72d58 c1f72f80
c1f72d54 c1f720cc
2: -> LEASE  MANDATORY READ  13924 <none>:0 0 EOF c1f720c0 c02cbaf0 c02cbaf0
c1f72e0c c1f72e18

6. Process A does not remove its lease explicitly, so that after the
   lease-break timeout (45 secs) expires, the kernel breaks the lease
   and process C's open succeeeds.

   At this point F_GETLEASE in Process B returns F_UNLCK, BUT according
   to/proc/locks Process B still holds a lease on the file:

$ cat /proc/locks | grep LEASE
1: LEASE  MANDATORY READ  13912 03:0b:72627 0 EOF c1f72d54 c02cbae8 c1f72f80
00000000 c1f72d60

QUESTION 2: Have (should) the leases by both processes (A & B) been (be)
broken by the kernel at this point?  (I expected so, but the output
from /proc/locks, plus the following results are confusing.)

7. Process C exits.

8. Process D (PID 13958) opens file X read-write - this blocks:

$ cat /proc/locks | grep LEASE
1: LEASE  MANDATORY READ  13912 03:0b:72627 0 EOF c1f72d54 c02cbae8 c1f72f80
00000000 c1f720cc
1: -> LEASE  MANDATORY READ  13958 <none>:0 0 EOF c1f720c0 c02cbaf0 c02cbaf0
c1f72d54 c1f72d60

9. Process B is NOT signaled.  Unless Process B explicitly removes its
   lease using F_SETLEASE-F_UNLCK (or closes its file descriptor, or
   terminates) then process D remains blocked forever!

QUESTION 3: Is this really expected behavior, or is something broken?
(If things aren't broken, what does it mean for two processes to set 
read leases on a file, and why aren't they both signalled?)

(As a variation of this scenario, at step 6, I tried having Process A
explicitly remove its lease (Process B did nothing).  In this case,
Process C remained blocked until the 45-second lease timeout.  Then
Process C's open unblocked, and looking in /proc/locks showed that
both Process A and Process B's leases were removed.  This seems
reasonable behavior.)


SCENARIO B:
===========

(As I investigated this further it really seems like a variation on 
the last part of the previous scenario).

1. Process A (PID=13980) opens file X read-write and obtains a 
   WRITE lease on it.

$ cat /proc/locks | grep LEASE
1: LEASE  MANDATORY WRITE 13980 03:0b:72627 0 EOF c1f72d54 c02cbae8 c1f72f80
00000000 c1f72d60

2. Process B opens file X for read-write specifying the O_NONBLOCK flag.
   The open() returns immediately with EWOULDBLOCK.
   (Alternatively: Process B performs a normal open(), but the blocked
   call is prematurely terminated by catching a signal or by abnormal 
   process termination.)

3. Process A is sent SIGIO, and its WRITE lease is downgraded to F_UNLCK
   (as revealed by F_GETLEASE).  BUT, we see the following:

$ cat /proc/locks
1: LEASE  MANDATORY READ  13980 03:0b:72627 0 EOF c1f72d54 c02cbae8 c1f72f80
00000000 c1f72d60

4. Process B exits.

5. Process C (PID 14002) opens file X for writing (_without_ O_NONBLOCK).

6. Process A receives no signal.  Process C blocks indefinitely,
   unless Process A explicitly sets the lease to F_UNLCK
   (or closes the file descriptor, or terminates).

$ cat /proc/locks | grep LEASE
1: LEASE  MANDATORY READ  13980 03:0b:72627 0 EOF c1f72d54 c02cbae8 c1f72f80
00000000 c1f72dbc
1: -> LEASE  MANDATORY READ  14002 <none>:0 0 EOF c1f72db0 c02cbaf0 c02cbaf0
c1f72d54 c1f72d60

QUESTION 4: Is this a bug?


And another question unrelated to the above two scenarios:

QUESTION 5:
Suppose that Process A sets a WRITE lease on a file, and Process B opens the
file for reading (blocks).  At this point, I would have thought that if
Process A does an explicit F_SETLEASE-F_RDLCK, then this should be
enough to allow Process B's open to unblock (since, in the current 
implementation, a read lease is compatible with an open for reading).

However, this is not so: Process A must do an F_SETLEASE-F_UNLCK.
Why is setting the lease to F_RDLCK insufficient?

-- 
GMX - Die Kommunikationsplattform im Internet.
http://www.gmx.net

