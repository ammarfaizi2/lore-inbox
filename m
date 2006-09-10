Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932177AbWIJOZp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932177AbWIJOZp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Sep 2006 10:25:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932133AbWIJOZp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Sep 2006 10:25:45 -0400
Received: from nef2.ens.fr ([129.199.96.40]:33802 "EHLO nef2.ens.fr")
	by vger.kernel.org with ESMTP id S932177AbWIJOZo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Sep 2006 10:25:44 -0400
Date: Sun, 10 Sep 2006 16:25:40 +0200
From: David Madore <david.madore@ens.fr>
To: Pavel Machek <pavel@ucw.cz>
Cc: Linux Kernel mailing-list <linux-kernel@vger.kernel.org>
Subject: capability inheritance (was: Re: patch to make Linux capabilities into something useful (v 0.3.1))
Message-ID: <20060910142540.GA19804@clipper.ens.fr>
References: <20060907003210.GA5503@clipper.ens.fr> <20060907010127.9028.qmail@web36603.mail.mud.yahoo.com> <20060907173449.GA24013@clipper.ens.fr> <20060907225429.GA30916@elf.ucw.cz> <20060908041034.GB24135@clipper.ens.fr> <20060908105238.GB920@elf.ucw.cz> <20060908225118.GB877@clipper.ens.fr> <20060909114037.GA4277@ucw.cz> <20060910104105.GB5865@clipper.ens.fr> <20060910130623.GB4206@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060910130623.GB4206@ucw.cz>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.5.10 (nef2.ens.fr [129.199.96.32]); Sun, 10 Sep 2006 16:25:40 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[I wrote:]
> > But I'll make this a securebit ("unsanitized sxid"), with the behavior
> > you advertise as default (0).

Done: I just posted version 0.4.4, where non-root suid/sgid exec() is
sanitized.

On Sun, Sep 10, 2006 at 01:06:24PM +0000, Pavel Machek wrote:
> I'm not sure if fundamental security semantics should be optional, but
> it is certainly better than before.

I think it's a gross hack to protect people who can't write correct
programs, so there *must* be a way to disable it.

> tytso actually shown a clever way: add per-filesystem 'default
> capability masks'. That should be fairly easy to merge, and
> automatically back-compatible.
> 
> (And it would get tou semantics you wanted in inheritance area,
> right?)

I'm not at all sure.  If it's just a matter of adding a mount option
("inhcaps", say) so that the default file inheritable set is full when
the option is turned on *or* when one of current->{r,e,s}uid==0 (else
defaults to regular caps), then that can easily be done: this will
give a reasonable inheritance with the mount option turned on and the
current behavior with the mount option turned off (but still the
possibility of activating inheritance for specific files).

*However*, Theodore Ts'o seemed to say that he wanted POSIX-draft-16
conformance, and I am unable to arrange this: I don't know how to come
up with a set of semantics that are compatible at once with the POSIX
rules and the traditional Unix semantics for root.  So if someone
knows how to do that, he should speak up at that point.

The POSIX-draft-16 rules, if I understand correctly, are something
like this:

  P'(per) <- (P(inh) & F(inh)) | (F(per) & bnd)
  P'(eff) <- (P(inh) & F(eff) & F(inh)) | (F(per) & F(eff) & bnd)
  P'(inh) <- P(inh)

The second rule means that a normal process with euid!=0 (so P(eff)
restricted to regular caps) but uid=0 (so P(per) full) executing a
non-suid/sgid executable will have all P'(eff)-caps raised after exec.
This is in contradiction with normal Unix behavior, with the principle
of least surprise and also with anything I consider as "sane".  As for
the third rule, it means that P(inh) is not raised by F(per), so if I
execute a suid-root program and *that* program executes a non-suid
program, the grandchild will not get full caps, again contradicting
the norma Unix behavior.  This is why I wrote my patch to change the
behavior to

  P'(per) <- (P(inh) & F(inh)) | (F(per) & bnd)
  P'(eff) <- (P(inh) & P(eff) & F(inh)) | (F(per) & F(eff) & bnd)
  P'(inh) <- P'(per)

(see <URL: http://www.madore.org/~david/linux/newcaps/#semantics >)
- which makes perfect sense but which contradicts the POSIX
(non-)spec, so Theodore Ts'o will be unhappy with my patch.

I can see no way of reconciling the POSIX rules with sane Unix
behavior.  Hence I can only give up if someone insists that the POSIX
draft should be adhered to.

(Just in case someone were tempted to get away with a handwaving such
as "just follow the POSIX rules except for suid root...", let that
someone please try to come up with a full description of the rules
which breaks nothing, and he will understand that it's not at all
easy.)

-- 
     David A. Madore
    (david.madore@ens.fr,
     http://www.madore.org/~david/ )
