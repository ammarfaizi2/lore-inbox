Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262092AbUC1Gx6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Mar 2004 01:53:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262088AbUC1Gx6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Mar 2004 01:53:58 -0500
Received: from smtp-roam.Stanford.EDU ([171.64.10.152]:43982 "EHLO
	smtp-roam.Stanford.EDU") by vger.kernel.org with ESMTP
	id S262092AbUC1Gxe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Mar 2004 01:53:34 -0500
Message-Id: <5.2.1.1.2.20040327222849.02171fd0@kash.pobox.stanford.edu>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.1
Date: Sat, 27 Mar 2004 22:53:34 -0800
To: linux-kernel@vger.kernel.org
From: Ken Ashcraft <kash@stanford.edu>
Subject: [CHECKER] 23 missing bounds checks
Cc: mc@cs.stanford.edu
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm from the Stanford Metacompilation research group where we use static 
analysis to find bugs.  I'm trying a new technique, so I would appreciate 
feedback on these error reports.

I found these errors by comparing implementations of the same 
interface.  If functions are assigned to the same function pointer (same 
field of some struct), I assume that the functions are called from the same 
context.  Therefore, they should treat their incoming parameters 
similarly.  In this case, before using scalar parameters as array indices, 
the functions should either perform bounds checks on those scalars or not 
perform bounds checks.  Any contradiction is an error.

There are 23 reports below.  Each report contains first a reference to an 
EXAMPLE or a place where the parameter is checked.  That reference is 
followed by a COUNTER(example) or a place where the parameter is not 
checked.  After that is a code snippet from the counter example.  The type 
of the function pointer (struct foo.bar) can be found in the COUNTER field: 
[COUNTER=struct foo.bar-param_num].

I was unsure about the validity of the errors where the function pointer is 
struct map_info.copy_to/from.  The examples did not do a straightforward 
bounds check.

Thanks for your feedback,
Ken Ashcraft

#  Total 				  = 23
# BUGs	|	File Name
3	|	/drivers/sbp2.c
2	|	/mtd/ich2rom.c
2	|	/mtd/pci.c
2	|	/mtd/map_funcs.c
2	|	/linux-2.6.3/binfmt_misc.c
1	|	/net/af_bluetooth.c
1	|	/drivers/mem.c
1	|	/usb/kobil_sct.c
1	|	/media/zoran_procfs.c
1	|	/net/mpoa_proc.c
1	|	/net/af_rose.c
1	|	/net/af_netrom.c
1	|	/net/af_econet.c
1	|	/fs/nfsctl.c
1	|	/drivers/csr.c
1	|	/cpu/centaur.c
1	|	/net/ipv6_sockglue.c

---------------------------------------------------------
[BUG]
/home/kash/interface/linux-2.6.3/net/ipv4/ip_sockglue.c:403:ip_setsockopt: 
NOTE:BOUND: Checking arg optlen [EXAMPLE=struct sctp_af.setsockopt-4]
/home/kash/interface/linux-2.6.3/net/ipv6/ipv6_sockglue.c:271:ipv6_setsockopt: 
ERROR:BOUND: Not checking arg optlen [COUNTER=struct sctp_af.setsockopt-4] 
[fit=4] [fit_fn=1] [fn_ex=1] [fn_counter=1] [ex=11] [counter=1] [z = 
-0.529812942826017] [fn-z = -2.91998558035372]
			break;

		memset(opt, 0, sizeof(*opt));
		opt->tot_len = sizeof(*opt) + optlen;
		retv = -EFAULT;

Error --->
		if (copy_from_user(opt+1, optval, optlen))
			goto done;

		msg.msg_controllen = optlen;
---------------------------------------------------------
[BUG] our favorite overflow for kmalloc
/home/kash/interface/linux-2.6.3/arch/i386/kernel/microcode.c:430:microcode_write: 
NOTE:BOUND: Checking arg len [EXAMPLE=struct file_operations.write-2]
/home/kash/interface/linux-2.6.3/drivers/char/mem.c:605:kmsg_write: 
ERROR:BOUND: Not checking arg count [COUNTER=struct 
file_operations.write-2] [fit=1] [fit_fn=1] [fn_ex=0] [fn_counter=1] 
[ex=59] [counter=1] [z = 1.18469775551818] [fn-z = -4.35889894354067]

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
[BUG] overflow in vmalloc
/home/kash/interface/linux-2.6.3/drivers/acpi/battery.c:591:acpi_battery_write_alarm: 
NOTE:BOUND: Checking arg count [EXAMPLE=struct proc_dir_entry.write_proc-2]
/home/kash/interface/linux-2.6.3/drivers/media/video/zoran_procfs.c:217:zoran_write_proc: 
ERROR:BOUND: Not checking arg count [COUNTER=struct 
proc_dir_entry.write_proc-2] [fit=2] [fit_fn=1] [fn_ex=0] [fn_counter=1] 
[ex=16] [counter=1] [z = -0.166924465222397] [fn-z = -4.35889894354067]
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
NOTE:BOUND: Checking arg count [EXAMPLE=struct file_operations.read-2]
/home/kash/interface/linux-2.6.3/net/atm/mpoa_proc.c:157:proc_mpc_read: 
ERROR:BOUND: Not checking arg count [COUNTER=struct file_operations.read-2] 
[fit=5] [fit_fn=5] [fn_ex=0] [fn_counter=1] [ex=60] [counter=5] [z = 
-0.995943188142822] [fn-z = -4.35889894354067]
	}

	if (*pos >= length) length = 0;
	else {
	  if ((count + *pos) > length) count = length - *pos;

Error --->
	  if (copy_to_user(buff, (char *)page , count)) {
  		  free_page(page);
		  return -EFAULT;
           }
---------------------------------------------------------
[BUG] overflow
/home/kash/interface/linux-2.6.3/arch/i386/kernel/apm.c:1447:do_read: 
NOTE:BOUND: Checking arg count [EXAMPLE=struct file_operations.read-2]
/home/kash/interface/linux-2.6.3/fs/binfmt_misc.c:570:bm_status_read: 
ERROR:BOUND: Not checking arg nbytes [COUNTER=struct 
file_operations.read-2] [fit=5] [fit_fn=4] [fn_ex=0] [fn_counter=1] [ex=60] 
[counter=5] [z = -0.995943188142822] [fn-z = -4.35889894354067]
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
NOTE:BOUND: Checking arg count [EXAMPLE=struct file_operations.read-2]
/home/kash/interface/linux-2.6.3/fs/binfmt_misc.c:449:bm_entry_read: 
ERROR:BOUND: Not checking arg nbytes [COUNTER=struct 
file_operations.read-2] [fit=5] [fit_fn=3] [fn_ex=0] [fn_counter=1] [ex=60] 
[counter=5] [z = -0.995943188142822] [fn-z = -4.35889894354067]
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
[BUG] overflow
/home/kash/interface/linux-2.6.3/arch/i386/kernel/apm.c:1447:do_read: 
NOTE:BOUND: Checking arg count [EXAMPLE=struct file_operations.read-2]
/home/kash/interface/linux-2.6.3/fs/nfsd/nfsctl.c:148:TA_read: ERROR:BOUND: 
Not checking arg size [COUNTER=struct file_operations.read-2] [fit=5] 
[fit_fn=2] [fn_ex=0] [fn_counter=1] [ex=60] [counter=5] [z = 
-0.995943188142822] [fn-z = -4.35889894354067]
		return 0;
	if (*pos >= ar->size)
		return 0;
	if (*pos + size > ar->size)
		size = ar->size - *pos;

Error --->
	if (copy_to_user(buf, ar->data + *pos, size))
		return -EFAULT;
	*pos += size;
	return size;
---------------------------------------------------------
[BUG] signed
/home/kash/interface/linux-2.6.3/net/ax25/af_ax25.c:773:ax25_create: 
NOTE:BOUND: Checking arg protocol [EXAMPLE=struct net_proto_family.create-1]
/home/kash/interface/linux-2.6.3/net/bluetooth/af_bluetooth.c:99:bt_sock_create: 
ERROR:BOUND: Not checking arg proto [COUNTER=struct 
net_proto_family.create-1] [fit=6] [fit_fn=1] [fn_ex=0] [fn_counter=1] 
[ex=6] [counter=1] [z = -1.12724296038136] [fn-z = -4.35889894354067]

	if (proto >= BT_MAX_PROTO)
		return -EINVAL;

#if defined(CONFIG_KMOD)

Error --->
	if (!bt_proto[proto]) {
		request_module("bt-proto-%d", proto);
	}
#endif
---------------------------------------------------------
[BUG] need lower bound
/home/kash/interface/linux-2.6.3/drivers/usb/serial/cyberjack.c:235:cyberjack_write: 
NOTE:BOUND: Checking arg count [EXAMPLE=struct usb_serial_device_type.write-3]
/home/kash/interface/linux-2.6.3/drivers/usb/serial/kobil_sct.c:444:kobil_write: 
ERROR:BOUND: Not checking arg count [COUNTER=struct 
usb_serial_device_type.write-3] [fit=7] [fit_fn=1] [fn_ex=0] [fn_counter=1] 
[ex=3] [counter=1] [z = -1.83532587096449] [fn-z = -4.35889894354067]
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
[BUG] example is questionable
/home/kash/interface/linux-2.6.3/arch/i386/kernel/cpu/mtrr/amd.c:16:amd_get_mtrr: 
NOTE:BOUND: Checking arg reg [EXAMPLE=struct mtrr_ops.get-0]
/home/kash/interface/linux-2.6.3/arch/i386/kernel/cpu/mtrr/centaur.c:54:centaur_get_mcr: 
ERROR:BOUND: Not checking arg reg [COUNTER=struct mtrr_ops.get-0] [fit=8] 
[fit_fn=1] [fn_ex=0] [fn_counter=1] [ex=3] [counter=1] [z = 
-1.83532587096449] [fn-z = -4.35889894354067]

static void
centaur_get_mcr(unsigned int reg, unsigned long *base,
		unsigned int *size, mtrr_type * type)
{

Error --->
	*base = centaur_mcr[reg].high >> PAGE_SHIFT;
	*size = -(centaur_mcr[reg].low & 0xfffff000) >> PAGE_SHIFT;
	*type = MTRR_TYPE_WRCOMB;	/*  If it is there, it is write-combining  */
	if (centaur_mcr_type == 1 && ((centaur_mcr[reg].low & 31) & 2))
---------------------------------------------------------
[BUG]
/home/kash/interface/linux-2.6.3/net/appletalk/ddp.c:1573:atalk_sendmsg: 
NOTE:BOUND: Checking arg len [EXAMPLE=struct proto_ops.sendmsg-3]
/home/kash/interface/linux-2.6.3/net/netrom/af_netrom.c:1104:nr_sendmsg: 
ERROR:BOUND: Not checking arg len [COUNTER=struct proto_ops.sendmsg-3] 
[fit=10] [fit_fn=1] [fn_ex=0] [fn_counter=1] [ex=15] [counter=3] [z = 
-2.27109989583067] [fn-z = -4.35889894354067]

	asmptr = skb->h.raw;
	SOCK_DEBUG(sk, "NET/ROM: Appending user data\n");

	/* User data follows immediately after the NET/ROM transport header */

Error --->
	if (memcpy_fromiovec(asmptr, msg->msg_iov, len)) {
		kfree_skb(skb);
		err = -EFAULT;
		goto out;
---------------------------------------------------------
[BUG] overflow: if (len + 15 > dev->mtu)
/home/kash/interface/linux-2.6.3/net/appletalk/ddp.c:1573:atalk_sendmsg: 
NOTE:BOUND: Checking arg len [EXAMPLE=struct proto_ops.sendmsg-3]
/home/kash/interface/linux-2.6.3/net/econet/af_econet.c:355:econet_sendmsg: 
ERROR:BOUND: Not checking arg len [COUNTER=struct proto_ops.sendmsg-3] 
[fit=10] [fit_fn=2] [fn_ex=0] [fn_counter=1] [ex=15] [counter=3] [z = 
-2.27109989583067] [fn-z = -4.35889894354067]
			} else if (res < 0)
				goto out_free;
		}
		
		/* Copy the data. Returns -EFAULT on error */

Error --->
		err = memcpy_fromiovec(skb_put(skb,len), msg->msg_iov, len);
		skb->protocol = proto;
		skb->dev = dev;
		skb->priority = sk->sk_priority;
---------------------------------------------------------
[BUG] lots of overflow fun
/home/kash/interface/linux-2.6.3/net/appletalk/ddp.c:1573:atalk_sendmsg: 
NOTE:BOUND: Checking arg len [EXAMPLE=struct proto_ops.sendmsg-3]
/home/kash/interface/linux-2.6.3/net/rose/af_rose.c:1086:rose_sendmsg: 
ERROR:BOUND: Not checking arg len [COUNTER=struct proto_ops.sendmsg-3] 
[fit=10] [fit_fn=3] [fn_ex=0] [fn_counter=1] [ex=15] [counter=3] [z = 
-2.27109989583067] [fn-z = -4.35889894354067]
	 */
	SOCK_DEBUG(sk, "ROSE: Appending user data\n");

	asmptr = skb->h.raw = skb_put(skb, len);


Error --->
	err = memcpy_fromiovec(asmptr, msg->msg_iov, len);
	if (err) {
		kfree_skb(skb);
		return err;
---------------------------------------------------------
[BUG] one example does the copy in chunks
/home/kash/interface/linux-2.6.3/drivers/mtd/maps/elan-104nc.c:185:elan_104nc_copy_to: 
NOTE:BOUND: Checking arg len [EXAMPLE=struct map_info.copy_to-3]
/home/kash/interface/linux-2.6.3/drivers/mtd/maps/pci.c:272:mtd_pci_copyto: 
ERROR:BOUND: Not checking arg len [COUNTER=struct map_info.copy_to-3] 
[fit=14] [fit_fn=1] [fn_ex=0] [fn_counter=1] [ex=4] [counter=3] [z = 
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
/home/kash/interface/linux-2.6.3/drivers/mtd/maps/elan-104nc.c:185:elan_104nc_copy_to: 
NOTE:BOUND: Checking arg len [EXAMPLE=struct map_info.copy_to-3]
/home/kash/interface/linux-2.6.3/drivers/mtd/maps/map_funcs.c:78:simple_map_copy_to: 
ERROR:BOUND: Not checking arg len [COUNTER=struct map_info.copy_to-3] 
[fit=14] [fit_fn=2] [fn_ex=0] [fn_counter=1] [ex=4] [counter=3] [z = 
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
/home/kash/interface/linux-2.6.3/drivers/mtd/maps/elan-104nc.c:144:elan_104nc_copy_from: 
NOTE:BOUND: Checking arg len [EXAMPLE=struct map_info.copy_from-3]
/home/kash/interface/linux-2.6.3/drivers/mtd/maps/map_funcs.c:73:simple_map_copy_from: 
ERROR:BOUND: Not checking arg len [COUNTER=struct map_info.copy_from-3] 
[fit=13] [fit_fn=2] [fn_ex=0] [fn_counter=1] [ex=4] [counter=3] [z = 
-4.59568283847783] [fn-z = -4.35889894354067]
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
NOTE:BOUND: Checking arg len [EXAMPLE=struct map_info.copy_to-3]
/home/kash/interface/linux-2.6.3/drivers/mtd/maps/ich2rom.c:90:ich2rom_copy_to: 
ERROR:BOUND: Not checking arg len [COUNTER=struct map_info.copy_to-3] 
[fit=14] [fit_fn=3] [fn_ex=0] [fn_counter=1] [ex=4] [counter=3] [z = 
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
NOTE:BOUND: Checking arg len [EXAMPLE=struct map_info.copy_from-3]
/home/kash/interface/linux-2.6.3/drivers/mtd/maps/pci.c:245:mtd_pci_copyfrom: 
ERROR:BOUND: Not checking arg len [COUNTER=struct map_info.copy_from-3] 
[fit=13] [fit_fn=3] [fn_ex=0] [fn_counter=1] [ex=4] [counter=3] [z = 
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
[BUG]
/home/kash/interface/linux-2.6.3/drivers/mtd/maps/elan-104nc.c:144:elan_104nc_copy_from: 
NOTE:BOUND: Checking arg len [EXAMPLE=struct map_info.copy_from-3]
/home/kash/interface/linux-2.6.3/drivers/mtd/maps/ich2rom.c:67:ich2rom_copy_from: 
ERROR:BOUND: Not checking arg len [COUNTER=struct map_info.copy_from-3] 
[fit=13] [fit_fn=1] [fn_ex=0] [fn_counter=1] [ex=4] [counter=3] [z = 
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
/home/kash/interface/linux-2.6.3/drivers/ieee1394/csr.c:724:write_fcp: 
NOTE:BOUND: Checking arg length [EXAMPLE=struct hpsb_address_ops.write-5]
/home/kash/interface/linux-2.6.3/drivers/ieee1394/sbp2.c:2437:sbp2_handle_status_write: 
ERROR:BOUND: Not checking arg length [COUNTER=struct 
hpsb_address_ops.write-5] [fit=16] [fit_fn=2] [fn_ex=0] [fn_counter=1] 
[ex=1] [counter=2] [z = -4.90076972114066] [fn-z = -4.35889894354067]
	}

	/*
	 * Put response into scsi_id status fifo...
	 */

Error --->
	memcpy(&scsi_id->status_block, data, length);

	/*
	 * Byte swap first two quadlets (8 bytes) of status for processing
---------------------------------------------------------
[BUG]
/home/kash/interface/linux-2.6.3/drivers/ieee1394/csr.c:724:write_fcp: 
NOTE:BOUND: Checking arg length [EXAMPLE=struct hpsb_address_ops.write-5]
/home/kash/interface/linux-2.6.3/drivers/ieee1394/sbp2.c:1089:sbp2_handle_physdma_write: 
ERROR:BOUND: Not checking arg length [COUNTER=struct 
hpsb_address_ops.write-5] [fit=16] [fit_fn=1] [fn_ex=0] [fn_counter=1] 
[ex=1] [counter=2] [z = -4.90076972114066] [fn-z = -4.35889894354067]
{

         /*
          * Manually put the data in the right place.
          */

Error --->
         memcpy(bus_to_virt((u32)addr), data, length);
	sbp2util_packet_dump(data, length, "sbp2 phys dma write by device", 
(u32)addr);
         return(RCODE_COMPLETE);
}
---------------------------------------------------------
[BUG] overflow
/home/kash/interface/linux-2.6.3/drivers/ieee1394/cmp.c:191:pcr_read: 
NOTE:BOUND: Checking arg length [EXAMPLE=struct hpsb_address_ops.read-4]
/home/kash/interface/linux-2.6.3/drivers/ieee1394/csr.c:271:read_maps: 
ERROR:BOUND: Not checking arg length [COUNTER=struct 
hpsb_address_ops.read-4] [fit=15] [fit_fn=2] [fn_ex=0] [fn_counter=1] 
[ex=1] [counter=2] [z = -4.90076972114066] [fn-z = -4.35889894354067]
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
[BUG] example makes sure length is 4
/home/kash/interface/linux-2.6.3/drivers/ieee1394/cmp.c:191:pcr_read: 
NOTE:BOUND: Checking arg length [EXAMPLE=struct hpsb_address_ops.read-4]
/home/kash/interface/linux-2.6.3/drivers/ieee1394/sbp2.c:1105:sbp2_handle_physdma_read: 
ERROR:BOUND: Not checking arg length [COUNTER=struct 
hpsb_address_ops.read-4] [fit=15] [fit_fn=1] [fn_ex=0] [fn_counter=1] 
[ex=1] [counter=2] [z = -4.90076972114066] [fn-z = -4.35889894354067]
{

         /*
          * Grab data from memory and send a read response.
          */

Error --->
         memcpy(data, bus_to_virt((u32)addr), length);
	sbp2util_packet_dump(data, length, "sbp2 phys dma read by device", (u32)addr);
         return(RCODE_COMPLETE);
}


