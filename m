Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267812AbTAMRCF>; Mon, 13 Jan 2003 12:02:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267829AbTAMRCF>; Mon, 13 Jan 2003 12:02:05 -0500
Received: from rumms.uni-mannheim.de ([134.155.50.52]:39855 "EHLO
	rumms.uni-mannheim.de") by vger.kernel.org with ESMTP
	id <S267812AbTAMRCE>; Mon, 13 Jan 2003 12:02:04 -0500
Content-Type: text/plain; charset=US-ASCII
From: Thomas Schlichter <schlicht@uni-mannheim.de>
To: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Subject: Re: patch for errno-issue (with soundcore)
Date: Mon, 13 Jan 2003 18:10:53 +0100
User-Agent: KMail/1.4.3
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       alan@lxorguk.ukuu.org.uk
References: <D206AA476EB@vcnet.vc.cvut.cz>
In-Reply-To: <D206AA476EB@vcnet.vc.cvut.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200301131810.53089.schlicht@uni-mannheim.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13. Jan. 2003 17:33, Petr Vandrovec wrote:
> There is no problem currently, because of nobody uses errno value at
> all (in the firmware loader), it is just that inline functions generated
> by syscallX() store error codes into errno...
>
> Real problem is that firmware loader should use
> filp_open/vfs_read/filp_close (or sys_open/sys_llseek/sys_read/sys_close if
> you want to use fd interface, but filp_{open,close} and vfs_read are
> already exported for modules while sys_open/sys_llseek/sys_read are not).
>
> As an alternative, do_mod_firmware_load should be standalone userspace
> program executed through call_usermodehelper or something like that...
> Unfortunately we do not have an interface to distribute userspace binaries
> together with kernel (except initrd) yet, so it would require either
> adding do_mod_firmware_load into module-init-tools, or some simillar
> package required by 2.[56].x kernels.
>
> Also adding "#define errno (current()->exit_code)" at the beginning of
> sound_firmware.c (just below #define __KERNEL_SYSCALLS__) should do
> the trick, but I do not recommend taking this path.
>                                             Best regards,
>                                                 Petr Vandrovec
>                                                 vandrove@vc.cvut.cz

First of all a big THANKS!

Now, at least, I understood the real problem...
'errno' is only needed because open(), close(), llseek() and read() are used, 
which do a syscall and the return code is written to a variable called 
'errno'. This is NOT the 'errno' variable defined in lib/errno.c... OK.

And so the real problem is using these functions and as we ARE in the kernel 
mode we do not really need the kernel traps...

So after realizing the real problem I think I am not the right person to fix 
it. But if you want I could try...

Sincerely yours
   Thomas Schlichter
