Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291620AbSCSTQq>; Tue, 19 Mar 2002 14:16:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291753AbSCSTQh>; Tue, 19 Mar 2002 14:16:37 -0500
Received: from [192.58.209.91] ([192.58.209.91]:38534 "HELO handhelds.org")
	by vger.kernel.org with SMTP id <S291620AbSCSTQR>;
	Tue, 19 Mar 2002 14:16:17 -0500
From: George France <france@handhelds.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Alpha - IEEE 754 - denorm fix.
Date: Tue, 19 Mar 2002 14:15:29 -0500
X-Mailer: KMail [version 1.1.99]
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_TTI82885MRDL416ADIVM"
MIME-Version: 1.0
Message-Id: <02031914152903.10791@shadowfax.middleearth>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_TTI82885MRDL416ADIVM
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

Start with a simple C program:

#include <stdio.h>
#include <values.h>

int main()
{
  float val = 1.40129846432481707e-45f;
  double dbl = val;

  printf("MINFLOAT is %e(flt)\n", MINFLOAT );
  printf("val is %e(flt) %g(dbl)\n", val, val);
}

Compile it:

	gcc -mieee -o ieee ieee.c

Results with the patch:

	MINFLOAT is 1.175494e-38(flt)
	val is 1.401298e-45(flt) 1.4013e-45(dbl)

Results without the patch:

	MINFLOAT is 1.175494e-38(flt)
	val is 2.652495e-315(flt) 2.65249e-315(dbl)

Patch follows inline & attached:

--- linux-2.4.18-orig/arch/alpha/math-emu/math.c        Fri Sep 22 16:54:09 
2000+++ linux-2.4.18/arch/alpha/math-emu/math.c     Mon Mar 18 18:26:53 2002
@@ -220,12 +220,12 @@
                                FP_CONV(S,D,1,1,SR,DB);
                                goto pack_s;
                        } else {
-                               /* CVTST need do nothing else but copy the
-                                  bits and repack.  */
-                               DR_c = DB_c;
-                               DR_s = DB_s;
-                               DR_e = DB_e;
-                               DR_f = DB_f;
+                               vb = alpha_read_fp_reg_s(fb);
+                               FP_UNPACK_SP(SB, &vb);
+                               DR_c = SB_c;
+                               DR_s = SB_s;
+                               DR_e = SB_e;
+                               DR_f = SB_f << ( 52 - 23 );
                                goto pack_d;
                        }


--George
--------------Boundary-00=_TTI82885MRDL416ADIVM
Content-Type: text/x-c;
  name="patch-alpha-ieee-denorm"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="patch-alpha-ieee-denorm"

LS0tIGxpbnV4LTIuNC4xOC1vcmlnL2FyY2gvYWxwaGEvbWF0aC1lbXUvbWF0aC5jICAgICAgICBG
cmkgU2VwIDIyIDE2OjU0OjA5IDIwMDAKKysrIGxpbnV4LTIuNC4xOC9hcmNoL2FscGhhL21hdGgt
ZW11L21hdGguYyAgICAgTW9uIE1hciAxOCAxODoyNjo1MyAyMDAyCkBAIC0yMjAsMTIgKzIyMCwx
MiBAQAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIEZQX0NPTlYoUyxELDEsMSxTUixE
Qik7CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZ290byBwYWNrX3M7CiAgICAgICAg
ICAgICAgICAgICAgICAgIH0gZWxzZSB7Ci0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
LyogQ1ZUU1QgbmVlZCBkbyBub3RoaW5nIGVsc2UgYnV0IGNvcHkgdGhlCi0gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgYml0cyBhbmQgcmVwYWNrLiAgKi8KLSAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBEUl9jID0gREJfYzsKLSAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBEUl9zID0gREJfczsKLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBEUl9lID0g
REJfZTsKLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBEUl9mID0gREJfZjsKKyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICB2YiA9IGFscGhhX3JlYWRfZnBfcmVnX3MoZmIpOwor
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIEZQX1VOUEFDS19TUChTQiwgJnZiKTsKKyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBEUl9jID0gU0JfYzsKKyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBEUl9zID0gU0JfczsKKyAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBEUl9lID0gU0JfZTsKKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBEUl9mID0g
U0JfZiA8PCAoIDUyIC0gMjMgKTsKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBnb3Rv
IHBhY2tfZDsKICAgICAgICAgICAgICAgICAgICAgICAgfQogCg==

--------------Boundary-00=_TTI82885MRDL416ADIVM--
