Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132601AbRDUNHz>; Sat, 21 Apr 2001 09:07:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132604AbRDUNHp>; Sat, 21 Apr 2001 09:07:45 -0400
Received: from WARSL401PIP3.highway.telekom.at ([195.3.96.75]:18722 "HELO
	email02.aon.at") by vger.kernel.org with SMTP id <S132601AbRDUNHb>;
	Sat, 21 Apr 2001 09:07:31 -0400
Message-ID: <3AE1860A.390E301@violin.dyndns.org>
Date: Sat, 21 Apr 2001 15:07:22 +0200
From: Hermann Himmelbauer <dusty@violin.dyndns.org>
Reply-To: dusty@strike.wu-wien.ac.at
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: APIC-Errors+Crashes on GA 586DX, 2.2.17/2.4.3
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I am using for my Internet-Gateway a dual Pentium MMX 200Mhz with a
Gigabyte 586DX Motherboard (with the Intel 430HX Chipset). The last year
I used Linux-2.2.16,2.2.17 with it and had several hangs of the network
and ISDN subsystem.

The network dies like this (when copying huge amount of data):
Feb  3 11:58:03 violin kernel: eth0: Interrupt posted but not delivered
-- IRQ blocked by another device?
Feb  3 11:58:03 violin kernel:   Flags; bus-master 1, full 0; dirty 16
current 16.
Feb  3 11:58:03 violin kernel:   Transmit list 00000000 vs. c13dfa00.
Feb  3 11:58:03 violin kernel:   0: @c13dfa00  length 8000006e status
0001006e
...

and the isdn subsystem like this:
Jan 27 00:41:15 violin kernel: isdn_tx_timeout dev ippp0 dialstate 0
Jan 27 00:41:28 violin kernel: ippp0: dialing 2 194040...
Jan 27 00:41:28 violin kernel: isdn: HiSax,ch0 cause: E001B

Although there is no direct hint to an APIC problem, I read in several
newsgroup articles that these two errors refer to APIC errors.

They system is still usable after such an error, only that eth0/isdn is 
not accessible, even if I reload the modules. The only solution
is a reboot.

Well - some days ago I tried to switch to 2.4.3, hoping that these
errors will be gone then. The first thing that I noticed was that I got
thousands of lines like this:

Apr 22 16:19:31 violin kernel: APIC error on CPU0: 04(00)

At first I ignored it and started to test the stability by copying huge
amounts of data via NFS over eth0. After around 500MB (and 45000 APIC
Errors!) the isdn subsystem died:
Apr 18 16:32:12 violin kernel: isdn_tx_timeout dev ippp0 dialstate 0
Apr 18 16:32:12 violin kernel: ippp0: all channels busy - requeuing!
...

After around 10 minutes the whole
system crashed, leaving this in the syslog:
Apr 18 16:59:15 violin kernel: APIC error on CPU1: 02(00)
Apr 18 16:59:15 violin kernel: APIC error on CPU0÷230Ý:'217û8226^C^@^@^
A^@H^@R*¬Öf^Máj225L`cÛ½235é^A^@^@^@203$^A^@Å!^C9Å!^C9ÿÿÿÿº
þ8^A^@+¢ý8,¢ý8÷230Ý:"217û8^^^K^@^@^A^@H^@aÑõ2009¢B1kp^BÄ¬:¼
...

I did a little statistic of the occurence of the APIC-errors:
APIC error on CPU0: 01(00)    650
APIC error on CPU0: 02(00)   9037
APIC error on CPU0: 04(00)    916
APIC error on CPU0: 06(00)      1
APIC error on CPU0: 06(04)      1
APIC error on CPU0: 08(00)   5369
APIC error on CPU0: 08(02)      1
APIC error on CPU0: 09(00)      3
APIC error on CPU0: 0a(00)      4
APIC error on CPU0: 0c(00)      1
APIC error on CPU0: 40(00)     60
APIC error on CPU0: 48(00)     23
APIC error on CPU1: 00(00)     13
APIC error on CPU1: 01(00)   5398
APIC error on CPU1: 02(00)   9533
APIC error on CPU1: 02(02)      5
APIC error on CPU1: 04(00)   6861
APIC error on CPU1: 08(00)   7836
APIC error on CPU1: 08(01)      7
APIC error on CPU1: 08(02)      1
APIC error on CPU1: 08(04)      1
APIC error on CPU1: 08(08)      1
APIC error on CPU1: 09(00)      5
APIC error on CPU1: 0a(00)     17
APIC error on CPU1: 0c(00)     23

Following the advice of Donald Becker he gave in some newsgroup I
restarted the
kernel with the "noapic" parameter. The strange thing is that the APIC
errors are still there, at least there are a lot less than before,
moreover the system seems slower but at least more stable. BTW, why are
there still APIC errors although there are no interrupts assigned to
CPU1 (as seen in /proc/interrupts).

I next tried to find out what triggers these APIC errors:

Without "noapic" kernel parameter:
The Errors are triggered by a certain amount of interrupts, whatever
device produces interrupts. 

With "noapic":
It seems as if those errors are mostly triggered by NFS. When I copy the
same
amount of data with FTP, there are a lot less Errors. (E.g. for 500MB
there
are 40 with NFS and only 2 with FTP). 

What I wonder is why linux outputs a line like this (with noapic):
<4>Intel MultiProcessor Specification v1.1
<4>    Virtual Wire compatibility mode.

although the board seems to be capable of MPS 1.4 (as there is a Bios
option "MPS 1.4 for single Processor).

The following Hardware is in the system:
3com905b, ISDN AVM Fritz!, 128MB RAM, IBM 36GB HD, some SCSI-Devices
(HD,CDROM,Tape in an external case) and a very old monochrome graphics
card. Perhaps this old graphics adapter is a problem?

It would be somehow sad to give away the board or use it as a single CPU
board, so do you perhaps have any clue of how to get rid of these
problems?

If you need any further information that would help to fix this, so
please tell me.


		Best Regards,
		Hermann Himmelbauer

-- 
 ,_,
(O,O)     "There is more to life than increasing its speed."
(   )     -- Gandhi
-"-"--------------------------------------------------------------
