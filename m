Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263157AbVBDBTM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263157AbVBDBTM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 20:19:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262758AbVBDBTK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 20:19:10 -0500
Received: from [211.58.254.17] ([211.58.254.17]:41603 "EHLO hemosu.com")
	by vger.kernel.org with ESMTP id S263261AbVBDAy0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 19:54:26 -0500
Message-ID: <4202C7BF.8080305@home-tj.org>
Date: Fri, 04 Feb 2005 09:54:23 +0900
From: Tejun Heo <tj@home-tj.org>
User-Agent: Debian Thunderbird 1.0 (X11/20050118)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: Re: [PATCH 2.6.11-rc2 22/29] ide: convert REQ_DRIVE_TASK to REQ_DRIVE_TASKFILE
References: <20050202024017.GA621@htj.dyndns.org>	 <20050202030727.GG1187@htj.dyndns.org> <58cb370e05020309307cb8fada@mail.gmail.com>
In-Reply-To: <58cb370e05020309307cb8fada@mail.gmail.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello again, Bartlomiej.

Bartlomiej Zolnierkiewicz wrote:
> On Wed, 2 Feb 2005 12:07:27 +0900, Tejun Heo <tj@home-tj.org> wrote:
> 
>>>22_ide_taskfile_flush.patch
>>>
>>>      All REQ_DRIVE_TASK users except ide_task_ioctl() converted
>>>      to use REQ_DRIVE_TASKFILE.
>>>      1. idedisk_issue_flush() converted to use REQ_DRIVE_TASKFILE.
>>>         This and the changes in ide_get_error_location() remove a
>>>         possible race condition between ide_get_error_location()
>>>         and other requests.
> 
> 
> What race condition?

The old ide_get_error_location() acceses hardware registers after the 
flush request is finished, so the registers could have been crobbered by 
other on-going or finished requests.

>>>      2. ide_queue_flush_cmd() converted to use REQ_DRIVE_TASKFILE.
>>
>>Signed-off-by: Tejun Heo <tj@home-tj.org>
>>
>>Index: linux-ide-export/drivers/ide/ide-disk.c
>>===================================================================
>>--- linux-ide-export.orig/drivers/ide/ide-disk.c        2005-02-02 10:28:06.272027942 +0900
>>+++ linux-ide-export/drivers/ide/ide-disk.c     2005-02-02 10:28:06.527986413 +0900
>>@@ -705,24 +705,26 @@ static int idedisk_issue_flush(request_q
>> {
>>        ide_drive_t *drive = q->queuedata;
>>        struct request *rq;
>>+       ide_task_t args;
>>        int ret;
>>
>>        if (!drive->wcache)
>>                return 0;
>>
>>-       rq = blk_get_request(q, WRITE, __GFP_WAIT);
>>-
>>-       memset(rq->cmd, 0, sizeof(rq->cmd));
>>+       memset(&args, 0, sizeof(args));
>>
>>        if (ide_id_has_flush_cache_ext(drive->id) &&
>>            (drive->capacity64 >= (1UL << 28)))
>>-               rq->cmd[0] = WIN_FLUSH_CACHE_EXT;
>>+               args.tfRegister[IDE_COMMAND_OFFSET] = WIN_FLUSH_CACHE_EXT;
>>        else
>>-               rq->cmd[0] = WIN_FLUSH_CACHE;
>>+               args.tfRegister[IDE_COMMAND_OFFSET] = WIN_FLUSH_CACHE;
>>
>>+       args.command_type = IDE_DRIVE_TASK_NO_DATA;
> 
> 
> .data_phase is missed

Yeah, it was kind of intentional as all other functions which do 
IDE_DRIVE_TASK_NO_DATA don't initialize args.data_phase explicitly. 
patch #29 makes this change for all such cases including this one.

> 
>>+       args.handler = task_no_data_intr;
> 
> 
> Please compare the code above to the code you've added to
> ide_queue_flush_cmd() - it is identical.  It would be nice to add
> some helper for doing this i.e. ide_init_flush_cmd().
>  

Sure.

> 
>>-       rq->flags |= REQ_DRIVE_TASK | REQ_SOFTBARRIER;
>>-       rq->buffer = rq->cmd;
>>+       rq = blk_get_request(q, WRITE, __GFP_WAIT);
>>+       rq->flags |= REQ_DRIVE_TASKFILE | REQ_SOFTBARRIER;
>>+       rq->special = &args;
>>
>>        ret = blk_execute_rq(q, disk, rq);
>>
>>@@ -730,8 +732,9 @@ static int idedisk_issue_flush(request_q
>>         * if we failed and caller wants error offset, get it
>>         */
>>        if (ret && error_sector)
>>-               *error_sector = ide_get_error_location(drive, rq->cmd);
>>+               *error_sector = ide_get_error_location(drive, &args);
>>
>>+       rq->special = NULL;     /* just in case */
>>        blk_put_request(rq);
>>        return ret;
>> }
>>Index: linux-ide-export/drivers/ide/ide-io.c
>>===================================================================
>>--- linux-ide-export.orig/drivers/ide/ide-io.c  2005-02-02 10:28:06.273027780 +0900
>>+++ linux-ide-export/drivers/ide/ide-io.c       2005-02-02 10:28:06.528986250 +0900
>>@@ -55,24 +55,6 @@
>> #include <asm/io.h>
>> #include <asm/bitops.h>
>>
>>-static void ide_fill_flush_cmd(ide_drive_t *drive, struct request *rq)
>>-{
>>-       char *buf = rq->cmd;
>>-
>>-       /*
>>-        * reuse cdb space for ata command
>>-        */
>>-       memset(buf, 0, sizeof(rq->cmd));
>>-
>>-       rq->flags |= REQ_DRIVE_TASK | REQ_STARTED;
>>-       rq->buffer = buf;
>>-       rq->buffer[0] = WIN_FLUSH_CACHE;
>>-
>>-       if (ide_id_has_flush_cache_ext(drive->id) &&
>>-           (drive->capacity64 >= (1UL << 28)))
>>-               rq->buffer[0] = WIN_FLUSH_CACHE_EXT;
>>-}
>>-
>> /*
>>  * preempt pending requests, and store this cache flush for immediate
>>  * execution
>>@@ -80,7 +62,8 @@ static void ide_fill_flush_cmd(ide_drive
>> static struct request *ide_queue_flush_cmd(ide_drive_t *drive,
>>                                           struct request *rq, int post)
>> {
>>-       struct request *flush_rq = &HWGROUP(drive)->wrq;
>>+       struct request *flush_rq = &HWGROUP(drive)->flush_rq;
>>+       ide_task_t *args = &HWGROUP(drive)->flush_args;
> 
> 
> please don't use HWGROUP() macro,
> just use drive->hwif->hwgroup directly
> 

I think I'll leave the code like above here and make another patch which 
removes all uses of HWGROUP() and HWGROUP() itself.  What do you think 
about that?

> 
>>        /*
>>         * write cache disabled, clear the barrier bit and treat it like
>>@@ -92,10 +75,22 @@ static struct request *ide_queue_flush_c
>>        }
>>
>>        ide_init_drive_cmd(flush_rq);
>>-       ide_fill_flush_cmd(drive, flush_rq);
>>-
>>-       flush_rq->special = rq;
>>+       flush_rq->flags = REQ_DRIVE_TASKFILE | REQ_STARTED;
>>        flush_rq->nr_sectors = rq->nr_sectors;
>>+       flush_rq->special = args;
>>+       HWGROUP(drive)->flush_real_rq = rq;
> 
> 
> ditto
> 
> 
>>+       memset(args, 0, sizeof(*args));
>>+
>>+       if (ide_id_has_flush_cache_ext(drive->id) &&
>>+           (drive->capacity64 >= (1UL << 28)))
>>+               args->tfRegister[IDE_COMMAND_OFFSET] = WIN_FLUSH_CACHE_EXT;
>>+       else
>>+               args->tfRegister[IDE_COMMAND_OFFSET] = WIN_FLUSH_CACHE;
>>+
>>+       args->command_type = IDE_DRIVE_TASK_NO_DATA;
>>+       args->data_phase = TASKFILE_NO_DATA;
>>+       args->handler = task_no_data_intr;
>>
>>        if (!post) {
>>                drive->doing_barrier = 1;
>>@@ -175,7 +170,7 @@ int ide_end_request (ide_drive_t *drive,
>>        if (!blk_barrier_rq(rq) || !drive->wcache)
>>                ret = __ide_end_request(drive, rq, uptodate, nr_sectors);
>>        else {
>>-               struct request *flush_rq = &HWGROUP(drive)->wrq;
>>+               struct request *flush_rq = &HWGROUP(drive)->flush_rq;
> 
> 
> ditto
> 
> 
>>                flush_rq->nr_sectors -= nr_sectors;
>>                if (!flush_rq->nr_sectors) {
>>@@ -221,41 +216,37 @@ static void ide_complete_pm_request (ide
>> /*
>>  * FIXME: probably move this somewhere else, name is bad too :)
>>  */
>>-u64 ide_get_error_location(ide_drive_t *drive, char *args)
>>+u64 ide_get_error_location(ide_drive_t *drive, ide_task_t *args)
>> {
>>        u32 high, low;
>>        u8 hcyl, lcyl, sect;
>>-       u64 sector;
>>
>>-       high = 0;
>>-       hcyl = args[5];
>>-       lcyl = args[4];
>>-       sect = args[3];
>>-
>>-       if (ide_id_has_flush_cache_ext(drive->id)) {
>>-               low = (hcyl << 16) | (lcyl << 8) | sect;
>>-               HWIF(drive)->OUTB(drive->ctl|0x80, IDE_CONTROL_REG);
>>-               high = ide_read_24(drive);
>>-       } else {
>>-               u8 cur = HWIF(drive)->INB(IDE_SELECT_REG);
>>-               if (cur & 0x40)
>>-                       low = (hcyl << 16) | (lcyl << 8) | sect;
>>-               else {
>>-                       low = hcyl * drive->head * drive->sect;
>>-                       low += lcyl * drive->sect;
>>-                       low += sect - 1;
>>-               }
>>-       }
>>+       if (ide_id_has_flush_cache_ext(drive->id) &&
>>+           (drive->capacity64 >= (1UL << 28)))
>>+               high = (args->hobRegister[IDE_HCYL_OFFSET] << 16) |
>>+                      (args->hobRegister[IDE_LCYL_OFFSET] << 8 ) |
>>+                       args->hobRegister[IDE_SECTOR_OFFSET];
>>+       else
>>+               high = 0;
>>+
>>+       hcyl = args->tfRegister[IDE_HCYL_OFFSET];
>>+       lcyl = args->tfRegister[IDE_LCYL_OFFSET];
>>+       sect = args->tfRegister[IDE_SECTOR_OFFSET];
>>+
>>+       if (args->tfRegister[IDE_SELECT_OFFSET] & 0x40)
>>+               low = (hcyl << 16) | (lcyl << 8 ) | sect;
>>+       else
>>+               low = hcyl * drive->head * drive->sect +
>>+                       lcyl * drive->sect + sect - 1;
>>
>>-       sector = ((u64) high << 24) | low;
>>-       return sector;
>>+       return ((u64)high << 24) | low;
>> }
>> EXPORT_SYMBOL(ide_get_error_location);
>>
>> static void ide_complete_barrier(ide_drive_t *drive, struct request *rq,
>>                                 int error)
>> {
>>-       struct request *real_rq = rq->special;
>>+       struct request *real_rq = HWGROUP(drive)->flush_real_rq;
> 
> 
> ditto
> 
> 
>>        int good_sectors, bad_sectors;
>>        sector_t sector;
>>
>>@@ -302,7 +293,7 @@ static void ide_complete_barrier(ide_dri
>>                 */
>>                good_sectors = 0;
>>                if (blk_barrier_postflush(rq)) {
>>-                       sector = ide_get_error_location(drive, rq->buffer);
>>+                       sector = ide_get_error_location(drive, rq->special);
>>
>>                        if ((sector >= real_rq->hard_sector) &&
>>                            (sector < real_rq->hard_sector + real_rq->hard_nr_sectors))
>>Index: linux-ide-export/include/linux/ide.h
>>===================================================================
>>--- linux-ide-export.orig/include/linux/ide.h   2005-02-02 10:28:06.274027617 +0900
>>+++ linux-ide-export/include/linux/ide.h        2005-02-02 10:28:06.529986088 +0900
>>@@ -930,6 +930,39 @@ typedef ide_startstop_t (ide_pre_handler
>> typedef ide_startstop_t (ide_handler_t)(ide_drive_t *);
>> typedef int (ide_expiry_t)(ide_drive_t *);
>>
>>+typedef struct ide_task_s {
>>+/*
>>+ *     struct hd_drive_task_hdr        tf;
>>+ *     task_struct_t           tf;
>>+ *     struct hd_drive_hob_hdr         hobf;
>>+ *     hob_struct_t            hobf;
>>+ */
>>+       task_ioreg_t            tfRegister[8];
>>+       task_ioreg_t            hobRegister[8];
>>+       ide_reg_valid_t         tf_out_flags;
>>+       ide_reg_valid_t         tf_in_flags;
>>+       int                     data_phase;
>>+       int                     command_type;
>>+       ide_pre_handler_t       *prehandler;
>>+       ide_handler_t           *handler;
>>+       struct request          *rq;            /* copy of request */
>>+       void                    *special;       /* valid_t generally */
>>+} ide_task_t;
> 
> 
> please don't move this around,
> adding struct ide_task_s; should do the trick
> 

No, I added ide_task_t flush_args to hwgroup_t not a pointer to 
ide_task_t, so the definition of ide_task_t has to come before the 
definition of hwgroup_t.

> 
>>+typedef struct pkt_task_s {
>>+/*
>>+ *     struct hd_drive_task_hdr        pktf;
>>+ *     task_struct_t           pktf;
>>+ *     u8                      pkcdb[12];
>>+ */
>>+       task_ioreg_t            tfRegister[8];
>>+       int                     data_phase;
>>+       int                     command_type;
>>+       ide_handler_t           *handler;
>>+       struct request          *rq;            /* copy of request */
>>+       void                    *special;
>>+} pkt_task_t;
> 
> 
> there is no need to move pkt_task_t around
> (moreover no code uses it currently)
> 

And it seemd kind of lonely after ide_task_t moved upward. :-)  How 
about modifying this patch such that it moves only the ide_task_t and 
adding another patch to kill pkt_task_t?

> 
>> typedef struct hwgroup_s {
>>                /* irq handler, if active */
>>        ide_startstop_t (*handler)(ide_drive_t *);
>>@@ -955,8 +988,12 @@ typedef struct hwgroup_s {
>>        struct request *rq;
>>                /* failsafe timer */
>>        struct timer_list timer;
>>-               /* local copy of current write rq */
>>-       struct request wrq;
>>+               /* rq used for flushing */
>>+       struct request flush_rq;
>>+               /* task used for flushing */
>>+       ide_task_t flush_args;
>>+               /* real_rq for flushing */
>>+       struct request *flush_real_rq;
>>                /* timeout value during long polls */
>>        unsigned long poll_timeout;
>>                /* queried upon timeouts */
>>@@ -1203,7 +1240,7 @@ extern void ide_init_drive_cmd (struct r
>> /*
>>  * this function returns error location sector offset in case of a write error
>>  */
>>-extern u64 ide_get_error_location(ide_drive_t *, char *);
>>+extern u64 ide_get_error_location(ide_drive_t *, ide_task_t *);
> 
> 
> extern is not needed
> 

Yeah, it isn't needed.  I was trying to be conformant with other 
declarations in the file.  I'll leave above line as it is now and write 
another patch to remove all extern's in front of function prototypes in 
ide drivers.  What do you think?

> 
>> /*
>>  * "action" parameter type for ide_do_drive_cmd() below.
>>@@ -1260,39 +1297,6 @@ extern void ide_end_drive_cmd(ide_drive_
>>  */
>> extern int ide_wait_cmd(ide_drive_t *, u8, u8, u8, u8, u8 *);
>>
>>-typedef struct ide_task_s {
>>-/*
>>- *     struct hd_drive_task_hdr        tf;
>>- *     task_struct_t           tf;
>>- *     struct hd_drive_hob_hdr         hobf;
>>- *     hob_struct_t            hobf;
>>- */
>>-       task_ioreg_t            tfRegister[8];
>>-       task_ioreg_t            hobRegister[8];
>>-       ide_reg_valid_t         tf_out_flags;
>>-       ide_reg_valid_t         tf_in_flags;
>>-       int                     data_phase;
>>-       int                     command_type;
>>-       ide_pre_handler_t       *prehandler;
>>-       ide_handler_t           *handler;
>>-       struct request          *rq;            /* copy of request */
>>-       void                    *special;       /* valid_t generally */
>>-} ide_task_t;
>>-
>>-typedef struct pkt_task_s {
>>-/*
>>- *     struct hd_drive_task_hdr        pktf;
>>- *     task_struct_t           pktf;
>>- *     u8                      pkcdb[12];
>>- */
>>-       task_ioreg_t            tfRegister[8];
>>-       int                     data_phase;
>>-       int                     command_type;
>>-       ide_handler_t           *handler;
>>-       struct request          *rq;            /* copy of request */
>>-       void                    *special;
>>-} pkt_task_t;
>>-
>> extern u32 ide_read_24(ide_drive_t *);
>>
>> extern void SELECT_DRIVE(ide_drive_t *);
> 
> 
> rest of the patch looks fine

Thanks.

-- 
tejun

