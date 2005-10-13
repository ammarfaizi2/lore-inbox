Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751643AbVJMT0t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751643AbVJMT0t (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Oct 2005 15:26:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751637AbVJMT0s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Oct 2005 15:26:48 -0400
Received: from xproxy.gmail.com ([66.249.82.198]:2442 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751630AbVJMT0r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Oct 2005 15:26:47 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-disposition:content-type:content-transfer-encoding:message-id;
        b=Fcc9SNYHWODfbV1UCG5zXaqX7FJ2sqp5e/8y7MCjq/XvFXgs1l4WtY2HmZMPfukcSloyb0uavDluozqTDFItGpO+sopOT1GfDwFKrF7E3/6XHxEjF1tvbsPC/YYwVXZmW6FVIZymy48RtEeBaH3NymOYLh31D2H9jj6QbsBmw7Q=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: "linux-kernel" <linux-kernel@vger.kernel.org>
Subject: [PATCH 11/14] Big kfree NULL check cleanup - arch
Date: Thu, 13 Oct 2005 21:29:39 +0200
User-Agent: KMail/1.8.2
Cc: Andrew Morton <akpm@osdl.org>, Russell King <rmk@arm.linux.org.uk>,
       Mikael Starvik <starvik@axis.com>, Ralf Baechle <ralf@linux-mips.org>,
       Matthew Wilcox <matthew@wil.cx>,
       Grant Grundler <grundler@parisc-linux.org>,
       Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@au.ibm.com>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       "David S. Miller" <davem@davemloft.net>, Jeff Dike <jdike@karaya.com>,
       Jesper Juhl <jesper.juhl@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200510132129.40176.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the arch/ part of the big kfree cleanup patch.

Remove pointless checks for NULL prior to calling kfree() in arch/.


Sorry about the long Cc: list, but I wanted to make sure I included everyone
who's code I've changed with this patch.


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

Please see the initial announcement mail on LKML with subject
"[PATCH 00/14] Big kfree NULL check cleanup"
for additional details.

 arch/arm/mach-integrator/impd1.c       |    3 +--
 arch/cris/arch-v32/drivers/cryptocop.c |   14 +++++++-------
 arch/ia64/kernel/perfmon.c             |    2 +-
 arch/mips/au1000/common/dbdma.c        |    3 +--
 arch/mips/au1000/common/usbdev.c       |    6 ++----
 arch/mips/kernel/irixelf.c             |    5 ++---
 arch/parisc/kernel/ioctl32.c           |   32 +++++++++-----------------------
 arch/ppc/8xx_io/cs4218_tdm.c           |    3 +--
 arch/ppc/syslib/prom.c                 |    6 ++----
 arch/ppc64/kernel/lparcfg.c            |    4 +---
 arch/ppc64/kernel/pSeries_reconfig.c   |    6 ++----
 arch/ppc64/kernel/rtas_flash.c         |    3 +--
 arch/ppc64/kernel/scanlog.c            |    3 +--
 arch/s390/mm/extmem.c                  |    8 ++++----
 arch/sparc64/kernel/us2e_cpufreq.c     |    7 ++-----
 arch/sparc64/kernel/us3_cpufreq.c      |    7 ++-----
 arch/um/drivers/ubd_kern.c             |   24 +++++++++---------------
 arch/um/kernel/sigio_user.c            |    2 +-
 18 files changed, 49 insertions(+), 89 deletions(-)

--- linux-2.6.14-rc4-orig/arch/um/drivers/ubd_kern.c	2005-10-11 22:41:03.000000000 +0200
+++ linux-2.6.14-rc4/arch/um/drivers/ubd_kern.c	2005-10-12 15:28:24.000000000 +0200
@@ -534,38 +534,32 @@ static irqreturn_t ubd_intr(int irq, voi
                 aio = container_of(reply.data, struct ubd_aio, aio);
                 n = reply.err;
 
-		if(n == 0){
+		if (n == 0){
 			req = aio->req;
 			req->nr_sectors -= aio->len >> 9;
 
-			if((aio->bitmap != NULL) &&
+			if ((aio->bitmap != NULL) &&
 			   (atomic_dec_and_test(&aio->bitmap->count))){
                                 aio->aio = aio->bitmap->aio;
                                 aio->len = 0;
                                 kfree(aio->bitmap);
                                 aio->bitmap = NULL;
                                 submit_aio(&aio->aio);
-			}
-			else {
+			} else {
 				if((req->nr_sectors == 0) &&
                                    (aio->bitmap == NULL)){
 					int len = req->hard_nr_sectors << 9;
 					ubd_finish(req, len);
 				}
-
-                                if(aio->bitmap_buf != NULL)
-                                        kfree(aio->bitmap_buf);
+				kfree(aio->bitmap_buf);
 				kfree(aio);
 			}
+		} else if (n < 0) {
+			ubd_finish(aio->req, n);
+			kfree(aio->bitmap);
+			kfree(aio->bitmap_buf);
+			kfree(aio);
 		}
-                else if(n < 0){
-                        ubd_finish(aio->req, n);
-                        if(aio->bitmap != NULL)
-                                kfree(aio->bitmap);
-                        if(aio->bitmap_buf != NULL)
-                                kfree(aio->bitmap_buf);
-                        kfree(aio);
-                }
 	}
 	reactivate_fd(fd, UBD_IRQ);
 
--- linux-2.6.14-rc4-orig/arch/um/kernel/sigio_user.c	2005-10-11 22:41:03.000000000 +0200
+++ linux-2.6.14-rc4/arch/um/kernel/sigio_user.c	2005-10-12 15:28:42.000000000 +0200
@@ -225,7 +225,7 @@ static int need_poll(int n)
 		next_poll.used = n;
 		return(0);
 	}
-	if(next_poll.poll != NULL) kfree(next_poll.poll);
+	kfree(next_poll.poll);
 	next_poll.poll = um_kmalloc_atomic(n * sizeof(struct pollfd));
 	if(next_poll.poll == NULL){
 		printk("need_poll : failed to allocate new pollfds\n");
--- linux-2.6.14-rc4-orig/arch/arm/mach-integrator/impd1.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc4/arch/arm/mach-integrator/impd1.c	2005-10-12 15:29:27.000000000 +0200
@@ -420,8 +420,7 @@ static int impd1_probe(struct lm_device 
  free_impd1:
 	if (impd1 && impd1->base)
 		iounmap(impd1->base);
-	if (impd1)
-		kfree(impd1);
+	kfree(impd1);
  release_lm:
 	release_mem_region(dev->resource.start, SZ_4K);
 	return ret;
--- linux-2.6.14-rc4-orig/arch/ppc/syslib/prom.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc4/arch/ppc/syslib/prom.c	2005-10-12 15:29:40.000000000 +0200
@@ -1335,10 +1335,8 @@ release_OF_resource(struct device_node* 
 	if (!res)
 		return -ENODEV;
 
-	if (res->name) {
-		kfree(res->name);
-		res->name = NULL;
-	}
+	kfree(res->name);
+	res->name = NULL;
 	release_resource(res);
 	kfree(res);
 
--- linux-2.6.14-rc4-orig/arch/ppc/8xx_io/cs4218_tdm.c	2005-10-11 22:40:57.000000000 +0200
+++ linux-2.6.14-rc4/arch/ppc/8xx_io/cs4218_tdm.c	2005-10-12 15:30:12.000000000 +0200
@@ -1013,8 +1013,7 @@ static void CS_IrqCleanup(void)
 	*/
 	cpm_free_handler(CPMVEC_SMC2);
 
-	if (beep_buf)
-		kfree(beep_buf);
+	kfree(beep_buf);
 	kd_mksound = orig_mksound;
 }
 #endif /* MODULE */
--- linux-2.6.14-rc4-orig/arch/cris/arch-v32/drivers/cryptocop.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc4/arch/cris/arch-v32/drivers/cryptocop.c	2005-10-12 15:31:53.000000000 +0200
@@ -277,7 +277,7 @@ struct file_operations cryptocop_fops = 
 static void free_cdesc(struct cryptocop_dma_desc *cdesc)
 {
 	DEBUG(printk("free_cdesc: cdesc 0x%p, from_pool=%d\n", cdesc, cdesc->from_pool));
-	if (cdesc->free_buf) kfree(cdesc->free_buf);
+	kfree(cdesc->free_buf);
 
 	if (cdesc->from_pool) {
 		unsigned long int flags;
@@ -2950,15 +2950,15 @@ static int cryptocop_ioctl_process(struc
 		put_page(outpages[i]);
 	}
 
-	if (digest_result) kfree(digest_result);
-	if (inpages) kfree(inpages);
-	if (outpages) kfree(outpages);
+	kfree(digest_result);
+	kfree(inpages);
+	kfree(outpages);
 	if (cop){
-		if (cop->tfrm_op.indata) kfree(cop->tfrm_op.indata);
-		if (cop->tfrm_op.outdata) kfree(cop->tfrm_op.outdata);
+		kfree(cop->tfrm_op.indata);
+		kfree(cop->tfrm_op.outdata);
 		kfree(cop);
 	}
-	if (jc) kfree(jc);
+	kfree(jc);
 
 	DEBUG(print_lock_status());
 
--- linux-2.6.14-rc4-orig/arch/ia64/kernel/perfmon.c	2005-10-11 22:40:51.000000000 +0200
+++ linux-2.6.14-rc4/arch/ia64/kernel/perfmon.c	2005-10-12 15:32:13.000000000 +0200
@@ -4939,7 +4939,7 @@ abort_locked:
 	if (call_made && PFM_CMD_RW_ARG(cmd) && copy_to_user(arg, args_k, base_sz*count)) ret = -EFAULT;
 
 error_args:
-	if (args_k) kfree(args_k);
+	kfree(args_k);
 
 	DPRINT(("cmd=%s ret=%ld\n", PFM_CMD_NAME(cmd), ret));
 
--- linux-2.6.14-rc4-orig/arch/mips/au1000/common/dbdma.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc4/arch/mips/au1000/common/dbdma.c	2005-10-12 15:32:50.000000000 +0200
@@ -738,8 +738,7 @@ au1xxx_dbdma_chan_free(u32 chanid)
 
 	au1xxx_dbdma_stop(chanid);
 
-	if (ctp->chan_desc_base != NULL)
-		kfree(ctp->chan_desc_base);
+	kfree(ctp->chan_desc_base);
 
 	stp->dev_flags &= ~DEV_FLAGS_INUSE;
 	dtp->dev_flags &= ~DEV_FLAGS_INUSE;
--- linux-2.6.14-rc4-orig/arch/mips/au1000/common/usbdev.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc4/arch/mips/au1000/common/usbdev.c	2005-10-12 15:33:30.000000000 +0200
@@ -1072,8 +1072,7 @@ dma_done_ep0_intr(int irq, void *dev_id,
 			clear_dma_done1(ep0->indma);
 
 		pkt = send_packet_complete(ep0);
-		if (pkt)
-			kfree(pkt);
+		kfree(pkt);
 	}
 
 	/*
@@ -1302,8 +1301,7 @@ usbdev_exit(void)
 		endpoint_flush(ep);
 	}
 
-	if (usbdev.full_conf_desc)
-		kfree(usbdev.full_conf_desc);
+	kfree(usbdev.full_conf_desc);
 }
 
 int
--- linux-2.6.14-rc4-orig/arch/mips/kernel/irixelf.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc4/arch/mips/kernel/irixelf.c	2005-10-12 15:34:24.000000000 +0200
@@ -782,11 +782,10 @@ out_free_dentry:
 	allow_write_access(interpreter);
 	fput(interpreter);
 out_free_interp:
-	if (elf_interpreter)
-		kfree(elf_interpreter);
+	kfree(elf_interpreter);
 out_free_file:
 out_free_ph:
-	kfree (elf_phdata);
+	kfree(elf_phdata);
 	goto out;
 }
 
--- linux-2.6.14-rc4-orig/arch/s390/mm/extmem.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc4/arch/s390/mm/extmem.c	2005-10-12 15:34:47.000000000 +0200
@@ -234,8 +234,8 @@ query_segment_type (struct dcss_segment 
 	rc = 0;
 
  out_free:
-	if (qin) kfree(qin);
-	if (qout) kfree(qout);
+	kfree(qin);
+	kfree(qout);
 	return rc;
 }
 
@@ -394,7 +394,7 @@ __segment_load (char *name, int do_nonsh
 				segtype_string[seg->vm_segtype]);
 	goto out;
  out_free:
-	kfree (seg);
+	kfree(seg);
  out:
 	return rc;
 }
@@ -505,7 +505,7 @@ segment_modify_shared (char *name, int d
 	list_del(&seg->list);
 	dcss_diag(DCSS_PURGESEG, seg->dcss_name,
 		  &dummy, &dummy);
-	kfree (seg);
+	kfree(seg);
  out_unlock:
 	spin_unlock(&dcss_lock);
 	return rc;
--- linux-2.6.14-rc4-orig/arch/ppc64/kernel/lparcfg.c	2005-10-11 22:40:59.000000000 +0200
+++ linux-2.6.14-rc4/arch/ppc64/kernel/lparcfg.c	2005-10-12 15:35:17.000000000 +0200
@@ -599,9 +599,7 @@ int __init lparcfg_init(void)
 void __exit lparcfg_cleanup(void)
 {
 	if (proc_ppc64_lparcfg) {
-		if (proc_ppc64_lparcfg->data) {
-			kfree(proc_ppc64_lparcfg->data);
-		}
+		kfree(proc_ppc64_lparcfg->data);
 		remove_proc_entry("lparcfg", proc_ppc64_lparcfg->parent);
 	}
 }
--- linux-2.6.14-rc4-orig/arch/ppc64/kernel/scanlog.c	2005-10-11 22:40:59.000000000 +0200
+++ linux-2.6.14-rc4/arch/ppc64/kernel/scanlog.c	2005-10-12 15:35:31.000000000 +0200
@@ -225,8 +225,7 @@ int __init scanlog_init(void)
 void __exit scanlog_cleanup(void)
 {
 	if (proc_ppc64_scan_log_dump) {
-		if (proc_ppc64_scan_log_dump->data)
-			kfree(proc_ppc64_scan_log_dump->data);
+		kfree(proc_ppc64_scan_log_dump->data);
 		remove_proc_entry("scan-log-dump", proc_ppc64_scan_log_dump->parent);
 	}
 }
--- linux-2.6.14-rc4-orig/arch/ppc64/kernel/pSeries_reconfig.c	2005-10-11 22:40:59.000000000 +0200
+++ linux-2.6.14-rc4/arch/ppc64/kernel/pSeries_reconfig.c	2005-10-12 15:36:03.000000000 +0200
@@ -286,10 +286,8 @@ static struct property *new_property(con
 	return new;
 
 cleanup:
-	if (new->name)
-		kfree(new->name);
-	if (new->value)
-		kfree(new->value);
+	kfree(new->name);
+	kfree(new->value);
 	kfree(new);
 	return NULL;
 }
--- linux-2.6.14-rc4-orig/arch/ppc64/kernel/rtas_flash.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc4/arch/ppc64/kernel/rtas_flash.c	2005-10-12 15:36:17.000000000 +0200
@@ -565,8 +565,7 @@ static int validate_flash_release(struct
 static void remove_flash_pde(struct proc_dir_entry *dp)
 {
 	if (dp) {
-		if (dp->data != NULL)
-			kfree(dp->data);
+		kfree(dp->data);
 		dp->owner = NULL;
 		remove_proc_entry(dp->name, dp->parent);
 	}
--- linux-2.6.14-rc4-orig/arch/sparc64/kernel/us3_cpufreq.c	2005-10-11 22:41:02.000000000 +0200
+++ linux-2.6.14-rc4/arch/sparc64/kernel/us3_cpufreq.c	2005-10-12 15:37:18.000000000 +0200
@@ -249,10 +249,8 @@ err_out:
 			kfree(driver);
 			cpufreq_us3_driver = NULL;
 		}
-		if (us3_freq_table) {
-			kfree(us3_freq_table);
-			us3_freq_table = NULL;
-		}
+		kfree(us3_freq_table);
+		us3_freq_table = NULL;
 		return ret;
 	}
 
@@ -263,7 +261,6 @@ static void __exit us3_freq_exit(void)
 {
 	if (cpufreq_us3_driver) {
 		cpufreq_unregister_driver(cpufreq_us3_driver);
-
 		kfree(cpufreq_us3_driver);
 		cpufreq_us3_driver = NULL;
 		kfree(us3_freq_table);
--- linux-2.6.14-rc4-orig/arch/sparc64/kernel/us2e_cpufreq.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc4/arch/sparc64/kernel/us2e_cpufreq.c	2005-10-12 15:37:37.000000000 +0200
@@ -388,10 +388,8 @@ err_out:
 			kfree(driver);
 			cpufreq_us2e_driver = NULL;
 		}
-		if (us2e_freq_table) {
-			kfree(us2e_freq_table);
-			us2e_freq_table = NULL;
-		}
+		kfree(us2e_freq_table);
+		us2e_freq_table = NULL;
 		return ret;
 	}
 
@@ -402,7 +400,6 @@ static void __exit us2e_freq_exit(void)
 {
 	if (cpufreq_us2e_driver) {
 		cpufreq_unregister_driver(cpufreq_us2e_driver);
-
 		kfree(cpufreq_us2e_driver);
 		cpufreq_us2e_driver = NULL;
 		kfree(us2e_freq_table);
--- linux-2.6.14-rc4-orig/arch/parisc/kernel/ioctl32.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc4/arch/parisc/kernel/ioctl32.c	2005-10-12 15:38:47.000000000 +0200
@@ -104,12 +104,9 @@ static int drm32_version(unsigned int fd
 	}
 
 out:
-	if (kversion.name)
-		kfree(kversion.name);
-	if (kversion.date)
-		kfree(kversion.date);
-	if (kversion.desc)
-		kfree(kversion.desc);
+	kfree(kversion.name);
+	kfree(kversion.date);
+	kfree(kversion.desc);
 	return ret;
 }
 
@@ -166,9 +163,7 @@ static int drm32_getsetunique(unsigned i
 			ret = -EFAULT;
 	}
 
-	if (karg.unique != NULL)
-		kfree(karg.unique);
-
+	kfree(karg.unique);
 	return ret;
 }
 
@@ -265,7 +260,6 @@ static int drm32_info_bufs(unsigned int 
 	}
 
 	kfree(karg.list);
-
 	return ret;
 }
 
@@ -305,7 +299,6 @@ static int drm32_free_bufs(unsigned int 
 
 out:
 	kfree(karg.list);
-
 	return ret;
 }
 
@@ -494,15 +487,10 @@ static int drm32_dma(unsigned int fd, un
 	}
 
 out:
-	if (karg.send_indices)
-		kfree(karg.send_indices);
-	if (karg.send_sizes)
-		kfree(karg.send_sizes);
-	if (karg.request_indices)
-		kfree(karg.request_indices);
-	if (karg.request_sizes)
-		kfree(karg.request_sizes);
-
+	kfree(karg.send_indices);
+	kfree(karg.send_sizes);
+	kfree(karg.request_indices);
+	kfree(karg.request_sizes);
 	return ret;
 }
 
@@ -555,9 +543,7 @@ static int drm32_res_ctx(unsigned int fd
 			ret = -EFAULT;
 	}
 
-	if (karg.contexts)
-		kfree(karg.contexts);
-
+	kfree(karg.contexts);
 	return ret;
 }
 



