Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966278AbWKTRgi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966278AbWKTRgi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 12:36:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966274AbWKTRgi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 12:36:38 -0500
Received: from mivlgu.ru ([81.18.140.87]:23169 "EHLO master.mivlgu.local")
	by vger.kernel.org with ESMTP id S966264AbWKTRgg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 12:36:36 -0500
Date: Mon, 20 Nov 2006 20:36:33 +0300
From: Sergey Vlasov <vsu@altlinux.ru>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: proc_kill_inodes() race WRT vfs_read() and other users of filp->f_ops
Message-ID: <20061120173633.GA3075@master.mivlgu.local>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EeQfGwPcQSOJBaQU"
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello!

proc_kill_inodes() (called by remove_proc_entry()) tries to revoke
access to the removed entry by finding all open files for that entry
and setting filp->f_op =3D NULL in them.  However, it does so without
any locking against users of filp->f_op (file_list_lock() protects
only against concurrent file opens, but does nothing to protect
against sys_read() calls for an already open file).

One way to get a reproducible oops:

# modprobe bonding
# while true; do ip link set bond0 name bond1; ip link set bond1 name bond0=
; done

and try to run this program in parallel:

#include <fcntl.h>
#include <unistd.h>

int main(int argc, char **argv)
{
	char buf[4096];
	for (;;) {
		int fd =3D open(argv[1], O_RDONLY);
		if (fd !=3D -1) {
			while (read(fd, buf, sizeof(buf)) !=3D -1)
				;
			close(fd);
		}
	}
}

=2E/file_read_check /proc/net/bonding/bond0

After some warnings:

de_put: deferred delete of bond0
remove_proc_entry: bonding/bond0 busy, count=3D1
de_put: deferred delete of bond0
remove_proc_entry: bonding/bond0 busy, count=3D1
de_put: deferred delete of bond0
remove_proc_entry: bonding/bond0 busy, count=3D1

the kernel soon oopses:

BUG: unable to handle kernel NULL pointer dereference at virtual address 00=
000008
 printing eip:
c01621e8
*pde =3D 00000000
Oops: 0000 [#1]
SMP=20
Modules linked in: bonding binfmt_misc nfsd exportfs lockd nfs_acl sunrpc a=
utofs4 ac thermal processor fan button ide_cd cdrom tsdev analog ns558 game=
port psmouse parport_pc parport floppy pcspkr sg it87 hwmon_vid hwmon eepro=
m i2c_isa ipx p8023 usb_storage libusual snd_intel8x0 snd_ac97_codec snd_pc=
m_oss snd_seq_dummy snd_seq_oss snd_seq_midi_event snd_seq snd_seq_device s=
nd_mixer_oss snd_ac97_bus snd_pcm intel_agp snd_timer snd skge agpgart uhci=
_hcd ehci_hcd soundcore i2c_i801 usbcore snd_page_alloc i2c_core nls_koi8_r=
 nls_cp866 vfat fat nls_base ext2 mbcache dm_mod rtc xfs ata_piix libata sd=
_mod scsi_mod ide_disk ide_generic generic piix ide_core
CPU:    1
EIP:    0060:[<c01621e8>]    Not tainted VLI
EFLAGS: 00010246   (2.6.18-std-smp-alt0.11.1 #1)=20
EIP is at vfs_read+0x90/0x15d
eax: 00000000   ebx: f6272a40   ecx: c02dc100   edx: 00000004
esi: 00000000   edi: bf883b04   ebp: 00001000   esp: ee7fdf84
ds: 007b   es: 007b   ss: 0068
Process file_read_check (pid: 29955, ti=3Dee7fd000 task=3Ddfcf27a0 task.ti=
=3Dee7fd000)
Stack: 00001000 00000000 f6272a40 fffffff7 bf884bb8 ee7fd000 c0162672 ee7fd=
fa4=20
       000000b7 00000000 00000000 00000003 bf883b04 c0102e17 00000003 bf883=
b04=20
       00001000 bf883b04 bf884bb8 bf884b18 00000003 0000007b 0000007b 00000=
003=20
Call Trace:
 [<c0162672>] sys_read+0x41/0x67
 [<c0102e17>] syscall_call+0x7/0xb
DWARF2 unwinder stuck at syscall_call+0x7/0xb
Leftover inexact backtrace:
Code: 85 c0 89 c5 0f 88 e5 00 00 00 8b 0d 00 89 3e c0 ba 04 00 00 00 89 d8 =
ff 91 f0 00 00 00 85 c0 74 07 89 c5 e9 c7 00 00 00 8b 43 10 <8b> 70 08 85 f=
6 74 11 8b 44 24 1c 89 e9 89 fa 89 04 24 89 d8 ff=20
EIP: [<c01621e8>] vfs_read+0x90/0x15d SS:ESP 0068:ee7fdf84

The kernel crashes at this place in vfs_read():

			if (file->f_op->read)
				ret =3D file->f_op->read(file, buf, count, pos);

because file->f_op is NULL, even though it was checked to be non-NULL
before.

This was reproduced on a 2.6.18.3-based kernel, but I don't see any
changes which would solve this problem in the current version.

Does someone have an idea how to fix this?

--=20
Sergey Vlasov

--EeQfGwPcQSOJBaQU
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFFYeehW82GfkQfsqIRApMOAJ0cf78EV9C7D1zJEJjb45+kh7zAigCfUl7a
idyOzv2P925MiDanWbgxb94=
=L+ec
-----END PGP SIGNATURE-----

--EeQfGwPcQSOJBaQU--
