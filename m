Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261267AbTI3Kf4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 06:35:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261282AbTI3Kf4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 06:35:56 -0400
Received: from rumms.uni-mannheim.de ([134.155.50.52]:4314 "EHLO
	rumms.uni-mannheim.de") by vger.kernel.org with ESMTP
	id S261267AbTI3Kfr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 06:35:47 -0400
From: Thomas Schlichter <schlicht@uni-mannheim.de>
To: Miles Bader <miles@gnu.org>
Subject: Re: [PATCH] document optimizing macro for translating PROT_ to VM_ bits
Date: Tue, 30 Sep 2003 12:35:32 +0200
User-Agent: KMail/1.5.9
Cc: Muli Ben-Yehuda <mulix@mulix.org>,
       Linux-Kernel <linux-kernel@vger.kernel.org>
References: <20030929090629.GF29313@actcom.co.il> <buoad8m3dvn.fsf@mcspd15.ucom.lsi.nec.co.jp> <20030930092403.GR29313@actcom.co.il>
In-Reply-To: <20030930092403.GR29313@actcom.co.il>
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-02=_5xVe/KKS4awfMLT";
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200309301235.37246.schlicht@uni-mannheim.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-02=_5xVe/KKS4awfMLT
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

here just my 2 cents...

On Tuesday 30 September 2003 11:24, Muli Ben-Yehuda wrote:

  ~~ snip ~~

> /*
>  * assert that only a single bit is on in 'bit'
>  */
> #define assert_single_bit(bit) do { \
>         if (__builtin_constant_p(bit)) {			        \
> 		if ((bit & (bit -1)))					\
> 			__assert_single_bit_failed_dont_exist();	\
> 	}  else								\
> 		BUG_ON(!(bit & (bit - 1)));				\
> 	} while(0)

In the BUG_ON statement the "!" looks wrong to me...

> /*
>  * Optimisation function.  It is equivalent to:
>  *      (x & bit1) ? bit2 : 0
>  * but this version is faster.
>  * ("bit1" and "bit2" must be single bits).
>  */
> static inline unsigned long
> inline_calc_vm_trans(unsigned long x, unsigned long bit1, unsigned long
> bit2) {
> 	assert_single_bit(bit1);
> 	assert_single_bit(bit2);
>
> 	return ((bit1) <= (bit2) ? ((x) & (bit1)) * ((bit2) / (bit1))
>
> 		: ((x) & (bit1)) / ((bit1) / (bit2)));
>
> }

Why don't we do:

static inline unsigned long calc_vm_trans(const unsigned long x,
		const unsigned long bit1, const unsigned long bit2) {
	assert_single_bit(bit1);
	assert_single_bit(bit2);

	/* Optimisation function */
	if (__builtin_constant_p(bit1) && __builtin_constant_p(bit2)) {
		return ((bit1) <= (bit2) ? ((x) & (bit1)) * ((bit2) / (bit1))
			: ((x) & (bit1)) / ((bit1) / (bit2)));
	}

	return (x & bit1) ? bit2 : 0;
}

Best regards
   Thomas Schlichter

--Boundary-02=_5xVe/KKS4awfMLT
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA/eVx5YAiN+WRIZzQRAp2/AJ9/jJqhqkRW5DIVcf43IHgimDr/QACfRyUP
QAaFPguusYSwbLSwVzB6QvI=
=Fnr1
-----END PGP SIGNATURE-----

--Boundary-02=_5xVe/KKS4awfMLT--
