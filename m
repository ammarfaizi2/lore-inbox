Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293151AbSBWQLP>; Sat, 23 Feb 2002 11:11:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293152AbSBWQLG>; Sat, 23 Feb 2002 11:11:06 -0500
Received: from mail.gmx.net ([213.165.64.20]:62541 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S293151AbSBWQKx>;
	Sat, 23 Feb 2002 11:10:53 -0500
Subject: Re: [RFC] [PATCH] C exceptions in kernel
From: Dan Aloni <da-x@gmx.net>
To: bert hubert <ahu@ds9a.nl>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20020223162100.A1952@outpost.ds9a.nl>
In-Reply-To: <1014412325.1074.36.camel@callisto.yi.org> 
	<20020223162100.A1952@outpost.ds9a.nl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 23 Feb 2002 18:05:48 +0200
Message-Id: <1014480355.1844.16.camel@callisto.yi.org>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-02-23 at 17:21, bert hubert wrote:
> On Fri, Feb 22, 2002 at 09:18:29PM +0000, Dan Aloni wrote:
> > The attached patch implements C exceptions in the kernel, which *don't*
> > depend on special support from the compiler. This is a 'request for
> > comments'. The patch is very initial, should not be applied.
> > 
> > I actually got this code to work in the kernel:
> > 
> >         try {
> >                 printk("TEST: before throwing \n");
> >                 throw(1000);
> >                 printk("TEST: won't run\n");
> >         }
> >         catch(unsigned long, value) {
> >                 printk("TEST: caught: %ld\n", value);
> >         } yrt;
> 
> Can they fall through multiple function calls? How do they jive with
> preemtive scheduling? How much is the stack unwinding overhead?

They fall through several function calls like they should.

I don't see any problem with preemtive scheduling (every kernel thread
has its own seperated exception frames). 

The overhead on the stack is 36 bytes for each exception frame (a
context of a try block). The unwinding procedure itself is short, the
throw macro calls a rather small asm function for an unwind.

> Potentially this is very cool but I'm again appalled at the INSTANT
> rejection seen here by kernel hackers, minor and major. Do NOT reject an
> idea before you've thought it through. Do NOT reject an idea simply because
> it is new.
 
> Also, do not jump on the bandwagon BECAUSE it is new. But still - people
> here should get a life if they get off on rejecting new stuff because it is
> new.

Whether it is accepted or not, I can't see it being used in the core
kernel code, just because there is too much code to rewrite for it to
happen. Maybe if this thing was proposed back in 1992/3 it would have
been different.

But, it CAN be used in *local* driver call branches. Writing a new
driver? have a lot of local nested calls? Hate goto's? You can use
exceptions.

The only problem is that because C is natively not object oriented, it's
hard to come up with an exception scheme for the C language that is
better than ye' old goto's, like in C++ when you have automatic
destruction during unwinding.

