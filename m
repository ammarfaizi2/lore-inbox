Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266169AbUI1KMU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266169AbUI1KMU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Sep 2004 06:12:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267186AbUI1KMU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Sep 2004 06:12:20 -0400
Received: from eth1023.nsw.adsl.internode.on.net ([150.101.206.254]:52798 "EHLO
	naya.ABOOSPLANET.COM") by vger.kernel.org with ESMTP
	id S266169AbUI1KME (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Sep 2004 06:12:04 -0400
From: "Aboo Valappil" <aboo@aboosplanet.com>
To: <linux-kernel@vger.kernel.org>
Subject: Switch back to Real mode and then boot strap
Date: Tue, 28 Sep 2004 20:11:59 +1000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
Thread-Index: AcSlPCbAQLoATotIQPmiGy8T1r1kWwAAPl+w
In-Reply-To: <41592C64.3030409@yahoo.com.au>
Message-ID: <NAYASmLAztxc1o8yfog00000008@naya.ABOOSPLANET.COM>
X-OriginalArrivalTime: 28 Sep 2004 10:12:02.0558 (UTC) FILETIME=[993DE9E0:01C4A543]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

I am new to this mailing list ... Need some help, PLEASE :)

I am running redhat Linux with kernel 2.4.21-4.EL.

Basically I have a requirement of re-booting ( Without really rebooting )
the OS from the hard disk ( even if a floppy is present or a bootable CD-ROM
is present).  Update CMOS to change the boot sequence is not an option for
my requirement.

My idea is to read the MBR off the hard disk and then jump to the memory
location of the MBR after switching to real mode. The thing I do not want to
do is to jump to real address FFFF:0000 because it is going to select the
boot device ( Where this selection, I do not have any control when I
rebooted )

I found a function in process.c ( arch/i386/kernel/ ) called
machine_real_restart(code,length) where you could give the address of a real
mode routine. If I call this function (ofcource from a kernel module) with
address pointed to a piece of code which has ljmp $0xffff,$0x0, the system
reboots fine. I WAS VERY EXCITED TO SEE THIS.

Proceeding to my next step, I generated an array of machine code (.code16),
where I use INT 13h to read the first sector off the hard drive to
0000:7c00, and then ljmp to 0000:7c000. I used the above kernel function to
call this. I am was so disappointed to see the SYSTEM JUST HANGS :( .

Here is the routine I am using ...

.code16
xorw %ax,%ax
movw %ax,%ds
movw %ax,%ss
movw %ax,%es
movw $0xffff, %sp
movw $0x201,%ax
movw $0x01,%cx
movw $0x7c00, %bx
movw $0x80,%dx
int $0x13
movb $0x0e,%ah
movb $0x5A,%al
int $0x10
ljmp $0x0000,$0x7c00

Here the code for device IOCTL for my character device.

int device_ioctl( struct inode *inode, struct file *file, unsigned int i_n,
unsigned long i_p )
{

   static unsigned char jbios [] =    {

 0x31 ,0xc0 ,0x8e ,0xd8 ,0x8e ,0xd0 ,0x8e ,0xc0 ,0xbc ,0xff ,0xff ,0xb8
,0x01 ,0x02 ,0xb9 ,0x01 ,0x00 ,0xbb ,0x00 ,0x7c ,0xba ,0x80 ,0x00 ,0xcd
,0x13 ,0xb4 ,0x0e ,0xb0 ,0x5a ,0xcd ,0x10 ,0xea ,0x00 ,0x7c ,0x00 ,0x00 };

 if (  i_n == 999 ) {
     machine_real_restart(jbios,36);
 }
}


When I call the ioctl, it just hangs. If I replace the code with only a ljmp
$0xffff,0x0 instruction it reboots the computer as it should.

Any ideas, what I am doing wrong here ?

Thanks

Aboo



