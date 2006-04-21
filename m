Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932204AbWDUMeR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932204AbWDUMeR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 08:34:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932200AbWDUMeR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 08:34:17 -0400
Received: from mx1.redhat.com ([66.187.233.31]:36072 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932190AbWDUMeQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 08:34:16 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20060420170754.39294603.akpm@osdl.org> 
References: <20060420170754.39294603.akpm@osdl.org>  <20060420165927.9968.33912.stgit@warthog.cambridge.redhat.com> <20060420165932.9968.40376.stgit@warthog.cambridge.redhat.com> 
To: Andrew Morton <akpm@osdl.org>
Cc: David Howells <dhowells@redhat.com>, torvalds@osdl.org, steved@redhat.com,
       sct@redhat.com, aviro@redhat.com, linux-fsdevel@vger.kernel.org,
       linux-cachefs@redhat.com, nfsv4@linux-nfs.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/7] FS-Cache: Avoid ENFILE checking for kernel-specific open files 
X-Mailer: MH-E 7.92+cvs; nmh 1.1; GNU Emacs 22.0.50.4
Date: Fri, 21 Apr 2006 13:33:47 +0100
Message-ID: <4816.1145622827@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:

> >  static struct percpu_counter nr_files __cacheline_aligned_in_smp;
> > +static atomic_t nr_kernel_files;
> 
> So it's not performance-critical.

Hmmm... nowhere near as critical as the ENFILE accounting, plus the only place
we actually read it is for the sysctl file.

It could actually be dispensed with entirely, I suppose.

> > -struct file *get_empty_filp(void)
> > +struct file *get_empty_filp(int kernel)
> 
> I'd suggest a new get_empty_kernel_filp(void) rather than providing a magic
> argument.  (we can still have the magic argument in the new
> __get_empty_filp(int), but it shouldn't be part of the caller-visible API).
> ...
> It would be more flexible to make the caller pass in the flags directly.

So:

	struct file *get_empty_kernel_filp(unsigned short flags);

which devolves to get_empty_filp() if flags == 0?


> > +EXPORT_SYMBOL(fget_light);
> 
> fget_light is not otherwise referenced in this patch.

Good point.  I'll move it into the cachefiles patch.

> > +EXPORT_SYMBOL(dentry_open_kernel);
> 
> _GPL?

If you wish.

> That's unfortunate.  There's still room in f_flags.  Was it hard to use that?

Yeah... but the usage of f_flags is constrained by O_xxxx flags that are part
of the userspace interface.  Using those up for purely kernel things is a bad
idea.

Note that I've not actually increased the size of the struct file - f_mode is
a 16-bit value, hence why I chose an unsigned short.

> This changes the format of /proc/sys/fs/file-nr.  What will break?

As far as I can tell, not a lot.  I've grepped through various etc, lib and
bin directories on my FC5 system, and the only match I've found is:

	/usr/lib64/sa/sadc

I'll present the count through a separate file to make sure.

David
