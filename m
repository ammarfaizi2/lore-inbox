Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267096AbRGJTDQ>; Tue, 10 Jul 2001 15:03:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267095AbRGJTDG>; Tue, 10 Jul 2001 15:03:06 -0400
Received: from front5m.grolier.fr ([195.36.216.55]:12019 "EHLO
	front5m.grolier.fr") by vger.kernel.org with ESMTP
	id <S267094AbRGJTCv> convert rfc822-to-8bit; Tue, 10 Jul 2001 15:02:51 -0400
Date: Tue, 10 Jul 2001 21:00:35 +0200 (CEST)
From: =?ISO-8859-1?Q?G=E9rard_Roudier?= <groudier@club-internet.fr>
X-X-Sender: <groudier@>
To: Tim Hockin <thockin@sun.com>
cc: <alan@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH]  sym53c8xx timer rework
In-Reply-To: <3B4AAC7D.A86AF1F3@sun.com>
Message-ID: <20010710203327.Q1488-100000@>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 10 Jul 2001, Tim Hockin wrote:

> Gerard (and all)
>
> Attached is a small patch to re-work the timer in the sym53c8xx driver.  I
> submitted this patch against 2.4.5, but don't see it in 2.4.6, so I am
> re-submitting against 2.4.6.
>
> Please let me know if there are any problems with this patch.

Hmmm... How much are you sure there isn't any race in your patch ?

If the timer handler is spinning on the lock embedded in the driver
instance and you free this instance under its knees, it will just
reference random memory.

That was the reason I preferred to leave the timer die by itself prior to
releasing the HBA instance. The 'release_stage' was the trick, but
probably some memory barriers or atomic operations were missing.

If you want to delete the timer on HBA instance release, then you also
want to check if the pointer to the HBA instance is still valid in the
timer handler and just return if it isn't so.

Btw, is there a simple and clean way to deal with such concurrency (I mean
a timer embedded in a data structure we want to free concurrently ? Given
the current sheme of Linux requiring a synchronous HBA instance release, I
am under the impression that there is no such way.

  Gérard.

