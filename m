Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261292AbVARNWj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261292AbVARNWj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jan 2005 08:22:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261293AbVARNWj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jan 2005 08:22:39 -0500
Received: from p0f.net ([193.77.154.190]:12242 "EHLO svarog.thaico.si")
	by vger.kernel.org with ESMTP id S261292AbVARNWa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jan 2005 08:22:30 -0500
Date: Tue, 18 Jan 2005 14:28:39 +0100
From: Grega Bremec <gregab@p0f.net>
To: linux-kernel@vger.kernel.org
Subject: Lock-ups in AHCI (?)
Message-ID: <20050118132839.GA31710@lunik.p0f.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="liOOAslEiF7prFVr"
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Organization: p0f
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--liOOAslEiF7prFVr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello, list.

NOTE: I am not subscribed, so please CC me in any of your replies.

I recently set up a machine featuring an Intel ICH6 desktop board
with two 200GB Seagates (ST3200822AS) in mirrored volume, AHCI mode,
with linux kernel 2.6.10 and ext3.

After a relatively small amount of I/O (for example, compiling ISC
bind), I get lock-ups (keyboard LEDs do not respond, SysRq works :)).

Timed vmstat dumps snapshot during a couple of bonnie++ tests are
available upon request, and it's evident from those that I/O was
rather bursty with regard to interactivity, and most all lock-ups
happened during rewrite phase, in second consecutive test run, when
cached memory was usually at around 1.75GB.

If I only let bonnie++ do one test and then exit() before re-running,
I was able to perform numerous tests if the thing survived the first
one, of course, as cache size went down to ~12MB after exit().

Setting chunk size and/or buffered i/o had marginal, if any, effect
on the success of the test.

The usual stack trace after a lock-up looks like this:

Pid: 1399, comm:           kmirrord/0
EIP: 0060:[<c0725421>] CPU: 0
EIP is at __read_lock_failed+0x5/0x14
 EFLAGS: 00000297    Not tainted  (2.6.10-sk98-4k-p0f-smp)
 EAX: c23a959c EBX: c23a959c ECX: c23a9580 EDX: c0a21000
 ESI: 000134b3 EDI: c23a958c EBP: 00000000 DS: 007b ES: 007b
 CR0: 8005003b CR2: 0809b890 CR3: 32159000 CR4: 000006d0
  [<c0726cf5>] _read_lock+0x15/0x20
  [<c05d65c7>] rh_dec+0x27/0xe0
  [<c05d7832>] mirror_end_io+0x32/0x40
  [<c05c997c>] clone_endio+0x7c/0x130
  [<c05d6c70>] write_callback+0x0/0x80
  [<c01692d5>] bio_endio+0x55/-x80
  [<c05d6cd7>] write_callback+0x67/0x80
  [<c05d0057>] dec_count+0x57/0x80
  [<c05d019d>] endio+0x5d/0x80
  [<c01692d5>] bio_endio+0x55/0x80
  [<c0478367>] __end_that_request_first+0x1c7/0x240
  [<c04ee14b>] scsi_end_request+0x3b/0x100
  [<c04ee4de>] scsu_io_completion+0x10e/0x4e0
  [<c0503841>] sd_rw_intr+0x81/0x280
  [<c04e921f>] scsi_finish_command+0x7f/0xe0
  [<c04e9128>] scsi_softirq+0xc8/0xf0
  [<c012752d>] __do_softirq+0xbd/0xd0
  [<c010591a>] do_softirq+0x4a/0x60
  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
  [<c0141719>] irq_exit+0x39/0x40
  [<c01057e3>] do_IRQ+0x63/0xb0
  [<c0103c36>] common_interrupt+0x1a/0x20
  [<c014007b>] audit_log+0x3b/0x41
  [<c0726eb9>] _spin_unlock_irq+0x9/0x20
  [<c05d61aa>] __rh_alloc+0xfa/0x100
  [<c05d655c>] rh_inc+0xac/0xb0
  [<c05d6593>] rh_inc_pending+0x33/0x40
  [<c05d6eb6>] do_writes+0xe6/0x1d0
  [<c05d7025>] do_mirror+0x85/0x90
  [<c05d7068>] do_work+0x38/0x70
  [<c0132d10>] worker_thread+0x1d0/0x270
  [<c05d7030>] do_work+0x0/0x70
  [<c011dbd0>] default_wake_function+0x0/0x20
  [<c011dbd0>] default_wake_function+0x0/0x20
  [<c0132b40>] worker_thread+0x0/0x270
  [<c013721a>] kthread+0xba/0xc0
  [<c0137160>] kthread+0x0/0xc0
  [<c0101305>] kernel_thread_helper+0x5/0x10

I was able to obtain the former one directly, with no previous action,
whereas a couple of other stack traces were only possible after a SAK,
yet with the exception of below, they were always identical.

Sometimes, a __wake_up_common and a __mod_timer would appear just below
scsi_io_completion, an audit_log was sometimes missing below
common_interrupt, but I suppose that's really far too far down the stack
to be of significance.

Board data:
    Product number: D925XCV Desktop Board
    BIOS Version: CV92510A.86A.0249.2004.0819.1259
    Board version: AAC57587-404

I had to patch from a beta sk98 driver to get support for Marvell
Gbit card on the board. No other patches were added to the kernel.

The ICH6 controller is in AHCI mode and the AHCI driver is the only
low-level SCSI driver included in the kernel (NOTE: I have no idea
how the QLogic driver came in :)):

    CONFIG_SCSI=3Dy
    CONFIG_SCSI_PROC_FS=3Dy
    CONFIG_SCSI_MULTI_LUN=3Dy
    CONFIG_SCSI_CONSTANTS=3Dy
    CONFIG_SCSI_LOGGING=3Dy
    CONFIG_SCSI_SPI_ATTRS=3Dy
    CONFIG_SCSI_FC_ATTRS=3Dy
    CONFIG_SCSI_SATA=3Dy
    CONFIG_SCSI_SATA_AHCI=3Dy
    CONFIG_SCSI_ATA_PIIX=3Dm
    CONFIG_SCSI_QLA2XXX=3Dy

Another interesting thing - when I start the dmraid up, I usually
(in 999 out of 1000 cases) get the following error messages from the
kernel:

attempt to access beyond end of device
sda: rw=3D0, want=3D390725760, limit=3D390721968
attempt to access beyond end of device
sda: rw=3D0, want=3D390725888, limit=3D390721968
attempt to access beyond end of device
sda: rw=3D0, want=3D390726016, limit=3D390721968
attempt to access beyond end of device
sda: rw=3D0, want=3D390726144, limit=3D390721968
attempt to access beyond end of device
sdb: rw=3D1, want=3D390725760, limit=3D390721968
attempt to access beyond end of device
sdb: rw=3D1, want=3D390725888, limit=3D390721968
attempt to access beyond end of device
sdb: rw=3D1, want=3D390726016, limit=3D390721968
attempt to access beyond end of device
sdb: rw=3D1, want=3D390726144, limit=3D390721968
attempt to access beyond end of device
=2E..

Nothing b0rks though. Is this something to worry about?

Let me know if I can provide any additional information, or if
anybody is interested in those vmstat dumps. I'll retry with whatever
state the 2.6.11 AHCI driver is in in the mean time.

With kind regards,
--=20
    Grega Bremec
    gregab at p0f dot net

--liOOAslEiF7prFVr
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFB7Q8Hfu4IwuB3+XoRAtqvAJ9ai+gLdf1jUhW5t6Z45nYAZrbw4ACdE1bm
ARMJ9hvsPSoaYNqSIxurS5U=
=yu04
-----END PGP SIGNATURE-----

--liOOAslEiF7prFVr--
