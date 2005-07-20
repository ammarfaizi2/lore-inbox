Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261746AbVGTFJN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261746AbVGTFJN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Jul 2005 01:09:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261740AbVGTFJN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Jul 2005 01:09:13 -0400
Received: from mail0.lsil.com ([147.145.40.20]:3321 "EHLO mail0.lsil.com")
	by vger.kernel.org with ESMTP id S261737AbVGTFJK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Jul 2005 01:09:10 -0400
Message-ID: <001a01c58ce9$24e31e60$171015ac@ericmoore>
From: "Moore, Eric Moore" <Eric.Moore@lsil.com>
To: "Matt Domsch" <Matt_Domsch@dell.com>
Cc: "Olaf Hering" <olh@suse.de>, "Andrew Morton" <akpm@osdl.org>,
       <linux-kernel@vger.kernel.org>,
       "James Bottomley" <James.Bottomley@SteelEye.com>,
       <linux-scsi@vger.kernel.org>
References: <91888D455306F94EBD4D168954A9457C03281EB4@nacos172.co.lsil.com> <20050720031249.GA18042@humbolt.us.dell.com>
Subject: Re: [PATCH 22/82] remove linux/version.h from drivers/message/fus ion
Date: Tue, 19 Jul 2005 23:09:00 -0600
Organization: LSI Logic Corporation
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0017_01C58CB6.D950B9D0"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2180
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_0017_01C58CB6.D950B9D0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit

On Tuesday, July 19, 2005 9:12 PM, Matt Domsch wrote:
>> What you illustrated above is not going to work.
>> If your doing #ifndef around a function, such as scsi_device_online, it's
>> not going to compile
>> when scsi_device_online is already implemented in the kernel tree.
>> The routine scsi_device_online is a function, not a define.  For a define
>> this would work.
>
> Sure it does, function names are defined symbols.
>

No its not compiling for me.
I'm currently building drivers for the DELL DKMS kit.
Trying to add support for SLES9 SP2 support ( -191 kernel).
My driver compiles for SLES9 Base(-97) and SP2(-139) but fails for SP2.
Between SP1 and SP2, they added msleep.

Here is the make.log output that you will find in 
/var/lib/dkms/mptlinux/3.02.52/build
when it fails to compile.

Also attached is linux_compat.h with the changes you have suggested.





------=_NextPart_000_0017_01C58CB6.D950B9D0
Content-Type: application/octet-stream;
	name="linux_compat.h"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="linux_compat.h"

/* drivers/message/fusion/linux_compat.h */

#ifndef FUSION_LINUX_COMPAT_H
#define FUSION_LINUX_COMPAT_H

#include <linux/version.h>
#include <linux/sched.h>
#include <linux/jiffies.h>
#include <linux/delay.h>
#include <linux/module.h>
#include <scsi/scsi_device.h>
#include <scsi/scsi_cmnd.h>

/* scsi_print_command() came in lk 2.6.8 kernel,
 * prior kernels it was called print_Scsi_Cmnd()
 */
#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,8))
extern void print_Scsi_Cmnd(struct scsi_cmnd *cmd);
#else
extern void scsi_print_command(struct scsi_cmnd *cmd);
#endif
static void inline mptscsih_scsi_print_command(struct scsi_cmnd *cmd){
#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,8))
	print_Scsi_Cmnd(cmd);
#else
	scsi_print_command(cmd);
#endif
}

/* define scsi_device_online which came in lk 2.6.6,
 * to be backward compatible to older variants of lk 2.6
 */
#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,6))
static int inline scsi_device_online(struct scsi_device *sdev)
{
	return sdev->online;
}
#endif

/* define msleep, msleep_interruptible which came in lk 2.6.8
 * to be backward compatible to older variants of lk 2.6
 */
#ifndef msecs_to_jiffies
static inline unsigned long msecs_to_jiffies(const unsigned int m)
{
#if HZ <=3D 1000 && !(1000 % HZ)
        return (m + (1000 / HZ) - 1) / (1000 / HZ);
#elif HZ > 1000 && !(HZ % 1000)
        return m * (HZ / 1000);
#else
        return (m * HZ + 999) / 1000;
#endif
}
#endif

#ifndef msleep
static void inline msleep(unsigned long msecs)
{
        set_current_state(TASK_UNINTERRUPTIBLE);
        schedule_timeout(msecs_to_jiffies(msecs) + 1);
}
#endif
#ifndef msleep_interruptible
static void inline msleep_interruptible(unsigned long msecs)
{
        set_current_state(TASK_INTERRUPTIBLE);
        schedule_timeout(msecs_to_jiffies(msecs) + 1);
}
#endif

/* define __iomem which came in lk 2.6.9
 * to be backward compatible to older variants of lk 2.6
 */
#ifndef __iomem
#define __iomem
#endif

/* define pm_message_t which came in lk 2.6.11
 * to be backward compatible to older variants of lk 2.6
 */
#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,11))
typedef u32 pm_message_t;
#endif

/* exporting of pci_disable_msi which came in lk 2.6.8
 * to be backward compatible to older variants of lk 2.6
 */
#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,8))
static inline void pci_disable_msi(struct pci_dev* dev) {}
#endif

/* defines for SAS controlers, to be eventually added to =
inlcude/linux/pci_ids.h
 */
#ifndef PCI_DEVICE_ID_LSI_SAS1064
#define PCI_DEVICE_ID_LSI_SAS1064	(0x0050)
#endif

#ifndef PCI_DEVICE_ID_LSI_SAS1066
#define PCI_DEVICE_ID_LSI_SAS1066	(0x005E)
#endif

#ifndef PCI_DEVICE_ID_LSI_SAS1068
#define PCI_DEVICE_ID_LSI_SAS1068	(0x0054)
#endif

#ifndef PCI_DEVICE_ID_LSI_SAS1064A
#define PCI_DEVICE_ID_LSI_SAS1064A	(0x005C)
#endif

#ifndef PCI_DEVICE_ID_LSI_SAS1064E
#define PCI_DEVICE_ID_LSI_SAS1064E	(0x0056)
#endif

#ifndef PCI_DEVICE_ID_LSI_SAS1066E
#define PCI_DEVICE_ID_LSI_SAS1066E	(0x005A)
#endif

#ifndef PCI_DEVICE_ID_LSI_SAS1068E
#define PCI_DEVICE_ID_LSI_SAS1068E	(0x0058)
#endif

#ifndef PCI_DEVICE_ID_LSI_FC939X
#define PCI_DEVICE_ID_LSI_FC939X	(0x0642)
#endif

#ifndef PCI_DEVICE_ID_LSI_FC949X
#define PCI_DEVICE_ID_LSI_FC949X	(0x0640)
#endif

/*}-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D=
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=
=3D*/
#endif /* _LINUX_COMPAT_H */

------=_NextPart_000_0017_01C58CB6.D950B9D0
Content-Type: application/octet-stream;
	name="make.log"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="make.log"

DKMS make.log for mptlinux-3.02.52 for kernel 2.6.5-7.191-smp (i586)
Tue Jul 19 22:42:47 MDT 2005
make: Entering directory `/usr/src/linux-2.6.5-7.191-obj/i386/smp'
make -C /usr/src/linux-2.6.5-7.191 =
O=3D/usr/src/linux-2.6.5-7.191-obj/i386/smp modules

WARNING: Symbol version dump =
/usr/src/linux-2.6.5-7.191-obj/i386/smp/Module.symvers is  missing, =
modules will have CONFIG_MODVERSIONS disabled.

  CC [M]  /var/lib/dkms/mptlinux/3.02.52/build/mptbase.o
In file included from /var/lib/dkms/mptlinux/3.02.52/build/mptbase.h:58,
                 from /var/lib/dkms/mptlinux/3.02.52/build/mptbase.c:71:
/var/lib/dkms/mptlinux/3.02.52/build/linux_compat.h:45: error: =
redefinition of `msecs_to_jiffies'
/usr/src/linux-2.6.5-7.191/include/linux/jiffies.h:96: error: =
`msecs_to_jiffies' previously defined here
/var/lib/dkms/mptlinux/3.02.52/build/linux_compat.h:58: error: =
conflicting types for `msleep'
/usr/src/linux-2.6.5-7.191/include/linux/delay.h:41: error: previous =
declaration of `msleep'
/var/lib/dkms/mptlinux/3.02.52/build/linux_compat.h:65: error: =
conflicting types for `msleep_interruptible'
/usr/src/linux-2.6.5-7.191/include/linux/delay.h:42: error: previous =
declaration of `msleep_interruptible'
make[3]: *** [/var/lib/dkms/mptlinux/3.02.52/build/mptbase.o] Error 1
make[2]: *** [_module_/var/lib/dkms/mptlinux/3.02.52/build] Error 2
make[1]: *** [modules] Error 2
make: *** [modules] Error 2
make: Leaving directory `/usr/src/linux-2.6.5-7.191-obj/i386/smp'

------=_NextPart_000_0017_01C58CB6.D950B9D0--


