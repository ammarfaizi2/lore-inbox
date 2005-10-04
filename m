Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932435AbVJDMo4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932435AbVJDMo4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 08:44:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932416AbVJDMoc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 08:44:32 -0400
Received: from magic.adaptec.com ([216.52.22.17]:26520 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id S932406AbVJDMoX convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 08:44:23 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: 2.6.13.2 aacraid regression
Date: Tue, 4 Oct 2005 08:44:21 -0400
Message-ID: <547AF3BD0F3F0B4CBDC379BAC7E4189F01AA0135@otce2k03.adaptec.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.6.13.2 aacraid regression
Thread-Index: AcXIZKFZsBTK1dnsSwKmNSJmN2l7mgAdkaMg
From: "Salyzyn, Mark" <mark_salyzyn@adaptec.com>
To: "Juan D Ch" <jchimienti@most.com.ar>
Cc: "Mark Haverkamp" <markh@osdl.org>, <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am sorry you are experiencing problems with the driver and the
Adapter.

The controller is failing to complete commands within 130 seconds
(total) under load; yes, the adapter is *DEAD*. Although the changes in
the driver between these two releases is numerous, the primary goal of
those changes increased the performance of the system which could take a
marginal controller over the edge. We have to determine if you have a
marginal controller, cables and drives first before we can explore the
possibility that these changes are stressing the controller's firmware
past some breaking point that we can mitigate with adjustments in the
driver. Tuning the driver with a bad controller or set of drives will
only lead to frustration and inconsistent results.

Please confirm with Adaptec Technical support that you have a compatible
set of drives with the controller. If compatible, please ensure that
your SATA cables are clean and not mechanically stressed. Make sure you
have the latest Firmware release in the Adapter, but we may ask you to
hold off on this if you are willing to experiment.

One of the changes in this driver is to negotiate with later firmware
some of the maximum characteristics (largest transfer, largest sg table
size, largest queue of outstanding commands). These characteristics map
to internal adapter limits and can be tuned by the adapter at
initialization time. The negotiated values can be changed by the RAID
management software to aid in increased performance based on the array
requirements.

Earlier firmware without these negotiation would have its transfer size
hard coded and increased from 64K to 256K, its sg table size moved from
16 to 34, 38 or 57 depending on controller model and environment, and
its queue of outstanding commands increased from 100 to 512. These
limits were consulted with the firmware team and tested out in our labs.
Nothing is perfect, as we discovered the maximum transfer size had to be
reduced recently from 1G to 256K as that corner did not appear to be
fully tested (oops). Any one, or combination, of these characteristics
could be a trigger for the failure for older firmware without the
negotiations.

If you are willing to take some time to explore these limits for the
benefit of the community, I would beg you to hold off the step above
where I request you to update the firmware (if it is not already) and
permit these changes to be explored. We would like to find a combination
that 'just' works and back off by a small amount after that.

I understand if you are unwilling to explore these limits on a
production server. Upgrading the firmware to the latest may be the
easiest and fastest path to resolution.

If you are game, let me demonstrate how to tune the driver (sorry, none
of these were made insmod parameters, that was short-sighted of me).

To adjust the outstanding commands tune the value of AAC_NUM_IO_FIB in
the .../drivers/scsi/aacraid/aacraid.h file and recompile the driver.
Values between (108 - AAC_NUM_MGT_FIB) and (512 - AAC_NUM_MGT_FIB)
should be explored.

To adjust the maximum command size, adjust the value of
AAC_MAX_32BIT_SGBCOUNT in the aacraid.h file. Values of 256 & 128 should
be tried.

To adjust the maximum number of sg elements the AAC_QUIRK_34SG may need
to be added in the linit.c file for the 2610 adapter, or the formulas in
the aachba.c file will need to be modified (see code fragment below). I
was assured that the 2610 was never shipped with firmware that had this
34 sg element hard limit, but for this test, lets cast doubt on that.

/*
 * 57 scatter gather elements
 */
dev->scsi_host_ptr->sg_tablesize = (dev->max_fib_size -
        sizeof(struct aac_fibhdr) -
        sizeof(struct aac_write) + sizeof(struct sgmap)) /
                sizeof(struct sgmap);
if (dev->dac_support) {
        /*
         * 38 scatter gather elements
         */
        dev->scsi_host_ptr->sg_tablesize =
                (dev->max_fib_size -
                sizeof(struct aac_fibhdr) -
                sizeof(struct aac_write64) +
                sizeof(struct sgmap64)) /
                        sizeof(struct sgmap64);
}
dev->scsi_host_ptr->max_sectors = AAC_MAX_32BIT_SGBCOUNT;
if(!(dev->adapter_info.options & AAC_OPT_NEW_COMM)) {
        /*
         * Worst case size that could cause sg overflow when
         * we break up SG elements that are larger than 64KB.
         * Would be nice if we could tell the SCSI layer what
         * the maximum SG element size can be. Worst case is
         * (sg_tablesize-1) 4KB elements with one 64KB
         * element.
         *      32bit -> 468 or 238KB   64bit -> 424 or 212KB
         */
        dev->scsi_host_ptr->max_sectors =
          (dev->scsi_host_ptr->sg_tablesize * 8) + 112;
}

I look forward to your correspondence.

Sincerely -- Mark Salyzyn


-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Juan D Ch
Sent: Monday, October 03, 2005 5:46 PM
To: linux-kernel@vger.kernel.org
Subject: 2.6.13.2 aacraid regression



Hi this is my first post in the list. I will try to make this mail short

and useful, sorry but english is not my first language.

I have a client that has a HP Proliant ML 150 G2 with a 6 port SATA RAID
Controler Adaptec 2610SA, with HP part number 372953-B21. 
I tried to install debian, but 2.6.8 kernel doesn't support this
controler. So I installed the system in a PATA drive and then compiled
the 2.6.13.2 
kernel from kernel.org. This kernel recognizes the controler so i
formatted 
the array and start coping data. I copied some  dirs in /dev/sda1 
and then, after transferring a random amount of data (sometimes a couple
of MB, sometimes a few GB) the following messages appear:

------

Sep 30 10:16:59 syrah kernel: aacraid: Host adapter reset request. SCSI 
hang ?
Sep 30 10:16:59 syrah kernel: aacraid: Host adapter appears dead Sep 30
10:16:59 syrah kernel: scsi: Device offlined - not ready after error 
recovery: host 0 channel 0 id 0 lun 0
Sep 30 10:16:59 syrah last message repeated 2 times
Sep 30 10:16:59 syrah kernel: SCSI error : <0 0 0 0> return code =
0x6000000 Sep 30 10:16:59 syrah kernel: end_request: I/O error, dev sda,
sector 895 Sep 30 10:16:59 syrah kernel: scsi0 (0:0): rejecting I/O to
offline device

-----

When this happens, I need to reboot in order to see the device again.

I tried 2.6.12.6 with the same options and the controller works fine.

As this is a production server it's difficult for me to track down the
exact change that introduced this error; so any hints would be highly
appreciated.

Thanks a lot


juandie

-- 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel"
in the body of a message to majordomo@vger.kernel.org More majordomo
info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
