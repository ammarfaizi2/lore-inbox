Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318761AbSG0ODC>; Sat, 27 Jul 2002 10:03:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318762AbSG0ODC>; Sat, 27 Jul 2002 10:03:02 -0400
Received: from post-20.mail.nl.demon.net ([194.159.73.1]:51436 "EHLO
	post-20.mail.nl.demon.net") by vger.kernel.org with ESMTP
	id <S318761AbSG0ODA>; Sat, 27 Jul 2002 10:03:00 -0400
Subject: kfree causes oops
From: Ronald Bultje <rbultje@ronald.bitfreak.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 27 Jul 2002 16:08:10 +0200
Message-Id: <1027778913.3265.56.camel@bultje.demon.nl>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm trying to make some small changes to a driver and am currently
facing a small problem. The driver used to allocate memory when the
module is loaded and deallocate it when the driver is unloaded. I'm
trying to make it only allocate the memory now when it actually needs
it.

For this, I use kmalloc() because it needs contiguous (physically)
memory. This works for the first try, but it always causes an oops on
the second try. dmesg log for the second try looks like this:

DC10plus[0]: ioctl VIDIOCGCAP
DC10plus[0]: ioctl VIDIOCGWIN
DC10plus[0]: ioctl VIDIOCGMBUF
DC10plus[0]: V4L frame 0 mem 0xc1780000 (bus: 0x1780000)
DC10plus[0]: V4L frame 1 mem 0xc17a0000 (bus: 0x17a0000)
DC10plus[0]: mmap(V4L) of 404c6000-40506000 (size=262144)
DC10plus[0]: ioctl VIDIOCMCAPTURE frame=0 geom=160x120 fmt=7
DC10plus[0]: width = 160, height = 120
DC10plus[0]: ioctl VIDIOCMCAPTURE frame=1 geom=160x120 fmt=7
DC10plus[0]: ioctl VIDIOCSYNC 0
DC10plus[0]: ioctl VIDIOCMCAPTURE frame=0 geom=160x120 fmt=7
DC10plus[0]: ioctl VIDIOCSYNC 1
[.. it does this a lot of times - queue and sync on buffer ..]
DC10plus[0]: ioctl VIDIOCSYNC 0
DC10plus[0]: munmap(V4L)
DC10plus[0]: kfree v4l-buffer 0xc1780000
divide error: 0000
CPU:    0
EIP:    0010:[<c012a567>]    Not tainted
EFLAGS: 00210002
eax: 00626680   ebx: 00626680   ecx: c027fb20   edx: 00000000
esi: c1292140   edi: 00200286   ebp: 00000000   esp: cea75e6c
ds: 0018   es: 0018   ss: 0018
Process lt-gst-launch (pid: 7893, stackpage=cea75000)
Stack: 00000000 ca52c000 0000000e 00000030 d38dd3d9 c1780000 d38e4160
d38e721e 
       c1780000 d38e7120 c56015c0 00040000 ce196be0 404c6000 c012436f
cef57320 
       c5601380 000001ff 00000000 c01057f0 cd034000 ce196be0 cea74000
00000002 
Call Trace: [<d38dd3d9>] [<d38e4160>] [<d38e721e>] [<d38e7120>]
[<c012436f>] 
   [<c01057f0>] [<c0114a79>] [<c01189e4>] [<c011d653>] [<c011d70d>]
[<c0106ba4>] 
   [<c013ead2>] [<c0106d30>] 

Code: f7 76 18 89 c3 8b 41 14 89 44 99 18 89 59 14 8b 51 10 8d 42 

ksymoops gives the following trace:

Reading Oops report from the terminal
CPU:    0
EIP:    0010:[<c012a567>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00210002
eax: 00626680   ebx: 00626680   ecx: c027fb20   edx: 00000000
esi: c1292140   edi: 00200286   ebp: 00000000   esp: cea75e6c
ds: 0018   es: 0018   ss: 0018
Process lt-gst-launch (pid: 7893, stackpage=cea75000)
Stack: 00000000 ca52c000 0000000e 00000030 d38dd3d9 c1780000 d38e4160
d38e721e 
       c1780000 d38e7120 c56015c0 00040000 ce196be0 404c6000 c012436f
cef57320 
       c5601380 000001ff 00000000 c01057f0 cd034000 ce196be0 cea74000
00000002 
Call Trace: [<d38dd3d9>] [<d38e4160>] [<d38e721e>] [<d38e7120>]
[<c012436f>] 
   [<c01057f0>] [<c0114a79>] [<c01189e4>] [<c011d653>] [<c011d70d>]
[<c0106ba4>] 
   [<c013ead2>] [<c0106d30>] 
Code: f7 76 18 89 c3 8b 41 14 89 44 99 18 89 59 14 8b 51 10 8d 42

>>EIP; c012a567 <kfree+37/a0>   <=====
Trace; d38dd3d9 <[zoran]v4l_fbuffer_free+a9/e0>
Trace; d38e4160 <[zoran]ZORAN_FORMATS+1a8/2788>
Trace; d38e721e <[zoran]__module_author+e/19>
Trace; d38e7120 <[zoran]zoran+0/c>
Trace; c012436f <exit_mmap+6f/120>
Trace; c01057f0 <__switch_to+20/e0>
Trace; c0114a79 <mmput+39/60>
Trace; c01189e4 <do_exit+84/1b0>
Trace; c011d653 <collect_signal+93/e0>
Trace; c011d70d <dequeue_signal+6d/b0>
Trace; c0106ba4 <do_signal+234/29c>
Trace; c013ead2 <sys_select+472/480>
Trace; c0106d30 <signal_return+14/18>
Code;  c012a567 <kfree+37/a0>
00000000 <_EIP>:
Code;  c012a567 <kfree+37/a0>   <=====
   0:   f7 76 18                  div    0x18(%esi),%eax   <=====
Code;  c012a56a <kfree+3a/a0>
   3:   89 c3                     mov    %eax,%ebx
Code;  c012a56c <kfree+3c/a0>
   5:   8b 41 14                  mov    0x14(%ecx),%eax
Code;  c012a56f <kfree+3f/a0>
   8:   89 44 99 18               mov    %eax,0x18(%ecx,%ebx,4)
Code;  c012a573 <kfree+43/a0>
   c:   89 59 14                  mov    %ebx,0x14(%ecx)
Code;  c012a576 <kfree+46/a0>
   f:   8b 51 10                  mov    0x10(%ecx),%edx
Code;  c012a579 <kfree+49/a0>
  12:   8d 42 00                  lea    0x0(%edx),%eax

So it seems to oops somewhere inside kfree(), which doesn't seem good to
me. ;-). The weird thing is that it only oopses on the second try, never
on the first. So the first time, I kmalloc() some memory, I get it
(addresses are 0xc1780000 and 0xc17a0000), use it (meaning that the
user-application mmap()'s it, the driver uses remap_page_range() for
this, and then the card uses this memory for grabbing video frames, then
the memory is munmap()'ed), kfree() it, then kmalloc() the same amount
of memory (same addresses, again 0xc1780000 and 0x17a0000), use it,
kfree() it -> oops.

Relevant code bits of the driver are here:

memory allocation (v4l_fbuffer_alloc()):
[..]
unsigned char *mem;
mem = (unsigned char *) kmalloc(fh->v4l_buffers.buffer_size,
GFP_KERNEL);
if (mem == 0) {
	printk(KERN_ERR "%s: kmalloc for V4L bufs failed\n", zr->name);
	v4l_fbuffer_free(file);
	return -ENOBUFS;
}
fh->v4l_buffers.buffer[i].fbuffer = mem;
fh->v4l_buffers.buffer[i].fbuffer_phys = virt_to_phys(mem);
fh->v4l_buffers.buffer[i].fbuffer_bus = virt_to_bus(mem);
for (off = 0; off < fh->v4l_buffers.buffer_size; off += PAGE_SIZE)
	mem_map_reserve(MAP_NR(mem + off));
DEBUG1(printk(KERN_INFO "%s: V4L frame %d mem 0x%lx (bus: 0x%lx)\n",
	zr->name, i, (unsigned long) mem, virt_to_bus(mem)));
[..]

memory deallocation (v4l_fbuffer_free()):
[..]
if (!fh->v4l_buffers.buffer[i].fbuffer)
	continue;
if (fh->v4l_buffers.buffer_size <= MAX_KMALLOC_MEM) {
	mem = fh->v4l_buffers.buffer[i].fbuffer;
	for (off = 0; off < fh->v4l_buffers.buffer_size; off += PAGE_SIZE)
		mem_map_unreserve(MAP_NR(mem + off));
	DEBUG1(printk(KERN_INFO "%s: kfree v4l-buffer 0x%lx\n",
		zr->name, (unsigned long) fh->v4l_buffers.buffer[i].fbuffer));
	kfree((void *) fh->v4l_buffers.buffer[i].fbuffer);
}
fh->v4l_buffers.buffer[i].fbuffer = NULL;
[..]

I'm using kernel 2.4.18 with SGI's XFS patch and some of Gerd Knorr's
patches for the new videodev subsystem and video4linux2 support
(http://bytesex.org/patches/). System is RedHat-7.0, with gcc-2.96-85
and glibc-2.2-12 (update RPMs from redhat.com).

Does anyone have a clue what I might be doing wrong here? Thanks for any
input (please CC any reply to me, I'm not subscribed),

Ronald

