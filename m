Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263558AbUDFArw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 20:47:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263564AbUDFArw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 20:47:52 -0400
Received: from smtp-roam.Stanford.EDU ([171.64.10.152]:21923 "EHLO
	smtp-roam.Stanford.EDU") by vger.kernel.org with ESMTP
	id S263558AbUDFArF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 20:47:05 -0400
Message-Id: <5.2.1.1.2.20040405173352.01be94b8@kash.pobox.stanford.edu>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.1
Date: Mon, 05 Apr 2004 17:45:12 -0700
To: linux-kernel@vger.kernel.org, cananian@alumni.princeton.edu, kanoj@sgi.com,
       rbultje@ronald.bitfreak.net, laurent.pinchart@skynet.be,
       ranty@debian.org, linuxusb@kobil.de, bcollins@debian.org,
       weihs@ict.tuwien.ac.at, support@qlogic.com, arjanv@redhat.com
From: Ken Ashcraft <kash@stanford.edu>
Subject: [CHECKER] 21 probable missing bounds checks
Cc: mc@cs.stanford.edu
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an update from a similar post on March 27, 2004.  If you are a 
direct recipient of this email, it means that I believe that you are the 
maintainer for a file containing one of the errors below.  I couldn't find 
maintainers for all of the files, so please forward this message if you 
know of someone who would care about any of the errors below.

#  Total                                  = 21
# BUGs  |       File Name
3       |       /drivers/sbp2.c
2       |       /mtd/ich2rom.c
2       |       /mtd/pci.c
2       |       /drivers/firmware_class.c
2       |       /linux-2.6.3/binfmt_misc.c
2       |       /mtd/map_funcs.c
1       |       /scsi/qla_os.c
1       |       /drivers/mem.c
1       |       /drivers/csr.c
1       |       /drivers/msi.c
1       |       /usb/kobil_sct.c
1       |       /i386/i8259.c
1       |       /media/zoran_procfs.c
1       |       /cpu/centaur.c

I found these errors by comparing implementations of the same 
interface.  If functions are assigned to the same function pointer (same 
field of some struct), I assume that the functions are called from the same 
context.  Therefore, they should treat their incoming parameters 
similarly.  In this case, before using scalar parameters as array indices, 
the functions should either all perform bounds checks on those scalars or 
none should perform bounds checks.  Any contradiction is an error.

There are 23 reports below.  Each report contains first a reference to an 
EXAMPLE or a place where the parameter is checked.  That reference is 
followed by a COUNTER(example) or a place where the parameter is not 
checked.  After that is a code snippet from the counter example.  The type 
of the function pointer (struct foo.bar) can be found in the COUNTER field: 
[COUNTER=struct foo.bar-param_num].

I was unsure about the validity of the errors where the function pointer is 
struct map_info.copy_to/from.  The examples did not do a straightforward 
bounds check.

Your feedback is appreciated!

Thanks,
Ken Ashcraft


---------------------------------------------------------
[BUG] our favorite overflow for kmalloc
/home/kash/interface/linux-2.6.3/arch/i386/kernel/microcode.c:430:microcode_write: 
NOTE:BOUND: Checking arg len [EXAMPLE=file_operations.write-2]
/home/kash/interface/linux-2.6.3/drivers/char/mem.c:605:kmsg_write: 
ERROR:BOUND: Not checking arg count [COUNTER=file_operations.write-2] 
[fit=1] [fit_fn=1] [fn_ex=0] [fn_counter=1] [ex=44] [counter=1] [z = 
0.854981960070962] [fn-z = -4.35889894354067]

         tmp = kmalloc(count + 1, GFP_KERNEL);
         if (tmp == NULL)
                 return -ENOMEM;
         ret = -EFAULT;

Error --->
         if (!copy_from_user(tmp, buf, count)) {
                 tmp[count] = 0;
                 ret = printk("%s", tmp);
         }
---------------------------------------------------------
[BUG]  vmalloc(count + 1) can overflow
/home/kash/interface/linux-2.6.3/drivers/acpi/battery.c:591:acpi_battery_write_alarm: 
NOTE:BOUND: Checking arg count [EXAMPLE=proc_dir_entry.write_proc-2]
/home/kash/interface/linux-2.6.3/drivers/media/video/zoran_procfs.c:217:zoran_write_proc: 
ERROR:BOUND: Not checking arg count [COUNTER=proc_dir_entry.write_proc-2] 
[fit=2] [fit_fn=1] [fn_ex=0] [fn_counter=1] [ex=13] [counter=1] [z = 
-0.367883603690978] [fn-z = -4.35889894354067]
                         KERN_ERR
                         "%s: write_proc: can not allocate memory\n",
                         ZR_DEVNAME(zr));
                 return -ENOMEM;
         }

Error --->
         if (copy_from_user(string, buffer, count)) {
                 vfree (string);
                 return -EFAULT;
         }
---------------------------------------------------------
[BUG] overflow
/home/kash/interface/linux-2.6.3/arch/i386/kernel/apm.c:1447:do_read: 
NOTE:BOUND: Checking arg count [EXAMPLE=file_operations.read-2]
/home/kash/interface/linux-2.6.3/fs/binfmt_misc.c:570:bm_status_read: 
ERROR:BOUND: Not checking arg nbytes [COUNTER=file_operations.read-2] 
[fit=3] [fit_fn=2] [fn_ex=0] [fn_counter=1] [ex=40] [counter=3] [z = 
-0.59475471426012] [fn-z = -4.35889894354067]
                 return -EINVAL;
         if (pos >= len)
                 return 0;
         if (len < pos + nbytes)
                 nbytes = len - pos;

Error --->
         if (copy_to_user(buf, s + pos, nbytes))
                 return -EFAULT;
         *ppos = pos + nbytes;
         return nbytes;
---------------------------------------------------------
[BUG] overflow
/home/kash/interface/linux-2.6.3/arch/i386/kernel/apm.c:1447:do_read: 
NOTE:BOUND: Checking arg count [EXAMPLE=file_operations.read-2]
/home/kash/interface/linux-2.6.3/fs/binfmt_misc.c:449:bm_entry_read: 
ERROR:BOUND: Not checking arg nbytes [COUNTER=file_operations.read-2] 
[fit=3] [fit_fn=3] [fn_ex=0] [fn_counter=1] [ex=40] [counter=3] [z = 
-0.59475471426012] [fn-z = -4.35889894354067]
         if (pos >= len)
                 goto out;
         if (len < pos + nbytes)
                 nbytes = len - pos;
         res = -EFAULT;

Error --->
         if (copy_to_user(buf, page + pos, nbytes))
                 goto out;
         *ppos = pos + nbytes;
         res = nbytes;
---------------------------------------------------------
[BUG] example is questionable: 
/home/kash/interface/linux-2.6.3/arch/i386/kernel/cpu/mtrr/cyrix.c:39:cyrix_get\_arr:
/home/kash/interface/linux-2.6.3/arch/i386/kernel/cpu/mtrr/amd.c:16:amd_get_mtrr: 
NOTE:BOUND: Checking arg reg [EXAMPLE=mtrr_ops.get-0]
/home/kash/interface/linux-2.6.3/arch/i386/kernel/cpu/mtrr/centaur.c:54:centaur_get_mcr: 
ERROR:BOUND: Not checking arg reg [COUNTER=mtrr_ops.get-0] [fit=4] 
[fit_fn=1] [fn_ex=0] [fn_counter=1] [ex=3] [counter=1] [z = 
-1.83532587096449] [fn-z = -4.35889894354067]

static void
centaur_get_mcr(unsigned int reg, unsigned long *base,
                 unsigned int *size, mtrr_type * type)
{

Error --->
         *base = centaur_mcr[reg].high >> PAGE_SHIFT;
         *size = -(centaur_mcr[reg].low & 0xfffff000) >> PAGE_SHIFT;
         *type = MTRR_TYPE_WRCOMB;       /*  If it is there, it is 
write-combining  */
         if (centaur_mcr_type == 1 && ((centaur_mcr[reg].low & 31) & 2))
---------------------------------------------------------
[BUG]
/home/kash/interface/linux-2.6.3/arch/i386/kernel/io_apic.c:1935:end_level_ioapic_vector: 
NOTE:BOUND: Checking arg vector [EXAMPLE=hw_interrupt_type.end-0]
/home/kash/interface/linux-2.6.3/arch/i386/kernel/i8259.c:44:end_8259A_irq: 
ERROR:BOUND: Not checking arg irq [COUNTER=hw_interrupt_type.end-0] [fit=9] 
[fit_fn=1] [fn_ex=0] [fn_counter=1] [ex=1] [counter=1] [z = 
-2.91998558035372] [fn-z = -4.35889894354067]

spinlock_t i8259A_lock = SPIN_LOCK_UNLOCKED;

static void end_8259A_irq (unsigned int irq)
{

Error --->
         if (!(irq_desc[irq].status & (IRQ_DISABLED|IRQ_INPROGRESS)) &&
                                                         irq_desc[irq].action)
                 enable_8259A_irq(irq);
}
---------------------------------------------------------
[BUG]
/home/kash/interface/linux-2.6.3/arch/i386/kernel/io_apic.c:1957:set_ioapic_affinity_vector: 
NOTE:BOUND: Checking arg vector [EXAMPLE=hw_interrupt_type.set_affinity-0]
/home/kash/interface/linux-2.6.3/drivers/pci/msi.c:97:set_msi_affinity: 
ERROR:BOUND: Not checking arg vector 
[COUNTER=hw_interrupt_type.set_affinity-0] [fit=7]
[fit_fn=1] [fn_ex=0] [fn_counter=1] [ex=1] [counter=1] [z = 
-2.91998558035372] [fn-z = -4.35889894354067]
{
         struct msi_desc *entry;
         struct msg_address address;
         unsigned int dest_id;


Error --->
         entry = (struct msi_desc *)msi_desc[vector];
         if (!entry || !entry->dev)
                 return;

---------------------------------------------------------
[BUG] maybe
/home/kash/interface/linux-2.6.3/drivers/scsi/qla2xxx/qla_os.c:587:qla2x00_sysfs_write_nvram: 
NOTE:BOUND: Checking arg count [EXAMPLE=bin_attribute.write-3]
/home/kash/interface/linux-2.6.3/drivers/base/firmware_class.c:201:firmware_data_write: 
ERROR:BOUND: Not checking arg count [COUNTER=bin_attribute.write-3] [fit=8] 
[fit_fn=1] [fn_ex=0] [fn_counter=1] [ex=1] [counter=1] [z = 
-2.91998558035372] [fn-z = -4.35889894354067]

         retval = fw_realloc_buffer(fw_priv, offset + count);
         if (retval)
                 return retval;


Error --->
         memcpy(fw->data + offset, buffer, count);

         fw->size = max_t(size_t, offset + count, fw->size);

---------------------------------------------------------
[BUG] need lower bound
/home/kash/interface/linux-2.6.3/drivers/usb/serial/cyberjack.c:235:cyberjack_write: 
NOTE:BOUND: Checking arg count [EXAMPLE=usb_serial_device_type.write-3]
/home/kash/interface/linux-2.6.3/drivers/usb/serial/kobil_sct.c:444:kobil_write: 
ERROR:BOUND: Not checking arg count 
[COUNTER=usb_serial_device_type.write-3] [fit=10] [fit_fn=1] [fn_ex=0] 
[fn_counter=1] [ex=3] [counter=2] [z = -3.59092423229804] [fn-z = 
-4.35889894354067]
                 return -ENOMEM;
         }

         // Copy data to buffer
         if (from_user) {

Error --->
                 if (copy_from_user(priv->buf + priv->filled, buf, count)) {
                         return -EFAULT;
                 }
         } else {
---------------------------------------------------------
[BUG]
/home/kash/interface/linux-2.6.3/drivers/mtd/maps/elan-104nc.c:185:elan_104nc_copy_to: 
NOTE:BOUND: Checking arg len [EXAMPLE=map_info.copy_to-3]
/home/kash/interface/linux-2.6.3/drivers/mtd/maps/ich2rom.c:90:ich2rom_copy_to:
ERROR:BOUND: Not checking arg len [COUNTER=map_info.copy_to-3] [fit=13] 
[fit_fn=3] [fn_ex=0] [fn_counter=1] [ex=4] [counter=3] [z = 
-4.59568283847783] [fn-z = -4.35889894354067]
         mb();
}

static void ich2rom_copy_to(struct map_info *map, unsigned long to, const 
void *from, ssize_t len)
{

Error --->
         memcpy_toio(addr(map, to), from, len);
}

static struct ich2rom_map_info ich2rom_map = {
---------------------------------------------------------
[BUG]
/home/kash/interface/linux-2.6.3/drivers/mtd/maps/elan-104nc.c:144:elan_104nc_copy_from: 
NOTE:BOUND: Checking arg len [EXAMPLE=map_info.copy_from-3]
/home/kash/interface/linux-2.6.3/drivers/mtd/maps/pci.c:245:mtd_pci_copyfrom: 
ERROR:BOUND: Not checking arg len [COUNTER=map_info.copy_from-3] [fit=14] 
[fit_fn=3] [fn_ex=0] [fn_counter=1] [ex=4] [counter=3] [z = 
-4.59568283847783] [fn-z = -4.35889894354067]
}

static void mtd_pci_copyfrom(struct map_info *_map, void *to, unsigned long 
from, ssize_t len)
{
         struct map_pci_info *map = (struct map_pci_info *)_map;

Error --->
         memcpy_fromio(to, map->base + map->translate(map, from), len);
}

static void mtd_pci_write8(struct map_info *_map, u8 val, unsigned long ofs)
---------------------------------------------------------
[BUG] one example does the copy in chunks
/home/kash/interface/linux-2.6.3/drivers/mtd/maps/elan-104nc.c:185:elan_104nc_copy_to: 
NOTE:BOUND: Checking arg len [EXAMPLE=map_info.copy_to-3]
/home/kash/interface/linux-2.6.3/drivers/mtd/maps/pci.c:272:mtd_pci_copyto: 
ERROR:BOUND: Not checking arg len [COUNTER=map_info.copy_to-3] [fit=13] 
[fit_fn=1] [fn_ex=0] [fn_counter=1] [ex=4] [counter=3] [z = 
-4.59568283847783] [fn-z = -4.35889894354067]
}

static void mtd_pci_copyto(struct map_info *_map, unsigned long to, const 
void *from, ssize_t len)
{
         struct map_pci_info *map = (struct map_pci_info *)_map;

Error --->
         memcpy_toio(map->base + map->translate(map, to), from, len);
}

static struct map_info mtd_pci_map = {
---------------------------------------------------------
[BUG]
/home/kash/interface/linux-2.6.3/drivers/mtd/maps/elan-104nc.c:144:elan_104nc_copy_from: 
NOTE:BOUND: Checking arg len [EXAMPLE=map_info.copy_from-3]
/home/kash/interface/linux-2.6.3/drivers/mtd/maps/ich2rom.c:67:ich2rom_copy_from: 
ERROR:BOUND: Not checking arg len [COUNTER=map_info.copy_from-3] [fit=14] 
[fit_fn=1] [fn_ex=0] [fn_counter=1] [ex=4] [counter=3] [z = 
-4.59568283847783] [fn-z = -4.35889894354067]
         return __raw_readl(addr(map, ofs));
}

static void ich2rom_copy_from(struct map_info *map, void *to, unsigned long 
from, ssize_t len)
{

Error --->
         memcpy_fromio(to, addr(map, from), len);
}

static void ich2rom_write8(struct map_info *map, __u8 d, unsigned long ofs)
---------------------------------------------------------
[BUG]
/home/kash/interface/linux-2.6.3/drivers/mtd/maps/elan-104nc.c:144:elan_104nc_copy_from: 
NOTE:BOUND: Checking arg len [EXAMPLE=map_info.copy_from-3]
/home/kash/interface/linux-2.6.3/drivers/mtd/maps/map_funcs.c:73:simple_map_copy_from: 
ERROR:BOUND: Not checking arg len [COUNTER=map_info.copy_from-3] [fit=14] 
[fit_fn=2] [fn_ex=0] [fn_counter=1] [ex=4] [counter=3] [z = -4.59568283847783]
[fn-z = -4.35889894354067]
#endif /* CFI_B8 */
}

static void simple_map_copy_from(struct map_info *map, void *to, unsigned 
long from, ssize_t len)
{

Error --->
         memcpy_fromio(to, map->virt + from, len);
}

static void simple_map_copy_to(struct map_info *map, unsigned long to, 
const void *from, ssize_t len)
---------------------------------------------------------
[BUG]
/home/kash/interface/linux-2.6.3/drivers/mtd/maps/elan-104nc.c:185:elan_104nc_copy_to: 
NOTE:BOUND: Checking arg len [EXAMPLE=map_info.copy_to-3]
/home/kash/interface/linux-2.6.3/drivers/mtd/maps/map_funcs.c:78:simple_map_copy_to: 
ERROR:BOUND: Not checking arg len [COUNTER=map_info.copy_to-3] [fit=13] 
[fit_fn=2] [fn_ex=0] [fn_counter=1] [ex=4] [counter=3] [z = 
-4.59568283847783] [fn-z = -4.35889894354067]
         memcpy_fromio(to, map->virt + from, len);
}

static void simple_map_copy_to(struct map_info *map, unsigned long to, 
const void *from, ssize_t len)
{

Error --->
         memcpy_toio(map->virt + to, from, len);
}

void simple_map_init(struct map_info *map)
---------------------------------------------------------
[BUG]
/home/kash/interface/linux-2.6.3/drivers/ieee1394/csr.c:724:write_fcp: 
NOTE:BOUND: Checking arg length [EXAMPLE=hpsb_address_ops.write-5]
/home/kash/interface/linux-2.6.3/drivers/ieee1394/sbp2.c:1089:sbp2_handle_physdma_write: 
ERROR:BOUND: Not checking arg length [COUNTER=hpsb_address_ops.write-5] 
[fit=15] [fit_fn=1] [fn_ex=0] [fn_counter=1] [ex=1] [counter=2] [z = 
-4.90076972114066] [fn-z = -4.35889894354067]
{

         /*
          * Manually put the data in the right place.
          */

Error --->
         memcpy(bus_to_virt((u32)addr), data, length);
         sbp2util_packet_dump(data, length, "sbp2 phys dma write by 
device", (u32)addr);
         return(RCODE_COMPLETE);
}
---------------------------------------------------------
[BUG]
/home/kash/interface/linux-2.6.3/drivers/ieee1394/csr.c:724:write_fcp: 
NOTE:BOUND: Checking arg length [EXAMPLE=hpsb_address_ops.write-5]
/home/kash/interface/linux-2.6.3/drivers/ieee1394/sbp2.c:2437:sbp2_handle_status_write: 
ERROR:BOUND: Not checking arg length [COUNTER=hpsb_address_ops.write-5]
[fit=15] [fit_fn=2] [fn_ex=0] [fn_counter=1] [ex=1] [counter=2] [z = 
-4.90076972114066] [fn-z = -4.35889894354067]
         }

         /*
          * Put response into scsi_id status fifo...
          */

Error --->
         memcpy(&scsi_id->status_block, data, length);

         /*
          * Byte swap first two quadlets (8 bytes) of status for processing
---------------------------------------------------------
[BUG] example makes sure length is 4
/home/kash/interface/linux-2.6.3/drivers/ieee1394/cmp.c:191:pcr_read: 
NOTE:BOUND: Checking arg length [EXAMPLE=hpsb_address_ops.read-4]
/home/kash/interface/linux-2.6.3/drivers/ieee1394/sbp2.c:1105:sbp2_handle_physdma_read: 
ERROR:BOUND: Not checking arg length [COUNTER=hpsb_address_ops.read-4] 
[fit=16] [fit_fn=1] [fn_ex=0] [fn_counter=1] [ex=1] [counter=2] [z = 
-4.90076972114066] [fn-z = -4.35889894354067]
{

         /*
          * Grab data from memory and send a read response.
          */

Error --->
         memcpy(data, bus_to_virt((u32)addr), length);
         sbp2util_packet_dump(data, length, "sbp2 phys dma read by device", 
(u32)addr);
         return(RCODE_COMPLETE);
}
---------------------------------------------------------
[BUG] overflow
/home/kash/interface/linux-2.6.3/drivers/ieee1394/cmp.c:191:pcr_read: 
NOTE:BOUND: Checking arg length [EXAMPLE=hpsb_address_ops.read-4]
/home/kash/interface/linux-2.6.3/drivers/ieee1394/csr.c:271:read_maps: 
ERROR:BOUND: Not checking arg length [COUNTER=hpsb_address_ops.read-4] 
[fit=16] [fit_fn=2] [fn_ex=0] [fn_counter=1] [ex=1] [counter=2] [z = 
-4.90076972114066] [fn-z = -4.35889894354067]
                         - CSR_TOPOLOGY_MAP;
         } else {
                 src = ((char *)host->csr.speed_map) + csraddr - CSR_SPEED_MAP;
         }


Error --->
         memcpy(buffer, src, length);
         spin_unlock_irqrestore(&host->csr.lock, flags);
         return RCODE_COMPLETE;
}
---------------------------------------------------------
[BUG] overflow
/home/kash/interface/linux-2.6.3/drivers/scsi/qla2xxx/qla_os.c:558:qla2x00_sysfs_read_nvram: 
NOTE:BOUND: Checking arg count [EXAMPLE=bin_attribute.read-3]
/home/kash/interface/linux-2.6.3/drivers/base/firmware_class.c:152:firmware_data_read: 
ERROR:BOUND: Not checking arg count [COUNTER=bin_attribute.read-3] [fit=17] 
[fit_fn=1] [fn_ex=0] [fn_counter=1] [ex=1] [counter=2] [z = 
-4.90076972114066] [fn-z = -4.35889894354067]
         if (offset > fw->size)
                 return 0;
         if (offset + count > fw->size)
                 count = fw->size - offset;


Error --->
         memcpy(buffer, fw->data + offset, count);
         return count;
}
static int
---------------------------------------------------------
[BUG] overflow
/home/kash/interface/linux-2.6.3/drivers/scsi/qla2xxx/qla_os.c:558:qla2x00_sysfs_read_nvram: 
NOTE:BOUND: Checking arg count [EXAMPLE=bin_attribute.read-3]
/home/kash/interface/linux-2.6.3/drivers/scsi/qla2xxx/qla_os.c:489:qla2x00_sysfs_read_fw_dump: 
ERROR:BOUND: Not checking arg count [COUNTER=bin_attribute.read-3] [fit=17] 
[fit_fn=2] [fn_ex=0] [fn_counter=1] [ex=1] [counter=2] [z = 
-4.90076972114066] [fn-z = -4.35889894354067]
         if (off > ha->fw_dump_buffer_len)
                 return 0;
         if (off + count > ha->fw_dump_buffer_len)
                 count = ha->fw_dump_buffer_len - off;


Error --->
         memcpy(buf, &ha->fw_dump_buffer[off], count);

         return (count);
}


