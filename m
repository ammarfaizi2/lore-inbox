Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264539AbUBIB2u (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Feb 2004 20:28:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264542AbUBIB2u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Feb 2004 20:28:50 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:36334 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S264539AbUBIB2o
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Feb 2004 20:28:44 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Andre Tomt <andre@tomt.net>
Subject: Re: Linux 2.6.3-rc1
Date: Mon, 9 Feb 2004 02:34:20 +0100
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org
References: <Pine.LNX.4.58.0402061823040.30672@home.osdl.org> <200402082351.48958.bzolnier@elka.pw.edu.pl> <4026CF98.5000905@tomt.net>
In-Reply-To: <4026CF98.5000905@tomt.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402090234.20832.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 09 of February 2004 01:08, Andre Tomt wrote:
> Bartlomiej Zolnierkiewicz wrote:
> >>>Can you disassemble ide_pci_register_host_proc using gdb?
> >>
> >>I'd need a walkthrough, not very familiar with gdb other than getting a
> >>backtrace out of it
> >
> > Make sure to enable following options in kernel config:
> > CONFIG_DEBUG_KERNEL ("Kernel hacking"->"Kernel debugging" ) and
> > CONFIG_DEBUG_INFO ("Kernel debugging"->"Compile the kernel with debug
> > info").
> >
> > Recompile kernel.
> >
> > $ gdb /usr/src/linux/vmlinux
> > (gdb) disassemble ide_pci_register_host_proc
> >
> > That's all :-).
>
> Ahh. However, as ide-core is a module in this case, I had to run gdb on
> the module instead. Anyway..

Yep.

> (gdb) disassemble ide_pci_register_host_proc
> Dump of assembler code for function ide_pci_register_host_proc:
> 0xe940 <ide_pci_register_host_proc>:    mov    0x4(%esp,1),%ecx
> 0xe944 <ide_pci_register_host_proc+4>:  test   %ecx,%ecx
> 0xe946 <ide_pci_register_host_proc+6>:  je     0xe978
> <ide_pci_register_host_proc+56>
> 0xe948 <ide_pci_register_host_proc+8>:  movl   $0x0,0x10(%ecx)
> 0xe94f <ide_pci_register_host_proc+15>: movb   $0x1,0x4(%ecx)
> 0xe953 <ide_pci_register_host_proc+19>: mov    0x3910,%eax
> 0xe958 <ide_pci_register_host_proc+24>: test   %eax,%eax
> 0xe95a <ide_pci_register_host_proc+26>: je     0xe972
> <ide_pci_register_host_proc+50>
> 0xe95c <ide_pci_register_host_proc+28>: mov    %eax,%edx
> 0xe95e <ide_pci_register_host_proc+30>: mov    0x10(%eax),%eax
> 0xe961 <ide_pci_register_host_proc+33>: test   %eax,%eax
> 0xe963 <ide_pci_register_host_proc+35>: je     0xe96e
> <ide_pci_register_host_proc+46>
> 0xe965 <ide_pci_register_host_proc+37>: mov    %eax,%edx

Access to ide_pci_proc_host_list->next.

> 0xe967 <ide_pci_register_host_proc+39>: mov    0x10(%eax),%eax
> 0xe96a <ide_pci_register_host_proc+42>: test   %eax,%eax
> 0xe96c <ide_pci_register_host_proc+44>: jne    0xe965
> <ide_pci_register_host_proc+37>
> 0xe96e <ide_pci_register_host_proc+46>: mov    %ecx,0x10(%edx)
> 0xe971 <ide_pci_register_host_proc+49>: ret
> 0xe972 <ide_pci_register_host_proc+50>: mov    %ecx,0x3910
> 0xe978 <ide_pci_register_host_proc+56>: ret
> End of assembler dump.

Ok thanks, I got the same dump.  I think the problem is that memory used by
previously registered ide_pci_host_proc_list entry (for pdc202xx_new driver)
is already unmapped because of __initdata in pdc202xx_new.h.
(This doesn't happen in built-in case because this memory is freed after
all drivers are initialized.)

Does this patch help?

 linux-2.6.3-rc1-bk1-root/drivers/ide/pci/pdc202xx_new.h |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN drivers/ide/pci/pdc202xx_new.h~pdc202xx_old_oops drivers/ide/pci/pdc202xx_new.h
--- linux-2.6.3-rc1-bk1/drivers/ide/pci/pdc202xx_new.h~pdc202xx_old_oops	2004-02-09 02:20:24.816898368 +0100
+++ linux-2.6.3-rc1-bk1-root/drivers/ide/pci/pdc202xx_new.h	2004-02-09 02:20:57.167980256 +0100
@@ -172,7 +172,7 @@ static u8 pdcnew_proc;
 
 static int pdcnew_get_info(char *, char **, off_t, int);
 
-static ide_pci_host_proc_t pdcnew_procs[] __initdata = {
+static ide_pci_host_proc_t pdcnew_procs[] = {
 	{
 		.name		= "pdcnew",
 		.set		= 1,

_

