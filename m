Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262510AbVDYDbN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262510AbVDYDbN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Apr 2005 23:31:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262508AbVDYDbM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Apr 2005 23:31:12 -0400
Received: from aibo.runbox.com ([193.71.199.94]:33202 "EHLO cujo.runbox.com")
	by vger.kernel.org with ESMTP id S262507AbVDYDay (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Apr 2005 23:30:54 -0400
Message-ID: <426C64E4.4090600@dwheeler.com>
Date: Sun, 24 Apr 2005 23:32:52 -0400
From: "David A. Wheeler" <dwheeler@dwheeler.com>
Reply-To: dwheeler@dwheeler.com
User-Agent: Mozilla Thunderbird 1.0.2-1.3.2 (X11/20050324)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Fabian Franz <FabianFranz@gmx.de>, Paul Jakma <paul@clubi.ie>,
       Sean <seanlkml@sympatico.ca>,
       Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
       David Woodhouse <dwmw2@infradead.org>, Jan Dittmer <jdittmer@ppp0.net>,
       Greg KH <greg@kroah.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Git Mailing List <git@vger.kernel.org>
Subject: Re: Git-commits mailing list feed.
References: <200504210422.j3L4Mo8L021495@hera.kernel.org> <426C4168.6030008@dwheeler.com> <Pine.LNX.4.58.0504241846290.18901@ppc970.osdl.org> <200504250417.17231.FabianFranz@gmx.de> <Pine.LNX.4.58.0504241938410.18901@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504241938410.18901@ppc970.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Apr 2005, Fabian Franz wrote:
 >> What about just <sha1 hash of object>.sig or <sha1 hash of object>.asc?

If you mean "hash of object being signed", the problem is that
there may be more than one signature of a given object.
Keys get stolen, for example, so you want to re-sign the objects.
Yes, you could replace the files, but it's nicer to make it
so there's never a need to replace files in the first place.
That's one of the nice properties of the git object database;
so if we can have that property everywhere, I think we should.

Instead, store the signatures in the normal object database, &
give it type "signature".  To speed access FROM a commit or tag
to a signature (and FROM a commit to a tag), create a
separate reverse directory that tells you what objects reference
a given object.  Like this:
.git/
   objects/
     00/
       0195297c2a6336c2007548f909769e0862b509  <= a commit object
     02/
       0395297c2a6336c2007548f909769e0862b509  <= signature of commit
     04/
       0595297c2a6336c2007548f909769e0862b509  <= a tag
     06/
       0795297c2a6336c2007548f909769e0862b509  <= signature of tag
   reverse/
     00/
       0195297c2a6336c2007548f909769e0862b509/
         020395297c2a6336c2007548f909769e0862b509  "this signs commit"
         .... other later signatures of this commit go here.
     04/
       0595297c2a6336c2007548f909769e0862b509/
         060795297c2a6336c2007548f909769e0862b509
         .... other later signatures of this tag go here.

The reverse directory's contents are basically the filenames.
The files themselves could be symlinks back up, or not.
Content-free files are probably more portable across filesystems,
and it's probably also good for space efficiency
(though I haven't examined that carefully).

"git"'s knowledge of signatures should be VERY limited, and
not dependent on PGP.  I think that'd be easy.
You could prepend some signature data into the "signature" file to
make it much easier to reconstruct the reverse directory and
to make it easy to check things WITHOUT knowledge of PGP or whatever.

Here's potential output:

$ cat-file commit 000195297c2a6336c2007548f909769e0862b509
tree 2aaf94eae20acc451553766f3c063bc46cfa75c6
parent dc459bf85b3ff97333e759d641c5d18f4dad470d
author Petr Baudis <pasky@ucw.cz> 1114303479 +0200
committer Petr Baudis <xpasky@machine.sinus.cz> 1114303479 +0200

    Added the whatsit flag.


$ cat-file signature 000195297c2a6336c2007548f909769e0862b509
signatureof commit 000195297c2a6336c2007548f909769e0862b509
signer Petr Baudis <pasky@ucw.cz>

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBCbFaRCxlT/+f+SU4RAgYSAKCWpPNlDKDkxuuA649zJop7WkQPnACdF1Fg
JgXatbJU8YJ7JHqvgyGepRU=
=Kttg
-----END PGP SIGNATURE-----


$

--- David A. Wheeler
