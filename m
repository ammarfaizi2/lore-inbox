Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262777AbTLIEX2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 23:23:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262782AbTLIEX2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 23:23:28 -0500
Received: from lists.us.dell.com ([143.166.224.162]:34449 "EHLO
	lists.us.dell.com") by vger.kernel.org with ESMTP id S262777AbTLIEXZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 23:23:25 -0500
Date: Mon, 8 Dec 2003 22:23:22 -0600
From: Matt Domsch <Matt_Domsch@dell.com>
To: Anton Altaparmakov <aia21@cam.ac.uk>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.23-bk bogus edd changeset - Re: 2.4.23 compile error in edd
Message-ID: <20031208222322.A21354@lists.us.dell.com>
References: <Pine.SOL.4.58.0312042225300.26114@yellow.csi.cam.ac.uk> <Pine.LNX.4.44.0312051109580.1782-100000@logos.cnet> <20031205113619.A20371@lists.us.dell.com> <1070901250.4508.1.camel@imp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1070901250.4508.1.camel@imp>; from aia21@cam.ac.uk on Mon, Dec 08, 2003 at 04:34:10PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> With latest 2.4-BK which includes your compile fix, compiling the kernel
> with the attached .config, installing and attempting to boot the kernel
> causes immediate reboot on my workstation.
> 
> Disabling EDD in the .config, recompiling and installing the kernel
> makes it boot just fine.
> 
> Let me know if you want me to test any patches, need any more
> information, etc...

Ok, I'm betting that your BIOS doesn't like the int13 call in setup.S for some
reason.

#if defined(CONFIG_EDD) || defined(CONFIG_EDD_MODULE)
# Read the first sector of device 80h and store the 4-byte signature
        movl    $0xFFFFFFFF, %eax
        movl    %eax, (DISK80_SIG_BUFFER)       # assume failure
        movb    $READ_SECTORS, %ah
        movb    $1, %al                         # read 1 sector
        movb    $0x80, %dl                      # from device 80
        movb    $0, %dh                         # at head 0
        movw    $1, %cx                         # cylinder 0, sector 0
        pushw   %es
        pushw   %ds
        popw    %es
        movw    $EDDBUF, %bx
        int     $0x13
        jc      disk_sig_done
        movl    (EDDBUF+MBR_SIG_OFFSET), %eax
        movl    %eax, (DISK80_SIG_BUFFER)       # store success
disk_sig_done:
        popw    %es


To test this, would you mind #if 0'ing everything starting with
movb $READ_SECTORS, %ah   through the popw %es at the end?  That
should leave you with a file in /proc/bios/int13_dev80/mbr_signature
that says 0xFFFFFFFF, but a booting system.

I'm wondering if %eax shouldn't be zeroed before the int13.  The
bottom word gets set properly, but the top word is 0xFFFF which your
BIOS may not like?  That would be another test, add an

 xor %eax, %eax

before the movb $READ_SECTORS, %ah.


My BIOSs I've seen this on work, so it could be BIOS-dependent;
clearing eax before setting the lower bytes would be OK if that fixes
it.

I'm travelling Monday and Tuesday, but will respond ASAP.

Thanks,
Matt

-- 
Matt Domsch
Sr. Software Engineer, Lead Engineer
Dell Linux Solutions www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com
