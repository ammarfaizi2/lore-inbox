Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264968AbUELEZS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264968AbUELEZS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 00:25:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265016AbUELEZS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 00:25:18 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:10904 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S264968AbUELEZK (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 00:25:10 -0400
Message-Id: <200405120425.i4C4P2eh019792@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: John McGowan <jmcgowan@inch.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net
Subject: Re: [Ext2-devel] Re: Kernel 2.6.6: Removing the last large file does not reset filesystem properties 
In-Reply-To: Your message of "Tue, 11 May 2004 23:09:15 EDT."
             <20040512030915.GA4245@thunk.org> 
From: Valdis.Kletnieks@vt.edu
References: <20040511002008.GA2672@localhost.localdomain> <20040511004956.70f7e17d.akpm@osdl.org> <20040511084510.J33555@shell.inch.com> <200405111532.i4BFWQIs029188@turing-police.cc.vt.edu>
            <20040512030915.GA4245@thunk.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_727863800P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Wed, 12 May 2004 00:25:02 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_727863800P
Content-Type: text/plain; charset=us-ascii

On Tue, 11 May 2004 23:09:15 EDT, "Theodore Ts'o" said:

> Well, actially, the initscripts should reboot if the ((status & 2) != 0).
> Or more simply, if the exit status is 2 or 3.
... 
>             4    - File system errors left uncorrected
> 
> Which should cause the initscripts to call for help.  An exit code of
> 2 or 3 merely means that the fsck is doing just fine, thank you very
> much, and just needs a reboot in order to flush the disk caches.

Man, a quarter of a century in this business, and I *still* haven't learned
that you can't trust your vendor to have a clue. That will teach me to go back
and check the upstream copy of the manpages, rather than trusting to memory and
a look at the rc.sysinit script. ;) It's been too long a week already...

It certainly looks like somebody needs to file a bug report against RedHat/
Fedora's initscripts, as it seems even more confused about the proper behavior
than I am ;) rc.sysinit interprets rc=0 as OK, rc=1 as "passed, keep on going"
(ignoring the remount issue, it just remounts r/w and goes on), and anything
greater than 1 as "yell for help".  Oh, and to add to the pain - I just noticed
that it fsck's *all* the file systems, drops you into a shell if *any* of them
return a  $? higher than 1, and when you exit that shell, it does:

umount -a
mount -n -o remount,ro /
reboot -f

(Yes, if a /userdata filesystem gets an rc2 and hasn't been mounted yet, we reboot anyhow.)

I've convinced myself that a crack pipe was involved in this code....

> P.S.  The real right answer is that the fsck of the root partition
> should take place *before* the root partition is mounted, in the
> initial ramdisk.  This gets rid of the whole need to flush the system
> caches, since the (real) root filesystem isn't mounted at all during
> the time of the initial check.

Right.  Fortunately, RedHat appears to have put down the crack pipe long enough
to ship statically linked fsck.ext[23] and /sbin/lvm, so there's hope of having
enough of the pieces to do that....

Unfortunately, they then pick the pipe up again with mkinitrd - that uses the
'nash' shell wannabe, which does know how to invoke an external command, but
lacks an 'if' statement to test the return code (and yes, this time I checked
the actual nash.c from the src.rpm) - the various builtins and external commands
will set a return code, but you can't reference it except for the last
command's value could conceivably be checked back in init/do_mounts_initrd.c -
but that seems to discard the exit value of linuxrc....

Argh... :)

--==_Exmh_727863800P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFAoacecC3lWbTT17ARAuvGAKCBGT5uN/vIwr7wga8eJn2PrfymNwCg8Zmu
ylylFNgdxRcXXJk9bkX3EAQ=
=BQ0c
-----END PGP SIGNATURE-----

--==_Exmh_727863800P--
