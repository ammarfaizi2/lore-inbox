Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262808AbSKIX1m>; Sat, 9 Nov 2002 18:27:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262815AbSKIX1m>; Sat, 9 Nov 2002 18:27:42 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:58638 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262808AbSKIX1k>; Sat, 9 Nov 2002 18:27:40 -0500
Date: Sat, 9 Nov 2002 15:33:48 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Werner Almesberger <wa@almesberger.net>,
       Suparna Bhattacharya <suparna@in.ibm.com>,
       Jeff Garzik <jgarzik@pobox.com>,
       "Matt D. Robinson" <yakker@aparity.com>,
       Rusty Russell <rusty@rustcorp.com.au>, Andy Pfiffer <andyp@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Mike Galbraith <efault@gmx.de>,
       "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
       <lkcd-general@lists.sourceforge.net>,
       <lkcd-devel@lists.sourceforge.net>
Subject: Re: [lkcd-devel] Re: What's left over.
In-Reply-To: <m1u1iqcpjg.fsf@frodo.biederman.org>
Message-ID: <Pine.LNX.4.44.0211091510060.1571-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 9 Nov 2002, Eric W. Biederman wrote:
> 
> Currently my code handles starting a new kernel under normal operating
> conditions.  There are currently two ways I can implement a clean user
> space shutdown with out needing locked buffers in the kernel until the
> very last moment.

PLEASE tell me why you don't just use the 20-line "vmalloc()" function I 
already wrote for you?

It works for all cases - and since you do need to load the kernel into 
memory anyway, it's not using any more memory than your existing code. And 
it's infinitely more flexible to have a clearly separated load-process, 
than having to have some load happen at reboot time (whether by init or by 
anything else).

And since the kernel is fully working at the load time, you can even do
things like swap out pages in order to make room for the kernel at the 
right place.  So you can even do something like this:

	int alloc_kernel_pages(unsigned long *array, int nr_pages,
		unsigned long min_address)
	{
		void *bad_page_list = NULL;
		int i = 0, retval;

		while (i < nr_pages) {
			unsigned long page = __get_free_page(GFP_USER);

			if (!page)
				goto oom;

			if (page < min_address) {
				*(void **)page = bad_page_list;
				bad_page_list = (void *)page;
				continue;
			}
			array[i] = page;
			i++;
		}
		retval = 0;
	out:
		while (bad_page_list) {
			unsigned long page = (unsigned long) bad_page_list;
			bad_page_list = *(void **)bad_page_list;
			free_page(page);
		}
		return retval;
	oom:
		while (i > 0)
			free_page(array[--i]);
		retval = -ENOMEM;
		goto out;
	}

and now you are guaranteed that all the allocated pages are above a
certain mark (change the "min_address" to be a "validity callback" or
whatever if you want to be fancy and allow arbitrary rules, which is good
if you want to allow pages in the low 1M on x86, for example), which means
that your final reboot stage is _much_much_ simpler and you don't ever 
have to worry about overlap. 

Use one of the pages to allocate the memcpy() trampoline and the actual 
data structures used for the copy, for example. Use the rest for the 
actual kernel data.

Keep it simple. 

			Linus

