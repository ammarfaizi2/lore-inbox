Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266890AbUHTOnP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266890AbUHTOnP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 10:43:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268121AbUHTOnP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 10:43:15 -0400
Received: from herkules.viasys.com ([194.100.28.129]:5562 "HELO
	mail.viasys.com") by vger.kernel.org with SMTP id S266890AbUHTOnI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 10:43:08 -0400
Date: Fri, 20 Aug 2004 17:43:04 +0300
From: Ville Herva <vherva@viasys.com>
To: Andrew Morton <akpm@osdl.org>
Cc: petr@vandrovec.name, linux-kernel@vger.kernel.org
Subject: Re: 2.6.8.1-mm2 breaks vmware
Message-ID: <20040820144304.GF8307@viasys.com>
Reply-To: vherva@viasys.com
References: <20040820104230.GH23741@viasys.com> <20040820035142.3bcdb1cb.akpm@osdl.org> <20040820131825.GI23741@viasys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040820131825.GI23741@viasys.com>
User-Agent: Mutt/1.4.1i
X-Operating-System: Linux herkules.viasys.com 2.4.27
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 20, 2004 at 04:18:25PM +0300, you [Ville Herva] wrote:
> 
> I just noticed I had missed get_user_pages-handle-VM_IO.patch - I'll try
> backing that out first. I'll report back if I find anything interesting 
> with different patch mixtures.

Well, I just tried 2.6.8.1-mm2 minus get_user_pages-handle-VM_IO.patch but
that didn't help with the "cannot allocate memory" problem. Curiously, I
didn't get the "get_user_pages() returns -EFAULT" warning with this kernel.

Also, neither "echo 1 > /proc/sys/vm/overcommit_memory" nor "echo 1 >
/proc/sys/vm/legacy_va_layout" helped.

It seems this is "cannot allocate memory" might have something to do with
/dev/mem mmap() permissions - here's a strace:

--8<-----------------------------------------------------------------------
5022  geteuid32()                       = 1414
5022  setresuid32(-1, 0, -1)            = 0
5022  open("/dev/mem", O_RDWR)          = 8
5022  getuid32()                        = 1414
5022  setresuid32(-1, 1414, -1)         = 0
5022  old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_SHARED, 8, 0x3d6000) = -1 EPERM (Operation not permitted)
5022  close(8)                          = 0
5022  ioctl(4, 0xf0, 0x3d6000)          = 0
5022  time(NULL)                        = 1093011756
5022  open("/etc/localtime", O_RDONLY)  = 8
5022  fstat64(8, {st_mode=S_IFREG|0644, st_size=682, ...}) = 0
5022  close(8)                          = 0
5022  writev(3, [{"Aug 20 17:22:36: ", 17}, {"VMX|", 4}, {"Msg_Post: Error\n", 16}], 3) = 37
5022  writev(3, [{"Aug 20 17:22:36: ", 17}, {"VMX|", 4}, {"[msg.msg.noMem] Cannot allocate "..., 40}], 3) = 61
5022  writev(3, [{"Aug 20 17:22:36: ", 17}, {"VMX|", 4}, {"--------------------------------"..., 41}], 3) = 62
--8<-----------------------------------------------------------------------

I just put get_user_pages-handle-VM_IO.patch back and reverted
dev-mem-restriction-patch.patch - I'll report back when it has compiled. 


-- v -- 

v@iki.fi

