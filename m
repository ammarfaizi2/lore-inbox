Return-Path: <linux-kernel-owner+w=401wt.eu-S937956AbWLICJA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937956AbWLICJA (ORCPT <rfc822;w@1wt.eu>);
	Fri, 8 Dec 2006 21:09:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S938071AbWLICJA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 21:09:00 -0500
Received: from mx1.redhat.com ([66.187.233.31]:52077 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S937956AbWLICI7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 21:08:59 -0500
Message-ID: <457A1A93.5090707@redhat.com>
Date: Fri, 08 Dec 2006 21:08:19 -0500
From: =?UTF-8?B?S3Jpc3RpYW4gSMO4Z3NiZXJn?= <krh@redhat.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060803)
MIME-Version: 1.0
To: Jeff Garzik <jeff@garzik.org>
CC: linux-kernel@vger.kernel.org, Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: [PATCH 2/3] Import fw-ohci driver.
References: <20061205052229.7213.38194.stgit@dinky.boston.redhat.com> <20061205052245.7213.39098.stgit@dinky.boston.redhat.com> <45750A89.7000802@garzik.org>
In-Reply-To: <45750A89.7000802@garzik.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:

Thanks for reviewing this.  I'm updating my git repo with your changes now, 
will send an updated patch set in a few days.

>> +struct descriptor {
>> +    u32 req_count:16;
>> +
>> +    u32 wait:2;
>> +    u32 branch:2;
>> +    u32 irq:2;
>> +    u32 yy:1;
>> +    u32 ping:1;
>> +
>> +    u32 key:3;
>> +    u32 status:1;
>> +    u32 command:4;
>> +
>> +    u32 data_address;
>> +    u32 branch_address;
>> +
>> +    u32 res_count:16;
>> +    u32 transfer_status:16;
>> +} __attribute__ ((aligned(16)));
> 
> you probably want __le32 annotations for sparse, right?

Yup, I've done away with the bitfields and switched to a mix of __le16 and 
__le32 struct fields.

>> +struct it_header {
>> +    u32 sy:4;
>> +    u32 tcode:4;
>> +    u32 channel:6;
>> +    u32 tag:2;
>> +    u32 speed:3;
>> +    u32 reserved0:13;
>> +    u32 reserved1:16;
>> +    u32 data_length:16;
>> +};
> 
> ditto.
> 
> And for the last two fields, I bet that using the normal 'u16' type 
> (__le16?) would generate much better code than a bitfield:16 ever would.

Yeah, as for struct descriptor, this is now just accessed as an __le32 array.

>> +struct fw_ohci {
>> +    struct fw_card card;
>> +
>> +    struct pci_dev *dev;
> 
> struct device* instead?  grep for to_pci_dev() to see how to get pci-dev 
> from device.

Right, and I have the struct device pointer in struct fw_card so I just 
dropped this field.

>> +    char *registers;
> 
> should be 'void __iomem *'

Ok.

>> +#define FW_OHCI_MAJOR            240
>> +#define OHCI1394_REGISTER_SIZE        0x800
>> +#define OHCI_LOOP_COUNT            500
>> +#define OHCI1394_PCI_HCI_Control    0x40
>> +#define SELF_ID_BUF_SIZE        0x800
> 
> consider using
> 
>     enum {
>         constant1    = 1234,
>         constant2    = 5678,
>     };
> 
> for constants.  These actually have some type information attached by 
> the compiler, and they show up as symbols in the debugger since they are 
> not stripped out by the C pre-processor.

All those are basically one-off constants, so maybe a static const u32 would 
be better?  As for the OHCI register map, I'd like to make a struct with a 
bunch of __le32 fields.

>> +static void ar_context_run(struct ar_context *ctx)
>> +{
>> +    reg_write(ctx->ohci, ctx->command_ptr, ctx->descriptor_bus | 1);
>> +    reg_write(ctx->ohci, ctx->control_set, CONTEXT_RUN);
> 
> PCI posting?

Added here, and the other places you pointed out.

>> +static int
>> +ar_context_init(struct ar_context *ctx, struct fw_ohci *ohci, u32 
>> control_set)
>> +{
>> +    /* FIXME: cpu_to_le32. */
>> +
>> +    ctx->descriptor_bus =
>> +        dma_map_single(&ohci->dev->dev, &ctx->descriptor,
>> +                   sizeof ctx->descriptor, PCI_DMA_TODEVICE);
>> +    if (ctx->descriptor_bus == 0)
>> +        return -ENOMEM;
>> +
>> +    if (ctx->descriptor_bus & 0xf)
>> +        fw_notify("descriptor not 16-byte aligned: 0x%08x\n",
>> +              ctx->descriptor_bus);
>> +
>> +    ctx->buffer_bus =
>> +        dma_map_single(&ohci->dev->dev, ctx->buffer,
>> +                   sizeof ctx->buffer, PCI_DMA_FROMDEVICE);
>> +
>> +    if (ctx->buffer_bus == 0)
>> +        return -ENOMEM;
> 
> leak on error

Fixed.

>> +static irqreturn_t irq_handler(int irq, void *data, struct pt_regs 
>> *unused)
>> +{
>> +    struct fw_ohci *ohci = data;
>> +    u32 event, iso_event;
>> +    int i;
>> +
>> +    event = reg_read(ohci, OHCI1394_IntEventClear);
>> +
>> +    if (!event)
>> +        return IRQ_NONE;
> 
> check for 0xffffffff also

Ok.
...
>> +static int ohci_enable(struct fw_card *card, u32 * config_rom, size_t 
>> length)
>> +{
>> +    struct fw_ohci *ohci = fw_ohci(card);
>> +
>> +    /* When the link is not yet enabled, the atomic config rom
>> +     * described above is not active.  We have to update
>> +     * ConfigRomHeader and BusOptions manually, and the write to
>> +     * ConfigROMmap takes effect immediately.  We tie this to the
>> +     * enabling of the link, so we ensure that we have a valid
>> +     * config rom before enabling - the OHCI requires that
>> +     * ConfigROMhdr and BusOptions have valid values before
>> +     * enabling.
>> +     */
>> +
>> +    ohci->config_rom = pci_alloc_consistent(ohci->dev, CONFIG_ROM_SIZE,
>> +                        &ohci->config_rom_bus);
>> +    if (ohci->config_rom == NULL)
>> +        return -ENOMEM;
>> +
>> +    memset(ohci->config_rom, 0, CONFIG_ROM_SIZE);
>> +    fw_memcpy_to_be32(ohci->config_rom, config_rom, length * 4);
>> +
>> +    reg_write(ohci, OHCI1394_ConfigROMmap, ohci->config_rom_bus);
>> +    reg_write(ohci, OHCI1394_ConfigROMhdr, config_rom[0]);
>> +    reg_write(ohci, OHCI1394_BusOptions, config_rom[2]);
>> +
>> +    reg_write(ohci, OHCI1394_AsReqFilterHiSet, 0x80000000);
>> +
>> +    if (request_irq(ohci->dev->irq, irq_handler,
>> +            SA_SHIRQ, ohci_driver_name, ohci)) {
>> +        fw_error("Failed to allocate shared interrupt %d.\n",
>> +             ohci->dev->irq);
>> +        return -EIO;
> 
> leak on error

Fixed.

>> +static int
>> +ohci_set_config_rom(struct fw_card *card, u32 * config_rom, size_t 
>> length)
>> +{
>> +    struct fw_ohci *ohci;
>> +    unsigned long flags;
>> +    int retval = 0;
>> +
>> +    ohci = fw_ohci(card);
>> +
>> +    /* When the OHCI controller is enabled, the config rom update
>> +     * mechanism is a bit tricky, but easy enough to use.  See
>> +     * section 5.5.6 in the OHCI specification.
>> +     *
>> +     * The OHCI controller caches the new config rom address in a
>> +     * shadow register (ConfigROMmapNext) and needs a bus reset
>> +     * for the changes to take place.  When the bus reset is
>> +     * detected, the controller loads the new values for the
>> +     * ConfigRomHeader and BusOptions registers from the specified
>> +     * config rom and loads ConfigROMmap from the ConfigROMmapNext
>> +     * shadow register. All automatically and atomically.
>> +     *
>> +     * We use ohci->lock to avoid racing with the code that sets
>> +     * ohci->next_config_rom to NULL (see bus_reset_tasklet).
>> +     */
>> +
>> +    spin_lock_irqsave(&ohci->lock, flags);
>> +
>> +    if (ohci->next_config_rom == NULL) {
>> +        ohci->next_config_rom =
>> +            pci_alloc_consistent(ohci->dev, CONFIG_ROM_SIZE,
>> +                         &ohci->next_config_rom_bus);
>> +
>> +        memset(ohci->next_config_rom, 0, CONFIG_ROM_SIZE);
> 
> next_config_rom could be NULL.  you have got to check allocations inside 
> spinlocks (GFP_ATOMIC), they are more likely to fail than GFP_KERNEL.

Yup, fixed.  For some reason this one slipped my attention.  I moved the alloc 
outside the spinlock so I don't have to alloc GFP_ATOMC and to ease error 
handling.

>> +static int __devinit
>> +pci_probe(struct pci_dev *dev, const struct pci_device_id *ent)
>> +{
>> +    struct fw_ohci *ohci;
>> +    u32 base, bus_options, max_receive, link_speed;
>> +    u64 guid;
>> +    int error_code;
>> +    size_t size;
>> +
>> +    if (pci_enable_device(dev)) {
>> +        fw_error("Failed to enable OHCI hardware.\n");
>> +        return -ENXIO;
>> +    }
>> +
>> +    ohci = kzalloc(sizeof *ohci, SLAB_KERNEL);
> 
> GFP_KERNEL

Yup.

>> +    if (ohci == NULL) {
>> +        fw_error("Could not malloc fw_ohci data.\n");
>> +        return -ENOMEM;
>> +    }
>> +
>> +    pci_set_master(dev);
>> +    pci_write_config_dword(dev, OHCI1394_PCI_HCI_Control, 0);
>> +    pci_set_drvdata(dev, ohci);
>> +
>> +    ohci->dev = dev;
>> +    spin_lock_init(&ohci->lock);
>> +
>> +    tasklet_init(&ohci->bus_reset_tasklet,
>> +             bus_reset_tasklet, (unsigned long)ohci);
>> +
>> +    /* We hardcode the register set size, since some cards get
>> +     * this wrong and others have some extra registers after the
>> +     * OHCI range.  We only use the OHCI registers, so there's no
>> +     * need to be clever.  */
>> +    base = pci_resource_start(dev, 0);
>> +    if (!request_mem_region(base, OHCI1394_REGISTER_SIZE, 
>> ohci_driver_name)) {
> 
> ugh!  use pci_request_regions(), not request_mem_region()

Fixed.

>> +        fw_error("MMIO resource (0x%x - 0x%x) unavailable\n",
>> +             base, base + OHCI1394_REGISTER_SIZE);
>> +        return cleanup(ohci, CLEANUP_OHCI, -EBUSY);
>> +    }
>> +
>> +    ohci->registers = ioremap(base, OHCI1394_REGISTER_SIZE);
>> +    if (ohci->registers == NULL) {
>> +        fw_error("Failed to remap registers\n");
>> +        return cleanup(ohci, CLEANUP_IOMEM, -ENXIO);
>> +    }
> 
> pci_iomap() does a lot of this

Oh yeah, nice.

>> +static void pci_remove(struct pci_dev *dev)
>> +{
>> +    struct fw_ohci *ohci;
>> +
>> +    ohci = pci_get_drvdata(dev);
>> +    if (ohci == NULL)
>> +        return;
> 
> test for event that will never occur

True, that's pretty stupid.

>> +    free_irq(ohci->dev->irq, ohci);
>> +    fw_core_remove_card(&ohci->card);
>> +
>> +    /* FIXME: Fail all pending packets here, now that the upper
>> +     * layers can't queue any more. */
>> +
>> +    software_reset(ohci);
>> +    cleanup(ohci, CLEANUP_SELF_ID, 0);
>> +
>> +    fw_notify("Removed fw-ohci device.\n");
> 
> need to call pci_disable_device(), pci_release_regions()

Yup, added that.

>> +static struct pci_device_id pci_table[] = {
>> +    {
>> +        .class        = PCI_CLASS_FIREWIRE_OHCI,
>> +        .class_mask    = PCI_ANY_ID,
> 
> I'm not sure this is a proper class_mask?

Huh, yeah... looks like ~0 should work.  And I changed this to use the 
PCI_DEVICE_CLASS macro.

>> +        .vendor        = PCI_ANY_ID,
>> +        .device        = PCI_ANY_ID,
>> +        .subvendor    = PCI_ANY_ID,
>> +        .subdevice    = PCI_ANY_ID,
>> +    },
>> +    { }
>> +};
>> +
>> +MODULE_DEVICE_TABLE(pci, pci_table);
>> +
>> +static struct pci_driver fw_ohci_pci_driver = {
>> +    .name        = ohci_driver_name,
>> +    .id_table    = pci_table,
>> +    .probe        = pci_probe,
>> +    .remove        = pci_remove,
>> +};
>> +
>> +MODULE_AUTHOR("Kristian Høgsberg <krh@bitplanet.net>");
>> +MODULE_DESCRIPTION("Driver for PCI OHCI IEEE1394 controllers");
>> +MODULE_LICENSE("GPL");
>> +
>> +static int __init fw_ohci_init(void)
>> +{
>> +    if (pci_register_driver(&fw_ohci_pci_driver)) {
>> +        fw_error("Failed to register PCI driver.\n");
>> +        return -EBUSY;
>> +    }
>> +
>> +    fw_notify("Loaded fw-ohci driver.\n");
>> +
>> +    return 0;
> 
> just return pci_register_driver() return value directly, don't invent 
> your own error when pci_register_driver() already returned a 
> more-correct error code

Ok.


