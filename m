Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266738AbRGKQ3S>; Wed, 11 Jul 2001 12:29:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266742AbRGKQ3L>; Wed, 11 Jul 2001 12:29:11 -0400
Received: from stlaurent.mindstep.com ([216.18.127.174]:6150 "EHLO
	stlaurent.mindstep.com") by vger.kernel.org with ESMTP
	id <S266738AbRGKQ3B>; Wed, 11 Jul 2001 12:29:01 -0400
Message-ID: <065f01c10a3f$cbe849a0$0400a8c0@swan>
From: "Herve Masson" <herve@mindstep.com>
To: <linux-kernel@vger.kernel.org>
Cc: <ak@muc.de>
Subject: PROBLEM: csum_partial() / i386 does not handle unaligned address with empty region properly
Date: Wed, 11 Jul 2001 12:29:26 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I hope I knock on the right door...

Herve MASSON                    herve@mindstep.com
MindStep Corp.

----


[1.] One line summary of the problem:
     csum_partial()/i386 does not handle unaligned address with empty region properly

[2.] Full description of the problem/report:

     First, I don't know if this is a BUG or if that behavior has been left
     intentionally.

     When we call the csum_partial() function with an empty
     region (i.e. len=0), its code (arch/i386/lib/checksum.S) behaves 
     differently when the given address is aligned (to 32 bits) or not.
     When it's aligned, the function returns 0, which is what I would expect.
     When it's not, it seems that it returns the first byte of the buffer,
     while I would expect it to return zero as well.
     It's not clear to me if it's calling code's responsibility to check the
     len parameter, but I know software that assume csum_partial does the test
     in all case (IPVS is the one where I disovered the problem).

[3.] Keywords:  Networking, i386, Arch, checksum

[4.] Kernel version (from /proc/version):

     Linux version 2.4.5 (root@linux) (gcc version 2.96 20000731 (Red Hat Linux 7.1 2.96-81))
     #92 SMP Sat Jul 7 19:28:46 EDT 2001

[6.] A small shell script or example program which triggers the
     problem (if possible)

     static char data[10]={9,4,9,4,9,4};
     int csum;

     csum=csum_partial(data,0,0);
     printk("****** CSUM %x = %d\n",data,csum);
     csum=csum_partial(data+2,0,0);
     printk(0, "****** CSUM %x = %d\n",data+2,csum);
     
     First message will report an aligned address and a nul checksum.
     Second message will report an unaligned address and a checksum value of 9.

[7.] Environment
[7.1.] Software (add the output of the ver_linux script here)

    If some fields are empty or look unusual you may have an old version.
    Compare to the current minimal requirements in Documentation/Changes.
     
    Linux linux 2.4.5 #92 SMP Sat Jul 7 19:28:46 EDT 2001 i686 unknown
 
    Gnu C                  2.96
    Gnu make               3.79.1
    binutils               2.10.91.0.2
    util-linux             2.10s
    mount                  2.10r
    modutils               2.4.2
    e2fsprogs              1.19
    PPP                    2.4.0
    isdn4k-utils           3.1pre1
    Linux C Library        2.2.2
    Dynamic linker (ldd)   2.2.2
    Procps                 2.0.7
    Net-tools              1.57
    Console-tools          0.3.3
    Sh-utils               2.0
    Modules Loaded         ip_vs_rr ip_vs_wrr ip_vs_queue ip_vs eepro100


[7.2.] Processor information (from /proc/cpuinfo):

    processor       : 0
    vendor_id       : AuthenticAMD
    cpu family      : 6
    model           : 3
    model name      : AMD Duron(tm) Processor
    stepping        : 1
    cpu MHz         : 756.753
    cache size      : 64 KB
    fdiv_bug        : no
    hlt_bug         : no
    f00f_bug        : no
    coma_bug        : no
    fpu             : yes
    fpu_exception   : yes
    cpuid level     : 1
    wp              : yes
    flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov
                      pat pse36 mmx fxsr syscall mmxext 3dnowext 3dnow
    bogomips        : 1510.60


[7.3.] Module information (from /proc/modules):

    ip_vs_rr                1616   8 (autoclean)
    ip_vs_wrr               1936   3 (autoclean)
    ip_vs_queue             6464   0 (unused)
    ip_vs                  70880  13 (autoclean) [ip_vs_rr ip_vs_wrr ip_vs_queue]
    eepro100               16368   1 (autoclean)

[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)

    (I believe this is not relevant in that case)

[7.5.] PCI information ('lspci -vvv' as root)


    (I believe this is not relevant in that case)

[7.6.] SCSI information (from /proc/scsi/scsi)

    (I believe this is not relevant in that case)

[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):

[X.] Other notes, patches, fixes, workarounds:

   Saddly, I don't have the knowledge to fix the problem myself
   since i386 is still cryptic to me.




