Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266139AbUIALb1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266139AbUIALb1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 07:31:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266149AbUIALb1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 07:31:27 -0400
Received: from pop.gmx.de ([213.165.64.20]:23200 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S266139AbUIALbC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 07:31:02 -0400
Date: Wed, 1 Sep 2004 13:31:01 +0200 (MEST)
From: "Michael Kerrisk" <mtk-lkml@gmx.net>
To: Roland McGrath <roland@redhat.com>
Cc: torvalds@osdl.org, jakub@redhat.com, akpm@osdl.org, drepper@redhat.com,
       linux-kernel@vger.kernel.org, michael.kerrisk@gmx.net,
       tonnerre@thundrix.ch
MIME-Version: 1.0
References: <200408312351.i7VNp28j001804@magilla.sf.frob.com>
Subject: Re: [PATCH] waitid system call
X-Priority: 3 (Normal)
X-Authenticated: #23581172
Message-ID: <30643.1094038261@www19.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just for completeness, I've updated the table below to include 
the AIX 5.2 result fro Eric Dumazet, and a Unixware result 
that I've also now got.  Unixware is like most other 
implementations, in zeroing out the siginfo_t structure 
when WNOHANG has no waitable children.

Cheers,

Michael

           Linux   Tru64   Solaris  HP-UX  Irix  AIX  U/Ware
           2.6.8.1  5.1       8      11    6.5   5.2  
           +waitid
si_pid     y.      y*      y*       y      y*    y.   y*
si_uid     y.      n* [1]  n* [2]   n [1]  n*    n.   n*
si_signo   y.      y*      y*       y      y*    y.   y*
si_status  y.      y*      y*       y      y#    y.   y*
si_code    y.      y*      y*       y      y*    y.   y*
si_errno   ?.      ?*      ?*       ?      ?*    ?.   ?*
si_stime   n.      n*      y* [3]   -      n#    -    -
si_utime   n.      n*      y* [3]   -      n*    -    -

Key
---

The first character in each table cell indicates whether
waitid() sets the field on this platform:

    y   this field is set on this platform

    n   this field is not set on this platform

    ?   there is insufficient information to determine if
        this field is meaningfully set on this platform

    -   this field is not available on this platform

    NOTE: The given test does not reveal whether si_errno is 
          meaningfully set on any platform (and I haven't 
          examined the header files sufficiently closely 
          enough to check if any further details can be 
          determined).  Offhand, I can't think of any 
          circumstances where it could be meaningful with 
          waitid().)

The second character in each table cell indicates (if present) 
how the field is treated when a WNOHANG operation is performed
and there is no child in a waitable state

    .   the field is left unchanged

    *   the field is explicitly initialized to 0

        NOTE: the Linux behaviour has now changed with the 
        more recent patch that DOES zero out the fields when 
        WNOHANG has no waitable children.

    #   the field is initialized to some random value 
        (i.e., something I don't understand) 

    NOTE: WNOHANG is broken on HP/UX 11 – if there are no 
          children that have yet terminated, waitid() fails 
          with the error ECHILD.

Notes to table:

[1] On Tru64 5.1 and HP-UX 11, si_uid is not meaningful, 
    but coincides with si_status, so a value is filled in.

[2] On Solaris 8, si_uid is not meaningful, but coincides with 
    si_utime, so a value is filled in.

[3] On Solaris 8, the si_stime and si_utime fields 
    return values in centiseconds.


Summary points
--------------

1. On most other implementations (other than AIX), when WNOHANG 
   is specified, all fields of the siginfo_t structure are 
   returned zeroed out if no child is in a waitable state, 
   with the following exceptions:

       WNOHANG on HP-UX is broken as noted above.  

       On Irix 6.5, si_status and si_stime are filled in
       with some unexplained values; the remaining fields
       are zeroed out.

2. All waitpid() implementations support si_pid, si_signo,
   si_status, and si_code.

3. Only Linux supports si_uid (and the rusage fields, which
   weren't employed in this test).

4. Solaris is the only implementation that supports 
   si_stime and si_utime.

Actual runs on the various platforms are shown below.

Cheers,

Michael

===========

Linux 2.6.8.1 + waitid patch

$ ./a.out escHi 1 3
Linux tekapo 2.6.8.1 #1 Wed Aug 18 11:04:01 CEST 2004 i686 i686 i386
GNU/Linux
child 1 PID=8208 started
child 2 PID=8209 started
0.04: waitid() returned 0
        si_pid=99; si_uid=99; si_signo=99;
        si_status=99; si_code=99 (????); si_errno=99;
        si_stime=99; si_utime=99;
0.54: waitid() returned 0
        si_pid=99; si_uid=99; si_signo=99;
        si_status=99; si_code=99 (????); si_errno=99;
        si_stime=99; si_utime=99;
child 1 PID=8208 finished
1.04: waitid() returned 0
        si_pid=8208; si_uid=500; si_signo=17;
        si_status=22; si_code=1 (CLD_EXITED); si_errno=0;
        si_stime=99; si_utime=99;
1.55: waitid() returned 0
        si_pid=99; si_uid=99; si_signo=99;
        si_status=99; si_code=99 (????); si_errno=99;
        si_stime=99; si_utime=99;
2.05: waitid() returned 0
        si_pid=99; si_uid=99; si_signo=99;
        si_status=99; si_code=99 (????); si_errno=99;
        si_stime=99; si_utime=99;
2.55: waitid() returned 0
        si_pid=99; si_uid=99; si_signo=99;
        si_status=99; si_code=99 (????); si_errno=99;
        si_stime=99; si_utime=99;
child 2 PID=8209 finished
3.05: waitid() returned 0
        si_pid=8209; si_uid=500; si_signo=17;
        si_status=22; si_code=1 (CLD_EXITED); si_errno=0;
        si_stime=99; si_utime=99;
3.55: waitid: No child processes

===========

Tru64 5.1

[I have no explanation for the odd si_errno setting on the 
first call below.]

$ ./a.out escHi 1 3
OSF1 spe206.testdrive.hp.com V5.1 2650 alpha
child 1 PID=1884812 started
0.01: waitid() returned 0
        si_pid=0; si_uid=0; si_signo=0;
        si_status=0; si_code=0 (????); si_errno=-1024;
        si_stime=0; si_utime=0;
child 2 PID=1885104 started
0.53: waitid() returned 0
        si_pid=0; si_uid=0; si_signo=0;
        si_status=0; si_code=0 (????); si_errno=0;
        si_stime=0; si_utime=0;
child 1 PID=1884812 finished
1.03: waitid() returned 0
        si_pid=1884812; si_uid=22; si_signo=20;
        si_status=22; si_code=1 (CLD_EXITED); si_errno=0;
        si_stime=0; si_utime=0;
1.53: waitid() returned 0
        si_pid=0; si_uid=0; si_signo=0;
        si_status=0; si_code=0 (????); si_errno=0;
        si_stime=0; si_utime=0;
2.03: waitid() returned 0
        si_pid=0; si_uid=0; si_signo=0;
        si_status=0; si_code=0 (????); si_errno=0;
        si_stime=0; si_utime=0;
2.53: waitid() returned 0
        si_pid=0; si_uid=0; si_signo=0;
        si_status=0; si_code=0 (????); si_errno=0;
        si_stime=0; si_utime=0;
child 2 PID=1885104 finished
3.03: waitid() returned 0
        si_pid=1885104; si_uid=22; si_signo=20;
        si_status=22; si_code=1 (CLD_EXITED); si_errno=0;
        si_stime=0; si_utime=0;
3.54: waitid: No child processes

===========

HP-UX 11

[WNOHANG is broken on this platform]

$ ./a.out escHi 1 3
HP-UX spe192 B.11.11 U 9000/800 1839940656 unlimited-user license
child 2 PID=5729 started
child 1 PID=5728 started
0.03: waitid: No child processes
$ child 1 PID=5728 finished
child 2 PID=5729 finished

./a.out esci 1 3
HP-UX spe192 B.11.11 U 9000/800 1839940656 unlimited-user license
child 1 PID=5733 started
child 2 PID=5734 started
child 1 PID=5733 finished
1.01: waitid() returned 0
        si_pid=5733; si_uid=22; si_signo=18;
        si_status=22; si_code=1 (CLD_EXITED); si_errno=0;
child 2 PID=5734 finished
3.01: waitid() returned 0
        si_pid=5734; si_uid=22; si_signo=18;
        si_status=22; si_code=1 (CLD_EXITED); si_errno=0;
3.01: waitid: No child processes

===========

Solaris 8

$ ./a.out escHi 1 3
SunOS sunbode6 5.8 Generic_108528-14 sun4u sparc SUNW,Ultra-4
child 1 PID=20682 started
0.02: child 2 PID=20683 started
waitid() returned 0
        si_pid=0; si_uid=0; si_signo=0;
        si_status=0; si_code=0 (????); si_errno=0;
        si_stime=0; si_utime=0;
0.52: waitid() returned 0
        si_pid=0; si_uid=0; si_signo=0;
        si_status=0; si_code=0 (????); si_errno=0;
        si_stime=0; si_utime=0;
child 1 PID=20682 finished
1.03: waitid() returned 0
        si_pid=20682; si_uid=80; si_signo=18;
        si_status=22; si_code=1 (CLD_EXITED); si_errno=0;
        si_stime=20; si_utime=80;
1.54: waitid() returned 0
        si_pid=0; si_uid=0; si_signo=0;
        si_status=0; si_code=0 (????); si_errno=0;
        si_stime=0; si_utime=0;
2.05: waitid() returned 0
        si_pid=0; si_uid=0; si_signo=0;
        si_status=0; si_code=0 (????); si_errno=0;
        si_stime=0; si_utime=0;
2.56: waitid() returned 0
        si_pid=0; si_uid=0; si_signo=0;
        si_status=0; si_code=0 (????); si_errno=0;
        si_stime=0; si_utime=0;
child 2 PID=20683 finished
3.07: waitid() returned 0
        si_pid=20683; si_uid=239; si_signo=18;
        si_status=22; si_code=1 (CLD_EXITED); si_errno=0;
        si_stime=61; si_utime=239;
3.58: waitid: No child processes

===========

Irix 6.5

$ ./a.out escHi 1 3
IRIX64 max 6.5 04091957 IP30
child 1 PID=62684 started
child 2 PID=62704 started
0.04: waitid() returned 0
        si_pid=0; si_uid=0; si_signo=0; 
        si_status=809598976; si_code=0 (????); si_errno=0; 
        si_stime=-1476395008; si_utime=0; 
0.59: waitid() returned 0
        si_pid=0; si_uid=0; si_signo=0; 
        si_status=4; si_code=0 (????); si_errno=0; 
        si_stime=-1476395008; si_utime=0; 
child 1 PID=62684 finished
1.10: waitid() returned 0
        si_pid=62684; si_uid=0; si_signo=18; 
        si_status=22; si_code=1 (CLD_EXITED); si_errno=0; 
        si_stime=0; si_utime=0; 
1.61: waitid() returned 0
        si_pid=0; si_uid=0; si_signo=0; 
        si_status=4; si_code=0 (????); si_errno=0; 
        si_stime=-1476395008; si_utime=0; 
2.12: waitid() returned 0
        si_pid=0; si_uid=0; si_signo=0; 
        si_status=4; si_code=0 (????); si_errno=0; 
        si_stime=-1476395008; si_utime=0; 
2.63: waitid() returned 0
        si_pid=0; si_uid=0; si_signo=0; 
        si_status=4; si_code=0 (????); si_errno=0; 
        si_stime=-1476395008; si_utime=0; 
child 2 PID=62704 finished
3.14: waitid() returned 0
        si_pid=62704; si_uid=0; si_signo=18; 
        si_status=22; si_code=1 (CLD_EXITED); si_errno=0; 
        si_stime=0; si_utime=0; 
3.65: waitid: No child processes

===========

AIX 5.2

# ./waitid_test escHi 1 3
AIX aix610p-ref 2 5 005FD96A4C00
child 1 PID=25204 started
child 2 PID=26944 started
0.03: waitid() returned 0
si_pid=99; si_uid=99; si_signo=99;
si_status=99; si_code=99 (????); si_errno=99;
0.53: waitid() returned 0
si_pid=99; si_uid=99; si_signo=99;
si_status=99; si_code=99 (????); si_errno=99;
child 1 PID=25204 finished
1.03: waitid() returned 0
si_pid=25204; si_uid=0; si_signo=20;
si_status=22; si_code=10 (CLD_EXITED); si_errno=0;
1.53: waitid() returned 0
si_pid=99; si_uid=99; si_signo=99;
si_status=99; si_code=99 (????); si_errno=99;
2.03: waitid() returned 0
si_pid=99; si_uid=99; si_signo=99;
si_status=99; si_code=99 (????); si_errno=99;
2.53: waitid() returned 0
si_pid=99; si_uid=99; si_signo=99;
si_status=99; si_code=99 (????); si_errno=99;
child 2 PID=26944 finished
3.03: waitid() returned 0
si_pid=26944; si_uid=0; si_signo=20;
si_status=22; si_code=10 (CLD_EXITED); si_errno=0;
3.53: waitid: No child processes

===
Unixware

$ ./a.out escHi 1 3

UNIX_SV shaft 4.2MP 2.1.1 i386 x86at
0.03: waitid() returned 0
        si_pid=0; si_uid=0; si_signo=0; 
        si_status=0; si_code=0 (????); si_errno=0; 
child 2 PID=13756 started
child 1 PID=13755 started
0.53: waitid() returned 0
        si_pid=0; si_uid=0; si_signo=0; 
        si_status=0; si_code=0 (????); si_errno=0; 
1.03: waitid() returned 0
        si_pid=0; si_uid=0; si_signo=0; 
        si_status=0; si_code=0 (????); si_errno=0; 
child 1 PID=13755 finished
1.53: waitid() returned 0
        si_pid=13755; si_uid=0; si_signo=18; 
        si_status=22; si_code=1 (CLD_EXITED); si_errno=0; 
2.03: waitid() returned 0
        si_pid=0; si_uid=0; si_signo=0; 
        si_status=0; si_code=0 (????); si_errno=0; 
2.53: waitid() returned 0
        si_pid=0; si_uid=0; si_signo=0; 
        si_status=0; si_code=0 (????); si_errno=0; 
3.03: waitid() returned 0
        si_pid=0; si_uid=0; si_signo=0; 
        si_status=0; si_code=0 (????); si_errno=0; 
child 2 PID=13756 finished
3.53: waitid() returned 0
        si_pid=13756; si_uid=0; si_signo=18; 
        si_status=22; si_code=1 (CLD_EXITED); si_errno=0; 
4.03: waitid: No child processes

-- 
Supergünstige DSL-Tarife + WLAN-Router für 0,- EUR*
Jetzt zu GMX wechseln und sparen http://www.gmx.net/de/go/dsl

