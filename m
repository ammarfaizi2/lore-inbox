Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265042AbSKFNUg>; Wed, 6 Nov 2002 08:20:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265046AbSKFNUg>; Wed, 6 Nov 2002 08:20:36 -0500
Received: from gra-vd1.iram.es ([150.214.224.250]:32388 "EHLO gra-vd1.iram.es")
	by vger.kernel.org with ESMTP id <S265042AbSKFNUf>;
	Wed, 6 Nov 2002 08:20:35 -0500
Date: Wed, 6 Nov 2002 14:27:02 +0100 (CET)
From: Gabriel Paubert <paubert@iram.es>
To: "H. Peter Anvin" <hpa@zytor.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: New nanosecond stat patch for 2.5.44
In-Reply-To: <aphqqo$261$1@cesium.transmeta.com>
Message-ID: <Pine.LNX.4.32.0211061324110.19072-100000@gra-vd1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 31 Oct 2002, H. Peter Anvin wrote:

> Followup to:  <20021027214913.GA17533@clusterfs.com>
> By author:    Andreas Dilger <adilger@clusterfs.com>
> In newsgroup: linux.dev.kernel
> >
> > 3) The fields you are usurping in struct stat are actually there for the
> >    Y2038 problem (when time_t wraps).  At least that's what Ted said when
> >    we were looking into nsec times for ext2/3.  Granted, we may all be
> >    using 64-bit systems by 2038...  I've always thought 64 bits is much
> >    to large for time_t, so we could always use 20 or 30 bits for sub-second
> >    times, and the remaining bits for extending time_t at the high end,
> >    and mask those off for now, but that is a separate issue...
> >
>
> 64-bit time_t is nice because you don't *ever* need to worry about
> overflow; it's capable of handling times on a galactic lifespan
> scale.  It's overkill, of course, but it's the *right* kind of
> overkill.

Indeed.

>
> We probably need to revamp struct stat anyway, to support a larger
> dev_t, and possibly a larger ino_t (we should account for 64-bit ino_t
> at least if we have to redesign the structure.)  At that point I would
> really like to advocate for int64_t ts_sec and uint32_t ts_nsec and
> quite possibly a int32_t ts_taidelta to deal with leap seconds... I'd
> personally like struct timespec to look like the above everywhere.

I basically agree but I suspect that filesystem writers will not be very
happy if you want to use 16 bytes for each timestamp, especially when 8 of
the bytes (the 32 high order bits from the second count and the TAI-UT
offset) do not change very often. (besides that tv_nsec is defined as a
long, i.e.  64 bit on 64 bit machines and _signed_ , stupid if you ask me
but I digress).

The goal as I understand it is to avoid first the possibility of ambiguous
timestamps, but then we have to be careful also not to break existing
applications (although they already broken wrt leap seconds).

I don't know how to trim the highly repeated most significant bytes of the
tv_sec field (it's probably file system specific), but 4 bytes can easily
be shaved from the on-disk structure by packing the leap second
information in the high order bits of the nsec field: since the number of
nanoseconds per second is unlikely to ever need more than 30 bits to be
encoded ;-), the 2 most significant bits can be used to encode inserted
leap seconds. Actually 1 bit should be sufficient but some texts claim
that up to 2 leap seconds can be inserted, this has however actually never
happened AFAICT and I believe that NTP for example does not support 2 leap
seconds in a row.

Converting this encoding to the format you suggest for stat(2) is trivial:
it only needs a table of leap seconds. I don't care whether it's in the
kernel or in user space: it's small and grows slowly.

For now I have more problems with the fact that gettimeofday and friends
do not properly handle leap seconds and lead to ambiguous timestamps.
Once this problem (a real killer for astronomical data acquisition, leap
seconds are infrequent but they are a problem) is solved, filesystems can
be updated.

What could be important now is to mask the low 30 bits of the nsec field
and declare the 2 MSB reserved so that no kernel is out in the wild that
simply copies the full nsec field to user space.

	Regards,
	Gabriel.



