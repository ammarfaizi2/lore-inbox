Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277073AbRJHTJI>; Mon, 8 Oct 2001 15:09:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277074AbRJHTI7>; Mon, 8 Oct 2001 15:08:59 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:4852 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S277073AbRJHTIs>; Mon, 8 Oct 2001 15:08:48 -0400
Message-ID: <3BC1F7D6.E84D617B@mvista.com>
Date: Mon, 08 Oct 2001 12:00:38 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Georg Nikodym <georgn@somanetworks.com>
CC: Pantelis Antoniou <panto@intracom.gr>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Standard way of generating assembler offsets
In-Reply-To: <28136.1002196028@ocs3.intra.ocs.com.au>
		<3BC1735F.41CBF5C1@intracom.gr>  <3BC1E294.1A4FB12D@mvista.com> <1002563771.21079.3.camel@keller>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Georg Nikodym wrote:
> 
> At the risk of sticking my foot in it, is there something wrong with the
> ANSI C offsetof() macro, defined in <stddef.h>?
> 
> --Georg
No, and it could have been (and was) written prio to ANSI C defining
it.  Something like:

#define offsetof(x, instruct) &((struct instruct *)0)->x

The issues that CPP resolves have to deal with the following sort of
structure:

struct instruct {
	struct foo * bar;
#ifdef CONFIG_OPTION_DIDDLE
	int diddle_flag;
	int diddle_array[CONFIG_DIDDLE_SIZE];
#endif
	int x;
}

Or for the simple need for a constant:

#define Const (CONFIG_DIDDLE_SIZE * sizeof(int))

Of course you could have any number of constant operators in the
expression.  Note also, that the array in the structure above is defined
by a CONFIG symbol.  This could also involve math, i.e.:

#define CONFIG_DIDDLE_SIZE CLOCK_RATE / HZ

and so on.  All in all, it best to let CPP do what it does best and
scarf up the result:

#define GENERATE_CONSTANT(name,c) printf(#name " equ %d\n",c)

then:

GENERATE_CONSTANT(diddle_size,CONFIG_DIDDLE_SIZE);

In the code we did, we put all the GENERATE macros in a .h file.  The
the code looked like:

#include.... all the headers needed....

#include <generate.h>

GENERATE....  all the generate macro calls...

} // all done (assumes that the "main(){" is in the generate.h file)

This whole mess was included as comments in the asm file.  The make rule
then used a sed script to extract it, compile and run it to produce a
new header file which the asm source included outside of the above
stuff.

George
