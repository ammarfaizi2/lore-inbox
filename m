Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262876AbSKJBdf>; Sat, 9 Nov 2002 20:33:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262877AbSKJBdf>; Sat, 9 Nov 2002 20:33:35 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:5960 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S262876AbSKJBdc>; Sat, 9 Nov 2002 20:33:32 -0500
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Werner Almesberger <wa@almesberger.net>,
       Suparna Bhattacharya <suparna@in.ibm.com>,
       Jeff Garzik <jgarzik@pobox.com>,
       "Matt D. Robinson" <yakker@aparity.com>,
       Rusty Russell <rusty@rustcorp.com.au>, Andy Pfiffer <andyp@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Mike Galbraith <efault@gmx.de>,
       "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Subject: Re: [lkcd-devel] Re: What's left over.
References: <Pine.LNX.4.44.0211091510060.1571-100000@home.transmeta.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 09 Nov 2002 18:37:35 -0700
In-Reply-To: <Pine.LNX.4.44.0211091510060.1571-100000@home.transmeta.com>
Message-ID: <m1of8ycihs.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@transmeta.com> writes:

> On 9 Nov 2002, Eric W. Biederman wrote:
> > 
> > Currently my code handles starting a new kernel under normal operating
> > conditions.  There are currently two ways I can implement a clean user
> > space shutdown with out needing locked buffers in the kernel until the
> > very last moment.
> 
> PLEASE tell me why you don't just use the 20-line "vmalloc()" function I 
> already wrote for you?

The reasons I don't jump on board:
- It does not handle multiple segments.
  Without multiple segments I think I simply out essential complexity
  of the problem.  A bzImage has at least 2.

- vmalloc is artificially limited to 128MB.

- I still have to run code to prevent imperfect overlaps.  A perfect
  overlap being a source buffer living in it's destination address.

- I still have to run code to find the physical addresses of the
  pages, and locate those in non-destination pages, and form a linked
  list of pages for that.

> It works for all cases - and since you do need to load the kernel into 
> memory anyway, it's not using any more memory than your existing code. And 
> it's infinitely more flexible to have a clearly separated load-process, 
> than having to have some load happen at reboot time (whether by init or by 
> anything else).

I am trying to process it but I don't see why having the load happen
as a seperate syscall is clearer.  Having it happen as a seperate
architecture independent function I understand.

asmlinkage long sys_kexec(unsigned long entry, long nr_segments, 
	struct kexec_segment *segments)
{
	/* Am I using to much stack space here? */
	struct kimage image;
	int result;

	/* We only trust the superuser with rebooting the system. */
	if (!capable(CAP_SYS_BOOT))
		return -EPERM;

	lock_kernel();

////  This chunk does the load and there is no kernel shutdown code
////  run yet.
	kimage_init(&image);
	result = do_kexec(entry, nr_segments, segments, &image);
	if (result) {
		kimage_free(&image);
		unlock_kernel();
		return result;
	}

//// ----------- I can snip here for your two syscall version -----------

////  This part is the kernel shutdown
	
	/* The point of no return is here... */
	notifier_call_chain(&reboot_notifier_list, SYS_RESTART, NULL);
	system_running = 0;
	device_shutdown();
	printk(KERN_EMERG "Starting new kernel\n");

//// And here is where I start the new kernel.

	machine_kexec(&image);
}

>
> And since the kernel is fully working at the load time, you can even do
> things like swap out pages in order to make room for the kernel at the 
> right place.  So you can even do something like this:

I have clearly separated load code, that runs before any of the kernel
starts to shutdown.  Until it completes successfully I do not start
to shutdown the kernel.  My user space is shut down but that is a
different story.

Swapping out pages is nice, but when user space is shutdown there
shouldn't be any extra pages in the kernel to swap out, and if you are
that tight on memory that you need to swap it won't work, anyway.

> 	int alloc_kernel_pages(unsigned long *array, int nr_pages,
> 		unsigned long min_address)
> 	{
> 		void *bad_page_list = NULL;
> 		int i = 0, retval;
> 
> 		while (i < nr_pages) {
> 			unsigned long page = __get_free_page(GFP_USER);
> 
> 			if (!page)
> 				goto oom;
> 
> 			if (page < min_address) {
> 				*(void **)page = bad_page_list;
> 				bad_page_list = (void *)page;
> 				continue;
> 			}
> 			array[i] = page;
> 			i++;
> 		}
> 		retval = 0;
> 	out:
> 		while (bad_page_list) {
> 			unsigned long page = (unsigned long) bad_page_list;
> 			bad_page_list = *(void **)bad_page_list;
> 			free_page(page);
> 		}
> 		return retval;
> 	oom:
> 		while (i > 0)
> 			free_page(array[--i]);
> 		retval = -ENOMEM;
> 		goto out;
> 	}

Which is a good algorithm but it has the potential to allocate a lot
of extra pages, and I have implemented this it in the past.  It's
worst case is just nasty.  

My current code allocates at most 1 extra page and works gracefully if
it happens to allocates the pages it really wanted to use.  It is just
a hair more complex, and it makes everything else very simple.  

> and now you are guaranteed that all the allocated pages are above a
> certain mark (change the "min_address" to be a "validity callback" or
> whatever if you want to be fancy and allow arbitrary rules, which is good
> if you want to allow pages in the low 1M on x86, for example), which means
> that your final reboot stage is _much_much_ simpler and you don't ever 
> have to worry about overlap. 

Exactly and that is why I do it where I do it.  In the C load code.
In the kernel so it has to be written only once.
 
> Use one of the pages to allocate the memcpy() trampoline and the actual 
> data structures used for the copy, for example. Use the rest for the 
> actual kernel data.
> 
> Keep it simple. 

Yep.  

After loading everything I have a total of 243 lines of code.
100 lines of assembly doing the copies in the trampoline.
143 lines of C modifying the page tables, the gdt, and the idt,
copying the trampoline to the correct place, and going for it.

And despite my utter puzzlement on why you want the syscall cut in two.
I will now go cut along the dotted line.  If that is all it takes to
have piece I can do that.  A sore head from all of the scratching
trying to figure out why it needs to be cut in two, but I can cut
sys_kexec in two.

Eric
