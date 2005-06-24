Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263191AbVFXHVx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263191AbVFXHVx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 03:21:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263190AbVFXHVx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 03:21:53 -0400
Received: from 69-18-3-179.lisco.net ([69.18.3.179]:17422 "EHLO
	ninja.slaphack.com") by vger.kernel.org with ESMTP id S263191AbVFXHVe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 03:21:34 -0400
Message-ID: <42BBB47C.9010002@slaphack.com>
Date: Fri, 24 Jun 2005 02:21:32 -0500
From: David Masover <ninja@slaphack.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050325)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Hans Reiser <reiser@namesys.com>
Cc: Nikita Danilov <nikita@clusterfs.com>,
       "Artem B. Bityuckiy" <dedekind@yandex.ru>,
       =?UTF-8?B?TWFya3VzIFTQlnJucXZpc3Q=?= <mjt@nysv.org>,
       Christophe Saout <christophe@saout.de>, Andrew Morton <akpm@osdl.org>,
       hch@infradead.org, jgarzik@pobox.com, linux-kernel@vger.kernel.org,
       reiserfs-list@namesys.com
Subject: Re: reiser4 plugins
References: <200506221733.j5MHXEoH007541@laptop11.inf.utfsm.cl>	<42B9DD48.6060601@slaphack.com>	<17081.58619.671650.812286@gargle.gargle.HOWL>	<42BAC668.2030604@slaphack.com> <17083.14428.546772.353003@gargle.gargle.HOWL> <42BBAA0F.2020404@namesys.com>
In-Reply-To: <42BBAA0F.2020404@namesys.com>
X-Enigmail-Version: 0.89.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hans Reiser wrote:
> Nikita, I respectfully disagree with what you say about the state of our
> atomicity code.   It is not so far away as you describe, and probably 6
> man weeks work could polish it off.  You don't see the value in what I
> define as useful, namely atomicity without isolation.  Since you don't
> see that, it is harder for you to see that something is close to working
> and just needs 6 weeks of someone who groks what I am asking for.

How about a poor-man's isolation -- any process other than that
responsible for the transaction sees a consistent state, never a
transaction-in-progress.  I'm sure there's a name for that.

So, until the transaction commits, all apps can still see the original
state, except the one actually writing the transaction.  After it's
done, all apps see the new consistent state.

Isolation can then be done easily in userspace, via voluntary locking.
If the isolation needs to be global, the user can take a performance hit
and do mandatory locking.  Either way, locking and unlocking could be
seen as part of the transaction.

Details follow, most of them pure speculation on my part...

I'm not sure how this ties into the bigger kind of transaction, as
you've decided to let userspace handle the rollback in the large,
multi-file transactions, but for a single file, it seems obvious (famous
last words).  You've got the wandering stuff, meaning that the new file
(or changes to a file) are written to a new space on disk, after which
you update the metadata (blocklist?) -- presumably atomically.

So, it already seems inherent in the system, but it should be defined.
For some transactions, it doesn't make sense to do this, especially huge
ones (where storing changes separately may well fill up the disk) which
make more sense to have an application handle the rollback.

Here's a bad example of such a situation:  We're doing a brand-new
install, and we start by unpacking a tarball from the installation
media.  After the tarball is unpacked, we start installing packages.
But, if the installation fails, maybe we want to roll back to the
initial tarball, change some installation parameters, and try again.  In
such a situation, it makes more sense to just unpack the tarball again
than to try to roll back each change individually.

This is a bad example because you shouldn't have to start over from the
beginning, and even if you did, exit codes should be enough for this
kind of installer.

Anyway, I'm not sure quite how this works when dealing with more than
one file, but we already have atomic metadata operations, and here we
have an example of a somewhat atomic file operation, so I'm sure the two
can be stringed together... somehow...  Conceptually, it seems you'd
just be building a COW subtree, and the actual "atomic" part consists of
simply changing the pointer from the original tree to the modified one.
 The cleanup of the original tree need not be atomic.

We do have COW support, don't we?  It was discussed, and we should.

Main point is, I've just described two kinds of transactions:  entirely
FS-managed and userland-rolled-back.  I think they are both useful.
Also, neither looks incredibly hard to implement.  I'm sure I'm wrong
about that, though.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iQIVAwUBQru0fHgHNmZLgCUhAQLX9hAAjSO4WkIaqyzeTYyz3l9PW5mWvvUKhxrv
eK3glrQvrEf2HHy8gBfdcqv5RV8BAHfYIh6V/4S9VqmMzpBcUfBfEGRCJg0vcTsj
oVSpzV0/ASdxitMjsHqIz3q3kNRhRuhZoD/ppsVVlH4zZtefioYecyD2asEzTz6w
vAMN08chHR/vQiSDMBPDwkJ5Ov1tyPqdpSA4vBuRreWhDpD32ChBd3epEVXjt090
P0HxddqGR6FXCo9m4z2nTgSFHhAPkrOJE5bNS72hpk94nTfLRMI1DDTKw7J4AO10
U2mdjaXD5AUyahwE3diMcsxrH+94orE5bmK4yvgLUquBZ+OeRFoH0u8FG7sD3coP
2YkJewbhSrCQD69hrrR3pluwds3aoe+awj3x2WOk+6NV9xajw0czPs1P3cEw2Dwt
Fl2+92M6545UUbysL51Dvk+DWp/PRniAL1nBoZ1q9nBlhYIiL7ccr48sXP2PxoZw
nSQ1BDASCZalS6AFlMhI6A6U/OxIMzEZQr/cq1J9/dwRdrST2VLqiQdaCmsfgmL5
EVxA1C0tFjOPWwAlzVHB7MisxDp491w6WrxzV3r8x9vCwJZ747+2RNF3z2ah0A56
bVV6ZTjOK/pAsC0p+cfZS3NOTtvmP8x9QXQFll9WZvVEgFMYaOYkPlL6qwtpdNNR
r0yOvDy1TLI=
=FeCh
-----END PGP SIGNATURE-----
