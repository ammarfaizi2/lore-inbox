Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271761AbTGRPGo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 11:06:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271840AbTGRPGF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 11:06:05 -0400
Received: from adsl-66-159-224-106.dslextreme.com ([66.159.224.106]:31756 "EHLO
	zork.ruvolo.net") by vger.kernel.org with ESMTP id S271765AbTGROtl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 10:49:41 -0400
Date: Fri, 18 Jul 2003 08:04:29 -0700
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, alsa-devel@lists.sourceforge.net
Subject: Re: 2.6.0-t1 garbage in /proc/ioports and oops
Message-ID: <20030718150429.GE15716@ruvolo.net>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, alsa-devel@lists.sourceforge.net
References: <20030718011101.GD15716@ruvolo.net> <20030717211533.77c0f943.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XStn23h1fwudRqtG"
Content-Disposition: inline
In-Reply-To: <20030717211533.77c0f943.akpm@osdl.org>
User-Agent: Mutt/1.3.28i
From: Chris Ruvolo <chris@ruvolo.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--XStn23h1fwudRqtG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

(adding alsa-devel)

On Thu, Jul 17, 2003 at 09:15:33PM -0700, Andrew Morton wrote:
> You could load all those modules one at a time, doing a `cat /proc/ioport=
s'
> after each one.  One sneaky way of doing that would be to make your
> modprobe executable be:

Ok, this let me track it down to the ALSA snd-sbawe module.  I did not have
isapnp compiled into the kernel and was relying on the userspace isapnp to
configure the device (carried over from 2.4).  Apparently the module didn't
like this.

With isapnp built into the kernel, the module loads successfully.

It seems that the driver is made to not require isapnp, so I'm not sure
where it is going wrong.

> Have you ever unloaded a module?  The usual source of this crash is some
> driver forgot to unregister an IO region during module unload.  So a read
> of /proc/ioports crashes _after_ the module is rmmodded.

No, I hadn't.  I was able to reproduce this by just loading the snd_sbawe
module on a clean boot.  Transcript follows.

Thanks,
-Chris


# /sbin/isapnp /etc/isapnp.conf
Board 1 has Identity 0e 10 00 2f 76 45 00 8c 0e:  CTL0045 Serial No 2684476=
06 [checksum 0e]
CTL0045/268447606[0]{Audio               }: Ports 0x220 0x330 0x388; IRQ5 D=
MA1 DMA5 --- Enabled OK
CTL0045/268447606[2]{WaveTable           }: Port 0x620; --- Enabled OK

# cat /proc/ioports=20
0000-001f : dma1
0020-0021 : pic1
0040-005f : timer
0060-006f : keyboard
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
0376-0376 : ide1
03c0-03df : vga+
03f6-03f6 : ide0
0cf8-0cff : PCI conf1
4000-403f : Intel Corp. 82371AB/EB/MB PIIX4
5000-501f : Intel Corp. 82371AB/EB/MB PIIX4
d000-dfff : PCI Bus #01
  d000-d0ff : 3Dfx Interactive, In Voodoo 3
e000-e01f : Intel Corp. 82371AB/EB/MB PIIX4
e400-e4ff : Lite-On Communicatio LNE100TX
e800-e87f : VIA Technologies, In IEEE 1394 Host Contr
ec00-ec07 : US Robotics/3Com 56K FaxModem Model 5
f000-f00f : Intel Corp. 82371AB/EB/MB PIIX4
  f000-f007 : ide0
  f008-f00f : ide1

# modprobe snd_sbawe
FATAL: Error inserting snd_sbawe (/lib/modules/2.6.0-test1/kernel/sound/isa=
/sb/snd-sbawe.ko): No such device

# cat /proc/ioports
Segmentation fault

# dmesg | tail -31
sbawe: fatal error - EMU-8000 synthesizer not detected at 0x620
Sound Blaster 16 soundcard not found or device busy
In case, if you have non-AWE card, try snd-sb16 module
Unable to handle kernel paging request at virtual address c887d0f5
 printing eip:
c01a123a
*pde =3D 07bc6067
*pte =3D 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<c01a123a>]    Not tainted
EFLAGS: 00010297
EIP is at vsnprintf+0x31a/0x450
eax: c887d0f5   ebx: 0000000a   ecx: c887d0f5   edx: fffffffe
esi: c739f0d3   edi: 00000000   ebp: c73a3ec0   esp: c73a3e88
ds: 007b   es: 007b   ss: 0068
Process cat (pid: 202, threadinfo=3Dc73a2000 task=3Dc73f8140)
Stack: c739f0cc c739ffff 0000038b 00000000 00000010 00000004 00000002 00000=
001
       ffffffff ffffffff c739ffff c13fed60 00000000 c0241301 c73a3edc c0167=
426
       c739f0c7 00000f39 c024131a c73a3ef8 c72f3700 c73a3f04 c011cf64 c13fe=
d60
Call Trace:
 [<c0167426>] seq_printf+0x36/0x60
 [<c011cf64>] do_resource_list+0x64/0xa0
 [<c011cfeb>] ioresources_show+0x4b/0x70
 [<c0166e0f>] seq_read+0xef/0x300
 [<c0149b3a>] vfs_read+0xaa/0x130
 [<c0149def>] sys_read+0x3f/0x60
 [<c010940b>] syscall_call+0x7/0xb

Code: 80 38 00 74 07 40 4a 83 fa ff 75 f4 29 c8 83 e7 10 89 c3 75
 <6>note: cat[202] exited with preempt_count 1


--XStn23h1fwudRqtG
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE/GAx9KO6EG1hc77ERAu8vAKC/5/v4MTIhxSr9sjLCOTkZMYkAaACgz/d4
iVz1FkP6nS7uT6F9wkwdfK4=
=/UOx
-----END PGP SIGNATURE-----

--XStn23h1fwudRqtG--
