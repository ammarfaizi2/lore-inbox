Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129610AbRAKMcm>; Thu, 11 Jan 2001 07:32:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129842AbRAKMcb>; Thu, 11 Jan 2001 07:32:31 -0500
Received: from [172.16.18.67] ([172.16.18.67]:65408 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S129610AbRAKMcX>; Thu, 11 Jan 2001 07:32:23 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <16427.979215125@ocs3.ocs-net> 
In-Reply-To: <16427.979215125@ocs3.ocs-net> 
To: Keith Owens <kaos@ocs.com.au>
Cc: Antony Suter <antony@mira.net>,
        List Linux-Kernel <linux-kernel@vger.kernel.org>,
        Allen Unueco <allen@premierweb.com>
Subject: Re: Where did vm_operations_struct->unmap in 2.4.0 go? 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 11 Jan 2001 12:32:10 +0000
Message-ID: <12129.979216330@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


kaos@ocs.com.au said:
>  Q. With your suggested static method, what happens when Y initialises
>    before X, calls inter_module_get, retrieves X's static data and
>    starts to use it before X has initialised? 
> A. Oops!

No. You'd explicitly only use the static registration when object X doesn't 
_need_ initialisation, which is the case for my code.

As it is, I've had to add completely now init routines for 
modules which didn't have them before, and all those init routines do is 
inter_module_register() and pray that they're called in time.


kaos@ocs.com.au said:
>  The whole point of registration methods is that the owner of the data
> decides when they are ready to provide the service.  Ensuring that
> code is initialised in the correct order, with providers starting
> before consumers, is a fact of life.

I have decided when I'm ready to provide the service. At compile time. 
Ensuring that the code is initialised in the correct order is not a fact of 
life. It's an artifact of the limited functionality of the new setup.


kaos@ocs.com.au said:
> It would be much nicer to define ordering sets.  Code in driver foo
> needs the code in driver bar to initialise first.  cfi_probe cannot
> initialise until cfi_cmdset_0001 and cfi_cmdset_0002 have initialised.
> Declare it that way so it is clear what is going on and why, instead
> of being implied by the Makefile order via three layers of
> indirection.

For cases where the code really does need initialisation, that is true. It 
should be done properly rather than just implicitly ordered by the 
Makefile. But in this case, the command set drivers don't need 
initialisation. They just provide a function for use by the generic CFI 
init code. They don't _need_ to initialise themselves beforehand.

The dynamic registration has introduced this ordering dependency when 
previously there was none.


>  The problem is, Linus likes the current method. 

Then he either hasn't considered this particular case, or he's wrong. It 
happens. I'm not suggesting that we change it drastically, only that we add 
the option of static (compile-time) registration for those entries which 
require it. 

Actually, I'd rather do this with weak symbols. Something along the lines 
of...

 extern cfi_cmdset_fn_t cfi_cmdset_0001 __attribute__((weak));
 extern cfi_cmdset_fn_t cfi_cmdset_0002 __attribute__((weak));


 ...
	
 if (cfi_cmdset_0001 && chip_is_type_1())
	return cfi_cmdset_0001(args...);
 if (cfi_cmdset_0002 && chip_is_type_2())
	return cfi_cmdset_0002(args...);

 return cfi_cmdset_load_module(args...)

Unfortunately, I couldn't get it to work reliably on anything but x86. 




--
dwmw2


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
