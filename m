Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316795AbSE3SN0>; Thu, 30 May 2002 14:13:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316796AbSE3SNZ>; Thu, 30 May 2002 14:13:25 -0400
Received: from ppp-217-133-209-102.dialup.tiscali.it ([217.133.209.102]:61146
	"EHLO home.ldb.ods.org") by vger.kernel.org with ESMTP
	id <S316795AbSE3SMR>; Thu, 30 May 2002 14:12:17 -0400
Subject: [PATCH] [2.4] ATM SAR support, based on SARlib
From: Luca Barbieri <ldb@ldb.ods.org>
To: Linux-Kernel ML <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-s7+TWHvobxmEDXilQJ2s"
X-Mailer: Ximian Evolution 1.0.5 
Date: 30 May 2002 20:12:09 +0200
Message-Id: <1022782329.1920.127.camel@ldb>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-s7+TWHvobxmEDXilQJ2s
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This code is a slightly version of Johan Verrept's SARlib.
It does ATM SAR (segmentation and reassembly, in other words it converts
upper layer packets to ATM cells and the opposite) in software.

diff --exclude-from=/home/ldb/src/linux-exclude -u -r -N linux-base/Documentation/networking/atmsar.txt linux/Documentation/networking/atmsar.txt
--- linux-base/Documentation/networking/atmsar.txt	Thu Jan  1 01:00:00 1970
+++ linux/Documentation/networking/atmsar.txt	Thu May 30 16:09:19 2002
@@ -0,0 +1,104 @@
+#
+## ATM SAR Library  (C) 2000, Johan Verrept (Johan.Verrept@advalvas.be)
+#
+# 30/may/2002, Luca Barbieri <ldb@ldb.ods.org>:
+#     "sarlib"/"SARlib" name replaced with "atmsar"/"ATM SAR"
+
+For updates, check the linux-atm mailing list or mail me.
+The updates will be very infrequent because I don't have much time.
+Any remarks, patches and bug fixes are welcome.
+
+WARNING: This is experimental software. Use at your own risk.
+
+License
+=======
+
+This code falls under the GNU Public License, see COPYING
+If you want to use this in a commercial product, contact me.
+
+Usage & requirements
+====================
+
+Usage: Just link this library to your driver/module/kernel.
+Requirements:
+	This needs the Linux ATM stuff, but can be easily ported to
+	any platform.
+
+API
+===
+
+The API to the ATM SAR is simple. At least, I tried to make it as simple as I
+could.  I alsi tried to map it to the ATM Linux API as much as I could.
+
+There is a atmsar_open() function which will initialize the atmsar_vcc
+structure with the provided parameters. The atmsar_close() function frees
+this all.
+the atmsar_open() function is passed in a type, all the header parts, a
+pointer to the Linux ATM vcc, a pointer to a list of atmsar_vcc's and a
+flags field.
+there are 2 flags available now:
+	ATMSAR_USE_53BYTE_CELL  will force atmsar_encode_rawcell() to produce
+53 byte cell in stead of the linux 52 byte cells.
+	ATMSAR_SET_PTI          this will cause the pti bit of the last cell
+int the provided buffer to be set ( by atmsar_encode_rawcell())
+
+Real SARing happens in the atmsar_encode_xxx() and atmsar_decode_xxx()
+functions. Everything is straight forward for the encoding of the data,
+althought there are a few assumptions.
+
+atmsar_encode_rawcell assumes it gets a multiple of 48 bytes.
+	if ATMSAR_SET_PTI is set, it assumes a full aal5 pdu is supplied.
+	It does NOT calculate the cell header CRC at the moment.
+
+atmsar_encode_aal5    assumes it gets a full aal5 pdu.
+
+The decode functions have no assumptions. Both decode functions need to be 
+repeated until they return NULL.  
+
+atmsar_decode_rawcell() requires a LIST of atmsar_vcc's. This allows the user 
+to pass in any cells they received, atmsar_decode_rawcell() will drop the 
+ones it doesn't know, the others are copied into the relevant atmsar_vcc 
+reassembly buffer.  Depending on the type of reassemly (only AAL5 at the
+moment) it will return a pointer to that buffer when a complete AAL5 pdu 
+has been received. The third argument will contains a pointer the relevant 
+atmsar_vcc.  You must repeat the call with the same arguments after
+processing the buffer, to allow atmsar_decode_rawcell() to process the
+remaining cells in the receive skb. It does NOT check the cell header crc.
+
+atmsar_decode_aal5() requires a complete AAL5 packet to process.
+This will do aal5 length and crc checking.  There is some intelligence in
+there that will try to recover from an illegal length.  It will take the
+length from the trailer and check whether the crc over this part is valid.
+This allows the ATM SAR to only drop 1 AAL5 pdu when the last cell of a pdu
+is lost. ( otherwise it would have to drop both...)
+
+There is also a atmsar_alloc_tx function now.  It is supposed to be called
+with a atmsar_vcc structure instead of a atm_vcc, I had to do this because I
+had no way of getting to the atmsar_vcc structure from the atm_vcc
+structure... the user program will have to wrap the atmsar_vcc function.
+BE CAREFULL!!  the atmsar_open function will copy the alloc_tx pointer from
+the atm_vcc and call it!  You cannot set the alloc_tx function in the vcc 
+BEFORE passing it to atmsar_open!! You will have to do it afterwards...
+
+To Do
+=====
+
+Lots to do.
+
+- Adding AAL1, AAL34 and maybe even AAL2 ( probably not, unless the
+	telephony thing wants it, need to look into it).
+- Add atm cell header crc calculation.
+- more optimalisations
+	- crc_calc / copy combinations.
+- completing support to run as well in userspace as in kernel space.
+	( replacing skb's with generalised functions, define for kernel
+	space to skb functions and to ATM SAR buffer system for user space.
+- completing buffer management on receive size.  introduced mru setting to
+	reduce problem. would maybe be better to go to scatter gather method.
+
+Acknowledgements
+================
+
+Thanks to :
+
+- Whoever wrote the CRC routines in linux/drivers/net/wan/sbni.c
diff --exclude-from=/home/ldb/src/linux-exclude -u -r -N linux-base/include/linux/atmsar.h linux/include/linux/atmsar.h
--- linux-base/include/linux/atmsar.h	Thu Jan  1 01:00:00 1970
+++ linux/include/linux/atmsar.h	Thu May 30 16:36:53 2002
@@ -0,0 +1,85 @@
+/*
+ *
+ *  General SAR library for ATM devices.
+ *
+ *  Copyright (c) 2000, Johan Verrept
+ *
+ *  This package is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *  
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
+ *
+ */
+
+#ifndef _ATMSAR_H_
+#define _ATMSAR_H_
+
+#include <linux/kernel.h>
+#include <linux/proc_fs.h>
+#include <linux/slab.h>
+#include <linux/atmdev.h>
+#include <linux/skbuff.h>
+#include <linux/types.h>
+#include <linux/atm.h>
+
+#define ATMSAR_USE_53BYTE_CELL  0x1L
+#define ATMSAR_SET_PTI          0x2L
+
+
+/* types */
+#define ATMSAR_TYPE_AAL0        ATM_AAL0
+#define ATMSAR_TYPE_AAL1        ATM_AAL1
+#define ATMSAR_TYPE_AAL2        ATM_AAL2
+#define ATMSAR_TYPE_AAL34       ATM_AAL34
+#define ATMSAR_TYPE_AAL5        ATM_AAL5
+
+
+/* default MTU's */
+#define ATMSAR_DEF_MTU_AAL0         48
+#define ATMSAR_DEF_MTU_AAL1         47
+#define ATMSAR_DEF_MTU_AAL2          0 /* not supported */
+#define ATMSAR_DEF_MTU_AAL34         0 /* not supported */
+#define ATMSAR_DEF_MTU_AAL5      65535 /* max mtu ..    */
+
+typedef struct atmsar_vcc_data {
+  struct atmsar_vcc_data   *next;
+
+  /* general atmsar flags, per connection */
+  int                flags;
+  int                type;
+
+  /* connection specific non-atmsar data */
+  struct sk_buff    *(*alloc_tx)(struct atm_vcc *vcc, unsigned int size);
+  struct atm_vcc    *vcc;
+  struct k_atm_aal_stats *stats;
+  unsigned short     mtu; /* max is actually  65k for AAL5... */
+
+  /* cell data */
+  unsigned int       vp;
+  unsigned int       vc;
+  unsigned char      gfc;
+  unsigned char      pti;
+  unsigned int       headerFlags;
+  unsigned long      atmHeader;
+   
+  /* raw cell reassembly */
+  struct sk_buff    *reasBuffer;
+  } atmsar_vcc_data_t;
+
+
+extern struct atmsar_vcc_data *atmsar_open (struct atmsar_vcc_data **list, struct atm_vcc *vcc, uint type, ushort vpi, ushort vci, unchar pti, unchar gfc, uint flags);
+extern void                    atmsar_close(struct atmsar_vcc_data **list, struct atmsar_vcc_data *vcc);
+
+extern struct sk_buff *atmsar_encode_rawcell (struct atmsar_vcc_data *ctx, struct sk_buff *skb);
+extern struct sk_buff *atmsar_encode_aal5    (struct atmsar_vcc_data *ctx, struct sk_buff *skb);
+
+struct sk_buff *atmsar_decode_rawcell (struct atmsar_vcc_data *list, struct sk_buff *skb, struct atmsar_vcc_data **ctx);
+struct sk_buff *atmsar_decode_aal5    (struct atmsar_vcc_data *ctx,  struct sk_buff *skb);
+
+struct sk_buff *atmsar_alloc_tx(struct atmsar_vcc_data *vcc, unsigned int size);
+
+#endif /* _ATMSAR_H_ */
diff --exclude-from=/home/ldb/src/linux-exclude -u -r -N linux-base/net/atm/Makefile linux/net/atm/Makefile
--- linux-base/net/atm/Makefile	Thu May 30 13:09:51 2002
+++ linux/net/atm/Makefile	Mon May 27 15:29:08 2002
@@ -9,12 +9,12 @@
 
 O_TARGET	:= atm.o
 
-export-objs 	:= common.o atm_misc.o raw.o resources.o ipcommon.o proc.o
+export-objs 	:= common.o atm_misc.o raw.o resources.o ipcommon.o proc.o atmsar.o
 
 list-multi	:= mpoa.o
 mpoa-objs	:= mpc.o mpoa_caches.o mpoa_proc.o
 
-obj-$(CONFIG_ATM) := addr.o pvc.o signaling.o svc.o common.o atm_misc.o raw.o resources.o
+obj-$(CONFIG_ATM) := addr.o pvc.o signaling.o svc.o common.o atm_misc.o raw.o resources.o atmsar.o
 
 ifeq ($(CONFIG_ATM_CLIP),y)
 obj-y += clip.o
diff --exclude-from=/home/ldb/src/linux-exclude -u -r -N linux-base/net/atm/atmsar.c linux/net/atm/atmsar.c
--- linux-base/net/atm/atmsar.c	Thu Jan  1 01:00:00 1970
+++ linux/net/atm/atmsar.c	Thu May 30 14:01:30 2002
@@ -0,0 +1,729 @@
+/*
+ *  General SAR library for ATM devices. 
+ * 
+ *  Written By Johan Verrept ( Johan.Verrept@advalvas.be )
+ *
+ *  Copyright (c) 2000, Johan Verrept
+ *
+ *  This package is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *  
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA. 
+
+Version 0.2.5-linuxkernel (30/may/2002, Luca Barbieri <ldb@ldb.ods.org>):
+        - shift expressions relaced with byteswap functions
+	- replaced "sarlib" with "atmsar"
+        - adaptations for inclusion in kernel tree
+
+Version 0.2.4:
+	- Fixed wrong buffer overrun check in sarlib_decode_rawcell()
+	  reported by Stephen Robinson <stephen.robinson@zen.co.uk>
+	- Fixed bug when input skb did not contain a multple of 52/53 bytes.
+	  (would happen when the speedtouch device resynced)
+	  also reported by Stephen Robinson <stephen.robinson@zen.co.uk>
+
+Version 0.2.3:
+	- Fixed wrong allocation size. caused memory corruption in some
+	  cases. Reported by Vladimir Dergachev <volodya@mindspring.com>
+	- Added some comments
+
+Version 0.2.2:
+	- Fixed CRCASM (patch from Linus Flannagan <linusf@netservices.eng.net>)
+	- Fixed problem when user did NOT use the SARLIB_USE_53BYTE_CELL flag.
+          (reported by  Piers Scannell <email@lot105.com> )
+	- No more in-buffer rewriting for cloned buffers.
+	- Removed the PII specific CFLAGS in the Makefile.
+
+Version 0.2.1:
+	- removed dependancy on alloc_tx. tis presented problems when using
+		this with the  br2684 code.
+
+Version 0.2:
+        - added AAL0 reassembly
+        - added alloc_tx support                  
+        - replaced alloc_skb in decode functions to dev_alloc_skb to allow
+                 calling from interrupt
+        - fixed embarassing AAL5 bug. I was setting the pti bit in the wrong
+                byte...
+        - fixed another emabrassing bug.. picked up the wrong crc type and
+                forgot to invert the crc result...
+        - fixed AAL5 length calculations.
+        - removed automatic skb freeing from encode functions.
+                This caused problems because i did kfree_skb it, while it
+                needed to be popped. I cannot determine though whether it
+                needs to be popped or not. Figu'e it out ye'self ;-)
+        - added mru field. This is the buffersize. sarlib_decode_aal0 will
+                use when it allocates a receive buffer. A stop gap for real
+		buffer management.
+
+Version 0.1:
+	- library created.
+	- only contains AAL5, AAL0 can be easily added. ( actually, only
+		AAL0 reassembly is missing)
+*/
+
+#include <linux/module.h>
+#include <linux/atmsar.h>
+
+static const char printk_header[] = "ATM SAR: ";
+
+#ifndef __KERNEL__
+
+/* user space functions */
+#define atomic_add(i,v)  *(v) += i
+#define atomic_inc(v)    *(v) ++
+
+#define Malloc(size)  malloc(size)
+
+#else
+/* kernel functions */
+
+#define Malloc(size)  dev_alloc_skb(size)
+#endif
+
+#define CRCASM 1
+
+/***********************
+ **
+ **  things to remember
+ **
+ ***********************/
+
+/*
+  1. the atmsar_vcc_data list pointer MUST be initialized to NULL
+  2. atmsar_encode_rawcell will drop incomplete cells.
+  3. ownership of the skb goes to the library !
+*/
+
+#define ATM_HDR_VPVC_MASK  (ATM_HDR_VPI_MASK | ATM_HDR_VCI_MASK)
+
+/***********************
+ **
+ **  LOCAL STRUCTURES
+ **
+ ***********************/
+
+/***********************
+ **
+ **  LOCAL MACROS
+ **
+ ***********************/
+
+#define ADD_HEADER(dest, header) *(*(u32**)&dest)++ = cpu_to_be32(header)
+
+/*
+ * CRC Routines from  net/wan/sbni.c)
+ * table generated by Rocksoft^tm Model CRC Algorithm Table Generation Program V1.0
+ */
+#define CRC32_REMAINDER CBF43926
+#define CRC32_INITIAL 0xffffffff
+#define CRC32(c,crc) (crc32tab[((size_t)(crc>>24) ^ (c)) & 0xff] ^ (((crc) << 8)))
+unsigned long crc32tab[256] = {
+	0x00000000L, 0x04C11DB7L, 0x09823B6EL, 0x0D4326D9L,
+	0x130476DCL, 0x17C56B6BL, 0x1A864DB2L, 0x1E475005L,
+	0x2608EDB8L, 0x22C9F00FL, 0x2F8AD6D6L, 0x2B4BCB61L,
+	0x350C9B64L, 0x31CD86D3L, 0x3C8EA00AL, 0x384FBDBDL,
+	0x4C11DB70L, 0x48D0C6C7L, 0x4593E01EL, 0x4152FDA9L,
+	0x5F15ADACL, 0x5BD4B01BL, 0x569796C2L, 0x52568B75L,
+	0x6A1936C8L, 0x6ED82B7FL, 0x639B0DA6L, 0x675A1011L,
+	0x791D4014L, 0x7DDC5DA3L, 0x709F7B7AL, 0x745E66CDL,
+	0x9823B6E0L, 0x9CE2AB57L, 0x91A18D8EL, 0x95609039L,
+	0x8B27C03CL, 0x8FE6DD8BL, 0x82A5FB52L, 0x8664E6E5L,
+	0xBE2B5B58L, 0xBAEA46EFL, 0xB7A96036L, 0xB3687D81L,
+	0xAD2F2D84L, 0xA9EE3033L, 0xA4AD16EAL, 0xA06C0B5DL,
+	0xD4326D90L, 0xD0F37027L, 0xDDB056FEL, 0xD9714B49L,
+	0xC7361B4CL, 0xC3F706FBL, 0xCEB42022L, 0xCA753D95L,
+	0xF23A8028L, 0xF6FB9D9FL, 0xFBB8BB46L, 0xFF79A6F1L,
+	0xE13EF6F4L, 0xE5FFEB43L, 0xE8BCCD9AL, 0xEC7DD02DL,
+	0x34867077L, 0x30476DC0L, 0x3D044B19L, 0x39C556AEL,
+	0x278206ABL, 0x23431B1CL, 0x2E003DC5L, 0x2AC12072L,
+	0x128E9DCFL, 0x164F8078L, 0x1B0CA6A1L, 0x1FCDBB16L,
+	0x018AEB13L, 0x054BF6A4L, 0x0808D07DL, 0x0CC9CDCAL,
+	0x7897AB07L, 0x7C56B6B0L, 0x71159069L, 0x75D48DDEL,
+	0x6B93DDDBL, 0x6F52C06CL, 0x6211E6B5L, 0x66D0FB02L,
+	0x5E9F46BFL, 0x5A5E5B08L, 0x571D7DD1L, 0x53DC6066L,
+	0x4D9B3063L, 0x495A2DD4L, 0x44190B0DL, 0x40D816BAL,
+	0xACA5C697L, 0xA864DB20L, 0xA527FDF9L, 0xA1E6E04EL,
+	0xBFA1B04BL, 0xBB60ADFCL, 0xB6238B25L, 0xB2E29692L,
+	0x8AAD2B2FL, 0x8E6C3698L, 0x832F1041L, 0x87EE0DF6L,
+	0x99A95DF3L, 0x9D684044L, 0x902B669DL, 0x94EA7B2AL,
+	0xE0B41DE7L, 0xE4750050L, 0xE9362689L, 0xEDF73B3EL,
+	0xF3B06B3BL, 0xF771768CL, 0xFA325055L, 0xFEF34DE2L,
+	0xC6BCF05FL, 0xC27DEDE8L, 0xCF3ECB31L, 0xCBFFD686L,
+	0xD5B88683L, 0xD1799B34L, 0xDC3ABDEDL, 0xD8FBA05AL,
+	0x690CE0EEL, 0x6DCDFD59L, 0x608EDB80L, 0x644FC637L,
+	0x7A089632L, 0x7EC98B85L, 0x738AAD5CL, 0x774BB0EBL,
+	0x4F040D56L, 0x4BC510E1L, 0x46863638L, 0x42472B8FL,
+	0x5C007B8AL, 0x58C1663DL, 0x558240E4L, 0x51435D53L,
+	0x251D3B9EL, 0x21DC2629L, 0x2C9F00F0L, 0x285E1D47L,
+	0x36194D42L, 0x32D850F5L, 0x3F9B762CL, 0x3B5A6B9BL,
+	0x0315D626L, 0x07D4CB91L, 0x0A97ED48L, 0x0E56F0FFL,
+	0x1011A0FAL, 0x14D0BD4DL, 0x19939B94L, 0x1D528623L,
+	0xF12F560EL, 0xF5EE4BB9L, 0xF8AD6D60L, 0xFC6C70D7L,
+	0xE22B20D2L, 0xE6EA3D65L, 0xEBA91BBCL, 0xEF68060BL,
+	0xD727BBB6L, 0xD3E6A601L, 0xDEA580D8L, 0xDA649D6FL,
+	0xC423CD6AL, 0xC0E2D0DDL, 0xCDA1F604L, 0xC960EBB3L,
+	0xBD3E8D7EL, 0xB9FF90C9L, 0xB4BCB610L, 0xB07DABA7L,
+	0xAE3AFBA2L, 0xAAFBE615L, 0xA7B8C0CCL, 0xA379DD7BL,
+	0x9B3660C6L, 0x9FF77D71L, 0x92B45BA8L, 0x9675461FL,
+	0x8832161AL, 0x8CF30BADL, 0x81B02D74L, 0x857130C3L,
+	0x5D8A9099L, 0x594B8D2EL, 0x5408ABF7L, 0x50C9B640L,
+	0x4E8EE645L, 0x4A4FFBF2L, 0x470CDD2BL, 0x43CDC09CL,
+	0x7B827D21L, 0x7F436096L, 0x7200464FL, 0x76C15BF8L,
+	0x68860BFDL, 0x6C47164AL, 0x61043093L, 0x65C52D24L,
+	0x119B4BE9L, 0x155A565EL, 0x18197087L, 0x1CD86D30L,
+	0x029F3D35L, 0x065E2082L, 0x0B1D065BL, 0x0FDC1BECL,
+	0x3793A651L, 0x3352BBE6L, 0x3E119D3FL, 0x3AD08088L,
+	0x2497D08DL, 0x2056CD3AL, 0x2D15EBE3L, 0x29D4F654L,
+	0xC5A92679L, 0xC1683BCEL, 0xCC2B1D17L, 0xC8EA00A0L,
+	0xD6AD50A5L, 0xD26C4D12L, 0xDF2F6BCBL, 0xDBEE767CL,
+	0xE3A1CBC1L, 0xE760D676L, 0xEA23F0AFL, 0xEEE2ED18L,
+	0xF0A5BD1DL, 0xF464A0AAL, 0xF9278673L, 0xFDE69BC4L,
+	0x89B8FD09L, 0x8D79E0BEL, 0x803AC667L, 0x84FBDBD0L,
+	0x9ABC8BD5L, 0x9E7D9662L, 0x933EB0BBL, 0x97FFAD0CL,
+	0xAFB010B1L, 0xAB710D06L, 0xA6322BDFL, 0xA2F33668L,
+	0xBCB4666DL, 0xB8757BDAL, 0xB5365D03L, 0xB1F740B4L
+};
+
+#ifdef CRCASM
+
+#if defined(__i386__)
+unsigned long
+calc_crc(char *mem, int len, unsigned initial)
+{
+	unsigned crc, dummy_len;
+      __asm__("xorl %%eax,%%eax\n\t" "1:\n\t" "movl %%edx,%%eax\n\t" "shrl $16,%%eax\n\t" "lodsb\n\t" "xorb %%ah,%%al\n\t" "andl $255,%%eax\n\t" "shll $8,%%edx\n\t" "xorl (%%edi,%%eax,4),%%edx\n\t" "loop 1b":"=d"(crc),
+		"=c"
+		(dummy_len)
+      :	"S"(mem), "D"(&crc32tab[0]), "1"(len), "0"(initial)
+      :	"eax");
+	return crc;
+}
+#else
+#undef CRCASM
+#endif
+
+#endif
+
+#ifndef CRCASM
+unsigned long
+calc_crc(char *mem, int len, unsigned initial)
+{
+	unsigned crc;
+	crc = initial;
+
+	for (; len; mem++, len--) {
+		crc = CRC32(*mem, crc);
+	}
+	return (crc);
+}
+#endif
+
+#define crc32( crc, mem, len) calc_crc(mem, len, crc);
+
+/* ATOMIC version of alloc_tx */
+struct sk_buff *
+atmsar_alloc_skb_wrapper(struct atm_vcc *vcc, unsigned int size)
+{
+	struct sk_buff *skb;
+
+	if (atomic_read(&vcc->tx_inuse) && !atm_may_send(vcc, size)) {
+		printk_dbg("sorry: tx_inuse = %d, size = %d, sndbuf = %d",
+			    atomic_read(&vcc->tx_inuse), size, vcc->sk->sndbuf);
+		return NULL;
+	}
+	skb = alloc_skb(size, GFP_ATOMIC);
+	if (!skb)
+		return NULL;
+	atomic_add(skb->truesize + ATM_PDU_OVHD, &vcc->tx_inuse);
+	return skb;
+}
+
+struct sk_buff *
+atmsar_alloc_tx(struct atmsar_vcc_data *vcc, unsigned int size)
+{
+	struct sk_buff *tmp = NULL;
+	int bufsize = 0;
+
+	switch (vcc->type) {
+	case ATMSAR_TYPE_AAL0:
+		/* reserving adequate headroom */
+		bufsize =
+		    size +
+		    (((size / 48) +
+		      1) * ((vcc->flags & ATMSAR_USE_53BYTE_CELL) ? 5 : 4));
+		break;
+	case ATMSAR_TYPE_AAL1:
+		/* reserving adequate headroom */
+		bufsize =
+		    size +
+		    (((size / 47) +
+		      1) * ((vcc->flags & ATMSAR_USE_53BYTE_CELL) ? 5 : 4));
+		break;
+	case ATMSAR_TYPE_AAL2:
+	case ATMSAR_TYPE_AAL34:
+		/* not supported */
+		break;
+	case ATMSAR_TYPE_AAL5:
+		/* reserving adequate tailroom */
+		bufsize = size + (((size + 8 + 47) / 48) * 48);
+		break;
+	}
+
+	printk_dbg("requested size %d, allocating size %d", size, bufsize);
+	tmp = vcc->alloc_tx(vcc->vcc, bufsize);
+	skb_put(tmp, bufsize);
+
+	return tmp;
+}
+
+struct atmsar_vcc_data *
+atmsar_open(struct atmsar_vcc_data **list, struct atm_vcc *vcc, uint type,
+	    ushort vpi, ushort vci, unchar pti, unchar gfc, uint flags)
+{
+	struct atmsar_vcc_data *new;
+
+	new = kmalloc(sizeof (struct atmsar_vcc_data), GFP_KERNEL);
+
+	if (!new)
+		return NULL;
+
+	if (!vcc)
+		return NULL;
+
+	memset(new, 0, sizeof (struct atmsar_vcc_data));
+	new->vcc = vcc;
+/*
+ * This gives problems with the ATM layer alloc_tx().
+ * It is not usable from interrupt context and for
+ * some reason this is used in interurpt context 
+ * with br2684.c
+ *
+  if (vcc->alloc_tx)
+    new->alloc_tx  = vcc->alloc_tx;
+  else
+*/
+	new->alloc_tx = atmsar_alloc_skb_wrapper;
+
+	new->stats = vcc->stats;
+	new->type = type;
+	new->next = NULL;
+	new->gfc = gfc;
+	new->vp = vpi;
+	new->vc = vci;
+	new->pti = pti;
+
+	switch (type) {
+	case ATMSAR_TYPE_AAL0:
+		new->mtu = ATMSAR_DEF_MTU_AAL0;
+		break;
+	case ATMSAR_TYPE_AAL1:
+		new->mtu = ATMSAR_DEF_MTU_AAL1;
+		break;
+	case ATMSAR_TYPE_AAL2:
+		new->mtu = ATMSAR_DEF_MTU_AAL2;
+		break;
+	case ATMSAR_TYPE_AAL34:
+		/* not supported */
+		new->mtu = ATMSAR_DEF_MTU_AAL34;
+		break;
+	case ATMSAR_TYPE_AAL5:
+		new->mtu = ATMSAR_DEF_MTU_AAL5;
+		break;
+	}
+
+	new->atmHeader = ((unsigned long) gfc << ATM_HDR_GFC_SHIFT)
+	    | ((unsigned long) vpi << ATM_HDR_VPI_SHIFT)
+	    | ((unsigned long) vci << ATM_HDR_VCI_SHIFT)
+	    | ((unsigned long) pti << ATM_HDR_PTI_SHIFT);
+	new->flags = flags;
+	new->next = NULL;
+	new->reasBuffer = NULL;
+
+	new->next = *list;
+	*list = new;
+
+	printk_dbg("allocated new atmsar vcc 0x%p with vp %d vc %d", new, vpi,
+		    vci);
+
+	return new;
+}
+
+void
+atmsar_close(struct atmsar_vcc_data **list, struct atmsar_vcc_data *vcc)
+{
+	struct atmsar_vcc_data *work;
+
+	if (*list == vcc) {
+		*list = (*list)->next;
+	} else {
+		for (work = *list; work && work->next && (work->next != vcc);
+		     work = work->next) ;
+
+		/* return if not found */
+		if (work->next != vcc)
+			return;
+
+		work->next = work->next->next;
+	}
+
+	if (vcc->reasBuffer) {
+		dev_kfree_skb(vcc->reasBuffer);
+	}
+
+	printk_dbg("allocated atmsar vcc 0x%p with vp %d vc %d", vcc, vcc->vp,
+		    vcc->vc);
+
+	kfree(vcc);
+}
+
+/***********************
+ **
+ **    ENCODE FUNCTIONS
+ **
+ ***********************/
+
+struct sk_buff *
+atmsar_encode_rawcell(struct atmsar_vcc_data *ctx, struct sk_buff *skb)
+{
+	int number_of_cells = (skb->len) / 48;
+	int total_length =
+	    number_of_cells * (ctx->flags & ATMSAR_USE_53BYTE_CELL ? 53 : 52);
+	unsigned char *source;
+	unsigned char *target;
+	struct sk_buff *out = NULL;
+	int i;
+
+	printk_dbg("called (0x%p, 0x%p)", ctx, skb);
+
+	if (skb_cloned(skb)
+	    || (skb_headroom(skb) <
+		(number_of_cells *
+		 (ctx->flags & ATMSAR_USE_53BYTE_CELL ? 5 : 4)))) {
+		printk_dbg
+		    ("allocating new skb: ctx->alloc_tx = 0x%p, ctx->vcc = 0x%p",
+		     ctx->alloc_tx, ctx->vcc);
+		/* get new skb */
+		out = ctx->alloc_tx(ctx->vcc, total_length);
+		if (!out)
+			return NULL;
+
+		skb_put(out, total_length);
+		source = skb->data;
+		target = out->data;
+	} else {
+		printk_dbg("sufficient headroom");
+		source = skb->data;
+		skb_push(skb,
+			 number_of_cells *
+			 ((ctx->flags & ATMSAR_USE_53BYTE_CELL) ? 5 : 4));
+		target = skb->data;
+		out = skb;
+	}
+
+	printk_dbg("source 0x=%p, target 0x%p", source, target);
+
+	if (ctx->flags & ATMSAR_USE_53BYTE_CELL) {
+		for (i = 0; i < number_of_cells; i++) {
+			ADD_HEADER(target, ctx->atmHeader);
+			*target++ = (char) 0xEC;
+			memcpy(target, source, 48);
+			target += 48;
+			source += 48;
+			printk_dbg("source 0x=%p, target 0x%p", source,
+				    target);
+		}
+	} else {
+		for (i = 0; i < number_of_cells; i++) {
+			ADD_HEADER(target, ctx->atmHeader);
+			memcpy(target, source, 48);
+			target += 48;
+			source += 48;
+			printk_dbg("source 0x=%p, target 0x%p", source,
+				    target);
+		};
+	}
+
+	if (ctx->flags & ATMSAR_SET_PTI) {
+		/* setting pti bit in last cell */
+		*(target - (ctx->flags & ATMSAR_USE_53BYTE_CELL ? 50 : 49)) |=
+		    0x2;
+	}
+
+	/* update stats */
+	if (ctx->stats && (ctx->type <= ATMSAR_TYPE_AAL1))
+		atomic_add(number_of_cells, &(ctx->stats->tx));
+
+	printk_dbg("return 0x%p (length %d)", out, out->len);
+	return out;
+}
+
+struct sk_buff *
+atmsar_encode_aal5(struct atmsar_vcc_data *ctx, struct sk_buff *skb)
+{
+	int length, pdu_length;
+	unsigned char *trailer;
+	unsigned char *pad;
+	uint crc = 0xffffffff;
+
+	printk_dbg("(0x%p, 0x%p) called", ctx, skb);
+
+	/* determine aal5 length */
+	pdu_length = skb->len;
+	length = ((pdu_length + 8 + 47) / 48) * 48;
+
+	if (skb_tailroom(skb) < (length - pdu_length)) {
+		struct sk_buff *out;
+		printk_dbg
+		    ("allocating new skb: ctx->alloc_tx = 0x%p, ctx->vcc = 0x%p",
+		     ctx->alloc_tx, ctx->vcc);
+		/* get new skb */
+		out = ctx->alloc_tx(ctx->vcc, length);
+		if (!out)
+			return NULL;
+
+		printk_dbg("out->data = 0x%p", out->data);
+		printk_dbg("pdu length %d, allocated length %d", skb->len,
+			    length);
+		memcpy(out->data, skb->data, skb->len);
+		skb_put(out, skb->len);
+
+		skb = out;
+	}
+
+	printk_dbg("skb->data = 0x%p", skb->data);
+	/* note end of pdu and add length */
+	pad = skb_put(skb, length - pdu_length);
+	trailer = skb->tail - 8;
+
+	printk_dbg("trailer = 0x%p", trailer);
+
+	/* zero padding space */
+	memset(pad, 0, length - pdu_length - 8);
+
+	/* add trailer */
+	*trailer++ = (unsigned char) 0;	/* UU  = 0 */
+	*trailer++ = (unsigned char) 0;	/* CPI = 0 */
+	*(*(u16 **) & trailer)++ = cpu_to_be16(pdu_length);
+	crc = ~crc32(crc, skb->data, length - 4);
+	*(*(u32 **) & trailer)++ = cpu_to_be32(crc);
+
+	/* update stats */
+	if (ctx->stats)
+		atomic_inc(&ctx->stats->tx);
+
+	printk_dbg("return 0x%p (length %d)", skb, skb->len);
+	return skb;
+}
+
+/***********************
+ **
+ **  DECODE FUNCTIONS
+ **
+ ***********************/
+
+struct sk_buff *
+atmsar_decode_rawcell(struct atmsar_vcc_data *list, struct sk_buff *skb,
+		      struct atmsar_vcc_data **ctx)
+{
+	while (skb->len) {
+		unsigned char *cell = skb->data;
+		unsigned char *cell_payload;
+		struct atmsar_vcc_data *vcc = list;
+		unsigned long atmHeader = be32_to_cpu(*(u32 *) cell);
+
+		printk_dbg("called (0x%p, 0x%p, 0x%p)", list, skb, ctx);
+		printk_dbg("skb->data %p, skb->tail %p", skb->data, skb->tail);
+
+		if (!list || !skb || !ctx)
+			return NULL;
+		if (!skb->data || !skb->tail)
+			return NULL;
+
+		/* here should the header CRC check be... */
+
+		/* look up correct vcc */
+		for (;
+		     vcc
+		     && ((vcc->atmHeader & ATM_HDR_VPVC_MASK) !=
+			 (atmHeader & ATM_HDR_VPVC_MASK)); vcc = vcc->next) ;
+
+		printk_dbg("found vcc %p for packet on vp %d, vc %d", vcc,
+			    (int) ((atmHeader & ATM_HDR_VPI_MASK) >>
+				   ATM_HDR_VPI_SHIFT),
+			    (int) ((atmHeader & ATM_HDR_VCI_MASK) >>
+				   ATM_HDR_VCI_SHIFT));
+
+		if (vcc
+		    && (skb->len >=
+			(vcc->flags & ATMSAR_USE_53BYTE_CELL ? 53 : 52))) {
+			cell_payload =
+			    cell +
+			    (vcc->flags & ATMSAR_USE_53BYTE_CELL ? 5 : 4);
+
+			switch (vcc->type) {
+			case ATMSAR_TYPE_AAL0:
+				/* case ATMSAR_TYPE_AAL1: when we have a decode AAL1 function... */
+				{
+					struct sk_buff *tmp = Malloc(vcc->mtu);
+
+					if (tmp) {
+						memcpy(tmp->tail, cell_payload,
+						       48);
+						skb_put(tmp, 48);
+
+						if (vcc->stats)
+							atomic_inc(&vcc->stats->
+								   rx);
+
+						skb_pull(skb,
+							 (vcc->
+							  flags &
+							  ATMSAR_USE_53BYTE_CELL
+							  ? 53 : 52));
+						printk_dbg
+						    ("returns ATMSAR_TYPE_AAL0 pdu 0x%p with length %d",
+						     tmp, tmp->len);
+						return tmp;
+					};
+				}
+				break;
+			case ATMSAR_TYPE_AAL1:
+			case ATMSAR_TYPE_AAL2:
+			case ATMSAR_TYPE_AAL34:
+				/* not supported */
+				break;
+			case ATMSAR_TYPE_AAL5:
+				if (!vcc->reasBuffer)
+					vcc->reasBuffer = Malloc(vcc->mtu);
+
+				/* if alloc fails, we just drop the cell. it is possible that we can still
+				 * receive cells on other vcc's 
+				 */
+				if (vcc->reasBuffer) {
+					/* if (buffer overrun) discard received cells until now */
+					if ((vcc->reasBuffer->len) >
+					    (vcc->mtu - 48))
+						skb_trim(vcc->reasBuffer, 0);
+
+					/* copy data */
+					memcpy(vcc->reasBuffer->tail,
+					       cell_payload, 48);
+					skb_put(vcc->reasBuffer, 48);
+
+					/* check for end of buffer */
+					if (cell[3] & 0x2) {
+						struct sk_buff *tmp;
+
+						/* the aal5 buffer ends here, cut the buffer. */
+						/* buffer will always have at least one whole cell, so */
+						/* don't need to check return from skb_pull */
+						skb_pull(skb,
+							 (vcc->
+							  flags &
+							  ATMSAR_USE_53BYTE_CELL
+							  ? 53 : 52));
+						*ctx = vcc;
+						tmp = vcc->reasBuffer;
+						vcc->reasBuffer = NULL;
+
+						printk_dbg
+						    ("returns ATMSAR_TYPE_AAL5 pdu 0x%p with length %d",
+						     tmp, tmp->len);
+						return tmp;
+					}
+				}
+				break;
+			};
+			/* flush the cell */
+			/* buffer will always contain at least one whole cell, so don't */
+			/* need to check return value from skb_pull */
+			skb_pull(skb,
+				 (vcc->
+				  flags & ATMSAR_USE_53BYTE_CELL ? 53 : 52));
+		} else {
+			/* If data is corrupt and skb doesn't hold a whole cell, flush the lot */
+			if (skb_pull
+			    (skb,
+			     (list->
+			      flags & ATMSAR_USE_53BYTE_CELL ? 53 : 52)) ==
+			    NULL) {
+				skb_trim(skb, 0);
+			}
+		}
+	}
+
+	return NULL;
+};
+
+struct sk_buff *
+atmsar_decode_aal5(struct atmsar_vcc_data *ctx, struct sk_buff *skb)
+{
+	uint crc = 0xffffffff;
+	uint length, pdu_crc, pdu_length;
+
+	printk_dbg("atmsar_decode_aal5 (0x%p, 0x%p) called", ctx, skb);
+
+	if (skb->len && (skb->len % 48))
+		return NULL;
+
+	length = be16_to_cpu(*(u16 *) (skb->tail - 6));
+	pdu_crc = be32_to_cpu(*(u32 *) (skb->tail - 4));
+	pdu_length = ((length + 47 + 8) / 48) * 48;
+
+	printk_dbg
+	    ("skb->len = %d, length = %d, pdu_crc = 0x%x, pdu_length = %d",
+	     skb->len, length, pdu_crc, pdu_length);
+
+	/* is skb long enough ? */
+	if (skb->len < pdu_length) {
+		if (ctx->stats)
+			atomic_inc(&ctx->stats->rx_err);
+		return NULL;
+	}
+
+	/* is skb too long ? */
+	if (skb->len > pdu_length) {
+		printk_dbg("warning: readjusting illegal size %d -> %d",
+			    skb->len, pdu_length);
+		/* buffer is too long. we can try to recover
+		 * if we discard the first part of the skb.
+		 * the crc will decide whether this was ok
+		 */
+		skb_pull(skb, skb->len - pdu_length);
+	}
+
+	crc = ~crc32(crc, skb->data, pdu_length - 4);
+
+	/* check crc */
+	if (pdu_crc != crc) {
+		printk_dbg("crc check failed!");
+
+		if (ctx->stats)
+			atomic_inc(&ctx->stats->rx_err);
+		return NULL;
+	}
+
+	/* pdu is ok */
+	skb_trim(skb, length);
+
+	/* update stats */
+	if (ctx->stats)
+		atomic_inc(&ctx->stats->rx);
+
+	printk_dbg("atmsar_decode_aal5 returns pdu 0x%p with length %d", skb,
+		    skb->len);
+	return skb;
+};
+
+EXPORT_SYMBOL(atmsar_open);
+EXPORT_SYMBOL(atmsar_close);
+EXPORT_SYMBOL(atmsar_encode_rawcell);
+EXPORT_SYMBOL(atmsar_encode_aal5);
+EXPORT_SYMBOL(atmsar_decode_rawcell);
+EXPORT_SYMBOL(atmsar_decode_aal5);
+EXPORT_SYMBOL(atmsar_alloc_tx);

--=-s7+TWHvobxmEDXilQJ2s
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQA89mt5djkty3ft5+cRAs0gAJ4ryXme8xRhrHClGz3CS8DD50oyKgCaAz+b
cUcgbaKxWTSR8EohTpJLpoM=
=OyHI
-----END PGP SIGNATURE-----

--=-s7+TWHvobxmEDXilQJ2s--
