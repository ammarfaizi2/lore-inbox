Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131900AbRAKSgL>; Thu, 11 Jan 2001 13:36:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131476AbRAKSgB>; Thu, 11 Jan 2001 13:36:01 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:50685 "HELO
	brinquedo.distro.conectiva") by vger.kernel.org with SMTP
	id <S131900AbRAKSfq>; Thu, 11 Jan 2001 13:35:46 -0500
Date: Thu, 11 Jan 2001 14:48:29 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: andre@linux-ide.org
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: [PATCH] ide-probe.c: check kmalloc return
Message-ID: <20010111144829.J5473@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	andre@linux-ide.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

	Please consider applying.

- Arnaldo

--- linux-2.4.0-ac6/drivers/ide/ide-probe.c	Thu Aug 10 10:14:26 2000
+++ linux-2.4.0-ac6.acme/drivers/ide/ide-probe.c	Thu Jan 11 14:37:35 2001
@@ -56,6 +56,12 @@
 	struct hd_driveid *id;
 
 	id = drive->id = kmalloc (SECTOR_WORDS*4, GFP_ATOMIC);	/* called with interrupts disabled! */
+	if (!id) {
+		printk(KERN_WARNING "%s: ouch, out of memory in do_identify!\n",
+			       	drive->name);
+		drive->present = 0;
+		return;
+	}
 	ide_input_data(drive, id, SECTOR_WORDS);		/* read 512 bytes of id info */
 	ide__sti();	/* local CPU only */
 	ide_fix_driveid(id);
@@ -652,6 +658,10 @@
 		hwgroup = match->hwgroup;
 	} else {
 		hwgroup = kmalloc(sizeof(ide_hwgroup_t), GFP_KERNEL);
+		if (!hwgroup) {
+			restore_flags(flags);	/* all CPUs */
+			return 1;
+		}
 		memset(hwgroup, 0, sizeof(ide_hwgroup_t));
 		hwgroup->hwif     = hwif->next = hwif;
 		hwgroup->rq       = NULL;
@@ -746,11 +756,23 @@
 	}
 	minors    = units * (1<<PARTN_BITS);
 	gd        = kmalloc (sizeof(struct gendisk), GFP_KERNEL);
+	if (!gd)
+		goto out;
 	gd->sizes = kmalloc (minors * sizeof(int), GFP_KERNEL);
+	if (!gd->sizes)
+		goto out_gd;
 	gd->part  = kmalloc (minors * sizeof(struct hd_struct), GFP_KERNEL);
+	if (!gd->part)
+		goto out_sizes;
 	bs        = kmalloc (minors*sizeof(int), GFP_KERNEL);
+	if (!bs)
+		goto out_part;
 	max_sect  = kmalloc (minors*sizeof(int), GFP_KERNEL);
+	if (!max_sect)
+		goto out_bs;
 	max_ra    = kmalloc (minors*sizeof(int), GFP_KERNEL);
+	if (!max_ra)
+		goto out_max_sect;
 
 	memset(gd->part, 0, minors * sizeof(struct hd_struct));
 
@@ -802,6 +824,13 @@
 				devfs_mk_dir (ide_devfs_handle, name, NULL);
 		}
 	}
+	goto out;
+out_max_sect:	kfree(max_sect);
+out_bs:		kfree(bs);
+out_part:	kfree(gd->part);
+out_sizes:	kfree(gd->sizes);
+out_gd:		kfree(gd);
+out:		return;
 }
 
 static int hwif_init (ide_hwif_t *hwif)
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
