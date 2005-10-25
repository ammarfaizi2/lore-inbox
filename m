Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932203AbVJYQcG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932203AbVJYQcG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Oct 2005 12:32:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932204AbVJYQcG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Oct 2005 12:32:06 -0400
Received: from mivlgu.ru ([81.18.140.87]:25515 "EHLO mail.mivlgu.ru")
	by vger.kernel.org with ESMTP id S932203AbVJYQcF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Oct 2005 12:32:05 -0400
Date: Tue, 25 Oct 2005 20:31:55 +0400
From: Sergey Vlasov <vsu@altlinux.ru>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: "Schupp Roderich (extern) BenQ MD PD SWP 2 CM MCH"@mivlgu.ru
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Tue__25_Oct_2005_20_31_55_+0400_64ouSWQweEh0822b"
Message-Id: <20051025164641.07452801B@mail.mivlgu.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Tue__25_Oct_2005_20_31_55_+0400_64ouSWQweEh0822b

 <Roderich.Schupp.extern@mch.siemens.de>, LKML
 <linux-kernel@vger.kernel.org>, Linux-hotplug-devel@lists.sourceforge.net
Bcc: vsu@mivlgu.ru
Subject: Re: Race between "mount" uevent and /proc/mounts?
Message-Id: <20051025203155.699a2d4d.vsu@altlinux.ru>
In-Reply-To: <20051025140041.GO7992@ftp.linux.org.uk>
References: <0AD07C7729CA42458B22AFA9C72E7011C8EF@mhha22kc.mchh.siemens.de>
	<20051025140041.GO7992@ftp.linux.org.uk>
X-Mailer: Sylpheed version 1.0.0beta4 (GTK+ 1.2.10; i586-alt-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Tue, 25 Oct 2005 15:00:41 +0100 Al Viro wrote:

> On Tue, Oct 25, 2005 at 03:20:10PM +0200, Schupp Roderich (extern) BenQ MD PD SWP 2 CM MCH wrote:
> > the 2.6.13 and 2.6.14-* kernels seem susceptible to a race condition
> > between the sending of a "mount" uevent and the actual mount becoming
> > visible thru /proc/mounts, at least when the kernel is configured
> > with voluntary preemption. 

The "umount" uevent has the same problem - the event is emitted at the
start of umount process, but the umount can really complete much later
(e.g., if there was a lot of cached writes).  This is really bad,
because the "umount" uevent cannot be used to tell the user when it is
safe to remove the device.

> > The following scenario: 
> > - system is using the HAL daemon, configured to monitor kernel uvents
> > - someone (usually some kind of volume manager in response to
> >   a device hotplug, but could also a manual mount) mounts a filesystem
> > - "mount" uevent is emitted
> 
> ... said event happens to be a piece of junk with ill-defined semantics.

Hmm, and what should be the proper semantics for such an event?

Currently the "mount" uevent signals that the device is busy (and the
"umount" uevent then should signal that the device is no longer in use,
but that is currently broken).

> > - HAL daemon reads the event, then opens and reads /proc/mounts
> 
> real useful, since
> 	a) we have no idea if mount() is being done in the same namespace
> 	b) we have no idea if mount() actually succeeds
> 	c) even if we manage to find a mountpoint, we have no idea if it
> gets e.g. mount --move just as we'd finished reading from /prov/mounts
> 	d) if the goal is to see which devices are held by mounted fs,
> you'll miss such things as e.g. external journals.
> 
> >   (in order to determine the corresponding mount point, since the uevent
> 
> *the* corresponding mountpoint?  Which one?  There might be any number
> of those...

--Signature=_Tue__25_Oct_2005_20_31_55_+0400_64ouSWQweEh0822b
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFDXl3+W82GfkQfsqIRAjGSAJ95g7dvHPE22/YZq3ms4OvUSrXAIgCfTHQd
sx3hSnjUrh0kiowjC0V/cho=
=Nm0W
-----END PGP SIGNATURE-----

--Signature=_Tue__25_Oct_2005_20_31_55_+0400_64ouSWQweEh0822b--
