Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264648AbUJAW46@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264648AbUJAW46 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 18:56:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266643AbUJAW46
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 18:56:58 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:49054
	"EHLO debian.tglx.de") by vger.kernel.org with ESMTP
	id S264648AbUJAWz4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 18:55:56 -0400
Subject: [PATCH / RFC] Shared Reed-Solomon ECC Library
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@osdl.org>
Content-Type: multipart/mixed; boundary="=-aMHXPaK2XRMzawIKdQUP"
Organization: linutronix
Message-Id: <1096670893.25635.41.camel@thomas>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 02 Oct 2004 00:48:14 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-aMHXPaK2XRMzawIKdQUP
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,

the attached patch contains a shared Reed-Solomon Library analogous to
the shared zlib.

(N)AND FLASH is gaining popularity and there are a lot of ASIC/SoC/FPGA
controllers around which implement hardware support for Reed-Solomon
error correction. As usual they use different implementations
(polynomials etc.). So it's obvious to use a shared library for the
common tasks of error correction.

A short scan through the kernel revealed that at least the ftape driver
uses Reed-Solomon error correction. It could be easily converted to use
the shared library code. 

The encoder/decoder code is lifted from the GPL'd userspace RS-library
written by Phil Karn. I modified/wrapped it to provide the different
functions which we need in the MTD/NAND code.

The library is tested in extenso under various MTD/NAND configurations.

The lib should be usable for other purposes right out of the box.
Adjustment for currently not implemented functionality is an easy task.

I'm willing to take the maintainership of the library.

Please apply,

tglx



--=-aMHXPaK2XRMzawIKdQUP
Content-Disposition: attachment; filename=rslib.patch
Content-Type: text/x-patch; name=rslib.patch; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 7bit

diff -urN linux-2.6.9-rc2.org/lib/Kconfig linux-2.6.9-rc2/lib/Kconfig
--- linux-2.6.9-rc2.org/lib/Kconfig	2004-09-16 22:15:16.000000000 +0200
+++ linux-2.6.9-rc2/lib/Kconfig	2004-09-16 22:20:19.000000000 +0200
@@ -39,5 +39,11 @@
 config ZLIB_DEFLATE
 	tristate
 
+#
+# reed solomon support is select'ed if needed
+#
+config REED_SOLOMON
+	tristate
+
 endmenu
 
diff -urN linux-2.6.9-rc2.org/lib/Makefile linux-2.6.9-rc2/lib/Makefile
--- linux-2.6.9-rc2.org/lib/Makefile	2004-09-16 22:15:16.000000000 +0200
+++ linux-2.6.9-rc2/lib/Makefile	2004-09-16 22:20:19.000000000 +0200
@@ -22,6 +22,7 @@
 
 obj-$(CONFIG_ZLIB_INFLATE) += zlib_inflate/
 obj-$(CONFIG_ZLIB_DEFLATE) += zlib_deflate/
+obj-$(CONFIG_REED_SOLOMON) += reed_solomon/
 
 hostprogs-y	:= gen_crc32table
 clean-files	:= crc32table.h
diff -urN linux-2.6.9-rc2.org/lib/reed_solomon/decode_rs.c linux-2.6.9-rc2/lib/reed_solomon/decode_rs.c
--- linux-2.6.9-rc2.org/lib/reed_solomon/decode_rs.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.9-rc2/lib/reed_solomon/decode_rs.c	2004-10-01 23:44:39.000000000 +0200
@@ -0,0 +1,235 @@
+/* 
+ * lib/reed_solomon/decode_rs.c
+ *
+ * Overview:
+ *   Generic Reed Solomon encoder / decoder library
+ *   
+ * Copyright 2002, Phil Karn, KA9Q
+ * May be used under the terms of the GNU General Public License (GPL)
+ *
+ * Adaption to the kernel by Thomas Gleixner (tglx@linutronix.de)
+ *
+ * $Id: decode_rs.c,v 1.4 2004/10/01 21:44:39 gleixner Exp $
+ *
+ */
+
+/* Generic data witdh independend code which is included by the 
+ * wrappers.
+ */
+{ 
+	int deg_lambda, el, deg_omega;
+	int i, j, r, k, PAD;
+	uint16_t u, q, tmp, num1, num2, den, discr_r, syn_error;
+	/* Err+Eras Locator poly and syndrome poly */
+	uint16_t lambda[NROOTS + 1], syn[NROOTS];	
+	uint16_t b[NROOTS + 1], t[NROOTS + 1], omega[NROOTS + 1];
+	uint16_t root[NROOTS], reg[NROOTS + 1], loc[NROOTS];
+	int count = 0;
+	uint16_t msk = (uint16_t) rs->nn;
+
+	/* Check length parameter for validity */
+	PAD = NN - NROOTS - len;
+	if (PAD < 0 || PAD >= NN)
+		return -ERANGE;
+		
+	/* Deos the caller provide the syndrome ? */
+	if (s != NULL) 
+		goto decode;
+
+	/* form the syndromes; i.e., evaluate data(x) at roots of g(x) */
+	for (i = 0; i < NROOTS; i++)
+		syn[i] = (((uint16_t) data[0]) ^ invmsk) & msk;
+
+	for (j = 1; j < len; j++) {
+		for (i = 0; i < NROOTS; i++) {
+			if (syn[i] == 0) {
+				syn[i] = (((uint16_t) data[j]) ^ invmsk) & msk;
+			} else {
+				syn[i] = ((((uint16_t) data[j]) ^ invmsk) & msk) ^ ALPHA_TO[MODNN(INDEX_OF[syn[i]] + (FCR+i)*PRIM)];
+			}
+		}
+	}
+
+	for (j = 0; j < NROOTS; j++) {
+		for (i = 0; i < NROOTS; i++) {
+			if (syn[i] == 0) {
+				syn[i] = ((uint16_t) par[j]) & msk;
+			} else {
+				syn[i] = (((uint16_t) par[j]) & msk) ^ ALPHA_TO[MODNN(INDEX_OF[syn[i]] + (FCR+i)*PRIM)];
+			}
+		}
+	}
+	s = syn;
+
+	/* Convert syndromes to index form, checking for nonzero condition */
+	syn_error = 0;
+	for (i = 0; i < NROOTS; i++) {
+		syn_error |= s[i];
+		s[i] = INDEX_OF[s[i]];
+	}
+
+	if (!syn_error) {
+		/* if syndrome is zero, data[] is a codeword and there are no
+		 * errors to correct. So return data[] unmodified
+		 */
+		count = 0;
+		goto finish;
+	}
+
+ decode:
+	memset (&lambda[1], 0, NROOTS * sizeof (lambda[0]));
+	lambda[0] = 1;
+
+	if (no_eras > 0) {
+		/* Init lambda to be the erasure locator polynomial */
+		lambda[1] = ALPHA_TO[MODNN (PRIM * (NN - 1 - eras_pos[0]))];
+		for (i = 1; i < no_eras; i++) {
+			u = MODNN (PRIM * (NN - 1 - eras_pos[i]));
+			for (j = i + 1; j > 0; j--) {
+				tmp = INDEX_OF[lambda[j - 1]];
+				if (tmp != A0)
+					lambda[j] ^= ALPHA_TO[MODNN (u + tmp)];
+			}
+		}
+	}
+
+	for (i = 0; i < NROOTS + 1; i++)
+		b[i] = INDEX_OF[lambda[i]];
+
+	/*
+	 * Begin Berlekamp-Massey algorithm to determine error+erasure
+	 * locator polynomial
+	 */
+	r = no_eras;
+	el = no_eras;
+	while (++r <= NROOTS) {	/* r is the step number */
+		/* Compute discrepancy at the r-th step in poly-form */
+		discr_r = 0;
+		for (i = 0; i < r; i++) {
+			if ((lambda[i] != 0) && (s[r - i - 1] != A0)) {
+				discr_r ^= ALPHA_TO[MODNN (INDEX_OF[lambda[i]] + s[r - i - 1])];
+			}
+		}
+		discr_r = INDEX_OF[discr_r];	/* Index form */
+		if (discr_r == A0) {
+			/* 2 lines below: B(x) <-- x*B(x) */
+			memmove (&b[1], b, NROOTS * sizeof (b[0]));
+			b[0] = A0;
+		} else {
+			/* 7 lines below: T(x) <-- lambda(x) - discr_r*x*b(x) */
+			t[0] = lambda[0];
+			for (i = 0; i < NROOTS; i++) {
+				if (b[i] != A0)
+					t[i + 1] = lambda[i + 1] ^ ALPHA_TO[MODNN (discr_r + b[i])];
+				else
+					t[i + 1] = lambda[i + 1];
+			}
+			if (2 * el <= r + no_eras - 1) {
+				el = r + no_eras - el;
+				/*
+				 * 2 lines below: B(x) <-- inv(discr_r) *
+				 * lambda(x)
+				 */
+				for (i = 0; i <= NROOTS; i++)
+					b[i] = (lambda[i] == 0) ? A0 : MODNN (INDEX_OF[lambda[i]] - discr_r + NN);
+			} else {
+				/* 2 lines below: B(x) <-- x*B(x) */
+				memmove (&b[1], b, NROOTS * sizeof (b[0]));
+				b[0] = A0;
+			}
+			memcpy (lambda, t, (NROOTS + 1) * sizeof (t[0]));
+		}
+	}
+
+	/* Convert lambda to index form and compute deg(lambda(x)) */
+	deg_lambda = 0;
+	for (i = 0; i < NROOTS + 1; i++) {
+		lambda[i] = INDEX_OF[lambda[i]];
+		if (lambda[i] != A0)
+			deg_lambda = i;
+	}
+	/* Find roots of the error+erasure locator polynomial by Chien search */
+	memcpy (&reg[1], &lambda[1], NROOTS * sizeof (reg[0]));
+	count = 0;		/* Number of roots of lambda(x) */
+	for (i = 1, k = IPRIM - 1; i <= NN; i++, k = MODNN (k + IPRIM)) {
+		q = 1;		/* lambda[0] is always 0 */
+		for (j = deg_lambda; j > 0; j--) {
+			if (reg[j] != A0) {
+				reg[j] = MODNN (reg[j] + j);
+				q ^= ALPHA_TO[reg[j]];
+			}
+		}
+		if (q != 0)
+			continue;	/* Not a root */
+		/* store root (index-form) and error location number */
+		root[count] = i;
+		loc[count] = k;
+		/* If we've already found max possible roots,
+		 * abort the search to save time
+		 */
+		if (++count == deg_lambda)
+			break;
+	}
+	if (deg_lambda != count) {
+		/*
+		 * deg(lambda) unequal to number of roots => uncorrectable
+		 * error detected
+		 */
+		count = -1;
+		goto finish;
+	}
+	/*
+	 * Compute err+eras evaluator poly omega(x) = s(x)*lambda(x) (modulo
+	 * x**NROOTS). in index form. Also find deg(omega).
+	 */
+	deg_omega = deg_lambda - 1;
+	for (i = 0; i <= deg_omega; i++) {
+		tmp = 0;
+		for (j = i; j >= 0; j--) {
+			if ((s[i - j] != A0) && (lambda[j] != A0))
+				tmp ^=
+				    ALPHA_TO[MODNN (s[i - j] + lambda[j])];
+		}
+		omega[i] = INDEX_OF[tmp];
+	}
+
+	/*
+	 * Compute error values in poly-form. num1 = omega(inv(X(l))), num2 =
+	 * inv(X(l))**(FCR-1) and den = lambda_pr(inv(X(l))) all in poly-form
+	 */
+	for (j = count - 1; j >= 0; j--) {
+		num1 = 0;
+		for (i = deg_omega; i >= 0; i--) {
+			if (omega[i] != A0)
+				num1 ^= ALPHA_TO[MODNN (omega[i] + i * root[j])];
+		}
+		num2 = ALPHA_TO[MODNN (root[j] * (FCR - 1) + NN)];
+		den = 0;
+
+		/* lambda[i+1] for i even is the formal derivative lambda_pr of lambda[i] */
+		for (i = min (deg_lambda, NROOTS - 1) & ~1; i >= 0; i -= 2) {
+			if (lambda[i + 1] != A0)
+				den ^= ALPHA_TO[MODNN (lambda[i + 1] + i * root[j])];
+		}
+		/* Apply error to data */
+		if (num1 != 0 && loc[j] >= PAD) {
+			uint16_t cor = ALPHA_TO[MODNN (INDEX_OF[num1] + INDEX_OF[num2] + NN - INDEX_OF[den])];
+			/* Store the error correction pattern, if a correction buffer is available */
+			if (corr) {
+				corr[j] = cor;
+			} else {
+				/* If a data buffer is given and the error is inside the message, correct it */
+				if (data && (loc[j] < (NN - NROOTS)))
+					data[loc[j] - PAD] ^= cor;
+			}
+		}
+	}
+
+finish:
+	if (eras_pos != NULL) {
+		for (i = 0; i < count; i++)
+			eras_pos[i] = loc[i] - PAD;
+	}
+	return count;
+
+}
diff -urN linux-2.6.9-rc2.org/lib/reed_solomon/encode_rs.c linux-2.6.9-rc2/lib/reed_solomon/encode_rs.c
--- linux-2.6.9-rc2.org/lib/reed_solomon/encode_rs.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.9-rc2/lib/reed_solomon/encode_rs.c	2004-09-19 14:09:40.000000000 +0200
@@ -0,0 +1,45 @@
+/* 
+ * lib/reed_solomon/encode_rs.c
+ *
+ * Overview:
+ *   Generic Reed Solomon encoder / decoder library
+ *   
+ * Copyright 2002, Phil Karn, KA9Q
+ * May be used under the terms of the GNU General Public License (GPL)
+ *
+ * Adaption to the kernel by Thomas Gleixner (tglx@linutronix.de)
+ *
+ * $Id: encode_rs.c,v 1.2 2004/09/19 12:09:40 gleixner Exp $
+ *
+ */
+
+/* Generic data witdh independend code which is included by the 
+ * wrappers.
+ * int encode_rsX (struct rs_control *rs, uintX_t *data, int len, uintY_t *par)
+ */
+{
+	int i, j, pad;
+	uint16_t feedback;
+	uint16_t msk = (uint16_t) NN;
+
+	/* Check length parameter for validity */
+	pad = NN - NROOTS - len;
+	if (pad < 0 || pad >= NN)
+		return -ERANGE;
+
+	for (i = 0; i < len; i++) {
+		feedback = INDEX_OF[((((uint16_t) data[i])^invmsk) & msk) ^ par[0]];
+		/* feedback term is non-zero */
+		if (feedback != A0) {	
+			for (j = 1; j < NROOTS; j++)
+				par[j] ^= ALPHA_TO[MODNN (feedback + GENPOLY[NROOTS - j])];
+		}
+		/* Shift */
+		memmove (&par[0], &par[1], sizeof (uint16_t) * (NROOTS - 1));
+		if (feedback != A0)
+			par[NROOTS - 1] = ALPHA_TO[MODNN (feedback + GENPOLY[0])];
+		else
+			par[NROOTS - 1] = 0;
+	}
+	return 0;
+}
diff -urN linux-2.6.9-rc2.org/lib/reed_solomon/Makefile linux-2.6.9-rc2/lib/reed_solomon/Makefile
--- linux-2.6.9-rc2.org/lib/reed_solomon/Makefile	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.9-rc2/lib/reed_solomon/Makefile	2004-09-17 20:38:35.000000000 +0200
@@ -0,0 +1,6 @@
+#
+# This is a modified version of reed solomon lib, 
+#
+
+obj-$(CONFIG_REED_SOLOMON) += reed_solomon.o
+
diff -urN linux-2.6.9-rc2.org/lib/reed_solomon/reed_solomon.c linux-2.6.9-rc2/lib/reed_solomon/reed_solomon.c
--- linux-2.6.9-rc2.org/lib/reed_solomon/reed_solomon.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.9-rc2/lib/reed_solomon/reed_solomon.c	2004-10-01 23:44:39.000000000 +0200
@@ -0,0 +1,364 @@
+/* 
+ * lib/reed_solomon/rslib.c
+ *
+ * Overview:
+ *   Generic Reed Solomon encoder / decoder library
+ *   
+ * Copyright (C) 2004 Thomas Gleixner (tglx@linutronix.de)
+ *
+ * Reed Solomon code lifted from reed solomon library written by Phil Karn
+ * Copyright 2002 Phil Karn, KA9Q
+ *
+ * $Id: rslib.c,v 1.3 2004/10/01 21:44:39 gleixner Exp $
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * Description:
+ *	
+ * The generic Reed Solomon library provides runtime configurable
+ * encoding / decoding of RS codes.
+ * Each user must call init_rs to get a pointer to a rs_control
+ * structure for the given rs parameters. This structure is either
+ * generated or a already available matching control structure is used.
+ * If a structure is generated then the polynominal arrays for
+ * fast encoding / decoding are built. This can take some time so
+ * make sure not to call this function from a timecritical path.
+ * Usually a module / driver should initialize the neccecary 
+ * rs_control structure on module / driver init and release it
+ * on exit.
+ * The encoding puts the calculated syndrome into a given syndrom 
+ * buffer. 
+ * The decoding is a two step process. The first step calculates
+ * the syndrome over the received (data + syndrom) and calls the
+ * second stage, which does the decoding / error correction itself.
+ * Many hw encoders provide a syndrom calculation over the received
+ * data + syndrom and can call the second stage directly.
+ *
+ */
+
+#include <linux/errno.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/rslib.h>
+#include <linux/slab.h>
+#include <asm/semaphore.h>
+
+/* This list holds all currently allocated rs control structures */
+static LIST_HEAD (rslist);
+/* Protection for the list */
+static DECLARE_MUTEX(rslistlock);
+
+/** 
+ * rs_init - Initialize a Reed-Solomon codec
+ *
+ * @symsize:	symbol size, bits (1-8)
+ * @gfpoly:	Field generator polynomial coefficients
+ * @fcr:	first root of RS code generator polynomial, index form
+ * @prim:	primitive element to generate polynomial roots
+ * @nroots:	RS code generator polynomial degree (number of roots)
+ *
+ * Allocate a control structure and the polynom arrays for faster
+ * en/decoding. Fill the arrays according to the given parameters
+ */
+static struct rs_control *rs_init (int symsize, int gfpoly, int fcr, int prim, int nroots)
+{
+	struct rs_control *rs;
+	int i, j, sr, root, iprim;
+
+	/* Allocate the control structure */
+	rs = (struct rs_control *) kmalloc (sizeof (struct rs_control), GFP_KERNEL);
+	if (rs == NULL)
+		return NULL;
+
+	INIT_LIST_HEAD(&rs->list);
+
+	rs->mm = symsize;
+	rs->nn = (1 << symsize) - 1;
+	rs->fcr = fcr;
+	rs->prim = prim;
+	rs->nroots = nroots;
+	rs->gfpoly = gfpoly;
+
+	/* Allocate the arrays */
+	rs->alpha_to = (uint16_t *) kmalloc (sizeof (uint16_t) * (rs->nn + 1), GFP_KERNEL);
+	if (rs->alpha_to == NULL)
+		goto errrs;
+
+	rs->index_of = (uint16_t *) kmalloc (sizeof (uint16_t) * (rs->nn + 1), GFP_KERNEL);
+	if (rs->index_of == NULL)
+		goto erralp;
+
+	rs->genpoly = (uint16_t *) kmalloc (sizeof (uint16_t) * (rs->nroots + 1), GFP_KERNEL);
+	if (rs->genpoly == NULL)
+		goto erridx;
+
+	/* Generate Galois field lookup tables */
+	rs->index_of[0] = rs->nn;	/* log(zero) = -inf */
+	rs->alpha_to[rs->nn] = 0;	/* alpha**-inf = 0 */
+	sr = 1;
+	for (i = 0; i < rs->nn; i++) {
+		rs->index_of[sr] = i;
+		rs->alpha_to[i] = sr;
+		sr <<= 1;
+		if (sr & (1 << symsize))
+			sr ^= gfpoly;
+		sr &= rs->nn;
+	}
+	/* If it's not primitive, exit */
+	if (sr != 1)
+		goto errpol;
+
+	/* Find prim-th root of 1, used in decoding */
+	for (iprim = 1; (iprim % prim) != 0; iprim += rs->nn);
+	/* prim-th root of 1, index form */
+	rs->iprim = iprim / prim;
+
+	/* Form RS code generator polynomial from its roots */
+	rs->genpoly[0] = 1;
+	for (i = 0, root = fcr * prim; i < nroots; i++, root += prim) {
+		rs->genpoly[i + 1] = 1;
+
+		/* Multiply rs->genpoly[] by  @**(root + x) */
+		for (j = i; j > 0; j--) {
+			if (rs->genpoly[j] != 0)
+				rs->genpoly[j] = rs->genpoly[j -1] ^ rs->alpha_to[(rs->index_of[rs->genpoly[j]] + root) % rs->nn];
+			else
+				rs->genpoly[j] = rs->genpoly[j - 1];
+		}
+		/* rs->genpoly[0] can never be zero */
+		rs->genpoly[0] = rs->alpha_to[(rs->index_of[rs->genpoly[0]] + root) % rs->nn];
+	}
+	/* convert rs->genpoly[] to index form for quicker encoding */
+	for (i = 0; i <= nroots; i++)
+		rs->genpoly[i] = rs->index_of[rs->genpoly[i]];
+	return rs;
+
+	/* Error exit */
+errpol:
+	kfree (rs->genpoly);
+erridx:
+	kfree (rs->index_of);
+erralp:
+	kfree (rs->alpha_to);
+errrs:
+	kfree (rs);
+	return NULL;
+}
+
+
+/** 
+ *  free_rs - Free the rs control structure, if its not longer used
+ *
+ *  @rs:	the control structure which is not longer used by the
+ *		caller
+ */
+void free_rs (struct rs_control *rs)
+{
+	down (&rslistlock);
+	rs->users--;
+	if (!rs->users) {
+		list_del (&rs->list);
+		kfree (rs->alpha_to);
+		kfree (rs->index_of);
+		kfree (rs->genpoly);
+		kfree (rs);
+	}
+	up (&rslistlock);
+}
+
+/** 
+ * init_rs - Find a matching or allocate a new rs control structure
+ *
+ *  @symsize:	the symbol size (number of bits)
+ *  @gfpoly:	the extended Galois field generator polynomial coefficients,
+ *		with the 0th coefficient in the low order bit. The polynomial
+ *		must be primitive;
+ *  @fcr:  	the first consecutive root of the rs code generator polynomial 
+ *		in index form
+ *  @prim:	primitive element to generate polynomial roots
+ *  @nroots:	RS code generator polynomial degree (number of roots)
+ */
+struct rs_control *init_rs (int symsize, int gfpoly, int fcr, int prim, int nroots)
+{
+	struct list_head	*tmp;
+	struct rs_control	*rs;
+
+	/* Sanity checks */
+	if (symsize < 1)
+		return NULL;
+	if (fcr < 0 || fcr >= (1<<symsize))
+    		return NULL;
+	if (prim <= 0 || prim >= (1<<symsize))
+    		return NULL;
+	if (nroots < 0 || nroots >= (1<<symsize))
+		return NULL;
+	
+	down (&rslistlock);
+
+	/* Walk through the list and look for a matching entry */
+	list_for_each (tmp, &rslist) {
+		rs = list_entry (tmp, struct rs_control, list);
+		if (symsize != rs->mm)
+			continue;
+		if (gfpoly != rs->gfpoly)
+			continue;
+		if (fcr != rs->fcr)
+			continue;	
+		if (prim != rs->prim)
+			continue;	
+		if (nroots != rs->nroots)
+			continue;
+		/* We have a matching one already */
+		rs->users++;
+		goto out;
+	}
+
+	/* Create a new one */
+	rs = rs_init (symsize, gfpoly, fcr, prim, nroots);
+	if (rs) {
+		rs->users = 1;
+		list_add (&rs->list, &rslist);
+	}
+out:	
+	up (&rslistlock);
+	return rs;
+}
+
+/** 
+ *  encode_rs8 - Calculate the parity for data values (8bit data width)
+ *
+ *  @rs:	the rs control structure
+ *  @data:	data field of a given type
+ *  @len:	data length 
+ *  @par:	parity data field, must be initialized by caller (usually all 0)
+ *  @invmsk:	invert data mask (will be xored on data)
+ *
+ *  The parity uses a uint16_t data type to enable
+ *  symbol size > 8. The calling code must take care of encoding of the
+ *  syndrome result for storage itself.
+ */
+int encode_rs8 (struct rs_control *rs, uint8_t *data, int len, uint16_t *par, uint16_t invmsk)
+{
+#include "encode_rs.c"
+}
+
+/** 
+ *  decode_rs8 - Decode codeword (8bit data width)
+ *
+ *  @rs:	the rs control structure
+ *  @data:	data field of a given type
+ *  @par:	received parity data field
+ *  @len:	data length
+ *  @s:		syndrome data field (if NULL, syndrome is calculated)
+ *  @no_eras:	number of erasures
+ *  @eras_pos:	position of erasures, can be NULL
+ *  @invmsk:	invert data mask (will be xored on data, not on parity!)
+ *  @corr:	buffer to store correction bitmask on eras_pos
+ *
+ *  The syndrome and parity uses a uint16_t data type to enable
+ *  symbol size > 8. The calling code must take care of decoding of the
+ *  syndrome result and the received parity before calling this code.
+ */
+int decode_rs8 (struct rs_control *rs, uint8_t *data, uint16_t *par, int len,
+		 uint16_t *s, int no_eras, int *eras_pos, uint16_t invmsk, uint16_t *corr)
+{
+#include "decode_rs.c"
+}
+
+/**
+ *  encode_rs16 - Calculate the parity for data values (16bit data width)
+ *
+ *  @rs:	the rs control structure
+ *  @data:	data field of a given type
+ *  @len:	data length 
+ *  @par:	parity data field, must be initialized by caller (usually all 0)
+ *  @invmsk:	invert data mask (will be xored on data, not on parity!)
+ *
+ *  Each field in the data array contains up to symbol size bits of valid data.
+ */
+int encode_rs16 (struct rs_control *rs, uint16_t *data, int len, uint16_t *par, uint16_t invmsk)
+{
+#include "encode_rs.c"
+}
+
+/** 
+ *  decode_rs16 - Decode codeword (16bit data width)
+ *
+ *  @rs:	the rs control structure
+ *  @data:	data field of a given type
+ *  @par:	received parity data field
+ *  @len:	data length
+ *  @s:		syndrome data field (if NULL, syndrome is calculated)
+ *  @no_eras:	number of erasures
+ *  @eras_pos:	position of erasures, can be NULL
+ *  @invmsk:	invert data mask (will be xored on data, not on parity!) 
+ *  @corr:	buffer to store correction bitmask on eras_pos
+ *
+ *  Each field in the data array contains up to symbol size bits of valid data.
+ */
+int decode_rs16 (struct rs_control *rs, uint16_t *data, uint16_t *par, int len,
+		 uint16_t *s, int no_eras, int *eras_pos, uint16_t invmsk, uint16_t *corr)
+{
+#include "decode_rs.c"
+}
+
+/** 
+ *  encode_rs32 - Calculate the parity for data values (32bit data width)
+ *
+ *  @rs:	the rs control structure
+ *  @data:	data field of a given type
+ *  @len:	data length 
+ *  @par:	parity data field, must be initialized by caller (usually all 0)
+ *  @invmsk:	invert data mask (will be xored on data)
+ *
+ *  The parity uses a uint16_t data type due to the fact that
+ *  we can't handle symbol size >= 16 bit as the polynominal arrays would 
+ *  be to large and the computation would be extreme slow.
+ *  Each field in the data array contains up to symbol size bits of data.
+ */
+int encode_rs32 (struct rs_control *rs, uint32_t *data, int len, uint16_t *par, uint16_t invmsk)
+{
+#include "encode_rs.c"
+}
+
+/** 
+ *  decode_rs32 - Decode codeword (32bit data width)
+ *
+ *  @rs:	the rs control structure
+ *  @data:	data field of a given type
+ *  @par:	received parity data field
+ *  @len:	data length
+ *  @s:		syndrome data field (if NULL, syndrome is calculated)
+ *  @no_eras:	number of erasures
+ *  @eras_pos:	position of erasures, can be NULL
+ *  @invmsk:	invert data mask (will be xored on data, not on parity!)
+ *  @corr:	buffer to store correction bitmask on eras_pos
+ *
+ *  The syndrome and parity use a uint16_t data type due to the fact that
+ *  we can't handle symbol size > 16 as the polynominal arrays would be to 
+ *  large and the computation would be extreme slow. The calling code must 
+ *  take care of decoding of the syndrome result and the received parity 
+ *  before calling this code.
+ *  Each field in the data array contains up to symbol size bits of data.
+ */
+int decode_rs32 (struct rs_control *rs, uint32_t *data, uint16_t *par, int len,
+		 uint16_t *s, int no_eras, int *eras_pos, uint16_t invmsk, uint16_t *corr)
+{
+#include "decode_rs.c"
+}
+
+EXPORT_SYMBOL(encode_rs8);
+EXPORT_SYMBOL(encode_rs16);
+EXPORT_SYMBOL(encode_rs32);
+EXPORT_SYMBOL(decode_rs8);
+EXPORT_SYMBOL(decode_rs16);
+EXPORT_SYMBOL(decode_rs32);
+EXPORT_SYMBOL(init_rs);
+EXPORT_SYMBOL(free_rs);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Reed Solomon encoder/decoder");
+MODULE_AUTHOR("Phil Karn, Thomas Gleixner");
diff -urN linux-2.6.9-rc2.org/include/linux/rslib.h linux-2.6.9-rc2/include/linux/rslib.h
--- linux-2.6.9-rc2.org/include/linux/rslib.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.9-rc2/include/linux/rslib.h	2004-10-01 23:43:50.000000000 +0200
@@ -0,0 +1,99 @@
+/* 
+ * include/linux/rslib.h
+ *
+ * Overview:
+ *   Generic Reed Solomon encoder / decoder library
+ *   
+ * Copyright (C) 2004 Thomas Gleixner (tglx@linutronix.de)
+ *
+ * RS code lifted from reed solomon library written by Phil Karn
+ * Copyright 2002 Phil Karn, KA9Q
+ *
+ * $Id: rslib.h,v 1.2 2004/10/01 21:43:50 gleixner Exp $
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef _RSLIB_H_
+#define _RSLIB_H_
+
+#include <linux/list.h>
+
+/** 
+ * struct rs_contol - rs control structure
+ * 
+ * @mm:		Bits per symbol
+ * @nn:		Symbols per block (= (1<<mm)-1)
+ * @alpha_to:	log lookup table
+ * @index_of:	Antilog lookup table
+ * @genpoly:	Generator polynomial 
+ * @nroots:	Number of generator roots = number of parity symbols
+ * @fcr:	First consecutive root, index form
+ * @prim:	Primitive element, index form 
+ * @iprim:	prim-th root of 1, index form 
+ * @gfpoly:	The primitive generator polynominal 
+ * @users:	Users of this structure 
+ * @list:	List entry for the rs control list
+*/
+struct rs_control {
+	int 		mm;
+	int 		nn;
+	uint16_t	*alpha_to;
+	uint16_t	*index_of;
+	uint16_t	*genpoly;
+	int 		nroots;
+	int 		fcr;
+	int 		prim;
+	int 		iprim;
+	int		gfpoly;
+	int		users;
+	struct list_head list;
+};
+
+/* General purpose RS codec, 8-bit data width, symbol width 1-15 bit  */
+int encode_rs8 (struct rs_control *rs, uint8_t *data, int len, uint16_t *par, uint16_t invmsk);
+int decode_rs8 (struct rs_control *rs, uint8_t *data, uint16_t *par, int len, 
+		uint16_t *s, int no_eras, int *eras_pos, uint16_t invmsk, uint16_t *corr);
+
+/* General purpose RS codec, 16-bit data width, symbol width 1-15 bit  */
+int encode_rs16 (struct rs_control *rs, uint16_t *data, int len, uint16_t *par, uint16_t invmsk);
+int decode_rs16 (struct rs_control *rs, uint16_t *data, uint16_t *par, int len,
+		uint16_t *s, int no_eras, int *eras_pos, uint16_t invmsk, uint16_t *corr);
+
+/* General purpose RS codec, 32-bit data width, symbol width 1-15 bit  */
+int encode_rs32 (struct rs_control *rs, uint32_t *data, int len, uint16_t *par, uint16_t invmsk);
+int decode_rs32 (struct rs_control *rs, uint32_t *data, uint16_t *par, int len,
+		uint16_t *s, int no_eras, int *eras_pos, uint16_t invmsk, uint16_t *corr);
+
+/* Create or get a matching rs control structure */
+struct rs_control *init_rs (int symsize, int gfpoly, int fcr, int prim, int nroots);
+
+/* Release a rs control structure */
+void free_rs (struct rs_control *rs);
+
+/* Internal usage only */
+static inline int modnn (struct rs_control *rs, int x)
+{
+	while (x >= rs->nn) {
+		x -= rs->nn;
+		x = (x >> rs->mm) + (x & rs->nn);
+	}
+	return x;
+}
+
+#define MODNN(x) modnn(rs,x)
+#define MM (rs->mm)
+#define NN (rs->nn)
+#define ALPHA_TO (rs->alpha_to) 
+#define INDEX_OF (rs->index_of)
+#define GENPOLY (rs->genpoly)
+#define NROOTS (rs->nroots)
+#define FCR (rs->fcr)
+#define PRIM (rs->prim)
+#define IPRIM (rs->iprim)
+#define A0 (NN)
+
+#endif
+

--=-aMHXPaK2XRMzawIKdQUP--

