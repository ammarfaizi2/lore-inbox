Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319568AbSIMJGB>; Fri, 13 Sep 2002 05:06:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319569AbSIMJGA>; Fri, 13 Sep 2002 05:06:00 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:24209 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S319568AbSIMJF2>;
	Fri, 13 Sep 2002 05:05:28 -0400
Date: Fri, 13 Sep 2002 11:10:14 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Minor input fixes [4/7]
Message-ID: <20020913111014.A28426@ucw.cz>
References: <20020913110453.A28145@ucw.cz> <20020913110600.B28378@ucw.cz> <20020913110641.C28378@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020913110641.C28378@ucw.cz>; from vojtech@suse.cz on Fri, Sep 13, 2002 at 11:06:41AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.
'bk pull bk://linux-input.bkbits.net/linux-input' should work as well.

===================================================================

ChangeSet@1.592, 2002-09-12 07:46:05+02:00, rz@linux-m68k.org
  Few small fixes for Q40 keyboard support.


 q40kbd.c |   31 +++++++++++++++++++++----------
 1 files changed, 21 insertions(+), 10 deletions(-)

===================================================================

diff -Nru a/drivers/input/serio/q40kbd.c b/drivers/input/serio/q40kbd.c
--- a/drivers/input/serio/q40kbd.c	Thu Sep 12 23:38:34 2002
+++ b/drivers/input/serio/q40kbd.c	Thu Sep 12 23:38:34 2002
@@ -47,12 +47,24 @@
 MODULE_DESCRIPTION("Q40 PS/2 keyboard controller driver");
 MODULE_LICENSE("GPL");
 
+
+static int q40kbd_open(struct serio *port)
+{
+	return 0;
+}
+static void q40kbd_close(struct serio *port)
+{
+	return 0;
+}
+
 static struct serio q40kbd_port =
 {
 	.type	= SERIO_8042,
+	.name	= "Q40 kbd port",
+	.phys	= "Q40",
 	.write	= NULL,
-	.name	= "Q40 PS/2 kbd port",
-	.phys	= "isa0060/serio0",
+	.open	= q40kbd_open,
+	.close	= q40kbd_close,
 };
 
 static void q40kbd_interrupt(int irq, void *dev_id, struct pt_regs *regs)
@@ -70,13 +82,10 @@
 {
 	int maxread = 100;
 
-	/* Get the keyboard controller registers (incomplete decode) */
-	request_region(0x60, 16, "q40kbd");
-
 	/* allocate the IRQ */
 	request_irq(Q40_IRQ_KEYBOARD, q40kbd_interrupt, 0, "q40kbd", NULL);
 
-	/* flush any pending input. */
+	/* flush any pending input */
 	while (maxread-- && (IRQ_KEYB_MASK & master_inb(INTERRUPT_REG)))
 		master_inb(KEYCODE_REG);
 	
@@ -84,15 +93,17 @@
 	master_outb(-1,KEYBOARD_UNLOCK_REG);
 	master_outb(1,KEY_IRQ_ENABLE_REG);
 
-	register_serio_port(&q40kbd_port);
-	printk(KERN_INFO "serio: Q40 PS/2 kbd port irq %d\n", Q40_IRQ_KEYBOARD);
+	serio_register_port(&q40kbd_port);
+	printk(KERN_INFO "serio: Q40 kbd registered\n");
 }
 
 void __exit q40kbd_exit(void)
 {
-	unregister_serio_port(&q40kbd_port);
+	master_outb(0,KEY_IRQ_ENABLE_REG);
+	master_outb(-1,KEYBOARD_UNLOCK_REG);
+
+	serio_unregister_port(&q40kbd_port);
 	free_irq(Q40_IRQ_KEYBOARD, NULL);
-	release_region(0x60, 16);	
 }
 
 module_init(q40kbd_init);

===================================================================

This BitKeeper patch contains the following changesets:
1.592
## Wrapped with gzip_uu ##


begin 664 bkpatch25303
M'XL(`%H)@3T``[U5VV[;.!!]%K]BD`*+-(TEDKJ[\"(7.ULC09*ZR,,"`0Q9
MHBW6DNB2E%UWW7\O)=MI=]L&V:*M)!"B.&?F',Z1]`SN%)-=:RG>:I;FZ!F\
M$DIW+54K9J<?S'PDA)D[N2B9LXMR)G.'5XM:([-^F^@TAR63JFL1VWUXHM<+
MUK5&@[_NKDY'"/5Z<)XGU8R]81IZ/:2%7"9%IDX2G1>BLK5,*E4RG=BI*#</
MH1N*,36G3T(7^\&&!-@+-RG)"$D\PC),O2CPT([8R8[V?_$Q,1G<F.!-@`/?
M17T@MA]3P-3!L4/,3=CU@B[V7V#:Q1CDAY."5_7[3AE$<UO(&;P@T,'H#'XN
M[7.4P@5;@2J3HH`I?\\43(6$UQZ&.5M/1"(S4/5B(:2VT27X<8Q==/MY)U'G
M?QX(X02C/^&MXF4I*G62,ZY8-6%RMM6RY%+72='*R21O^KKMM6-\PH7SSL/S
M26:G6X4AP93BR#4**8FB#9WB=#JE(?6G@1NXW]C))R1MN^4%F&Q<GWA>ZYW'
M4(V=?I.>!Z/I%2_X+-=VG:X:PSTA-?6HZX6$;&@4[3SH?N5`\GT'4F-!\FL\
M^(H?FS&!Z;^]>`PK(><**IZR8FV;D!%/<^-)8\5M:VZ@(U?M9:QU^VB7?L"J
M0R\&H_@>*9UHG@*O-&S3C<6"58=*RSK5T-:!H^8E>8[^099DNI85X)?HXQZY
M%#S;0]-"*/84[#T:^A0HLNPJ*9G5@X/VO9QDT(0?')N%1;Y6NP4S[_N>"1_Z
M?@MJ*)JU+P@WB+;ZY\?MU"!#%XPE0J,7#=O1<HY@6M0JAZ1:@P%GO)I!N[%P
MY*!^%#:EHJ@IU8H82S;C2C,Y;M@=_K$KT"I[B:R%-+LW/[P<C*['P^N+&SAH
M45W8:]K#679?'1A$/W8;,F;TD%4F;691Z\DA/KX<_#T>CEZ/!]>G9U>#L?G&
M-Q6^C.F0)NCLYG34']]=7]V<7^ZB[O=LZ^I1OOW8-]4??B9ISM*YJLO>!`>4
-1<84GP`L<R(:N08`````
`
end

-- 
Vojtech Pavlik
SuSE Labs
