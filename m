Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267692AbTAMQYw>; Mon, 13 Jan 2003 11:24:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267541AbTAMQYw>; Mon, 13 Jan 2003 11:24:52 -0500
Received: from mailgw.cvut.cz ([147.32.3.235]:22705 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id <S267692AbTAMQYt>;
	Mon, 13 Jan 2003 11:24:49 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Thomas Schlichter <schlicht@uni-mannheim.de>
Date: Mon, 13 Jan 2003 17:33:27 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: patch for errno-issue (with soundcore)
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       alan@lxorguk.ukuu.org.uk
X-mailer: Pegasus Mail v3.50
Message-ID: <D206AA476EB@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 13 Jan 03 at 15:57, Thomas Schlichter wrote:
> On Mon, 13. Jan. 2003 16:13, Alan Cox wrote:
> > This actually shows a bug that has always been lurking. What if we load two
> > modules firmware at the same time. errno needs to be task private or we
> > perhaps need an errno_sem ?
> 
> OK, I think I see the problem now!
> But is soundcore the only place where 'errno' is used? Does this problem not 
> occur if any task modifies the errno value and an other one depends on its 
> previous value? I think this could happen even if no modules are used...

There is no problem currently, because of nobody uses errno value at
all (in the firmware loader), it is just that inline functions generated 
by syscallX() store error codes into errno...

Real problem is that firmware loader should use 
filp_open/vfs_read/filp_close (or sys_open/sys_llseek/sys_read/sys_close if 
you want to use fd interface, but filp_{open,close} and vfs_read are already 
exported for modules while sys_open/sys_llseek/sys_read are not).

As an alternative, do_mod_firmware_load should be standalone userspace
program executed through call_usermodehelper or something like that... 
Unfortunately we do not have an interface to distribute userspace binaries 
together with kernel (except initrd) yet, so it would require either
adding do_mod_firmware_load into module-init-tools, or some simillar
package required by 2.[56].x kernels.

Also adding "#define errno (current()->exit_code)" at the beginning of
sound_firmware.c (just below #define __KERNEL_SYSCALLS__) should do
the trick, but I do not recommend taking this path.
                                            Best regards,
                                                Petr Vandrovec
                                                vandrove@vc.cvut.cz
                                                
