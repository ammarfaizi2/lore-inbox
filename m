Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267558AbUJLS17@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267558AbUJLS17 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 14:27:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266561AbUJLS17
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 14:27:59 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:44974 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S267558AbUJLS1O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 14:27:14 -0400
Message-Id: <200410121827.i9CIRAc6014366@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.1 07/26/2004 with nmh-1.1-RC3
To: linux-kernel@vger.kernel.org
Subject: 2.6.9-rc4-mm1-VP-T7 - horrid death in vortex_init at boot
From: Valdis.Kletnieks@vt.edu
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1246049674P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 12 Oct 2004 14:27:10 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1246049674P
Content-Type: text/plain; charset=us-ascii

2.6.9-rc4-mm1-VP-T7 plus Ingo's patch to profile.c and 3c59x.c to use
raw_rwlock_t and raw_spinlock_t rather than the non-raw variant.  It croaked
when it found the onboard ethernet controller on a Dell Latitude C840 laptop:

lspci says it's a:
02:00.0 Ethernet controller: 3Com Corporation 3c905C-TX/TX-M [Tornado] (rev 78)

Got the following (admittedly truncated - was handwritten and CTS is a pain,
literally) at very early boot:

3c59x: Donald Becker and others. ...
0000:02:00.0: 3Com PCI 3c905C Tornado at 0xec80. Vers LK1.1.19
kernel BUG at net/core/net-sysfs.c:384
process swapper
... registers skipped
call trace:
	show_stack
	show_registers
	die
	do_invalid_op
	error_code
	class_hotplug
	kobject_hotplug
	kobject_add
	class_device_add
	netdev_register_sysfs
	netdev_run_todo
	register_netdev
	vortex_probe1
	vortex_init_one
	pci_device_probe_static
	__pci_device_probe
	pci_device_probe
	bus_match
	driver_attach
	bus_add_driver
	driver_register
	pci_register_driver
	vortex_init
	do_initcalls

The offending code:

static void netdev_release(struct class_device *cd)
{
        struct net_device *dev
                = container_of(cd, struct net_device, class_dev);

        BUG_ON(dev->reg_state != NETREG_RELEASED);

        kfree((char *)dev - dev->padded);
}

I'm guessing something broken in the bk-driver-core patch in -rc4-mm1, as
that completely overhauled this stuff.

This ring any bells?  If need be, I'll scare up a serial cable and get a
more complete trace - somehow, I don't think netconsole will help here.. ;)

(As an aside, kobject_hotplug calls call_usermodehelper() - which seems
like a Bad Idea if we haven't gotten userspace up and running yet?

--==_Exmh_1246049674P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFBbCH9cC3lWbTT17ARAi7PAKDVxTBrpIm7YL7EchVZAjDOqZJMAACfZxU6
ZrvbH9LaWmfp5oiaxCLP5Jg=
=vL+f
-----END PGP SIGNATURE-----

--==_Exmh_1246049674P--
