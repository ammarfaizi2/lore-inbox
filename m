Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311523AbSDXKU0>; Wed, 24 Apr 2002 06:20:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311587AbSDXKUZ>; Wed, 24 Apr 2002 06:20:25 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:60178 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S311523AbSDXKUY>; Wed, 24 Apr 2002 06:20:24 -0400
Message-ID: <3CC686D8.44435CE5@aitel.hist.no>
Date: Wed, 24 Apr 2002 12:20:08 +0200
From: Helge Hafting <helgehaf@aitel.hist.no>
X-Mailer: Mozilla 4.76 [no] (X11; U; Linux 2.5.7 i686)
X-Accept-Language: no, en, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Bio pool & scsi scatter gather pool usage
In-Reply-To: <E16yUE0-0006i7-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > But this gets you lowest common denominator sizes for the whole
> > volume, which is basically the buffer head approach, chop all I/O up
> > into a chunk size we know will always work. Any sort of nasty  boundary
> > condition at one spot in a volume means the whole thing is crippled
> > down to that level. It then becomes a black magic art to configure a
> > volume which is not restricted to a small request size.
> 
> Its still cheaper to merge bio chains than split them. The VM issues with
> splitting them are not nice at all since you may need to split a bio to
> write out a page and it may be the last page

How about reserving a small memory pool for splitting when normal
memory allocation fails?  

I know we want a clean kernel,
so this mechanism would be implemented in those drivers that
actually need it.  I.e. raid0/5 would keep a
emergency split buffer around for bio's bigger than the
stripe size, devices with all sorts of odd requirement could do the
same.
This might look like duplication, but isn't really as the different
devices
might need different splitting anyway.  I.e. RAID want to
split into stripe-sized chunks but no smaller, an odd device might
need something different.  The disk concatenation in md would
only want to split when you actually hit a boundary.
Also, letting each driver handle the special cases itself
works when someone makes raid-0 on top
of weird adapters.

A kernel with just plain disk drivers wouldn't need
and wouldn't have such mechanisms either.

Helge Hafting
