Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262876AbUCWWG0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Mar 2004 17:06:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262879AbUCWWG0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Mar 2004 17:06:26 -0500
Received: from arhont1.eclipse.co.uk ([81.168.98.121]:6567 "EHLO
	pingo.core.arhont.com") by vger.kernel.org with ESMTP
	id S262876AbUCWWGV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Mar 2004 17:06:21 -0500
Message-ID: <4060B4C7.8060107@arhont.com>
Date: Tue, 23 Mar 2004 22:05:59 +0000
From: Andrei Mikhailovsky <mlists@arhont.com>
Reply-To: andrei@arhont.com
Organization: Arhont Information Security
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040312 Debian/1.6-3
X-Accept-Language: en
MIME-Version: 1.0
To: Hans-Peter Jansen <hpj@urpla.net>
CC: Petr Vandrovec <vandrove@vc.cvut.cz>, linux-kernel@vger.kernel.org
Subject: Re: VMware-workstation-4.5.1 on linux-2.6.4-x86_64 host fails on
 virtual ethernet setup
References: <200403232233.46879.hpj@urpla.net>
In-Reply-To: <200403232233.46879.hpj@urpla.net>
X-Enigmail-Version: 0.83.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.9 (----)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have successfully installed (well actually upgraded) to 4.5.1 from 
4.0.5. No patches where required and everything seems to work like a charm.

--
Andrei Mikhailovsky
Arhont Ltd

Web: http://www.arhont.com
Tel: +44 (0)870 4431337
Fax: +44 (0)117 9690141
PGP: Key ID - 0xFF67A4F4
PGP: Server - keyserver.pgp.com


Hans-Peter Jansen wrote:
> [CCing LKML in order to give other people, which may suffer from this 
>  in the future something to google for ;-)]
> 
> Hi Petr,
> 
> I'm suffering from a strange problem here. I tried to reach you on
> vmware.for-linux.experimental without success (got a trollish answer only).
> 
> Here it is:
> I'm trying to get VMware-workstation-4.5.1-7568.i386.rpm working on SuSE 
> 9.1b1, based on linux-2.6.4-x86_64. Thanks to some googling, I found related 
> hints from you and your vmware-any-any-update54, which got me around the 
> compile issues in vmmon with this patch:
> 
> --- vmmon-only/linux/hostif.c.orig	2004-03-21 20:53:35.042565778 +0100
> +++ vmmon-only/linux/hostif.c	2004-03-21 20:53:40.284442570 +0100
> @@ -516,13 +516,13 @@
>  ClearNXBit(VA vaddr)
>  {
>     pgd_t *pgd = pgd_offset_k(vaddr);
> -   pmd_t *pmd = pmd_offset(pgd, vaddr);
> +   pmd_t *pmd = pmd_offset_map(pgd, vaddr);
>     pte_t *pte;
>  
>     if (pmd_val(*pmd) & _PAGE_PSE) {
>        pte = (pte_t*)pmd;
>     } else {
> -      pte = pte_offset(pmd, vaddr);
> +      pte = pte_offset_map(pmd, vaddr);
>     }
>     if (pte_val(*pte) & _PAGE_NX) {
>        pte_val(*pte) &= ~_PAGE_NX;
> 
> 
> vmware-config.pl and /etc/init.d/vmware both fail at the same point,
> setting up virtual networking [the latter with VMWARE_DEBUG=yes]:
> 
> Starting VMware services:
>    Virtual machine monitor                                             done
>    Virtual ethernet                                                    done
>    Bridged networking on /dev/vmnet0cd /usr/bin && /usr/bin/vmnet-bridge
> -d /var/run/vmnet-bridge-0.pid /dev/vmnet0 eth0
> eth0: Not a valid Ethernet interface
>                                                                       failed
> 
> 
> This triggers these syslog messages:
> 
> Mar 22 21:45:57 tyrex kernel: /dev/vmmon: Module vmmon: registered with major=10 minor=165
> Mar 22 21:45:57 tyrex kernel: /dev/vmmon: Module vmmon: initialized
> Mar 22 21:45:57 tyrex kernel: vmnet: module license 'unspecified' taints kernel.
> Mar 22 21:45:57 tyrex kernel: /dev/vmnet: open called by PID 4871 (vmnet-bridge)
> Mar 22 21:45:57 tyrex kernel: /dev/vmnet: hub 0 does not exist, allocating memory.
> Mar 22 21:45:57 tyrex kernel: /dev/vmnet: port on hub 0 successfully opened
> Mar 22 21:45:57 tyrex kernel: ioctl32(vmnet-bridge:4871): Unknown cmd fd(5) cmd(00008941){00} 
> arg(ffffd268) on /dev/vmnet0
> 
> Replacing vmnet.tar with yours suffers from the same problem.
> 
> stracing vmnet-bridge command:
> execve("/usr/bin/vmnet-bridge", ["vmnet-bridge", "-d", "/var/run/vmnet-bridge-0.pid", 
> "/dev/vmnet0", "eth0"], [/* 72 vars */]) = 0
> [ Process PID=4910 runs in 32 bit mode. ]
> eth0: Not a valid Ethernet interface
> 
> syslog:
> Mar 22 21:51:40 tyrex kernel: /dev/vmnet: open called by PID 4910
> (vmnet-bridge)
> Mar 22 21:51:40 tyrex kernel: /dev/vmnet: port on hub 0 successfully opened
> Mar 22 21:51:40 tyrex kernel: ioctl32(vmnet-bridge:4910): Unknown cmd fd(5) cmd(00008941){00}
> arg(ffffd288) on /dev/vmnet0
> 
> Surely, eth0 is up and running (I highly depend on a working lan here ;-)
> 
> Obviously it's some problem with i386 <-> x86_64 interfacing.
> 
> Any ideas, what to try next?
> 
> TIA,
> Pete
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
