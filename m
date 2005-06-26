Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261510AbVFZDyZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261510AbVFZDyZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Jun 2005 23:54:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261512AbVFZDyY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Jun 2005 23:54:24 -0400
Received: from mxout01.versatel.de ([212.7.152.115]:8130 "EHLO
	mxout01.versatel.de") by vger.kernel.org with ESMTP id S261510AbVFZDyR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Jun 2005 23:54:17 -0400
Message-ID: <42BE26D1.1000402@web.de>
Date: Sun, 26 Jun 2005 05:53:53 +0200
From: Christian Trefzer <ctrefzer@web.de>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050617)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: "Darryl L. Miles" <darryl@netbauds.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.12 initrd module loading seems parallel on bootup
References: <42BDFEC2.3030004@netbauds.net>
In-Reply-To: <42BDFEC2.3030004@netbauds.net>
X-Enigmail-Version: 0.92.0.0
OpenPGP: id=6B99E3A5
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig6C524A1C82649320AF4CD4E7"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig6C524A1C82649320AF4CD4E7
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Well, although I cannot comment on your exact situation, I guess I see 
the same problem here. When checking out 2.6.12 for the first time, my 
little early-userspace environment had some serious trouble configuring 
the scsi|md|lvm setup which worked flawlessly before. The plan was to 
load required modules for disks, then md, bring up the arrays and 
activate the LVs. But it takes several seconds (!) until device nodes 
appear after modprobe has terminated correctly. For me, the quick ugly 
fix was to introduce a delay loop in the bash scripts which waits for 
important device nodes before proceeding, similar to that:

function wait_for_node{} (
	echo -en "Waiting for ${1} to appear..."
	while [ ! -e ${1} ]
	do
		echo -en "."
		sleep 1s
	done
	echo " done."
)

This one can be called with any node important for the next 
initialization step. In my case, I wait for disk partitions to appear 
before RAID initialization:
	wait_for_node /dev/sda1
You could wait for your root partition to come up, instead of running 
into the vfs panic while trying to mount it. But that won't solve the 
original problem, I fear...

Yours,
Chris

--------------enig6C524A1C82649320AF4CD4E7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iQIVAwUBQr4m112m8MprmeOlAQKTpBAAuURn77dzheCIqDH9ZZzjj90GYuD48GXd
2r/RgJMZOJoLO9guvQUuGnseNmmO6SkB+b2gYZJb2B9d6SWHeMVLR3IGtuJeAE1a
FU2+pyx5njpV7XJtAc4gNYIxURE4VSl1LvoNiZNxTciJ7x3Ar6HHXdwNRfpu2uQA
Kqd0xOLhKtEhaL5fXPT6cRVoFNIABvLsQk81mYnORIh7ahDSVVj6dFdWHT2XgUP6
4UNZrOC5P/Ue4KaFOaJO0TbU3iOoeMRHmtpbwfvnmRwu7Jqd/lS30zB/AutnnQ4w
y8ZFFSnDXxBpAFaaXwscHRJKhAGftaaVfRLAaD9ksJsxt+ETAHT8CP3/mXpgvEwi
SbItPs28/j4vEFYM5yprkCpm+C6uQ21eqBcM8QaJ4iVA1Dk5rFPeCjaFmME0f9x6
m3GAiQ9g/KhRlFFu2aHZHVUAi5jaH203jNy+8N1FhyjdTcS2xDjmCe/oWP6BPSEa
yG7xpbiFA+qJDYRgy8mbwruXhwnH1KFiH8KTla8jAG3RitttGsSR5h2Q/Y/8zV9R
FWXjskC2rWPsDkswfDjndJvBPn37AQuArs3iwVQgcR4SMcc9CJqIiU72DmoM8ZAR
boub/o8H+Kqh9q+7TmUpml4N539V5qy3oiGPn8ZporMzCeTehL230R80x48rCggt
C8I6T2DHIuU=
=hx2N
-----END PGP SIGNATURE-----

--------------enig6C524A1C82649320AF4CD4E7--
