Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269109AbUI2XNx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269109AbUI2XNx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 19:13:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269117AbUI2XNx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 19:13:53 -0400
Received: from moraine.clusterfs.com ([66.246.132.190]:3784 "EHLO
	moraine.clusterfs.com") by vger.kernel.org with ESMTP
	id S269109AbUI2XNu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 19:13:50 -0400
Date: Wed, 29 Sep 2004 17:13:27 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: Steven Pratt <slpratt@austin.ibm.com>
Cc: linuxram@us.ibm.com, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH/RFC] Simplified Readahead
Message-ID: <20040929231327.GM2061@schnapps.adilger.int>
Mail-Followup-To: Steven Pratt <slpratt@austin.ibm.com>,
	linuxram@us.ibm.com, akpm@osdl.org, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0409291113580.4449-600000@localhost.localdomain> <415B3845.3010005@austin.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KIbT1ud6duwZIwNL"
Content-Disposition: inline
In-Reply-To: <415B3845.3010005@austin.ibm.com>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--KIbT1ud6duwZIwNL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On a readahead-related note, I'm wondering how hard it would be to have
some tunables and/or hooks from the readahead state manchine made
available to the filesystem?  With the 2.4 readahead code it was basically
impossible for the filesystem to disable the readahead, I haven't looked
at the 2.6 readahead enough to determine whether we need that or not.

The real issue (reason for turning off RA in 2.4) is that within Lustre
there can be many DLM extent locks for a single file, so client A can
be writing to one part of the file, and client B can be reading from
another part of the same file.  With the stock readahead it wouldn't
stay within the lock extent boundaries, and we couldn't turn it off
easily.  Having some sort of FS method that says "don't do RA beyond
this offset" would be useful here.

The other problem that Lustre had was that the stock readahead would
send out page reads in small chunks as the window grew instead of
sending out large requests that could be turned into large, efficient
network RPCs.  So the desire would be to have some sort of tunable in
the readahead state (per fs or per file) that says "don't submit
another readahead until the window is growing by X pages".

As it is we've basically had to implement our own readahead code within
the filesystem in order to get correct behaviour and good performance.
This is of course not optimal from a code duplication point of view and
also we don't get any benefits from the algorithm improvements being
done here.


The other question is whether the new readahead code takes the latency
of completing read requests into account when determining the size of
the readahead window?  Lustre generally runs with very fast disk and
network systems so the size of the readahead window has to be very large
in order to keep the pipeline full to avoid stalling on the client.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://members.shaw.ca/adilger/             http://members.shaw.ca/golinux/


--KIbT1ud6duwZIwNL
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFBW0GWpIg59Q01vtYRAlqyAKC9R5VNJT9KXCAkShwe4COtZWnsSQCfQ641
uemyYi7Q88DjpfnodqVv85A=
=fCsc
-----END PGP SIGNATURE-----

--KIbT1ud6duwZIwNL--
