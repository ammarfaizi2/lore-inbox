Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932641AbVJET1N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932641AbVJET1N (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 15:27:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932639AbVJET1N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 15:27:13 -0400
Received: from 41-052.adsl.zetnet.co.uk ([194.247.41.52]:34826 "EHLO
	mail.esperi.org.uk") by vger.kernel.org with ESMTP id S932641AbVJET1L
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 15:27:11 -0400
To: 7eggert@gmx.de
Cc: Marc Perkel <marc@perkel.com>,
       Luke Kenneth Casson Leighton <lkcl@lkcl.net>,
       linux-kernel@vger.kernel.org
Subject: Re: what's next for the linux kernel?
References: <4TiWy-4HQ-3@gated-at.bofh.it> <4U0XH-3Gp-39@gated-at.bofh.it>
	<4Uis4-4pZ-5@gated-at.bofh.it> <E1ENDIw-00012k-Fz@be1.lrz>
From: Nix <nix@esperi.org.uk>
X-Emacs: don't cry -- it won't help.
Date: Wed, 05 Oct 2005 20:27:01 +0100
In-Reply-To: <E1ENDIw-00012k-Fz@be1.lrz> (Bodo Eggert's message of "Wed, 05
 Oct 2005 19:43:45 +0200")
Message-ID: <87vf0bg3y2.fsf@amaterasu.srvr.nix>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 05 Oct 2005, Bodo Eggert suggested tentatively:
> Nix <nix@esperi.org.uk> wrote:
>> On 4 Oct 2005, Marc Perkel announced authoritatively:
> 
>> Look at a NetWare permission on some file and you can't tell what the
>> effective permission is, because it depends on inherited ones as well.
>> Look at an effective permission and you can't tell which parts of it
>> will change if you change the inherited permission.
> 
> MS solved that part by not allowing partially defined permissions.
> (At least AFAI can tell from the UI.)

The UI lies grossly, but in this area I think you are right. (I'm still
unclear as to what happens to permissions when you copy something:
do the inherited parts change, or not?)

>> Unix has inherited permissions in one sense: you can't get at a file
>> via some path if one of the directories in that path is unreadable.
> 
> NACK. ITYM non-accessable (-x), and it's only true if you can't reach it or
> one of the other links from $PWD and the directories you can fchdir to
> (which, admittedly, is the usural case).

Yeah, I was being sloppy. You got what I meant. (In similar wise, file
permissions don't stop you from reading a file if you can coerce someone
else into opening it and passing you its fd. Nonetheless, file
permissions almost always *do* work.)

>>>                                       File systems and individual
>>> directories should be able to be flagged as casesensitive/insensitive.
>> 
>> Only if you're willing to change POSIX to include a call to check filenames
>> for identity,
> 
> You'd "just" need a way to determine the canonialized form. Still an evil
> masterplan.

It'd still require changing POSIX and rewriting a large part of the
universe.

> [...]
>> It would also require case-conversion and locale-handling code, probably
>> including UTF-8 canoncalization code, inside the kernel. This would
>> greatly increase kernel complexity for a very small reward, and lead to
>> Al Viro's early death from cerebral aneurysm combined with involuntary
>> projectile vomiting. This cannot be considered a good thing.
> 
> a) NLS is in the kernel,

I don't think enough of it to do this is in there, at least not if you
aren't using something like NTFS.

>                          and if utf-8 filenames are supposed to be used,
>    an utf-8 checker rejecting non-canonialized strings will be desirable
>    to avoid binary trash in filenames or lookalike filenames. The
>    conversion to the canonialized form should happen outside the kernel.

Yes. But where? libc? (I can just see Ulrich going for *this*!)

> b) ACK, I don't think caseless handling of filenames is a good thing,
>    it would needlessly bloat the kernel by opening a can of worms.
>    E.g. 'ß' would be converted to 'SS'[0] in German or 'B' in greek.

... which means that either you lose per-process locale-dependence
via LANG et all, or you get the possibility of directories containing
several files with the same name from some users' POV.

Neither seems good to me; even though we already have part of this with
NTFS, we should not inflict it on people needlessly.

>> Now /etc/mtab, *that* is an abomination, and a small kernel improvement
>> (allowing arbitrary flag strings to be passed by mount into the kernel
>> solely for display in the appropriate /proc/mounts field) could
>> eliminate it and replace it entirely with /proc/mounts.
> 
> What about making all fs ignore the
> -omount="$tool:foo:bar;$tool2=baz:barf..." parameter?

Well, they'd have to dump it into /proc/mounts, too (I guess that would
happen magically). That would unbreak the few things this cares about.

> This is a cruel hack, but it will be backward compatible.
> (If your hammer is big enough, the problem may turn out to be a nail.)

Indeed. I'm fairly sure this problem is trivially solvable: it's far
easier than the *other* problems lying in wait down the per-user-
namespace path. :)

-- 
`Next: FEMA neglects to take into account the possibility of
fire in Old Balsawood Town (currently in its fifth year of drought
and home of the General Grant Home for Compulsive Arsonists).'
            --- James Nicoll
