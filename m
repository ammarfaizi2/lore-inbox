Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261988AbVANPqU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261988AbVANPqU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 10:46:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262012AbVANPqU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 10:46:20 -0500
Received: from fw.osdl.org ([65.172.181.6]:16290 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261988AbVANPqN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 10:46:13 -0500
Date: Fri, 14 Jan 2005 07:45:44 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Horst von Brand <vonbrand@inf.utfsm.cl>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Christoph Hellwig <hch@infradead.org>,
       Dave Jones <davej@redhat.com>, Andrew Morton <akpm@osdl.org>,
       marcelo.tosatti@cyclades.com, Greg KH <greg@kroah.com>, chrisw@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: thoughts on kernel security issues 
In-Reply-To: <200501141239.j0ECdaRj005677@laptop11.inf.utfsm.cl>
Message-ID: <Pine.LNX.4.58.0501140731450.2310@ppc970.osdl.org>
References: <200501141239.j0ECdaRj005677@laptop11.inf.utfsm.cl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 14 Jan 2005, Horst von Brand wrote:
> 
> But you can trivially run an executable via e.g.:
> 
>     /lib/ld-2.3.4.so some-nice-proggie

I thought we fixed this, and modern ld-so's will fail on this if 
"some-nice-proggie" cannot be mapped executably. Which is exactly what 
we'd do.

[ scrounge scrounge ]

Yup, just checked - it's exactly the same case as MNT_NOEXEC, which indeed
used to have exactly that bug.

So the implementation of what I suggested (and no, I'm not at all
guaranteeing that this is a wonderful idea, I'm sure others have tried it
and it probably sucks) would be something like

	--- 1.161/mm/mmap.c	2005-01-12 08:26:28 -08:00
	+++ edited/mm/mmap.c	2005-01-14 07:37:51 -08:00
	@@ -882,9 +882,12 @@
	 		if (!file->f_op || !file->f_op->mmap)
	 			return -ENODEV;
	 
	-		if ((prot & PROT_EXEC) &&
	-		    (file->f_vfsmnt->mnt_flags & MNT_NOEXEC))
	-			return -EPERM;
	+		if (prot & PROT_EXEC) {
	+			if (file->f_vfsmnt->mnt_flags & MNT_NOEXEC)
	+				return -EPERM;
	+			if (!capability(CAP_CAN_RUN_NONROOT) && file->f_dentry->d_inode->i_uid)
	+				return -EPERM;
	+		}
	 	}
	 	/*
	 	 * Does the application expect PROT_READ to imply PROT_EXEC?

(or just add a security hook there - it's not like this couldn't be a 
SELinux thing..)

And no, this doesn't trap mprotect(), but that's not the point. The point
of this is not to make it impossible to execute code on purpose by some
existing binary - it's to make it impossible for some people to compile or
download their own binaries.

(Side note: this is probably useful for MIS kind of things - if you don't 
want your users to download games etc, you'd want soemthing like that. Of 
course, MNT_NOEXEC in that case is fairly easy, and the "run programs 
capability" is more a "this also works for arbitrary servers etc" things).

Alan's point about perl is well taken, though. Perl is a pretty damn 
generic interpreter, and unlike most interpreters exposes everything. And 
I doubt it uses "mmap(.. PROT_EXEC)" to map in the file ;)

		Linus
