Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265554AbUAGVEx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 16:04:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265557AbUAGVEx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 16:04:53 -0500
Received: from nwkea-mail-1.sun.com ([192.18.42.13]:46308 "EHLO
	nwkea-mail-1.sun.com") by vger.kernel.org with ESMTP
	id S265554AbUAGVEt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 16:04:49 -0500
Date: Wed, 07 Jan 2004 16:04:41 -0500
From: Mike Waychison <Michael.Waychison@Sun.COM>
Subject: Re: [autofs] [RFC] Towards a Modern Autofs
In-reply-to: <3FFC46EB.9050201@zytor.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Message-id: <3FFC7469.3050700@sun.com>
MIME-version: 1.0
Content-type: multipart/signed;
 boundary=------------enig88C5FC4D8197CCE09971C435;
 protocol="application/pgp-signature"; micalg=pgp-sha1
X-Accept-Language: en
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031107
 Debian/1.5-3
X-Enigmail-Version: 0.82.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
References: <1b5GC-29h-1@gated-at.bofh.it> <1b6CO-3v0-15@gated-at.bofh.it>
 <m3ad50tmlq.fsf@averell.firstfloor.org> <3FFC46EB.9050201@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig88C5FC4D8197CCE09971C435
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

H. Peter Anvin wrote:

>> Also when /home or other important fs are mounted via autofs there is
>> not much practical difference between a hung kernel and a hung
>> daemon. You have to reboot the system anyways.
> 
> 
> a) Guess which one is easier to debug?

When they may both equally hang your machine, neither.

> b) Do people around here really believe that putting things in the 
> kernel magically makes them work right?
> 

No magic involved.

When atomicity is needed wrt. mountpoints, moving the logic into the 
kernel is a much simpler solution.

How much code was required to handle the corner cases and races in the 
existing autofs implementations?

To put it into perspective, the I'm calling for the following major changes:

1) move expiry logic out of autofs and into the VFS where others can use 
it and notice when it breaks when VFS internals change.  For example, I 
just noticed that autofs4 in 2.6 hasn't been updated to grab the new 
vfsmount_lock instead of dcache_lock in certain circumstances.

2) move the loop that used to spin around and ask kernelspace if there 
was anything to expire into the VFS as well, where it won't be killed.

3) introduce some way to let userspace walk the mountpoints using file 
descriptors as references.

4) figure out a way to get super_blocks to clone so that we can have 
some consistent automount functionality across cloned namespaces.

(1) and (2) shouldn't be hard at all to do considering David Howells has 
done the majority of this already. (3) is needed in order to manage 
direct mounts properly for when they are 'covered'.  Admittedly, (4) 
comes off as an ugly hack.

Also, (2) was the only 'active' task the automount daemon was doing. 
Everything else it did can be rewritten in the form of a usermode helper 
that runs only when it is needed.  This simplifies the userspace code a lot.


-- 
Mike Waychison
Sun Microsystems, Inc.
1 (650) 352-5299 voice
1 (416) 202-8336 voice
mailto: Michael.Waychison@Sun.COM
http://www.sun.com

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
NOTICE:  The opinions expressed in this email are held by me,
and may not represent the views of Sun Microsystems, Inc.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

--------------enig88C5FC4D8197CCE09971C435
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Using GnuPG with Debian - http://enigmail.mozdev.org

iD8DBQE//HRtdQs4kOxk3/MRAuKUAKCdTS1FaYs9tgk2fOC99iQSp3wjWwCghCI6
0kxBJ9clEFTEucVc9bOLSfA=
=1bMG
-----END PGP SIGNATURE-----

--------------enig88C5FC4D8197CCE09971C435--

