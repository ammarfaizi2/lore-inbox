Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281232AbRKPIKQ>; Fri, 16 Nov 2001 03:10:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281234AbRKPIKG>; Fri, 16 Nov 2001 03:10:06 -0500
Received: from AGrenoble-101-1-5-110.abo.wanadoo.fr ([80.11.136.110]:64130
	"EHLO strider.virtualdomain.net") by vger.kernel.org with ESMTP
	id <S281232AbRKPIJ5> convert rfc822-to-8bit; Fri, 16 Nov 2001 03:09:57 -0500
Message-ID: <3BF4CA77.9050307@wanadoo.fr>
Date: Fri, 16 Nov 2001 09:12:39 +0100
From: =?ISO-8859-15?Q?Fran=E7ois?= Cami <stilgar2k@wanadoo.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5) Gecko/20011012
X-Accept-Language: en-us, fr
MIME-Version: 1.0
To: Andrew Morton <akpm@zip.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: 3C905x - too much work in interrupt, follow-up
In-Reply-To: <Pine.LNX.4.33.0111160721120.6043-100000@titan.lahn.de> <3BF4BD81.C3E4A4DC@zip.com.au>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Andrew !

Here are the promised stats (I'm sorry it took so
long):

testing procedure :
each PC was rebooted at midnight on sundays, and
data was collected for 4 days and then averaged.

Network : 700 networked PCs, running different
windows versions or linux, usually with 10MBits/s
boards, some with 100MB. Network is partially switched
with 3COM 1100s and 3300s ; fiber network (100MB/s I
think [not too sure 'bout that]) between two stacks.

Machine 1
ASUS P2B-DS / Dual PII350 / 512MB RAM / 3*18GB 10KT IBM / 3C905C
[it got an upgrade] ; distro is slackware 8, kernel 2.2.19
serves as a proxy server running squid. Normal network load
during the day is around 30MBits/s or so ; the machine
transfers 1GB of data daily, which is not too much i think.
the PC uses IO-APIC.
cat /proc/interrupts always shows that the NIC pushes
3-10 times more interrupts than the timer.
aic7xxx pushes 10 times less interrupts than the NIC.
ifconfig shows that RX is 7 times less that TX

max_interrupt_work set to 20 :
eth0 : too much work in interrupt appears 21 times a day

max_interrupt_work set to 32 :
eth0 : too much work in interrupt appears 8 times a day

max_interrupt_work set to 64 :
eth0 : too much work in interrupt appears around 2 times a day

max_interrupt_work set to 128 :
eth0 : too much work in interrupt never appears in the log.


Machine 2
ABIT LX6 / PII300 / 128MB RAM / 3C905C
hard drives [all ide] :
IBM 8GB as hda
Maxtor 80GB 5400T as hdb
Maxtor 60GB 5400T as hdc
distro is slackware 8, kernel 2.4.4
serves as an ftp server running proftpd ; sometimes uses
samba to send data to a W2K-server.
Normal network load is 500MByte per day for RX, and the same
for TX.

max_interrupt_work set to 20 :
eth0 : too much work in interrupt appears 17 times a day

max_interrupt_work set to 32 :
eth0 : too much work in interrupt appears 7 times a day

max_interrupt_work set to 64 :
eth0 : too much work in interrupt appears around 2 times a day

max_interrupt_work set to 128 :
eth0 : too much work in interrupt never appears in the log.


Machine 3
ABIT BH6 / PII400 / 128MB RAM / 3C905C / Tekram DC-390F
hard drives :
IBM 9GB as sda
IBM 4GB as sdb
distro is slackware 8, kernel 2.2.19
tested as a proxy server instead of the dual PII350

max_interrupt_work set to 20 :
eth0 : too much work in interrupt appears 5 times a day

max_interrupt_work set to 32 :
eth0 : too much work in interrupt appears 4 times a day

max_interrupt_work set to 64 :
eth0 : too much work in interrupt never appears in the log.

I hope that helps... keep me informed, please.

François Cami


Andrew Morton wrote [20 April 2001]:
 >
 > Vibol Hou wrote:
 > ...
 >
 > > Apr 17 16:10:12 omega kernel: eth0: Too much work in interrupt, 
status e401.
 >
 > I got that one too, PC is ASUS P2B-DS with two PII-350, 384MB RAM,
 > 3C905B.
If you were getting this message occasionally, and if increasing the
max_interrupt_work module parm makes it stop, and everything
is always working fine, then it's an OK thing to do.
Question is: why is it happening?  We're failing to get out
of the interrupt loop after 32 loops.  Each loop can reap
up to 16 transmitted packets and 32 received packets.
That's a lot.
My suspicion is that something else in the system is
causing the NIC interrupt routine to get held up for long
periods of time.  It has to be another interrupt.
All reporters of this problem (ie: both of them) were using
aic7xx SCSI.  I wonder if that driver can sometimes spend a
long time in its interrupt routine.  Many times.  Rapidly.
Very odd.
Ah.  SMP.  Perhaps the other CPU is generating the transmit
load, some other interrupt source is slowing down *this*
CPU.
Could you test something for me?  Try *decreasing* the
value of max_interrupt_work.  See if that increases
the frequency of the message.  Then, it if does, try to
correlate the occurence of the message with some other
form of system activity (especially disk I/O).
Thanks.

