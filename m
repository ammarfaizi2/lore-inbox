Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261300AbUC1Mka (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Mar 2004 07:40:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261426AbUC1Mka
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Mar 2004 07:40:30 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:65289 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S261300AbUC1Mk0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Mar 2004 07:40:26 -0500
Date: Sun, 28 Mar 2004 14:40:22 +0200
From: Willy TARREAU <willy@w.ods.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.26-rc1 => Alpha warnings
Message-ID: <20040328124022.GG24421@pcw.home.local>
References: <20040328042608.GA17969@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040328042608.GA17969@logos.cnet>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo, all,

2.4.26-rc1 compiled correctly on alpha, but I got amongst usual
warnings a strange one (with gcc-3.2.3) :

math.c: In function `alpha_fp_emul':
math.c:204: warning: right shift count is negative
math.c:204: warning: left shift count >= width of type
math.c:220: warning: left shift count is negative
math.c:258: warning: right shift count >= width of type
math.c:258: warning: right shift count >= width of type
math.c:262: warning: right shift count >= width of type
math.c:262: warning: right shift count >= width of type
math.c:238: warning: statement with no effect
math.c:270: warning: statement with no effect
math.c:270: warning: statement with no effect
math.c:270: warning: statement with no effect
math.c:277: warning: statement with no effect
math.c:277: warning: statement with no effect
math.c:277: warning: statement with no effect

The offending code is in ./arch/alpha/math-emu/math.c :

     95 long
     96 alpha_fp_emul (unsigned long pc)
../..
    203                 case FOP_FNC_MULx:
>>> 204                         FP_MUL_D(DR, DA, DB);
    205                         goto pack_d;
    206
    207                 case FOP_FNC_DIVx:
    208                         FP_DIV_D(DR, DA, DB);
    209                         goto pack_d;
    210
    211                 case FOP_FNC_SQRTx:
    212                         FP_SQRT_D(DR, DB);
    213                         goto pack_d;
    214
    215                 case FOP_FNC_CVTxS:
    216                         /* It is irritating that DEC encoded CVTST with
    217                            SRC == T_floating.  It is also interesting that
    218                            the bit used to tell the two apart is /U... */
    219                         if (insn & 0x2000) {
>>> 220                                 FP_CONV(S,D,1,1,SR,DB);
    221                                 goto pack_s;
    222                         } else {
    223                                 vb = alpha_read_fp_reg_s(fb);
    224                                 FP_UNPACK_SP(SB, &vb);
    225                                 DR_c = DB_c;
    226                                 DR_s = DB_s;
    227                                 DR_e = DB_e;
    228                                 DR_f = SB_f << (52 - 23);
    229                                 goto pack_d;
    230                         }
    231
    232                 case FOP_FNC_CVTxQ:
    233                         if (DB_c == FP_CLS_NAN
    234                             && (_FP_FRAC_HIGH_RAW_D(DB) & _FP_QNANBIT_D)) {
    235                           /* AAHB Table B-2 says QNaN should not trigger INV */
    236                                 vc = 0;
    237                         } else
>>> 238                                 FP_TO_INT_ROUND_D(vc, DB, 64, 2);
    239                         goto done_d;
    240                 }
    241                 goto bad_insn;
    242
    243         case FOP_SRC_Q:
    244                 vb = alpha_read_fp_reg(fb);
    245
    246                 switch (func) {
    247                 case FOP_FNC_CVTQL:
    248                         /* Notice: We can get here only due to an integer
    249                            overflow.  Such overflows are reported as invalid
    250                            ops.  We return the result the hw would have
    251                            computed.  */
    252                         vc = ((vb & 0xc0000000) << 32 | /* sign and msb */
    253                               (vb & 0x3fffffff) << 29); /* rest of the int */
    254                         FP_SET_EXCEPTION (FP_EX_INVALID);
    255                         goto done_d;
    256
    257                 case FOP_FNC_CVTxS:
>>> 258                         FP_FROM_INT_S(SR, ((long)vb), 64, long);
    259                         goto pack_s;
    260
    261                 case FOP_FNC_CVTxT:
>>> 262                         FP_FROM_INT_D(DR, ((long)vb), 64, long);
    263                         goto pack_d;
    264                 }
    265                 goto bad_insn;
    266         }
    267         goto bad_insn;
    268
    269 pack_s:
>>> 270         FP_PACK_SP(&vc, SR);
    271         if ((_fex & FP_EX_UNDERFLOW) && (swcr & IEEE_MAP_UMZ))
    272                 vc = 0;
    273         alpha_write_fp_reg_s(fc, vc);
    274         goto done;
    275
    276 pack_d:
>>> 277         FP_PACK_DP(&vc, DR);
    278         if ((_fex & FP_EX_UNDERFLOW) && (swcr & IEEE_MAP_UMZ))
    279                 vc = 0;
    280 done_d:
    281         alpha_write_fp_reg(fc, vc);
    282         goto done;

I didn't understand how this works. Perhaps someone with better alpha skills could
enlighten a bit ?

Cheers,
Willy

