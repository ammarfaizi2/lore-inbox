Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270174AbRHROPX>; Sat, 18 Aug 2001 10:15:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270178AbRHROPN>; Sat, 18 Aug 2001 10:15:13 -0400
Received: from [62.70.89.10] ([62.70.89.10]:5638 "EHLO elin.scali.no")
	by vger.kernel.org with ESMTP id <S270174AbRHROPJ>;
	Sat, 18 Aug 2001 10:15:09 -0400
Date: Sat, 18 Aug 2001 16:15:17 +0200 (CEST)
From: Terje Eggestad <te@scali.no>
To: <michael@optusnet.com.au>
cc: Terje Eggestad <terje.eggestad@scali.no>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] processes with shared vm
In-Reply-To: <m1y9oic1ou.fsf@mo.optusnet.com.au>
Message-ID: <Pine.LNX.4.30.0108181530030.6444-100000@elin.scali.no>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 17 Aug 2001 michael@optusnet.com.au wrote:

>
>
> Why not just print out the address of the 'mm_struct'?
>
> That lets 'ps' treat the address as a cookie, and
> thus count the number of occurences of each vm.
>
> This has the additional advantages of:
>
> * moving the intelligence out to the app
> * reducing the kernel size, and
> * make it easy to find out exactly which processes
> are using which vm. (you just search for all occurences
> of the cookie).
>
> Michael.
>

Not a bad idea, One reason is that I've an inate distrust of using
addresses as anything remotely useful. BTW, do you want the tag in hex or
dec??
keep in mind 32 and  64 bit machines, it must actually be a 64 bit!

What I really wanted was a list of pids of the clones.
ps/top/gtop could then use it as an exclude list for futher processing...
Trouble is that returning more than 4kb in a file in proc is a pain,
and there is no guarantee that someone make will not a 1000 clones.
ref the recent problem with maps exceeding 4kb.

(I might be paranoid, you get ~170 (1024/6) pids in 1kb, assuming 16bit
pid.

using the lowest pid seems a good compromise.

I still think the overhead is neglible.
What's the upper practial limit of procs ~64k? (more like 4k.)
How many instructions to tranvers the task list and test mm_struct
pointer for equality? O(10) per task.? assuming all clones we're talking
about ~650k instructions, and with 100mips machines (with 64k task, that's
slow1) thats 1/200 second overhead every time you do cat
/proc/[0-9]*/status. I can live with that.


But I guess I can live with using the address.....

>
> Terje Eggestad <terje.eggestad@scali.no> writes:
> > --=-L6iLOYILsDzljNLIi035
> > Content-Type: text/plain
> > Content-Transfer-Encoding: 7bit
> > --- array.c.orig	Mon Mar 19 21:34:55 2001
> > +++ array.c	Thu Aug 16 16:33:56 2001
> > @@ -50,6 +50,12 @@
> >   * Al Viro & Jeff Garzik :  moved most of the thing into base.c and
> >   *			 :  proc_misc.c. The rest may eventually go into
> >   *			 :  base.c too.
> > + *
> > + * Terje Eggestad    :  added in /proc/<pid>/status a VmClones: n
> > + *                   :  that tells how many proc that uses the same VM (mm_struct).
> > + *                   :  if there are clones add another field VmFirstClone with the
> > + *                   :  clone with the lowest pid. Needed for things like gtop that adds
> > + *                   :  mem usage of groups of proc, or else they add up the usage of threads.
> >   */
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

-- 
_________________________________________________________________________

Terje Eggestad                  terje.eggestad@scali.no
Scali Scalable Linux Systems    http://www.scali.com

Olaf Helsets Vei 6              tel:    +47 22 62 89 61 (OFFICE)
P.O.Box 70 Bogerud                      +47 975 31 574  (MOBILE)
N-0621 Oslo                     fax:    +47 22 62 89 51
NORWAY
_________________________________________________________________________

