Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316427AbSEOQBr>; Wed, 15 May 2002 12:01:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316428AbSEOQBq>; Wed, 15 May 2002 12:01:46 -0400
Received: from smtp02.uc3m.es ([163.117.136.122]:60680 "HELO smtp.uc3m.es")
	by vger.kernel.org with SMTP id <S316427AbSEOQBo>;
	Wed, 15 May 2002 12:01:44 -0400
From: "Peter T. Breuer" <ptb@it.uc3m.es>
Message-Id: <200205151601.g4FG1Z213556@oboe.it.uc3m.es>
Subject: RE: Kernel deadlock using nbd over acenic driver
To: linux kernel <linux-kernel@vger.kernel.org>
Date: Wed, 15 May 2002 18:01:35 +0200 (MET DST)
Cc: steve@gw.chygwyn.com, alan@lxorguk.ukuu.org.uk, chen_xiangping@emc.com,
        kumbera@yahoo.com
X-Anonymously-To: 
Reply-To: ptb@it.uc3m.es
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Steven Whitehouse wrote:
> I don't think the system has "run out" exactly, more just got itself into
> a state where the code path writing out dirty blocks has been blocked
> due to lack of freeable memory at that moment and where the process
> freeing up memory has blocked waiting for the nbd device. It may well
> be that there is freeable memory, just that for whatever reason no
> process is trying to free it.

I'll provide some datapoints vis-a-vis the "Enhanced" NBD (ENBD, see
freshmeat). There have been sporadic reports of lock up with ENBD
too. Lately I have had a good report in which the reporter was
swapping over ENBD (it _is_ possible) and where the kernel locked
almost immediately under kernel 2.4.18, and the thing ran perfectly
under kernel 2.4.9. That coincides with my general feeling that a
lockup of VM against tcp is possible with the current VM.


The precise report is:

(Michael Kumbera)
) I'm trying to get swap working with nbd on a 2.4.18
) kernel (redhat 7.3) and my machine hangs when I start
) to swap.
) 
) This works great if a boot to a 2.4.9 kernel so I 
) assume it's an interaction with the "new" VM system. 
) Does anyone know if I can tune /proc/sys/vm/* to make
) it more stable?
) 
) I have tried to set the bdflush_nfract_sync to 100%
) and the bdflush_nfract to 0% and still hang almost
) instantly.
) 
) Any ideas? Does anyone have nbd swap working on a
) 2.4.10 (or greater) kernel?

and

) > You ARE using "-s", yes?
) 
) Yes, I'm using the "-s" options.  I just tried the -s -a and no change.
) As soon as the machine starts to really swap it hangs.
) The system uses the network heavily for about 3-5 seconds and then
) nothing.

and

) My client machien is a Dual CPU Athlon 1.6GHz and I'm
) running on a 100M connection to a P4 server. 

His test is:

) > The program malloc's out 1G of memory 64M at a time.  After each
) > malloc
) > I memset the allocated block to zero. I picked 1G since that is my
) > physical memory size. (I create a 512M swap partition with enbd)

Now, the primary difference (in this area) between ENBD and NBD is that
ENBD does its networking in userspace, so that it can use other
transport media, and do more sophisticated reconnections.  The client
daemons call mlockall() to lock themselves in memory when the -s flag is
given.  They transfer data to and from the kernel via ioctls on the nbd
device. When -a is given, they "trust the net" and ack the kernel
before getting an ack back from the net, so a kernel request may
be released before the corresponding network packets have been made,
sent out, and recieved back, which avoids one potential deadlock if
tcp can deadlock.

The report says that neither of these strategies (together) is
effective in kernel 2.4.18, and it works fine in kernel 2.4.9.

I have also found that many potential problems in 2.4.18 are solved if
one lowers the VM async buffers trigger point so that buffers start to
go to the net immediately, and if one increases the VM sync buffer point
so that the system never goes synchronous.  I guess that when the kernel
hits the sync point, that all buffer i/o goes synchronous, and we cannot
use the net to send out the requests and get back the ack that would
free the nbd requests that are creating the pressure.  Anecdotal
evidence suggests that if you supply more real ram, this kind of
deadlock ceases to be even a possibililty.

Can one change the VM parameters on a per-device basis? Or at least
monitor them?

There are also several studies being made from collaborators in
Heidelberg which show qualitative differences between new VM and old VM
behaviour on the _server_ side.  Basically, put an old VM on the server,
and push data to it with VM, and you get something like a steady
16.5MB/s.  Put a new VM in and you get pulsed behaviour.  Maybe 18.5MB/s
tops, dropping to nothing, then picking up again, at maybe 7s intervals.

To my control-theoretic trained eyes, that looks like two control
systems locked together, one of them at least doing stop-start control,
with hysteresis.  The old VM, by contrast, looks as though it's using
predictive control (i.e.  the equations contain a differential term,
which would be "acceleration" in this setting) and thus damping the
resonance.  The new VMs look to be resonating when linked by nbd.

I suspect that the new VM has got rid of some slow-throttling mechanisms
that previously avoided the possibility of deadlocking against tcp.
But I'm at a loss to explain why swap is showing up as being
particularly sensitive. Maybe it's simply treated differently by the
new VM.

Anyway, if you have any comments, please let me see them!

Should Andrea or Rik be in on this?





Peter

