Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310397AbSCBQLQ>; Sat, 2 Mar 2002 11:11:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310398AbSCBQLH>; Sat, 2 Mar 2002 11:11:07 -0500
Received: from ja.mac.ssi.bg ([212.95.166.194]:15878 "EHLO u.domain.uli")
	by vger.kernel.org with ESMTP id <S310397AbSCBQLA>;
	Sat, 2 Mar 2002 11:11:00 -0500
Date: Sat, 2 Mar 2002 18:10:50 +0000 (GMT)
From: Julian Anastasov <ja@ssi.bg>
X-X-Sender: ja@u.domain.uli
To: kuznet@ms2.inr.ac.ru
cc: kain@kain.org, <linux-kernel@vger.kernel.org>, <ak@suse.de>
Subject: Re: OOPS: Multipath routing 2.4.17
In-Reply-To: <200203021436.RAA20557@ms2.inr.ac.ru>
Message-ID: <Pine.LNX.4.44.0203021730110.5003-100000@u.domain.uli>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	Hello,

On Sat, 2 Mar 2002 kuznet@ms2.inr.ac.ru wrote:

> > 	What about the new scheduler (for 2.5?), of course, after
> > replacing the wrong write_lock() with spin_lock_bh(&fib_nh_powers) ?
>
> I do not see any reasons not to do this.
> I remember your approach had some inacceptable issues, but 2.5 is exactly
> the place to resolve them. :-)
>
> But actually I would like to see a fix for 2.4 for beginning.

	OK, I'll try it soon, I assume you ack about the
new fib_select_multipath scheduler discussed in this thread.

> The failure with orphaned DEADs was hard bug yet. Minute...
> I remember I did some work to make a minimalistic fix...

	Yep, I'm wondering, nobody complains about this problem :)
May be it is still not too late to fix it :)

> Aha! That's it. Please, look at this _carefully_. It is going
> to be submitted to 2.4 and mistakes are not allowed here.
> Look especially at the differences of your approach both about
> medium_id and DEAD fault.

	I see, very good, you restore the nh_dev on "enable IP"
which is detroyed on "disable IP".

About medium_id, I didn't tested your variant but I see what you mean:
proxy_arp must be enabled for the receiver, distinguish 0/-1.
Sounds good, looks good, only doc changes:

- change "media" to "medium"

- docs in Documentation/filesystems/proc.txt or the net part
is going out from this file?

	About the FIB changes, check fib_sync_down because I see a
bad scenario, i.e. change:

if (force && nh->nh_dev) {

to

if (force && nh->nh_dev == dev && nh->nh_flags&RTNH_F_DEAD) {

and move it before endfor_nexthops because we can miss the
following sequence of events:

- enable IP
- link up
...
- link down => nh is DEAD after force=0 but with valid nh_dev!=NULL

and we come here with the new change:

- disable IP/unreg with force=1 => we miss the above event and
don't clear nh_dev

In short, nh can be already DEAD with nh_dev!=NULL and we miss it when
force is 1.

So, the new code must be something like this:

				}
+				if (force && nh->nh_dev == dev &&
+				    nh->nh_flags&RTNH_F_DEAD) {
+					dev_put(nh->nh_dev);
+					nh->nh_dev = NULL;
+				}
			} endfor_nexthops(fi)

	There is a second variant: we to keep all DEAD nhs to be with
nh_dev==NULL but I'm not sure about it. At least, you already added
a mechanism the nexthops to bind again to outdev and this can work,
may be. But I prefer the first solution after fixing.

> Alexey

> +	two devices attached to different media.

medium

Regards

--
Julian Anastasov <ja@ssi.bg>

