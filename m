Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263542AbUJ2Wq5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263542AbUJ2Wq5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 18:46:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263541AbUJ2WpT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 18:45:19 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:31933 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S263523AbUJ2WmC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 18:42:02 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] deviceiobook.tmpl update
Date: Fri, 29 Oct 2004 15:41:49 -0700
User-Agent: KMail/1.7
Cc: grundler@parisc-linux.org, gnb@sgi.com
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_tcsgBg+ZM9ZTMTV"
Message-Id: <200410291541.49481.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_tcsgBg+ZM9ZTMTV
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Greg and Grant, how does this small update look?

Thanks,
Jesse

--Boundary-00=_tcsgBg+ZM9ZTMTV
Content-Type: text/plain;
  charset="us-ascii";
  name="deviceiobook-update.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="deviceiobook-update.patch"

===== Documentation/DocBook/deviceiobook.tmpl 1.5 vs edited =====
--- 1.5/Documentation/DocBook/deviceiobook.tmpl	2004-10-25 13:06:49 -07:00
+++ edited/Documentation/DocBook/deviceiobook.tmpl	2004-10-29 15:38:01 -07:00
@@ -195,7 +195,12 @@
 	be strongly ordered coming from different CPUs.  Thus it's important
 	to properly protect parts of your driver that do memory-mapped writes
 	with locks and use the <function>mmiowb</function> to make sure they
-	arrive in the order intended.
+	arrive in the order intended.  Issuing a regular <function>readX
+	</function> will also ensure write ordering, but should only be used
+	when the driver has to be sure that the write has actually arrived
+	at the device (not that it's simply ordered with respect to other
+	writes), since a full <function>readX</function> is a relatively
+	expensive operation.
       </para>
 
       <para>
@@ -203,29 +208,50 @@
 	releasing a spinlock that protects regions using <function>writeb
 	</function> or similar functions that aren't surrounded by <function>
 	readb</function> calls, which will ensure ordering and flushing.  The
-	following example (again from qla1280.c) illustrates its use.
+	following pseudocode illustrates what might occur if write ordering
+	isn't guaranteed via <function>mmiowb</function> or one of the
+	<function>readX</function> functions.
       </para>
 
 <programlisting>
-       sp->flags |= SRB_SENT;
-       ha->actthreads++;
-       WRT_REG_WORD(&amp;reg->mailbox4, ha->req_ring_index);
-
-       /*
-        * A Memory Mapped I/O Write Barrier is needed to ensure that this write
-        * of the request queue in register is ordered ahead of writes issued
-        * after this one by other CPUs.  Access to the register is protected
-        * by the host_lock.  Without the mmiowb, however, it is possible for
-        * this CPU to release the host lock, another CPU acquire the host lock,
-        * and write to the request queue in, and have the second write make it
-        * to the chip first.
-        */
-       mmiowb(); /* posted write ordering */
+CPU A:  spin_lock_irqsave(&amp;dev_lock, flags)
+CPU A:  ...
+CPU A:  writel(newval, ring_ptr);
+CPU A:  spin_unlock_irqrestore(&amp;dev_lock, flags)
+        ...
+CPU B:  spin_lock_irqsave(&amp;dev_lock, flags)
+CPU B:  writel(newval2, ring_ptr);
+CPU B:  ...
+CPU B:  spin_unlock_irqrestore(&amp;dev_lock, flags)
 </programlisting>
 
       <para>
+	In the case above, newval2 could be written to ring_ptr before
+	newval.  Fixing it is easy though:
+      </para>
+
+<programlisting>
+CPU A:  spin_lock_irqsave(&amp;dev_lock, flags)
+CPU A:  ...
+CPU A:  writel(newval, ring_ptr);
+CPU A:  mmiowb(); /* ensure no other writes beat us to the device */
+CPU A:  spin_unlock_irqrestore(&amp;dev_lock, flags)
+        ...
+CPU B:  spin_lock_irqsave(&amp;dev_lock, flags)
+CPU B:  writel(newval2, ring_ptr);
+CPU B:  ...
+CPU B:  mmiowb();
+CPU B:  spin_unlock_irqrestore(&amp;dev_lock, flags)
+</programlisting>
+
+      <para>
+	See tg3.c for a real world example of how to use <function>mmiowb
+	</function>
+      </para>
+
+      <para>
 	PCI ordering rules also guarantee that PIO read responses arrive
-	after any outstanding DMA writes on that bus, since for some devices
+	after any outstanding DMA writes from that bus, since for some devices
 	the result of a <function>readb</function> call may signal to the
 	driver that a DMA transaction is complete.  In many cases, however,
 	the driver may want to indicate that the next
@@ -234,7 +260,11 @@
 	<function>readb_relaxed</function> for these cases, although only
 	some platforms will honor the relaxed semantics.  Using the relaxed
 	read functions will provide significant performance benefits on
-	platforms that support it.
+	platforms that support it.  The qla2xxx driver provides examples
+	of how to use <function>readX_relaxed</function>.  In many cases,
+	a majority of the driver's <function>readX</function> calls can
+	safely be converted to <function>readX_relaxed</function> calls, since
+	only a few will indicate or depend on DMA completion.
       </para>
     </sect1>
 

--Boundary-00=_tcsgBg+ZM9ZTMTV--
