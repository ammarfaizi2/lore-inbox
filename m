Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262217AbVAUAeF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262217AbVAUAeF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 19:34:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262230AbVAUAeF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 19:34:05 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:55178 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262217AbVAUAbw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 19:31:52 -0500
Message-ID: <41F04D73.20800@us.ibm.com>
Date: Thu, 20 Jan 2005 16:31:47 -0800
From: "Darrick J. Wong" <djwong@us.ibm.com>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041124)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-aio@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH] BUG in io_destroy (fs/aio.c:1248)
X-Enigmail-Version: 0.89.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig5E134474FD3CC35D9385CC32"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig5E134474FD3CC35D9385CC32
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi all,

[Please cc me on any replies because I'm not subscribed to linux-aio or 
linux-kernel.]

I was running a random system call generator against mainline the other 
day and got this bug report about AIO in dmesg:

------------[ cut here ]------------
kernel BUG at fs/aio.c:1249!
invalid operand: 0000 [#1]
PREEMPT SMP
Modules linked in: 8250 serial_core isofs zlib_inflate ipt_limit 
iptable_mangle ipt_LOG ipt_MASQUERADE iptable_nat ipt_TOS ipt_REJECT 
ip_conntrack_irc ip_conntrack_ftp ipt_state ip_conntrack iptable_filter 
ip_tables snd_intel8x0 snd_ac97_codec snd_pcm snd_timer snd soundcore 
snd_page_alloc intel_agp agpgart evdev ehci_hcd uhci_hcd usbcore piix 
ext2 ide_generic ide_cd ide_core cdrom
CPU:    0
EIP:    0060:[<c0170245>]    Not tainted VLI
EFLAGS: 00010286   (2.6.10-elm3a74)
EIP is at io_destroy+0xb1/0xce
eax: ffffffff   ebx: f6b2a300   ecx: 00000000   edx: cfca1000
esi: d0da5e80   edi: f6b2a488   ebp: cfca1fa4   esp: cfca1f94
ds: 007b   es: 007b   ss: 0068
Process io_destroy (pid: 6610, threadinfo=cfca1000 task=f6cdca20)
Stack: 00000000 08048008 fffffff2 fffffff2 cfca1fbc c01702fc d0da5e80 
00000010
        b7fd8c50 bffff3d4 cfca1000 c0102eb3 00000010 08048008 080482fd 
b7fd8c50
        bffff3d4 bffff3e8 000000f5 0000007b 0000007b 000000f5 b7f7c60d 
00000073
Call Trace:
  [<c0103d25>] show_stack+0x7a/0x90
  [<c0103ea6>] show_registers+0x152/0x1ca
  [<c01040b7>] die+0x100/0x184
  [<c01044a8>] do_invalid_op+0xa3/0xad
  [<c01039cf>] error_code+0x2b/0x30
  [<c01702fc>] sys_io_setup+0x9a/0xa9
  [<c0102eb3>] syscall_call+0x7/0xb
Code: 1c 8b 06 85 c0 78 24 83 c4 04 5b 5e 5f 5d c3 8b 0a 85 c9 2e 74 b5 
8b 46 10 89 02 eb ae 83 c4 04 89 f0 5b 5e 5f 5d e9 9b ee ff ff <0f> 0b 
e1 04 f5 f6 2b c0 eb d2 89 f0 e8 8a ee ff ff eb ab 0f 0b

This is a fairly run-of-the mill P4 box with SCSI disks and a plain 
vanilla 2.6.10 kernel on Debian.I 've written a test case that exposes 
this bug:

http://submarine.dyndns.org/~djwong/docs/io_destroy.c

The program takes as its only argument the address of a region of read 
only memory.  The libc mmap is a pretty good place for this, so you can 
run the program thusly:

$ ./io_destroy `cat /proc/$$/maps | grep libc- | grep 'r-' | \
awk -F "-" '{print $1}'`

...and watch the program segfault.  If you can't find an address, 
8048000 seems to work in most cases.

I think I've found the cause of this bug.  Each ioctx structure has a
"users" field that acts as a reference counter for the ioctx, and a
"dead" flag that seems to indicate that the ioctx isn't associated with
any particular list of IO requests.

The problem, then, lies in aio.c:1247.	The io_destroy function checks
the (old) value of the dead flag--if it's false (i.e. the ioctx is
alive), then the function calls put_ioctx to decrease the reference
count on the assumption that the ioctx is no longer associated with any
requests.  Later, it calls put_ioctx again, on the assumption that
someone called lookup_ioctx to perform some operation at some point.

This BUG is caused by the reference counts being off.  The testcase that
I provided looks for a chunk of user memory that's read-only and passes
that to the sys_io_setup syscall.  sys_io_setup checks that the pointer
is readable, creates the ioctx and then tries to write the ioctx handle
back to userland.  This is where the problems start to surface.

Since the pointer points to a non-writable region of memory, the write
fails.	The syscall handler then destroys the ioctx.  The dead flag is
zero, so io_destroy calls put_ioctx...but wait!  Nobody ever put the
ioctx into a request list.  The ioctx is alive but not in a list, yet
the io_destroy code assumes that being alive implies being in a request
list somewhere.  Hence, calling put_ioctx is bogus; the reference count
becomes 0, and the ioctx is freed.  Worse yet, put_ioctx is called again
(on a freed pointer!) to clear up the lookup_ioctx that never happened.
  put_ioctx sees that the reference count has become negative and BUGs.

The patch that I've provided calls aio_cancel_all before calling
io_destroy in this failure case.  aio_cancel_all sets ioctx->dead = 1
and cancels all requests (there shouldn't be any in this case) in
progress.  Since the dead flag is 1, io_destroy calls put_ioctx once to
zero the reference count and free the ioctx, and thus the BUG condition
doesn't get triggered.	The userland program receives an error code
instead of a segfault.

This patch is against 2.6.10; the problem doesn't seem to be fixed in 
2.6.11-rc1.  A simpler version of this fix would simply say "ioctx->dead 
= 1;" (or even call "get_ioctx(ioctx);" to inflate the refcounts 
artificially), but as I'm not an AIO developer I don't want to be the 
one making that call.

--Darrick

-----------------

Signed-off-by: Darrick Wong <djwong@us.ibm.com>

--- linux-2.6.10-a74/fs/aio.c   2004-12-24 13:34:44.000000000 -0800
+++ linux-2.6.10/fs/aio.c       2005-01-12 16:09:37.000000000 -0800
@@ -1285,6 +1285,7 @@
                 if (!ret)
                         return 0;

+               aio_cancel_all(ioctx);
                 io_destroy(ioctx);
         }

--------------enig5E134474FD3CC35D9385CC32
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFB8E1za6vRYYgWQuURAgEjAJ9HIFwZII9rXlAXR4641/YGbVxvkgCgi1vO
8XvrG0VBV0yWYWq91ODFu58=
=1v9o
-----END PGP SIGNATURE-----

--------------enig5E134474FD3CC35D9385CC32--
