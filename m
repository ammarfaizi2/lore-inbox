Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132702AbRAHVpc>; Mon, 8 Jan 2001 16:45:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133117AbRAHVpO>; Mon, 8 Jan 2001 16:45:14 -0500
Received: from mta5.snfc21.pbi.net ([206.13.28.241]:56271 "EHLO
	mta5.snfc21.pbi.net") by vger.kernel.org with ESMTP
	id <S132702AbRAHVoy>; Mon, 8 Jan 2001 16:44:54 -0500
Date: Mon, 08 Jan 2001 13:41:36 -0800
From: David Brownell <david-b@pacbell.net>
Subject: Announce: updated USB hotplug support
To: linux-kernel@vger.kernel.org
Cc: linux-hotplug-devel@lists.sourceforge.net,
        linux-usb-devel@lists.sourceforge.net
Message-id: <03d001c079bb$ccf000a0$6600000a@brownell.org>
MIME-version: 1.0
X-Mailer: Microsoft Outlook Express 5.00.2314.1300
Content-type: multipart/mixed;
 boundary="----=_NextPart_000_03C7_01C07978.B86A8940"
X-MSMail-Priority: Normal
X-MIMEOLE: Produced By Microsoft MimeOLE V5.00.2314.1300
In-Reply-To: <4094.978969148@ocs3.ocs-net>
X-Priority: 3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_03C7_01C07978.B86A8940
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

Matching Keith's modutils update, here's a a package of
hotplug scripts ... not yet as neatly packaged!  And
also, not (yet) handling with the older file format for
the "modules.usbmap" files associated with 2.4.0 test (and
prerelease) kernels.  It "ought" to behave with the usb
hotplug support in 2.2.18 kernels.

Extract into /etc/hotplug, and see the README.  There's
a network hotplug agent but no PCI/Cardbus agent.

Followups to linux-hotplug-devel please.

- Dave


> From: Keith Owens <kaos@ocs.com.au>
> To: <linux-kernel@vger.kernel.org>
> Cc: <linux-hotplug-devel@lists.sourceforge.net>;
<linux-usb-devel@lists.sourceforge.net>
> Sent: Monday, January 08, 2001 7:52 AM
> Subject: Announce: modutils 2.4.1 is available
>
> In the absence of any screams of pain from the usb list, modutils 2.4.1
> is released for your enjoyment.
>
> ftp://ftp.<country>.kernel.org/pub/linux/utils/kernel/modutils/v2.4
>
> modutils-2.4.1.tar.gz           Source tarball, includes RPM spec file
> modutils-2.4.1-1.src.rpm        As above, in SRPM format
> modutils-2.4.1-1.i386.rpm       Compiled with egcs-2.91.66, glibc 2.1.2
> modutils-2.4.1-1.sparc.rpm      Compiled for combined sparc 32/64
> patch-modutils-2.4.1.gz Patch from modutils 2.4.0 to 2.4.1.
>
> Related kernel patches.
>
> patch-2.4.0-hotplug.gz          Correctly handle USB modules in kernel 2.4.0.
> The fix adds a version number to tables read by
> depmod, this affects all kernel hotplug tables,
> not just USB.  Required for USB on 2.4.0.
>
> patch-2.4.0-persistent.gz Adds persistent data and generic string
> support to kernel 2.4.0.  Optional.
>
> Changelog extract
>
> * Cast 2*sizeof to int in printf, new gcc warns about this.
> * Add an optional version number to kernel tables.
> * Handle version 1 and 2 usb device tables.
> * man lsmod documents use count -1.
>
> NOTE:
>
>   Handling the change of format for the USB tables highlighted the need
> for the kernel to include a version number against each table to tell
> depmod which format table it is processing.  Checking for a change in
> table size was not enough.  You _must_ apply patch-2.4.0-hotplug to
> 2.4.0 kernels in order to pick up the new USB table format. You will
> also need a new set of USB utilities that understand match_flags.
>
>   patch-2.4.0-hotplug hits all hotplug tables, not just USB.  The
> kernel and modutils changes are forward and backward compatible; old
> kernels will run with new modutils and vice versa.  The only
> combination not supported is USB hotplugging in an unpatched kernel
> 2.4.0, there is no way for any version of modutils to detect which
> format USB table is being used in unpatched 2.4.0 kernels.
>
> patch-2.4.0-hotplug follows for reference, it is also in the URL at the
> top of this mail.  With any luck this patch will be included in kernel
> 2.4.1.
>
> Index: 0.1/include/linux/usb.h
> - --- 0.1/include/linux/usb.h Fri, 05 Jan 2001 13:42:29 +1100 kaos
(linux-2.4/Z/38_usb.h 1.1 644)
> +++ 0.1(w)/include/linux/usb.h Sun, 07 Jan 2001 22:36:31 +1100 kaos
(linux-2.4/Z/38_usb.h 1.1 644)
> @@ -344,12 +344,18 @@ struct usb_device;
>  #define USB_INTERFACE_INFO(cl,sc,pr) \
>   match_flags: USB_DEVICE_ID_MATCH_INT_INFO, bInterfaceClass: (cl),
bInterfaceSubClass: (sc), bInterfaceProtocol: (pr)
>
> - -struct usb_device_id {
> - - /* This bitmask is used to determine which of the following fields
> - - * are to be used for matching.
> - - */
> - - __u16 match_flags;
> +/* match_flags added in 2.4.0 but at the start which messed up depmod.
> + * match_flags moved to before driver_info in 2.4.1 by KAO, you also need
> + * modutils 2.4.1.  USB modules cannot be supported in kernel 2.4.0,
> + * insufficient data to detect which table format is being used.
> + *
> + * Do NOT change this table format without checking with the modutils
> + * maintainer.  This is an ABI visible structure.
> + */
> +
> +#define usb_device_id_ver 2 /* Version 2 table */
>
> +struct usb_device_id {
>   /*
>   * vendor/product codes are checked, if vendor is nonzero
>   * Range is for device revision (bcdDevice), inclusive;
> @@ -374,6 +380,11 @@ struct usb_device_id {
>   __u8 bInterfaceClass;
>   __u8 bInterfaceSubClass;
>   __u8 bInterfaceProtocol;
> +
> + /* This bitmask is used to determine which of the preceding fields
> + * are to be used for matching.
> + */
> + __u16 match_flags; /* New in version 2 */
>
>   /*
>   * for driver's use; not involved in driver matching.
> Index: 0.1/include/linux/isapnp.h
> - --- 0.1/include/linux/isapnp.h Fri, 05 Jan 2001 13:42:29 +1100 kaos
(linux-2.4/b/b/11_isapnp.h 1.1 644)
> +++ 0.1(w)/include/linux/isapnp.h Sun, 07 Jan 2001 22:36:40 +1100 kaos
(linux-2.4/b/b/11_isapnp.h 1.1 644)
> @@ -142,6 +142,16 @@ struct isapnp_resources {
>  #define ISAPNP_CARD_TABLE(name) \
>   MODULE_GENERIC_TABLE(isapnp_card, name)
>
> +/* Do NOT change the format of struct isapnp_card_id, struct isapnp_device_id or
> + * the value of ISAPNP_CARD_DEVS without checking with the modutils maintainer.
> + * These are ABI visible structures and defines.
> + *
> + * isapnp_device_id_ver is a single version number for the combination of
> + * struct isapnp_card_id and struct isapnp_device_id.
> + */
> +
> +#define isapnp_device_id_ver 1 /* Version 1 tables */
> +
>  struct isapnp_card_id {
>   unsigned long driver_data; /* data private to the driver */
>   unsigned short card_vendor, card_device;
> Index: 0.1/include/linux/module.h
> - --- 0.1/include/linux/module.h Fri, 05 Jan 2001 13:42:29 +1100 kaos
(linux-2.4/c/b/46_module.h 1.1 644)
> +++ 0.1(w)/include/linux/module.h Sun, 07 Jan 2001 22:07:49 +1100 kaos
(linux-2.4/c/b/46_module.h 1.1 644)
> @@ -242,19 +242,17 @@ __attribute__((section(".modinfo"))) =
>   * isapnp - struct isapnp_device_id - List of ISA PnP ids supported by this module
>   * usb - struct usb_device_id - List of USB ids supported by this module
>   */
> - -#define MODULE_GENERIC_TABLE(gtype,name) \
> - -static const unsigned long __module_##gtype##_size \
> - -  __attribute__ ((unused)) = sizeof(struct gtype##_id); \
> - -static const struct gtype##_id * __module_##gtype##_table \
> - -  __attribute__ ((unused)) = name
> - -#define MODULE_DEVICE_TABLE(type,name) \
> - -  MODULE_GENERIC_TABLE(type##_device,name)
> - -/* not put to .modinfo section to avoid section type conflicts */
>
> - -/* The attributes of a section are set the first time the section is
> - -   seen; we want .modinfo to not be allocated.  */
> +#define MODULE_GENERIC_TABLE(gtype,name) \
> +static const unsigned long __module_##gtype##_size \
> +  __attribute__ ((unused)) = sizeof(struct gtype##_id); \
> +static const unsigned long __module_##gtype##_ver \
> +  __attribute__ ((unused)) = gtype##_id_ver; \
> +static const struct gtype##_id * __module_##gtype##_table \
> +  __attribute__ ((unused)) = name
>
> - -__asm__(".section .modinfo\n\t.previous");
> +#define MODULE_DEVICE_TABLE(type,name) \
> +  MODULE_GENERIC_TABLE(type##_device,name)
>
>  /* Define the module variable, and usage macros.  */
>  extern struct module __this_module;
> Index: 0.1/include/linux/pci.h
> - --- 0.1/include/linux/pci.h Fri, 05 Jan 2001 13:42:29 +1100 kaos
(linux-2.4/f/b/12_pci.h 1.1 644)
> +++ 0.1(w)/include/linux/pci.h Sun, 07 Jan 2001 22:36:09 +1100 kaos
(linux-2.4/f/b/12_pci.h 1.1 644)
> @@ -439,6 +439,12 @@ struct pbus_set_ranges_data
>   unsigned long mem_start, mem_end;
>  };
>
> +/* Do NOT change this table format without checking with the modutils
> + * maintainer.  This is an ABI visible structure.
> + */
> +
> +#define pci_device_id_ver 1 /* Version 1 table */
> +
>  struct pci_device_id {
>   unsigned int vendor, device; /* Vendor and device ID or PCI_ANY_ID */
>   unsigned int subvendor, subdevice; /* Subsystem ID's or PCI_ANY_ID */
> Index: 0.1/Documentation/Changes
> - --- 0.1/Documentation/Changes Fri, 05 Jan 2001 13:42:29 +1100 kaos
(linux-2.4/Z/c/26_Changes 1.1 644)
> +++ 0.4(w)/Documentation/Changes Tue, 09 Jan 2001 02:43:44 +1100 kaos
(linux-2.4/Z/c/26_Changes 1.1 644)
> @@ -52,7 +52,7 @@ o  Gnu C                  2.91.66
>  o  Gnu make               3.77                    # make --version
>  o  binutils               2.9.1.0.25              # ld -v
>  o  util-linux             2.10o                   # fdformat --version
> - -o  modutils               2.4.0                   # insmod -V
> +o  modutils               2.4.1                   # insmod -V
>  o  e2fsprogs              1.19                    # tune2fs --version
>  o  pcmcia-cs              3.1.21                  # cardmgr -V
>  o  PPP                    2.4.0                   # pppd --version
>


------=_NextPart_000_03C7_01C07978.B86A8940
Content-Type: application/x-gzip;
	name="hotplug-8-Jan-2001.tar.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="hotplug-8-Jan-2001.tar.gz"

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
8AAA

------=_NextPart_000_03C7_01C07978.B86A8940--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
