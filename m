Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265657AbSKFGag>; Wed, 6 Nov 2002 01:30:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265665AbSKFGag>; Wed, 6 Nov 2002 01:30:36 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:47754 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S265657AbSKFGaa>; Wed, 6 Nov 2002 01:30:30 -0500
Date: Wed, 6 Nov 2002 12:08:54 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Werner Almesberger <wa@almesberger.net>,
       Jeff Garzik <jgarzik@pobox.com>,
       "Matt D. Robinson" <yakker@aparity.com>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lkcd-general@lists.sourceforge.net, lkcd-devel@lists.sourceforge.net
Subject: Re: [lkcd-devel] Re: What's left over.
Message-ID: <20021106120854.A2259@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <m1d6pjfhhr.fsf@frodo.biederman.org> <Pine.LNX.4.44.0211052203150.1416-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0211052203150.1416-100000@home.transmeta.com>; from torvalds@transmeta.com on Tue, Nov 05, 2002 at 10:25:35PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 05, 2002 at 10:25:35PM -0800, Linus Torvalds wrote:
> 
> On 5 Nov 2002, Eric W. Biederman wrote:
> > 
> > In replying to another post by Al Viro I managed to think this through.
> > kexec needs:
> 
> Note that kexec doesn't bother me at all, and I might find myself using it 
> myself.
> 
> >From a sanity standpoint, I think the thing already _has_ a system call, 
> though: clearly "sys_reboot()" is the place to add a case for "reboot into 
> this image". No? That's where we shut down devices anyway, and it's the 
> sane place to say "reboot into the kexec image"
> 
> Which still leaves you with a real sys_kexec() to actually _load_ the
> image, or course. I think loading of the image should be a totally
> separate event from the actual booting of the image, since we may want to
> load the image early, then do various user-level shutdown (unmounting 
> etc), and then reboot.
> 
> Right now the kexec() stuff seems to mix up the loading and rebooting, but
> I didn't take a very deep look, maybe I'm wrong.
> 
> Anyway, I don't really get why the kexec() system call would not just be
> 
> 	void *kexec_image = NULL;
> 	unsigned long kexec_size;
> 
> 	int sys_kexec(void *uaddr, size_t len)
> 	{
> 		void *new;
> 
> 		if (!capable(CAP_ADMIN))
> 			return -EPERM;
> 
> 		/* Get rid of old image if any.. */
> 		if (kexec_image) {
> 			vfree(kexec_image);
> 			kexec_image = NULL;
> 		}
> 
> 		/* Zero length just meant "get rid of it" */
> 		if (!len)
> 			return 0;
> 
> 		if (!access_ok(VERIFY_READ, uaddr, len))
> 			return -EFAULT;
> 
> 		new = vmalloc(len);
> 		if (!new)
> 			return -ENOMEM;
> 
> 		if (memcpy_from_user(new, uaddr, len)) {
> 			vfree(new);
> 			return -EFAULT;
> 		}
> 
> 		kexec_image = new;
> 		kexec_size = len;
> 		return 0;
> 	}
> 
> and be done with it that way? Then the actual "reboot" (and that would be
> in the existing "sys_reboot()") basically just does something like
> 
> 	memcpy(kernelbase, kexec_image, kexec_size);
> 
> at the very end (while obviously having to be careful about itself being
> out of the way. It can avoid the page table issue by using the "page *"
> array that vmalloc uses internally anyway: see "area->pages[]" in
> vmalloc).
> 
> Note that the two-phase boot means that you can load the new kernel early, 
> which allows you to later on use it for oops handling (it's a bit late to 
> try to set up the kernel to be loaded at that time ;)

Yes, that's exactly what we need to support a soft-boot based dump
mechanism, much like the Mission Critical folks split up the bootimg
syscall to do the early load on a sane system, and the actual soft-boot
at crash time. And it fits in naturally as you point out ..

Regards
Suparna

> 
> 		Linus
> 

-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Labs, India

