Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130308AbQKFIGg>; Mon, 6 Nov 2000 03:06:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130289AbQKFIG0>; Mon, 6 Nov 2000 03:06:26 -0500
Received: from smtp3.mail.yahoo.com ([128.11.68.135]:47883 "HELO
	smtp1b.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S129663AbQKFIGO>; Mon, 6 Nov 2000 03:06:14 -0500
X-Apparently-From: <p?gortmaker@yahoo.com>
Message-ID: <3A06155C.796995DD@yahoo.com>
Date: Sun, 05 Nov 2000 21:20:12 -0500
From: Paul Gortmaker <p_gortmaker@yahoo.com>
X-Mailer: Mozilla 3.04 (X11; I; Linux 2.2.17 i486)
MIME-Version: 1.0
To: Andrew Morton <andrewm@uow.edu.au>
CC: Keith Owens <kaos@ocs.com.au>, Andi Kleen <ak@suse.de>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        "Hen, Shmulik" <shmulik.hen@intel.com>,
        "'LKML'" <linux-kernel@vger.kernel.org>,
        "'LNML'" <linux-net@vger.kernel.org>
Subject: Re: Locking Between User Context and Soft IRQs in 2.4.0
In-Reply-To: Your message of "Sun, 05 Nov 2000 14:39:43 +1100."
		             <9277.973395583@ocs3.ocs-net> <9368.973396061@ocs3.ocs-net> <3A054872.8D88EF95@uow.edu.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

> y'know, if we keep working this patch for about a year we
> might end up getting it right.  Thousand monkeys and all that.

Yeah, probably still a year until the release of 2.4.0.  8)
Now where did I put those darn bananas...

> - With this patch applied, the module refcounts for netdevices
>   will show doubled values in `lsmod', unless those drivers
>   have been changed to remove the now unneeded MOD_INC/DEC_USE_COUNT
>   macros (perhaps with the above 2.2-compatibility thing).

Assuming that nobody has all the MOD_..._USE_COUNT things culled
from a tree somewhere already, I quickly hacked up the following
script for drivers/net:

----------------
#!/bin/bash
for i in `grep -l 'MOD_..._USE_COUNT;' *.c */*.c`
do
  mv $i $i~
  cat $i~ | \
  sed '/^$/{N;s/.*MOD.*COUNT;//;tz;b;:z;N;s/^\n$//;};/.*MOD.*COUNT;/d' > $i
done
----------------

It looks ugly but it zaps out the extra blank line when MOD_.*COUNT
had a blank line above and below.  I had a quick look at the resulting
diff (4200 lines!) and it looks like the post-script hand editing will
be minimal (e.g. a few arcnet drivers have MOD_*_COUNT as the only code
in an if block).

We might want to filter the file list created by grep against VERSION_CODE
as people with that in their driver(s) probably don't want the wholesale
deletion of MOD_*_COUNT. (OTOH, drivers that have VERSION_CODE that
supports 2.0.38 or oddball 2.3.x versions could probably be pruned...)

That still leaves the addition of dev->owner = THIS_MODULE into
each device probe.  One *hackish* way to do this without having to
deal with each driver could be something like this in netdevice.h

- extern void ether_setup(struct net_device *dev);
+ extern void __ether_setup(struct net_device *dev);
+ static inline void ether_setup(struct net_device *dev){
+	dev->owner = THIS_MODULE; 	
+	__ether_setup(dev);
+ }

Ugh. Probably should just add it to each probe and be done with it...

Paul. (aka. monkey #937)



_________________________________________________________
Do You Yahoo!?
Get your free @yahoo.com address at http://mail.yahoo.com

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
