Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262284AbTCUBIR>; Thu, 20 Mar 2003 20:08:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262642AbTCUBIR>; Thu, 20 Mar 2003 20:08:17 -0500
Received: from tux.rsn.bth.se ([194.47.143.135]:39573 "EHLO tux.rsn.bth.se")
	by vger.kernel.org with ESMTP id <S262284AbTCUBIP>;
	Thu, 20 Mar 2003 20:08:15 -0500
Subject: Re: An oops while running 2.5.65-mm2
From: Martin Josefsson <gandalf@wlug.westbo.se>
To: Andrew Morton <akpm@digeo.com>
Cc: jjs <jjs@tmsusa.com>, linux-kernel@vger.kernel.org,
       Netfilter-devel <netfilter-devel@lists.netfilter.org>
In-Reply-To: <20030320122931.0d2f208f.akpm@digeo.com>
References: <3E7A1ABF.7050402@tmsusa.com>
	 <20030320122931.0d2f208f.akpm@digeo.com>
Content-Type: multipart/mixed; boundary="=-JUU4Yu8ouguPdwnGBvCa"
Organization: 
Message-Id: <1048209554.1103.21.camel@tux.rsn.bth.se>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 21 Mar 2003 02:19:14 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-JUU4Yu8ouguPdwnGBvCa
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, 2003-03-20 at 21:29, Andrew Morton wrote:
> jjs <jjs@tmsusa.com> wrote:
> >
> > Greetings -
> > 
> > Here is some info about an oops from 2.5.65-mm2
> 
> It is not exactly an oops, but it is a warning of a fatal bug.

This might explain the crashes I've seen in my routers but been unable
to capture so far (and without the extra slab debugging I don't know if
I would have been able to find it or even get a decent capture...)

Patch attached that should fix the problem, not tested or even compiled.

Joe, can you please please test it and report back?

> Look at this lovely trace:

> Mar 20 11:06:46 jyro kernel: Slab corruption: start=ceaa2234, expend=ceaa2377, problemat=ceaa22ac
> Mar 20 11:06:46 jyro kernel: Last user: [<e0a12cb0>](destroy_conntrack+0xd0/0x140 [ip_conntrack])
> Mar 20 11:06:46 jyro kernel: Data: ************************************************************************************************************************AC 22 AA CE AC 22 AA CE ***************************************************************************************************************************************************************************************************A5 
> Mar 20 11:06:46 jyro kernel: Next: 71 F0 2C .B0 2C A1 E0 71 F0 2C .********************
> Mar 20 11:06:46 jyro kernel: slab error in check_poison_obj(): cache `ip_conntrack': object was modified after freeing

> Looking at the data pattern, it is probably an INIT_LIST_HEAD() against a
> list_head field which is 120 bytes into the object.  (problemat - start).  Or
> a list_del() against a different object which erroneously remains on a list
> with this object.

You are correct. It was a list_del() that caused it (at least I think
so, it's 2am right now).

1. conntrack helper adds an expectation and adds that to a list hanging
of off a connection.

2. the expected connection arrives. the expectation is still on the
list.

3. the original connection that caused the expectation terminates but
the expectation still thinks it's added to the list.

4. the expected connection terminates and list_del() is called to remove
it from the list which doesn't exist anymore. boom!

> Manfred has extra toys in the works which will be able to unmap slab objects
> from the kernel virtual address space when they are freed.  When this debug
> code is working (it will run slowly) we will get an oops at the site of the
> bug.

This will be a nice feature, might make it easier to find the bugs.
Too bad it can't help work out the relationship between structs... I had
to use pen and paper to work out the relationship between connections
and expectations :) That part is almost a little bit hairy.

-- 
/Martin

Never argue with an idiot. They drag you down to their level, then beat you with experience.

--=-JUU4Yu8ouguPdwnGBvCa
Content-Disposition: attachment; filename=ip_conntrack-siblingfix.diff
Content-Type: text/plain; name=ip_conntrack-siblingfix.diff; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

--- linux-2.5.64-bk10/net/ipv4/netfilter/ip_conntrack_core.c.orig	2003-03-2=
1 01:42:57.000000000 +0100
+++ linux-2.5.64-bk10/net/ipv4/netfilter/ip_conntrack_core.c	2003-03-21 01:=
44:11.000000000 +0100
@@ -274,6 +274,7 @@
 		 * the un-established ones only */
 		if (exp->sibling) {
 			DEBUGP("remove_expectations: skipping established %p of %p\n", exp->sib=
ling, ct);
+			exp->sibling =3D NULL;
 			continue;
 		}
=20
@@ -327,9 +328,11 @@
 	WRITE_LOCK(&ip_conntrack_lock);
 	/* Delete our master expectation */
 	if (ct->master) {
-		/* can't call __unexpect_related here,
-		 * since it would screw up expect_list */
-		list_del(&ct->master->expected_list);
+		if (ct->master->sibling) {
+			/* can't call __unexpect_related here,
+			 * since it would screw up expect_list */
+			list_del(&ct->master->expected_list);
+		}
 		kfree(ct->master);
 	}
 	WRITE_UNLOCK(&ip_conntrack_lock);

--=-JUU4Yu8ouguPdwnGBvCa--
