Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750943AbWEQSxw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750943AbWEQSxw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 14:53:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750947AbWEQSxw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 14:53:52 -0400
Received: from mtagate5.uk.ibm.com ([195.212.29.138]:46734 "EHLO
	mtagate5.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1750943AbWEQSxv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 14:53:51 -0400
Subject: [RFC] [Patch 3/6] statistics infrastructure - prerequisite:
	timestamp
From: Martin Peschke <mp3@de.ibm.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Chase Venters <chase.venters@clientec.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Keith Owens <kaos@ocs.com.au>,
       Andrew Morton <akpm@osdl.org>, Christoph Lameter <clameter@sgi.com>,
       "Frank Ch. Eigler" <fche@redhat.com>,
       Peter Chubb <peterc@gelato.unsw.edu.au>,
       "hch@infradead.org" <hch@infradead.org>,
       "arjan@infradead.org" <arjan@infradead.org>, "ak@suse.de" <ak@suse.de>
Content-Type: text/plain
Date: Wed, 17 May 2006 20:53:38 +0200
Message-Id: <1147892018.3076.17.camel@dyn-9-152-230-71.boeblingen.de.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch separates the timestamp code out from printk. Thus, other
components, like the statistics infrastructure, can also make use of it
and provide similar timestamps. It just makes sense to have one timestamp
format throughout the kernel.

The original piece of code was a bit promiscuous, IMHO.
Please accept the little cleanup that comes with my patch.

And I think that I have fixed a printed_len related miscalculation.
printed_len needs to be increased if no valid log level has been found
and a log level prefix has been added by printk(). Otherwise, printed_len
must not be increased. The old code did it the other way around (in the
timestamp case).

Signed-off-by: Martin Peschke <mp3@de.ibm.com>
---

 include/linux/jiffies.h |    7 ++++
 kernel/printk.c         |   74 +++++++++++++++++++-----------------------------
 2 files changed, 37 insertions(+), 44 deletions(-)

diff -Nurp a/include/linux/jiffies.h b/include/linux/jiffies.h
--- a/include/linux/jiffies.h	2006-05-17 19:02:03.000000000 +0200
+++ b/include/linux/jiffies.h	2006-05-17 19:06:10.000000000 +0200
@@ -447,4 +447,11 @@ static inline u64 nsec_to_clock_t(u64 x)
 	return x;
 }
 
+static inline int nsec_to_timestamp(char *s, unsigned long long t)
+{
+	unsigned long nsec_rem = do_div(t, 1000000000);
+	return sprintf(s, "[%5lu.%06lu]", (unsigned long)t, nsec_rem/1000);
+}
+#define TIMESTAMP_SIZE	30
+
 #endif
diff -Nurp a/kernel/printk.c b/kernel/printk.c
--- a/kernel/printk.c	2006-05-17 19:02:04.000000000 +0200
+++ b/kernel/printk.c	2006-05-17 19:06:10.000000000 +0200
@@ -493,7 +493,7 @@ asmlinkage int vprintk(const char *fmt, 
 	int printed_len;
 	char *p;
 	static char printk_buf[1024];
-	static int log_level_unknown = 1;
+	static int new_line = 1;
 
 	preempt_disable();
 	if (unlikely(oops_in_progress) && printk_cpu == smp_processor_id())
@@ -510,59 +510,45 @@ asmlinkage int vprintk(const char *fmt, 
 
 	/*
 	 * Copy the output into log_buf.  If the caller didn't provide
-	 * appropriate log level tags, we insert them here
+	 * appropriate log level tags, we insert them here.
 	 */
 	for (p = printk_buf; *p; p++) {
-		if (log_level_unknown) {
-                        /* log_level_unknown signals the start of a new line */
+		if (new_line) {
+			/* The log level token is first. */
+			int loglev_char;
+			if (p[0] == '<' && p[1] >='0' &&
+			    p[1] <= '7' && p[2] == '>') {
+				loglev_char = p[1];
+				p += 3;
+				printed_len -= 3;
+			} else	{
+				loglev_char = default_message_loglevel + '0';
+			}
+			emit_log_char('<');
+			emit_log_char(loglev_char);
+			emit_log_char('>');
+			/* A timestamp, if requested, goes next. */
 			if (printk_time) {
-				int loglev_char;
-				char tbuf[50], *tp;
-				unsigned tlen;
-				unsigned long long t;
-				unsigned long nanosec_rem;
-
-				/*
-				 * force the log level token to be
-				 * before the time output.
-				 */
-				if (p[0] == '<' && p[1] >='0' &&
-				   p[1] <= '7' && p[2] == '>') {
-					loglev_char = p[1];
-					p += 3;
-					printed_len -= 3;
-				} else {
-					loglev_char = default_message_loglevel
-						+ '0';
-				}
-				t = printk_clock();
-				nanosec_rem = do_div(t, 1000000000);
-				tlen = sprintf(tbuf,
-						"<%c>[%5lu.%06lu] ",
-						loglev_char,
-						(unsigned long)t,
-						nanosec_rem/1000);
-
-				for (tp = tbuf; tp < tbuf + tlen; tp++)
+				char tbuf[TIMESTAMP_SIZE], *tp;
+				printed_len += nsec_to_timestamp(tbuf,
+							printk_clock());
+				for (tp = tbuf; *tp; tp++)
 					emit_log_char(*tp);
-				printed_len += tlen;
-			} else {
-				if (p[0] != '<' || p[1] < '0' ||
-				   p[1] > '7' || p[2] != '>') {
-					emit_log_char('<');
-					emit_log_char(default_message_loglevel
-						+ '0');
-					emit_log_char('>');
-					printed_len += 3;
-				}
+				emit_log_char(' ');
+				printed_len++;
 			}
-			log_level_unknown = 0;
+			new_line = 0;
 			if (!*p)
 				break;
 		}
+		/*
+		 * Once we are done with special strings at the head of
+		 * each line, we just keep copying characters until
+		 * we come across another line and need to start over.
+		 */
 		emit_log_char(*p);
 		if (*p == '\n')
-			log_level_unknown = 1;
+			new_line = 1;
 	}
 
 	if (!cpu_online(smp_processor_id())) {


