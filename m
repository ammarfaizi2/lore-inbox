Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269435AbRHGVDk>; Tue, 7 Aug 2001 17:03:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269438AbRHGVDb>; Tue, 7 Aug 2001 17:03:31 -0400
Received: from [206.166.249.112] ([206.166.249.112]:62731 "EHLO
	srv-exchange2.adtran.com") by vger.kernel.org with ESMTP
	id <S269435AbRHGVDV>; Tue, 7 Aug 2001 17:03:21 -0400
Message-ID: <3B70574B.C2B1B6F1@adtran.com>
Date: Tue, 07 Aug 2001 16:02:04 -0500
From: Ron Flory <ron.flory@adtran.com>
Organization: Adtran
X-Mailer: Mozilla 4.77 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
CC: lkml <linux-kernel@vger.kernel.org>, ron.flory@adtran.com
Subject: Kernel 2.4.6 & 2.4.7 networking performance: seeing serious delays in 
 TCP layer depending upon packet length
In-Reply-To: <Pine.LNX.4.21.0108061954001.11203-100000@freak.distro.conectiva> <20010807131857.A13210@krispykreme>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)@localhost.localdomain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This email contains 99-columns of information:

[1.] One line summary of the problem:

 Depending upon length of TCP socket write requests, I'm seeing 
extremely long TCP delays, limiting throughput to only 25 datagrams 
per second.  Data blocks above a 'magic' length have a much higher 
throughput than shorter blocks, which is counter-intuitive.


[2.] Full description of the problem/report:

 Compared to a normal 35 microseconds, I am seeing TCP stack delays 
on the order of 35 millisec when socket write lengths are BELOW a 
certain value.  

 Depending upon whether I use an actual ethernet or loopback device, 
this 'slow' packet length threshold is at 1447 bytes (Ethernet), or 
16383 bytes (loopback).  For some reason, the sending stack is delaying,
and/or or waiting for an ACK between a 'short' followed by a 'longer' 
write TCP datagram.

 For all packets >= these magic lengths (1448/16384 respectively), the 
TCP stack does not wait for this ACK, and immediately sends the next 
datagram.  For packets differing by only one byte in length, I see the 
packet rate jump from only 25 per second to several thousand per second.

 In the case of the loopback device, simply changing the packet length 
from 16383 to 16384 bytes results in a max transfer rate of 25 vs. 4250
packets per second.

 I think Alan will be interested in looking into this...

--------------- more (too much) background ----------------

 To test various IP/ATM/FrameRelay network systems and interfaces, I 
wrote a small client/server app to pass as much network traffic as 
possible across a simulated customer network in our lab.

 The sequence is relatively simple:

 - create server.
 - create client. (client contacts server, transfers data).

 *Server:

  wait for client to request our max packet length (8 bytes)
  respond with our max packet length (8 bytes).

  while (1)
  {
    1. wait for client request packet payload (8 bytes).
    2. Respond with ACK message indicating length (8 bytes)
    3. send all requested data to client (1..128Kbytes).
  }


 *Client:

  contact server, request max packet length (8 bytes)
  read response from server (8 bytes).

  while (1)
  {
    1. request payload packet from server (8 bytes).
    2. accept ACK packet (with length) from server (8 bytes).
    3. read all requested data from server (1..128Kbytes).
  }

 The test application can be provided if you don't have 
alternative (independant) test tools available.


[3.] Keywords (i.e., modules, networking, kernel):

 networking, sockets, performance, benchmark, kernel, TCP, IP


[4.] Kernel version (from /proc/version):

 Both Linux x86 2.4.6 and 2.4.7, non-patched sources downloaded from 
kernel.org, compiled locally.


[5.] Output of Oops.. message with symbolic information resolved
     (see Kernel Mailing List FAQ, Section 1.5):

 No oops, just delay...


[6.] A small shell script or example program which triggers the
     problem (if possible)

 application tar-archive available upon request.  not too small.


[7.] Environment

 Local network, on a network switch, both Linux machines running 
RedHat 7.1 (x86), One machine is SCSI-based, the other is all-IDE.  
Disk subsystem not relevant.


[7.1.] Software (add the output of the ver_linux script here)

 [script is hosed]

  gcc 2.96 ('updated' versions from RH).
  binutils 2.10.91.0.2
  Linux C Lib 2.2.so ('updated' versions from RH).
  libc.so.6 => /lib/i686/libc.so.6 (0x40021000)
  /lib/ld-linux.so.2 => /lib/ld-linux.so.2 (0x40000000)


[7.2.] Processor information (from /proc/cpuinfo):

 problem seen on several SMP/uniprocessor systems:


[7.3.] Module information (from /proc/modules):

 One machine uses Tulip network modules, other uses 8139too. 
This problem is present in the loopback device as well, so physical drivers 
are probably not an issue.  SMC-Ultra is eth1 (not used in this case).

Module                  Size  Used by
smc-ultra               4992   1 (autoclean)
8390                    6928   0 (autoclean) [smc-ultra]
tulip                  39520   1 (autoclean)
st                     26640   0 (unused)


[7.4.] SCSI information (from /proc/scsi/scsi):

 N/A


[7.5.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):

[X.] Other notes, patches, fixes, workarounds:

 Protocol is TCP (SOCK_STREAM).

NOTE: machine 172.22.112.101 (shown here as .101) is the server, .100 is the client.

 Ethereal log of short/slow/bad packets (1447 bytes): (time is inter-packet)

 # Time      Src  Dst Port         Info
 1 0.000000 .100 .101 41359 > 4180 [SYN] Seq=4186558034 Ack=0 Win=5840 Len=0
 2 0.000083 .101 .100 4180 > 41359 [SYN, ACK] Seq=124141118 Ack=4186558035 Win=5792 Len=0
 3 0.000117 .100 .101 41359 > 4180 [ACK] Seq=4186558035 Ack=124141119 Win=5840 Len=0
 4 0.000061 .100 .101 41359 > 4180 [PSH, ACK] Seq=4186558035 Ack=124141119 Win=5840 Len=8
 5 0.000061 .101 .100 4180 > 41359 [ACK] Seq=124141119 Ack=4186558043 Win=5792 Len=0
 6 0.002295 .101 .100 4180 > 41359 [PSH, ACK] Seq=124141119 Ack=4186558043 Win=5792 Len=8
 7 0.000098 .100 .101 41359 > 4180 [ACK] Seq=4186558043 Ack=124141127 Win=5840 Len=0
 8 0.000111 .100 .101 41359 > 4180 [PSH, ACK] Seq=4186558043 Ack=124141127 Win=5840 Len=8
 9 0.000062 .101 .100 4180 > 41359 [PSH, ACK] Seq=124141127 Ack=4186558051 Win=5792 Len=8
10 0.036399 .100 .101 41359 > 4180 [ACK] Seq=4186558051 Ack=124141135 Win=5840 Len=0  <- DELAY
11 0.000074 .101 .100 4180 > 41359 [PSH, ACK] Seq=124141135 Ack=4186558051 Win=5792 Len=1447
12 0.000362 .100 .101 41359 > 4180 [ACK] Seq=4186558051 Ack=124142582 Win=8682 Len=0
13 0.000279 .100 .101 41359 > 4180 [FIN, ACK] Seq=4186558051 Ack=124142582 Win=8682 Len=0
14 0.000073 .101 .100 4180 > 41359 [FIN, ACK] Seq=124142582 Ack=4186558052 Win=5792 Len=0
15 0.000099 .100 .101 41359 > 4180 [ACK] Seq=4186558052 Ack=124142583 Win=8682 Len=0

 Ethereal log of long/fast/good packets (1448 bytes): (time is inter-packet)

 # Time      Src  Dst Port         Info
 1 0.000000 .100 .101 41363 > 4180 [SYN] Seq=4268751129 Ack=0 Win=5840 Len=0
 2 0.000077 .101 .100 4180 > 41363 [SYN, ACK] Seq=189815001 Ack=4268751130 Win=5792 Len=0
 3 0.000116 .100 .101 41363 > 4180 [ACK] Seq=4268751130 Ack=189815002 Win=5840 Len=0
 4 0.000060 .100 .101 41363 > 4180 [PSH, ACK] Seq=4268751130 Ack=189815002 Win=5840 Len=8
 5 0.000038 .101 .100 4180 > 41363 [ACK] Seq=189815002 Ack=4268751138 Win=5792 Len=0
 6 0.002467 .101 .100 4180 > 41363 [PSH, ACK] Seq=189815002 Ack=4268751138 Win=5792 Len=8
 7 0.000109 .100 .101 41363 > 4180 [ACK] Seq=4268751138 Ack=189815010 Win=5840 Len=0
 8 0.000122 .100 .101 41363 > 4180 [PSH, ACK] Seq=4268751138 Ack=189815010 Win=5840 Len=8
 9 0.000061 .101 .100 4180 > 41363 [PSH, ACK] Seq=189815010 Ack=4268751146 Win=5792 Len=8
10 0.000034 .101 .100 4180 > 41363 [ACK] Seq=189815018 Ack=4268751146 Win=5792 Len=1448 
11 0.000351 .100 .101 41363 > 4180 [ACK] Seq=4268751146 Ack=189816466 Win=8688 Len=0
12 0.000520 .100 .101 41363 > 4180 [FIN, ACK] Seq=4268751146 Ack=189816466 Win=8688 Len=0
13 0.000065 .101 .100 4180 > 41363 [FIN, ACK] Seq=189816466 Ack=4268751147 Win=5792 Len=0
14 0.000095 .100 .101 41363 > 4180 [ACK] Seq=4268751147 Ack=189816467 Win=8688 Len=0

 Line #9 in both above represent the server (.101) sending an 8-byte descriptor block 
back to the client (.100), informing him how much data will be following in the next 
'write' (payload block).  The payload 'write' immediately follows (no other delays or 
processing present).

 Of particular interest is line #10 of each above.  

 For some reason, in the case of the 'short' packet, the server machine waits for a
TCP ACK from the client machine (delaying 36 millisec), which does not happen if the packet 
is just 1-byte longer, in which case the server immediately follows the 8-byte block with the 
1448-byte payload.

 I realize there is probably some relationship with the 1500 MTU of ethernet, but I do not 
see the relation with the 16k slow/fast boundary seen with the loopback device, or when the 
server/client are on the same machine.  In this case, all packets < 16384 bytes wait approx
36 milli-sec for the client to ACK before sending the subsequent payload data block.


Thanks, - i hope this isn't a well known issue that 'just has to be done this way'...

ron
