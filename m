Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267203AbTAPSuQ>; Thu, 16 Jan 2003 13:50:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267200AbTAPSuQ>; Thu, 16 Jan 2003 13:50:16 -0500
Received: from host85-170.pool62211.interbusiness.it ([62.211.170.85]:20866
	"HELO gw.ir2ip.net") by vger.kernel.org with SMTP
	id <S267203AbTAPSuA>; Thu, 16 Jan 2003 13:50:00 -0500
Message-ID: <15dd01c2bd90$6c7a9b70$0201a8c0@BEDROOM2000>
From: "iw2lsi" <iw2lsi@gw.ir2ip.net>
To: <linux-kernel@vger.kernel.org>
Subject: I/O access question
Date: Thu, 16 Jan 2003 19:52:30 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
x-mimeole: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi all.

I've a question (maybe a stupid question!) about I/O access on ISA card...

I'm writing a real-time module/driver for an ISA card that simply put some
data to a 16 bit DAC... what I can't explain
myself is why the number of cpu cycle for outb and/or writeb is not
constant... if linux kernel is not preempive
why this variability ? maybe interrupt ? I think no cause things doesn't
change even if I add a cli() before the write.
Is there a way to reduce this variability ?

Thanks in advance and excuse my english!

    Paolo

----------------------------------------------------------------------------
System                      : Rtlinux 3.2 pre 1 on Kernel 2.4.19, RH 7.2
CPU model name      : AMD-K6(tm) 3D processor
cpu MHz                   : 451.029
cache size                  : 64 KB
bogomips                  : 897.84
----------------------------------------------------------------------------
TEST PROGRAM:

void * thread_code(int fd)
{
pthread_make_periodic_np(pthread_self(), gethrtime(), 1000000000); //
schedulo ogni 1s
printk(KERN_INFO "MIO: realtime thread is started...\n");
while (1)
 {
 unsigned int counta1,counta2,fixa;
 pthread_wait_np();

 rdtscl(counta1);
 rdtscl(counta2);
 fixa = counta2-counta1;
 printk("rdtsc took %d cycles\n",fixa);

 rdtscl(counta1);
 outb(0, 0x330);
 rdtscl(counta2);
 printk("outb() took %d cycles\n",counta2-counta1-fixa);

 rdtscl(counta1);
 writeb(0, mio_base+OFF_DAC16_2_EN); // DAC 2 a 16 bit enable
 mb();
 rdtscl(counta2);
 printk("writeb() took %d cycles\n",counta2-counta1-fixa);

 return 0;
 }
}

----------------------------------------------------------------------------

RESULTS in normal conditions:

Jan 12 14:49:29 ds4 kernel: rdtsc took 9 cycles
Jan 12 14:49:29 ds4 kernel: outb() took 622 cycles
Jan 12 14:49:29 ds4 kernel: writeb() took 393 cycles
Jan 12 14:49:30 ds4 kernel: rdtsc took 9 cycles
Jan 12 14:49:30 ds4 kernel: outb() took 632 cycles
Jan 12 14:49:30 ds4 kernel: writeb() took 601 cycles
Jan 12 14:49:31 ds4 kernel: rdtsc took 9 cycles
Jan 12 14:49:31 ds4 kernel: outb() took 623 cycles
Jan 12 14:49:31 ds4 kernel: writeb() took 444 cycles
Jan 12 14:49:32 ds4 kernel: rdtsc took 9 cycles
Jan 12 14:49:32 ds4 kernel: outb() took 622 cycles
Jan 12 14:49:32 ds4 kernel: writeb() took 440 cycles
Jan 12 14:49:33 ds4 kernel: rdtsc took 9 cycles
Jan 12 14:49:33 ds4 kernel: outb() took 627 cycles
Jan 12 14:49:33 ds4 kernel: writeb() took 454 cycles
Jan 12 14:49:34 ds4 kernel: rdtsc took 9 cycles
Jan 12 14:49:34 ds4 kernel: outb() took 796 cycles
Jan 12 14:49:34 ds4 kernel: writeb() took 456 cycles
Jan 12 14:49:35 ds4 kernel: rdtsc took 9 cycles

----------------------------------------------------------------------------

RESULTS with kernel compiling and ping flood active:

Jan 12 15:16:47 ds4 kernel: writeb() took 613 cycles
Jan 12 15:16:48 ds4 kernel: rdtsc took 9 cycles
Jan 12 15:16:48 ds4 kernel: outb() took 676 cycles
Jan 12 15:16:48 ds4 kernel: writeb() took 615 cycles
Jan 12 15:16:49 ds4 kernel: rdtsc took 9 cycles
Jan 12 15:16:49 ds4 kernel: outb() took 756 cycles
Jan 12 15:16:49 ds4 kernel: writeb() took 773 cycles
Jan 12 15:16:50 ds4 kernel: rdtsc took 9 cycles
Jan 12 15:16:50 ds4 kernel: outb() took 666 cycles
Jan 12 15:16:50 ds4 kernel: writeb() took 767 cycles
Jan 12 15:16:51 ds4 kernel: rdtsc took 9 cycles
Jan 12 15:16:51 ds4 kernel: outb() took 667 cycles
Jan 12 15:16:51 ds4 kernel: writeb() took 544 cycles
Jan 12 15:16:52 ds4 kernel: rdtsc took 9 cycles
Jan 12 15:16:52 ds4 kernel: outb() took 663 cycles
Jan 12 15:16:52 ds4 kernel: writeb() took 660 cycles
Jan 12 15:16:54 ds4 kernel: rdtsc took 9 cycles
Jan 12 15:16:54 ds4 kernel: outb() took 665 cycles
Jan 12 15:16:54 ds4 kernel: writeb() took 655 cycles
Jan 12 15:16:54 ds4 kernel: rdtsc took 9 cycles
Jan 12 15:16:54 ds4 kernel: outb() took 663 cycles
Jan 12 15:16:54 ds4 kernel: writeb() took 566 cycles





