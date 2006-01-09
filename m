Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751594AbWAIWnB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751594AbWAIWnB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 17:43:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751597AbWAIWnA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 17:43:00 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:9368 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751595AbWAIWm7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 17:42:59 -0500
Message-ID: <43C2E6EF.40903@us.ibm.com>
Date: Mon, 09 Jan 2006 14:42:55 -0800
From: "Darrick J. Wong" <djwong@us.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Paul Jackson <pj@sgi.com>
CC: Alexis Bruemmer <alexisb@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: cpusets: BUG: cpuset_excl_nodes_overlap() may sleep under tasklist_lock
X-Enigmail-Version: 0.92.0.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig213A01FE4501B8AB3E864E35"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig213A01FE4501B8AB3E864E35
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi Mr. Jackson,

I've been stress testing 2.6.15 on an IntelliStation Z20 in our lab, and
have seen the same complaints that were described earlier in this thread
(sleeping in the cpuset code under OOM conditions):

Debug: sleeping function called from invalid context at
include/asm/semaphore.h:105
in_atomic():1, irqs_disabled():0

Call Trace:<ffffffff80130640>{__might_sleep+179}
<ffffffff8015bb68>{cpuset_excl_nodes_overlap+31}
       <ffffffff80164d9f>{out_of_memory+123}
<ffffffff801676c4>{__alloc_pages+564}
       <ffffffff8017ec41>{alloc_pages_current+160}
<ffffffff8016873f>{__do_page_cache_readahead+197}
       <ffffffff8010e5c3>{__switch_to+50}
<ffffffff8031c547>{_spin_unlock_irqrestore+52}
       <ffffffff80166604>{free_pages_bulk+674}
<ffffffff80168a00>{do_page_cache_readahead+82}
       <ffffffff8016355a>{filemap_nopage+332}
<ffffffff8017378f>{__handle_mm_fault+1162}
       <ffffffff8031c547>{_spin_unlock_irqrestore+52}
<ffffffff8031df02>{do_page_fault+1096}
       <ffffffff801991ee>{sys_select+839} <ffffffff8011078d>{error_exit+0}

Since we seem to be able to reproduce this with some regularity, let me
know if you'd like us to test out any cpuset patch(es).

--Darrick

> Kirill Korotaev wrote:
>> FYI, there is an obvious bug in cpusets in 2.6.15-rcX:
>> cpuset_excl_nodes_overlap() may sleep (as it takes semaphore), but is 
>> called from atomic context - select_bad_process() under tasklist_lock.
>> BUG. Found by Denis Lunev.
> 
> Sorry for not responding sooner - I was off the air for a week.
> 
> Thanks for finding and reporting this.
> 
> Apparently, from KUROSAWA Takahiro's report, this bug was also in
> 2.6.14.  My initial reading of the code in 2.6.14 and 2.6.15-* agrees,
> and finds that this bug was present since the cpuset_excl_nodes_overlap
> call was added, Sept 8, 2005 (in Linus's tree.)
> 
> 
>> the same actually applies to cpuset_zone_allowed() which is called e.g. 
>> from __alloc_pages()->get_page_from_freelist() and doesn't check for 
>> GPF_NOATOMIC anyhow...
> 
> I don't think so.  Please read the comments in kernel/cpuset.c above
> the routine cpuset_zone_allowed().  Either that routine is called with
> the __GFP_HARDWALL flag set, so returns before it gets to the semaphore
> call, or it is not called at all, due to the check for ATOMIC (!wait)
> in mm/page_alloc.c.
> 
> I don't see any bugs like this, in the cpuset_zone_allowed code path.
> 
> 
> ==> My initial analysis - I have one bug, in the oom_kill path,
>     where the code takes callback_sem while holding tasklist_ lock,
>     that has been in the main line kernel since 2.6.14.
> 
> My first guess is that it will take me about a week, with testing and
> other priorities (including a few more days vacation), to respond with a
> patch.  Speak up if that doesn't meet your needs.


--------------enig213A01FE4501B8AB3E864E35
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDwubxa6vRYYgWQuURAox1AKCwbsctHjo1os3M4Z9H2CY2BQ3LgwCeO4AH
JQzRup5WaMqLkQQbqw6TorQ=
=7dm4
-----END PGP SIGNATURE-----

--------------enig213A01FE4501B8AB3E864E35--
