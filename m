Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262215AbTCMKmm>; Thu, 13 Mar 2003 05:42:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262224AbTCMKmm>; Thu, 13 Mar 2003 05:42:42 -0500
Received: from arnor.apana.org.au ([203.14.152.115]:5384 "EHLO
	arnor.me.apana.org.au") by vger.kernel.org with ESMTP
	id <S262215AbTCMKml>; Thu, 13 Mar 2003 05:42:41 -0500
From: Herbert Xu <herbert@gondor.apana.org.au>
To: skraw@ithnet.com (Stephan von Krawczynski), linux-kernel@vger.kernel.org
Subject: Re: OOPS in 2.4.21-pre5, ide-scsi
In-Reply-To: <20030227221017.4291c1f6.skraw@ithnet.com>
X-Newsgroups: apana.lists.os.linux.kernel
User-Agent: tin/1.5.14-20020917 ("Chop Suey!") (UNIX) (Linux/2.4.20-686-smp (i686))
Message-Id: <E18tPJJ-0001Dv-00@gondolin.me.apana.org.au>
Date: Thu, 13 Mar 2003 20:47:37 +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephan von Krawczynski <skraw@ithnet.com> wrote:
> 
> Code;  c0213ab3 <idescsi_pc_intr+63/360>
> 00000000 <_EIP>:
> Code;  c0213ab3 <idescsi_pc_intr+63/360>   <=====
>   0:   ff 42 18                  incl   0x18(%edx)   <=====
> Code;  c0213ab6 <idescsi_pc_intr+66/360>
>   3:   89 3c 24                  mov    %edi,(%esp,1)
> Code;  c0213ab9 <idescsi_pc_intr+69/360>
>   6:   c7 44 24 04 01 00 00      movl   $0x1,0x4(%esp,1)
> Code;  c0213ac0 <idescsi_pc_intr+70/360>
>   d:   00 
> Code;  c0213ac1 <idescsi_pc_intr+71/360>
>   e:   e8 ae fc ff ff            call   fffffcc1 <_EIP+0xfffffcc1> c0213774 <idescsi_do_end_request+a4/e0>
> Code;  c0213ac6 <idescsi_pc_intr+76/360>
>  13:   31 00                     xor    %eax,(%eax)

Does this patch fix the problem?
-- 
Debian GNU/Linux 3.0 is out! ( http://www.debian.org/ )
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
--
Index: drivers/scsi/ide-scsi.c
===================================================================
RCS file: /home/gondolin/herbert/src/CVS/debian/kernel-source-2.4/drivers/scsi/ide-scsi.c,v
retrieving revision 1.1.1.8
retrieving revision 1.2
diff -u -r1.1.1.8 -r1.2
--- drivers/scsi/ide-scsi.c	28 Nov 2002 23:53:14 -0000	1.1.1.8
+++ drivers/scsi/ide-scsi.c	25 Feb 2003 08:55:10 -0000	1.2
@@ -261,7 +261,7 @@
 	ide_drive_t *drive = hwgroup->drive;
 	idescsi_scsi_t *scsi = drive->driver_data;
 	struct request *rq = hwgroup->rq;
-	idescsi_pc_t *pc = (idescsi_pc_t *) rq->buffer;
+	idescsi_pc_t *pc = rq->special;
 	int log = test_bit(IDESCSI_LOG_CMD, &scsi->log);
 	u8 *scsi_buf;
 	unsigned long flags;
@@ -462,7 +462,7 @@
 #endif /* IDESCSI_DEBUG_LOG */
 
 	if (rq->cmd == IDESCSI_PC_RQ) {
-		return idescsi_issue_pc (drive, (idescsi_pc_t *) rq->buffer);
+		return idescsi_issue_pc (drive, rq->special);
 	}
 	printk (KERN_ERR "ide-scsi: %s: unsupported command in request queue (%x)\n", drive->name, rq->cmd);
 	idescsi_end_request (0,HWGROUP (drive));
@@ -836,7 +836,7 @@
 	}
 
 	ide_init_drive_cmd (rq);
-	rq->buffer = (char *) pc;
+	rq->special = pc;
 	rq->bh = idescsi_dma_bh (drive, pc);
 	rq->cmd = IDESCSI_PC_RQ;
 	spin_unlock_irq(&io_request_lock);
