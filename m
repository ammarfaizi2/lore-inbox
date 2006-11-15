Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030507AbWKOOpF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030507AbWKOOpF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 09:45:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030510AbWKOOpF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 09:45:05 -0500
Received: from extu-mxob-2.symantec.com ([216.10.194.135]:2207 "EHLO
	extu-mxob-2.symantec.com") by vger.kernel.org with ESMTP
	id S1030507AbWKOOpB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 09:45:01 -0500
X-AuditID: d80ac287-a28e6bb000005d67-65-455b27e2d6f5 
Date: Wed, 15 Nov 2006 14:45:08 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@blonde.wat.veritas.com
To: =?UTF-8?B?UMOhZHJhaWcgQnJhZHk=?= <P@draigBrady.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Lauri Lubi <lauri@lubi.se>
Subject: Re: negative anon_rss?
In-Reply-To: <455A5F97.1070509@draigBrady.com>
Message-ID: <Pine.LNX.4.64.0611151434100.11929@blonde.wat.veritas.com>
References: <455A5F97.1070509@draigBrady.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323584-578489045-1163601908=:11929"
X-OriginalArrivalTime: 15 Nov 2006 14:44:50.0036 (UTC) FILETIME=[9A665B40:01C708C4]
X-Brightmail-Tracker: AAAAAA==
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323584-578489045-1163601908=:11929
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 15 Nov 2006, P=C3=A1draig Brady wrote:
> Sorry for not sending this to linux-mm,
> but I can't subscribe at present? Anyway...
>=20
> I wrote the following script to try and accurately determine
> how much RAM a particular program uses:
> http://www.pixelbeat.org/scripts/ps_mem.py
>=20
> A user reported an issue on debian with kernel 2.6.8-2-386
> where many processes were being reported as using
> a negative amount of memory.
>=20
> I asked him to run the following:
>=20
>   (
>     echo total rss shared trs - drs -
>     for pid in `pidof apache2`; do
>         cat /proc/$pid/statm
>     done
>   ) | column -t
>=20
> the output of which was:
>=20
>   total  rss   shared  trs  -  drs   -
>   6580   2306  5273    95   0  6485  0
>   6580   2313  5273    95   0  6485  0
>   6119   1717  5269    95   0  6024  0
>   6630   2371  5273    95   0  6535  0
>   6735   2503  5273    95   0  6640  0
>   6773   2546  5273    95   0  6678  0
>   5845   1146  5198    95   0  5750  0
>=20
> Notice the large values for the shared column.
> Also notice that the shared column is larger than rss!?
> I had assumed that shared was a subset of rss from
> the following (pseudo) code from fs/proc/task_mmu.c::task_statm()
>=20
>   *total  =3D mm->total_em
>   *shared =3D get_mm_counter(mm, file_rss)
>   *rss    =3D *shared + get_mm_counter(mm, anon_rss)
>   *trs    =3D mm->end_code - mm->start_code
>   *drs    =3D mm->total_vm - mm->shared_vm
>=20
> Therefore anon_rss must be negative in the kernel?
> So there is a mismatch between pages being marked
> as anonymous and anon_rss being updated appropriately?

You're looking at recent source to explain what happened in 2.6.8:
not a good strategy.  2.6.8 didn't even record file_rss and anon_rss
separately.  We split off anon_rss in 2.6.10, and changed the meaning
of "shared" then too - here's my ChangeLog comment justifying it.

From: Hugh Dickins <hugh@veritas.com>
Date: Thu, 28 Oct 2004 01:17:23 +0000 (-0700)
Subject: [PATCH] statm: shared =3D rss - anon_rss
X-Git-Tag: v2.6.10~147^2~103
X-Git-Url: http://127.0.0.1:1234/?p=3D.git;a=3Dcommitdiff_plain;h=3D8586feb=
d93ed02668b9d0ad87963610425e44977;hp=3Dda63671a5c506729abb8fe383704c264967c=
53c0

[PATCH] statm: shared =3D rss - anon_rss

The third "shared" field of /proc/$pid/statm in 2.4 was a count of pages in
the mm whose page_count is more than 1 (oddly, including pages shared just
with swapcache).  That's too costly to calculate each time, so 2.6 changed
it to the total file-backed extent.  But Andrea knows apps and users
surprised when (rss - shared) goes negative: we need to provide an rss-like
statistic, close to the 2.4 interpretation.

Something that's quick and easy to maintain accurately is mm->anon_rss, the
count of anonymous pages in the mm.  Then shared =3D rss - anon_rss gives a
pretty good and meaningful approximation to 2.4's intention: wli confirms
that this will be useful to Oracle too.

Where to show it?  I think it's best to treat this as a bugfix and show it
in the third field of /proc/$pid/statm, after resident, as before - there's
no evidence that the total file-backed extent was found useful.

Albert would like other fields to revert to page counts, but that's a lot
harder: if mprotect can change the category of a page, then it can't be
accounted as simply as this.  Only go that route if real need shown.

Hugh
--8323584-578489045-1163601908=:11929--
