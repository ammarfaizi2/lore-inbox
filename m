Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750784AbWHGP7W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750784AbWHGP7W (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 11:59:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750777AbWHGP7W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 11:59:22 -0400
Received: from spock.bluecherry.net ([66.138.159.248]:33954 "EHLO
	spock.bluecherry.net") by vger.kernel.org with ESMTP
	id S1750786AbWHGP7V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 11:59:21 -0400
Date: Mon, 7 Aug 2006 11:59:17 -0400
From: "Zephaniah E. Hull" <warp@aehallh.com>
To: dtor_core@ameritech.net
Cc: linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Subject: [patch] Crash on evdev disconnect.
Message-ID: <20060807155916.GE5472@aehallh.com>
Mail-Followup-To: dtor_core@ameritech.net,
	linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zYM0uCDKw75PZbzx"
Content-Disposition: inline
X-Notice-1: Unsolicited Commercial Email (Aka SPAM) to ANY systems under
X-Notice-2: our control constitutes a $US500 Administrative Fee, payable
X-Notice-3: immediately.  By sending us mail, you hereby acknowledge that
X-Notice-4: policy and agree to the fee.
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--zYM0uCDKw75PZbzx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

While trying to figure out the best way to handle an odd mouse, I found
that we oopsed when doing a rmmod on usbhid while someone had a USB
device open through evdev.

We try to loop through evdev->list, calling kill_fasync on each member,
however by the time we try to get the next pointer, we have already
freed the member and poisoned the next/last.

The fix is fairly simple, and if nobody objects I think we should try
and get this into -stable too.

Signed-off-by: "Zephaniah E. Hull" <warp@aehallh.com>

diff -ur linux-test/drivers/input/evdev.c linux-2.6/drivers/input/evdev.c
--- linux-test/drivers/input/evdev.c	2006-07-24 23:36:01.000000000 -0400
+++ linux-2.6/drivers/input/evdev.c	2006-08-07 11:41:13.000000000 -0400
@@ -659,7 +659,7 @@
 static void evdev_disconnect(struct input_handle *handle)
 {
 	struct evdev *evdev = handle->private;
-	struct evdev_list *list;
+	struct evdev_list *list, *next;
 
 	sysfs_remove_link(&input_class.subsys.kset.kobj, evdev->name);
 	class_device_destroy(&input_class,
@@ -669,7 +669,7 @@
 	if (evdev->open) {
 		input_close_device(handle);
 		wake_up_interruptible(&evdev->wait);
-		list_for_each_entry(list, &evdev->list, node)
+		list_for_each_entry_safe(list, next, &evdev->list, node)
 			kill_fasync(&list->fasync, SIGIO, POLL_HUP);
 	} else
 		evdev_free(evdev);

-- 
	  1024D/E65A7801 Zephaniah E. Hull <warp@aehallh.com>
	   92ED 94E4 B1E6 3624 226D  5727 4453 008B E65A 7801
	    CCs of replies from mailing lists are requested.

"Sir," barked one of those useless aristocratic generals to William
Howard Russell, the great Times war correspondent, "I do not like what
you write." "Then, sir," retorted Russell, "I suggest you do not do what
I write about."

--zYM0uCDKw75PZbzx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFE12NURFMAi+ZaeAERAkq0AJ4leF/TJTdPmPGOiS7adHj4R0DpWACdEMlu
bSElj82jpol8YMaIvAOeZe0=
=6j/G
-----END PGP SIGNATURE-----

--zYM0uCDKw75PZbzx--
