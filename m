Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292846AbSCAW2N>; Fri, 1 Mar 2002 17:28:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292879AbSCAW2E>; Fri, 1 Mar 2002 17:28:04 -0500
Received: from ja.mac.ssi.bg ([212.95.166.194]:32004 "EHLO u.domain.uli")
	by vger.kernel.org with ESMTP id <S292846AbSCAW17>;
	Fri, 1 Mar 2002 17:27:59 -0500
Date: Sat, 2 Mar 2002 00:27:40 +0000 (GMT)
From: Julian Anastasov <ja@ssi.bg>
X-X-Sender: ja@u.domain.uli
To: Kain <kain@kain.org>
cc: linux-kernel <linux-kernel@vger.kernel.org>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, Andi Kleen <ak@suse.de>
Subject: Re: OOPS: Multipath routing 2.4.17
Message-ID: <Pine.LNX.4.44.0203012316120.1420-100000@u.domain.uli>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	Hello,

Kain wrote:

> impossible 888
> divide error: 0000

> > > EIP; c024c5ea <fib_select_multipath+5a/a0>   <=====
> Trace; c02232e8 <ip_route_output_slow+318/670>

	There is no write locking in fib_select_multipath,
combined with high rate of route resolutions and ... boom,
fi->fib_power is 0:

w = jiffies % fi->fib_power;

	What about a different algorithm to apply weighted
round robin (idea mostly from LVS), something like
this code (entirely not tested) where fi->fib_power is not used
and where fib_sync_up and fib_sync_down don't need to play
with nh_power on nh_flags change:

void fib_select_multipath(const struct rt_key *key, struct fib_result *res)
{
	struct fib_info *fi = res->fi;
	int w = -1, sel = 0;

	write_lock(&fib_info_lock);

	repeat:

	change_nexthops(fi) {
		if (nh->nh_power > w && !(nh->nh_flags&RTNH_F_DEAD)) {
			w = nh->nh_power;
			sel = nhsel;
		}
	} endfor_nexthops(fi);
	if (w > 0) {
		fi->fib_nh[sel].nh_power--;
		write_unlock(&fib_info_lock);
		res->nh_sel = sel;
		return;
	}

	if (!w) {
		change_nexthops(fi) {
			if (!(nh->nh_flags&RTNH_F_DEAD)) {
				nh->nh_power = nh->nh_weight;
			}
		} endfor_nexthops(fi);
		w = -1;
		goto repeat;
	}

	write_unlock(&fib_info_lock);

#if 1
	printk(KERN_CRIT "impossible 888\n");
#endif
	return;
}

Regards

--
Julian Anastasov <ja@ssi.bg>

