Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268548AbTANDiB>; Mon, 13 Jan 2003 22:38:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268537AbTANDiB>; Mon, 13 Jan 2003 22:38:01 -0500
Received: from 216-239-45-4.google.com ([216.239.45.4]:56908 "EHLO
	216-239-45-4.google.com") by vger.kernel.org with ESMTP
	id <S268557AbTANDhk>; Mon, 13 Jan 2003 22:37:40 -0500
Message-ID: <3E2387B4.3050404@google.com>
Date: Mon, 13 Jan 2003 19:44:52 -0800
From: Ross Biro <rossb@google.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ross Biro <rossb@google.com>
CC: alan@lxorguk.ukuu.org.uk, andre@linux-ide.org, marcelo@conectiva.com.br,
       linux-kernel@vger.kernel.org
Subject: Re: PATCH: [2.4.21-pre3] IDE error recovery
References: <3E237867.4040009@google.com>
Content-Type: multipart/mixed;
 boundary="------------060905030700080506030304"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060905030700080506030304
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit


Someone said there were word wrapping problems with my mailer.  I'm too 
lazy to get a real mailer, so here's an attachment.

       Ross


Ross Biro wrote:

>
> Take this patch with a big grain of salt.
>
> The current IDE error recovery code will send a IDLEIMMEDIATE in the 
> case when a drive is still busy or has drq set during an error.  This 
> is a violation of the ATA spec and hoses up quite a few drives.  The 
> prefered form of error recovery seems to be a soft reset followed by a 
> set features.  This patch replaces the IDLEIMMEDIATE with a reset, but 
> does not do the set features.  The set features should not be 
> necessary, but at least one drive vendor does most of their testing 
> with the set features.  OK_TO_RESET_CONTROLLER must be set to 1 if 
> this patch is applied.
>
> I've modified the google kernel to add a desired_speed to ide_drive_t 
> and check to see if current_speed != desired_speed before every read 
> or write request.  This causes a set features after a reset.  I can 
> provide patches to do something similiar for 2.4.21, but I'm not sure 
> it's appropriate.  There are bugs in the way hdparm -X is handled in 
> 2.4.20, and this patch would fix them as well, but it may be too large 
> of a patch for a stable kernel.
>
> This also fixes drive_cmd_intr to do a little better checking to make 
> sure the device is ready.  The spec requires this, but any device that 
> sends an interrupt before it's ready is probably broken.
>
> I have no idea what impact this will have on older devices or non disks.
>
> This patch has only been minimally tested.
>
> ----- snip -------
> diff -durbB linux-2.4.20-p1/drivers/ide/ide-cd.c 
> linux-2.4.20-p2/drivers/ide/ide-cd.c
> --- linux-2.4.20-p1/drivers/ide/ide-cd.c    Wed Jan  8 16:25:04 2003
> +++ linux-2.4.20-p2/drivers/ide/ide-cd.c    Thu Jan  9 11:38:22 2003
> @@ -644,7 +644,11 @@
>     }
>     if (HWIF(drive)->INB(IDE_STATUS_REG) & (BUSY_STAT|DRQ_STAT)) {
>         /* force an abort */
> -        HWIF(drive)->OUTB(WIN_IDLEIMMEDIATE,IDE_COMMAND_REG);
> +                /* This violates the ATA Spec and causes trouble for
> +                   many modern hard drives.  I'm not sure if it is 
> necessary
> +                   for older devices or even modern cd-roms. -- RAB
> +                   
> HWIF(drive)->OUTB(WIN_IDLEIMMEDIATE,IDE_COMMAND_REG); */
> +                rq->errors |= ERROR_RESET;
>         }
>     if (rq->errors >= ERROR_MAX) {
>         DRIVER(drive)->end_request(drive, 0);
> diff -durbB linux-2.4.20-p1/drivers/ide/ide-disk.c 
> linux-2.4.20-p2/drivers/ide/ide-disk.c
> --- linux-2.4.20-p1/drivers/ide/ide-disk.c    Wed Jan  8 16:25:17 2003
> +++ linux-2.4.20-p2/drivers/ide/ide-disk.c    Thu Jan  9 11:40:20 2003
> @@ -943,7 +943,11 @@
>     }
>     if (hwif->INB(IDE_STATUS_REG) & (BUSY_STAT|DRQ_STAT)) {
>         /* force an abort */
> -        hwif->OUTB(WIN_IDLEIMMEDIATE,IDE_COMMAND_REG);
> +                /* This violates the ATA Spec and causes trouble for
> +                   many modern hard drives.  I'm not sure if it is 
> necessary
> +                   for older devices or even other modern devices. -- 
> RAB
> +                   hwif->OUTB(WIN_IDLEIMMEDIATE,IDE_COMMAND_REG); */
> +                rq->errors |= ERROR_RESET;
>     }
>     if (rq->errors >= ERROR_MAX)
>         DRIVER(drive)->end_request(drive, 0);
> diff -durbB linux-2.4.20-p1/drivers/ide/ide-io.c 
> linux-2.4.20-p2/drivers/ide/ide-io.c
> --- linux-2.4.20-p1/drivers/ide/ide-io.c    Wed Jan  8 16:25:37 2003
> +++ linux-2.4.20-p2/drivers/ide/ide-io.c    Mon Jan 13 18:01:52 2003
> @@ -328,7 +328,12 @@
>     }
>     if (hwif->INB(IDE_STATUS_REG) & (BUSY_STAT|DRQ_STAT)) {
>         /* force an abort */
> +                /* This violates the ATA Spec and causes trouble for
> +                   many modern hard drives.  I'm not sure if it is 
> necessary
> +                   for older devices or even other modern ata devices 
> -- RAB
>         hwif->OUTB(WIN_IDLEIMMEDIATE,IDE_COMMAND_REG);
> +                */
> +                rq->errors |= ERROR_RESET;
>     }
>     if (rq->errors >= ERROR_MAX) {
>         if (drive->driver != NULL)
> @@ -397,18 +402,63 @@
>     struct request *rq = HWGROUP(drive)->rq;
>     ide_hwif_t *hwif = HWIF(drive);
>     u8 *args = (u8 *) rq->buffer;
> -    u8 stat = hwif->INB(IDE_STATUS_REG);
> +    u8 stat;
>     int retries = 10;
>
> +        /* The ATA-6 spec requires a 400ns wait when entering the
> +           HPIOI1: Check_status State from the HI4 state.  We should
> +           only get here coming from the HPIOI0 INTRQ_wait state, but
> +           better safe than sorry.  The spec also says a read of the
> +           alt status register accomplishes this wait. */
> +    if (IDE_CONTROL_REG)
> +        (void)hwif->INB(IDE_ALTSTATUS_REG);
> +    else
> +                ide_delay_400ns();
> +
> +        /* The ATA-6 spec says that the should enter the check status
> +           state when it get's an interrupt for a drive command, so
> +           technically, the device can send an interrupt before it has
> +           finished.  I would consider any device that does this to be
> +           broken, but the spec allows it. --RAB 1/10/03 */
> +    stat = hwif->INB(IDE_STATUS_REG);
> +        if (stat & BUSY_STAT) {
> +                /* We are just supposed to poll from here on out. */
> +                if (HWGROUP(drive)->poll_timeout == 0) {
> +                        
> HWGROUP(drive)->poll_timeout=WAIT_CMD/CMD_POLL_TICKS;
> +                } else if (--HWGROUP(drive)->poll_timeout == 0) {
> +                        return DRIVER(drive)->error(drive,
> +                                                    "drive_cmd timeout",
> +                                                    stat);
> +                }
> +                ide_set_handler(drive, drive_cmd_intr, 
> CMD_POLL_TICKS, NULL);
> +                return ide_started;
> +        }
> +
>     local_irq_enable();
> -    if ((stat & DRQ_STAT) && args && args[3]) {
> +
> +        /* We want to make sure that the device and the command
> +           both agree on wether or not data is returned by the command
> +           that was just issued.  If they do not, it is an error. */
> +        if (args && args[3]) {
>         u8 io_32bit = drive->io_32bit;
> +                /* The software expects some data back.  If the drive 
> does
> +                   not, then it is an error. */
> +                if (!(stat & DRQ_STAT)) {
> +                        return DRIVER(drive)->error(drive, "drive_cmd 
> no data", stat);
> +                }
>         drive->io_32bit = 0;
>         hwif->ata_input_data(drive, &args[4], args[3] * SECTOR_WORDS);
>         drive->io_32bit = io_32bit;
>         while (((stat = hwif->INB(IDE_STATUS_REG)) & BUSY_STAT) && 
> retries--)
>             udelay(100);
> +        } else {
> +                /* The software does not expect data, so if the drive
> +                   returns some, then it's an error. */
> +                if (stat & DRQ_STAT) {
> +                        return DRIVER(drive)->error(drive, "drive_cmd 
> unexpected data", stat);
> +                }
>     }
> +
>
>     if (!OK_STAT(stat, READY_STAT, BAD_STAT))
>         return DRIVER(drive)->error(drive, "drive_cmd", stat);
> diff -durbB linux-2.4.20-p1/drivers/ide/ide-taskfile.c 
> linux-2.4.20-p2/drivers/ide/ide-taskfile.c
> --- linux-2.4.20-p1/drivers/ide/ide-taskfile.c    Wed Jan  8 16:25:43 
> 2003
> +++ linux-2.4.20-p2/drivers/ide/ide-taskfile.c    Fri Jan 10 11:19:07 
> 2003
> @@ -485,7 +485,13 @@
>     }
>     if (hwif->INB(IDE_STATUS_REG) & (BUSY_STAT|DRQ_STAT)) {
>         /* force an abort */
> -        hwif->OUTB(WIN_IDLEIMMEDIATE, IDE_COMMAND_REG);
> +                /* This violates the ATA Spec and causes trouble for
> +                   many modern hard drives.  I'm not sure if it is 
> necessary
> +                   for older devices or even other modern ata devices 
> -- RAB
> +        hwif->OUTB(WIN_IDLEIMMEDIATE,IDE_COMMAND_REG);
> +                */
> +                rq->errors |= ERROR_RESET;
> +
>     }
>     if (rq->errors >= ERROR_MAX) {
>         DRIVER(drive)->end_request(drive, 0);
> diff -durbB linux-2.4.20-p1/include/linux/ide.h 
> linux-2.4.20-p2/include/linux/ide.h
> --- linux-2.4.20-p1/include/linux/ide.h    Thu Jan  9 15:37:22 2003
> +++ linux-2.4.20-p2/include/linux/ide.h    Mon Jan 13 18:04:47 2003
> @@ -271,6 +271,10 @@
> #define WAIT_WORSTCASE    (30*HZ)    /* 30sec  - worst case when 
> spinning up */
> #define WAIT_CMD    (10*HZ)    /* 10sec  - maximum wait for an IRQ to 
> happen */
> #define WAIT_MIN_SLEEP    (2*HZ/100)    /* 20msec - minimum sleep time */
> +#define CMD_POLL_TICKS  (1)     /* How long to wait in ticks between
> +                                   status checks for a drive cmd
> +                                   that set it's interrupt before it
> +                                   was complete. */
>
> #define HOST(hwif,chipset)                    \
> {                                \
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/




--------------060905030700080506030304
Content-Type: application/x-java-vm;
 name="patch2"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="patch2"

ZGlmZiAtZHVyYkIgbGludXgtMi40LjIwLXAxL2RyaXZlcnMvaWRlL2lkZS1jZC5jIGxpbnV4
LTIuNC4yMC1wMi9kcml2ZXJzL2lkZS9pZGUtY2QuYwotLS0gbGludXgtMi40LjIwLXAxL2Ry
aXZlcnMvaWRlL2lkZS1jZC5jCVdlZCBKYW4gIDggMTY6MjU6MDQgMjAwMworKysgbGludXgt
Mi40LjIwLXAyL2RyaXZlcnMvaWRlL2lkZS1jZC5jCVRodSBKYW4gIDkgMTE6Mzg6MjIgMjAw
MwpAQCAtNjQ0LDcgKzY0NCwxMSBAQAogCX0KIAlpZiAoSFdJRihkcml2ZSktPklOQihJREVf
U1RBVFVTX1JFRykgJiAoQlVTWV9TVEFUfERSUV9TVEFUKSkgewogCQkvKiBmb3JjZSBhbiBh
Ym9ydCAqLwotCQlIV0lGKGRyaXZlKS0+T1VUQihXSU5fSURMRUlNTUVESUFURSxJREVfQ09N
TUFORF9SRUcpOworICAgICAgICAgICAgICAgIC8qIFRoaXMgdmlvbGF0ZXMgdGhlIEFUQSBT
cGVjIGFuZCBjYXVzZXMgdHJvdWJsZSBmb3IKKyAgICAgICAgICAgICAgICAgICBtYW55IG1v
ZGVybiBoYXJkIGRyaXZlcy4gIEknbSBub3Qgc3VyZSBpZiBpdCBpcyBuZWNlc3NhcnkKKyAg
ICAgICAgICAgICAgICAgICBmb3Igb2xkZXIgZGV2aWNlcyBvciBldmVuIG1vZGVybiBjZC1y
b21zLiAtLSBSQUIKKyAgICAgICAgICAgICAgICAgICBIV0lGKGRyaXZlKS0+T1VUQihXSU5f
SURMRUlNTUVESUFURSxJREVfQ09NTUFORF9SRUcpOyAqLworICAgICAgICAgICAgICAgIHJx
LT5lcnJvcnMgfD0gRVJST1JfUkVTRVQ7CiAgICAgICAgIH0KIAlpZiAocnEtPmVycm9ycyA+
PSBFUlJPUl9NQVgpIHsKIAkJRFJJVkVSKGRyaXZlKS0+ZW5kX3JlcXVlc3QoZHJpdmUsIDAp
OwpkaWZmIC1kdXJiQiBsaW51eC0yLjQuMjAtcDEvZHJpdmVycy9pZGUvaWRlLWRpc2suYyBs
aW51eC0yLjQuMjAtcDIvZHJpdmVycy9pZGUvaWRlLWRpc2suYwotLS0gbGludXgtMi40LjIw
LXAxL2RyaXZlcnMvaWRlL2lkZS1kaXNrLmMJV2VkIEphbiAgOCAxNjoyNToxNyAyMDAzCisr
KyBsaW51eC0yLjQuMjAtcDIvZHJpdmVycy9pZGUvaWRlLWRpc2suYwlUaHUgSmFuICA5IDEx
OjQwOjIwIDIwMDMKQEAgLTk0Myw3ICs5NDMsMTEgQEAKIAl9CiAJaWYgKGh3aWYtPklOQihJ
REVfU1RBVFVTX1JFRykgJiAoQlVTWV9TVEFUfERSUV9TVEFUKSkgewogCQkvKiBmb3JjZSBh
biBhYm9ydCAqLwotCQlod2lmLT5PVVRCKFdJTl9JRExFSU1NRURJQVRFLElERV9DT01NQU5E
X1JFRyk7CisgICAgICAgICAgICAgICAgLyogVGhpcyB2aW9sYXRlcyB0aGUgQVRBIFNwZWMg
YW5kIGNhdXNlcyB0cm91YmxlIGZvcgorICAgICAgICAgICAgICAgICAgIG1hbnkgbW9kZXJu
IGhhcmQgZHJpdmVzLiAgSSdtIG5vdCBzdXJlIGlmIGl0IGlzIG5lY2Vzc2FyeQorICAgICAg
ICAgICAgICAgICAgIGZvciBvbGRlciBkZXZpY2VzIG9yIGV2ZW4gb3RoZXIgbW9kZXJuIGRl
dmljZXMuIC0tIFJBQgorICAgICAgICAgICAgICAgICAgIGh3aWYtPk9VVEIoV0lOX0lETEVJ
TU1FRElBVEUsSURFX0NPTU1BTkRfUkVHKTsgKi8KKyAgICAgICAgICAgICAgICBycS0+ZXJy
b3JzIHw9IEVSUk9SX1JFU0VUOwogCX0KIAlpZiAocnEtPmVycm9ycyA+PSBFUlJPUl9NQVgp
CiAJCURSSVZFUihkcml2ZSktPmVuZF9yZXF1ZXN0KGRyaXZlLCAwKTsKZGlmZiAtZHVyYkIg
bGludXgtMi40LjIwLXAxL2RyaXZlcnMvaWRlL2lkZS1pby5jIGxpbnV4LTIuNC4yMC1wMi9k
cml2ZXJzL2lkZS9pZGUtaW8uYwotLS0gbGludXgtMi40LjIwLXAxL2RyaXZlcnMvaWRlL2lk
ZS1pby5jCVdlZCBKYW4gIDggMTY6MjU6MzcgMjAwMworKysgbGludXgtMi40LjIwLXAyL2Ry
aXZlcnMvaWRlL2lkZS1pby5jCU1vbiBKYW4gMTMgMTg6MDE6NTIgMjAwMwpAQCAtMzI4LDcg
KzMyOCwxMiBAQAogCX0KIAlpZiAoaHdpZi0+SU5CKElERV9TVEFUVVNfUkVHKSAmIChCVVNZ
X1NUQVR8RFJRX1NUQVQpKSB7CiAJCS8qIGZvcmNlIGFuIGFib3J0ICovCisgICAgICAgICAg
ICAgICAgLyogVGhpcyB2aW9sYXRlcyB0aGUgQVRBIFNwZWMgYW5kIGNhdXNlcyB0cm91Ymxl
IGZvcgorICAgICAgICAgICAgICAgICAgIG1hbnkgbW9kZXJuIGhhcmQgZHJpdmVzLiAgSSdt
IG5vdCBzdXJlIGlmIGl0IGlzIG5lY2Vzc2FyeQorICAgICAgICAgICAgICAgICAgIGZvciBv
bGRlciBkZXZpY2VzIG9yIGV2ZW4gb3RoZXIgbW9kZXJuIGF0YSBkZXZpY2VzIC0tIFJBQgog
CQlod2lmLT5PVVRCKFdJTl9JRExFSU1NRURJQVRFLElERV9DT01NQU5EX1JFRyk7CisgICAg
ICAgICAgICAgICAgKi8KKyAgICAgICAgICAgICAgICBycS0+ZXJyb3JzIHw9IEVSUk9SX1JF
U0VUOwogCX0KIAlpZiAocnEtPmVycm9ycyA+PSBFUlJPUl9NQVgpIHsKIAkJaWYgKGRyaXZl
LT5kcml2ZXIgIT0gTlVMTCkKQEAgLTM5NywxOCArNDAyLDYzIEBACiAJc3RydWN0IHJlcXVl
c3QgKnJxID0gSFdHUk9VUChkcml2ZSktPnJxOwogCWlkZV9od2lmX3QgKmh3aWYgPSBIV0lG
KGRyaXZlKTsKIAl1OCAqYXJncyA9ICh1OCAqKSBycS0+YnVmZmVyOwotCXU4IHN0YXQgPSBo
d2lmLT5JTkIoSURFX1NUQVRVU19SRUcpOworCXU4IHN0YXQ7CiAJaW50IHJldHJpZXMgPSAx
MDsKIAorICAgICAgICAvKiBUaGUgQVRBLTYgc3BlYyByZXF1aXJlcyBhIDQwMG5zIHdhaXQg
d2hlbiBlbnRlcmluZyB0aGUKKyAgICAgICAgICAgSFBJT0kxOiBDaGVja19zdGF0dXMgU3Rh
dGUgZnJvbSB0aGUgSEk0IHN0YXRlLiAgV2Ugc2hvdWxkCisgICAgICAgICAgIG9ubHkgZ2V0
IGhlcmUgY29taW5nIGZyb20gdGhlIEhQSU9JMCBJTlRSUV93YWl0IHN0YXRlLCBidXQKKyAg
ICAgICAgICAgYmV0dGVyIHNhZmUgdGhhbiBzb3JyeS4gIFRoZSBzcGVjIGFsc28gc2F5cyBh
IHJlYWQgb2YgdGhlCisgICAgICAgICAgIGFsdCBzdGF0dXMgcmVnaXN0ZXIgYWNjb21wbGlz
aGVzIHRoaXMgd2FpdC4gKi8KKwlpZiAoSURFX0NPTlRST0xfUkVHKQorCQkodm9pZClod2lm
LT5JTkIoSURFX0FMVFNUQVRVU19SRUcpOworCWVsc2UKKyAgICAgICAgICAgICAgICBpZGVf
ZGVsYXlfNDAwbnMoKTsKKworICAgICAgICAvKiBUaGUgQVRBLTYgc3BlYyBzYXlzIHRoYXQg
dGhlIHNob3VsZCBlbnRlciB0aGUgY2hlY2sgc3RhdHVzCisgICAgICAgICAgIHN0YXRlIHdo
ZW4gaXQgZ2V0J3MgYW4gaW50ZXJydXB0IGZvciBhIGRyaXZlIGNvbW1hbmQsIHNvCisgICAg
ICAgICAgIHRlY2huaWNhbGx5LCB0aGUgZGV2aWNlIGNhbiBzZW5kIGFuIGludGVycnVwdCBi
ZWZvcmUgaXQgaGFzCisgICAgICAgICAgIGZpbmlzaGVkLiAgSSB3b3VsZCBjb25zaWRlciBh
bnkgZGV2aWNlIHRoYXQgZG9lcyB0aGlzIHRvIGJlIAorICAgICAgICAgICBicm9rZW4sIGJ1
dCB0aGUgc3BlYyBhbGxvd3MgaXQuIC0tUkFCIDEvMTAvMDMgKi8KKwlzdGF0ID0gaHdpZi0+
SU5CKElERV9TVEFUVVNfUkVHKTsKKyAgICAgICAgaWYgKHN0YXQgJiBCVVNZX1NUQVQpIHsK
KyAgICAgICAgICAgICAgICAvKiBXZSBhcmUganVzdCBzdXBwb3NlZCB0byBwb2xsIGZyb20g
aGVyZSBvbiBvdXQuICovCisgICAgICAgICAgICAgICAgaWYgKEhXR1JPVVAoZHJpdmUpLT5w
b2xsX3RpbWVvdXQgPT0gMCkgeworICAgICAgICAgICAgICAgICAgICAgICAgSFdHUk9VUChk
cml2ZSktPnBvbGxfdGltZW91dD1XQUlUX0NNRC9DTURfUE9MTF9USUNLUzsKKyAgICAgICAg
ICAgICAgICB9IGVsc2UgaWYgKC0tSFdHUk9VUChkcml2ZSktPnBvbGxfdGltZW91dCA9PSAw
KSB7CisgICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gRFJJVkVSKGRyaXZlKS0+ZXJy
b3IoZHJpdmUsIAorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICJkcml2ZV9jbWQgdGltZW91dCIsCisgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3RhdCk7CisgICAgICAgICAgICAgICAg
fQorICAgICAgICAgICAgICAgIGlkZV9zZXRfaGFuZGxlcihkcml2ZSwgZHJpdmVfY21kX2lu
dHIsIENNRF9QT0xMX1RJQ0tTLCBOVUxMKTsKKyAgICAgICAgICAgICAgICByZXR1cm4gaWRl
X3N0YXJ0ZWQ7CisgICAgICAgIH0KKwogCWxvY2FsX2lycV9lbmFibGUoKTsKLQlpZiAoKHN0
YXQgJiBEUlFfU1RBVCkgJiYgYXJncyAmJiBhcmdzWzNdKSB7CisKKyAgICAgICAgLyogV2Ug
d2FudCB0byBtYWtlIHN1cmUgdGhhdCB0aGUgZGV2aWNlIGFuZCB0aGUgY29tbWFuZAorICAg
ICAgICAgICBib3RoIGFncmVlIG9uIHdldGhlciBvciBub3QgZGF0YSBpcyByZXR1cm5lZCBi
eSB0aGUgY29tbWFuZAorICAgICAgICAgICB0aGF0IHdhcyBqdXN0IGlzc3VlZC4gIElmIHRo
ZXkgZG8gbm90LCBpdCBpcyBhbiBlcnJvci4gKi8KKyAgICAgICAgaWYgKGFyZ3MgJiYgYXJn
c1szXSkgewogCQl1OCBpb18zMmJpdCA9IGRyaXZlLT5pb18zMmJpdDsKKyAgICAgICAgICAg
ICAgICAvKiBUaGUgc29mdHdhcmUgZXhwZWN0cyBzb21lIGRhdGEgYmFjay4gIElmIHRoZSBk
cml2ZSBkb2VzCisgICAgICAgICAgICAgICAgICAgbm90LCB0aGVuIGl0IGlzIGFuIGVycm9y
LiAqLworICAgICAgICAgICAgICAgIGlmICghKHN0YXQgJiBEUlFfU1RBVCkpIHsKKyAgICAg
ICAgICAgICAgICAgICAgICAgIHJldHVybiBEUklWRVIoZHJpdmUpLT5lcnJvcihkcml2ZSwg
ImRyaXZlX2NtZCBubyBkYXRhIiwgc3RhdCk7CisgICAgICAgICAgICAgICAgfQogCQlkcml2
ZS0+aW9fMzJiaXQgPSAwOwogCQlod2lmLT5hdGFfaW5wdXRfZGF0YShkcml2ZSwgJmFyZ3Nb
NF0sIGFyZ3NbM10gKiBTRUNUT1JfV09SRFMpOwogCQlkcml2ZS0+aW9fMzJiaXQgPSBpb18z
MmJpdDsKIAkJd2hpbGUgKCgoc3RhdCA9IGh3aWYtPklOQihJREVfU1RBVFVTX1JFRykpICYg
QlVTWV9TVEFUKSAmJiByZXRyaWVzLS0pCiAJCQl1ZGVsYXkoMTAwKTsKKyAgICAgICAgfSBl
bHNlIHsKKyAgICAgICAgICAgICAgICAvKiBUaGUgc29mdHdhcmUgZG9lcyBub3QgZXhwZWN0
IGRhdGEsIHNvIGlmIHRoZSBkcml2ZQorICAgICAgICAgICAgICAgICAgIHJldHVybnMgc29t
ZSwgdGhlbiBpdCdzIGFuIGVycm9yLiAqLworICAgICAgICAgICAgICAgIGlmIChzdGF0ICYg
RFJRX1NUQVQpIHsKKyAgICAgICAgICAgICAgICAgICAgICAgIHJldHVybiBEUklWRVIoZHJp
dmUpLT5lcnJvcihkcml2ZSwgImRyaXZlX2NtZCB1bmV4cGVjdGVkIGRhdGEiLCBzdGF0KTsK
KyAgICAgICAgICAgICAgICB9CiAJfQorCiAKIAlpZiAoIU9LX1NUQVQoc3RhdCwgUkVBRFlf
U1RBVCwgQkFEX1NUQVQpKQogCQlyZXR1cm4gRFJJVkVSKGRyaXZlKS0+ZXJyb3IoZHJpdmUs
ICJkcml2ZV9jbWQiLCBzdGF0KTsKZGlmZiAtZHVyYkIgbGludXgtMi40LjIwLXAxL2RyaXZl
cnMvaWRlL2lkZS10YXNrZmlsZS5jIGxpbnV4LTIuNC4yMC1wMi9kcml2ZXJzL2lkZS9pZGUt
dGFza2ZpbGUuYwotLS0gbGludXgtMi40LjIwLXAxL2RyaXZlcnMvaWRlL2lkZS10YXNrZmls
ZS5jCVdlZCBKYW4gIDggMTY6MjU6NDMgMjAwMworKysgbGludXgtMi40LjIwLXAyL2RyaXZl
cnMvaWRlL2lkZS10YXNrZmlsZS5jCUZyaSBKYW4gMTAgMTE6MTk6MDcgMjAwMwpAQCAtNDg1
LDcgKzQ4NSwxMyBAQAogCX0KIAlpZiAoaHdpZi0+SU5CKElERV9TVEFUVVNfUkVHKSAmIChC
VVNZX1NUQVR8RFJRX1NUQVQpKSB7CiAJCS8qIGZvcmNlIGFuIGFib3J0ICovCi0JCWh3aWYt
Pk9VVEIoV0lOX0lETEVJTU1FRElBVEUsIElERV9DT01NQU5EX1JFRyk7CisgICAgICAgICAg
ICAgICAgLyogVGhpcyB2aW9sYXRlcyB0aGUgQVRBIFNwZWMgYW5kIGNhdXNlcyB0cm91Ymxl
IGZvcgorICAgICAgICAgICAgICAgICAgIG1hbnkgbW9kZXJuIGhhcmQgZHJpdmVzLiAgSSdt
IG5vdCBzdXJlIGlmIGl0IGlzIG5lY2Vzc2FyeQorICAgICAgICAgICAgICAgICAgIGZvciBv
bGRlciBkZXZpY2VzIG9yIGV2ZW4gb3RoZXIgbW9kZXJuIGF0YSBkZXZpY2VzIC0tIFJBQgor
CQlod2lmLT5PVVRCKFdJTl9JRExFSU1NRURJQVRFLElERV9DT01NQU5EX1JFRyk7CisgICAg
ICAgICAgICAgICAgKi8KKyAgICAgICAgICAgICAgICBycS0+ZXJyb3JzIHw9IEVSUk9SX1JF
U0VUOworCiAJfQogCWlmIChycS0+ZXJyb3JzID49IEVSUk9SX01BWCkgewogCQlEUklWRVIo
ZHJpdmUpLT5lbmRfcmVxdWVzdChkcml2ZSwgMCk7CmRpZmYgLWR1cmJCIGxpbnV4LTIuNC4y
MC1wMS9pbmNsdWRlL2xpbnV4L2lkZS5oIGxpbnV4LTIuNC4yMC1wMi9pbmNsdWRlL2xpbnV4
L2lkZS5oCi0tLSBsaW51eC0yLjQuMjAtcDEvaW5jbHVkZS9saW51eC9pZGUuaAlUaHUgSmFu
ICA5IDE1OjM3OjIyIDIwMDMKKysrIGxpbnV4LTIuNC4yMC1wMi9pbmNsdWRlL2xpbnV4L2lk
ZS5oCU1vbiBKYW4gMTMgMTg6MDQ6NDcgMjAwMwpAQCAtMjcxLDYgKzI3MSwxMCBAQAogI2Rl
ZmluZSBXQUlUX1dPUlNUQ0FTRQkoMzAqSFopCS8qIDMwc2VjICAtIHdvcnN0IGNhc2Ugd2hl
biBzcGlubmluZyB1cCAqLwogI2RlZmluZSBXQUlUX0NNRAkoMTAqSFopCS8qIDEwc2VjICAt
IG1heGltdW0gd2FpdCBmb3IgYW4gSVJRIHRvIGhhcHBlbiAqLwogI2RlZmluZSBXQUlUX01J
Tl9TTEVFUAkoMipIWi8xMDApCS8qIDIwbXNlYyAtIG1pbmltdW0gc2xlZXAgdGltZSAqLwor
I2RlZmluZSBDTURfUE9MTF9USUNLUyAgKDEpICAgICAvKiBIb3cgbG9uZyB0byB3YWl0IGlu
IHRpY2tzIGJldHdlZW4KKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3Rh
dHVzIGNoZWNrcyBmb3IgYSBkcml2ZSBjbWQKKyAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgdGhhdCBzZXQgaXQncyBpbnRlcnJ1cHQgYmVmb3JlIGl0CisgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIHdhcyBjb21wbGV0ZS4gKi8KIAogI2RlZmluZSBI
T1NUKGh3aWYsY2hpcHNldCkJCQkJCVwKIHsJCQkJCQkJCVwK
--------------060905030700080506030304--

