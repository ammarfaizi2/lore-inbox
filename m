Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264099AbTEOQZw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 12:25:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264101AbTEOQZw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 12:25:52 -0400
Received: from air-2.osdl.org ([65.172.181.6]:50062 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264099AbTEOQZu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 12:25:50 -0400
Subject: Re: Race between vmtruncate and mapped areas?
From: Daniel McNeil <daniel@osdl.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Andrew Morton <akpm@digeo.com>, dmccr@us.ibm.com,
       mika.penttila@kolumbus.fi, linux-mm@kvack.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030515094041.GA1429@dualathlon.random>
References: <154080000.1052858685@baldur.austin.ibm.com>
	 <20030513181018.4cbff906.akpm@digeo.com>
	 <18240000.1052924530@baldur.austin.ibm.com>
	 <20030514103421.197f177a.akpm@digeo.com>
	 <82240000.1052934152@baldur.austin.ibm.com>
	 <20030515004915.GR1429@dualathlon.random>
	 <20030515013245.58bcaf8f.akpm@digeo.com>
	 <20030515085519.GV1429@dualathlon.random>
	 <20030515022000.0eb9db29.akpm@digeo.com>
	 <20030515094041.GA1429@dualathlon.random>
Content-Type: multipart/mixed; boundary="=-FFfYtZuZ9pM5fMlSmUEX"
Organization: 
Message-Id: <1053016706.2693.10.camel@ibm-c.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 15 May 2003 09:38:26 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-FFfYtZuZ9pM5fMlSmUEX
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, 2003-05-15 at 02:40, Andrea Arcangeli wrote:
> On Thu, May 15, 2003 at 02:20:00AM -0700, Andrew Morton wrote:
> > Andrea Arcangeli <andrea@suse.de> wrote:
> > >
> > > and it's still racy
> > 
> > damn, and it just booted ;)
> > 
> > I'm just a little bit concerned over the ever-expanding inode.  Do you
> > think the dual sequence numbers can be replaced by a single generation
> > counter?
> 
> yes, I wrote it as a single counter first, but was unreadable and it had
> more branches, so I added the other sequence number to make it cleaner.
> I don't mind another 4 bytes, that cacheline should be hot anyways.

You could use the seqlock.h sequence locking.  It only uses 1 sequence
counter.  The 2.5 isize patch 1 has a sequence lock without the spinlock
so it only uses 4 bytes and it is somewhat more readable.  I don't
think it has more branches.

I've attached the isize seqlock.h patch.
-- 
Daniel McNeil <daniel@osdl.org>

--=-FFfYtZuZ9pM5fMlSmUEX
Content-Disposition: attachment; filename=patch-2.5.69-isize.1
Content-Type: text/x-patch; name=patch-2.5.69-isize.1; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

diff -rupN -X /home/daniel/dontdiff linux-2.5.69/include/linux/seqlock.h linux-2.5.69-isize/include/linux/seqlock.h
--- linux-2.5.69/include/linux/seqlock.h	Sun May  4 16:53:14 2003
+++ linux-2.5.69-isize/include/linux/seqlock.h	Wed May  7 16:00:25 2003
@@ -94,6 +94,57 @@ static inline int read_seqretry(const se
 	return (iv & 1) | (sl->sequence ^ iv);
 }
 
+
+/*
+ * Version using sequence counter only. 
+ * This can be used when code has its own mutex protecting the
+ * updating starting before the write_seqcntbeqin() and ending
+ * after the write_seqcntend().
+ */
+
+typedef struct seqcnt {
+	unsigned sequence;
+} seqcnt_t;
+
+#define SEQCNT_ZERO { 0 }
+#define seqcnt_init(x)	do { *(x) = (seqcnt_t) SEQCNT_ZERO; } while (0)
+
+/* Start of read using pointer to a sequence counter only.  */
+static inline unsigned read_seqcntbegin(const seqcnt_t *s)
+{
+	unsigned ret = s->sequence;
+	smp_rmb();
+	return ret;
+}
+
+/* Test if reader processed invalid data.
+ * Equivalent to: iv is odd or sequence number has changed.
+ *                (iv & 1) || (*s != iv)
+ * Using xor saves one conditional branch.
+ */
+static inline int read_seqcntretry(const seqcnt_t *s, unsigned iv)
+{
+	smp_rmb();
+	return (iv & 1) | (s->sequence ^ iv);
+}
+
+
+/* 
+ * Sequence counter only version assumes that callers are using their
+ * own mutexing.
+ */
+static inline void write_seqcntbegin(seqcnt_t *s)
+{
+	s->sequence++;
+	smp_wmb();			
+}	
+
+static inline void write_seqcntend(seqcnt_t *s) 
+{
+	smp_wmb();
+	s->sequence++;
+}
+
 /*
  * Possible sw/hw IRQ protected versions of the interfaces.
  */

--=-FFfYtZuZ9pM5fMlSmUEX--

