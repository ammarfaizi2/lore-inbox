Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261679AbVBHXJQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261679AbVBHXJQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Feb 2005 18:09:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261681AbVBHXJQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Feb 2005 18:09:16 -0500
Received: from av1-2-sn4.m-sp.skanova.net ([81.228.10.115]:49801 "EHLO
	av1-2-sn4.m-sp.skanova.net") by vger.kernel.org with ESMTP
	id S261679AbVBHXI7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Feb 2005 18:08:59 -0500
To: Robert Love <rml@novell.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.11-rc3-mm1
References: <20050204103350.241a907a.akpm@osdl.org> <m3d5vengs2.fsf@telia.com>
	<1107686024.30303.52.camel@gaston> <m3acqhnaw3.fsf@telia.com>
	<m3d5vdl6xi.fsf@telia.com> <1107796935.24154.14.camel@localhost>
From: Peter Osterlund <petero2@telia.com>
Date: 09 Feb 2005 00:08:56 +0100
In-Reply-To: <1107796935.24154.14.camel@localhost>
Message-ID: <m33bw63b07.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Love <rml@novell.com> writes:

> On Sun, 2005-02-06 at 22:22 +0100, Peter Osterlund wrote:
> 
> > > > >         EIP is a strncpy_from_user+0x33/0x47
> > > > >         ...
> > > > >         Call Trace:
> > > > >          getname+0x69/0xa5
> > > > >          sys_open+0x12/0xc6
> > > > >          sysenter_past_esp+0x52/0x75
> > > > >         ...
> > > > >         Kernel panic - not syncing: Attempted to kill init!
> > 
> > I found the if I disable CONFIG_INOTIFY, the problem goes away.
> 
> Weird.  While we touch sys_open() with an inotify hook, we do so after
> the call to getname, and we don't touch getname() or strncpy_from_user()
> at all.
> 
> I wonder if there is another bug and inotify is just affecting the
> timing?

Possible, but it fails every time with CONFIG_INOTIFY enabled and
works every time with CONFIG_INOTIFY disabled.

I added some printk's to do_getname and got this:

    ...
    Freeing unused kernel memory: 160k freed
    ...
    do_getname: init /etc/localtime
    do_getname: init seg:1 page:df404000 filename:455dd11f len:4096
    do_getname: init /etc/localtime
    do_getname: init seg:1 page:df404000 filename:455dd11f len:4096
    do_getname: init /etc/localtime
    do_getname: init seg:1 page:df404000 filename:455dd11f len:4096
    do_getname: init /etc/localtime
    do_getname: init seg:1 page:df404000 filename:00000000 len:4096
    Unable to handle kernel NULL pointer dereference at virtual address 00000000
     printing eip:
    c01d8257
    *pde = 00000000
    Oops: 0000 [#1]
    PREEMPT 
    Modules linked in:
    CPU:    0
    EIP:    0060:[<c01d8257>]    Not tainted VLI
    EFLAGS: 00010206   (2.6.11-rc3-mm1) 
    EIP is at strncpy_from_user+0x33/0x47
    eax: c14f0000   ebx: fffffff2   ecx: 00001000   edx: 00001000
    esi: 00000000   edi: df404000   ebp: 00000000   esp: c14f1f60
    ds: 007b   es: 007b   ss: 0068
    Process init (pid: 1, threadinfo=c14f0000 task=dff4ba40)
    Stack: c14f0000 fffffff4 df404000 00000000 c0166854 df404000 00000000 00001000 
           df404000 00000000 00001000 00001000 00000000 00000000 00000901 c14f0000 
           c0158725 00000000 00000000 00000000 00000002 00000000 00000000 00000901 
    Call Trace:
     [<c0166854>] getname+0xb4/0x10f
     [<c0158725>] sys_open+0x12/0xc6
     [<c0102f19>] sysenter_past_esp+0x52/0x75
    Code: 57 56 53 bb f2 ff ff ff 8b 74 24 18 8b 7c 24 14 8b 4c 24 1c 89 f2 83 c2 01 19 ed 39 50 18 83 dd 00 85 ed 75 13 89 ca 85 c9 74 0b <ac> aa 84 c0 74 03 49 75 f7 29 ca 89 d3 89 d8 5b 5e 5f 5d c3 57 
     do_getname: hotplug seg:1 page:dfca1000 filename:080e6770 len:4096
    do_getname: hotplug /etc/hotplug.d/default/20-hal.hotplug
    do_getname: hotplug seg:1 page:df6d1000 filename:080e6770 len:4096
    do_getname: hotplug /etc/hotplug.d/default/20-hal.hotplug
    Kernel panic - not syncing: Attempted to kill init!

If I add this code to do_getname()

+	if (!filename)
+		return -EFAULT;

the machine boots correctly, but then fails later when trying to start
the X server:

    Unable to handle kernel paging request at virtual address 00008050
     printing eip:
    c01d840a
    *pde = 16fd4067
    *pte = 00000000
    Oops: 0002 [#1]
    PREEMPT 
    Modules linked in: radeon joydev mousedev nfs psmouse snd_atiixp_modem nfsd exportfs lockd parport_pc lp parport autofs4 pcmcia sunrpc ipt_LOG ipt_limit ipt_state ipt_REJECT iptable_filter ipt_MASQUERADE iptable_nat ip_tables binfmt_misc dm_mod yenta_socket rsrc_nonstatic pcmcia_core ohci_hcd ehci_hcd usbcore ide_cd cdrom
    CPU:    0
    EIP:    0060:[<c01d840a>]    Not tainted VLI
    EFLAGS: 00013246   (2.6.11-rc3-mm1) 
    EIP is at __copy_to_user_ll+0x3c/0x64
    eax: 00000000   ebx: 00008050   ecx: 00000002   edx: 00008058
    esi: e1a5cc67   edi: 00008050   ebp: ffffffff   esp: d75e9e58
    ds: 007b   es: 007b   ss: 0068
    Process X (pid: 4757, threadinfo=d75e8000 task=d7584020)
    Stack: 00000027 00008050 00000000 00000000 e1a5cc70 c01d84ce 00008050 e1a5cc67 
           00000008 00000008 d75e9ec8 e1a51140 00008050 e1a5cc67 00000008 00000000 
           d75e9f08 c01d8511 d75e9f08 bfd4a320 d7957800 bfd4a320 d75e9f08 ffffffea 
    Call Trace:
     [<c01d84ce>] copy_to_user+0x38/0x42
     [<e1a51140>] version+0xe8/0x138 [radeon]
     [<c01d8511>] copy_from_user+0x39/0x68
     [<c02524e0>] drm_setversion+0x49/0x11b
     [<c0251219>] drm_ioctl+0xeb/0x1c1
     [<c0106407>] handle_vm86_fault+0x78f/0x909
     [<c0106407>] handle_vm86_fault+0x78f/0x909
     [<c016bac7>] do_ioctl+0x57/0x85
     [<c0106407>] handle_vm86_fault+0x78f/0x909
     [<c016bcc8>] vfs_ioctl+0x5c/0x1c3
     [<c0106407>] handle_vm86_fault+0x78f/0x909
     [<c016be6b>] sys_ioctl+0x3c/0x59
     [<c0106407>] handle_vm86_fault+0x78f/0x909
     [<c0102f19>] sysenter_past_esp+0x52/0x75
     [<c0106407>] handle_vm86_fault+0x78f/0x909
    Code: 83 f9 3f 76 0c 89 f8 31 f0 85 05 80 bd 44 c0 75 28 89 c8 83 f9 07 76 17 89 f9 f7 d9 83 e1 07 29 c8 f3 a4 89 c1 c1 e9 02 83 e0 03 <f3> a5 89 c1 f3 a4 83 c4 0c 5e 89 c8 5f c3 89 4c 24 08 89 74 24 
     <3>[drm:drm_release] *ERROR* Device busy: 1 0

Patch used during tests:

diff -puN fs/namei.c~panic-debug fs/namei.c
--- linux/fs/namei.c~panic-debug	2005-02-08 23:06:54.604431440 +0100
+++ linux-petero/fs/namei.c	2005-02-08 23:52:26.585107248 +0100
@@ -116,15 +116,28 @@ static inline int do_getname(const char 
 {
 	int retval;
 	unsigned long len = PATH_MAX;
+	int segment = 0;
 
 	if (!segment_eq(get_fs(), KERNEL_DS)) {
+		segment = 1;
 		if ((unsigned long) filename >= TASK_SIZE)
 			return -EFAULT;
 		if (TASK_SIZE - (unsigned long) filename < PATH_MAX)
 			len = TASK_SIZE - (unsigned long) filename;
 	}
 
+#if 0
+	printk("do_getname: %s seg:%d page:%p filename:%p len:%ld\n",
+	       current->comm, segment, page, filename, len);
+#endif
+
+	if (!filename)
+		return -EFAULT;
+
 	retval = strncpy_from_user(page, filename, len);
+#if 0
+	printk("do_getname: %s %s\n", current->comm, page);
+#endif
 	if (retval > 0) {
 		if (retval < len)
 			return 0;

-- 
Peter Osterlund - petero2@telia.com
http://web.telia.com/~u89404340
