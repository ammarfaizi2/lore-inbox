Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316430AbSG3UYe>; Tue, 30 Jul 2002 16:24:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316512AbSG3UYe>; Tue, 30 Jul 2002 16:24:34 -0400
Received: from sproxy.gmx.de ([213.165.64.20]:41007 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S316430AbSG3UYd>;
	Tue, 30 Jul 2002 16:24:33 -0400
Date: Tue, 30 Jul 2002 23:27:37 +0300
From: Dan Aloni <da-x@gmx.net>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: [PATCH] fix s390[x] to print the correct freed memory amount
Message-ID: <20020730202737.GA10142@callisto.yi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is purely because arch/s390/mm/init.c does:

	extern unsigned long _text;
	extern unsigned long _etext;
	extern unsigned long _edata;
	extern unsigned long __bss_start;
	extern unsigned long _end;

	extern unsigned long __init_begin;
	extern unsigned long __init_end;

And as you know C, here (&__init_end - &__init_begin) >> 10) will 
not evaluate to the right value because of 'unsigned long'.

Linus, this is a good reason why I introduced asm-generic/sections.h
and asm-i386/sections.h. I think there should be a sections.h file 
every arch, in order to avoid having every .c file declare its own 
idea of what those symbols are.

BTW, I have another patch which adds a sections.h for every arch
and removes the cruft of the extern declarations, while adding 
an #include <asm/sections.h>.

--

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.544, 2002-07-30 22:58:38+03:00, da-x@gmx.net
  Make s390 and s390x print the right freed init memory size.
  The expression (&__init_begin - &__init_end) depends on the type
  of this adhoc extern variables, which was changed from char to long
  when the code was copied from another arch.


 s390/mm/init.c  |    2 +-
 s390x/mm/init.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)


diff -Nru a/arch/s390/mm/init.c b/arch/s390/mm/init.c
--- a/arch/s390/mm/init.c	Tue Jul 30 23:00:32 2002
+++ b/arch/s390/mm/init.c	Tue Jul 30 23:00:32 2002
@@ -189,7 +189,7 @@
 		totalram_pages++;
         }
         printk ("Freeing unused kernel memory: %dk freed\n",
-		(&__init_end - &__init_begin) >> 10);
+		((unsigned long)&__init_end - (unsigned long)&__init_begin) >> 10);
 }
 
 #ifdef CONFIG_BLK_DEV_INITRD
diff -Nru a/arch/s390x/mm/init.c b/arch/s390x/mm/init.c
--- a/arch/s390x/mm/init.c	Tue Jul 30 23:00:32 2002
+++ b/arch/s390x/mm/init.c	Tue Jul 30 23:00:32 2002
@@ -201,7 +201,7 @@
 		totalram_pages++;
         }
         printk ("Freeing unused kernel memory: %ldk freed\n",
-		(&__init_end - &__init_begin) >> 10);
+		((unsigned long)&__init_end - (unsigned long)&__init_begin) >> 10);
 }
 
 #ifdef CONFIG_BLK_DEV_INITRD

===================================================================


This BitKeeper patch contains the following changesets:
1.544
## Wrapped with gzip_uu ##


begin 664 bkpatch16769
M'XL(`&#P1CT``]5576_3,!1]KG_%E2:A5:.)[=A)&]1I,!`@0$R#/4]N?-M8
M;9+*SM8.Y<?CM.RC4EL&;`\DD9S;W)R<GGM.<@`7#FW:T:JW)`?PH7)UVID4
MRZ#$VM?G5>7KL$!M5#A5UFH,9Z:\6H9:+7F/!Y+XKC-59SE<HW5IAP71W2_U
MS1S3SOF[]Q>?7Y\3,AS"::[*"7[#&H9#4E?V6LVT.U%U/JO*H+:J=`76*LBJ
MHKEK;3BEW.^2)1&5<<-B*I(F8YHQ)1AJRD4_%O=H>57@?BR/PX1,:-Q$`RHX
M>0LLD$(`Y2%-PH@"YZGLIU'_B$8II="*<_)+%#CBT*/D#3PM^U.2P1<U17">
M$JA2KTZ6,+>FK*'.$:R9Y#6,+:(&4YH:"BPJ>P/._,#`W_W=]^!R;M$Y4Y5P
M^.+RLFV['.'$E-"#VQI+W06-<[\Z\(TM=CLH#U&-?64<*)U7F0>KT99PK:Q1
MHQFZE[#(C9_J0CG(5G]/>SI5T1;6RP%>A8E'6>2X1LTJC>ON:FYNFU59^6L6
ME,WR@'R"2'(IR=F],TCO#S="J*+D&.:MY[9/HWU8N!(T+(JPE2'('@Q&#AAM
M6$(CT:#@LI_T]9BCUB.U.?L].*VE!C(1<2,ECX2GL]\?=TA;"0D:R48FG-,F
M'L5)C%D\ZK,QBY(=?/;0Z5,>K;*WC7P;PV?1C13*UJ8,7)8OC,:QF]Z<:!R9
M&F>_43*F`]IN7@`N^#J<C&]F,TE%O#6;#'KL6;+YN!QZ/Z_'_Q5Z=K$ZO#_/
MMDK_%SY_RZD`1CZNET[G\/"J=&92>B9M]KH/(NX#O^/BZGW0A>-C8+3[:M,9
MF\9X'@<_VAF[C"':B#'VWQEC%<1=QO@W7[`!;WVQ7I[(%[<?\2S';.JNBB'+
/]$#V>4Q^`ISPL@,T"```
`
end


-- 
Dan Aloni
da-x@gmx.net
