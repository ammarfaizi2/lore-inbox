Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265297AbSKFHoc>; Wed, 6 Nov 2002 02:44:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265639AbSKFHoc>; Wed, 6 Nov 2002 02:44:32 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:25411 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S265297AbSKFHoa>; Wed, 6 Nov 2002 02:44:30 -0500
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Werner Almesberger <wa@almesberger.net>,
       Suparna Bhattacharya <suparna@in.ibm.com>,
       Jeff Garzik <jgarzik@pobox.com>,
       "Matt D. Robinson" <yakker@aparity.com>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       <lkcd-general@lists.sourceforge.net>,
       <lkcd-devel@lists.sourceforge.net>
Subject: Re: [lkcd-devel] Re: What's left over.
References: <Pine.LNX.4.44.0211052203150.1416-100000@home.transmeta.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 06 Nov 2002 00:48:36 -0700
In-Reply-To: <Pine.LNX.4.44.0211052203150.1416-100000@home.transmeta.com>
Message-ID: <m1znsndtpn.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@transmeta.com> writes:

> On 5 Nov 2002, Eric W. Biederman wrote:
> > 
> > In replying to another post by Al Viro I managed to think this through.
> > kexec needs:
> 
> Note that kexec doesn't bother me at all, and I might find myself using it 
> myself.

Good.  Just before I saw this message I sent you my patch ported to 2.5.46,
and from the feed back on this one it looks like people would
appreciate a tweak or two.
 
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

That sounds reasonable to me.  Especially as that lines up a little more
with what the mcore people want as well.  Until today I hadn't realized
they were using a spare current to process oopses.  For just booting
another kernel all of the staging can currently be done by reading the
new kernel into your process before calling the user-level shutdown code.

> Right now the kexec() stuff seems to mix up the loading and rebooting, but
> I didn't take a very deep look, maybe I'm wrong.

It currently happens all in one step because I had never gotten
feedback that people wanted it in two steps.   

> Note that the two-phase boot means that you can load the new kernel early, 
> which allows you to later on use it for oops handling (it's a bit late to 
> try to set up the kernel to be loaded at that time ;)

Given that it is definitely a good idea to split the patch up into two
pieces.  And a kernel for oops handling should work once all of other
problems are resolved.

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

Using area->pages[] is an interesting idea.

>From my current interface this is missing the following pieces.
1) The address or addresses to load the new kernel at.  (Think kernel + ramdisk)
2) The address to jump to start the new kernel.
3) My interesting buffer handling.

The question is how much of that do we need.

Thinking out loud, and hopefully answering your question.
- We need a working stack when the new kernel is jumped to so PIC code
  can exist at the entry point.

- An oops processing kernel needs to load at an address other than 1MB,
  or at the very least it's boot sequence needs to squirrel away the
  old contents of the kernel text and data segments, which reside at
  1MB, before it moves down to 1MB.

- When we transfer control to the trampoline in machine_kexec we need
  to be able to refer to everything with physical addresses.

- I do not see a way out of running my buffer verifier algorithm.
  The problem is that I do not want to put complex logic in the
  assembly machine_kexec trampoline.  So I want to be able to pass
  it something it can just memcpy to it's final resting place.  Which
  means the buffer pages either need to be the final resting place of
  the new kernel (ideal) or are not a page that of the final resting
  place.

- I can dig up area->pages[] but I don't see vmalloc buying me
  anything.  Doing the copies and allocations a page at a time is not
  hard.   I have to sort the contents of the pages, and where they
  are located so I need to undo the virtual mapping.
  area ->pages is all by struct pages *, which is most inconvenient 
  when you are tearing down page tables, I would need to put the pages
  into another data structure that just had the page frame number or
  physical page address anyway.

- Once I am using my own data structure to track the pages, and I am
  already vetting the pages for safe locations.  Going the rest of the
  way to my current interface is not a big step, and I have already
  tested that code.

So either I have blinders on, or there is very little percentage in
changing how I load an image.  But to make the oops processing easier
I will split it up into two parts.

Then I guess the reasonable thing to do is to modify sys_reboot to
call machine_kexec instead of machine_restart when a kexec_image is
present.  Or should I add another magic number, and another case to
sys_reboot?  

	case LINUX_REBOOT_CMD_RESTART:
		notifier_call_chain(&reboot_notifier_list, SYS_RESTART, NULL);
		system_running = 0;
		device_shutdown();
		printk(KERN_EMERG "Restarting system.\n");
+		if (kexec_image)
+			machine_kexec(kexec_image);
		machine_restart(NULL);
		break;


O.k.  In the next couple of days I will split the loading, and
executing phase of my kexec code into parts, and resubmit the code.
The we can dig in on what it takes to make kexec run stably.

Eric


