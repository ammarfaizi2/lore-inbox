Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288801AbSBDI5x>; Mon, 4 Feb 2002 03:57:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288804AbSBDI5o>; Mon, 4 Feb 2002 03:57:44 -0500
Received: from elin.scali.no ([62.70.89.10]:13320 "EHLO elin.scali.no")
	by vger.kernel.org with ESMTP id <S288801AbSBDI5e>;
	Mon, 4 Feb 2002 03:57:34 -0500
Message-ID: <3C5E4CDE.9B60F077@scali.com>
Date: Mon, 04 Feb 2002 09:57:02 +0100
From: Steffen Persvold <sp@scali.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.9-ac18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: mingo@elte.hu
CC: Jens Axboe <axboe@suse.de>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: Short question regarding generic_make_request()
In-Reply-To: <Pine.LNX.4.33.0202040130200.19055-100000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> 
> On Sun, 3 Feb 2002, Steffen Persvold wrote:
> 
> > Ok, the reason I'm asking is that I receive a request from a remote
> > machine on interrupt level (tasklet) and want to submit this to the
> > local device. The reason I'm using a tasklet instead of a kernel
> > thread is that somewhere between RedHat's 2.4.3-12 and 2.4.9-12
> > kernels the latency of waking up a kernel thread increased (using a
> > semaphore method similar to the one used in loop.c). I don't know why
> > this happened, but I guess that if I still could use a kernel thread
> > there wouldn't be any problems using generic_make_request().
> 
> you really want a kernel thread for this. The wakeup latency of a kernel
> thread is on the order of 2-3 usecs (context switch overhead included),
> nothing compared to usual block IO costs.
> 
> you say that the latency of waking up a kernel thread has increased - by
> how much?
> 

Well, I might be analyzing it wrong but, the same driver that I'm gonna use for this shared disk
stuff can also be enabled for ethernet emulation. The reason I'm saying that the latency of waking
up a kernel thread increased somewhere between RedHat's 2.4.3 and 2.4.9 is that with the packet
receive handler running in a tasklet I get these ping-pong numbers (measured with /bin/ping) :

[root@damd1 root]# ping sci4
PING sci4 (192.168.4.4) from 192.168.4.3 : 56(84) bytes of data.
64 bytes from sci4 (192.168.4.4): icmp_seq=0 ttl=255 time=238 usec
64 bytes from sci4 (192.168.4.4): icmp_seq=1 ttl=255 time=176 usec
64 bytes from sci4 (192.168.4.4): icmp_seq=2 ttl=255 time=200 usec
64 bytes from sci4 (192.168.4.4): icmp_seq=3 ttl=255 time=177 usec
64 bytes from sci4 (192.168.4.4): icmp_seq=4 ttl=255 time=172 usec
64 bytes from sci4 (192.168.4.4): icmp_seq=5 ttl=255 time=156 usec
64 bytes from sci4 (192.168.4.4): icmp_seq=6 ttl=255 time=160 usec
64 bytes from sci4 (192.168.4.4): icmp_seq=7 ttl=255 time=177 usec
64 bytes from sci4 (192.168.4.4): icmp_seq=8 ttl=255 time=173 usec

For simplicity I'll say ~200usec. When I change the receive handler from a tasklet to a kernel
thread, the numbers look like this :

[root@damd1 root]# ping sci4
PING sci4 (192.168.4.4) from 192.168.4.3 : 56(84) bytes of data.
64 bytes from sci4 (192.168.4.4): icmp_seq=0 ttl=255 time=4.215 msec
64 bytes from sci4 (192.168.4.4): icmp_seq=1 ttl=255 time=5.728 msec
64 bytes from sci4 (192.168.4.4): icmp_seq=2 ttl=255 time=3.825 msec
64 bytes from sci4 (192.168.4.4): icmp_seq=3 ttl=255 time=6.521 msec
64 bytes from sci4 (192.168.4.4): icmp_seq=4 ttl=255 time=5.700 msec
64 bytes from sci4 (192.168.4.4): icmp_seq=5 ttl=255 time=5.666 msec
64 bytes from sci4 (192.168.4.4): icmp_seq=6 ttl=255 time=6.495 msec
64 bytes from sci4 (192.168.4.4): icmp_seq=7 ttl=255 time=5.631 msec
64 bytes from sci4 (192.168.4.4): icmp_seq=8 ttl=255 time=6.480 msec


A bit up and down, but all of them in the msec range wich is means that the ping-pong latency has
increased atleast 100 times.

This might of course be related to the network stack (i.e it doesn't like to netif_rx() from user
context, or just a high turnaround time when trying to send the response) but on 2.4.3-12 it didn't
behave like this. The strange thing is that when I run a network benchmark such as netperf, I get
nice numbers on UDP bandwith (one-way traffic) :

(with kernel thread):
UDP UNIDIRECTIONAL SEND TEST to sci4
Socket  Message  Elapsed      Messages                
Size    Size     Time         Okay Errors   Throughput
bytes   bytes    secs            #      #   MBytes/sec

262144   32768   10.00       55958      0     174.92
262144           10.00       55925            174.82

(with tasklet):
UDP UNIDIRECTIONAL SEND TEST to sci4
Socket  Message  Elapsed      Messages                
Size    Size     Time         Okay Errors   Throughput
bytes   bytes    secs            #      #   MBytes/sec

262144   32768   10.01       53648      0     167.55
262144           10.01       53648            167.55



The TCP stack seems to like it better with tasklets :

(with kernel thread):
TCP STREAM TEST to sci4
Recv   Send    Send                          
Socket Socket  Message  Elapsed              
Size   Size    Size     Time     Throughput  
bytes  bytes   bytes    secs.    MBytes/sec  

262144 262144 262144    10.02      16.24   

(with tasklet):
TCP STREAM TEST to sci4
Recv   Send    Send                          
Socket Socket  Message  Elapsed              
Size   Size    Size     Time     Throughput  
bytes  bytes   bytes    secs.    MBytes/sec  

262144 262144 262144    10.00     116.00   

Regards,
-- 
  Steffen Persvold   | Scalable Linux Systems |   Try out the world's best
 mailto:sp@scali.com |  http://www.scali.com  | performing MPI implementation:
Tel: (+47) 2262 8950 |   Olaf Helsets vei 6   |      - ScaMPI 1.13.8 -
Fax: (+47) 2262 8951 |   N0621 Oslo, NORWAY   | >320MBytes/s and <4uS latency
