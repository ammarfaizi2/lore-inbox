Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315183AbSD3TsZ>; Tue, 30 Apr 2002 15:48:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315185AbSD3TsY>; Tue, 30 Apr 2002 15:48:24 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:51474 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S315183AbSD3TsX>;
	Tue, 30 Apr 2002 15:48:23 -0400
Message-ID: <3CCEF4CC.C56E31B8@zip.com.au>
Date: Tue, 30 Apr 2002 12:47:24 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: suparna@in.ibm.com
CC: "Eric W. Biederman" <ebiederm@xmission.com>, linux-kernel@vger.kernel.org,
        marcelo@brutus.conectiva.com.br, linux-mm@kvack.org
Subject: Re: [PATCH]Fix: Init page count for all pages during higher order allocs
In-Reply-To: <20020429202446.A2326@in.ibm.com> <m1r8ky1jzu.fsf@frodo.biederman.org> <20020430110108.A1275@in.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Suparna Bhattacharya wrote:
> 
> ...
> > It might make sense to add a PG_large flag and
> > then in the immediately following struct page add a pointer to the next
> > page, so you can identify these pages by inspection.  Doing something
> > similar to the PG_skip flag.
> 
> Maybe different solutions could emerge for this in 2.4 and 2.5.
> 
> Even a PG_partial flag for the partial pages will enable us to
> traverse back to the main page, and vice-versa to determine the
> partial pages covered by the main page, without any additional
> pointers. Is that an acceptable option for 2.4 ? (That's one
> more page flag ...)
> 

I'd suggest that you go with the PG_partial thing for the
follow-on pages.

If you have a patch for crashdumps, and that patch is
included in the main kernel, and it happens to rely on the
addition of a new page flag well gee, that's a tiny change.

Plus it only affects code paths in the `order > 0' case,
which are rare.

Plus you can independently use PG_partial to detect when
someone is freeing pages from the wrong part of a higher-order
allocation - that's a feature ;)

An alternative is to just set PG_inuse against _all_ pages
in rmqueue(), and clear PG_inuse against all pages in
__free_pages_ok().  Which seems cleaner, and would fix other
problems, I suspect.

-
