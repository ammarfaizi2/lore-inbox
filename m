Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318674AbSG0B0c>; Fri, 26 Jul 2002 21:26:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318677AbSG0B0c>; Fri, 26 Jul 2002 21:26:32 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:57281 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S318674AbSG0B0b>;
	Fri, 26 Jul 2002 21:26:31 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15681.63365.640669.474907@napali.hpl.hp.com>
Date: Fri, 26 Jul 2002 18:29:41 -0700
To: Davide Libenzi <davidel@xmailserver.org>
Cc: davidm@hpl.hp.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: performance experiment
In-Reply-To: <Pine.LNX.4.44.0207261344250.1561-100000@blue1.dev.mcafeelabs.com>
References: <15681.38933.698148.860188@napali.hpl.hp.com>
	<Pine.LNX.4.44.0207261344250.1561-100000@blue1.dev.mcafeelabs.com>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Fri, 26 Jul 2002 13:49:27 -0700 (PDT), Davide Libenzi <davidel@xmailserver.org> said:

  Davide> IMHO the patch makes sense, it reduces memory loads and it
  Davide> "helps" the compiler to correctly allocate registers.

I just realized that a gcc3 feature snuck into the source-code by
accident.  Below is a fixed patch which should work with gcc2 as well.

	--david

--- linux-2.4.18/fs/select.c	Mon Sep 24 15:08:21 2001
+++ lia64-2.4/fs/select.c	Fri Jul 26 18:26:38 2002
@@ -164,7 +164,7 @@
 int do_select(int n, fd_set_bits *fds, long *timeout)
 {
 	poll_table table, *wait;
-	int retval, i, off;
+	long retval, i, off;
 	long __timeout = *timeout;
 
  	read_lock(&current->files->file_lock);
@@ -181,6 +181,7 @@
 		wait = NULL;
 	retval = 0;
 	for (;;) {
+#if 0
 		set_current_state(TASK_INTERRUPTIBLE);
 		for (i = 0 ; i < n; i++) {
 			unsigned long bit = BIT(i);
@@ -214,6 +215,57 @@
 				wait = NULL;
 			}
 		}
+#else
+		unsigned long *rinp, *routp, *rexp, *inp, *outp, *exp;
+
+		set_current_state(TASK_INTERRUPTIBLE);
+
+		inp = fds->in; outp = fds->out; exp = fds->ex;
+		rinp = fds->res_in; routp = fds->res_out; rexp = fds->res_ex;
+
+		for (i = 0; i < n; ++rinp, ++routp, ++rexp) {
+			unsigned long in, out, ex, all_bits, bit = 1, mask, j;
+			unsigned long res_in = 0, res_out = 0, res_ex = 0;
+			struct file_operations *f_op;
+			struct file *file = NULL;
+
+			in = *inp++; out = *outp++; ex = *exp++;
+			all_bits = in | out | ex;
+			if (all_bits == 0)
+				continue;
+
+			for (j = 0; j < __NFDBITS; ++j, ++i, bit <<= 1) {
+				if (i >= n)
+					break;
+				if (!(bit & all_bits))
+					continue;
+				file = fget(i);
+				if (file)
+					f_op = file->f_op;
+				mask = DEFAULT_POLLMASK;
+				if (file) {
+					if (f_op && f_op->poll)
+						mask = (*f_op->poll)(file, retval ? NULL : wait);
+					fput(file);
+					if ((mask & POLLIN_SET) && (in & bit)) {
+						res_in |= bit;
+						retval++;
+					}
+					if ((mask & POLLOUT_SET) && (out & bit)) {
+						res_out |= bit;
+						retval++;
+					}
+					if ((mask & POLLEX_SET) && (ex & bit)) {
+						res_ex |= bit;
+						retval++;
+					}
+				}
+			}
+			if (res_in) *rinp = res_in;
+			if (res_out) *routp = res_out;
+			if (res_ex) *rexp = res_ex;
+		}
+#endif
 		wait = NULL;
 		if (retval || !__timeout || signal_pending(current))
 			break;

