Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318028AbSGWLZV>; Tue, 23 Jul 2002 07:25:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318032AbSGWLZV>; Tue, 23 Jul 2002 07:25:21 -0400
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:62414 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S318028AbSGWLZQ>; Tue, 23 Jul 2002 07:25:16 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Linus Torvalds <torvalds@transmeta.com>
Date: Tue, 23 Jul 2002 21:28:26 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15677.15834.295020.89244@notabene.cse.unsw.edu.au>
cc: linux-kernel@vger.kernel.org
Subject: PATCH: type safe(r) list_entry repacement: generic_out_cast
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


list.h has this nifty macro called list_entry that takes a pointer to a "struct
list_head" and "casts" that to a pointer to some structure that
contains the "struct list_head".

However it doesn't do any type checking on the pointer, and you can 
give it a pointer to something else... just as I did in line 850 of
md/md.c :-(

So I thought I would add some type checking to list_entry so that
you have to pass it a "struct list_head *", but I then discovered that
lots of places are using list_entry to do creative casting on
all sorts of other things like inodes embedded in bigger structures
and so on.

So... I have created "generic_out_cast" which is like the old
list_entry but with an extra type arguement.  I have then
changed uses of list_entry that did not actually apply to lists to use
generic_out_cast, often indirectly.

Why "out_cast"???

Well OO people would probably call it a "down cast" as you are
effectively casting from a more-general type to a less-general (more
specific) type that is there-fore lower on the type latice.
So maybe it should be "generic_down_cast".
But seeing that one is casting from an embeded internal structure to a
containing external structure, "out_cast" seemed a little easier to
intuitively understand.

If anyone wants to suggest better names of any of the names I have
chosen, feel free to submit suggestions or patches.

NOTE: I probably haven't found all list_entry() calls that don't operate
on list_heads.  I have found all that are necessary for a clean
compile with my standard .config, but it doesn't include everything.
If there are some I have missed, they will cause benign compiler
warnings and can easily be fixed later.

NOTE2: I placed generic_out_cast in list.h because I knew it would be
included in all the right places.  Suggests for a better place are
welcome.

NeilBrown (who wishes the compiler could catch even more of his silly
           typos than it currently does)


 ----------- Diffstat output ------------
 ./drivers/pci/pci-driver.c    |   14 +++++++-------
 ./drivers/pci/proc.c          |    4 ++--
 ./drivers/scsi/scsi.h         |    2 ++
 ./drivers/scsi/scsi_scan.c    |    3 +--
 ./drivers/usb/core/usb.c      |   10 +++++-----
 ./fs/driverfs/inode.c         |    8 ++++----
 ./fs/ext2/ext2.h              |    2 +-
 ./include/linux/adfs_fs.h     |    2 +-
 ./include/linux/driverfs_fs.h |    2 ++
 ./include/linux/efs_fs.h      |    2 +-
 ./include/linux/ext3_fs.h     |    2 +-
 ./include/linux/fs.h          |   10 ++++++++--
 ./include/linux/hfs_fs.h      |    2 +-
 ./include/linux/iso_fs.h      |    2 +-
 ./include/linux/list.h        |   13 ++++++++++++-
 ./include/linux/msdos_fs.h    |    2 +-
 ./include/linux/ncp_fs.h      |    2 +-
 ./include/linux/nfs_fs.h      |    2 +-
 ./include/linux/pci.h         |    4 ++++
 ./include/linux/proc_fs.h     |    2 +-
 ./include/linux/qnx4_fs.h     |    2 +-
 ./include/linux/reiserfs_fs.h |    2 +-
 ./include/linux/shmem_fs.h    |    2 +-
 ./include/linux/smb_fs.h      |    2 +-
 ./include/linux/ufs_fs.h      |    2 +-
 ./include/linux/usb.h         |    2 ++
 ./net/socket.c                |    2 +-
 27 files changed, 65 insertions(+), 39 deletions(-)

--- ./drivers/scsi/scsi.h	2002/07/23 07:08:05	1.1
+++ ./drivers/scsi/scsi.h	2002/07/23 11:14:05	1.2
@@ -627,6 +627,8 @@ struct scsi_device {
 	int allow_revalidate;
 	struct device sdev_driverfs_dev;
 };
+#define	to_scsi_device(d)	\
+	generic_out_cast(struct device, d, struct scsi_device, sdev_driverfs_dev)
 
 
 /*
--- ./drivers/scsi/scsi_scan.c	2002/07/23 07:10:04	1.1
+++ ./drivers/scsi/scsi_scan.c	2002/07/23 11:14:05	1.2
@@ -293,8 +293,7 @@ static int scsilun_to_int(ScsiLun *scsil
 static ssize_t scsi_device_type_read(struct device *driverfs_dev, char *page, 
 	size_t count, loff_t off)
 {
-	struct scsi_device *SDpnt = list_entry(driverfs_dev,
-		struct scsi_device, sdev_driverfs_dev);
+	struct scsi_device *SDpnt = to_scsi_device(driverfs_dev);
 
 	if ((SDpnt->type <= MAX_SCSI_DEVICE_CODE) && 
 		(scsi_device_types[(int)SDpnt->type] != NULL))
--- ./drivers/usb/core/usb.c	2002/07/23 07:13:47	1.1
+++ ./drivers/usb/core/usb.c	2002/07/23 11:14:05	1.2
@@ -832,7 +832,7 @@ show_config (struct device *dev, char *b
 
 	if (off)
 		return 0;
-	udev = list_entry (dev, struct usb_device, dev);
+	udev = to_usb_device (dev);
 	return sprintf (buf, "%u\n", udev->actconfig->bConfigurationValue);
 }
 static struct driver_file_entry usb_config_entry = {
@@ -851,7 +851,7 @@ show_altsetting (struct device *dev, cha
 
 	if (off)
 		return 0;
-	interface = list_entry (dev, struct usb_interface, dev);
+	interface = to_usb_interface (dev);
 	return sprintf (buf, "%u\n", interface->altsetting->bAlternateSetting);
 }
 static struct driver_file_entry usb_altsetting_entry = {
@@ -868,7 +868,7 @@ static ssize_t show_product (struct devi
 
 	if (off)
 		return 0;
-	udev = list_entry (dev, struct usb_device, dev);
+	udev = to_usb_device (dev);
 
 	len = usb_string(udev, udev->descriptor.iProduct, buf, PAGE_SIZE); 
 	buf[len] = '\n';
@@ -890,7 +890,7 @@ show_manufacturer (struct device *dev, c
 
 	if (off)
 		return 0;
-	udev = list_entry (dev, struct usb_device, dev);
+	udev = to_usb_device (dev);
 
 	len = usb_string(udev, udev->descriptor.iManufacturer, buf, PAGE_SIZE); 
 	buf[len] = '\n';
@@ -912,7 +912,7 @@ show_serial (struct device *dev, char *b
 
 	if (off)
 		return 0;
-	udev = list_entry (dev, struct usb_device, dev);
+	udev = to_usb_device (dev);
 
 	len = usb_string(udev, udev->descriptor.iSerialNumber, buf, PAGE_SIZE); 
 	buf[len] = '\n';
--- ./drivers/pci/pci-driver.c	2002/07/23 07:05:59	1.1
+++ ./drivers/pci/pci-driver.c	2002/07/23 11:14:05	1.2
@@ -41,8 +41,8 @@ static int pci_device_probe(struct devic
 	struct pci_driver *drv;
 	struct pci_dev *pci_dev;
 
-	drv = list_entry(dev->driver, struct pci_driver, driver);
-	pci_dev = list_entry(dev, struct pci_dev, dev);
+	drv = to_pci_driver(dev->driver);
+	pci_dev = to_pci_dev(dev);
 
 	if (drv->probe) {
 		const struct pci_device_id *id;
@@ -60,7 +60,7 @@ static int pci_device_probe(struct devic
 
 static int pci_device_remove(struct device * dev)
 {
-	struct pci_dev * pci_dev = list_entry(dev,struct pci_dev,dev);
+	struct pci_dev * pci_dev = to_pci_dev(dev);
 	struct pci_driver * drv = pci_dev->driver;
 
 	if (drv) {
@@ -73,7 +73,7 @@ static int pci_device_remove(struct devi
 
 static int pci_device_suspend(struct device * dev, u32 state, u32 level)
 {
-	struct pci_dev * pci_dev = (struct pci_dev *)list_entry(dev,struct pci_dev,dev);
+	struct pci_dev * pci_dev = to_pci_dev(dev);
 	int error = 0;
 
 	if (pci_dev->driver) {
@@ -87,7 +87,7 @@ static int pci_device_suspend(struct dev
 
 static int pci_device_resume(struct device * dev, u32 level)
 {
-	struct pci_dev * pci_dev = (struct pci_dev *)list_entry(dev,struct pci_dev,dev);
+	struct pci_dev * pci_dev = to_pci_dev(dev);
 
 	if (pci_dev->driver) {
 		if (level == RESUME_POWER_ON && pci_dev->driver->resume)
@@ -175,8 +175,8 @@ pci_dev_driver(const struct pci_dev *dev
  */
 static int pci_bus_match(struct device * dev, struct device_driver * drv) 
 {
-	struct pci_dev * pci_dev = list_entry(dev, struct pci_dev, dev);
-	struct pci_driver * pci_drv = list_entry(drv,struct pci_driver,driver);
+	struct pci_dev * pci_dev = to_pci_dev(dev);
+	struct pci_driver * pci_drv = to_pci_driver(drv);
 	const struct pci_device_id * ids = pci_drv->id_table;
 
 	if (!ids) 
--- ./drivers/pci/proc.c	2002/07/23 10:25:17	1.1
+++ ./drivers/pci/proc.c	2002/07/23 11:14:05	1.2
@@ -374,7 +374,7 @@ static struct proc_dir_entry *proc_bus_p
 /* driverfs files */
 static ssize_t pci_show_irq(struct device * dev, char * buf, size_t count, loff_t off)
 {
-	struct pci_dev * pci_dev = list_entry(dev,struct pci_dev,dev);
+	struct pci_dev * pci_dev = to_pci_dev(dev);
 	return off ? 0 : sprintf(buf,"%u\n",pci_dev->irq);
 }
 
@@ -386,7 +386,7 @@ static struct driver_file_entry pci_irq_
 
 static ssize_t pci_show_resources(struct device * dev, char * buf, size_t count, loff_t off)
 {
-	struct pci_dev * pci_dev = list_entry(dev,struct pci_dev,dev);
+	struct pci_dev * pci_dev = to_pci_dev(dev);
 	char * str = buf;
 	int i;
 
--- ./include/linux/list.h	2002/07/22 11:20:13	1.1
+++ ./include/linux/list.h	2002/07/23 11:14:05	1.2
@@ -178,13 +178,24 @@ static inline void list_splice_init(list
 }
 
 /**
+ * generic_out_cast - cast a member of a structure out to that structure
+ *
+ * @ptr_type:   the type of the member
+ * @ptr:	the pointer to the member.
+ * @type:	the type of the struct this is embedded in.
+ * @member:	the name of the member within the struct.
+ *
+ */
+#define generic_out_cast(ptr_type, ptr, type, member) \
+	({ const ptr_type *__ptr = ptr ; (type *)((char *)(__ptr)-(unsigned long)(&((type *)0)->member));})
+/**
  * list_entry - get the struct for this entry
  * @ptr:	the &list_t pointer.
  * @type:	the type of the struct this is embedded in.
  * @member:	the name of the list_struct within the struct.
  */
 #define list_entry(ptr, type, member) \
-	((type *)((char *)(ptr)-(unsigned long)(&((type *)0)->member)))
+	generic_out_cast(list_t, ptr, type, member)
 
 /**
  * list_for_each	-	iterate over a list
--- ./include/linux/fs.h	2002/07/22 11:30:57	1.1
+++ ./include/linux/fs.h	2002/07/23 11:14:05	1.2
@@ -407,14 +407,20 @@ struct socket_alloc {
 	struct inode vfs_inode;
 };
 
+#define inode_out_cast(ptr, type, member) \
+	generic_out_cast(struct inode, ptr, type, member)
+
 static inline struct socket *SOCKET_I(struct inode *inode)
 {
-	return &list_entry(inode, struct socket_alloc, vfs_inode)->socket;
+	return &inode_out_cast(inode, struct socket_alloc, vfs_inode)->socket;
 }
 
+#define socket_out_cast(ptr, type, member) \
+	generic_out_cast(struct socket, ptr, type, member)
+
 static inline struct inode *SOCK_INODE(struct socket *socket)
 {
-	return &list_entry(socket, struct socket_alloc, socket)->vfs_inode;
+	return &generic_out_cast(struct socket, socket, struct socket_alloc, socket)->vfs_inode;
 }
 
 /* will die */
--- ./include/linux/pci.h	2002/07/23 07:06:37	1.1
+++ ./include/linux/pci.h	2002/07/23 11:14:05	1.2
@@ -392,6 +392,7 @@ struct pci_dev {
 
 #define pci_dev_g(n) list_entry(n, struct pci_dev, global_list)
 #define pci_dev_b(n) list_entry(n, struct pci_dev, bus_list)
+#define	to_pci_dev(n) generic_out_cast(struct device, n, struct pci_dev, dev)
 
 /*
  *  For PCI devices, the region numbers are assigned this way:
@@ -490,6 +491,9 @@ struct pci_driver {
 
 	struct device_driver	driver;
 };
+
+#define	to_pci_driver(drv) \
+	generic_out_cast(struct device_driver, drv,struct pci_driver, driver)
 
 
 /* these external functions are only available when PCI support is enabled */
--- ./include/linux/adfs_fs.h	2002/07/22 11:38:14	1.1
+++ ./include/linux/adfs_fs.h	2002/07/23 11:14:05	1.2
@@ -68,7 +68,7 @@ static inline struct adfs_sb_info *ADFS_
 
 static inline struct adfs_inode_info *ADFS_I(struct inode *inode)
 {
-	return list_entry(inode, struct adfs_inode_info, vfs_inode);
+	return inode_out_cast(inode, struct adfs_inode_info, vfs_inode);
 }
 
 #endif
--- ./include/linux/efs_fs.h	2002/07/22 11:38:24	1.1
+++ ./include/linux/efs_fs.h	2002/07/23 11:14:05	1.2
@@ -41,7 +41,7 @@ static const char cprt[] = "EFS: "EFS_VE
 
 static inline struct efs_inode_info *INODE_INFO(struct inode *inode)
 {
-	return list_entry(inode, struct efs_inode_info, vfs_inode);
+	return inode_out_cast(inode, struct efs_inode_info, vfs_inode);
 }
 
 static inline struct efs_sb_info *SUPER_INFO(struct super_block *sb)
--- ./include/linux/ext3_fs.h	2002/07/22 11:38:36	1.1
+++ ./include/linux/ext3_fs.h	2002/07/23 11:14:05	1.2
@@ -447,7 +447,7 @@ struct ext3_super_block {
 #define EXT3_SB(sb)	(&((sb)->u.ext3_sb))
 static inline struct ext3_inode_info *EXT3_I(struct inode *inode)
 {
-	return list_entry(inode, struct ext3_inode_info, vfs_inode);
+	return inode_out_cast(inode, struct ext3_inode_info, vfs_inode);
 }
 #else
 /* Assume that user mode programs are passing in an ext3fs superblock, not
--- ./include/linux/hfs_fs.h	2002/07/22 11:38:43	1.1
+++ ./include/linux/hfs_fs.h	2002/07/23 11:14:05	1.2
@@ -322,7 +322,7 @@ extern void hfs_tolower(unsigned char *,
 
 static inline struct hfs_inode_info *HFS_I(struct inode *inode)
 {
-	return list_entry(inode, struct hfs_inode_info, vfs_inode);
+	return inode_out_cast(inode, struct hfs_inode_info, vfs_inode);
 }
 
 static inline struct hfs_sb_info *HFS_SB(struct super_block *sb)
--- ./include/linux/iso_fs.h	2002/07/22 11:38:49	1.1
+++ ./include/linux/iso_fs.h	2002/07/23 11:14:05	1.2
@@ -179,7 +179,7 @@ static inline struct isofs_sb_info *ISOF
 
 static inline struct iso_inode_info *ISOFS_I(struct inode *inode)
 {
-	return list_entry(inode, struct iso_inode_info, vfs_inode);
+	return inode_out_cast(inode, struct iso_inode_info, vfs_inode);
 }
 
 static inline int isonum_711(char *p)
--- ./include/linux/msdos_fs.h	2002/07/22 11:38:57	1.1
+++ ./include/linux/msdos_fs.h	2002/07/23 11:14:05	1.2
@@ -198,7 +198,7 @@ static inline struct msdos_sb_info *MSDO
 
 static inline struct msdos_inode_info *MSDOS_I(struct inode *inode)
 {
-	return list_entry(inode, struct msdos_inode_info, vfs_inode);
+	return inode_out_cast(inode, struct msdos_inode_info, vfs_inode);
 }
 
 struct fat_cache {
--- ./include/linux/ncp_fs.h	2002/07/22 11:39:03	1.1
+++ ./include/linux/ncp_fs.h	2002/07/23 11:14:05	1.2
@@ -199,7 +199,7 @@ static inline struct ncp_server *NCP_SBP
 #define NCP_SERVER(inode)	NCP_SBP((inode)->i_sb)
 static inline struct ncp_inode_info *NCP_FINFO(struct inode *inode)
 {
-	return list_entry(inode, struct ncp_inode_info, vfs_inode);
+	return inode_out_cast(inode, struct ncp_inode_info, vfs_inode);
 }
 
 #ifdef DEBUG_NCP_MALLOC
--- ./include/linux/nfs_fs.h	2002/07/22 11:39:14	1.1
+++ ./include/linux/nfs_fs.h	2002/07/23 11:14:05	1.2
@@ -176,7 +176,7 @@ struct nfs_inode {
 
 static inline struct nfs_inode *NFS_I(struct inode *inode)
 {
-	return list_entry(inode, struct nfs_inode, vfs_inode);
+	return inode_out_cast(inode, struct nfs_inode, vfs_inode);
 }
 #define NFS_SB(s)		((struct nfs_server *)(s->u.generic_sbp))
 
--- ./include/linux/proc_fs.h	2002/07/22 11:39:23	1.1
+++ ./include/linux/proc_fs.h	2002/07/23 11:14:05	1.2
@@ -219,7 +219,7 @@ struct proc_inode {
 
 static inline struct proc_inode *PROC_I(const struct inode *inode)
 {
-	return list_entry(inode, struct proc_inode, vfs_inode);
+	return inode_out_cast(inode, struct proc_inode, vfs_inode);
 }
 
 static inline struct proc_dir_entry *PDE(const struct inode *inode)
--- ./include/linux/qnx4_fs.h	2002/07/22 11:39:27	1.1
+++ ./include/linux/qnx4_fs.h	2002/07/23 11:14:05	1.2
@@ -140,7 +140,7 @@ static inline struct qnx4_sb_info *qnx4_
 
 static inline struct qnx4_inode_info *qnx4_i(struct inode *inode)
 {
-	return list_entry(inode, struct qnx4_inode_info, vfs_inode);
+	return inode_out_cast(inode, struct qnx4_inode_info, vfs_inode);
 }
 
 static inline struct qnx4_inode_entry *qnx4_raw_inode(struct inode *inode)
--- ./include/linux/shmem_fs.h	2002/07/22 11:39:45	1.1
+++ ./include/linux/shmem_fs.h	2002/07/23 11:14:05	1.2
@@ -31,7 +31,7 @@ struct shmem_sb_info {
 
 static inline struct shmem_inode_info *SHMEM_I(struct inode *inode)
 {
-	return list_entry(inode, struct shmem_inode_info, vfs_inode);
+	return inode_out_cast(inode, struct shmem_inode_info, vfs_inode);
 }
 
 #endif
--- ./include/linux/reiserfs_fs.h	2002/07/22 11:39:36	1.1
+++ ./include/linux/reiserfs_fs.h	2002/07/23 11:14:05	1.2
@@ -288,7 +288,7 @@ struct unfm_nodeinfo {
 
 static inline struct reiserfs_inode_info *REISERFS_I(struct inode *inode)
 {
-	return list_entry(inode, struct reiserfs_inode_info, vfs_inode);
+	return inode_out_cast(inode, struct reiserfs_inode_info, vfs_inode);
 }
 
 static inline struct reiserfs_sb_info *REISERFS_SB(const struct super_block *sb)
--- ./include/linux/smb_fs.h	2002/07/22 11:40:00	1.1
+++ ./include/linux/smb_fs.h	2002/07/23 11:14:05	1.2
@@ -38,7 +38,7 @@ static inline struct smb_sb_info *SMB_SB
 
 static inline struct smb_inode_info *SMB_I(struct inode *inode)
 {
-	return list_entry(inode, struct smb_inode_info, vfs_inode);
+	return inode_out_cast(inode, struct smb_inode_info, vfs_inode);
 }
 
 /* macro names are short for word, double-word, long value (?) */
--- ./include/linux/ufs_fs.h	2002/07/22 11:40:05	1.1
+++ ./include/linux/ufs_fs.h	2002/07/23 11:14:05	1.2
@@ -784,7 +784,7 @@ extern void ufs_truncate (struct inode *
 
 static inline struct ufs_inode_info *UFS_I(struct inode *inode)
 {
-	return list_entry(inode, struct ufs_inode_info, vfs_inode);
+	return inode_out_cast(inode, struct ufs_inode_info, vfs_inode);
 }
 
 #endif	/* __KERNEL__ */
--- ./include/linux/driverfs_fs.h	2002/07/23 10:26:09	1.1
+++ ./include/linux/driverfs_fs.h	2002/07/23 11:14:06	1.2
@@ -46,6 +46,8 @@ struct driver_file_entry {
 	ssize_t (*store)(struct device * dev, const char * buf, size_t count, loff_t off);
 };
 
+#define dde_out_cast(d) generic_out_cast(struct driver_dir_entry, d, struct device, dir)
+
 extern int
 driverfs_create_dir(struct driver_dir_entry *, struct driver_dir_entry *);
 
--- ./include/linux/usb.h	2002/07/23 07:13:17	1.1
+++ ./include/linux/usb.h	2002/07/23 11:14:06	1.2
@@ -257,6 +257,7 @@ struct usb_interface {
 	struct device dev;		/* interface specific device info */
 	void *private_data;
 };
+#define	to_usb_interface(d) generic_out_cast(struct device, d, struct usb_interface, dev)
 
 /* USB_DT_CONFIG: Configuration descriptor information.
  *
@@ -422,6 +423,7 @@ struct usb_device {
 	int maxchild;			/* Number of ports if hub */
 	struct usb_device *children[USB_MAXCHILDREN];
 };
+#define	to_usb_device(d) generic_out_cast(struct device, d, struct usb_device, dev)
 
 extern struct usb_device *usb_alloc_dev(struct usb_device *parent, struct usb_bus *);
 extern struct usb_device *usb_get_dev(struct usb_device *dev);
--- ./net/socket.c	2002/07/23 07:16:26	1.1
+++ ./net/socket.c	2002/07/23 11:14:06	1.2
@@ -288,7 +288,7 @@ static struct inode *sock_alloc_inode(st
 static void sock_destroy_inode(struct inode *inode)
 {
 	kmem_cache_free(sock_inode_cachep,
-			list_entry(inode, struct socket_alloc, vfs_inode));
+			inode_out_cast(inode, struct socket_alloc, vfs_inode));
 }
 
 static void init_once(void * foo, kmem_cache_t * cachep, unsigned long flags)
--- ./fs/ext2/ext2.h	2002/07/23 10:33:46	1.1
+++ ./fs/ext2/ext2.h	2002/07/23 11:14:06	1.2
@@ -34,7 +34,7 @@ struct ext2_inode_info {
 
 static inline struct ext2_inode_info *EXT2_I(struct inode *inode)
 {
-	return list_entry(inode, struct ext2_inode_info, vfs_inode);
+	return inode_out_cast(inode, struct ext2_inode_info, vfs_inode);
 }
 
 /* balloc.c */
--- ./fs/driverfs/inode.c	2002/07/23 10:17:44	1.1
+++ ./fs/driverfs/inode.c	2002/07/23 11:14:06	1.2
@@ -267,7 +267,7 @@ driverfs_read_file(struct file *file, ch
 	if (count > PAGE_SIZE)
 		count = PAGE_SIZE;
 
-	dev = list_entry(entry->parent,struct device, dir);
+	dev = dde_out_cast(entry->parent);
 
 	page = (unsigned char*)__get_free_page(GFP_KERNEL);
 	if (!page)
@@ -328,7 +328,7 @@ driverfs_write_file(struct file *file, c
 	if (!entry->store)
 		return 0;
 
-	dev = list_entry(entry->parent,struct device, dir);
+	dev = dde_out_cast(entry->parent);
 
 	page = (char *)__get_free_page(GFP_KERNEL);
 	if (!page)
@@ -394,7 +394,7 @@ static int driverfs_open_file(struct ino
 	entry = (struct driver_file_entry *)inode->u.generic_ip;
 	if (!entry)
 		return -EFAULT;
-	dev = (struct device *)list_entry(entry->parent,struct device,dir);
+	dev = dde_out_cast(entry->parent);
 	get_device(dev);
 	filp->private_data = entry;
 	return 0;
@@ -408,7 +408,7 @@ static int driverfs_release(struct inode
 	entry = (struct driver_file_entry *)filp->private_data;
 	if (!entry)
 		return -EFAULT;
-	dev = (struct device *)list_entry(entry->parent,struct device,dir);
+	dev = dde_out_cast(entry->parent);
 	put_device(dev);
 	return 0;
 }
