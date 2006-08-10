Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161346AbWHJPe0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161346AbWHJPe0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 11:34:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161351AbWHJPe0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 11:34:26 -0400
Received: from spirit.analogic.com ([204.178.40.4]:31751 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP
	id S1161346AbWHJPeY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 11:34:24 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
X-OriginalArrivalTime: 10 Aug 2006 15:34:22.0085 (UTC) FILETIME=[73CF4B50:01C6BC92]
Content-class: urn:content-classes:message
Subject: Network compatibility and performance
Date: Thu, 10 Aug 2006 11:34:23 -0400
Message-ID: <Pine.LNX.4.61.0608101131530.4239@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Network compatibility and performance
Thread-Index: Aca8knPWNC1BGSk0SiOkX8B68snd+A==
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Linux kernel" <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

Network throughput is seriously defective with linux-2.6.16.24
if the length given to 'write()' is a large number.

Given this code on a connected socket........

//-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
//
//  Copyright(c)  2005  Analogic Corporation    (rjohnson@analogic.com)
//
//  This program may be distributed under the GNU Public License
//  version 2, as published by the Free Software Foundation, Inc.,
//  59 Temple Place, Suite 330 Boston, MA, 02111.
//
//-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <stdint.h>
#include <signal.h>
#include <string.h>
#include <stdarg.h>
#include <errno.h>
#include <fcntl.h>
#include <netinet/in.h>
#include <netinet/tcp.h>
#include <sys/poll.h>

#define BUF_LEN 0x1000
#define FAIL -1

//-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
//
//   This sends a message that could exceed the size of the network buffers.
//   It returns 0 if everything went okay, and FAIL if not.
//
int32_t sender(int32_t fd, void *buf, size_t len)
{
     int32_t ret_val;
     uint8_t *cp;
     cp = (uint8_t *) buf;
     while(len) {
         if((ret_val = write(fd, cp, MIN(len, BUF_LEN))) == FAIL) {
             if(errno == EAGAIN)
                 continue;
             return ret_val;
         }
         len -= ret_val;
         cp  += ret_val;
     }
     return 0;
}

It used to work quite well with:

     while(len) {
         if((ret_val = write(fd, cp, len)) == FAIL) {
                 return ret_val;
         }
         len -= ret_val;
         cp  += ret_val;
     }

The network socket layer would return the amount of bytes
actually sent and the code would walk its way up through the
buffer. This was the expected behavior for many years.

Then after about Linux-2.6.8, I needed to do:

     while(len) {
         if((ret_val = write(fd, cp, len)) == FAIL) {
             if(errno == EAGAIN)
                 continue;
             return ret_val;
         }
         len -= ret_val;
         cp  += ret_val;
     }

This was because Linux would claim to run out of resources
even though there was nothing else running on the system.

Now at Linux-2.6.16.24, the code needed to be further modified
to:
     while(len) {
         if((ret_val = write(fd, cp, MIN(len, 0x1000))) == FAIL) {
             if(errno == EAGAIN)
                 continue;
             return ret_val;
         }
         len -= ret_val;
         cp  += ret_val;
     }

... or else it would spin <forever> returning 0 with no errno set.
In all cases, these problems exist when 'len' is a large value, perhaps
0x01000000, much greater than Linux could ever find an available
buffer for. Linux used to send what it could. Now it will just fail to
send anything at all, returning 0 if it 'feels' like it doesn't want
to bother. This is not good. With the hacked code, the data throughput
is about 100,000 bytes per second on a dedicated link. The previous
code ran 112,000 bytes per second. Once the 'errno' happens, the
network stumbles to a measley 12,000 bytes per second. This
breaks our applications.

processor	: 0
vendor_id	: GenuineIntel
cpu family	: 15
model		: 2
model name	: Intel(R) Xeon(TM) CPU 2.40GHz
stepping	: 9
cpu MHz		: 2399.809
cache size	: 512 KB
physical id	: 0
siblings	: 2
core id		: 0
cpu cores	: 1
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid xtpr
bogomips	: 4804.62

processor	: 1
vendor_id	: GenuineIntel
cpu family	: 15
model		: 2
model name	: Intel(R) Xeon(TM) CPU 2.40GHz
stepping	: 9
cpu MHz		: 2399.809
cache size	: 512 KB
physical id	: 0
siblings	: 2
core id		: 0
cpu cores	: 1
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid xtpr
bogomips	: 4798.10

processor	: 2
vendor_id	: GenuineIntel
cpu family	: 15
model		: 2
model name	: Intel(R) Xeon(TM) CPU 2.40GHz
stepping	: 9
cpu MHz		: 2399.809
cache size	: 512 KB
physical id	: 3
siblings	: 2
core id		: 0
cpu cores	: 1
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid xtpr
bogomips	: 4798.06

processor	: 3
vendor_id	: GenuineIntel
cpu family	: 15
model		: 2
model name	: Intel(R) Xeon(TM) CPU 2.40GHz
stepping	: 9
cpu MHz		: 2399.809
cache size	: 512 KB
physical id	: 3
siblings	: 2
core id		: 0
cpu cores	: 1
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid xtpr
bogomips	: 4797.98

Module                  Size  Used by
parport_pc             26948  1
lp                     13480  0
parport                33608  2 parport_pc,lp
autofs4                19460  0
sunrpc                124476  1
e1000                 100276  0   <--- Intel network controller
floppy                 55524  0
sg                     33180  0
microcode              10912  0
dm_mod                 49816  0
uhci_hcd               31248  0
button                  9488  0
battery                12164  0
ac                      7940  0
ipv6                  229728  18
ext3                  114568  2
jbd                    50324  1 ext3
aic79xx               182104  3
scsi_transport_spi     22144  1 aic79xx
sd_mod                 17792  4
scsi_mod              116360  4 sg,aic79xx,scsi_transport_spi,sd_mod


MemTotal:      1164292 kB
MemFree:        438272 kB
Buffers:        131024 kB
Cached:         383516 kB
SwapCached:          0 kB
Active:         125260 kB
Inactive:       407276 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:      1164292 kB
LowFree:        438272 kB
SwapTotal:     2040244 kB
SwapFree:      2040244 kB
Dirty:               0 kB
Writeback:           0 kB
Mapped:          31780 kB
Slab:           185896 kB
CommitLimit:   2622388 kB
Committed_AS:    27872 kB
PageTables:        764 kB
VmallocTotal:   122576 kB
VmallocUsed:     11036 kB
VmallocChunk:   105676 kB
HugePages_Total:     0
HugePages_Free:      0
Hugepagesize:     4096 kB


Cheers,
Dick Johnson
Penguin : Linux version 2.6.16.24 on an i686 machine (5592.62 BogoMips).
New book: http://www.AbominableFirebug.com/
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
