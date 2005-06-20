Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261640AbVFTVkl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261640AbVFTVkl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 17:40:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261598AbVFTVgb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 17:36:31 -0400
Received: from rproxy.gmail.com ([64.233.170.193]:50096 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261617AbVFTVeI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 17:34:08 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=nhnrlx6DjK9WSg17aXzuuKShprhJ98uo9gN2+hd6RBWDpJl8dph9TepBag82UkT+ZWFY4QsRTnM/Stx8ZJ524pRLWPS+zPb/dXY2zyVjpDhV0Wvt8i8E+o3wAH89uX/UhhowgoV6aW8Pziut7yTZaO04PMNLAVSlBBeIMSpwd6U=
From: Alexey Dobriyan <adobriyan@gmail.com>
To: dipankar@in.ibm.com
Subject: Re: 2.6.12-mm1 (kernel BUG at fs/open.c:935!)
Date: Tue, 21 Jun 2005 01:39:55 +0400
User-Agent: KMail/1.7.2
Cc: jan malstrom <xanon@snacksy.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, rjw@sisk.pl
References: <42B6BEC2.405@snacksy.com> <20050620202145.GC4622@in.ibm.com>
In-Reply-To: <20050620202145.GC4622@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506210139.55294.adobriyan@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 21 June 2005 00:21, Dipankar Sarma wrote:
> On Mon, Jun 20, 2005 at 03:04:02PM +0200, jan malstrom wrote:
> > Jun 20 14:38:07 hades kernel: kernel BUG at fs/open.c:935!
> > Jun 20 14:38:07 hades kernel: invalid operand: 0000 [#1]
> > Jun 20 14:38:07 hades kernel: PREEMPT
> > Jun 20 14:38:07 hades kernel: Modules linked in: ipw2100 i2c_i801
> > Jun 20 14:38:07 hades kernel: CPU:    0
> > Jun 20 14:38:07 hades kernel: EIP:    0060:[fd_install+309/400]    Not 
> > tainted VLI
> 
> Can you try the following patch and let me know if it fixes any
> of your problems ?

> If expand_fdtable() sees that someone else expanded the fdtable
> while it dropped the lock, it can return 0 which in turn
> can be returned by expand_files() even though there has
> been an expansion of the fdtable since expand_files()
> was originally called. This could lead to locate_fd()
> not repeating the fd search and returning a bogus fd.

> --- linux-2.6.12-mm1-test/fs/file.c~fix-expand-files
> +++ linux-2.6.12-mm1-test-dipankar/fs/file.c

Doesn't fix for me.

2.6.12-mm1-935
============================================================================
kernel BUG at fs/open.c:935!
invalid operand: 0000 [#1]
PREEMPT 
Modules linked in: floppy evdev ide_cd cdrom snd_intel8x0 snd_ac97_codec
CPU:    0
EIP:    0060:[<c01517ad>]    Not tainted VLI
EFLAGS: 00210282   (2.6.12-mm1) 
EIP is at fd_install+0x7d/0x90
eax: c1573280   ebx: deee0280   ecx: 00000001   edx: de597840
esi: de45c000   edi: 00000080   ebp: c1573a80   esp: de45cf68
ds: 007b   es: 007b   ss: 0068
Process kded (pid: 6947, threadinfo=de45c000 task=de6d10a0)
Stack: 00000080 deee0280 de597840 de45c000 c0163de2 c1573a80 00000080 ffffffea 
       0000000c 0000000c c016424a 00000000 c1573a80 fffffff7 c0164400 c1573a80 
       0000000c 00000080 b6c58ff4 de45c000 c0102d05 0000000c 00000000 00000080 
Call Trace:
 [<c0163de2>] dupfd+0x62/0xa0
 [<c016424a>] do_fcntl+0xba/0x190
 [<c0164400>] sys_fcntl64+0x80/0x90
 [<c0102d05>] syscall_call+0x7/0xb
Code: 13 8b 1c 24 8b 74 24 04 8b 7c 24 08 8b 6c 24 0c 83 c4 10 c3 8b 1c 24 8b 74 24 04 8b 7c 24 08 8b 6c 24 0c 83 c4 10 e9 23 06 19 00 <0f> 0b a7 03 1c 6b 2f c0 eb b5 89 f6 8d bc 27 00 00 00 00 83 ec 
 <6>note: kded[6947] exited with preempt_count 1
	...

2.6.12-mm1
============================================================================
kernel BUG at fs/open.c:935!
invalid operand: 0000 [#1]
PREEMPT 
Modules linked in: floppy evdev ide_cd cdrom snd_intel8x0 snd_ac97_codec
CPU:    0
EIP:    0060:[<c01517ad>]    Not tainted VLI
EFLAGS: 00210282   (2.6.12-mm1) 
EIP is at fd_install+0x7d/0x90
eax: de5a9980   ebx: def38280   ecx: 00000001   edx: de534840
esi: de2f9000   edi: 00000080   ebp: de6c2280   esp: de2f9f68
ds: 007b   es: 007b   ss: 0068
Process kded (pid: 6947, threadinfo=de2f9000 task=de927510)
Stack: 00000080 def38280 de534840 de2f9000 c0163de2 de6c2280 00000080 ffffffea 
       0000000c 0000000c c016424a 00000000 de6c2280 fffffff7 c0164400 de6c2280 
       0000000c 00000080 b6c68ff4 de2f9000 c0102d05 0000000c 00000000 00000080 
Call Trace:
 [<c0163de2>] dupfd+0x62/0xa0
 [<c016424a>] do_fcntl+0xba/0x190
 [<c0164400>] sys_fcntl64+0x80/0x90
 [<c0102d05>] syscall_call+0x7/0xb
Code: 13 8b 1c 24 8b 74 24 04 8b 7c 24 08 8b 6c 24 0c 83 c4 10 c3 8b 1c 24 8b 74 24 04 8b 7c 24 08 8b 6c 24 0c 83 c4 10 e9 43 06 19 00 <0f> 0b a7 03 3c 6b 2f c0 eb b5 89 f6 8d bc 27 00 00 00 00 83 ec 
 <6>note: kded[6947] exited with preempt_count 1
scheduling while atomic: kded/0x10000001/6947
 [<c02e1de2>] schedule+0x672/0x680
 [<c014254e>] zap_pte_range+0xde/0x1b0
 [<c01426ab>] unmap_page_range+0x8b/0xb0
 [<c02e280a>] cond_resched+0x2a/0x50
 [<c0142890>] unmap_vmas+0x1c0/0x220
 [<c014707a>] exit_mmap+0x7a/0x160
 [<c0112c01>] mmput+0x41/0x110
 [<c011769d>] do_exit+0xcd/0x4e0
 [<c01036db>] die+0x16b/0x170
 [<c0103a40>] do_invalid_op+0x0/0xc0
 [<c0103adf>] do_invalid_op+0x9f/0xc0
 [<c01517ad>] fd_install+0x7d/0x90
 [<c0123f7d>] in_group_p+0x3d/0xa0
 [<c01b1cfe>] __reiserfs_permission+0x23e/0x290
 [<c01b1d50>] reiserfs_permission+0x0/0x20
 [<c01b1d5f>] reiserfs_permission+0xf/0x20
 [<c015f9eb>] permission+0x8b/0xa0
 [<c0161797>] may_open+0x47/0x1e0
 [<c015301b>] get_empty_filp+0x5b/0xd0
 [<c0102f1f>] error_code+0x4f/0x54
 [<c01517ad>] fd_install+0x7d/0x90
 [<c0163de2>] dupfd+0x62/0xa0
 [<c016424a>] do_fcntl+0xba/0x190
 [<c0164400>] sys_fcntl64+0x80/0x90
 [<c0102d05>] syscall_call+0x7/0xb
	...
