Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267729AbTADAMy>; Fri, 3 Jan 2003 19:12:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267731AbTADAMt>; Fri, 3 Jan 2003 19:12:49 -0500
Received: from hera.cwi.nl ([192.16.191.8]:40632 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S267729AbTADAMk>;
	Fri, 3 Jan 2003 19:12:40 -0500
From: Andries.Brouwer@cwi.nl
Date: Sat, 4 Jan 2003 01:21:11 +0100 (MET)
Message-Id: <UTC200301040021.h040LB128544.aeb@smtp.cwi.nl>
To: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: inquiry in scsi_scan.c
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Got a new USB device and noticed some scsi silliness while playing with it.

A bug in scsi_scan.c is

        sdev->inquiry = kmalloc(sdev->inquiry_len, GFP_ATOMIC);
        memcpy(sdev->inquiry, inq_result, sdev->inquiry_len);
        sdev->vendor = (char *) (sdev->inquiry + 8);
        sdev->model = (char *) (sdev->inquiry + 16);
        sdev->rev = (char *) (sdev->inquiry + 32);

since it happens that inquiry_len is short (in my case it is 5)
and the vendor/model/rev pointers are wild.
Catting /proc/scsi/scsi now yields random garbage.

I made a patch but hesitated between a small patch and a larger one.
Why do we have this malloced inquiry field? As far as I can see
nobody uses it. And the comment in scsi_add_lun() advises us
not to save the inquiry, precisely what we did until recently.
So, should this change from 2.5.11 be reverted?

Andries


[My present scsi_scan.c differes quite a lot from a stock one.
Already fixed the scsi_check_id_size() some time ago.
Below some diff fragments from today.]

+/*
+ * Do an INQUIRY with given length (minimum 5, maximum 255).
+ * Note: many devices react badly when given an unexpected length.
+ */
+static int
+scsi_do_inquiry(Scsi_Request *sreq, char *buffer, int len) {
+       Scsi_Device *sdev = sreq->sr_device;
+       unsigned char cmd[6];
+       int res;
+
+       SCSI_LOG_SCAN_BUS(3, printk(KERN_INFO "scsi scan: INQUIRY (len %d) "
+                                   "to host %d channel %d id %d lun %d\n",
+                                   len, sdev->host->host_no, sdev->channel,
+                                   sdev->id, sdev->lun));
+
+       memset(cmd, 0, 6);
+       cmd[0] = INQUIRY;
+       cmd[4] = len;
+       sreq->sr_cmd_len = 0;
+       sreq->sr_data_direction = SCSI_DATA_READ;
+       memset(buffer, 0, len);
+
+       scsi_wait_req(sreq, (void *) cmd, (void *) buffer, len,
+                     SCSI_TIMEOUT + 4 * HZ, 3);
+
+       res = sreq->sr_result;
+       SCSI_LOG_SCAN_BUS(3, printk(res ? KERN_INFO "scsi scan: "
+                                   "INQUIRY returned code 0x%x\n" :
+                                   KERN_INFO "scsi scan: INQUIRY OK\n", res));
+       return res;
+}

+/*
+ * The inquiry length is  inq_result[4] + 5  unless overridden.
+ */
+static int
+valid_inquiry_lth(int bflags, unsigned char *inq_result) {
+       int len = ((bflags & BLIST_INQUIRY_36) ? 36 :
+                  (bflags & BLIST_INQUIRY_58) ? 58 :
+                  inq_result[4] + 5);
+       if (len > 255)
+               len = 36;       /* sanity */
+       return len;
+}

Text in scsi_probe_lun(), including two reactions to comments:

static void
scsi_probe_lun(Scsi_Request *sreq, char *inq_result, int *bflags)
{
        Scsi_Device *sdev = sreq->sr_device;    /* a bit ugly */
        unsigned char scsi_cmd[MAX_COMMAND_SIZE];
        int res, possible_inq_resp_len;

        /* first issue an inquiry with conservative alloc_length */
        res = scsi_do_inquiry(sreq, inq_result, 36);

        if (res) {
                if ((driver_byte(res) & DRIVER_SENSE) != 0 &&
                    (sreq->sr_sense_buffer[2] & 0xf) == UNIT_ATTENTION &&
                    sreq->sr_sense_buffer[12] == 0x28 &&
                    sreq->sr_sense_buffer[13] == 0) {
                        /* not-ready to ready transition - good */
                        /* dpg: bogus? INQUIRY never returns UNIT_ATTENTION */
                        /* aeb: seen with an USB CF card reader */
                } else
                        /*
                         * assume no peripheral if any other sort of error
                         */
                        return;
        }

        /*
         * Get any flags for this device.
         *
         * Some devices return only 5 bytes for an INQUIRY, but the memset
         * in scsi_do_inquiry makes sure that scsi_get_device_flags() gets
         * well-defined arguments.
         */
        *bflags = scsi_get_device_flags(&inq_result[8], &inq_result[16]);

        possible_inq_resp_len = valid_inquiry_lth(*bflags, inq_result);

        if (possible_inq_resp_len > 36) {       /* do additional INQUIRY */
                res = scsi_do_inquiry(sreq, inq_result, possible_inq_resp_len);
                if (res)
                        return;

                /*
                 * The INQUIRY can change, this means the length can change.
                 */
                possible_inq_resp_len = valid_inquiry_lth(*bflags, inq_result);
        }

        sdev->inquiry_len = possible_inq_resp_len;

        /*
         * Abort if the response length is less than 36?
         * No, some USB devices just produce the minimal 5-byte INQUIRY.
         *
         * ...
         */


