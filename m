Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932487AbVL1Gx6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932487AbVL1Gx6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Dec 2005 01:53:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932488AbVL1Gx6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Dec 2005 01:53:58 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:31415 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932487AbVL1Gx6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Dec 2005 01:53:58 -0500
Date: Wed, 28 Dec 2005 06:53:54 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Joshua Kwan <joshk@triplehelix.org>
Cc: linux-kernel@vger.kernel.org
Subject: [vma list corruption] Re: proc_pid_readlink oopses again on 2.6.14.5
Message-ID: <20051228065354.GE27946@ftp.linux.org.uk>
References: <dot96e$e76$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dot96e$e76$1@sea.gmane.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 27, 2005 at 09:52:26PM -0800, Joshua Kwan wrote:
> Unable to handle kernel paging request at virtual address b7c1fc35
>  printing eip:
> c017c2a8
> *pde = 0afff067
> *pte = 00000000
> Oops: 0000 [#1]
> Modules linked in: hostap_pci hostap ieee80211_crypt tulip ipt_state
> ipt_MASQUERADE ppp_deflate zlib_deflate zlib_inflate bsd_comp ipt_LOG
> iptable_mangle sch_ingress cls_u32 sch_sfq sch_cbq iptable_nat ip_nat
> ipt_REJECT iptable_filter ip_tables ppp_async crc_ccitt ppp_generic slhc
> ip_conntrack_irc i2c_dev via686a hwmon i2c_isa i2c_core
> CPU:    0
> EIP:    0060:[<c017c2a8>]    Not tainted VLI
> EFLAGS: 00010282   (2.6.14-influx)
> EIP is at proc_exe_link+0x28/0xa0
> eax: cd4af070   ebx: cd4af040   ecx: cd4af070   edx: b7c1fc20
> esi: 00000000   edi: c445bf6c   ebp: c445a000   esp: c445bf30
> ds: 007b   es: 007b   ss: 0068
> Process lsof (pid: 17477, threadinfo=c445a000 task=c0d82560)
> Stack: c9473e60 00000000 c017de2c c9473e60 c445bf4c c445bf48 00000000
> c0355fc0
>        c9473e60 00001000 c0156093 d0d6af70 bffc9250 00001000 c9473e60
> d0d6af70
>        c12f3f60 00000000 00000000 00000000 00000000 00000001 00000000
> 00000000
> Call Trace:
>  [<c017de2c>] proc_pid_readlink+0x4c/0xc0
>  [<c0156093>] sys_readlink+0x53/0x80
>  [<c01060df>] do_syscall_trace+0x9f/0x148
>  [<c0102af9>] syscall_call+0x7/0xb
> Code: 90 90 90 56 53 8b 44 24 0c ff 70 f0 e8 b2 69 f9 ff 85 c0 89 c3 5a
> 74 77 8d 48 30 89 c8 ff 00 0f 88 72 07 00 00 8b 13 85 d2 74 14 <f6> 42
> 15 10 74 07 8b 42 4c 85 c0 75 28 8b 52 0c 85 d2 75 ec be

Until the last line it made sense.  Code, however, is flat-out BS.
This chunk is from around proc_exe_link(), all right.  But it starts
at 3 bytes before the beginning of that function.  Perfect match to
build with your .config using gcc4, but...  no way in hell you would
get an oops at that location - it's in the middle of long chunk of
NOP.  So something's rotten here...

FWIW, with the same build you will get the following at 0x28 from the
beginning of function:
        vma = mm->mmap;
        while (vma) {
                if ((vma->vm_flags & VM_EXECUTABLE) && vma->vm_file)
                     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
                        break;
                vma = vma->vm_next;
        }
This check.  It turns into
	f6 42 15 10             testb  $0x10,0x15(%edx)
with vma in %edx.  Since your %edx is 0xb7c1fc20 and address you are trying
to access is 0xb7c1fc35, it's a match.

So you've got 0xb7c1fc20 as vma.  Which is not good, since that's a userland
address.  The next question is where it'd come from - it might be
	* fscked task->mm
	* fscked mm->mmap
	* fscked vma somewhere in the chain.

Doing lsof will walk vma chains of many processes, so if something is
corrupted it will step into that...
