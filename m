Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129145AbQKSWpL>; Sun, 19 Nov 2000 17:45:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129183AbQKSWpC>; Sun, 19 Nov 2000 17:45:02 -0500
Received: from [210.149.136.62] ([210.149.136.62]:51073 "EHLO
	research.imasy.or.jp") by vger.kernel.org with ESMTP
	id <S129145AbQKSWoo>; Sun, 19 Nov 2000 17:44:44 -0500
Date: Mon, 20 Nov 2000 07:13:25 +0900
Message-Id: <200011192213.eAJMDPO02395@research.imasy.or.jp>
From: Taisuke Yamada <tai@imasy.or.jp>
To: karrde@callisto.yi.org
Cc: andre@linux-ide.org, linux-kernel@vger.kernel.org, tai@imasy.or.jp
Subject: Re: [PATCH] Large "clipped" IDE disk support for 2.4 when using oldBIOS
In-Reply-To: Your message of "Sun, 19 Nov 2000 18:41:29 +0200 (IST)".
    <Pine.LNX.4.21.0011191816570.857-100000@callisto.yi.org>
X-Mailer: mnews [version 1.22PL4] 2000-05/28(Sun)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > Earlier this month, I had sent in a patch to 2.2.18pre17 (with
> > IDE-patch from http://www.linux-ide.org/ applied) to add support
> > for IDE disk larger than 32GB, even if the disk required "clipping"
> > to reduce apparent disk size due to BIOS limitation.
>  
> This patch is not good. It compiles, but when I boot the kernel, it
> decides to ignore the hdc=5606,255,63 parameter that I pass to the kernel,
> and limits the number of sectors to fill 8.4GB.

Please retest with hdc=... parameter removed. If hd[a-z]=...
parameter is specified, my patch will be disabled, trusting
whatever user has specified.

Here's a example output of what you should expect if the patched
part is being executed:

  hda: host protected area => 1
  hda: checking for max native LBA...
  hda: max native LBA is 90045647
  hda: (un)clipping max LBA...
  hda: max LBA (un)clipped to 90045647
  hda: lba = 1, cap = 90045647
  hda: 90045647 sectors (46103 MB) w/2048KiB Cache, CHS=89330/16/63, UDMA(33)
  hdc: host protected area => 1
  hdc: checking for max native LBA...
  hdc: max native LBA is 90045647
  hdc: (un)clipping max LBA...
  hdc: max LBA (un)clipped to 90045647
  hdc: lba = 1, cap = 90045647
  hdc: 90045647 sectors (46103 MB) w/2048KiB Cache, CHS=89330/16/63, UDMA(33)

>  /*
>   * Compute drive->capacity, the full capacity of the drive
>   * Called with drive->id != NULL.
> + *
> + * To compute capacity, this uses either of
> + *
> + *    1. CHS value set by user       (whatever user sets will be trusted)
> + *    2. LBA value from target drive (require new ATA feature)
> + *    3. LBA value from system BIOS  (new one is OK, old one may break)
> + *    4. CHS value from system BIOS  (traditional style)
> + *
> + * in above order (i.e., if value of higher priority is available,
> + * rest of the values are ignored).
>   */

--
Taisuke Yamada <tai@imasy.or.jp>
PGP fingerprint = 6B 57 1B ED 65 4C 7D AE  57 1B 49 A7 F7 C8 23 46
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
