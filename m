Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263114AbTCYRQr>; Tue, 25 Mar 2003 12:16:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263118AbTCYRQq>; Tue, 25 Mar 2003 12:16:46 -0500
Received: from smtp01.uc3m.es ([163.117.136.121]:19208 "HELO smtp.uc3m.es")
	by vger.kernel.org with SMTP id <S263114AbTCYRQl>;
	Tue, 25 Mar 2003 12:16:41 -0500
From: "Peter T. Breuer" <ptb@it.uc3m.es>
Message-Id: <200303251727.h2PHRfP22373@oboe.it.uc3m.es>
Subject: Re: [PATCH] ENBD for 2.5.64
In-Reply-To: From "(env:" "ptb)" at "Mar 25, 2003 04:35:23 pm"
To: linux kernel <linux-kernel@vger.kernel.org>
Date: Tue, 25 Mar 2003 18:27:41 +0100 (MET)
X-Anonymously-To: 
Reply-To: ptb@it.uc3m.es
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"a litle while ago ptb wrote:"
> Here's a patch to incorporate Enhanced NBD (ENBD) into kernel 2.5.64.
> I'll put the patch on the list first, and then post again with a
> technical breakdown and various arguments/explanations.

I'll now put up the technical discussion I promised. (the patch is
also in the patches/ subdir in the archive at
ftp://oboe.it.uc3m.es/pub/Programs/nbd-2.4.31.tgz)

I'll repeat the dates .. Pavel's kernel NBD, 1997, the ENBD 1998,
derived initially from Pavel's code backported to stable kernels.
Pavel and I have been in contact many times over the years. 

Technical differences
---------------------
1) One of the original changes made was technical, and is perhaps
   the biggest reason for what incompatibilities there are (I can
   equalize the wire formats, but not the functional protocols, so you
   need different userspace support for the different kernel drivers).

   - kernel nbd runs a single thread transferring data between kernel
   and net.

   - ENBD runs multiple threads running asynchronously of each other

   The result is that ENBD can get a pipelining benefit ..  while one
   thread is sending to the net another is talking to the kernel and
   so on.  This shows up in different ways.  Obviously you do best if
   you have two cpus or two nics, etc.

   Also ENBD doesn't die when one thread gets stuck. I'll talk about
   that.

2) There is a difference in philosophy, which results in different
   code, different behaviors, etc. Basically, ENBD must not /fail/.
   It's supposed to keep working first and foremost, and deal with
   errors when they crop up, and it's supposed to expect errors.

   - kernel nbd runs a full kernel thread which cannot die. It loops
     inside the kernel.

   - ENBD runs userspace threads which can die and are expected to die
     and which are restarted by a master when they die. They only dip
     into the kernel occasionally.

   This originally arose because I was frustrated with not being able
   to kill the kernel nbd client daemon, and thus free up its "space".
   It certainly used to start what nowadays we know as a kernel thread,
   but from user space. It dove into the kernel in an ioctl and
   executed a forever loop there. ENBD doesn't do that. It runs the
   daemon cycle from user space via separate ioctls for each stage.

   That's why you need different user space utilities.

   - kernel nbd has daemons which are quite lightweight

   - ENBD has daemons which disconnect if they detect network failures
     and reconnect as soon as the net comes up again. Servers and
     clients can die, and be restarted, and they'll reconnect, entirely
     automatically, all on their little ownsomes ..

   ENBD is prepared internally to retract requests from client daemons
   which don't respond any longer, and pass them to others instead.
   It's tehrefore also prepared to receive acks out fo order, etc. etc.

   Another facet of all that is the following:

   - kernel nbd does networking from within the kernel

   - ENBD does its networking from userspace. It has to, to manage the
     complex reconnect handshakes, authentication, brownouts, etc.

   As a result, ENBD is much more flexible in its transport protocols.
   There is a single code module which implements a "stream", and
   the three or four method within need to be reimplementd for each
   protocol, but that's all. There are two standard transports in the
   distribution code - tcp and ssl, and other transport modules have 
   been implemented, including ones for very low overhead raw networking
   protocols.


OK, I can't think of any more "basic" things at the moment. But ENBD
also suffers from galloping featurism. All the features can be added to 
kernel nbd too, of course, but some of them are not point changes at
all! It would take just as long as it took to add them to ENBD in the
first place.  I'll make a list ...


Featuritus
----------

  1) remote ioctls. ENBD does pass ioctls over the net to the
     server. Only the ones it knows about of course, but that's 
     at least a hundred off. You can eject cdroms over the net.
     More ioctls can be added to its list anytime. Well, it knows about
     at least 4 different techniques for moving ioctls, and you can
     invent more ..

  2) support for removable media. Maybe I should have included that in
     the  technical differnces part. Basically, ENBD expects the
     server to report errors that are on-disk, and it distinguishes
     them from on-wire errors. It proactively pings both the server, and
     asks the server to check its media, every second or so. A change 
     in an exported floppy is spotted, and the kernel notified.

  3) ENBD has a "local write/remote read" mode, which  is useful for
     replacing NFS root with. A single server can be replicated to
     many clients, each of which then makes its own local changes.
     The writes stay in memory, of course (this IS a kind of point
     change).

  4) ENBD has an async mode (well, two), in which no acks are expected
     for requests. This is useful for swapping over ENBD (the daemons
     also have to fixed in memory for that, and thats's a "-s" flag).
     Really, there are several async modes. Either the client doesn't
     need to ack the kernel, or can ack it late, or the server doesn't
     need to ack the client, etc.

  5) ENBD has an evolved accounting and control interface in /proc.
     It amounts to about 25% of its code.

  6) ENBD supports several sync modes, direct i/o on client, sync 
     on server, talking to raw devices, etc.

  7) ENBD supports partitions.


Maybe there are more features. There are enough that I forget them at
times. I try and split them out into add-on modules. These are things
that have been requested or even requested and funded! So they satisfy
real needs.

Extra badness
-------------

One thing that's obvious is that ENBD has vastly more code than kernel
enbd. Look at these stats:

csize output, enbd vs kernel nbd ..

   total    blank lines w/   nb, nc    semi- preproc. file
   lines    lines comments    lines   colons  direct.
--------+--------+--------+--------+--------+--------+----
    4172      619      800     2789     1438       89 enbd_base.c
     405       38       67      304       70       38 enbd_ioctl.c
      30        4        3       23       10        4 enbd_ioctl_stub.c
      99       13        8       78       34        8 enbd_md.c
    1059      134       32      902      447       15 enbd_proc.c
      75        8       16       51       20        2 enbd_seqno.c
      64       14        5       45       18        2 enbd_speed.c
    5943      839      931     4222     2043      167 total

   total    blank lines w/   nb, nc    semi- preproc. file
   lines    lines comments    lines   colons  direct.
--------+--------+--------+--------+--------+--------+----
     631       77       68      487      307       34 nbd.c

You should see that ENBD has between 5 and 10 times as much code as
kernel nbd.  I've tried to split things up so that enbd_base.c is
roughly equivalent to kernel nbd, but it still looks that way.  But it's
not quite true ..  one thing that distorts stats is that ENBD needs many
more trivial support functions just to allow things to be split up!  The
extra functions become methods in a struct, and the struct is exported
to the other module, and then the caller uses the method.  Pavel was
probably able to just do a straight bitop instead!

Another thing that distorts the stats is the proc interface. Although I
split it out in the code (it's about 1000 of 5000 lines total), the 
support functions for its read and writes are still in the main code.
Yes, I could have not written a function and instead embedded the code
directly in the proc interface, but then maintenance would have been
impossible. So that's another reason ...

... because of the extra size of the code, ENBD has many more internal
code interfaces, in order to keep things separated and sane. It would
be unmanagable as a single monolithic lump. You get some idea of that
from the function counts in the following list:

   ccount 1.0:    NCSS  Comnts  Funcs  Blanks  Lines
------------------+-----+-------+------+-------+----
  enbd_base.c:    1449    739     71    615   4174
 enbd_ioctl.c:      70     59     12     42    409
enbd_ioctl_stub.c:  10      3      3      3     30
    enbd_md.c:      34      7      6     13     99
  enbd_proc.c:     452     32     16    133   1060
 enbd_seqno.c:      20     13      5      8     75
 enbd_speed.c:      18      4      2     14     64
       Totals:    2059    857    115    837   5950

------------------+-----+-------+------+-------+----
   ccount 1.0:    NCSS  Comnts  Funcs  Blanks  Lines
        nbd.c:     314     63     13     75    631

Note that Pavel averages 48 lines per function and I average 51,
so we probably have the same sense of "diffculty". We both comment
at about the same rate too, Pavel 1 in every 10 lines, me 1 in
every 7 lines.

But I know that I have considerable swathes of code that have to be done
inline, because they mess with request struct fields (for the remote
ioctl stuff), and have to complete and reverse the manipulations within
a single routine.

I'll close with what I said earlier ...

> ENBD is not a replacement for NBD - the two are alternatives, aimed
> at different niches.  ENBD is a sort of heavyweight industrial NBD.  It
> does many more things and has a different achitecture.  Kernel NBD is
> like a stripped down version of ENBD.  Both should be in the kernel.

Peter
