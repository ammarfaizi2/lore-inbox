Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265052AbTFLXUP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 19:20:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265060AbTFLXUO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 19:20:14 -0400
Received: from air-2.osdl.org ([65.172.181.6]:4776 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265052AbTFLXTD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 19:19:03 -0400
Date: Thu, 12 Jun 2003 16:34:29 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise
To: Robert Love <rml@tech9.net>
cc: Greg KH <greg@kroah.com>, Andrew Morton <akpm@digeo.com>,
       <sdake@mvista.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] udev enhancements to use kernel event queue
In-Reply-To: <1055460564.662.339.camel@localhost>
Message-ID: <Pine.LNX.4.44.0306121629590.11379-100000@cherise>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > +	spin_lock(&sequence_lock);
> > +	seq = sequence_num++;
> > +	spin_unlock(&sequence_lock);
> > +
> > +	envp [i++] = scratch;
> > +	scratch += sprintf(scratch, "SEQNUM=%ld", seq) + 1;
> 
> Nice thinking. It is a shame we need a lock for this, but we don't have
> an atomic_inc_and_return().

Those were my sentiments exactly:

16:21  * mochel searches for atomic_inc_and_read() :)

It seems like the following should work. Would someone mind commenting on
it?

Thanks,


	-pat


===== include/asm/atomic.h 1.4 vs edited =====
--- 1.4/include/asm-i386/atomic.h	Mon Feb  4 23:42:13 2002
+++ edited/include/asm/atomic.h	Thu Jun 12 16:32:10 2003
@@ -110,6 +110,23 @@
 		:"m" (v->counter));
 }
 
+
+/**
+ * atomic_inc_and_read - increment atomic variable and return new value
+ * @v: pointer of type atomic_t
+ * 
+ * Atomically increments @v by 1.  Note that the guaranteed
+ * useful range of an atomic_t is only 24 bits.
+ */ 
+static inline int atomic_inc_and_read(atomic_t *v)
+{
+	__asm__ __volatile__(
+		LOCK "incl %0"
+		:"=m" (v->counter)
+		:"m" (v->counter));
+	return v->counter;
+}
+
 /**
  * atomic_dec - decrement atomic variable
  * @v: pointer of type atomic_t

