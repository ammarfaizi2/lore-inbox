Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314066AbSDKOAu>; Thu, 11 Apr 2002 10:00:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314067AbSDKOAt>; Thu, 11 Apr 2002 10:00:49 -0400
Received: from hera.cwi.nl ([192.16.191.8]:51904 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S314066AbSDKOAt>;
	Thu, 11 Apr 2002 10:00:49 -0400
From: Andries.Brouwer@cwi.nl
Date: Thu, 11 Apr 2002 14:00:35 GMT
Message-Id: <UTC200204111400.OAA599785.aeb@cwi.nl>
To: dwmw2@infradead.org, linux-kernel@vger.kernel.org
Subject: Flash device IDs
Cc: mdharm-usb@one-eyed-alien.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In include/linux/mtd/nand_ids.h there is some information
about device IDs and device properties of NAND flash devices.

In drivers/usb/storage/sddr09.c there is very similar information.
Probably both tables should be merged.

Various comments:

- The combination NAND_MFR_TOSHIBA, 0x79 is missing in nand_flash_ids[].
  An appropriate line might be

	{"Toshiba TH58NS100DC",   NAND_MFR_TOSHIBA, 0x79, 27, 0, 3, 0x4000},

- The type names given as first item in this struct are too precise.
  They include all kinds of stuff like voltage and temperature range, etc.
  But the device ID only give the size, page size, erase size, I think.
  So, given any card, it is quite likely that the kernel report on it
  will have incorrect type number.
  Moreover, I get the strong impression that Toshiba and Samsung use
  identical device IDs, so that one does not need to know the
  manufacturer to interpret the device ID.
  Probably we should delete the first two items from the
  struct nand_flash_dev, and have something like

static inline char *nand_flash_manufacturer(int manuf_id) {
        switch(manuf_id) {
        case NAND_MFR_TOSHIBA:
                return "Toshiba";
        case NAND_MFR_SAMSUNG:
                return "Samsung";
        default:
                return "unknown";
        }
}

  for the manufacturer.

- In sddr09.c it is suggested that the Read Device ID command
  returns two bytes. But it may return more. My source has the
  comment

/*
 * Read Device ID Command: 12 bytes.
 * byte 0: opcode: ED
 *
 * Returns 2 bytes: Manufacturer ID and Device ID.
 * On more recent cards 3 bytes: the third byte is an option code A5
 * signifying that the secret command to read an 128-bit ID is available.
 * On still more recent cards 4 bytes: the fourth byte C0 means that
 * a second read ID cmd is available.
 */

  Nobody knows anything about this secret command?


I hope to come with a patch one of these centuries.

Andries
