Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267444AbTBUOPI>; Fri, 21 Feb 2003 09:15:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267445AbTBUOPI>; Fri, 21 Feb 2003 09:15:08 -0500
Received: from rumms.uni-mannheim.de ([134.155.50.52]:10482 "EHLO
	rumms.uni-mannheim.de") by vger.kernel.org with ESMTP
	id <S267444AbTBUOPG>; Fri, 21 Feb 2003 09:15:06 -0500
From: Thomas Schlichter <schlicht@uni-mannheim.de>
To: Dave Jones <davej@codemonkey.org.uk>
Subject: Re: [PATCH][2.5] replace flush_map() in arch/i386/mm/pageattr.c w ith flush_tlb_all()
Date: Fri, 21 Feb 2003 15:25:01 +0100
User-Agent: KMail/1.5
Cc: Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@digeo.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0302211217390.1531-100000@localhost.localdomain> <200302211342.19007.schlicht@uni-mannheim.de> <20030221142039.GA21532@codemonkey.org.uk>
In-Reply-To: <20030221142039.GA21532@codemonkey.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-02=_DbjV+7Ae8S/EhGN";
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200302211525.07213.schlicht@uni-mannheim.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-02=_DbjV+7Ae8S/EhGN
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Description: signed data
Content-Disposition: inline

Yes, you are right. I was just looking for this preempt-problem where a=20
flush_tlb* was done, but there are many other places where this problem=20
occours, too... Nearly everywhere where smp_call_function() is used!

I found a function in the file mm/slab.c called smp_call_function_all_cpus(=
)=20
which tries to do the thing we want, but I think not even this function is=
=20
preempt-safe...!

But here I think I better get off my fingers, I just wanted to help a bit w=
ith=20
this issue, but I don't think I have the time and knowledge to solve it=20
completely in the mentioned good way...

Perhaps even the semantic of the function smp_call_function() could be chan=
ged=20
to call the function on every CPU? Just an idea...

Best regards
  Thomas Schlichter


On Fri, 21 Feb 2003 15:20, Dave Jones wrote:
> On Fri, Feb 21, 2003 at 01:42:12PM +0100, Thomas Schlichter wrote:
>  > > No.  All that does is make sure that the cpu you start out on is
>  > > flushed, once or twice, and the cpu you end up on may be missed.
>  > > Use preempt_disable and preempt_enable.
>  >
>  > Oh, you are right! I think I am totally stupid this morning...!
>  > Now finally I hope this is the correct patch...
>
> That would appear to do what you want, but its an ugly construct to
> be repeating everywhere that wants to call a function on all CPUs.
> It would probably clean things up a lot if we had a function to do..
>
> static inline void on_each_cpu(void *func)
> {
> #ifdef CONFIG_SMP
> 	preempt_disable();
> 	smp_call_function(func, NULL, 1, 1);
> 	func(NULL);
> 	preempt_enable();
> #else
> 	func(NULL);
> #endif
> }
>
> Bluesmoke and agpgart could both use this to cleanup some mess,
> and no doubt there are others
>
> Comments?
>
> 		Dave

--Boundary-02=_DbjV+7Ae8S/EhGN
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+VjbDYAiN+WRIZzQRAk6FAJ45uZxT8aFPEfxzQgihAf6VQjharwCggdOr
MuDk8MqPYjchHUJnsOqNRBU=
=t/x1
-----END PGP SIGNATURE-----

--Boundary-02=_DbjV+7Ae8S/EhGN--

