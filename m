Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276691AbRJBVDM>; Tue, 2 Oct 2001 17:03:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276689AbRJBVDC>; Tue, 2 Oct 2001 17:03:02 -0400
Received: from zikova.cvut.cz ([147.32.235.100]:1550 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S276686AbRJBVCz>;
	Tue, 2 Oct 2001 17:02:55 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: VDA <VDA@port.imtp.ilyichevsk.odessa.ua>
Date: Tue, 2 Oct 2001 23:02:28 MET-1
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: System reset on Kernel 2.4.10
CC: linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.40
Message-ID: <527872464EC@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  2 Oct 01 at 23:52, VDA wrote:
> V> Straced vmlinux does not reboot.
> V> Kernel: 2.4.10+ext3+preempt
> 
> Well... sometimes it reboots too.
> Once it rebooted ~10 mins after strace (system was at zero load).
> Also it rebooted after two strace's in succession.

Look at fs/binfmt_elf.c, at line 642 (in -ac2). There is

error = elf_map(....)

but nobody bothers with checking error value, it even tries it
to use as an offset if stars are in wrong constellation.
If you could add these lines below the call:

if ((unsigned long)error >= (unsigned long)(-256)) {
  set_fs(old_fs);
  printk(KERN_DEBUG "Something went wrong with elf_map()\n");
  kfree(elf_phdata);
  send_sig(SIGSEGV, current, 0);
  return 0;
}

and then report results...
                                    Petr Vandrovec
                                    (not willing to test it myself)
                                    
