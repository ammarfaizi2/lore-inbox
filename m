Return-Path: <linux-kernel-owner+w=401wt.eu-S1751052AbWLLDRU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751052AbWLLDRU (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 22:17:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751057AbWLLDRU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 22:17:20 -0500
Received: from mx1.mandriva.com ([212.85.150.183]:39559 "EHLO mx1.mandriva.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751052AbWLLDRQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 22:17:16 -0500
Date: Tue, 12 Dec 2006 01:17:18 -0200
From: Arnaldo Carvalho de Melo <acme@mandriva.com>
To: "James E.J. Bottomley" <James.Bottomley@SteelEye.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: [PATCH][SCSI]: Save some bytes in struct scsi_target
Message-ID: <20061212031718.GC6218@mandriva.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Before:

[acme@newtoy kpahole-2.6]$ pahole --cacheline 32 /tmp/scsi.o.before scsi_target
/* include/scsi/scsi_device.h:86 */
struct scsi_target {
        struct scsi_device *       starget_sdev_user;    /*     0     4 */
        struct list_head           siblings;             /*     4     8 */
        struct list_head           devices;              /*    12     8 */
        struct device              dev;                  /*    20   300 */
        /* --- cacheline 10 boundary (320 bytes) --- */
        unsigned int               reap_ref;             /*   320     4 */
        unsigned int               channel;              /*   324     4 */
        unsigned int               id;                   /*   328     4 */
        unsigned int               create:1;             /*   332     4 */

        /* XXX 31 bits hole, try to pack */

        unsigned int               pdt_1f_for_no_lun;    /*   336     4 */
        char                       scsi_level;           /*   340     1 */

        /* XXX 3 bytes hole, try to pack */

        struct execute_work        ew;                   /*   344    16 */
        /* --- cacheline 11 boundary (352 bytes) was 8 bytes ago --- */
        enum scsi_target_state     state;                /*   360     4 */
        void *                     hostdata;             /*   364     4 */
        long unsigned int          starget_data[0];      /*   368     0 */
}; /* size: 368, cachelines: 12 */
   /* sum members: 365, holes: 1, sum holes: 3 */
   /* bit holes: 1, sum bit holes: 31 bits */
   /* last cacheline: 16 bytes */

After:

[acme@newtoy kpahole-2.6]$ pahole --cacheline 32 drivers/scsi/scsi.o scsi_target
/* include/scsi/scsi_device.h:86 */
struct scsi_target {
        struct scsi_device *       starget_sdev_user;    /*     0     4 */
        struct list_head           siblings;             /*     4     8 */
        struct list_head           devices;              /*    12     8 */
        struct device              dev;                  /*    20   300 */
        /* --- cacheline 10 boundary (320 bytes) --- */
        unsigned int               reap_ref;             /*   320     4 */
        unsigned int               channel;              /*   324     4 */
        unsigned int               id;                   /*   328     4 */
        char                       scsi_level;           /*   332     1 */
        unsigned char              create:1;             /*   333     1 */

        /* XXX 7 bits hole, try to pack */
        /* XXX 2 bytes hole, try to pack */

        unsigned int               pdt_1f_for_no_lun;    /*   336     4 */
        struct execute_work        ew;                   /*   340    16 */
        /* --- cacheline 11 boundary (352 bytes) was 4 bytes ago --- */
        enum scsi_target_state     state;                /*   356     4 */
        void *                     hostdata;             /*   360     4 */
        long unsigned int          starget_data[0];      /*   364     0 */
}; /* size: 364, cachelines: 12 */
   /* sum members: 362, holes: 1, sum holes: 2 */
   /* bit holes: 1, sum bit holes: 7 bits */
   /* last cacheline: 12 bytes */

[acme@newtoy kpahole-2.6]$ codiff -V /tmp/scsi.o.before drivers/scsi/scsi.o
drivers/scsi/scsi.c:
  struct scsi_target |   -4
    create:1;
     from: unsigned int          /*   332(31)    4(1) */
     to:   unsigned char         /*   333(7)     1(1) */
    scsi_level;
     from: char                  /*   340(0)     1(0) */
     to:   char                  /*   332(0)     1(0) */
<SNIP offset changes>
 1 struct changed

Signed-off-by: Arnaldo Carvalho de Melo <acme@mandriva.com>

---

 scsi_device.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/scsi/scsi_device.h b/include/scsi/scsi_device.h
index ebf31b1..ab245fc 100644
--- a/include/scsi/scsi_device.h
+++ b/include/scsi/scsi_device.h
@@ -175,11 +175,11 @@ struct scsi_target {
 	unsigned int		channel;
 	unsigned int		id; /* target id ... replace
 				     * scsi_device.id eventually */
-	unsigned int		create:1; /* signal that it needs to be added */
+	char			scsi_level;
+	unsigned char		create:1; /* signal that it needs to be added */
 	unsigned int		pdt_1f_for_no_lun;	/* PDT = 0x1f */
 						/* means no lun present */
 
-	char			scsi_level;
 	struct execute_work	ew;
 	enum scsi_target_state	state;
 	void 			*hostdata; /* available to low-level driver */
