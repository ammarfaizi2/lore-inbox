Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261349AbVBGFNu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261349AbVBGFNu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 00:13:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261353AbVBGFNu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 00:13:50 -0500
Received: from wproxy.gmail.com ([64.233.184.206]:54682 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261349AbVBGFNc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 00:13:32 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=bB2rZ0anfxm9gptKkC+gXYMk/arH2+4zEcjEJnB82wBRlSJWqyMFBdQoOaNgJKBzyErVYuVb1J71QrQhoORgLxrQzvdJN0P18cv/8PqoPnpB7nAmP99S3xRfhenfkVTjfhr/9wIX07LXEPC9NlloikVAFvZSdWUmrHrxOp8u2vE=
Message-ID: <4206F8F2.3020908@gmail.com>
Date: Mon, 07 Feb 2005 14:13:22 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Debian Thunderbird 1.0 (X11/20050118)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Tejun Heo <tj@home-tj.org>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.11-rc2 04/09] ide: convert REQ_DRIVE_TASK to REQ_DRIVE_TASKFILE
References: <20050205021502.GA17767@htj.dyndns.org>	 <20050205021556.8FC05132701@htj.dyndns.org> <58cb370e0502061034393bd229@mail.gmail.com>
In-Reply-To: <58cb370e0502061034393bd229@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:
> I put some more thought into this change... details below...
> 
> On Sat,  5 Feb 2005 11:15:56 +0900 (KST), Tejun Heo <tj@home-tj.org> wrote:
> 
> 
>>@@ -705,24 +705,17 @@ static int idedisk_issue_flush(request_q
>> {
>>        ide_drive_t *drive = q->queuedata;
>>        struct request *rq;
>>+       ide_task_t args;
>>        int ret;
> 
> 
> ide_task_t task please
> 

  Okay.

> 
>>@@ -730,8 +723,9 @@ static int idedisk_issue_flush(request_q
>>         * if we failed and caller wants error offset, get it
>>         */
>>        if (ret && error_sector)
>>-               *error_sector = ide_get_error_location(drive, rq->cmd);
>>+               *error_sector = ide_get_error_location(drive, &args);
>>
>>+       rq->special = NULL;     /* just in case */
> 
> 
> In what case?
> 

  As the request is allocated and freed by the generic block layer, I 
was kinda worrying about cases where the request outlives 
blk_put_request() and somehow somebody accesses ->special.  Probably 
unnecessary but dangling pointers pointing stack area really scares me.

> 
>>@@ -55,22 +55,19 @@
>> #include <asm/io.h>
>> #include <asm/bitops.h>
>>
>>-static void ide_fill_flush_cmd(ide_drive_t *drive, struct request *rq)
>>+void ide_init_flush_task(ide_drive_t *drive, ide_task_t *args)
> 
> 
> ide_task_t *task
> 
> 
>>@@ -80,7 +77,9 @@ static void ide_fill_flush_cmd(ide_drive
>> static struct request *ide_queue_flush_cmd(ide_drive_t *drive,
>>                                           struct request *rq, int post)
>> {
>>-       struct request *flush_rq = &HWGROUP(drive)->wrq;
>>+       ide_hwgroup_t *hwgroup = drive->hwif->hwgroup;
>>+       struct request *flush_rq = &hwgroup->flush_rq;
>>+       ide_task_t *args = &hwgroup->flush_args;
> 
> 
> ide_task_t *task
> 
> 
>>@@ -221,41 +223,37 @@ static void ide_complete_pm_request (ide
>> /*
>>  * FIXME: probably move this somewhere else, name is bad too :)
>>  */
>>-u64 ide_get_error_location(ide_drive_t *drive, char *args)
>>+u64 ide_get_error_location(ide_drive_t *drive, ide_task_t *args)
> 
> 
> ide_task_t *task
> 
> 
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
> 
> 
> Please just use if (drive->addressing), it is simpler and still correct.
> Since we are now using ide_task_t 'high' will be 0 when
> ide_id_has_flush_cache() == 0 and drive->addressing == 1
> (such combination is unlikely but...).  Also thanks to this change
> ide_get_error_location() becomes a really *generic* helper and
> can be later used by other code.
> 

  Sure.

> 
>>@@ -1201,9 +1224,14 @@ extern ide_startstop_t ide_do_reset (ide
>> extern void ide_init_drive_cmd (struct request *rq);
>>
>> /*
>>+ * This function initializes @task to WIN_FLUSH_CACHE[_EXT] command.
>>+ */
>>+void ide_init_flush_task(ide_drive_t *drive, ide_task_t *args);
> 
> 
> comment is wrong and not needed,
> 
> void ide_init_flush_task(ide_drive_t *, ide_task_t *);
> 
> should be enough
> 

  Okay.

> 
> There is one problem left with this change - FLUSH_CACHE_{EXT}
> command handling becomes slower for drive's supporting LBA48
> (also next patches make ide_{task,cmd}_ioctl() slower).  Why is so?
> See do_rw_taskfile(), HOB registers are written/read unconditionally
> if (drive->addressing == 1).  This can be fixed by i.e. adding
> 'unsigned long flags' to ide_task_t and IDE_TASK_LBA48 flag.
> BTW this fix is needed also to implement LBA48 optimization for
> read/write requests (not writing HOB registers when not needed).
> 
> IMHO there are some things worth mentioning in the patch description,
> do_rw_taskfile() vs execute_drive_cmd()+ide_cmd() details:
> some registers are written now in different order and timeout is bumped
> (these changes shouldn't make any harm but I'm paranoid :).
> 

  Yeah, sure.

  Thanks.

-- 
tejun

