Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261188AbUJXVTN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261188AbUJXVTN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Oct 2004 17:19:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261196AbUJXVTN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Oct 2004 17:19:13 -0400
Received: from fw.osdl.org ([65.172.181.6]:42970 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261188AbUJXVTH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Oct 2004 17:19:07 -0400
Date: Sun, 24 Oct 2004 14:18:53 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Pavel Machek <pavel@suse.cz>
cc: Paul Mackerras <paulus@samba.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, David Brownell <david-b@pacbell.net>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Subject: Re: Totally broken PCI PM calls
In-Reply-To: <20041024205841.GH28314@elf.ucw.cz>
Message-ID: <Pine.LNX.4.58.0410241415360.13209@ppc970.osdl.org>
References: <1097455528.25489.9.camel@gaston> <Pine.LNX.4.58.0410101937100.3897@ppc970.osdl.org>
 <16746.299.189583.506818@cargo.ozlabs.ibm.com> <Pine.LNX.4.58.0410102115410.3897@ppc970.osdl.org>
 <20041011101824.GC26677@atrey.karlin.mff.cuni.cz>
 <Pine.LNX.4.58.0410110857180.3897@ppc970.osdl.org> <20041015135955.GD2015@elf.ucw.cz>
 <Pine.LNX.4.58.0410150839010.3897@ppc970.osdl.org> <20041024205841.GH28314@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 24 Oct 2004, Pavel Machek wrote:
> 
> Ok, after -Wbitwise for sparse, strict typechecking seems to
> work. Unfortunately, it produces a *lot* of noise, for code such as
> 
> static ssize_t disk_show(struct subsystem * subsys, char * buf)
> {
>         return sprintf(buf, "%s\n", pm_disk_modes[pm_disk_mode]);
> }
> 
> ...where pm_disk_mode is __bitwise. That is not really what we
> want. Would it be possible to get something similar to __bitwise where
> arithmetic is still okay to do?

I'll try to get to it - I've spent the last two days on sparse making sure 
that I can do flow-control checking (things like "a function that gets a 
spinlock needs to release it"), and it will take a while before I get out 
of it.

But yes, I think it makes sense to have a "unique type" thing that allows 
arithmetic. And I think it makes sense to have another unique type that 
disallows _all_ operations (ie truly opaque cookies, where the only valid 
op is to compare it with another cookie).

Maybe Al is interested..

		Linus

---
> With __bitwise, I'd need to do:
> 
> @@ -292,15 +297,15 @@
>         int i;
>         int len;
>         char *p;
> -       u32 mode = 0;
> +       suspend_disk_method_t mode = 0;
> 
>         p = memchr(buf, '\n', n);
>         len = p ? p - buf : n;
> 
>         down(&pm_sem);
> -       for (i = PM_DISK_FIRMWARE; i < PM_DISK_MAX; i++) {
> +       for (i = (int __force) PM_DISK_FIRMWARE; i < (int __force) PM_DISK_MAX; i++) {
>                 if (!strncmp(buf, pm_disk_modes[i], len)) {
> -                       mode = i;
> +                       mode = (suspend_disk_method_t __force) i;
>                         break;
>                 }
>         }
> 
> 
> ...thats ugly.
> 
> 								Pavel
> -- 
> People were complaining that M$ turns users into beta-testers...
> ...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
> 
