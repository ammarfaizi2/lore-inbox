Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932428AbWBSM7b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932428AbWBSM7b (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Feb 2006 07:59:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932429AbWBSM7a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Feb 2006 07:59:30 -0500
Received: from allen.werkleitz.de ([80.190.251.108]:27013 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S932428AbWBSM7a
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Feb 2006 07:59:30 -0500
Date: Sun, 19 Feb 2006 13:59:24 +0100
From: Johannes Stezenbach <js@linuxtv.org>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: LKML <linux-kernel@vger.kernel.org>, len.brown@intel.com,
       Paul Bristow <paul@paulbristow.net>, mpm@selenic.com,
       B.Zolnierkiewicz@elka.pw.edu.pl, dtor_core@ameritech.net, kkeil@suse.de,
       linux-dvb-maintainer@linuxtv.org, philb@gnu.org, gregkh@suse.de,
       dwmw2@infradead.org, rusty@rustcorp.com.au
Message-ID: <20060219125924.GB5896@linuxtv.org>
Mail-Followup-To: Johannes Stezenbach <js@linuxtv.org>,
	Sam Ravnborg <sam@ravnborg.org>,
	LKML <linux-kernel@vger.kernel.org>, len.brown@intel.com,
	Paul Bristow <paul@paulbristow.net>, mpm@selenic.com,
	B.Zolnierkiewicz@elka.pw.edu.pl, dtor_core@ameritech.net,
	kkeil@suse.de, linux-dvb-maintainer@linuxtv.org, philb@gnu.org,
	gregkh@suse.de, dwmw2@infradead.org, rusty@rustcorp.com.au
References: <20060217214855.GA5563@mars.ravnborg.org> <20060217224702.GA25761@mars.ravnborg.org> <20060219113630.GA5032@mars.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060219113630.GA5032@mars.ravnborg.org>
User-Agent: Mutt/1.5.11+cvs20060126
X-SA-Exim-Connect-IP: 84.189.198.33
Subject: Re: [v4l-dvb-maintainer] Re: kbuild: Section mismatch warnings
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 19, 2006, Sam Ravnborg wrote:
> On Fri, Feb 17, 2006 at 11:47:02PM +0100, Sam Ravnborg wrote:
> > Background:
> > I have introduced a build-time check for section mismatch and it showed
> > up a great number of warnings.
> > Below is the result of the run on a 2.6.16-rc1 tree (which my kbuild
> > tree is based upon) based on a 'make allmodconfig'
> 
> Updated list of warnings below. This time on a rc4 tree and with
> referenced symbol included in warning (when possible).
> This is with my latest kbuild tree which will show up in next -mm.
...
> WARNING: drivers/media/dvb/ttpci/dvb-ttpci.o - Section mismatch: reference to .init.text:av7110_ir_init from .text between 'av7110_attach' (at offset 0xcaa6) and 'av7110_detach'
> WARNING: drivers/media/dvb/ttpci/dvb-ttpci.o - Section mismatch: reference to .exit.text:av7110_ir_exit from .text between 'av7110_detach' (at offset 0xcbc5) and 'av7110_irq'

These seem to be legitimate and point to the right place.
Patch attached.

Thanks,
Johannes

---
dvb: fix __init/__exit section references in av7110 driver

Signed-off-by: Johannes Stezenbach <js@linuxtv.org>

diff -r 24e38b947b8a linux/drivers/media/dvb/ttpci/av7110.c
--- a/linux/drivers/media/dvb/ttpci/av7110.c	Sat Feb 18 10:41:07 2006 -0200
+++ b/linux/drivers/media/dvb/ttpci/av7110.c	Sun Feb 19 13:54:37 2006 +0100
@@ -2476,7 +2476,8 @@ static int frontend_init(struct av7110 *
  * The same behaviour of missing VSYNC can be duplicated on budget
  * cards, by seting DD1_INIT trigger mode 7 in 3rd nibble.
  */
-static int av7110_attach(struct saa7146_dev* dev, struct saa7146_pci_extension_data *pci_ext)
+static int __devinit av7110_attach(struct saa7146_dev* dev,
+				   struct saa7146_pci_extension_data *pci_ext)
 {
 	const int length = TS_WIDTH * TS_HEIGHT;
 	struct pci_dev *pdev = dev->pci;
@@ -2826,7 +2827,7 @@ err_kfree_0:
 	goto out;
 }
 
-static int av7110_detach(struct saa7146_dev* saa)
+static int __devexit av7110_detach(struct saa7146_dev* saa)
 {
 	struct av7110 *av7110 = saa->ext_priv;
 	dprintk(4, "%p\n", av7110);
@@ -2973,7 +2974,7 @@ static struct saa7146_extension av7110_e
 	.module		= THIS_MODULE,
 	.pci_tbl	= &pci_tbl[0],
 	.attach		= av7110_attach,
-	.detach		= av7110_detach,
+	.detach		= __devexit_p(av7110_detach),
 
 	.irq_mask	= MASK_19 | MASK_03 | MASK_10,
 	.irq_func	= av7110_irq,
diff -r 24e38b947b8a linux/drivers/media/dvb/ttpci/av7110_ir.c
--- a/linux/drivers/media/dvb/ttpci/av7110_ir.c	Sat Feb 18 10:41:07 2006 -0200
+++ b/linux/drivers/media/dvb/ttpci/av7110_ir.c	Sun Feb 19 13:54:37 2006 +0100
@@ -208,7 +208,7 @@ static void ir_handler(struct av7110 *av
 }
 
 
-int __init av7110_ir_init(struct av7110 *av7110)
+int __devexit av7110_ir_init(struct av7110 *av7110)
 {
 	static struct proc_dir_entry *e;
 
@@ -248,7 +248,7 @@ int __init av7110_ir_init(struct av7110 
 }
 
 
-void __exit av7110_ir_exit(struct av7110 *av7110)
+void __devexit av7110_ir_exit(struct av7110 *av7110)
 {
 	int i;
 
