Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261736AbTILPHk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 11:07:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261735AbTILPHW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 11:07:22 -0400
Received: from adsl-68-72-9-97.dsl.klmzmi.ameritech.net ([68.72.9.97]:7043
	"EHLO tabriel.tabris.net") by vger.kernel.org with ESMTP
	id S261734AbTILPHK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 11:07:10 -0400
From: Tabris <tabris@tabris.net>
To: Tim Schmielau <tim@physik3.uni-rostock.de>
Subject: Re: Jiffies_64 for 2.4.22-ac
Date: Fri, 12 Sep 2003 11:07:03 -0400
User-Agent: KMail/1.5.3
Cc: lkml <linux-kernel@vger.kernel.org>, <bero@arklinux.org>,
       <saint@arklinux.org>, Alan Cox <alan@redhat.com>
References: <Pine.LNX.4.33.0309121541180.21331-100000@gans.physik3.uni-rostock.de>
In-Reply-To: <Pine.LNX.4.33.0309121541180.21331-100000@gans.physik3.uni-rostock.de>
MIME-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200309121107.06021.tabris@tabris.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Friday 12 September 2003 10:00 am, Tim Schmielau wrote:
> On Fri, 12 Sep 2003, Tabris wrote:
> > I took Tim Schmielau's jiffies_64 patch, and ported it to -ac
> >
> > currently running on my machine here.
> > comments? did i screw up horribly?
>
> see my comments below:
> > +#define get_uidle_64()    
> > get_64bits(&(init_tasks[0]->times.tms_utime),\ +                     
> >                 &uidle_msb_flips)
> > +#define get_sidle_64()    
> > get_64bits(&(init_tasks[0]->times.tms_stime),\ +                     
> >                 &sidle_msb_flips)
>
> for -ac this needs to be
>
> +#define get_uidle_64()     get_64bits(&(init_task.times.tms_utime),\
> +                                      &uidle_msb_flips)
> +#define get_sidle_64()     get_64bits(&(init_task.times.tms_stime),\
> +                                      &sidle_msb_flips)
>
> > +	check_one(init_tasks[0]->times.tms_utime, &uidle_msb_flips);
> > +	check_one(init_tasks[0]->times.tms_stime, &sidle_msb_flips);
>
> ditto
>
>
> +#define get_uidle_64()     (init_tasks[0]->times.tms_utime)
> +#define get_sidle_64()     (init_tasks[0]->times.tms_stime)
>
> ditto
>
> > -	unsigned long uptime;
> > -	unsigned long idle;
> > +	u64 uptime, idle;
> >  	int len;
>
> the declaration
> 	unsigned long uptime_remainder, idle_remainder;
> is missing
>
> >  #if HZ!=100
> >  	len = sprintf(page,"%lu.%02lu %lu.%02lu\n",
> > -		uptime / HZ,
> > -		(((uptime % HZ) * 100) / HZ) % 100,
> > -		idle / HZ,
> > -		(((idle % HZ) * 100) / HZ) % 100);
> > +		(unsigned long) uptime,
> > +		uptime_remainder,
> > +		(unsigned long) idle / HZ,
> > +		idle_remainder);
>
> since we're in the HZ!=100 branch, this needs to be
>
> +               (uptime_remainder * 100) / HZ,
> +               (unsigned long) idle,
> +               (idle_remainder * 100) / HZ);
>
>
>
> I wonder it actually compiled, but otherwise it looks good.
>
> Tim
>
oops.
yeah, i merged it originally against a different tree... that patch didn't 
apply against 2.4.22-ac
and i forgot to compile test it since i was too tired.

updated/fixed patch later today.

- --
tabris
- -
	"...A strange enigma is man!"
	"Someone calls him a soul concealed in an animal," I suggested.
	"Winwood Reade is good upon the subject," said Holmes.  "He remarked
that, while the individual man is an insoluble puzzle, in the aggregate he
becomes a mathematical certainty.  You can, for example, never foretell 
what any one man will do, but you can say with precision what an average 
number will be up to.  Individuals vary, but percentages remain constant.  
So says the statistician."
		-- Sherlock Holmes, "The Sign of Four"
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/YeEYtTgrITXtL+8RAm6zAJ93ljgW0p70fgrrjvhu52Dod+fOawCcCLjc
Ns6HWVXlCbIHWf8t2FB9BzI=
=ya6P
-----END PGP SIGNATURE-----

