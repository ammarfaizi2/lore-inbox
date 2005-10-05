Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030290AbVJERoP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030290AbVJERoP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 13:44:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030291AbVJERoP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 13:44:15 -0400
Received: from mail-in-07.arcor-online.net ([151.189.21.47]:30401 "EHLO
	mail-in-07.arcor-online.net") by vger.kernel.org with ESMTP
	id S1030290AbVJERoN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 13:44:13 -0400
From: Bodo Eggert <harvested.in.lkml@7eggert.dyndns.org>
Subject: Re: what's next for the linux kernel?
To: Nix <nix@esperi.org.uk>, Marc Perkel <marc@perkel.com>,
       Luke Kenneth Casson Leighton <lkcl@lkcl.net>,
       linux-kernel@vger.kernel.org
Reply-To: 7eggert@gmx.de
Date: Wed, 05 Oct 2005 19:43:45 +0200
References: <4TiWy-4HQ-3@gated-at.bofh.it> <4U0XH-3Gp-39@gated-at.bofh.it> <4Uis4-4pZ-5@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8Bit
Message-Id: <E1ENDIw-00012k-Fz@be1.lrz>
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: harvested.in.lkml@posting.7eggert.dyndns.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nix <nix@esperi.org.uk> wrote:
> On 4 Oct 2005, Marc Perkel announced authoritatively:

>>             Netware also has inherited permissions like Windows and
>> Samba has and this is doing it right.
> 
> s/right/wrong/
> 
> Look at a NetWare permission on some file and you can't tell what the
> effective permission is, because it depends on inherited ones as well.
> Look at an effective permission and you can't tell which parts of it
> will change if you change the inherited permission.

MS solved that part by not allowing partially defined permissions.
(At least AFAI can tell from the UI.)

> Unix has inherited permissions in one sense: you can't get at a file
> via some path if one of the directories in that path is unreadable.

NACK. ITYM non-accessable (-x), and it's only true if you can't reach it or
one of the other links from $PWD and the directories you can fchdir to
(which, admittedly, is the usural case).

> Even *that* causes regular problems,

ACK.-)

>>                                       File systems and individual
>> directories should be able to be flagged as casesensitive/insensitive.
> 
> Only if you're willing to change POSIX to include a call to check filenames
> for identity,

You'd "just" need a way to determine the canonialized form. Still an evil
masterplan.

[...]
> It would also require case-conversion and locale-handling code, probably
> including UTF-8 canoncalization code, inside the kernel. This would
> greatly increase kernel complexity for a very small reward, and lead to
> Al Viro's early death from cerebral aneurysm combined with involuntary
> projectile vomiting. This cannot be considered a good thing.

a) NLS is in the kernel, and if utf-8 filenames are supposed to be used,
   an utf-8 checker rejecting non-canonialized strings will be desirable
   to avoid binary trash in filenames or lookalike filenames. The
   conversion to the canonialized form should happen outside the kernel.

   (I know POSIX doesn't define a propper return value, but the return
    value used for VFAT works and it's better than dealing with
    $'M\x{0430}kefile' looking like Makefile)

b) ACK, I don't think caseless handling of filenames is a good thing,
   it would needlessly bloat the kernel by opening a can of worms.
   E.g. 'ß' would be converted to 'SS'[0] in German or 'B' in greek.


[0] or, if you like and bend the standard, to 'SZ' if the word with 'SS'
    would clash with another word.

> Now /etc/mtab, *that* is an abomination, and a small kernel improvement
> (allowing arbitrary flag strings to be passed by mount into the kernel
> solely for display in the appropriate /proc/mounts field) could
> eliminate it and replace it entirely with /proc/mounts.

What about making all fs ignore the
-omount="$tool:foo:bar;$tool2=baz:barf..." parameter?

This is a cruel hack, but it will be backward compatible.
(If your hammer is big enough, the problem may turn out to be a nail.)

-- 
Ich danke GMX dafür, die Verwendung meiner Adressen mittels per SPF
verbreiteten Lügen zu sabotieren.
