Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268064AbUH1WfA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268064AbUH1WfA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 18:35:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268061AbUH1WfA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 18:35:00 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:31962 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S268039AbUH1Wem (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 18:34:42 -0400
X-Comment: AT&T Maillennium special handling code - c
Message-ID: <4131074D.7050209@namesys.com>
Date: Sat, 28 Aug 2004 15:29:33 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Helge Hafting <helgehaf@aitel.hist.no>, Rik van Riel <riel@redhat.com>,
       Spam <spam@tnonline.net>, Jamie Lokier <jamie@shareable.org>,
       David Masover <ninja@slaphack.com>, Diego Calleja <diegocg@teleline.es>,
       christophe@saout.de, vda@port.imtp.ilyichevsk.odessa.ua,
       christer@weinigel.se, Andrew Morton <akpm@osdl.org>, wichert@wiggy.net,
       jra@samba.org, hch@lst.de, linux-fsdevel@vger.kernel.org,
       Kernel Mailing List <linux-kernel@vger.kernel.org>, flx@namesys.com,
       reiserfs-list@namesys.com,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Subject: Re: silent semantic changes with reiser4
References: <Pine.LNX.4.44.0408272158560.10272-100000@chimarrao.boston.redhat.com> <Pine.LNX.4.58.0408271902410.14196@ppc970.osdl.org> <20040828170515.GB24868@hh.idb.hist.no> <Pine.LNX.4.58.0408281038510.2295@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0408281038510.2295@ppc970.osdl.org>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I object to openat().....

My reason is that the things that distinguish between objects should be 
the names, not the choice of system call.  The reason for this is that 
it improves closure and namespace unification to do so, because it 
allows all the objects to be accessed within the same namespace.

Yes, it can be useful to allow a namespace to exclude some objects, but 
that exclusion should not be mandated.  If you want to exclude, you 
should cd or chroot to /proc/nopseudos and find a view of the filesystem 
that excludes metas, or mount with -nopseuodos.

Do you see why I say this?  I can say a lot more about the damage of 
fragmenting namespaces into multiple apis.... Why look at xattrs....;-)

Hans


Linus Torvalds wrote:

>
>
>I'm pretty confident that we can extend the VFS layer to support named
>streams (see the technical discussion with Al, rather than the flames in
>this thread). I also clearly believe that it is worth it, but I'm starting
>to wonder if we should have a special open flag to make people select the
>stream.
>
>If you look at the Solaris interface, the _nice_ part about "openat()" is 
>that you can do something like
>
>	file = open(filename, O_RDONLY);
>	if (file < 0)
>		return -ENOENT;
>	icon = openat(file, "icon", O_RDONLY | O_XATTR);
>	if (icon < 0)
>		icon = default_icon_file;
>	..
>
>and it will work regardless of whether "filename" is a directory or a 
>regular file, if I've understood correctly.
>
>Now, I think that makes sense for several reasons:
> - single case
> - race-free (think "stat()" vs "fstat()" races).
> - I think we want to do "openat()" regardless of whether we ever 
>   support extended attributes or not ("openat()" is nice for doing 
>   "namei()" in user space even in the absense of any attributes or 
>   named streams).
>
>So what we can do is
> - implement openat() regardless, and expect to do the Solaris thing for 
>   it if we ever do streams.
> - _also_ support the "implied named attributes" for regular files, so 
>   that you don't have to use "openat()" to access them.
>
>Comments? Does anybody hate "openat()" for any reason (regardless of 
>attributes)? We can easily support it, we'd just need to pass in the file 
>to use as part of the "nameidata" thing or add an argument (it would also 
>possibly be cleaner if we made "fs->pwd" be a "struct file").
>
>		Linus
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>
>  
>

