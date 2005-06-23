Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262816AbVFWWcU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262816AbVFWWcU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 18:32:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262769AbVFWWcT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 18:32:19 -0400
Received: from [80.71.243.242] ([80.71.243.242]:12218 "EHLO tau.rusteko.ru")
	by vger.kernel.org with ESMTP id S262816AbVFWWbu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 18:31:50 -0400
From: Nikita Danilov <nikita@clusterfs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17083.14428.546772.353003@gargle.gargle.HOWL>
Date: Fri, 24 Jun 2005 02:31:56 +0400
To: David Masover <ninja@slaphack.com>
Cc: "Artem B. Bityuckiy" <dedekind@yandex.ru>,
       =?UTF-8?B?TWFya3VzIFTQlnJu?= =?UTF-8?B?cXZpc3Q=?= <mjt@nysv.org>,
       Christophe Saout <christophe@saout.de>, Andrew Morton <akpm@osdl.org>,
       Hans Reiser <reiser@namesys.com>, hch@infradead.org, jgarzik@pobox.com,
       linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
Subject: Re: reiser4 plugins
In-Reply-To: <42BAC668.2030604@slaphack.com>
References: <200506221733.j5MHXEoH007541@laptop11.inf.utfsm.cl>
	<42B9DD48.6060601@slaphack.com>
	<17081.58619.671650.812286@gargle.gargle.HOWL>
	<42BAC668.2030604@slaphack.com>
X-Mailer: VM 7.17 under 21.5 (patch 17) "chayote" (+CVS-20040321) XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Masover writes:
 > -----BEGIN PGP SIGNED MESSAGE-----
 > Hash: SHA1
 > 
 > Nikita Danilov wrote:
 > > David Masover writes:
 > > 
 > > [...]
 > > 
 > >  > 
 > >  > What we want is to have programs that can write small changes to one
 > >  > file or to many files, lump all those changes into a transaction, and
 > >  > have the transaction either succeed or fail.
 > > 
 > > No existing file system guarantees such behavior. Even atomicity of
 > > single system call is not guaranteed.
 > 
 > No _existing_ filesystem.  But I seem to recall that this was one of the
 > design decisions of Reiser4, and that the system call itself was pushed
 > off to 4.1?

First off, my comment was in response to the message

http://marc.theaimsgroup.com/?l=linux-kernel&m=111945793205480&w=2

claiming that reiser4 was "atomic". As it stands, currently reiser4
cannot guarantee that single write(2) call is atomic. Think of system
with X bytes of physical memory and 9*X bytes of swap. User does

        buf = malloc(10 * X);
		memset(buf, 42, 10 * X);
        write(reiser4_fd, buf, 10 * X);

As far as I know, current reiser4 code cannot guarantee that such write
is always handled as a single transaction. It is _possible_ to implement
such a guarantee, I believe, but this requires a lot of work.

 > 
 > Maybe I'm just wrong about how big a transaction can be.  Maybe it was
 > limited to a single file.  I don't think so, though.  From the
 > whitepaper:  "Stuffing a transaction into a single file just because you
 > need the transaction to be atomic is hardly what one would call flexible
 > semantics."

I don't quite understand what do you mean. Whitepaper describes how
things work according to some grand visionary scheme. It doesn't go to
the level of technical details, it doesn't discuss possible
obstacles. There is a huge gap between saying "it's nice to have
user-visible transactions" and having ones. So huge, in my opinion, that
compared with it, difference in reiser4 and, say, ext3 as possible
starting points is immaterial.

 > 
 > I also seem to recall that the rolling back of the transaction, should
 > it fail, was supposed to be handled by the application.  This doesn't
 > quite click with the whitepaper, but it could work.

What if user level application err... crashed (does this happen?) or
stuck in the infinite loop (hmm... user level programmers never do this,
I hope)?

[...]

 > > 
 > > Because to have such transactions databases pay huge price in both
 > > resource consumption and available concurrency (isolation, commit-time
 > > locks, etc.), and yet mechanism they use to deal with stuck transactions
 > > (which is simply to abort it) is not very suitable for the file system.
 > 
 > Oh, really?  If we've got application support through sys_reiser4?  The
 > application should be ready to deal with a transaction abort.

Transactional systems have to deal with so-called external
actions. E.g., in the ATM external action is to hand cash out to the
person doing withdraw. After external action was done as part of
transaction, that transaction can no longer be aborted (because one
cannot reverse external action). Typical example of file system
transactions is mail server doing something roughly following:

        (0) begin work;
        (1) take message from the queue;
        (2) send message to the recipient;
        (3) wait for confirmation;
        (4) remove message;
        (5) commit work;

Here (2), and (3) are external actions, they cannot be aborted or
reversed. This means that should transaction abort at the step (4)
system would be left in the inconsistent state.

 > 
 > I'm still not convinced of any of that paragraph.  I don't know enough
 > to argue the point, but it intuitively feels wrong.  After all, if the
 > metadata is atomic, and we are allowed to make our own system calls, why
 > can't we make the data atomic?

Because meta-data are under tight kernel control. There is a difference
between implementing transaction engine for use by a small body of
trusted code (kernel) and a general purpose transaction manager.

Nikita.

 > 
 > -----BEGIN PGP SIGNATURE-----
 > Version: GnuPG v1.4.1 (GNU/Linux)
 > Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org
 > 
 > iQIVAwUBQrrGOngHNmZLgCUhAQJZhw//dmJ6S2GlGT6J5YI9DTCyoTDIPUYNb8o0
 > M1me6KDTElzzQ3yUak/eUd0sbGBAQcf0vn/iVscfq2DoAwnUWxHjht+PaOA98axR
 > 0pnofqE291QLTQJ36epW0kKqFjavVVsrpD80llcaCFz9Rq48W40DoI5CWuX1RQqK
 > pCnr9vYe8cAsRY+PzV9/KUaSQ+eZJ9daLsAmMwA3Gcxo4XYqILlZm90X3QQTdc8W
 > gnKSabG3zIjEozfgG/nvtV/09mktHINGq3ud8W1XubBOXs4z+ECsLyvi7QNW83Bq
 > b/wTDUX3PkrjDHnfcmFkFZJqRrCBD9Ko36f9NThxuaba5eV7kb6h+qx+kS5ZM6Lm
 > bh90TjJrIpJ4aQr2qrPRAE85GSnvSlyi3E01gk/+UnkBFMoTqTvw2dPb0GhvMINM
 > EhSUhEyeaopWXIdv3IszOOpbHJLwczixLDBtZ8OFDS26bnJGj7YlnTjdf+TZ9CGf
 > ZXn7GaG16CiSTOt0YkKk2UGZz+AOubPAUHc6v8Wg587qXWKD3cXVQeZVqYwJG/8B
 > G5qq51LB6jypjAoP4uSeuTs4DfANGi2H2mHjZVAyaGcwzhxf3ffGRFkfjElAj8RA
 > RdmB6bq10nt32mL7YP8+n7xa38iCP+ks9wsoOY2KBBDlOpHu07xb/c2DS9yfTCpj
 > FvMShQw6EBI=
 > =S7ds
 > -----END PGP SIGNATURE-----
