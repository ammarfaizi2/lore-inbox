Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279407AbRKIJ00>; Fri, 9 Nov 2001 04:26:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279228AbRKIJ0N>; Fri, 9 Nov 2001 04:26:13 -0500
Received: from [194.213.32.133] ([194.213.32.133]:30337 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S279739AbRKIJZv>;
	Fri, 9 Nov 2001 04:25:51 -0500
Date: Thu, 8 Nov 2001 22:50:39 +0100
From: Pavel Machek <pavel@suse.cz>
To: rmk@arm.linux.org.uk, kernel list <linux-kernel@vger.kernel.org>
Subject: Support for hispeed serial ports
Message-ID: <20011108225038.A3092@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This is lying on my hdd for around forever. I used to have it in
kernel, but tytso convinced me to push it into userspace. Could it be
merged into setserial?

								Pavel

diff -ur -x .dep* -x .hdep* -x *.[oas] -x *~ -x #* -x *CVS* -x *.orig -x *.rej -x *.old -x .menu* -x asm -x local.h -x System.map -x autoconf.h -x compile.h -x version.h -x .version -x defkeymap.c -x uni_hash.tbl -x zImage -x vmlinu?* -x TAGS -x bootsect -x *RCS* -x conmakehash -x map -x build -x build -x configure -x *target* -x *.flags -x *.bak setserial-2.14.ofic/Makefile setserial-2.14/Makefile
--- setserial-2.14.ofic/Makefile	Wed Jun 21 21:45:29 2000
+++ setserial-2.14/Makefile	Thu Jun 22 23:44:45 2000
@@ -14,8 +14,8 @@
 
 all: setserial setserial.cat
 
-setserial: setserial.c
-	$(CC) $(CFLAGS) $(DEFS) setserial.c -o setserial
+setserial: setserial.c hispeed.c
+	$(CC) $(CFLAGS) $(DEFS) setserial.c hispeed.c -o setserial
 
 setserial.cat: setserial.8
 	nroff -man setserial.8 > setserial.cat
diff -ur -x .dep* -x .hdep* -x *.[oas] -x *~ -x #* -x *CVS* -x *.orig -x *.rej -x *.old -x .menu* -x asm -x local.h -x System.map -x autoconf.h -x compile.h -x version.h -x .version -x defkeymap.c -x uni_hash.tbl -x zImage -x vmlinu?* -x TAGS -x bootsect -x *RCS* -x conmakehash -x map -x build -x build -x configure -x *target* -x *.flags -x *.bak setserial-2.14.ofic/Makefile.in setserial-2.14/Makefile.in
--- setserial-2.14.ofic/Makefile.in	Tue Jun 16 08:09:09 1998
+++ setserial-2.14/Makefile.in	Thu Jun 22 23:44:41 2000
@@ -14,8 +14,8 @@
 
 all: setserial setserial.cat
 
-setserial: setserial.c
-	$(CC) $(CFLAGS) $(DEFS) setserial.c -o setserial
+setserial: setserial.c hispeed.c
+	$(CC) $(CFLAGS) $(DEFS) setserial.c hispeed.c -o setserial
 
 setserial.cat: setserial.8
 	nroff -man setserial.8 > setserial.cat
diff -ur -x .dep* -x .hdep* -x *.[oas] -x *~ -x #* -x *CVS* -x *.orig -x *.rej -x *.old -x .menu* -x asm -x local.h -x System.map -x autoconf.h -x compile.h -x version.h -x .version -x defkeymap.c -x uni_hash.tbl -x zImage -x vmlinu?* -x TAGS -x bootsect -x *RCS* -x conmakehash -x map -x build -x build -x configure -x *target* -x *.flags -x *.bak setserial-2.14.ofic/hispeed.c setserial-2.14/hispeed.c
--- setserial-2.14.ofic/hispeed.c	Thu Jun 22 23:52:12 2000
+++ setserial-2.14/hispeed.c	Fri Jun 23 00:05:58 2000
@@ -0,0 +1,626 @@
+/*
+ *  hispeed.c
+ *
+ *  Copyright (C) 1998-2000 Pavel Machek, it is cleanup of code from:
+ *  Distribute under GPLv2. Work was sponsored by SuSE.
+ *
+ * High Speed mode patch for SMC hispeed_chips by mizuhara@st.rim.or.jp
+ * Original idea and NT driver from gigo@yk.rim.or.jp
+ * 09/98 updated by ytakeuch@po.iijnet.or.jp
+ * Visit http://www.yk.rim.or.jp/~gigo/download.html
+ *
+ */
+
+/*
+ * CONFIG_SERIAL_HISPEED
+ *		Enables support for High Speed mode, available with
+ *		some SMC/NS/Winbond multi-I/O hispeed_chips.
+ */
+
+#undef DEBUG
+
+#define PC87338
+#undef CHKENB
+
+#define printk printf
+
+struct serial_state {
+	int baud_base;
+	int port;
+};
+
+#include <stdio.h>
+#include <linux/serial_reg.h>
+#include <asm/io.h>
+
+struct idn {
+	unsigned short port;	/* Base port chip lives at */
+	unsigned char ini1;	/* 1st magic for entering config mode */
+	unsigned char ini2;	/* 2nd... */
+	unsigned char idx;	/* Magic for getting identification */
+	unsigned char id;	/* ... identification expected */
+	unsigned char rev;
+	unsigned char fin;	/* Magic for exiting config mode */
+	int pch;		/* Manufacturer, for printing only */
+	int type;
+	char *name;
+} idnt[] = {
+	{ 0x3f0,0x55,0x55,0x20,0x4c,0x01,0xAA,1,4,"B72x"    },  /*00:B72x */
+	{ 0x370,0x55,0x55,0x20,0x4c,0x01,0xAA,1,4,"B72x"    },  /*01:B72x at 0x370 */
+	{ 0x3f0,0x55,0x55,0x20,0x43,0x01,0xAA,1,4,"B77x"    },  /*02:B77x */
+	{ 0x370,0x55,0x55,0x20,0x43,0x01,0xAA,1,4,"B77x"    },  /*03:B77x at 0x370 */
+	{ 0x3f0,0x55,0x55,0x20,0x44,0x01,0xAA,1,4,"B78x"    },  /*04:B78x */
+	{ 0x370,0x55,0x55,0x20,0x44,0x01,0xAA,1,4,"B78x"    },  /*05:B78x at 0x370 */
+	{ 0x3f0,0x55,0x55,0x20,0x42,0x01,0xAA,1,4,"B80x"    },  /*06:B80x */
+	{ 0x370,0x55,0x55,0x20,0x42,0x01,0xAA,1,4,"B80x"    },  /*07:B80x at 0x370 */
+	{ 0x3f0,0x55,0x55,0x0d,0x65,0x02,0xAA,0,1,"C665GT"  },  /*08:C665GT */
+	{ 0x3f0,0x44,0x44,0x0d,0x66,0x02,0xAA,0,1,"C666GT"  },  /*09:C666GT */
+	{ 0x3f0,0x55,0x55,0x0d,0x65,0x82,0xAA,1,2,"C665IR"  },  /*10:C665IR */
+	{ 0x3f0,0x44,0x44,0x0d,0x66,0x82,0xAA,1,2,"C666IR"  },  /*11:C666IR */
+	{ 0x3f0,0x55,0x55,0x0d,0x03,0x00,0xAA,1,3,"C669"    },  /*12:C669 */
+	{ 0x370,0x55,0x55,0x0d,0x03,0x00,0xAA,1,3,"C669"    },  /*13:C669 at 0x370 */
+	{ 0x3f0,0x55,0x55,0x0d,0x04,0x00,0xAA,1,3,"C669FR"  },  /*14:C669FR */
+	{ 0x370,0x55,0x55,0x0d,0x04,0x00,0xAA,1,3,"C669FR"  },  /*15:C669FR at 0x370 */
+	{ 0x3f0,0x55,0x55,0x20,0x40,0x01,0xAA,1,4,"C67x"    },  /*16:C67x */
+	{ 0x370,0x55,0x55,0x20,0x40,0x01,0xAA,1,4,"C67x"    },  /*17:C67x at 0x370 */
+	{ 0x3f0,0x55,0x55,0x20,0x48,0x01,0xAA,1,4,"C68x"    },  /*18:C68x */
+	{ 0x370,0x55,0x55,0x20,0x48,0x01,0xAA,1,4,"C68x"    },  /*19:C68x at 0x370 */
+	{ 0x3f0,0x55,0x55,0x20,0x02,0x01,0xAA,1,4,"C93x"    },  /*20:C93x */
+	{ 0x370,0x55,0x55,0x20,0x02,0x01,0xAA,1,4,"C93x"    },  /*21:C93x at 0x370 */
+	{ 0x3f0,0x55,0x55,0x20,0x30,0x01,0xAA,1,4,"C93xAPM" },  /*22:C93xAPM */
+	{ 0x370,0x55,0x55,0x20,0x30,0x01,0xAA,1,4,"C93xAPM" },  /*23:C93xAPM at 0x370 */
+	{ 0x3f0,0x55,0x55,0x20,0x03,0x01,0xAA,1,4,"C93xFR"  },  /*24:C93xFR */
+	{ 0x370,0x55,0x55,0x20,0x03,0x01,0xAA,1,4,"C93xFR"  },  /*25:C93xFR at 0x370 */
+	{ 0x3f0,0x55,0x55,0x20,0x47,0x01,0xAA,1,4,"M60x"    },  /*26:M60x */
+	{ 0x370,0x55,0x55,0x20,0x47,0x01,0xAA,1,4,"M60x"    },  /*27:M60x at 0x370 */
+	{ 0x3f0,0x55,0x55,0x20,0x46,0x01,0xAA,1,4,"M61x"    },  /*28:M61x */
+	{ 0x370,0x55,0x55,0x20,0x46,0x01,0xAA,1,4,"M61x"    },  /*29:M61x at 0x370 */
+	{ 0x3f0,0x55,0x55,0x0d,0x28,0x00,0xAA,1,3,"N769"    },  /*30:N769FR */
+	{ 0x370,0x55,0x55,0x0d,0x28,0x00,0xAA,1,3,"N769"    },  /*31:N769FR at 0x370 */
+	{ 0x3f0,0x55,0x55,0x20,0x09,0x01,0xAA,1,4,"N958FR"  },  /*32:N958FR */
+	{ 0x370,0x55,0x55,0x20,0x09,0x01,0xAA,1,4,"N958FR"  },  /*33:N958FR at 0x370 */
+
+#if 0
+	/* deleted ? */
+	{ 0x3f0,0x55,0x55,0x20,0x07,0x01,0xAA,1,4,"C957FR"  },  /*34:C957FR */
+	{ 0x370,0x55,0x55,0x20,0x07,0x01,0xAA,1,4,"C957FR"  },  /*35:C957FR at 0x370 */
+	/* same ID as B80 ?? */
+	{ 0x3f0,0x55,0x55,0x20,0x42,0x01,0xAA,1,4,"M70x"    },  /*26:M70x */
+	{ 0x370,0x55,0x55,0x20,0x42,0x01,0xAA,1,4,"M70x"    },  /*27:M70x at 0x370 */
+	/* deleted ? */
+	{ 0x3f0,0x55,0x55,0x20,0x43,0x01,0xAA,1,4,"M77x"    },  /*28:M77x */
+	{ 0x370,0x55,0x55,0x20,0x43,0x01,0xAA,1,4,"M77x"    },  /*29:M77x at 0x370 */
+#endif
+#if 0
+	/* no function but detectable */
+	{ 0x250,0x89,0x89,0x09,0x0a,0x01,0xAA,0,6,"W83877F"},   /*--:W83877F at 0x250 */
+	{ 0x250,0x88,0x88,0x09,0x0a,0x01,0xAA,0,6,"W83877F"},   /*--:W83877F at 0x250 */
+	{ 0x3F0,0x87,0x87,0x09,0x0a,0x01,0xAA,0,7,"W83877F"},   /*--:W83877F at 0x3f0 */
+	{ 0x3F0,0x86,0x86,0x09,0x0a,0x01,0xAA,0,7,"W83877F"},   /*--:W83877F at 0x3f0 */
+#endif
+	{ 0x250,0x89,0x89,0x09,0x0c,0x01,0xAA,2,8,"W83877TF"},  /*34:W83877TF at 0x250 */
+	{ 0x250,0x88,0x88,0x09,0x0c,0x01,0xAA,2,8,"W83877TF"},  /*35:W83877TF at 0x250 */
+	{ 0x3F0,0x87,0x87,0x09,0x0c,0x01,0xAA,2,9,"W83877TF"},  /*36:W83877TF at 0x3f0 */
+	{ 0x3F0,0x86,0x86,0x09,0x0c,0x01,0xAA,2,9,"W83877TF"},  /*37:W83877TF at 0x3f0 */
+
+	{ 0x3f0,0x87,0x87,0x20,0x97,0x71,0xAA,2,10,"W83977" },  /*38:W83977A/AF/TF/ATF at 0x3f0 */
+	{ 0x370,0x87,0x87,0x20,0x97,0x71,0xAA,2,10,"W83977" },  /*39:W83977A/AF/TF/ATF at 0x370 */
+#if 0
+	/* no function but detectable */
+	{ 0x02e,0x00,0x00,0x08,0x90,0x00,0xAA,3,01,"87336"  },  /*--:PC87336 at 0x02e */
+	{ 0x15c,0x00,0x00,0x08,0x90,0x00,0xAA,3,01,"87336"  },  /*--:PC87336 at 0x15c */
+	{ 0x398,0x00,0x00,0x08,0x90,0x00,0xAA,3,01,"87336"  },  /*--:PC87336 at 0x398 */
+#endif
+	{ 0x02e,0x00,0x00,0x20,0xa0,0x00,0xAA,3,20,"87308"  },  /*40:PC87308 at 0x02e */
+	{ 0x15c,0x00,0x00,0x20,0xa0,0x00,0xAA,3,20,"87308"  },  /*41:PC87308 at 0x15c */
+#if defined(PC87338)
+	{ 0x02e,0x00,0x00,0x08,0xb0,0x00,0xAA,3,28,"87338"  },  /*42:PC87338 at 0x02e */
+	{ 0x15c,0x00,0x00,0x08,0xb0,0x00,0xAA,3,28,"87338"  },  /*43:PC87338 at 0x15c */
+	{ 0x398,0x00,0x00,0x08,0xb0,0x00,0xAA,3,28,"87338"  },  /*44:PC87338 at 0x398 */
+#endif
+	{ 0x02e,0x00,0x00,0x20,0xc0,0x00,0xAA,3,22,"87307"  },  /*45:PC87307 at 0x02e */
+	{ 0x15c,0x00,0x00,0x20,0xc0,0x00,0xAA,3,22,"87307"  },  /*46:PC87307 at 0x15c */
+	{ 0x02e,0x00,0x00,0x20,0xcf,0x00,0xAA,3,21,"97307"  },  /*47:PC97307 at 0x02e */
+	{ 0x15c,0x00,0x00,0x20,0xcf,0x00,0xAA,3,21,"97307"  },  /*48:PC97307 at 0x15c */
+	{ 0x02e,0x00,0x00,0x20,0xd0,0x00,0xAA,3,22,"87317"  },  /*49:PC87317 at 0x02e */
+	{ 0x15c,0x00,0x00,0x20,0xd0,0x00,0xAA,3,22,"87317"  },  /*50:PC87317 at 0x15c */
+	{ 0x02e,0x00,0x00,0x20,0xdf,0x00,0xAA,3,21,"97317"  },  /*51:PC87317 at 0x02e */
+	{ 0x15c,0x00,0x00,0x20,0xdf,0x00,0xAA,3,21,"97317"  },  /*52:PC87317 at 0x15c */
+	{ 0x02e,0x00,0x00,0x20,0xe0,0x00,0xAA,3,23,"87309"  },  /*53:PC87309 at 0x02e */
+	{ 0x15c,0x00,0x00,0x20,0xe0,0x00,0xAA,3,23,"87309"  },  /*54:PC87309 at 0x15c */
+	{ 0x3f0,0x51,0x23,0x20,0x43,0x15,0xBB,4,30,"M1543"  },  /*55:M1543 at 0x3f0 */
+	{ 0x370,0x51,0x23,0x20,0x43,0x15,0xBB,4,30,"M1543"  },  /*56:M1543 at 0x370 */
+	{     0,   0,   0,   0,   0,   0,   0,0, 0,"Other"  }
+};
+
+#define OUTP0(x) outb(x, idnt[n].port)
+#define OUTP1(x) outb(x, idnt[n].port+1)
+#define INP1 ((unsigned char) inb(idnt[n].port+1))
+#define INP2 ((unsigned char) inb(idnt[n].port+2))
+
+#define save_flags(a)
+#define cli()
+#define restore_flags(a)
+
+static int
+hispeed_probe(int n)
+{
+	unsigned char id,rev;
+	unsigned long flags;
+
+	save_flags(flags); cli();
+	/* write ini value to enter config mode */
+	if (idnt[n].ini1) OUTP0(idnt[n].ini1);
+	if (idnt[n].ini2) OUTP0(idnt[n].ini2);
+	if (idnt[n].type != 8) {
+		OUTP0(idnt[n].idx);
+		id = INP1;
+	} else {
+		OUTP1(idnt[n].idx);
+		id = INP2;
+	}
+	switch (idnt[n].type) {
+	default:
+		OUTP0(idnt[n].idx+1);
+		rev = INP1;
+		break;
+	case 8:
+	case 9:
+		id = (unsigned char)(id&0xf);
+		rev = 0xff;
+		break;
+	case 20:
+	case 22:
+	case 28:
+		id = (unsigned char) (id & ~7);
+		rev = (unsigned char)(id &  7);
+		break;
+	case 21:
+	case 23:
+		rev = 0xff;
+		break;
+	}
+	OUTP0(idnt[n].fin);	/* exit config mode */
+	restore_flags(flags);
+
+#ifdef DEBUG
+	printk("*Check %s: port=%04x, ini1=%02x, ini2=%02x, idx=%02x -> id=%02x, rev=%02x (exp id=%02x, rev=%02x)\n",
+	       idnt[n].name,idnt[n].port,idnt[n].ini1,idnt[n].ini2,idnt[n].idx,id,rev,
+	       idnt[n].id, idnt[n].rev);
+#endif
+
+	/* id & (rev or not 665IR/666IR) ? */
+	if ( (idnt[n].id==id) && ((idnt[n].rev==rev)||(idnt[n].type!=2)) && (idnt[n].type>1) )
+		return n;
+	return -1;
+}
+
+static void
+hispeed_natsemi_set(int portAdr, char opr, struct serial_state *state)
+{
+	int val;
+	if (opr == 'H') {
+		outb(0xe0, portAdr + UART_LCR);	/* select Bank2 */
+#if 0
+		outb(0x41, portAdr + 0x02);		/* set EXT_SL */
+#endif
+		val = inb(portAdr + 0x04);		/* get EXCR2 */
+		val = (val & 0xcf) | 0x10;		/* PRESL = 1.625 */
+		outb(val, portAdr + 0x04);		/* set EXCR2 */
+		outb(0x00, portAdr + UART_LCR);	/* select Bank0 */
+	
+		state->baud_base = 921600;
+	}
+	if (opr == 'L') {
+		outb(0xe0, portAdr + UART_LCR);	/* select Bank2 */
+#if 0
+		outb(0x40, portAdr + 0x02);		/* clear EXT_SL */
+#endif
+		val = inb(portAdr + 0x04);		/* get EXCR2 */
+		val = (val & 0xcf) | 0x00;		/* PRESL = 13 */
+		outb(val, portAdr + 0x04);		/* set EXCR2 */
+		outb(0x00, portAdr + UART_LCR);	/* select Bank0 */
+	}
+}
+
+static int
+hispeed_operation(int n, char opr, int uart, int *portAdr, struct serial_state *state)
+{
+	unsigned char r,v,cr1,cr2;
+	int i,dvofs,nxt;
+	int portNo;
+	unsigned long flags;
+
+	portNo = 0x20 << uart;
+	v = 0;
+
+	switch(idnt[n].type) {
+	case 0: /* Unknown */
+	case 1: /* 665GT,666GT */
+	default: /* internal error.. */
+		printk( "Hispeed operation: internal error\n" );
+		break;
+	case 2: /* 665IR,666IR */
+		save_flags(flags); cli();
+		/* write ini value 2 times to enter config mode */
+		OUTP0(idnt[n].ini1);
+		OUTP0(idnt[n].ini2);
+		OUTP0(0x01);
+		cr1 = INP1;
+		OUTP0(0x02);
+		cr2 = INP1;
+		/* select sr0c */
+		OUTP0(0x0c);
+		r = INP1;
+		if (opr == 'H')
+			r |= portNo;
+		if (opr == 'L')
+			r &= ~portNo;
+		OUTP1(r);
+		r = INP1;
+		OUTP0(idnt[n].fin);	/* exit config mode */
+		restore_flags(flags);
+		for (v=0x40,i=1;i<=2;++i) {
+			if (cr2 & 0x4) {
+				switch (cr2 & 0x3) {
+				case 00: portAdr[i]=0x3F8;break;
+				case 01: portAdr[i]=0x2F8;break;
+				case 02:
+					switch(cr1 & 0x30){
+					case 0x00: portAdr[i]=0x338;break;
+					case 0x10: portAdr[i]=0x3E8;break;
+					case 0x20: portAdr[i]=0x2E8;break;
+					case 0x30: portAdr[i]=0x220;break;
+					}
+					break;
+				case 03:
+					switch(cr1 & 0x30){
+					case 0x00: portAdr[i]=0x238;break;
+					case 0x10: portAdr[i]=0x2E8;break;
+					case 0x20: portAdr[i]=0x2E0;break;
+					case 0x30: portAdr[i]=0x228;break;
+					}
+					break;
+				}
+				if ( i == uart ) {
+					v = v & r;
+					break;
+				}
+			} else {
+				if ( i == uart ) {
+					v = v & r;
+					portAdr[i] = 0;
+					break;
+				}
+			}
+			cr2 >>= 4;
+			v <<= 1;
+		}
+		break;
+	case 3: /* 669 */
+		save_flags(flags); cli();
+		/* write ini value 2 times to enter config mode */
+		OUTP0(idnt[n].ini1);
+		OUTP0(idnt[n].ini2);
+		OUTP0(0x24);
+		portAdr[1] =  (INP1 & 0xFE) << 2;
+		OUTP0(0x25);
+		portAdr[2] =  (INP1 & 0xFE) << 2;
+		/* select sr0c */
+		OUTP0(0x0c);
+		r = INP1;
+		if (opr == 'H')
+			r |= portNo;
+		if (opr == 'L')
+			r &= ~portNo;
+		OUTP1(r);
+		r = INP1;
+		OUTP0(idnt[n].fin);	/* exit config mode */
+		restore_flags(flags);
+		for (v=0x40,i=1;i<=2;++i) {
+			if (portAdr[i] & 0x300) {
+				if ( i == uart ) {
+					v = v & r;
+					break;
+				}
+			} else {
+				if ( i == uart ) {
+					v = v & r;
+					portAdr[i] = 0;
+					break;
+				}
+			}
+			v <<= 1;
+		}
+		break;
+	case 8: /* W83877TF native */
+	case 9: /* W83877TF emulate mode */
+		save_flags(flags); cli();
+		/* write ini value 2 times to enter config mode */
+		OUTP0(idnt[n].ini1);
+		if (idnt[n].type != 8)
+			OUTP0(idnt[n].ini2);
+		else
+			idnt[n].port++;
+		OUTP0(0x24);
+		portAdr[1] =  (INP1 & 0xFE) << 2;
+		OUTP0(0x25);
+		portAdr[2] =  (INP1 & 0xFE) << 2;
+		/* select sr19 */
+		OUTP0(0x19);
+		r = INP1;
+		v = 0;
+		if (portNo & 0x40)
+			v = 0x2;
+		if (portNo & 0x80)
+			v |= 0x1;
+		if (opr == 'H')
+			r |= v;
+		if (opr == 'L')
+			r &= ~v;
+		OUTP1(r);
+		r = INP1;
+		OUTP0(idnt[n].fin);	/* exit config mode */
+		restore_flags(flags);	/* sti */
+		for (v=0x02,i=1;i<=2;++i) {
+			if (portAdr[i] & 0x300) {
+				if ( i == uart ) {
+					v = v & r;
+					if ( v )
+						state->baud_base = 921600;
+					break;
+				}
+			} else {
+				if ( i == uart ) {
+					v = v & r;
+					portAdr[i] = 0;
+					break;
+				}
+			}
+			v >>= 1;
+		}
+		if (idnt[n].type == 8)
+			idnt[n].port--;
+		break;
+	case  4: /* 67x,68x,93x,957 dev 4,5*/
+	case 30: /* ALI M1543 dev 4,5*/
+	case 10: /* W83977TF dev 2,3*/
+	case 20: /* NS PC8xxxxx dev 6,5*/
+	case 21: /* NS PC9xxxxx dev 6,5*/
+	case 22: /* NS PC8xxxxx dev 6,5*/
+	case 23: /* NS PC9xxxxx dev 3,2*/
+		switch(idnt[n].type) {
+		case 20:
+		case 21:
+		case 22:
+			dvofs = 6;	/* 5:port2, 6:port1 87307/97037/87308/87317/97317 */
+			nxt = -1;
+			break;
+		case 23:
+			dvofs = 3;	/* 2:port2, 3:port1 87309 */
+			nxt = -1;
+			break;
+		case 10:	/* WinBond */
+			dvofs = 2;	/* 2:port1, 3:port2 */
+			nxt = 1;
+			break;
+		default:	/* SMC,ALI */
+			dvofs = 4;	/* 4:port1, 5:port2 */
+			nxt = 1;
+			break;
+		}
+
+		for (i = 1; i <=2 ; ++i, dvofs += nxt) {
+			save_flags(flags); cli();
+			/* write ini value 2 times to enter config mode */
+			if (idnt[n].ini1) OUTP0(idnt[n].ini1);
+			if (idnt[n].ini2) OUTP0(idnt[n].ini2);
+			OUTP0(0x07);/* Select device register */
+			OUTP1(dvofs); /* Set device value */
+			OUTP0(0x60);		/* get port addr. */
+			portAdr[i] = ((int) INP1) << 8;
+			OUTP0(0x61);
+			portAdr[i] |= (int) INP1;
+#if defined(CHKENB)
+			OUTP0(0x30);		/* enabled ? */
+			if (!INP1)
+				portAdr[i] = 0;
+#endif
+			OUTP1(0xF0);/* Select serial config register */
+			r = INP1;
+			switch (idnt[n].type) {
+			case  4: /* SMC */
+			case 30: /* ALI */
+				if ((0x20 << i) & portNo) {
+					if (opr == 'H')
+						r |= 2;
+					if (opr == 'L')
+						r &= ~2;
+					OUTP1(r);
+				}
+				r = INP1;
+				v = (unsigned char)((r&0x3) == 0x2);
+				break;
+			case 10: /* Winbond 83977TF */
+				if ((0x20 << i) & portNo) {
+					if (opr == 'H')
+						r |= 3;
+					if (opr == 'L')
+						r &= ~3;
+					OUTP1(r);
+				}
+				r = INP1;
+				v = (unsigned char)((r&0x3) == 0x3);
+				if ( v )
+					state->baud_base = 921600;
+				break;
+			case 20: /* NS 87308 */
+			case 21: /* NS */
+			case 22: /* NS */
+			case 23: /* NS */
+				if ((0x20 << i) & portNo) {
+					OUTP0(0xf0);
+					OUTP1(r|0x80);	/* enable Bank Select */
+				}
+				v = (unsigned char)(INP1&0x80);
+				if (v) hispeed_natsemi_set(portAdr[i], opr, state);
+				if ((0x20 << i) & portNo) {
+					if (opr == 'L') {
+						OUTP0(0xf0);
+						OUTP1(r&0x7f);	/* disable Bank Select */
+					}
+				}
+				break;
+			default:
+				break;
+			}
+			OUTP0(idnt[n].fin);	/* exit config mode */
+			restore_flags(flags);	/* sti */
+			if (portAdr[i]) {
+				if ( i == uart ) {
+					break;
+				}
+			} else {
+				if ( i == uart ) {
+					portAdr[i] = 0;
+					break;
+				}
+			}
+		}
+		break;
+#ifdef PC87338
+	case 28: /* PC87338 */
+		OUTP0(0x00);	/* get FER 3:FDC 2:SCC2 1:SCC1 0:PPA */
+		cr1 = INP1;
+		OUTP0(0x01);	/* get FAR 7:6-COM34 5:4-SCC2 3:2-SCC1 2:1-PPA */
+		cr2 = INP1;
+
+		for (i=1;i<=2;++i) {
+			if ((cr1 & (1 << i) )==0) {
+				portAdr[i] = 0;
+				if ( i == uart ) {
+					v = 0;
+					break;
+				}
+				continue;
+			}
+			switch ((cr2>>(2*i)) & 0x03) {
+			case 00: portAdr[i]=0x3F8;break;
+			case 01: portAdr[i]=0x2F8;break;
+			case 02: /* com3 */
+				switch(cr2 & 0xc0){
+				case 0x00: portAdr[i]=0x3E8;break;
+				case 0x40: portAdr[i]=0x338;break;
+				case 0x80: portAdr[i]=0x2E8;break;
+				case 0xc0: portAdr[i]=0x220;break;
+				}
+				break;
+			case 03: /* com4 */
+				switch(cr2 & 0xc0){
+				case 0x00: portAdr[i]=0x2E8;break;
+				case 0x40: portAdr[i]=0x238;break;
+				case 0x80: portAdr[i]=0x2E0;break;
+				case 0xc0: portAdr[i]=0x228;break;
+				}
+				break;
+			}
+			if ((0x20 << i) & portNo) {
+				OUTP0(0x40);	/* enable Bank Select */
+				OUTP1(INP1 | (0x10 << (3*(i-1))) );
+			}
+			v = (unsigned char)(INP1 & (0x10 << (3*(i-1))) );
+			if ( v ) hispeed_natsemi_set(portAdr[i], opr, state);
+			if ((0x20 << i) & portNo) {
+				if (opr == 'L') {
+					OUTP0(0x40);	/* disable Bank Select */
+					OUTP1(INP1 & ~(0x10 << (3*(i-1))) );
+				}
+			}
+			if ( i == uart )
+				break;
+		}
+		break;
+#endif
+	}
+
+	return v;
+}
+
+
+static void
+get_portAdr(int n, int *portAdr, struct serial_state *state)
+{
+	hispeed_operation(n, ' ', 2, portAdr, state);
+}
+
+
+int
+do_enable_hispeed(struct serial_state *state)
+{
+	int result, n;
+	int uart;
+	char *fab;
+	int portAdr[3];
+
+	printk( "Detecting hispeed serials (%04x)... ", state->port );
+	fflush(stdout);
+
+	/* find what type of controller is used */
+	for (n = 0; idnt[n].port; n++)
+		if ( hispeed_probe(n) != -1 ) break;
+
+	if ( idnt[n].port == 0 ) {
+		printk( "not there\n" );
+		return 0;
+	}
+
+	/* what port? */
+	get_portAdr( n, portAdr, state );
+
+	uart = 0;
+	if ( portAdr[1] == state->port )
+		uart |= 1;
+	if ( portAdr[2] == state->port )
+		uart |= 2;
+
+	if ( uart == 0 || uart > 2) {
+		printk( "not for this port\n" );
+		return 0;
+	}
+
+	switch(idnt[n].pch) {
+	case 1:
+		fab = "SMC37";
+		break;
+	case 2:
+		fab = "Winbond ";
+		break;
+	case 3:
+		fab = "NS PC";
+		break;
+	case 4:
+		fab = "ALI ";
+		break;
+	default:
+		fab = "nowhere ";
+		break;
+	}
+	printk("%s%s at %04xh",fab,idnt[n].name,idnt[n].port);
+
+	/* try to enable High Speed mode */
+	result = hispeed_operation(n, 'H', uart, portAdr, state);
+	printk(", base = %d baud\n", state->baud_base);
+	return result;
+}
+
+int
+enable_hispeed(int port)
+{
+	struct serial_state fake;
+
+	iopl(3);
+	fake.port = port;
+	fake.baud_base = 0;
+	do_enable_hispeed(&fake);
+	return fake.baud_base;
+}
Only in setserial-2.14: setserial
diff -ur -x .dep* -x .hdep* -x *.[oas] -x *~ -x #* -x *CVS* -x *.orig -x *.rej -x *.old -x .menu* -x asm -x local.h -x System.map -x autoconf.h -x compile.h -x version.h -x .version -x defkeymap.c -x uni_hash.tbl -x zImage -x vmlinu?* -x TAGS -x bootsect -x *RCS* -x conmakehash -x map -x build -x build -x configure -x *target* -x *.flags -x *.bak setserial-2.14.ofic/setserial.8 setserial-2.14/setserial.8
--- setserial-2.14.ofic/setserial.8	Wed Jun 21 21:45:29 2000
+++ setserial-2.14/setserial.8	Fri Jun 23 00:20:47 2000
@@ -138,7 +138,7 @@
 .B skip_test
 parameter also often must be specified.
 .TP
-.B autoconfigure
+.B autoconfig
 When this parameter is given, 
 .B setserial
 will ask the kernel to attempt to automatically configure the serial
@@ -147,10 +147,21 @@
 .B auto_irq 
 parameter is set, Linux will attempt to automatically determine the
 IRQ.  The
-.B autoconfigure
+.B autoconfig
 parameter should be given after the
 .BR port , auto_irq ", and" skip_test
 parameters have been specified.
+.TP
+.B hispeed
+Some SMC/NS/Winbond Multi-I/O chips and ALI south bridge chips have High
+Speed mode, in which baud rate can be set to 230400, 460800 (or 921600
+at NS/Winbond chips) bps. With this option,
+.B setserial
+try to detect such chips and make kernel capable of using higher speeds.
+(ALI: M1543(Aladdin V south bridge) - 460800 max,
+NS: PC8730[789], PC[89]3[01]7, PC87338 - 921600 max,
+SMC:37C665IR/666IR, 37C669/669FR,37N769, 37B72x/77x/78x/80x, 37C67x/68x/93x/93xAPM/93xFR, 37M60x/61x, 37N958FR - 450800 max,
+WinBond: W83877TF(TF ONLY, A/F/AF NOT supported) W83977A/AF/TF/ATF - 460800 max).
 .TP
 .B auto_irq
 During autoconfiguration, try to determine the IRQ.  This feature is
diff -ur -x .dep* -x .hdep* -x *.[oas] -x *~ -x #* -x *CVS* -x *.orig -x *.rej -x *.old -x .menu* -x asm -x local.h -x System.map -x autoconf.h -x compile.h -x version.h -x .version -x defkeymap.c -x uni_hash.tbl -x zImage -x vmlinu?* -x TAGS -x bootsect -x *RCS* -x conmakehash -x map -x build -x build -x configure -x *target* -x *.flags -x *.bak setserial-2.14.ofic/setserial.8.in setserial-2.14/setserial.8.in
--- setserial-2.14.ofic/setserial.8.in	Tue Jun  9 15:51:29 1998
+++ setserial-2.14/setserial.8.in	Fri Jun 23 00:21:40 2000
@@ -138,7 +138,7 @@
 .B skip_test
 parameter also often must be specified.
 .TP
-.B autoconfigure
+.B autoconfig
 When this parameter is given, 
 .B setserial
 will ask the kernel to attempt to automatically configure the serial
@@ -147,10 +147,21 @@
 .B auto_irq 
 parameter is set, Linux will attempt to automatically determine the
 IRQ.  The
-.B autoconfigure
+.B autoconfig
 parameter should be given after the
 .BR port , auto_irq ", and" skip_test
 parameters have been specified.
+.TP
+.B hispeed
+Some SMC/NS/Winbond Multi-I/O chips and ALI south bridge chips have High
+Speed mode, in which baud rate can be set to 230400, 460800 (or 921600
+at NS/Winbond chips) bps. With this option,
+.B setserial
+try to detect such chips and make kernel capable of using higher speeds.
+(ALI: M1543(Aladdin V south bridge) - 460800 max,
+NS: PC8730[789], PC[89]3[01]7, PC87338 - 921600 max,
+SMC:37C665IR/666IR, 37C669/669FR,37N769, 37B72x/77x/78x/80x, 37C67x/68x/93x/93xAPM/93xFR, 37M60x/61x, 37N958FR - 450800 max,
+WinBond: W83877TF(TF ONLY, A/F/AF NOT supported) W83977A/AF/TF/ATF - 460800 max).
 .TP
 .B auto_irq
 During autoconfiguration, try to determine the IRQ.  This feature is
diff -ur -x .dep* -x .hdep* -x *.[oas] -x *~ -x #* -x *CVS* -x *.orig -x *.rej -x *.old -x .menu* -x asm -x local.h -x System.map -x autoconf.h -x compile.h -x version.h -x .version -x defkeymap.c -x uni_hash.tbl -x zImage -x vmlinu?* -x TAGS -x bootsect -x *RCS* -x conmakehash -x map -x build -x build -x configure -x *target* -x *.flags -x *.bak setserial-2.14.ofic/setserial.c setserial-2.14/setserial.c
--- setserial-2.14.ofic/setserial.c	Tue Jun  9 15:35:11 1998
+++ setserial-2.14/setserial.c	Fri Jun 23 00:14:12 2000
@@ -66,6 +66,7 @@
 #define CMD_CONFIG	10
 #define CMD_GETMULTI	11
 #define CMD_SETMULTI	12
+#define CMD_HISPEED	13
 
 #define FLAG_CAN_INVERT	0x0001
 #define FLAG_NEED_ARG	0x0002
@@ -109,6 +110,7 @@
 	CMD_WAIT2,	"closing_wait2",0,		0,		0, FLAG_NEED_ARG,
 #endif
 	CMD_CONFIG,	"autoconfig",	0,		0,		0, 0,
+	CMD_HISPEED,	"hispeed",	0,		0,		0, 0,
 	CMD_GETMULTI,	"get_multiport",0,		0,		0, 0,
 	CMD_SETMULTI,	"set_multiport",0,		0,		0, 0,
 	0,		0,		0,		0,		0, 0,
@@ -484,6 +486,27 @@
 			}
 			set_multiport(device, fd, &arg);
 			break;
+		case CMD_HISPEED:
+			{
+				struct serial_struct serinfo;
+				int baud_base;
+
+				if (ioctl(fd, TIOCGSERIAL, &serinfo) < 0) {
+					perror("Cannot get serial info");
+					exit(1);
+				}
+				baud_base = enable_hispeed(serinfo.port);
+				if (!baud_base)
+					printf( "Hispeed serial not detected\n" );
+				else {
+					serinfo.baud_base = baud_base;
+					if (ioctl(fd, TIOCSSERIAL, &new_serinfo) < 0) {
+						perror("Cannot set serial info");
+						exit(1);
+					}
+				}
+			} 
+			break;
 			
 		default:
 			fprintf(stderr, "Internal error: unhandled cmd #%d\n", p->cmd);
@@ -561,7 +584,8 @@
 	fprintf(stderr, "\t\t\t\tafter the reciver is disabled\n");
 #endif
 	fprintf(stderr, "\t^ fourport\tconfigure the port as an AST Fourport\n");
-	fprintf(stderr, "\t  autoconfigure\tautomatically configure the serial port\n");
+	fprintf(stderr, "\t  autoconfig\tautomatically configure the serial port\n");
+	fprintf(stderr, "\t  hispeed\ttry to make serail port capable of faster speeds\n");
 	fprintf(stderr, "\t^ auto_irq\ttry to determine irq during autoconfiguration\n");
 	fprintf(stderr, "\t^ skip_test\tskip UART test during autoconfiguration\n");
 	fprintf(stderr, "\n");
Only in setserial-2.14: setserial.cat
Only in setserial-2.14: setserial2
Only in setserial-2.14: setserial3

-- 
STOP THE WAR! Someone killed innocent Americans. That does not give
U.S. right to kill people in Afganistan.


