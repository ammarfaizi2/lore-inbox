Return-Path: <linux-kernel-owner+w=401wt.eu-S965038AbXABXRr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965038AbXABXRr (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 18:17:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965064AbXABXRr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 18:17:47 -0500
Received: from smtp.bulldogdsl.com ([212.158.248.8]:1125 "EHLO
	mcr-smtp-002.bulldogdsl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S965038AbXABXRp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 18:17:45 -0500
X-Spam-Abuse: Please report all spam/abuse matters to abuse@bulldogdsl.com
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: kernel + gcc 4.1 = several problems
Date: Tue, 2 Jan 2007 23:18:11 +0000
User-Agent: KMail/1.9.5
Cc: Adrian Bunk <bunk@stusta.de>,
       "Zhang, Yanmin" <yanmin_zhang@linux.intel.com>,
       LKML <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>,
       Chuck Ebbert <76306.1226@compuserve.com>, Andrew Morton <akpm@osdl.org>
References: <200612201421.03514.s0348365@sms.ed.ac.uk> <200701022156.48919.s0348365@sms.ed.ac.uk> <Pine.LNX.4.64.0701021408280.4473@woody.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0701021408280.4473@woody.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701022318.11680.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

On Tuesday 02 January 2007 22:13, Linus Torvalds wrote:
[snip]
> What are the exact crash details? That might narrow things down enough
> that maybe you could try just one or two files that are "suspect".

I'll do a digest of the problem for you and anybody else that's lost track of 
the debugging story so far..

There are no hardware problems evidenced by any testing I have performed 
(memtest, prime95 CPU torture tests, temp monitors). Furthermore, kernels 
compiled with older GCCs have been running without problems for literally 
years on this machine.

Here is an example of an oops. The kernel continued to limp along after this.

BUG: unable to handle kernel NULL pointer dereference at virtual address 
00000009
 printing eip:
c0156f60
*pde = 00000000
Oops: 0002 [#1]
Modules linked in: ipt_recent ipt_REJECT xt_tcpudp ipt_MASQUERADE iptable_nat 
xt_state iptable_filter ip_tables x_tables prism54 yenta_socket 
rsrc_nonstatic pcmcia_core snd_via82xx snd_ac97_codec snd_ac97_bus snd_pcm 
snd_timer snd_page_alloc snd_mpu401_uart snd_rawmidi snd soundcore ehci_hcd 
usblp eth1394 uhci_hcd usbcore ohci1394 ieee1394 via_agp agpgart vt1211 
hwmon_vid hwmon ip_nat_ftp ip_nat ip_conntrack_ftp ip_conntrack
CPU:    0
EIP:    0060:[<c0156f60>]    Not tainted VLI
EFLAGS: 00010246   (2.6.19.1 #1)
EIP is at pipe_poll+0xa0/0xb0
eax: 00000008   ebx: 00000000   ecx: 00000008   edx: 00000000
esi: f70f3e9c   edi: f7017c00   ebp: f70f3c1c   esp: f70f3c0c
ds: 007b   es: 007b   ss: 0068
Process python (pid: 4178, ti=f70f2000 task=f70c4a90 task.ti=f70f2000)
Stack: 00000000 00000000 f70f3e9c f6e111c0 f70f3fa4 c015d7f3 f70f3c54 f70f3fac
       084c44a0 00000030 084c44d0 00000000 f70f3e94 f70f3e94 00000006 f70f3ecc
       00000000 f70f3e94 c015e580 00000000 00000000 00000006 f6e111c0 00000000
Call Trace:
 [<c015d7f3>] do_sys_poll+0x253/0x480
 [<c015da53>] sys_poll+0x33/0x50
 [<c0102c97>] syscall_call+0x7/0xb
 [<b7f6b402>] 0xb7f6b402
 =======================
Code: 58 01 00 00 0f 4f c2 09 c1 89 c8 83 c8 08 85 db 0f 44 c8 8b 5d f4 89 c8 
8b 75 f8 8b 7d fc 89 ec 5d c3 89 ca 8b 46 6c 83 ca 10 3b <87> 68 01 00 00 0f 
45 ca eb b6 8d b6 00 00 00 00 55 b8 01 00 00
EIP: [<c0156f60>] pipe_poll+0xa0/0xb0 SS:ESP 0068:f70f3c0c

Chuck observed that the kernel tries to reenter pipe_poll half way through an 
instruction (c0156f5f->c0156f60); it's not a single-bit error but an 
off-by-one.

On Wednesday 20 December 2006 20:48, Chuck Ebbert wrote:
> In-Reply-To: <200612201421.03514.s0348365@sms.ed.ac.uk>
>
> On Wed, 20 Dec 2006 14:21:03 +0000, Alistair John Strachan wrote:
> > Any ideas?
> >
> > BUG: unable to handle kernel NULL pointer dereference at virtual address
> > 00000009
>
>     83 ca 10                  or     $0x10,%edx
>     3b                        .byte 0x3b
>     87 68 01                  xchg   %ebp,0x1(%eax)   <=====
>     00 00                     add    %al,(%eax)
>
> Somehow it is trying to execute code in the middle of an instruction.
> That almost never works, even when the resulting fragment is a legal
> opcode. :)
>
> The real instruction is:
>
>     3b 87 68 01 00 00 00        cmp    0x168(%edi),%eax

I've tried a multitude of kernel configs and compiler options, but none have 
made any difference. That first oops was pretty lucky, very often the machine 
locks up after oopsing (panic_on_oops=1 doesn't work). I've not seen oopses 
anywhere but in pipe_poll, but I've not seen many oopses.

The machine runs jabberd 2.x which uses separate python processes as 
transports to different networks. The server hosts 50-100 users. One of my 
oops reports had Java crashing in the same place, that's Azureus.

I've got binutils 2.17, gcc 4.1.1 hand bootstrapped from GNU sources (not 
distro versions). I've got another, secondary compiler (3.4.6), also compiled 
from GNU sources, installed elsewhere which I have used to build working 
kernels. So the only variable, for sure, is GCC itself.

Both compilers were built with "make bootstrap" and I built binutils with the 
resulting GCC, and GCC with the resulting binutils, just to be sure. The only 
slightly non-standard thing I do is to compile everything (GCC, binutils, the 
kernels) on a dual-opteron box, inside a 32bit chroot, which is rsync'ed over 
to the Via C3-2 box with the problem. I can't see how this would cause any 
problems (and indeed have done it successfully for years), but I thought I'd 
point it out.

The crashes take time to appear, which is why so many people suspected 
hardware initially. But the uptime of a GCC 4.1.1 kernel will always be less 
than 12 hours, where a 3.4.6 kernel will survive for months. I've had no 
other mysterious software crashes, ever.

On Sunday 31 December 2006 22:16, Alistair John Strachan wrote:
> On Sunday 31 December 2006 21:43, Chuck Ebbert wrote:
> > Those were compiled without frame pointers.  Can you post them compiled
> > with frame pointers so they match your original bug report? And confirm
> > that pipe_poll() is still at 0xc0156ec0 in vmlinux?
>
> c0156ec0 <pipe_poll>:
>
> I used the config I original sent you to rebuild it again. This time I've
> put up the whole vmlinux for both kernels, the config is replaced, the
> decompilation is re-done, I've confirmed the offset in the GCC 4.1.1 kernel
> is identical. Sorry for the confusion.
[snip]
> http://devzero.co.uk/~alistair/2.6.19-via-c3-pipe_poll/

At the above URL can be found vmlinux images, the config used to build both, 
and decompilations of the fs/pipe.o file (with relocation information).

The suggestions I've had so far which I have not yet tried:

-	Select a different x86 CPU in the config.
		-	Unfortunately the C3-2 flags seem to simply tell GCC
			to schedule for ppro (like i686) and enabled MMX and SSE
		-	Probably useless

-	Enable as many debug options as possible ("a shot in the dark")

-	Try compiling a minimal kernel config, sans modules that are not required
	for booting. The problem with this one (whilst it might uncover some bizarre
	memory scribbling or stack corruption) is that the machine's primary role is
	that of a router, so I require most of the modules loaded for the oops to be
	reproduced (chicken, egg?).

If I can provide any more information, please do let me know.

-- 
Cheers,
Alistair.

Final year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
