Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268119AbUJOP6M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268119AbUJOP6M (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 11:58:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268092AbUJOP6L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 11:58:11 -0400
Received: from fw.osdl.org ([65.172.181.6]:21227 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268104AbUJOP4k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 11:56:40 -0400
Date: Fri, 15 Oct 2004 08:56:32 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Pavel Machek <pavel@ucw.cz>
cc: Paul Mackerras <paulus@samba.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, David Brownell <david-b@pacbell.net>
Subject: Re: Totally broken PCI PM calls
In-Reply-To: <20041015135955.GD2015@elf.ucw.cz>
Message-ID: <Pine.LNX.4.58.0410150839010.3897@ppc970.osdl.org>
References: <1097455528.25489.9.camel@gaston> <Pine.LNX.4.58.0410101937100.3897@ppc970.osdl.org>
 <16746.299.189583.506818@cargo.ozlabs.ibm.com> <Pine.LNX.4.58.0410102115410.3897@ppc970.osdl.org>
 <20041011101824.GC26677@atrey.karlin.mff.cuni.cz>
 <Pine.LNX.4.58.0410110857180.3897@ppc970.osdl.org> <20041015135955.GD2015@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 15 Oct 2004, Pavel Machek wrote:
> 
> I'm trying to learn how to work with bitwise on obsolete stuff, but
> checking there is good, too, right?
> 
> Is this right way to do it?
> 
> +typedef enum pm_request __bitwise {
> +       __bitwise PM_SUSPEND, /* enter D1-D3 */
> +       __bitwise PM_RESUME,  /* enter D0 */
> +} pm_request_t;

No, "__bitwise" is a type attribute, so you'd have to do it something like 
this:

	typedef int __bitwise pm_request_t;

	enum pm_request {
		PM_SUSPEND = (__force pm_request_t) 1,
		PM_RESUME = (__force pm_request_t) 2
	};

which makes PM_SUSPEND and PM_RESUME "bitwise" integers (the "__force" is 
there because sparse will complain about casting to/from a bitwise type, 
but in this case we really _do_ want to force the conversion). And because 
the enum values are all the same type, now "enum pm_request" will be that 
type too.

And with gcc, all the __bitwise/__force stuff goes away, and it all ends 
up looking just like integers to gcc.

Quite frankly, you don't need the enum there. The above all really just 
boils down to one special "int __bitwise" type.

So the simpler way is to just do

	typedef int __bitwise pm_request_t;

	#define PM_SUSPEND ((__force pm_request_t) 1)
	#define PM_RESUME ((__force pm_request_t) 2)

and you now have all the infrastructure needed for strict typechecking. 

One small note: the constant integer "0" is special. You can use a 
constant zero as a bitwise integer type without sparse ever complaining. 
This is because "bitwise" (as the name implies) was designed for making 
sure that bitwise types don't get mixed up (little-endian vs big-endian 
vs cpu-endian vs whatever), and there the constant "0" really _is_ 
special. 

Also, because of the "bitwise" nature of bitwise types, you cannot add, 
subtract or do a lot of things with bitwise types. But you _can_ use the 
bitwise operations on them, and you can test them for equality.

So at some point we might add a separate "__opaque" type that allows no
operations at all (except for assignment and equality comparison), and
where "0" isn't special. But in the meantime, __bitwise gets you most of 
the way. Just keep in mind that sparse won't warn about use of the 
constant zero.

> Having __bitwise at every line in enum looks quite ugly to my
> eyes.

And in fact you cannot do it that way. "__bitwise" will always create a
_new_ type, so every time you use it you get a _different_ type. So to use
it sanely, you have to create _one_ typedef for each type you want to use, 
and make that one __bitwise, and that will be the only __bitwise that 
you'll ever see for that particular usage. After that, you use the 
typedef, because it is now a unique type, thanks to the __bitwise.

>	 [Where to get sparse? I tried to google for it but "sparse" is
> very common word (as in sparse matrix). And theres no
> kernel/people/linus on kernel.org...]

With BK, you can just get it from

	bk://sparse.bkbits.net/sparse

and I think DaveJ does tar-balls somewhere. If you search for "sparse 
checker linux" you'll find a number of hits..

Once you have it, just do

	make
	make install

as your regular user, and it will install sparse in your ~/bin directory. 
After that, doing a kernel make with "make C=1" will run sparse on all the 
C files that get recompiled, or with "make C=2" will run sparse on the 
files whether they need to be recompiled or not (ie the latter is fast way 
to check the whole tree if you have already built it).

		Linus
