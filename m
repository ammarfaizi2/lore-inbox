Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261524AbTEKOnt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 May 2003 10:43:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261580AbTEKOnt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 May 2003 10:43:49 -0400
Received: from CPE0080c8c9b431-CM014280010574.cpe.net.cable.rogers.com ([24.43.38.154]:18693
	"EHLO stargate.coplanar.net") by vger.kernel.org with ESMTP
	id S261524AbTEKOnd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 May 2003 10:43:33 -0400
Message-ID: <005201c317cd$febb2d00$7c07a8c0@kennet.coplanar.net>
From: "Jeremy Jackson" <jerj@coplanar.net>
To: "Bartlomiej Zolnierkiewicz" <B.Zolnierkiewicz@elka.pw.edu.pl>,
       "Rusty Russell" <rusty@rustcorp.com.au>
Cc: "Alan Cox" <alan@lxorguk.ukuu.org.uk>, <linux-kernel@vger.kernel.org>
References: <Pine.SOL.4.30.0305101819540.6807-100000@mion.elka.pw.edu.pl>
Subject: Re: [PATCH] Switch ide parameters to new-style and make them unique.
Date: Sun, 11 May 2003 10:59:59 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Haven't tested, but I have a few comments.

First, I think this is a great step in the right
direction for the ide driver.

I think at some point, the kernel command line parameters should be
consolidated behind a single ata=hda,noprobe or ata=if0,io0x1f0,irq7 type
parameter, instead of the hda= and ide0=.  Taking that one step furthur, a
new syntax is needed, and having it go into 2.6 might pave the way for
removing the old cruft in 2.8?

That would seem necessary, as I see it, to remove static ide_hwifs and
eventually support better hotswap.  (But even if it doesn't it would still
clean up the ide parameters)

Regards,

Jeremy
----- Original Message -----
From: "Bartlomiej Zolnierkiewicz" <B.Zolnierkiewicz@elka.pw.edu.pl>
To: "Rusty Russell" <rusty@rustcorp.com.au>
Cc: "Alan Cox" <alan@lxorguk.ukuu.org.uk>; <linux-kernel@vger.kernel.org>
Sent: Saturday, May 10, 2003 12:25 PM
Subject: [PATCH] Switch ide parameters to new-style and make them unique.


>
> Fixes ide parameters after late_boot_params patch.
> Works for me and I would like to know if it doesn't for somebody.
> --
> Bartlomiej
>
> # Switch ide to new-style kernel parameters.
> # Make ide parameters unique.
> #
> # Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
>
>  drivers/ide/ide.c |  701
++++++++++++++++++++++++++++--------------------------
>  1 files changed, 370 insertions(+), 331 deletions(-)
>
> diff -puN drivers/ide/ide.c~late_boot_params_ide drivers/ide/ide.c
> --- linux-2.5.69/drivers/ide/ide.c~late_boot_params_ide Sat May 10
17:23:14 2003
> +++ linux-2.5.69-root/drivers/ide/ide.c Sat May 10 17:23:14 2003
> @@ -132,6 +132,7 @@
>
>  #include <linux/config.h>
>  #include <linux/module.h>
> +#include <linux/moduleparam.h>
>  #include <linux/types.h>
>  #include <linux/string.h>
>  #include <linux/kernel.h>
> @@ -239,7 +240,7 @@ static void init_hwif_data (unsigned int
>   hwif->noprobe = !hwif->io_ports[IDE_DATA_OFFSET];
>  #ifdef CONFIG_BLK_DEV_HD
>   if (hwif->io_ports[IDE_DATA_OFFSET] == HD_DATA)
> - hwif->noprobe = 1; /* may be overridden by ide_setup() */
> + hwif->noprobe = 1; /* may be overridden by ideX=noprobe */
>  #endif /* CONFIG_BLK_DEV_HD */
>   hwif->major = ide_hwif_to_major[index];
>   hwif->name[0] = 'i';
> @@ -1638,7 +1639,7 @@ static int __init stridx (const char *s,
>  }
>
>  /*
> - * match_parm() does parsing for ide_setup():
> + * match_parm() does parsing of boot/module parameters:
>   *
>   * 1. the first char of s must be '='.
>   * 2. if the remainder matches one of the supplied keywords,
> @@ -1649,52 +1650,48 @@ static int __init stridx (const char *s,
>   *     and base16 is allowed when prefixed with "0x".
>   * 4. otherwise, zero is returned.
>   */
> -static int __init match_parm (char *s, const char *keywords[], int
vals[], int max_vals)
> +static int __init match_parm (const char *s, const char *keywords[], int
vals[], int max_vals)
>  {
>   static const char *decimal = "0123456789";
>   static const char *hex = "0123456789abcdef";
>   int i, n;
>
> - if (*s++ == '=') {
> - /*
> - * Try matching against the supplied keywords,
> - * and return -(index+1) if we match one
> - */
> - if (keywords != NULL) {
> - for (i = 0; *keywords != NULL; ++i) {
> - if (!strcmp(s, *keywords++))
> - return -(i+1);
> - }
> + /*
> + * Try matching against the supplied keywords,
> + * and return -(index+1) if we match one
> + */
> + if (keywords != NULL) {
> + for (i = 0; *keywords != NULL; ++i) {
> + if (!strcmp(s, *keywords++))
> + return -(i+1);
>   }
> - /*
> - * Look for a series of no more than "max_vals"
> - * numeric values separated by commas, in base10,
> - * or base16 when prefixed with "0x".
> - * Return a count of how many were found.
> - */
> - for (n = 0; (i = stridx(decimal, *s)) >= 0;) {
> - vals[n] = i;
> - while ((i = stridx(decimal, *++s)) >= 0)
> - vals[n] = (vals[n] * 10) + i;
> - if (*s == 'x' && !vals[n]) {
> - while ((i = stridx(hex, *++s)) >= 0)
> - vals[n] = (vals[n] * 0x10) + i;
> - }
> - if (++n == max_vals)
> - break;
> - if (*s == ',' || *s == ';')
> - ++s;
> + }
> + /*
> + * Look for a series of no more than "max_vals"
> + * numeric values separated by commas, in base10,
> + * or base16 when prefixed with "0x".
> + * Return a count of how many were found.
> + */
> + for (n = 0; (i = stridx(decimal, *s)) >= 0;) {
> + vals[n] = i;
> + while ((i = stridx(decimal, *++s)) >= 0)
> + vals[n] = (vals[n] * 10) + i;
> + if (*s == 'x' && !vals[n]) {
> + while ((i = stridx(hex, *++s)) >= 0)
> + vals[n] = (vals[n] * 0x10) + i;
>   }
> - if (!*s)
> - return n;
> + if (++n == max_vals)
> + break;
> + if (*s == ',' || *s == ';')
> + ++s;
>   }
> + if (!*s)
> + return n;
>   return 0; /* zero = nothing matched */
>  }
>
>  /*
> - * ide_setup() gets called VERY EARLY during initialization,
> - * to handle kernel "command line" strings beginning with "hdx="
> - * or "ide".  Here is the complete set currently supported:
> + * Here is the complete set of currently supported boot/module
parameters:
>   *
>   * "hdx="  is recognized for all "x" from "a" to "h", such as "hdc".
>   * "idex=" is recognized for all "x" from "0" to "3", such as "ide1".
> @@ -1774,328 +1771,363 @@ static int __init match_parm (char *s, c
>   * "idex=dc4030" : probe/support Promise DC4030VL interface
>   * "ide=doubler" : probe/support IDE doublers on Amiga
>   */
> -int __init ide_setup (char *s)
> -{
> - int i, vals[3];
> - ide_hwif_t *hwif;
> - ide_drive_t *drive;
> - unsigned int hw, unit;
> - const char max_drive = 'a' + ((MAX_HWIFS * MAX_DRIVES) - 1);
> - const char max_hwif  = '0' + (MAX_HWIFS - 1);
> -
> -
> - if (strncmp(s,"hd",2) == 0 && s[2] == '=') /* hd= is for hd.c   */
> - return 0; /* driver and not us */
>
> - if (strncmp(s,"ide",3) &&
> -     strncmp(s,"idebus",6) &&
> -     strncmp(s,"hd",2)) /* hdx= & hdxlun= */
> - return 0;
> -
> - printk(KERN_INFO "ide_setup: %s", s);
> - init_ide_data ();
> +int __init ide_param_set_fn(const char *val, struct kernel_param *kp)
> +{
> + printk(KERN_INFO "IDE parameter: %s=%s", kp->name, val);
> + init_ide_data();
>
>  #ifdef CONFIG_BLK_DEV_IDEDOUBLER
> - if (!strcmp(s, "ide=doubler")) {
> + if (!strcmp(val, "doubler")) {
>   extern int ide_doubler;
>
>   printk(" : Enabled support for IDE doublers\n");
>   ide_doubler = 1;
> - return 1;
> + return 0;
>   }
>  #endif /* CONFIG_BLK_DEV_IDEDOUBLER */
>
> - if (!strcmp(s, "ide=nodma")) {
> - printk("IDE: Prevented DMA\n");
> + if (!strcmp(val, "nodma")) {
> + printk(" : Prevented DMA\n");
>   noautodma = 1;
> - return 1;
> + return 0;
>   }
>
>  #ifdef CONFIG_BLK_DEV_IDEPCI
> - if (!strcmp(s, "ide=reverse")) {
> + if (!strcmp(val, "reverse")) {
>   ide_scan_direction = 1;
>   printk(" : Enabled support for IDE inverse scan order.\n");
> - return 1;
> + return 0;
>   }
>  #endif /* CONFIG_BLK_DEV_IDEPCI */
>
> - /*
> - * Look for drive options:  "hdx="
> - */
> - if (s[0] == 'h' && s[1] == 'd' && s[2] >= 'a' && s[2] <= max_drive) {
> - const char *hd_words[] = {"none", "noprobe", "nowerr", "cdrom",
> - "serialize", "autotune", "noautotune",
> - "slow", "swapdata", "bswap", "flash",
> - "remap", "noremap", "scsi", "biostimings",
> - NULL};
> - unit = s[2] - 'a';
> - hw   = unit / MAX_DRIVES;
> - unit = unit % MAX_DRIVES;
> - hwif = &ide_hwifs[hw];
> - drive = &hwif->drives[unit];
> - if (strncmp(s + 4, "ide-", 4) == 0) {
> - strncpy(drive->driver_req, s + 4, 9);
> - goto done;
> - }
> - /*
> - * Look for last lun option:  "hdxlun="
> - */
> - if (s[3] == 'l' && s[4] == 'u' && s[5] == 'n') {
> - if (match_parm(&s[6], NULL, vals, 1) != 1)
> - goto bad_option;
> - if (vals[0] >= 0 && vals[0] <= 7) {
> - drive->last_lun = vals[0];
> - drive->forced_lun = 1;
> - } else
> - printk(" -- BAD LAST LUN! Expected value from 0 to 7");
> - goto done;
> - }
> - switch (match_parm(&s[3], hd_words, vals, 3)) {
> - case -1: /* "none" */
> - drive->nobios = 1;  /* drop into "noprobe" */
> - case -2: /* "noprobe" */
> - drive->noprobe = 1;
> - goto done;
> - case -3: /* "nowerr" */
> - drive->bad_wstat = BAD_R_STAT;
> - hwif->noprobe = 0;
> - goto done;
> - case -4: /* "cdrom" */
> - drive->present = 1;
> - drive->media = ide_cdrom;
> - hwif->noprobe = 0;
> - goto done;
> - case -5: /* "serialize" */
> - printk(" -- USE \"ide%d=serialize\" INSTEAD", hw);
> - goto do_serialize;
> - case -6: /* "autotune" */
> - drive->autotune = IDE_TUNE_AUTO;
> - goto done;
> - case -7: /* "noautotune" */
> - drive->autotune = IDE_TUNE_NOAUTO;
> - goto done;
> - case -8: /* "slow" */
> - drive->slow = 1;
> - goto done;
> - case -9: /* "swapdata" or "bswap" */
> - case -10:
> - drive->bswap = 1;
> - goto done;
> - case -11: /* "flash" */
> - drive->ata_flash = 1;
> - goto done;
> - case -12: /* "remap" */
> - drive->remap_0_to_1 = 1;
> - goto done;
> - case -13: /* "noremap" */
> - drive->remap_0_to_1 = 2;
> - goto done;
> - case -14: /* "scsi" */
> -#if defined(CONFIG_BLK_DEV_IDESCSI) && defined(CONFIG_SCSI)
> - drive->scsi = 1;
> - goto done;
> -#else
> - drive->scsi = 0;
> - goto bad_option;
> -#endif /* defined(CONFIG_BLK_DEV_IDESCSI) && defined(CONFIG_SCSI) */
> - case -15: /* "biostimings" */
> - drive->autotune = IDE_TUNE_BIOS;
> - goto done;
> - case 3: /* cyl,head,sect */
> - drive->media = ide_disk;
> - drive->cyl = drive->bios_cyl  = vals[0];
> - drive->head = drive->bios_head = vals[1];
> - drive->sect = drive->bios_sect = vals[2];
> - drive->present = 1;
> - drive->forced_geom = 1;
> - hwif->noprobe = 0;
> - goto done;
> - default:
> - goto bad_option;
> - }
> - }
> + printk(" -- BAD OPTION\n");
> + return 0;
> +}
>
> - if (s[0] != 'i' || s[1] != 'd' || s[2] != 'e')
> +int __init idebus_param_set_fn(const char *val, struct kernel_param *kp)
> +{
> + int vals[3];
> +
> + printk(KERN_INFO "IDE parameter: %s=%s", kp->name, val);
> + init_ide_data();
> +
> + if (match_parm(val, NULL, vals, 1) != 1)
>   goto bad_option;
> + if (vals[0] >= 20 && vals[0] <= 66)
> + idebus_parameter = vals[0];
> + else
> + printk(" -- BAD BUS SPEED! Expected value from 20 to 66");
> + printk("\n");
> + return 0;
> +bad_option:
> + printk(" -- BAD OPTION\n");
> + return 0;
> +}
> +
> +int __init ideX_param_set_fn(const char *val, struct kernel_param *kp)
> +{
>   /*
> - * Look for bus speed option:  "idebus="
> - */
> - if (s[3] == 'b' && s[4] == 'u' && s[5] == 's') {
> - if (match_parm(&s[6], NULL, vals, 1) != 1)
> - goto bad_option;
> - if (vals[0] >= 20 && vals[0] <= 66) {
> - idebus_parameter = vals[0];
> - } else
> - printk(" -- BAD BUS SPEED! Expected value from 20 to 66");
> - goto done;
> - }
> - /*
> - * Look for interface options:  "idex="
> + * Be VERY CAREFUL changing this: note hardcoded indexes below
> + * -8,-9,-10 : are reserved for future calls to ease the hardcoding.
>   */
> - if (s[3] >= '0' && s[3] <= max_hwif) {
> - /*
> - * Be VERY CAREFUL changing this: note hardcoded indexes below
> - * -8,-9,-10 : are reserved for future idex calls to ease the hardcoding.
> - */
> - const char *ide_words[] = {
> - "noprobe", "serialize", "autotune", "noautotune",
> + const char *ide_words[] = {
> + "noprobe", "serialize", "autotune", "noautotune",
>   "reset", "dma", "ata66", "minus8", "minus9", "minus10",
> - "four", "qd65xx", "ht6560b", "cmd640_vlb", "dtc2278",
> + "four", "qd65xx", "ht6560b", "cmd640_vlb", "dtc2278",
>   "umc8672", "ali14xx", "dc4030", "biostimings", NULL };
> - hw = s[3] - '0';
> - hwif = &ide_hwifs[hw];
> - i = match_parm(&s[4], ide_words, vals, 3);
> + ide_hwif_t *hwif;
> + unsigned int hw;
> + const char max_hwif = '0' + (MAX_HWIFS - 1);
> + int i, vals[3];
>
> - /*
> - * Cryptic check to ensure chipset not already set for hwif:
> - */
> - if (i > 0 || i <= -11) { /* is parameter a chipset name? */
> - if (hwif->chipset != ide_unknown)
> - goto bad_option; /* chipset already specified */
> - if (i <= -11 && i != -18 && hw != 0)
> - goto bad_hwif; /* chipset drivers are for "ide0=" only */
> - if (i <= -11 && i != -18 && ide_hwifs[hw+1].chipset != ide_unknown)
> - goto bad_option; /* chipset for 2nd port already specified */
> - printk("\n");
> - }
> + printk(KERN_INFO "IDE parameter: %s=%s", kp->name, val);
> + init_ide_data();
> +
> + if (kp->name[3] > max_hwif)
> + goto bad_option;
> +
> + hw = kp->name[3] - '0';
> + hwif = &ide_hwifs[hw];
> + i = match_parm(val, ide_words, vals, 3);
> +
> + /*
> + * Cryptic check to ensure chipset not already set for hwif:
> + */
> + if (i > 0 || i <= -11) { /* is parameter a chipset name? */
> + if (hwif->chipset != ide_unknown)
> + goto bad_option; /* chipset already specified */
> + if (i <= -11 && i != -18 && hw != 0)
> + goto bad_hwif; /* chipset drivers are for "ide0=" only */
> + if (i <= -11 && i != -18 && ide_hwifs[hw+1].chipset != ide_unknown)
> + goto bad_option; /* chipset for 2nd port already specified */
> + printk("\n");
> + }
>
> - switch (i) {
> - case -19: /* "biostimings" */
> - hwif->drives[0].autotune = IDE_TUNE_BIOS;
> - hwif->drives[1].autotune = IDE_TUNE_BIOS;
> - goto done;
> + switch (i) {
> + case -19: /* "biostimings" */
> + hwif->drives[0].autotune = IDE_TUNE_BIOS;
> + hwif->drives[1].autotune = IDE_TUNE_BIOS;
> + goto done;
>  #ifdef CONFIG_BLK_DEV_PDC4030
> - case -18: /* "dc4030" */
> - {
> - extern void init_pdc4030(void);
> - init_pdc4030();
> - goto done;
> - }
> + case -18: /* "dc4030" */
> + {
> + extern void init_pdc4030(void);
> + init_pdc4030();
> + goto done;
> + }
>  #endif /* CONFIG_BLK_DEV_PDC4030 */
>  #ifdef CONFIG_BLK_DEV_ALI14XX
> - case -17: /* "ali14xx" */
> - {
> - extern void init_ali14xx (void);
> - init_ali14xx();
> - goto done;
> - }
> + case -17: /* "ali14xx" */
> + {
> + extern void init_ali14xx (void);
> + init_ali14xx();
> + goto done;
> + }
>  #endif /* CONFIG_BLK_DEV_ALI14XX */
>  #ifdef CONFIG_BLK_DEV_UMC8672
> - case -16: /* "umc8672" */
> - {
> - extern void init_umc8672 (void);
> - init_umc8672();
> - goto done;
> - }
> + case -16: /* "umc8672" */
> + {
> + extern void init_umc8672 (void);
> + init_umc8672();
> + goto done;
> + }
>  #endif /* CONFIG_BLK_DEV_UMC8672 */
>  #ifdef CONFIG_BLK_DEV_DTC2278
> - case -15: /* "dtc2278" */
> - {
> - extern void init_dtc2278 (void);
> - init_dtc2278();
> - goto done;
> - }
> + case -15: /* "dtc2278" */
> + {
> + extern void init_dtc2278 (void);
> + init_dtc2278();
> + goto done;
> + }
>  #endif /* CONFIG_BLK_DEV_DTC2278 */
>  #ifdef CONFIG_BLK_DEV_CMD640
> - case -14: /* "cmd640_vlb" */
> - {
> - extern int cmd640_vlb; /* flag for cmd640.c */
> - cmd640_vlb = 1;
> - goto done;
> - }
> + case -14: /* "cmd640_vlb" */
> + {
> + extern int cmd640_vlb; /* flag for cmd640.c */
> + cmd640_vlb = 1;
> + goto done;
> + }
>  #endif /* CONFIG_BLK_DEV_CMD640 */
>  #ifdef CONFIG_BLK_DEV_HT6560B
> - case -13: /* "ht6560b" */
> - {
> - extern void init_ht6560b (void);
> - init_ht6560b();
> - goto done;
> - }
> + case -13: /* "ht6560b" */
> + {
> + extern void init_ht6560b (void);
> + init_ht6560b();
> + goto done;
> + }
>  #endif /* CONFIG_BLK_DEV_HT6560B */
>  #ifdef CONFIG_BLK_DEV_QD65XX
> - case -12: /* "qd65xx" */
> - {
> - extern void init_qd65xx (void);
> - init_qd65xx();
> - goto done;
> - }
> + case -12: /* "qd65xx" */
> + {
> + extern void init_qd65xx (void);
> + init_qd65xx();
> + goto done;
> + }
>  #endif /* CONFIG_BLK_DEV_QD65XX */
>  #ifdef CONFIG_BLK_DEV_4DRIVES
> - case -11: /* "four" drives on one set of ports */
> - {
> - ide_hwif_t *mate = &ide_hwifs[hw^1];
> - mate->drives[0].select.all ^= 0x20;
> - mate->drives[1].select.all ^= 0x20;
> - hwif->chipset = mate->chipset = ide_4drives;
> - mate->irq = hwif->irq;
> - memcpy(mate->io_ports, hwif->io_ports, sizeof(hwif->io_ports));
> - goto do_serialize;
> - }
> + case -11: /* "four" drives on one set of ports */
> + {
> + ide_hwif_t *mate = &ide_hwifs[hw^1];
> + mate->drives[0].select.all ^= 0x20;
> + mate->drives[1].select.all ^= 0x20;
> + hwif->chipset = mate->chipset = ide_4drives;
> + mate->irq = hwif->irq;
> + memcpy(mate->io_ports, hwif->io_ports, sizeof(hwif->io_ports));
> + goto do_serialize;
> + }
>  #endif /* CONFIG_BLK_DEV_4DRIVES */
> - case -10: /* minus10 */
> - case -9: /* minus9 */
> - case -8: /* minus8 */
> - goto bad_option;
> - case -7: /* ata66 */
> + case -10: /* minus10 */
> + case -9: /* minus9 */
> + case -8: /* minus8 */
> + goto bad_option;
> + case -7: /* ata66 */
>  #ifdef CONFIG_BLK_DEV_IDEPCI
> - hwif->udma_four = 1;
> - goto done;
> + hwif->udma_four = 1;
> + goto done;
>  #else /* !CONFIG_BLK_DEV_IDEPCI */
> - hwif->udma_four = 0;
> - goto bad_hwif;
> + hwif->udma_four = 0;
> + goto bad_hwif;
>  #endif /* CONFIG_BLK_DEV_IDEPCI */
> - case -6: /* dma */
> - hwif->autodma = 1;
> - goto done;
> - case -5: /* "reset" */
> - hwif->reset = 1;
> - goto done;
> - case -4: /* "noautotune" */
> - hwif->drives[0].autotune = IDE_TUNE_NOAUTO;
> - hwif->drives[1].autotune = IDE_TUNE_NOAUTO;
> - goto done;
> - case -3: /* "autotune" */
> - hwif->drives[0].autotune = IDE_TUNE_AUTO;
> - hwif->drives[1].autotune = IDE_TUNE_AUTO;
> - goto done;
> - case -2: /* "serialize" */
> - do_serialize:
> - hwif->mate = &ide_hwifs[hw^1];
> - hwif->mate->mate = hwif;
> - hwif->serialized = hwif->mate->serialized = 1;
> - goto done;
> -
> - case -1: /* "noprobe" */
> - hwif->noprobe = 1;
> - goto done;
> -
> - case 1: /* base */
> - vals[1] = vals[0] + 0x206; /* default ctl */
> - case 2: /* base,ctl */
> - vals[2] = 0; /* default irq = probe for it */
> - case 3: /* base,ctl,irq */
> - hwif->hw.irq = vals[2];
> - ide_init_hwif_ports(&hwif->hw, (unsigned long) vals[0], (unsigned long)
vals[1], &hwif->irq);
> - memcpy(hwif->io_ports, hwif->hw.io_ports, sizeof(hwif->io_ports));
> - hwif->irq      = vals[2];
> - hwif->noprobe  = 0;
> - hwif->chipset  = ide_generic;
> - goto done;
> -
> - case 0: goto bad_option;
> - default:
> - printk(" -- SUPPORT NOT CONFIGURED IN THIS KERNEL\n");
> - return 1;
> - }
> + case -6: /* dma */
> + hwif->autodma = 1;
> + goto done;
> + case -5: /* "reset" */
> + hwif->reset = 1;
> + goto done;
> + case -4: /* "noautotune" */
> + hwif->drives[0].autotune = IDE_TUNE_NOAUTO;
> + hwif->drives[1].autotune = IDE_TUNE_NOAUTO;
> + goto done;
> + case -3: /* "autotune" */
> + hwif->drives[0].autotune = IDE_TUNE_AUTO;
> + hwif->drives[1].autotune = IDE_TUNE_AUTO;
> + goto done;
> + case -2: /* "serialize" */
> + hwif->mate = &ide_hwifs[hw^1];
> + hwif->mate->mate = hwif;
> + hwif->serialized = hwif->mate->serialized = 1;
> + goto done;
> +
> + case -1: /* "noprobe" */
> + hwif->noprobe = 1;
> + goto done;
> +
> + case 1: /* base */
> + vals[1] = vals[0] + 0x206; /* default ctl */
> + case 2: /* base,ctl */
> + vals[2] = 0; /* default irq = probe for it */
> + case 3: /* base,ctl,irq */
> + hwif->hw.irq = vals[2];
> + ide_init_hwif_ports(&hwif->hw, (unsigned long) vals[0], (unsigned long)
vals[1], &hwif->irq);
> + memcpy(hwif->io_ports, hwif->hw.io_ports, sizeof(hwif->io_ports));
> + hwif->irq      = vals[2];
> + hwif->noprobe  = 0;
> + hwif->chipset  = ide_generic;
> + goto done;
> + case 0: goto bad_option;
> + default:
> + printk(" -- SUPPORT NOT CONFIGURED IN THIS KERNEL\n");
> + return 0;
>   }
>  bad_option:
>   printk(" -- BAD OPTION\n");
> - return 1;
> + return 0;
>  bad_hwif:
>   printk("-- NOT SUPPORTED ON ide%d", hw);
>  done:
>   printk("\n");
> - return 1;
> + return 0;
> +}
> +
> +int __init hdX_param_set_fn(const char *val, struct kernel_param *kp)
> +{
> + const char *hd_words[] = { "none", "noprobe", "nowerr", "cdrom",
> +    "serialize", "autotune", "noautotune",
> +    "slow", "swapdata", "bswap", "flash",
> +    "remap", "noremap", "scsi", "biostimings",
> +    NULL };
> + ide_hwif_t *hwif;
> + ide_drive_t *drive;
> + unsigned int hw, unit;
> + const char max_drive = 'a' + ((MAX_HWIFS * MAX_DRIVES) - 1);
> + int vals[3];
> +
> + printk(KERN_INFO "IDE parameter: %s=%s", kp->name, val);
> + init_ide_data();
> +
> + if (kp->name[2] > max_drive)
> + goto bad_option;
> +
> + unit = kp->name[2] - 'a';
> + hw   = unit / MAX_DRIVES;
> + unit = unit % MAX_DRIVES;
> + hwif = &ide_hwifs[hw];
> + drive = &hwif->drives[unit];
> +
> + if (!strncmp(val, "ide-", 4)) {
> + strncpy(drive->driver_req, val, 9);
> + goto done;
> + }
> +
> + switch (match_parm(val, hd_words, vals, 3)) {
> + case -1: /* "none" */
> + drive->nobios = 1;  /* drop into "noprobe" */
> + case -2: /* "noprobe" */
> + drive->noprobe = 1;
> + goto done;
> + case -3: /* "nowerr" */
> + drive->bad_wstat = BAD_R_STAT;
> + hwif->noprobe = 0;
> + goto done;
> + case -4: /* "cdrom" */
> + drive->present = 1;
> + drive->media = ide_cdrom;
> + hwif->noprobe = 0;
> + goto done;
> + case -5: /* "serialize" */
> + printk(" -- USE \"ide%d=serialize\" INSTEAD", hw);
> + hwif->mate = &ide_hwifs[hw^1];
> + hwif->mate->mate = hwif;
> + hwif->serialized = hwif->mate->serialized = 1;
> + goto done;
> + case -6: /* "autotune" */
> + drive->autotune = IDE_TUNE_AUTO;
> + goto done;
> + case -7: /* "noautotune" */
> + drive->autotune = IDE_TUNE_NOAUTO;
> + goto done;
> + case -8: /* "slow" */
> + drive->slow = 1;
> + goto done;
> + case -9: /* "swapdata" or "bswap" */
> + case -10:
> + drive->bswap = 1;
> + goto done;
> + case -11: /* "flash" */
> + drive->ata_flash = 1;
> + goto done;
> + case -12: /* "remap" */
> + drive->remap_0_to_1 = 1;
> + goto done;
> + case -13: /* "noremap" */
> + drive->remap_0_to_1 = 2;
> + goto done;
> + case -14: /* "scsi" */
> +#if defined(CONFIG_BLK_DEV_IDESCSI) && defined(CONFIG_SCSI)
> + drive->scsi = 1;
> + goto done;
> +#else
> + drive->scsi = 0;
> + goto bad_option;
> +#endif /* defined(CONFIG_BLK_DEV_IDESCSI) && defined(CONFIG_SCSI) */
> + case -15: /* "biostimings" */
> + drive->autotune = IDE_TUNE_BIOS;
> + goto done;
> + case 3: /* cyl,head,sect */
> + drive->media = ide_disk;
> + drive->cyl = drive->bios_cyl  = vals[0];
> + drive->head = drive->bios_head = vals[1];
> + drive->sect = drive->bios_sect = vals[2];
> + drive->present = 1;
> + drive->forced_geom = 1;
> + hwif->noprobe = 0;
> + goto done;
> + default:
> + goto bad_option;
> + }
> +bad_option:
> + printk(" -- BAD OPTION\n");
> + return 0;
> +done:
> + printk("\n");
> + return 0;
> +}
> +
> +int __init hdXlun_param_set_fn(const char *val, struct kernel_param *kp)
> +{
> + int vals[3];
> + ide_drive_t *drive = NULL;
> + const char max_drive = 'a' + ((MAX_HWIFS * MAX_DRIVES) - 1);
> +
> + printk(KERN_INFO "IDE parameter: %s=%s", kp->name, val);
> + init_ide_data();
> +
> + if (kp->name[2] > max_drive)
> + goto bad_option;
> +
> + if (match_parm(val, NULL, vals, 1) != 1)
> + goto bad_option;
> + if (vals[0] >= 0 && vals[0] <= 7) {
> + drive->last_lun = vals[0];
> + drive->forced_lun = 1;
> + } else
> + printk(" -- BAD LAST LUN! Expected value from 0 to 7");
> + printk("\n");
> + return 0;
> +bad_option:
> + printk(" -- BAD OPTION\n");
> + return 0;
>  }
>
>  /*
> @@ -2482,30 +2514,8 @@ int __init ide_init (void)
>  }
>
>  #ifdef MODULE
> -char *options = NULL;
> -MODULE_PARM(options,"s");
>  MODULE_LICENSE("GPL");
>
> -static void __init parse_options (char *line)
> -{
> - char *next = line;
> -
> - if (line == NULL || !*line)
> - return;
> - while ((line = next) != NULL) {
> - if ((next = strchr(line,' ')) != NULL)
> - *next++ = 0;
> - if (!ide_setup(line))
> - printk (KERN_INFO "Unknown option '%s'\n", line);
> - }
> -}
> -
> -int init_module (void)
> -{
> - parse_options(options);
> - return ide_init();
> -}
> -
>  void cleanup_module (void)
>  {
>   int index;
> @@ -2525,11 +2535,40 @@ void cleanup_module (void)
>
>   bus_unregister(&ide_bus_type);
>  }
> +#endif /* MODULE */
>
> -#else /* !MODULE */
> -
> -__setup("", ide_setup);
> +/* For 2.4 compatibility, drop "ide." prefix. */
> +#undef MODULE_PARAM_PREFIX
> +#define MODULE_PARAM_PREFIX ""
> +
> +module_param_call(ide, ide_param_set_fn, NULL, NULL, 0);
> +module_param_call(idebus, idebus_param_set_fn, NULL, NULL, 0);
> +
> +/*
> + * maximum MAX_HWIFS = 10 (also limited by number of IDE major numbers)
> + */
> +#define ideX_param(i) \
> + module_param_call(ide##i##, ideX_param_set_fn, NULL, NULL, 0)
> +ideX_param(0); ideX_param(1); ideX_param(2); ideX_param(3);
ideX_param(4);
> +ideX_param(5); ideX_param(6); ideX_param(7); ideX_param(8);
ideX_param(9);
> +
> +/*
> + * maximum drives = MAX_HWIFS * MAX_DRIVES = 20
> + */
> +#define hdX_param(c) \
> + module_param_call(hd##c##, hdX_param_set_fn, NULL, NULL, 0)
> +hdX_param(a); hdX_param(b); hdX_param(c); hdX_param(d); hdX_param(e);
> +hdX_param(f); hdX_param(g); hdX_param(h); hdX_param(i); hdX_param(j);
> +hdX_param(k); hdX_param(l); hdX_param(m); hdX_param(n); hdX_param(o);
> +hdX_param(p); hdX_param(q); hdX_param(r); hdX_param(s); hdX_param(t);
> +
> +#define hdXlun_param(c) \
> + module_param_call(hd##c##lun, hdXlun_param_set_fn, NULL, NULL, 0)
> +hdXlun_param(a); hdXlun_param(b); hdXlun_param(c); hdXlun_param(d);
> +hdXlun_param(e); hdXlun_param(f); hdXlun_param(g); hdXlun_param(h);
> +hdXlun_param(i); hdXlun_param(j); hdXlun_param(k); hdXlun_param(l);
> +hdXlun_param(m); hdXlun_param(n); hdXlun_param(o); hdXlun_param(p);
> +hdXlun_param(q); hdXlun_param(r); hdXlun_param(s); hdXlun_param(t);
>
>  module_init(ide_init);
>
> -#endif /* MODULE */
>
> _
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

