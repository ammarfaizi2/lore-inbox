Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283581AbRLRBqx>; Mon, 17 Dec 2001 20:46:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283586AbRLRBqo>; Mon, 17 Dec 2001 20:46:44 -0500
Received: from codepoet.org ([166.70.14.212]:7946 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id <S283581AbRLRBqh>;
	Mon, 17 Dec 2001 20:46:37 -0500
Date: Mon, 17 Dec 2001 18:46:37 -0700
From: Erik Andersen <andersen@codepoet.org>
To: Dave Jones <davej@suse.de>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        lkml <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Linux 2.4.17-rc1
Message-ID: <20011217184637.A17505@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Dave Jones <davej@suse.de>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	lkml <linux-kernel@vger.kernel.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <20011217182724.A17312@codepoet.org> <Pine.LNX.4.33.0112180237440.23388-100000@Appserv.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0112180237440.23388-100000@Appserv.suse.de>
User-Agent: Mutt/1.3.23i
X-Operating-System: 2.4.13-ac8-rmk1, Rebel NetWinder (Intel StrongARM-110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue Dec 18, 2001 at 02:38:48AM +0100, Dave Jones wrote:
> On Mon, 17 Dec 2001, Erik Andersen wrote:
> 
> 
> > This fix from -pre6 broke NCR5380 so that it does not compile
> > when linked into the kernel (i.e.  not as a module).  This patch
> > fixes it.  Please apply for 2.4.17-rc2,
> 
> This doesn't look right..

Sure it does, look closer.  :-)

> > -static int __init do_NCR53C400_setup(char *str)
> > -static int __init do_NCR53C400A_setup(char *str)
> > -static int __init do_DTC3181E_setup(char *str)
> 
> You nuked the functions..

Exactly.  Because there were two copies of that code, but one
copy was wrapped inside an '#ifndef MODULE' so when compiling as
a module, everything was cool.  But if you link the driver into
the kernel you would get two copies of those init funcs....

> >  __setup("ncr5380=", do_NCR5380_setup);
> >  __setup("ncr53c400=", do_NCR53C400_setup);
> >  __setup("ncr53c400a=", do_NCR53C400A_setup);
> >  __setup("dtc3181e=", do_DTC3181E_setup);
> 
> But not the references to them. What error are you seeing ?

make[3]: Entering directory `/usr/src/linux/drivers/scsi'
ld -m elf_i386 -r -o scsi_mod.o scsi.o hosts.o scsi_ioctl.o constants.o scsicam.o scsi_proc.o scsi_error.o scsi_obsolete.o scsi_queue.o scsi_lib.o scsi_merge.o scsi_dma.o scsi_scan.o scsi_syms.o
gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4     -c -o g_NCR5380.o g_NCR5380.c
g_NCR5380.c:917: redefinition of `do_NCR53C400_setup'
g_NCR5380.c:230: `do_NCR53C400_setup' previously defined here
g_NCR5380.c: In function `do_NCR53C400_setup':
g_NCR5380.c:921: warning: implicit declaration of function `generic_NCR53C400_setup'
g_NCR5380.c: At top level:
g_NCR5380.c:927: redefinition of `do_NCR53C400A_setup'
g_NCR5380.c:248: `do_NCR53C400A_setup' previously defined here
g_NCR5380.c: In function `do_NCR53C400A_setup':
g_NCR5380.c:931: warning: implicit declaration of function `generic_NCR53C400A_setup'
g_NCR5380.c: At top level:
g_NCR5380.c:937: redefinition of `do_DTC3181E_setup'
g_NCR5380.c:266: `do_DTC3181E_setup' previously defined here
g_NCR5380.c: In function `do_DTC3181E_setup':
g_NCR5380.c:941: warning: implicit declaration of function `generic_DTC3181E_setup'
g_NCR5380.c: At top level:
NCR5380.c:458: warning: `NCR5380_print_phase' defined but not used
NCR5380.c:402: warning: `NCR5380_print' defined but not used
{standard input}: Assembler messages:
{standard input}:4585: Error: symbol `do_NCR53C400_setup' is already defined
{standard input}:4608: Error: symbol `do_NCR53C400A_setup' is already defined
{standard input}:4631: Error: symbol `do_DTC3181E_setup' is already defined
make[3]: *** [g_NCR5380.o] Error 1
make[3]: Leaving directory `/usr/src/linux/drivers/scsi'
make[2]: *** [first_rule] Error 2
make[2]: Leaving directory `/usr/src/linux/drivers/scsi'
make[1]: *** [_subdir_scsi] Error 2
make[1]: Leaving directory `/usr/src/linux/drivers'
make: *** [_dir_drivers] Error 2

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
