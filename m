Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131651AbQKWKui>; Thu, 23 Nov 2000 05:50:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131809AbQKWKu2>; Thu, 23 Nov 2000 05:50:28 -0500
Received: from [209.249.10.20] ([209.249.10.20]:27596 "EHLO
        freya.yggdrasil.com") by vger.kernel.org with ESMTP
        id <S131723AbQKWKuO>; Thu, 23 Nov 2000 05:50:14 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Thu, 23 Nov 2000 02:20:13 -0800
Message-Id: <200011231020.CAA00606@adam.yggdrasil.com>
To: jgarzik@mandrakesoft.com, kaos@ocs.com.au
Subject: Re: Patch(?): pci_device_id tables for drivers/scsi in 2.4.0-test11
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Keith Owens wrote:
>> 
>> [Adam J. Richter]
>> > +static struct pci_device_id atp870u_pci_tbl[] __initdata = {
>> > +{vendor: 0x1191, device: 0x8002, subvendor: PCI_ANY_ID, subdevice: PCI_ANY_ID},
>> > +{vendor: 0x1191, device: 0x8010, subvendor: PCI_ANY_ID, subdevice: PCI_ANY_ID},
>> 
>> It would make it easier to read and safer to type if you used a macro
>> to generate the fields.
>> 
>> #define PCITBL(v,d,sv,sd) \
>>  { PCI_VENDOR_ID_##v, PCI_DEVICE_ID_##d, \
>>    PCI_VENDOR_ID_##sv, PCI_DEVICE_ID_##sd }
>> 
>> #define PCITBL_END {0,0,0,0}
>> 
>> static struct pci_device_id foo_pci_tbl[] __initdata = {
>>   PCITBL(INTEL, INTEL_82437VX, ANY, ANY),
>>   PCITBL_END
>> }

>* your macro fails for the 'ANY' case, because the proper macro is
>PCI_ANY_ID not PCI_{VENDOR,DEVICE}_ID_ANY.
>* many drivers need to set the driver_data field

>That said, the general idea presented above is quite good.  The PCITBL
>macro will probably change on a per-driver basis... I don't think it
>belongs in a common header.  For example, ethernet drivers might want to
>have a macro that always checks for PCI-CLASS-ETHERNET under the hood,
>while visibly looking like

>PCITBL(INTEL, 82437VX, {a driver_data value}),
>PCITBL(INTEL, 82987VX, {another driver_data value}),
>PCITBL_END

>	Jeff


Jaroslav Kysela's isapnp MODULE_DEVICE_TABLE support uses a
a similar scheme (see Documentation/isapnp.txt and
include/linux/isapnp.h).  I also used similar macros to add
support usb MODULE_DEVICE_TABLE support for usb/storage/
(not yet in 2.4.0-test11 yet) and usb/pegasus.c.

Note that, in all of these cases, the macros expand to field:value
form, which addresses my concerns about modifiability.

The cases where I implemented this sort of thing in the USB code
were where there was a big tables of values that included device
ID information plus more information than could comfortably fit in
in id->driver_data.  Using a trick used in the gcc sources, I changed
the table entries into a calls to a macro and moved them into a
separate .h file, which was included multiple times with different
definitions of the macro to construct the usb_device_id table and a
parallel table of additional driver specific data.  There are a bunch
of cases in the code that I have been adding pci_device_id tables
to where an approach like this will probably end up being used
when somebody gets around to eliminating the duplication of data
between the pci_device_id table and the "old" way the driver
organized the PCI ID information.

In the specific case of the current drivers/scsi/atp870u.c, 
I think a macro would not help yet becuase the pci entries
still fit on one line without the macro.  So, it would just
make the code longer and perhaps less clear.  However, when the
devid[] array in that driver is eliminated and perhaps the
driver is ported to the new PCI interface, then the
vendor_data field will probably be used and it will probably be
worthwhile to define a macro as you describe (at least that's
my prediction; I don't claim to be the maintainer of any of these
drivers).

Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
