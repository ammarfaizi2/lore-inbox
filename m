Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265909AbTADC7n>; Fri, 3 Jan 2003 21:59:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265894AbTADC7n>; Fri, 3 Jan 2003 21:59:43 -0500
Received: from hera.cwi.nl ([192.16.191.8]:59362 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S265890AbTADC7g>;
	Fri, 3 Jan 2003 21:59:36 -0500
From: Andries.Brouwer@cwi.nl
Date: Sat, 4 Jan 2003 04:07:51 +0100 (MET)
Message-Id: <UTC200301040307.h0437pY06513.aeb@smtp.cwi.nl>
To: Andries.Brouwer@cwi.nl, mdharm-kernel@one-eyed-alien.net
Subject: Re: inquiry in scsi_scan.c
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Dharm writes:

> There should probably be a sanity check to never ask for INQUIRY
> less than 36 bytes.  I thought there used to be such a thing....

As Doug also points out, we ask for 36, but there is no
guarantee that we get what we ask for.

> Actually, 5 isn't minimal... it's sub-minimal.
> That's an error in the INQUIRY data/
> The minimum (by spec) is 36 bytes.

No. Quoting:

"The INQUIRY data (Table 7-9) contains a five byte header,
followed by the vendor unique parameters, if any."
(SCSI-1 standard)

So, as long as we are willing to support SCSI-1 devices,
we must accept that the INQUIRY data can be as short as this.
And in fact all our other code is careful - look at
print_inquiry() how before looking at a byte we check
whether it really there.


On the other hand, my case was not an ancient SCSI-1 device,
it was a brand new USB device. So, I have the SCSI host in hand.
Looking at what happens:

usb-storage: usb_stor_bulk_transfer_buf(): xfer 36 bytes
 00 80 00 00 00 00 00 00 4F 45 49 2D 55 53 42 20
 53 6D 61 72 74 4D 65 64 69 61 20 20 20 20 20 20
 32 2E 30 35
usb-storage: Status code 0; transferred 36/36
usb-storage: Fixing INQUIRY data to show SCSI rev 2 - was 0
usb-storage: Fixing INQUIRY data to show length 36 - was 0

and all is fine.

Instead of the old garbage I now see:
% cat /proc/scsi/scsi
...
Host: scsi2 Channel: 00 Id: 00 Lun: 00
  Vendor: OEI-USB  Model: SmartMedia       Rev: 2.05
  Type:   Direct-Access                    ANSI SCSI revision: 02
...


Conclusion:
(i) scsi_scan.c has to be careful about INQUIRY lengths,
and some patch is required for devices that return a short length.
(ii) usb-storage knows the transport length, and can fix it
in case it is (5+)0. For example, in protocol.c:fix_inquiry_data():

static void fix_inquiry_data(Scsi_Cmnd *srb)
{
        unsigned char *data_ptr;

        /* verify that it's an INQUIRY command */
        if (srb->cmnd[0] != INQUIRY)
                return;

        data_ptr = find_data_location(srb);

        if ((data_ptr[2] & 7) != 2) {
                US_DEBUGP("Fixing INQUIRY data to show SCSI rev 2 - was %d\n",
                          data_ptr[2] & 7);

                /* Change the SCSI revision number */
                data_ptr[2] = (data_ptr[2] & ~7) | 2;
        }

        if (data_ptr[4] == 0) {
                US_DEBUGP("Fixing INQUIRY data to show length 36 - was 0\n");
                data_ptr[4] = 36 - 5;
        }
}

Andries
