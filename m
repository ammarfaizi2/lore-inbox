Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265408AbTFMPEP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 11:04:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265410AbTFMPEP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 11:04:15 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:42409 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S265408AbTFMPEK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 11:04:10 -0400
Importance: Normal
Sensitivity: 
Subject: RE: e1000 performance hack for ppc64 (Power4)
To: "Feldman, Scott" <scott.feldman@intel.com>
Cc: "David Gibson" <dwg@au1.ibm.com>, <linux-kernel@vger.kernel.org>,
       "Anton Blanchard" <anton@samba.org>,
       "Nancy J Milliner" <milliner@us.ibm.com>,
       "Ricardo C Gonzalez" <ricardoz@us.ibm.com>,
       "Brian Twichell" <twichell@us.ibm.com>
X-Mailer: Lotus Notes Release 5.0.7  March 21, 2001
Message-ID: <OF0078342A.E131D4B1-ON85256D44.0051F7C0@pok.ibm.com>
From: "Herman Dierks" <hdierks@us.ibm.com>
Date: Fri, 13 Jun 2003 10:17:33 -0500
X-MIMETrack: Serialize by Router on D01ML065/01/M/IBM(Release 5.0.11 +SPRs MIAS5EXFG4, MIAS5AUFPV
 and DHAG4Y6R7W, MATTEST |November 8th, 2002) at 06/13/2003 11:17:53 AM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Scott, we don't copy large blocks like large send.
 The code is just suppose to copy any packets 2K or less.

Actually, David jumped the gun here a bit as we were going to write up a
more proposal for this.
I expect that this would help other acrh. as well.
The issue is the alignment and problems that causes on the PCI bus.
 In a nutshell, it takes several more DMA's to get the transfer done.  Not
sure if this would hold true on all platforms (IE is a function of the
adapter and or PCI bus) or if it is due to the bridge chips (PHB's) on
pSeries (PPC).
I think the only issue here that is PPC specific is that we have several
bridge chips in the IO path so LATENCY is longer that if you have a direct
attached bus.  However, many platforms that need more PCI slots have to add
bridge chips into the path (required by the PCI architecture due to loads
on the bus, etc).  Thus, the extra DMA's required due to miss-alignment
lead to longer bus times if bridge chips are in the IO path.
I copied  below a note from 3/16/2003 that shows the issues. Note that the
main issue here is on PCI bus (not PCI-X).
The reason is that PCI-X with MMRBC =2048 reads larger chunks and this
helps.   However, we have PIC-X bus traces and this alignment also helps
PCI-X as well, just to a lesser extend with respect to performance.

I don't think the TCE is an issue in this one case because the driver was
already DMA'ing a single "linear" buffer to the adapter.
It was just aligned in such a way that it takes more DMA's to finish.
In AIX, we did the copy to get to a single DMA buffer (which Linux already
does) as it has the TCP/IP headers in one buffer and data in another buffer
(one or two in some cases for MTU 1500).   Thus we took two TCE lookups in
the AIX case so the copy saved us more.
Because we only copy 2K or less, the cost is minimal as the data is already
in the cache (typically)  from being copied into the kernel (non-zero copy
case).

So in summary I think this is mainly an alignment issue and it is likely to
help other platforms as well so should be considered for the driver.

Here is the older note on the PCI bus trace.    The receive alignment was
addressed in a different defect and I think has been taken care of.

 To:  Ricardo C Gonzalez/Austin/IBM@ibmus, Nancy J
Milliner/Austin/IBM@IBMUS, Anton Blanchard/Australia/IBM@IBMAU, Michael
Perez/Austin/IBM@IBMUS, Pat Buckland/Austin/IBM@IBMUS
cc:    Brian Twichell/Austin/IBM@IBMUS, Bill Buros/Austin/IBM@IBMUS, Binh
       Hua/Austin/IBM@IBMUS, Jim Cunningham/Austin/IBM@IBMUS, Brian M
       Rzycki/Austin/IBM@IBMUS
From:  Herman Dierks/Austin/IBM@IBMUS
Subject:    Goliad performance issues on linux, results of PCI bus traces


This note is partially  regarding bug1589.   Will have to add some of this
info into that defect.
Any time you go looking for problems, you often find more than you went
looking for.   Such is probably the case here so we may end up with a few
other defects if we want to track them seperately.  We just looked at Linux
2.4, so I assume the same issues are in 2.5 but would need to be verified.

I have talked with Anton about issues 1 and 2 below so he will see about
fixing them so we can prototype the change and measure it.

Binh Hua came over and we ran a number of PCI bus traces using  Brian &
Jim's bus Analizer over several days.  (Thanks guys).
As this is just a "PCI" analizer (and not a PCI-X analizer), we could only
trace on the p660 (M2+) system.

After first day of tracing, we saw all 256 byte transfers on the bus for
Memory Read Multiple commands (MMR).
I thought those should be 512 and investigated the system FW level.
I found the FW on the machine was quite old (from 2001) and predated some
Goliad perf changes.
So I installed a 020910 level FW on the M2+.
The performance on AIX then jumped up 200 Mbits/sec.   The PCI bus analizer
trace then showed we are doing 512 byte transfers as we should be.
On AIX, this took the PCI commands from 10 down to 3 to send one packet.
These are not CPU cycles but DMA bus cycles.
Thus you can see the large affect that saving a few commands can have on
performance.
This above paragraph is just a side note, and I will not put that into the
defect.
The point of this paragraph is that the FW sets up the bridge chips based
on adapter and its very important to have the right level of FW on the
system when looking at any performance issues.

Now that the M2+ had the right FW,  we did a few more sniff tests and took
more bus traces on both AIX and then the following day on Linux.

Cutting to the chase,  based on what we see in the traces, we see a couple
of performance problems.
 1) Linux is not aligning the transmit buffer on a cache line.
       M2+ to LER performance for LINUX is 777 Mbits while for AIX it is
859 Mbits.  We have large send (TSO) disabled on AIX to make this apples to
apples.
       So there is a 82 Mbit difference (10%) here that we feel is due to
the cache alignment.  See details below.
       With large send enabled, AIX tets 943 Mbits with single session.

      The solution here is to align the transmit buffer onto a 128 byte
cache line.  This is probably being controled up in the TCP stack above the
driver.
                If we have to fix this in the driver, it would mean another
copy.

 2) Linux is not aligning the receive buffer on a cache line.
      On a number of PCI commands viewpoint,  Linux alignment is fewer PCI
commands.
     However, the bad new of the way it does the alignment is that the
memory controller will have to do  "read-modify-write" operations to RAM to
update partial cache lines.  That is very costly on the memory subsystem
and will hurt is as we scale up the number of adapters and the memory
bandwidth becomes taxed.
This may need to be a new defect on just the e1000 driver (at least for PPC
and PPC64).

3)   We need to do a second look at the number of TX and RX descriptors
fetched by the adapter on Linux. These values may be set up way too large.
     Binh thought on AIX we just move a cache line's worth at a time.
This is a secondary issue (generates bus traffic) and we need to
investigate a bit more before we open a defect on this.


DETAILS:

I will show the  PCI commands for sending (reading from memory) for AIX
first and then for Linux  2.4.  This is with correct level of FW on M2+.
PCI Commands are :       MRM  is Memory Read Multiple (IE multiple cache
lines)
                  MRL is Memory Read Line (IE one cache line of 128 bytes)
                  MR is Memory Read  (IE reading fewer bytes than one cache
line)

AIX  sending one 1514 byte packet  (859 Mbits sec rate)

      Address     PCI comand  Bytes xfered
      4800        MRM         512
      4A00        MRM         512
      4C00        MRM         490
                              -------
                              1514 bytes

Linux sending one 1514 byte packet   (777 Mbits sec rate)

      Address     PCI command Bytes xfered
      420A8       MRM         344
      42200       MRM         512
      42400       MRM         512
      42600       MRL         128
      42680       MR            18
                              -----
                              1514 bytes , total time of 14.108 micro
seconds

 So, notice what happended. On AIX we move the data in 3 PCI commands.
On Linux, due to the alignment, it took 5 operations.
The bus latency on these RIO based IO drawer machines is very long. Each of
these commands takes at least 700 nanosec to issue the command.
 It can take longer to issue the command than to transfer the bytes.
 So, we want to change Linux to align the buffer on a 128 byte cache
boundry.  That should get us parity with AIX.

Now lets look at receive side (writes to memory)


AIX receiving one 1514 byte packet

      Address     PCI command Bytes xfered
      EE800       MWI         512
      EA00        MWI         512
      EC00        MWI         384
         ED80           MW          106      (partial cache line)
                              -----
                              1514 bytes,

LINUX receiving one 1514 byte packet

      Address     PCI Command Bytes xfered
      2012        MWI         494 bytes    (partial cache line)
      2200        MWI         512
      2400        MWI         508          (partial cache line)
                                    ----------
                              1514 bytes,   total time 6.496 micro sec

Linux does the xfer in 3 PCI commands.  However, it appears that due to the
partial cache lines (one at start and one at end) that this will cause one
more read-modify-write of a cache line at the memory controller to update
the line.
We need to verify this with Pat or Mike (so I am copying them on this note)
If so, then we should probably align  the RX buffer to start on a cache
line and take the hit on one more PCI command.    Just depends on what we
want to optimize for, esp. on a busy server.




"Feldman, Scott" <scott.feldman@intel.com> on 06/12/2003 08:16:11 PM

To:    "David Gibson" <dwg@au1.ibm.com>
cc:    <linux-kernel@vger.kernel.org>, "Anton Blanchard" <anton@samba.org>,
       Nancy J Milliner/Austin/IBM@IBMUS, Herman Dierks/Austin/IBM@IBMUS,
       Ricardo C Gonzalez/Austin/IBM@ibmus
Subject:    RE: e1000 performance hack for ppc64 (Power4)



David, arch-specific code in the driver concerns me.  I would really
like to avoid any arch-specific code in the driver if at all possible.
Can we find a way to move this work to the arch-dependent areas?  This
doesn't seem to be an issue unique to e1000, so moving this up one level
should benefit other devices as well.  More questions below.

> Peculiarities in the PCI bridges on Power4 based ppc64 machines mean
> that unaligned DMAs are horribly slow.  This hits us hard on gigabit
> transfers, since the packets (starting from the MAC header) are
> usually only 2-byte aligned.

2-byte alignment is bad for ppc64, so what is minimum alignment that is
good?  (I hope it's not 2K!)  What could you do at a higher level to
present properly aligned buffers to the driver?

> The patch below addresses this by copying and realigning packets into
> nicely 2k aligned buffers.  As well as fixing the alignment that
> minimises the number of TCE lookups, and because we allocate the
> buffers pci_alloc_consistent(), we avoid setting up and tearing down
> the TCE mappings for each packet.

If I'm understanding the patch correctly, you're saying unaligned DMA +
TCE lookup is more expensive than a data copy?  If we copy the data, we
loss some of the benefits of TSO and Zerocopy and h/w checksum
offloading!  What is more expensive, unaligned DMA or TCE?

 -scott




