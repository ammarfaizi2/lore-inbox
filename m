Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262792AbTCQIb7>; Mon, 17 Mar 2003 03:31:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262806AbTCQIb6>; Mon, 17 Mar 2003 03:31:58 -0500
Received: from grunt1.ihug.co.nz ([203.109.254.41]:62092 "EHLO
	grunt1.ihug.co.nz") by vger.kernel.org with ESMTP
	id <S262792AbTCQIb4>; Mon, 17 Mar 2003 03:31:56 -0500
Message-ID: <002d01c2ed11$6ba7a110$0b721cac@stacy>
From: "dave" <davekern@ihug.co.nz>
To: <linux-kernel@vger.kernel.org>
Subject: error using unsigned long long not working in 2.4.x
Date: Mon, 17 Mar 2003 21:44:16 -0800
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_002A_01C2ECCE.5BE026F0"
X-Priority: 1
X-MSMail-Priority: High
X-Mailer: Microsoft Outlook Express 6.00.2720.3000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_002A_01C2ECCE.5BE026F0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

hi i am writing a kernel 2.4.x driver and need to do maths on 64 bit ints
(unsigned long long)
bcause you can not use the FPU
but when i insmod i get the error unresolved symbol __udivdi3 i need!! 64
bit ints

i have included the code

thank you


------=_NextPart_000_002A_01C2ECCE.5BE026F0
Content-Type: application/octet-stream;
	name="lnvrm_nv05Pramdac.c"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="lnvrm_nv05Pramdac.c"

#include <lnvrm.h>=0A=
#include <lnvrm_exports.h>=0A=
=0A=
unsigned long nv05_pramdacPllCalc(struct _lnvrm_objNv01Device  *hw , =
unsigned long long clock)=0A=
{=0A=
  unsigned long long refClock  =3D hw->refClock ;=0A=
  unsigned long long vcoMax =3D 350000000 ;=0A=
  unsigned long long vcoMin =3D         0 ;=0A=
  unsigned long long nMax   =3D       255 ;=0A=
  unsigned long long nMin   =3D         1 ;=0A=
  unsigned long long mMax   =3D        14 ;=0A=
  unsigned long long mMin   =3D         1 ;=0A=
  unsigned long long pMax   =3D         4 ;=0A=
  unsigned long long pMin   =3D         1 ;=0A=
  unsigned long long f        ;=0A=
  unsigned long long fDif     ;=0A=
  unsigned long long fDifBest =3D ~0x00 ;=0A=
  unsigned long long fBest    =3D 0 ;=0A=
  unsigned long long nBest    =3D nMin ;=0A=
  unsigned long long mBest    =3D mMax ;=0A=
  unsigned long long pBest    =3D pMax ;=0A=
  unsigned long long vco   ;=0A=
  unsigned long long n     ;=0A=
  unsigned long long m     ;=0A=
  unsigned long long p     ;=0A=
  =0A=
  if(clock > vcoMax) clock =3D vco ;=0A=
  =0A=
  for(p =3D pMin ; p <=3D pMax ; p++) =0A=
    {=0A=
      vco =3D clock * (1 << p) ;=0A=
      for(m =3D mMin ; m <=3D mMax ; m++)=0A=
	{=0A=
	  n =3D vco / (refClock / m) ;=0A=
	  if((n >=3D nMin) & (n <=3D nMax))=0A=
	    {=0A=
	      f =3D refClock / m * n ;=0A=
	      if(vco > f)=0A=
		fDif =3D vco - f ;=0A=
	      else=0A=
		fDif =3D f   - vco ;=0A=
	      if(fDif < fDifBest) { fDifBest =3D fDif ; fBest =3D f ; nBest =3D =
n ; mBest =3D m ; pBest =3D p ; } =0A=
	    }=0A=
	}=0A=
    }=0A=
  printk("nv05_pramdacPllCalc: M:N:P %2.2LX:%2.2LX:%2.2LX f =3D %Ld Hz =
out =3D %Ld Hz\n",=0A=
	 mBest,=0A=
	 nBest,=0A=
	 pBest,=0A=
	 clock,=0A=
	 fBest / (1 << pBest));=0A=
=0A=
  return((pBest << 16) | (nBest << 8) | mBest) ;=0A=
}=0A=
=0A=
void nv05_pramdacSetPllNv(struct _lnvrm_objNv01Device  *hw , unsigned =
long long clock)=0A=
{=0A=
  unsigned long value ;=0A=
  value =3D nv05_pramdacPllCalc(hw,clock) ;=0A=
  nvr_regw(NV04_PRAMDAC_NVPLL_COEFF , value) ;=0A=
}=0A=
=0A=
void nv05_pramdacSetPllMem(struct _lnvrm_objNv01Device  *hw , unsigned =
long long clock)=0A=
{=0A=
  unsigned long value ;=0A=
  value =3D nv05_pramdacPllCalc(hw,clock) ;=0A=
  nvr_regw(NV04_PRAMDAC_MPLL_COEFF , value) ;=0A=
}=0A=
=0A=
void nv05_pramdacSetPllPixel(struct _lnvrm_objNv01Device  *hw , unsigned =
long long clock)=0A=
{=0A=
  unsigned long value ;=0A=
  value =3D nv05_pramdacPllCalc(hw,clock) ;=0A=
  nvr_regw(NV04_PRAMDAC_VPLL_COEFF , value) ;=0A=
}=0A=

------=_NextPart_000_002A_01C2ECCE.5BE026F0--

