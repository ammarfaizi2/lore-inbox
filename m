Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316667AbSGYXew>; Thu, 25 Jul 2002 19:34:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316668AbSGYXew>; Thu, 25 Jul 2002 19:34:52 -0400
Received: from angus.ind.WPI.EDU ([130.215.24.5]:22777 "EHLO angus.ind.WPI.EDU")
	by vger.kernel.org with ESMTP id <S316667AbSGYXev>;
	Thu, 25 Jul 2002 19:34:51 -0400
Date: Thu, 25 Jul 2002 19:38:06 -0400
From: "Charles R. Anderson" <cra@WPI.EDU>
To: linux-kernel@vger.kernel.org
Subject: 2.4.19-rc3-ac3 ide_map_buffer/ide_unmap_buffer
Message-ID: <20020725193806.U7778@angus.ind.WPI.EDU>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[I'm not subscribed, so please Cc: me directly.  Thanks.]

patch-2.4.19-rc3-ac3 has this stuff related to highmem support:

 /*
+ * mapping stuff, prepare for highmem...
+ * 
+ * temporarily mapping a (possible) highmem bio for PIO transfer
+ */
+#define ide_rq_offset(rq) \
+       (((rq)->hard_cur_sectors - (rq)->current_nr_sectors) << 9)
+
+extern inline void *ide_map_buffer(struct request *rq, unsigned long
*flags)
+{
+       return rq->buffer + ide_rq_offset(rq);
+}
+
+extern inline void ide_unmap_buffer(char *buffer, unsigned long *flags)
+{
+       do { } while (0);
+}

Red Hat's 2.4.18-5 kernel has these conflicting bits in
linux-2.4.17-blockhighmem.patch:

+
+/*
+ * temporarily mapping a (possible) highmem bio
+ */
+#define ide_rq_offset(rq) (((rq)->hard_cur_sectors - (rq)->current_nr_sectors) << 9)
+
+extern inline void *ide_map_buffer(struct request *rq, unsigned long
*flags)
+{
+       return bh_kmap_irq(rq->bh, flags) + ide_rq_offset(rq);
+}
+
+extern inline void ide_unmap_buffer(char *buffer, unsigned long *flags)
+{
+       bh_kunmap_irq(buffer, flags);
+}

Which one should I apply? I'm inclined to keep the Red Hat bits, since
the ac3 ide_unmap_buffer does nothing.

[For anyone wondering, I have a new Dell with an Intel 845G chipset for
which I would like DMA support, etc.  I'm attempting to merge
2.4.19-rc3-ac3 with Red Hat's patches.  If anyone has a simple patch for
82801DB IDE DMA support which applies to 2.4.18 I'd be much obliged.]

Thanks.

-- 
Charles R. Anderson <cra@wpi.edu> / http://angus.ind.wpi.edu/~cra/
PGP Key ID: 49BB5886
Fingerprint: EBA3 A106 7C93 FA07 8E15  3AC2 C367 A0F9 49BB 5886
