Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268131AbUH1Xmd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268131AbUH1Xmd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 19:42:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268133AbUH1Xmc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 19:42:32 -0400
Received: from dp.samba.org ([66.70.73.150]:32479 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S268131AbUH1Xm1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 19:42:27 -0400
Date: Sat, 28 Aug 2004 16:47:38 -0700
From: Jeremy Allison <jra@samba.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Helge Hafting <helgehaf@aitel.hist.no>, Rik van Riel <riel@redhat.com>,
       Spam <spam@tnonline.net>, Jamie Lokier <jamie@shareable.org>,
       Hans Reiser <reiser@namesys.com>, David Masover <ninja@slaphack.com>,
       Diego Calleja <diegocg@teleline.es>, christophe@saout.de,
       vda@port.imtp.ilyichevsk.odessa.ua, christer@weinigel.se,
       Andrew Morton <akpm@osdl.org>, wichert@wiggy.net, jra@samba.org,
       hch@lst.de, linux-fsdevel@vger.kernel.org,
       Kernel Mailing List <linux-kernel@vger.kernel.org>, flx@namesys.com,
       reiserfs-list@namesys.com,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Subject: Re: silent semantic changes with reiser4
Message-ID: <20040828234738.GC2611@localhost.localdomain>
Reply-To: Jeremy Allison <jra@samba.org>
References: <Pine.LNX.4.44.0408272158560.10272-100000@chimarrao.boston.redhat.com> <Pine.LNX.4.58.0408271902410.14196@ppc970.osdl.org> <20040828170515.GB24868@hh.idb.hist.no> <Pine.LNX.4.58.0408281038510.2295@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0408281038510.2295@ppc970.osdl.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 28, 2004 at 11:09:38AM -0700, Linus Torvalds wrote:
> 
> If you look at the Solaris interface, the _nice_ part about "openat()" is 
> that you can do something like
> 
> 	file = open(filename, O_RDONLY);
> 	if (file < 0)
> 		return -ENOENT;
> 	icon = openat(file, "icon", O_RDONLY | O_XATTR);
> 	if (icon < 0)
> 		icon = default_icon_file;
> 	..
> 
> and it will work regardless of whether "filename" is a directory or a 
> regular file, if I've understood correctly.
> 
> Now, I think that makes sense for several reasons:
>  - single case
>  - race-free (think "stat()" vs "fstat()" races).
>  - I think we want to do "openat()" regardless of whether we ever 
>    support extended attributes or not ("openat()" is nice for doing 
>    "namei()" in user space even in the absense of any attributes or 
>    named streams).
> 
> So what we can do is
>  - implement openat() regardless, and expect to do the Solaris thing for 
>    it if we ever do streams.

Hurrah ! Definately the best way to go as far as Samba is concerned.
Makes our portability easier. Now the NT interface allows an open on
a named data stream without an open on the containing file (ie.
you can do CreateFile("filename::STREAMNAME",....) without doing
CreateFile("filename",..." first, but I personally think those
semantics are a nasty hack. It makes much more sense (IMHO) to
ensure that you already have an open fd on a file before allowing
access to the named streams inside, Windows be damned. If we have
some semantic issues mapping from the Windows semantics to Solaris/Linux
semantics then so be it, it's a Samba problem so to speak :-).

Thanks,

	Jeremy.
