Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263103AbTFGLpV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jun 2003 07:45:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263150AbTFGLpV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jun 2003 07:45:21 -0400
Received: from dp.samba.org ([66.70.73.150]:26601 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S263103AbTFGLov (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jun 2003 07:44:51 -0400
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16097.53638.261084.917085@argo.ozlabs.ibm.com>
Date: Sat, 7 Jun 2003 21:50:30 +1000
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Fix check warnings in PPP code
X-Mailer: VM 7.16 under Emacs 21.3.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

This patch removes the warnings that the check program came up with in
the PPP code: ppp_async.c, ppp_deflate.c and ppp_generic.c.  This
involved adding __user and converting K&R-style function definitions
to ANSI-style.  I also took the time to add some extra comments to
ppp_deflate.c explaining in more detail what each function does and
what its arguments are.

Please apply.

Thanks,
Paul.

diff -urN linux-2.5/drivers/net/ppp_async.c pmac-2.5/drivers/net/ppp_async.c
--- linux-2.5/drivers/net/ppp_async.c	2003-04-25 09:17:22.000000000 +1000
+++ pmac-2.5/drivers/net/ppp_async.c	2003-06-07 17:45:00.000000000 +1000
@@ -427,12 +427,12 @@
 		break;
 
 	case PPPIOCGXASYNCMAP:
-		if (copy_to_user((void *) arg, ap->xaccm, sizeof(ap->xaccm)))
+		if (copy_to_user((void __user *) arg, ap->xaccm, sizeof(ap->xaccm)))
 			break;
 		err = 0;
 		break;
 	case PPPIOCSXASYNCMAP:
-		if (copy_from_user(accm, (void *) arg, sizeof(accm)))
+		if (copy_from_user(accm, (void __user *) arg, sizeof(accm)))
 			break;
 		accm[2] &= ~0x40000000U;	/* can't escape 0x5e */
 		accm[3] |= 0x60000000U;		/* must escape 0x7d, 0x7e */
diff -urN linux-2.5/drivers/net/ppp_deflate.c pmac-2.5/drivers/net/ppp_deflate.c
--- linux-2.5/drivers/net/ppp_deflate.c	2003-05-07 14:25:43.000000000 +1000
+++ pmac-2.5/drivers/net/ppp_deflate.c	2003-06-07 19:36:29.000000000 +1000
@@ -57,29 +57,31 @@
 
 #define DEFLATE_OVHD	2		/* Deflate overhead/packet */
 
-static void	*z_comp_alloc __P((unsigned char *options, int opt_len));
-static void	*z_decomp_alloc __P((unsigned char *options, int opt_len));
-static void	z_comp_free __P((void *state));
-static void	z_decomp_free __P((void *state));
-static int	z_comp_init __P((void *state, unsigned char *options,
+static void	*z_comp_alloc(unsigned char *options, int opt_len);
+static void	*z_decomp_alloc(unsigned char *options, int opt_len);
+static void	z_comp_free(void *state);
+static void	z_decomp_free(void *state);
+static int	z_comp_init(void *state, unsigned char *options,
 				 int opt_len,
-				 int unit, int hdrlen, int debug));
-static int	z_decomp_init __P((void *state, unsigned char *options,
+				 int unit, int hdrlen, int debug);
+static int	z_decomp_init(void *state, unsigned char *options,
 				   int opt_len,
-				   int unit, int hdrlen, int mru, int debug));
-static int	z_compress __P((void *state, unsigned char *rptr,
+				   int unit, int hdrlen, int mru, int debug);
+static int	z_compress(void *state, unsigned char *rptr,
 				unsigned char *obuf,
-				int isize, int osize));
-static void	z_incomp __P((void *state, unsigned char *ibuf, int icnt));
-static int	z_decompress __P((void *state, unsigned char *ibuf,
-				int isize, unsigned char *obuf, int osize));
-static void	z_comp_reset __P((void *state));
-static void	z_decomp_reset __P((void *state));
-static void	z_comp_stats __P((void *state, struct compstat *stats));
-
-static void
-z_comp_free(arg)
-    void *arg;
+				int isize, int osize);
+static void	z_incomp(void *state, unsigned char *ibuf, int icnt);
+static int	z_decompress(void *state, unsigned char *ibuf,
+				int isize, unsigned char *obuf, int osize);
+static void	z_comp_reset(void *state);
+static void	z_decomp_reset(void *state);
+static void	z_comp_stats(void *state, struct compstat *stats);
+
+/**
+ *	z_comp_free - free the memory used by a compressor
+ *	@arg:	pointer to the private state for the compressor.
+ */
+static void z_comp_free(void *arg)
 {
 	struct ppp_deflate_state *state = (struct ppp_deflate_state *) arg;
 
@@ -91,13 +93,21 @@
 	}
 }
 
-/*
- * Allocate space for a compressor.
+/**
+ *	z_comp_alloc - allocate space for a compressor.
+ *	@options: pointer to CCP option data
+ *	@opt_len: length of the CCP option at @options.
+ *
+ *	The @options pointer points to the a buffer containing the
+ *	CCP option data for the compression being negotiated.  It is
+ *	formatted according to RFC1979, and describes the window
+ *	size that the peer is requesting that we use in compressing
+ *	data to be sent to it.
+ *
+ *	Returns the pointer to the private state for the compressor,
+ *	or NULL if we could not allocate enough memory.
  */
-static void *
-z_comp_alloc(options, opt_len)
-    unsigned char *options;
-    int opt_len;
+static void *z_comp_alloc(unsigned char *options, int opt_len)
 {
 	struct ppp_deflate_state *state;
 	int w_size;
@@ -135,11 +145,23 @@
 	return NULL;
 }
 
-static int
-z_comp_init(arg, options, opt_len, unit, hdrlen, debug)
-    void *arg;
-    unsigned char *options;
-    int opt_len, unit, hdrlen, debug;
+/**
+ *	z_comp_init - initialize a previously-allocated compressor.
+ *	@arg:	pointer to the private state for the compressor
+ *	@options: pointer to the CCP option data describing the
+ *		compression that was negotiated with the peer
+ *	@opt_len: length of the CCP option data at @options
+ *	@unit:	PPP unit number for diagnostic messages
+ *	@hdrlen: ignored (present for backwards compatibility)
+ *	@debug:	debug flag; if non-zero, debug messages are printed.
+ *
+ *	The CCP options described by @options must match the options
+ *	specified when the compressor was allocated.  The compressor
+ *	history is reset.  Returns 0 for failure (CCP options don't
+ *	match) or 1 for success.
+ */
+static int z_comp_init(void *arg, unsigned char *options, int opt_len,
+		       int unit, int hdrlen, int debug)
 {
 	struct ppp_deflate_state *state = (struct ppp_deflate_state *) arg;
 
@@ -160,9 +182,14 @@
 	return 1;
 }
 
-static void
-z_comp_reset(arg)
-    void *arg;
+/**
+ *	z_comp_reset - reset a previously-allocated compressor.
+ *	@arg:	pointer to private state for the compressor.
+ *
+ *	This clears the history for the compressor and makes it
+ *	ready to start emitting a new compressed stream.
+ */
+static void z_comp_reset(void *arg)
 {
 	struct ppp_deflate_state *state = (struct ppp_deflate_state *) arg;
 
@@ -170,12 +197,19 @@
 	zlib_deflateReset(&state->strm);
 }
 
-int
-z_compress(arg, rptr, obuf, isize, osize)
-    void *arg;
-    unsigned char *rptr;	/* uncompressed packet (in) */
-    unsigned char *obuf;	/* compressed packet (out) */
-    int isize, osize;
+/**
+ *	z_compress - compress a PPP packet with Deflate compression.
+ *	@arg:	pointer to private state for the compressor
+ *	@rptr:	uncompressed packet (input)
+ *	@obuf:	compressed packet (output)
+ *	@isize:	size of uncompressed packet
+ *	@osize:	space available at @obuf
+ *
+ *	Returns the length of the compressed packet, or 0 if the
+ *	packet is incompressible.
+ */
+int z_compress(void *arg, unsigned char *rptr, unsigned char *obuf,
+	       int isize, int osize)
 {
 	struct ppp_deflate_state *state = (struct ppp_deflate_state *) arg;
 	int r, proto, off, olen, oavail;
@@ -251,19 +285,24 @@
 	return olen;
 }
 
-static void
-z_comp_stats(arg, stats)
-    void *arg;
-    struct compstat *stats;
+/**
+ *	z_comp_stats - return compression statistics for a compressor
+ *		or decompressor.
+ *	@arg:	pointer to private space for the (de)compressor
+ *	@stats:	pointer to a struct compstat to receive the result.
+ */
+static void z_comp_stats(void *arg, struct compstat *stats)
 {
 	struct ppp_deflate_state *state = (struct ppp_deflate_state *) arg;
 
 	*stats = state->stats;
 }
 
-static void
-z_decomp_free(arg)
-    void *arg;
+/**
+ *	z_decomp_free - Free the memory used by a decompressor.
+ *	@arg:	pointer to private space for the decompressor.
+ */
+static void z_decomp_free(void *arg)
 {
 	struct ppp_deflate_state *state = (struct ppp_deflate_state *) arg;
 
@@ -275,13 +314,21 @@
 	}
 }
 
-/*
- * Allocate space for a decompressor.
+/**
+ *	z_decomp_alloc - allocate space for a decompressor.
+ *	@options: pointer to CCP option data
+ *	@opt_len: length of the CCP option at @options.
+ *
+ *	The @options pointer points to the a buffer containing the
+ *	CCP option data for the compression being negotiated.  It is
+ *	formatted according to RFC1979, and describes the window
+ *	size that we are requesting the peer to use in compressing
+ *	data to be sent to us.
+ *
+ *	Returns the pointer to the private state for the decompressor,
+ *	or NULL if we could not allocate enough memory.
  */
-static void *
-z_decomp_alloc(options, opt_len)
-    unsigned char *options;
-    int opt_len;
+static void *z_decomp_alloc(unsigned char *options, int opt_len)
 {
 	struct ppp_deflate_state *state;
 	int w_size;
@@ -317,11 +364,24 @@
 	return NULL;
 }
 
-static int
-z_decomp_init(arg, options, opt_len, unit, hdrlen, mru, debug)
-    void *arg;
-    unsigned char *options;
-    int opt_len, unit, hdrlen, mru, debug;
+/**
+ *	z_decomp_init - initialize a previously-allocated decompressor.
+ *	@arg:	pointer to the private state for the decompressor
+ *	@options: pointer to the CCP option data describing the
+ *		compression that was negotiated with the peer
+ *	@opt_len: length of the CCP option data at @options
+ *	@unit:	PPP unit number for diagnostic messages
+ *	@hdrlen: ignored (present for backwards compatibility)
+ *	@mru:	maximum length of decompressed packets
+ *	@debug:	debug flag; if non-zero, debug messages are printed.
+ *
+ *	The CCP options described by @options must match the options
+ *	specified when the decompressor was allocated.  The decompressor
+ *	history is reset.  Returns 0 for failure (CCP options don't
+ *	match) or 1 for success.
+ */
+static int z_decomp_init(void *arg, unsigned char *options, int opt_len,
+			 int unit, int hdrlen, int mru, int debug)
 {
 	struct ppp_deflate_state *state = (struct ppp_deflate_state *) arg;
 
@@ -343,9 +403,14 @@
 	return 1;
 }
 
-static void
-z_decomp_reset(arg)
-    void *arg;
+/**
+ *	z_decomp_reset - reset a previously-allocated decompressor.
+ *	@arg:	pointer to private state for the decompressor.
+ *
+ *	This clears the history for the decompressor and makes it
+ *	ready to receive a new compressed stream.
+ */
+static void z_decomp_reset(void *arg)
 {
 	struct ppp_deflate_state *state = (struct ppp_deflate_state *) arg;
 
@@ -353,8 +418,13 @@
 	zlib_inflateReset(&state->strm);
 }
 
-/*
- * Decompress a Deflate-compressed packet.
+/**
+ *	z_decompress - decompress a Deflate-compressed packet.
+ *	@arg:	pointer to private state for the decompressor
+ *	@ibuf:	pointer to input (compressed) packet data
+ *	@isize:	length of input packet
+ *	@obuf:	pointer to space for output (decompressed) packet
+ *	@osize:	amount of space available at @obuf
  *
  * Because of patent problems, we return DECOMP_ERROR for errors
  * found by inspecting the input data and for system problems, but
@@ -369,13 +439,8 @@
  * bug, so we return DECOMP_FATALERROR for them in order to turn off
  * compression, even though they are detected by inspecting the input.
  */
-int
-z_decompress(arg, ibuf, isize, obuf, osize)
-    void *arg;
-    unsigned char *ibuf;
-    int isize;
-    unsigned char *obuf;
-    int osize;
+int z_decompress(void *arg, unsigned char *ibuf, int isize,
+		 unsigned char *obuf, int osize)
 {
 	struct ppp_deflate_state *state = (struct ppp_deflate_state *) arg;
 	int olen, seq, r;
@@ -474,14 +539,13 @@
 	return olen;
 }
 
-/*
- * Incompressible data has arrived - add it to the history.
+/**
+ *	z_incomp - add incompressible input data to the history.
+ *	@arg:	pointer to private state for the decompressor
+ *	@ibuf:	pointer to input packet data
+ *	@icnt:	length of input data.
  */
-static void
-z_incomp(arg, ibuf, icnt)
-    void *arg;
-    unsigned char *ibuf;
-    int icnt;
+static void z_incomp(void *arg, unsigned char *ibuf, int icnt)
 {
 	struct ppp_deflate_state *state = (struct ppp_deflate_state *) arg;
 	int proto, r;
diff -urN linux-2.5/drivers/net/ppp_generic.c pmac-2.5/drivers/net/ppp_generic.c
--- linux-2.5/drivers/net/ppp_generic.c	2003-06-02 18:02:30.000000000 +1000
+++ pmac-2.5/drivers/net/ppp_generic.c	2003-06-07 17:47:39.000000000 +1000
@@ -387,7 +387,7 @@
 	return 0;
 }
 
-static ssize_t ppp_read(struct file *file, char *buf,
+static ssize_t ppp_read(struct file *file, char __user *buf,
 			size_t count, loff_t *ppos)
 {
 	struct ppp_file *pf = file->private_data;
@@ -436,7 +436,7 @@
 	return ret;
 }
 
-static ssize_t ppp_write(struct file *file, const char *buf,
+static ssize_t ppp_write(struct file *file, const char __user *buf,
 			 size_t count, loff_t *ppos)
 {
 	struct ppp_file *pf = file->private_data;
@@ -617,7 +617,7 @@
 	case PPPIOCGIDLE:
 		idle.xmit_idle = (jiffies - ppp->last_xmit) / HZ;
 		idle.recv_idle = (jiffies - ppp->last_recv) / HZ;
-		if (copy_to_user((void *) arg, &idle, sizeof(idle)))
+		if (copy_to_user((void __user *) arg, &idle, sizeof(idle)))
 			break;
 		err = 0;
 		break;
@@ -646,7 +646,7 @@
 
 	case PPPIOCGNPMODE:
 	case PPPIOCSNPMODE:
-		if (copy_from_user(&npi, (void *) arg, sizeof(npi)))
+		if (copy_from_user(&npi, (void __user *) arg, sizeof(npi)))
 			break;
 		err = proto_to_npindex(npi.protocol);
 		if (err < 0)
@@ -655,7 +655,7 @@
 		if (cmd == PPPIOCGNPMODE) {
 			err = -EFAULT;
 			npi.mode = ppp->npmode[i];
-			if (copy_to_user((void *) arg, &npi, sizeof(npi)))
+			if (copy_to_user((void __user *) arg, &npi, sizeof(npi)))
 				break;
 		} else {
 			ppp->npmode[i] = npi.mode;
@@ -673,24 +673,22 @@
 		struct sock_filter *code = NULL;
 		int len;
 
-		if (copy_from_user(&uprog, (void *) arg, sizeof(uprog)))
+		if (copy_from_user(&uprog, (void __user *) arg, sizeof(uprog)))
+			break;
+		err = -ENOMEM;
+		len = uprog.len * sizeof(struct sock_filter);
+		code = kmalloc(len, GFP_KERNEL);
+		if (code == 0)
+			break;
+		err = -EFAULT;
+		if (copy_from_user(code, (void __user *) uprog.filter, len)) {
+			kfree(code);
+			break;
+		}
+		err = sk_chk_filter(code, uprog.len);
+		if (err) {
+			kfree(code);
 			break;
-		if (uprog.len > 0 && uprog.len < 65536) {
-			err = -ENOMEM;
-			len = uprog.len * sizeof(struct sock_filter);
-			code = kmalloc(len, GFP_KERNEL);
-			if (code == 0)
-				break;
-			err = -EFAULT;
-			if (copy_from_user(code, uprog.filter, len)) {
-				kfree(code);
-				break;
-			}
-			err = sk_chk_filter(code, uprog.len);
-			if (err) {
-				kfree(code);
-				break;
-			}
 		}
 		filtp = (cmd == PPPIOCSPASS)? &ppp->pass_filter: &ppp->active_filter;
 		ppp_lock(ppp);
@@ -879,7 +877,7 @@
 {
 	struct ppp *ppp = dev->priv;
 	int err = -EFAULT;
-	void *addr = (void *) ifr->ifr_ifru.ifru_data;
+	void __user *addr = (void __user *) ifr->ifr_ifru.ifru_data;
 	struct ppp_stats stats;
 	struct ppp_comp_stats cstats;
 	char *vers;
@@ -1952,9 +1950,9 @@
 	unsigned char ccp_option[CCP_MAX_OPTION_LENGTH];
 
 	err = -EFAULT;
-	if (copy_from_user(&data, (void *) arg, sizeof(data))
+	if (copy_from_user(&data, (void __user *) arg, sizeof(data))
 	    || (data.length <= CCP_MAX_OPTION_LENGTH
-		&& copy_from_user(ccp_option, data.ptr, data.length)))
+		&& copy_from_user(ccp_option, (void __user *) data.ptr, data.length)))
 		goto out;
 	err = -EINVAL;
 	if (data.length > CCP_MAX_OPTION_LENGTH
