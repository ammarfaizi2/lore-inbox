Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261819AbVF0FEz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261819AbVF0FEz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 01:04:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261822AbVF0FEz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 01:04:55 -0400
Received: from h80ad25a1.async.vt.edu ([128.173.37.161]:51131 "EHLO
	h80ad25a1.async.vt.edu") by vger.kernel.org with ESMTP
	id S261819AbVF0FEt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 01:04:49 -0400
Message-Id: <200506270459.j5R4xdZp005659@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Hubert Chan <hubert@uhoreg.ca>
Cc: Lincoln Dale <ltd@cisco.com>, Gregory Maxwell <gmaxwell@gmail.com>,
       Hans Reiser <reiser@namesys.com>,
       Horst von Brand <vonbrand@inf.utfsm.cl>,
       Jeff Garzik <jgarzik@pobox.com>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: reiser4 plugins 
In-Reply-To: Your message of "Sun, 26 Jun 2005 23:10:43 EDT."
             <87y88webpo.fsf@evinrude.uhoreg.ca> 
From: Valdis.Kletnieks@vt.edu
References: <200506240241.j5O2f1eb005609@laptop11.inf.utfsm.cl> <42BCD93B.7030608@slaphack.com> <200506251420.j5PEKce4006891@turing-police.cc.vt.edu> <42BDA377.6070303@slaphack.com> <200506252031.j5PKVb4Y004482@turing-police.cc.vt.edu> <42BDC422.6020401@namesys.com> <42BE3645.4070806@cisco.com> <e692861c05062522071fe380a5@mail.gmail.com> <42BE563D.4000402@cisco.com> <42BE5DB6.8040103@slaphack.com> <200506261816.j5QIGMdI010142@turing-police.cc.vt.edu> <42BF08CF.2020703@slaphack.com> <200506262105.j5QL5kdR018609@turing-police.cc.vt.edu> <42BF2DC4.8030901@slaphack.com> <200506270040.j5R0eUNA030632@turing-police.cc.vt.edu>
            <87y88webpo.fsf@evinrude.uhoreg.ca>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1119848378_3633P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 27 Jun 2005 00:59:39 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1119848378_3633P
Content-Type: text/plain; charset=us-ascii

On Sun, 26 Jun 2005 23:10:43 EDT, Hubert Chan said:
> On Sun, 26 Jun 2005 20:40:29 -0400, Valdis.Kletnieks@vt.edu said:

> > Oh, I'm waiting for the fun the first time somebody deploys a plugin
> > that has similar semantics to 'chmod g+s dirname/' ;)

(You *did* notice it was set-GID of a *directory* not an executable file,
right?)

> Reiser4 plugins have to be compiled into the kernel.  (They're not
> plugins in the sense that most people use that word.)  And any admin who
> would compile that kind of plugin into the kernel needs to have his head

Oh?  You saying that it *wont* be permitted for a user to say:

mkdir $HOME/zipped
chattr "files under here are ZIP files" $HOME/zipped

and instead you have to do that chattr by hand for *every* *single* zip file?

Or "files on this filesystem are encrypted by default"?

I suspect that this sort of thing is going to be one of the *first* things
that will get created, and any admin who tries to sell this idea to the users
*without* that sort of functionality will be handed their head.

Or, if "that type of plugin.. needs to have their head examimed", I suggest
that you go to your kernel source tree, find fs/ext3/ialloc.c, and this code
in ext3_new_inode():

        if (test_opt (sb, GRPID))
                inode->i_gid = dir->i_gid;
        else if (dir->i_mode & S_ISGID) {
                inode->i_gid = dir->i_gid;
                if (S_ISDIR(mode))
                        mode |= S_ISGID;
        } else
                inode->i_gid = current->fsgid;

and #ifdef out all but the last line, and see if anything breaks. ;)

> examined.  Not to mention that plugins must first go through Hans and/or
> Linus before they can get included into the kernel.
> 
> The kernel defines the set of plugins available to the user.  The user
> selects (to a certain degree) which plugins to use.

The point you missed was that plugins *will* have interactions, and as
the guys who are working on a stacker for LSM modules have found out the
hard way, trying to deal with the composition of functions is fiendishly
difficult.

And notice that it doesn't *have* to be quite so obvious - how about if a
user creates a directory $HOME/zipped/ and flags it as "anything under here
is a zipped file".

Now throw in multiple users and CPU limits.  User A enters that directory and
references everything, causing the buffer cache to get filled up.  While there,
A makes changes, so the pages are dirty - "for i in */*; do echo " " >> $i; done"
would do the job...  User B now does something that causes a writeback of one
of those buffer cache pages.

A) What process currently gets ticked for the CPU and I/O for the writeback?

B) In your model, who will get ticked for the resources?

C) Will the users riot? (Note that you can't win here - currently, the "price"
of writing back A's and B's pages are about equal.  However, if A gets dinked
for an expensive writeback due to B's process, A will get miffed.  If B gets
charge for an expensive writeback of A's, B will get miffed. If you say "screw it"
and bill it to a kernel thread, the bean counters will get miffed... ;)

--==_Exmh_1119848378_3633P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFCv4e6cC3lWbTT17ARAhPrAKDln3ZSJTXlQXujy7Xs1qg7bfApgQCgsGy4
N9VaXwtC/xJ6ii6IAGZ26YY=
=zvMF
-----END PGP SIGNATURE-----

--==_Exmh_1119848378_3633P--
