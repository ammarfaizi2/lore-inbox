Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131050AbQLIULQ>; Sat, 9 Dec 2000 15:11:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131079AbQLIULG>; Sat, 9 Dec 2000 15:11:06 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:49650 "HELO
	brinquedo.distro.conectiva") by vger.kernel.org with SMTP
	id <S131050AbQLIUKx>; Sat, 9 Dec 2000 15:10:53 -0500
Date: Sat, 9 Dec 2000 17:40:19 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jens Axboe <axboe@suse.de>, linux-kernel@vger.kernel.org
Subject: [PATCH] scsi/sr.c resource alloc checking
Message-ID: <20001209174018.F859@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, Jens Axboe <axboe@suse.de>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20001209151425.E859@conectiva.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20001209151425.E859@conectiva.com.br>; from acme@conectiva.com.br on Sat, Dec 09, 2000 at 03:14:25PM -0200
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan/Jens,

	Please consider applying, a similar patch is already in 2.4. In
sr_init we don't need zeroing the data allocated with scsi_init_malloc, as
scsi_init_malloc already does this for us.

- Arnaldo

--- linux-2.2.18-pre25/drivers/scsi/sr.c	Sat Dec  9 15:08:24 2000
+++ linux-2.2.18-pre25.acme/drivers/scsi/sr.c	Sat Dec  9 17:33:54 2000
@@ -26,6 +26,8 @@
  *	Modified by Jens Axboe <axboe@suse.de> - support DVD-RAM
  *	transparently and loose the GHOST hack
  *
+ *	Modified by Arnaldo Carvalho de Melo <acme@conectiva.com.br>
+ *	check resource allocation in sr_init and some cleanups - 2000/12/09
  */
 
 #include <linux/module.h>
@@ -70,10 +72,10 @@
 	sr_finish, sr_attach, sr_detach
 };
 
-Scsi_CD *scsi_CDs = NULL;
-static int *sr_sizes = NULL;
+Scsi_CD *scsi_CDs;
+static int *sr_sizes;
 
-static int *sr_blocksizes = NULL;
+static int *sr_blocksizes;
 
 static int sr_open(struct cdrom_device_info *, int);
 void get_sectorsize(int);
@@ -1113,16 +1115,21 @@
 	}
 	if (scsi_CDs)
 		return 0;
-	sr_template.dev_max =
-	    sr_template.dev_noticed + SR_EXTRA_DEVS;
-	scsi_CDs = (Scsi_CD *) scsi_init_malloc(sr_template.dev_max * sizeof(Scsi_CD), GFP_ATOMIC);
-	memset(scsi_CDs, 0, sr_template.dev_max * sizeof(Scsi_CD));
-
-	sr_sizes = (int *) scsi_init_malloc(sr_template.dev_max * sizeof(int), GFP_ATOMIC);
-	memset(sr_sizes, 0, sr_template.dev_max * sizeof(int));
-
-	sr_blocksizes = (int *) scsi_init_malloc(sr_template.dev_max *
-						 sizeof(int), GFP_ATOMIC);
+	sr_template.dev_max = sr_template.dev_noticed + SR_EXTRA_DEVS;
+	scsi_CDs = scsi_init_malloc(sr_template.dev_max * sizeof(Scsi_CD),
+					GFP_ATOMIC);
+	if (!scsi_CDs)
+		goto cleanup_register;
+
+	sr_sizes = scsi_init_malloc(sr_template.dev_max * sizeof(int),
+					GFP_ATOMIC);
+	if (!sr_sizes)
+		goto cleanup_cds;
+
+	sr_blocksizes = scsi_init_malloc(sr_template.dev_max * sizeof(int),
+					GFP_ATOMIC);
+	if (!sr_blocksizes)
+		goto cleanup_sizes;
 
 	/*
 	 * These are good guesses for the time being.
@@ -1131,6 +1138,18 @@
 		sr_blocksizes[i] = 2048;
 	blksize_size[MAJOR_NR] = sr_blocksizes;
 	return 0;
+cleanup_sizes:
+	scsi_init_free((char *) sr_sizes, sr_template.dev_max * sizeof(int));
+	sr_sizes = NULL;
+cleanup_cds:
+	scsi_init_free((char *) scsi_CDs,
+		       (sr_template.dev_noticed + SR_EXTRA_DEVS) *
+		       sizeof(Scsi_CD));
+	scsi_CDs = NULL;
+cleanup_register:
+	unregister_blkdev(MAJOR_NR, "sr");
+	sr_registered--;
+	return 1;
 }
 
 void sr_finish()
@@ -1241,7 +1260,7 @@
 		scsi_init_free((char *) scsi_CDs,
 			       (sr_template.dev_noticed + SR_EXTRA_DEVS)
 			       * sizeof(Scsi_CD));
-
+		scsi_CDs = NULL;
 		scsi_init_free((char *) sr_sizes, sr_template.dev_max * sizeof(int));
 		sr_sizes = NULL;
 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
