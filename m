Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317030AbSGXMfk>; Wed, 24 Jul 2002 08:35:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317034AbSGXMfk>; Wed, 24 Jul 2002 08:35:40 -0400
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:42372 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S317030AbSGXMfe>; Wed, 24 Jul 2002 08:35:34 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Date: Wed, 24 Jul 2002 22:38:45 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15678.40917.311278.590142@notabene.cse.unsw.edu.au>
Subject: PATCH - mark 2: type safe(r) list_entry repacement: container_of
In-Reply-To: message from Neil Brown on Tuesday July 23
References: <15677.15834.295020.89244@notabene.cse.unsw.edu.au>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ok, here is my second attempt at the patch to make list_entry more
type-safe. Thankyou to various people for various suggestions.

With the "typeof" suggestion from Kevin, I could just change
list_entry and not woory about the fact that lots of people use
"list_entry" for things that aren't lists.... but I didn't.

NeilBrown

### Comments for ChangeSet
Define container_of which cast from member to struct with some type checking.

This is much like list_entry but is cearly for things other than lists.

List_entry now uses container_of.

Thanks to  Linus Torvalds and Christoph Hellwig  for suggesting
   the word "container" in the macro name
 to Christoph Hellwig for suggesting kernel.h as suitable location
  for definition
 to Kevin O'Connor for suggesting the use of typeof instead of
  giving the member type explicitly
 to  Mikael Pettersson for suggesting offsetof



 ----------- Diffstat output ------------
 ./drivers/pci/pci-driver.c    |   14 +++++++-------
 ./drivers/pci/proc.c          |    4 ++--
 ./drivers/scsi/scsi.h         |    2 ++
 ./drivers/scsi/scsi_scan.c    |    3 +--
 ./drivers/usb/core/usb.c      |   10 +++++-----
 ./fs/driverfs/inode.c         |    8 ++++----
 ./fs/ext2/ext2.h              |    2 +-
 ./include/linux/adfs_fs.h     |    2 +-
 ./include/linux/device.h      |    2 ++
 ./include/linux/efs_fs.h      |    2 +-
 ./include/linux/ext3_fs.h     |    2 +-
 ./include/linux/fs.h          |    4 ++--
 ./include/linux/hfs_fs.h      |    2 +-
 ./include/linux/iso_fs.h      |    2 +-
 ./include/linux/kernel.h      |   13 +++++++++++++
 ./include/linux/list.h        |    2 +-
 ./include/linux/msdos_fs.h    |    2 +-
 ./include/linux/ncp_fs.h      |    2 +-
 ./include/linux/nfs_fs.h      |    2 +-
 ./include/linux/pci.h         |    3 +++
 ./include/linux/proc_fs.h     |    2 +-
 ./include/linux/qnx4_fs.h     |    2 +-
 ./include/linux/reiserfs_fs.h |    2 +-
 ./include/linux/shmem_fs.h    |    2 +-
 ./include/linux/smb_fs.h      |    2 +-
 ./include/linux/ufs_fs.h      |    2 +-
 ./include/linux/usb.h         |    2 ++
 ./net/socket.c                |    2 +-
 28 files changed, 60 insertions(+), 39 deletions(-)

--- ./drivers/scsi/scsi.h	2002/07/24 11:12:15	1.1
+++ ./drivers/scsi/scsi.h	2002/07/24 11:14:41	1.2
@@ -627,6 +627,8 @@ struct scsi_device {
 	int allow_revalidate;
 	struct device sdev_driverfs_dev;
 };
+#define	to_scsi_device(d)	\
+	container_of(d, struct scsi_device, sdev_driverfs_dev)
 
 
 /*
--- ./drivers/scsi/scsi_scan.c	2002/07/24 11:12:15	1.1
+++ ./drivers/scsi/scsi_scan.c	2002/07/24 11:14:41	1.2
@@ -293,8 +293,7 @@ static int scsilun_to_int(ScsiLun *scsil
 static ssize_t scsi_device_type_read(struct device *driverfs_dev, char *page, 
 	size_t count, loff_t off)
 {
-	struct scsi_device *SDpnt = list_entry(driverfs_dev,
-		struct scsi_device, sdev_driverfs_dev);
+	struct scsi_device *SDpnt = to_scsi_device(driverfs_dev);
 
 	if ((SDpnt->type <= MAX_SCSI_DEVICE_CODE) && 
 		(scsi_device_types[(int)SDpnt->type] != NULL))
--- ./drivers/usb/core/usb.c	2002/07/24 11:12:15	1.1
+++ ./drivers/usb/core/usb.c	2002/07/24 11:14:41	1.2
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
--- ./drivers/pci/proc.c	2002/07/24 11:12:16	1.1
+++ ./drivers/pci/proc.c	2002/07/24 11:14:41	1.2
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
 
--- ./drivers/pci/pci-driver.c	2002/07/24 11:12:16	1.1
+++ ./drivers/pci/pci-driver.c	2002/07/24 11:14:41	1.2
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
--- ./include/linux/list.h	2002/07/24 11:12:16	1.1
+++ ./include/linux/list.h	2002/07/24 11:14:41	1.2
@@ -184,7 +184,7 @@ static inline void list_splice_init(list
  * @member:	the name of the list_struct within the struct.
  */
 #define list_entry(ptr, type, member) \
-	((type *)((char *)(ptr)-(unsigned long)(&((type *)0)->member)))
+	container_of(ptr, type, member)
 
 /**
  * list_for_each	-	iterate over a list
--- ./include/linux/fs.h	2002/07/24 11:12:16	1.1
+++ ./include/linux/fs.h	2002/07/24 11:14:41	1.2
@@ -409,12 +409,12 @@ struct socket_alloc {
 
 static inline struct socket *SOCKET_I(struct inode *inode)
 {
-	return &list_entry(inode, struct socket_alloc, vfs_inode)->socket;
+	return &container_of(inode, struct socket_alloc, vfs_inode)->socket;
 }
 
 static inline struct inode *SOCK_INODE(struct socket *socket)
 {
-	return &list_entry(socket, struct socket_alloc, socket)->vfs_inode;
+	return &container_of(socket, struct socket_alloc, socket)->vfs_inode;
 }
 
 /* will die */
--- ./include/linux/pci.h	2002/07/24 11:12:16	1.1
+++ ./include/linux/pci.h	2002/07/24 11:14:41	1.2
@@ -392,6 +392,7 @@ struct pci_dev {
 
 #define pci_dev_g(n) list_entry(n, struct pci_dev, global_list)
 #define pci_dev_b(n) list_entry(n, struct pci_dev, bus_list)
+#define	to_pci_dev(n) container_of(n, struct pci_dev, dev)
 
 /*
  *  For PCI devices, the region numbers are assigned this way:
@@ -490,6 +491,8 @@ struct pci_driver {
 
 	struct device_driver	driver;
 };
+
+#define	to_pci_driver(drv) container_of(drv,struct pci_driver, driver)
 
 
 /* these external functions are only available when PCI support is enabled */
--- ./include/linux/usb.h	2002/07/24 11:12:16	1.1
+++ ./include/linux/usb.h	2002/07/24 11:14:41	1.2
@@ -257,6 +257,7 @@ struct usb_interface {
 	struct device dev;		/* interface specific device info */
 	void *private_data;
 };
+#define	to_usb_interface(d) container_of(d, struct usb_interface, dev)
 
 /* USB_DT_CONFIG: Configuration descriptor information.
  *
@@ -422,6 +423,7 @@ struct usb_device {
 	int maxchild;			/* Number of ports if hub */
 	struct usb_device *children[USB_MAXCHILDREN];
 };
+#define	to_usb_device(d) container_of(d, struct usb_device, dev)
 
 extern struct usb_device *usb_alloc_dev(struct usb_device *parent, struct usb_bus *);
 extern struct usb_device *usb_get_dev(struct usb_device *dev);
--- ./include/linux/adfs_fs.h	2002/07/24 11:12:16	1.1
+++ ./include/linux/adfs_fs.h	2002/07/24 11:14:41	1.2
@@ -68,7 +68,7 @@ static inline struct adfs_sb_info *ADFS_
 
 static inline struct adfs_inode_info *ADFS_I(struct inode *inode)
 {
-	return list_entry(inode, struct adfs_inode_info, vfs_inode);
+	return container_of(inode, struct adfs_inode_info, vfs_inode);
 }
 
 #endif
--- ./include/linux/efs_fs.h	2002/07/24 11:12:16	1.1
+++ ./include/linux/efs_fs.h	2002/07/24 11:14:41	1.2
@@ -41,7 +41,7 @@ static const char cprt[] = "EFS: "EFS_VE
 
 static inline struct efs_inode_info *INODE_INFO(struct inode *inode)
 {
-	return list_entry(inode, struct efs_inode_info, vfs_inode);
+	return container_of(inode, struct efs_inode_info, vfs_inode);
 }
 
 static inline struct efs_sb_info *SUPER_INFO(struct super_block *sb)
--- ./include/linux/ext3_fs.h	2002/07/24 11:12:16	1.1
+++ ./include/linux/ext3_fs.h	2002/07/24 11:14:42	1.2
@@ -447,7 +447,7 @@ struct ext3_super_block {
 #define EXT3_SB(sb)	(&((sb)->u.ext3_sb))
 static inline struct ext3_inode_info *EXT3_I(struct inode *inode)
 {
-	return list_entry(inode, struct ext3_inode_info, vfs_inode);
+	return container_of(inode, struct ext3_inode_info, vfs_inode);
 }
 #else
 /* Assume that user mode programs are passing in an ext3fs superblock, not
--- ./include/linux/hfs_fs.h	2002/07/24 11:12:16	1.1
+++ ./include/linux/hfs_fs.h	2002/07/24 11:14:42	1.2
@@ -322,7 +322,7 @@ extern void hfs_tolower(unsigned char *,
 
 static inline struct hfs_inode_info *HFS_I(struct inode *inode)
 {
-	return list_entry(inode, struct hfs_inode_info, vfs_inode);
+	return container_of(inode, struct hfs_inode_info, vfs_inode);
 }
 
 static inline struct hfs_sb_info *HFS_SB(struct super_block *sb)
--- ./include/linux/iso_fs.h	2002/07/24 11:12:16	1.1
+++ ./include/linux/iso_fs.h	2002/07/24 11:14:42	1.2
@@ -179,7 +179,7 @@ static inline struct isofs_sb_info *ISOF
 
 static inline struct iso_inode_info *ISOFS_I(struct inode *inode)
 {
-	return list_entry(inode, struct iso_inode_info, vfs_inode);
+	return container_of(inode, struct iso_inode_info, vfs_inode);
 }
 
 static inline int isonum_711(char *p)
--- ./include/linux/msdos_fs.h	2002/07/24 11:12:16	1.1
+++ ./include/linux/msdos_fs.h	2002/07/24 11:14:42	1.2
@@ -198,7 +198,7 @@ static inline struct msdos_sb_info *MSDO
 
 static inline struct msdos_inode_info *MSDOS_I(struct inode *inode)
 {
-	return list_entry(inode, struct msdos_inode_info, vfs_inode);
+	return container_of(inode, struct msdos_inode_info, vfs_inode);
 }
 
 struct fat_cache {
--- ./include/linux/ncp_fs.h	2002/07/24 11:12:16	1.1
+++ ./include/linux/ncp_fs.h	2002/07/24 11:14:42	1.2
@@ -199,7 +199,7 @@ static inline struct ncp_server *NCP_SBP
 #define NCP_SERVER(inode)	NCP_SBP((inode)->i_sb)
 static inline struct ncp_inode_info *NCP_FINFO(struct inode *inode)
 {
-	return list_entry(inode, struct ncp_inode_info, vfs_inode);
+	return container_of(inode, struct ncp_inode_info, vfs_inode);
 }
 
 #ifdef DEBUG_NCP_MALLOC
--- ./include/linux/nfs_fs.h	2002/07/24 11:12:16	1.1
+++ ./include/linux/nfs_fs.h	2002/07/24 11:14:42	1.2
@@ -176,7 +176,7 @@ struct nfs_inode {
 
 static inline struct nfs_inode *NFS_I(struct inode *inode)
 {
-	return list_entry(inode, struct nfs_inode, vfs_inode);
+	return container_of(inode, struct nfs_inode, vfs_inode);
 }
 #define NFS_SB(s)		((struct nfs_server *)(s->u.generic_sbp))
 
--- ./include/linux/proc_fs.h	2002/07/24 11:12:16	1.1
+++ ./include/linux/proc_fs.h	2002/07/24 11:14:42	1.2
@@ -219,7 +219,7 @@ struct proc_inode {
 
 static inline struct proc_inode *PROC_I(const struct inode *inode)
 {
-	return list_entry(inode, struct proc_inode, vfs_inode);
+	return container_of(inode, struct proc_inode, vfs_inode);
 }
 
 static inline struct proc_dir_entry *PDE(const struct inode *inode)
--- ./include/linux/qnx4_fs.h	2002/07/24 11:12:16	1.1
+++ ./include/linux/qnx4_fs.h	2002/07/24 11:14:42	1.2
@@ -140,7 +140,7 @@ static inline struct qnx4_sb_info *qnx4_
 
 static inline struct qnx4_inode_info *qnx4_i(struct inode *inode)
 {
-	return list_entry(inode, struct qnx4_inode_info, vfs_inode);
+	return container_of(inode, struct qnx4_inode_info, vfs_inode);
 }
 
 static inline struct qnx4_inode_entry *qnx4_raw_inode(struct inode *inode)
--- ./include/linux/shmem_fs.h	2002/07/24 11:12:16	1.1
+++ ./include/linux/shmem_fs.h	2002/07/24 11:14:42	1.2
@@ -31,7 +31,7 @@ struct shmem_sb_info {
 
 static inline struct shmem_inode_info *SHMEM_I(struct inode *inode)
 {
-	return list_entry(inode, struct shmem_inode_info, vfs_inode);
+	return container_of(inode, struct shmem_inode_info, vfs_inode);
 }
 
 #endif
--- ./include/linux/smb_fs.h	2002/07/24 11:12:16	1.1
+++ ./include/linux/smb_fs.h	2002/07/24 11:14:42	1.2
@@ -38,7 +38,7 @@ static inline struct smb_sb_info *SMB_SB
 
 static inline struct smb_inode_info *SMB_I(struct inode *inode)
 {
-	return list_entry(inode, struct smb_inode_info, vfs_inode);
+	return container_of(inode, struct smb_inode_info, vfs_inode);
 }
 
 /* macro names are short for word, double-word, long value (?) */
--- ./include/linux/reiserfs_fs.h	2002/07/24 11:12:16	1.1
+++ ./include/linux/reiserfs_fs.h	2002/07/24 11:14:42	1.2
@@ -288,7 +288,7 @@ struct unfm_nodeinfo {
 
 static inline struct reiserfs_inode_info *REISERFS_I(struct inode *inode)
 {
-	return list_entry(inode, struct reiserfs_inode_info, vfs_inode);
+	return container_of(inode, struct reiserfs_inode_info, vfs_inode);
 }
 
 static inline struct reiserfs_sb_info *REISERFS_SB(const struct super_block *sb)
--- ./include/linux/ufs_fs.h	2002/07/24 11:12:16	1.1
+++ ./include/linux/ufs_fs.h	2002/07/24 11:14:42	1.2
@@ -784,7 +784,7 @@ extern void ufs_truncate (struct inode *
 
 static inline struct ufs_inode_info *UFS_I(struct inode *inode)
 {
-	return list_entry(inode, struct ufs_inode_info, vfs_inode);
+	return container_of(inode, struct ufs_inode_info, vfs_inode);
 }
 
 #endif	/* __KERNEL__ */
--- ./include/linux/device.h	2002/07/24 11:12:44	1.1
+++ ./include/linux/device.h	2002/07/24 11:14:42	1.2
@@ -160,6 +160,8 @@ struct device {
 	void	(*release)(struct device * dev);
 };
 
+#define to_device(d) container_of(d, struct device, dir)
+
 static inline struct device *
 list_to_dev(struct list_head *node)
 {
--- ./include/linux/kernel.h	2002/07/24 11:12:44	1.1
+++ ./include/linux/kernel.h	2002/07/24 11:14:42	1.2
@@ -150,6 +150,19 @@ extern const char *print_tainted(void);
 #define max_t(type,x,y) \
 	({ type __x = (x); type __y = (y); __x > __y ? __x: __y; })
 
+
+/**
+ * container_of - cast a member of a structure out to the containing structure
+ *
+ * @ptr:	the pointer to the member.
+ * @type:	the type of the container struct this is embedded in.
+ * @member:	the name of the member within the struct.
+ *
+ */
+#define container_of(ptr, type, member) ({			\
+        const typeof( ((type *)0)->member ) *__mptr = (ptr);	\
+        (type *)( (char *)__mptr - offsetof(type,member) );})
+
 #endif /* __KERNEL__ */
 
 #define SI_LOAD_SHIFT	16
--- ./net/socket.c	2002/07/24 11:12:17	1.1
+++ ./net/socket.c	2002/07/24 11:14:42	1.2
@@ -288,7 +288,7 @@ static struct inode *sock_alloc_inode(st
 static void sock_destroy_inode(struct inode *inode)
 {
 	kmem_cache_free(sock_inode_cachep,
-			list_entry(inode, struct socket_alloc, vfs_inode));
+			container_of(inode, struct socket_alloc, vfs_inode));
 }
 
 static void init_once(void * foo, kmem_cache_t * cachep, unsigned long flags)
--- ./fs/ext2/ext2.h	2002/07/24 11:12:17	1.1
+++ ./fs/ext2/ext2.h	2002/07/24 11:14:42	1.2
@@ -34,7 +34,7 @@ struct ext2_inode_info {
 
 static inline struct ext2_inode_info *EXT2_I(struct inode *inode)
 {
-	return list_entry(inode, struct ext2_inode_info, vfs_inode);
+	return container_of(inode, struct ext2_inode_info, vfs_inode);
 }
 
 /* balloc.c */
--- ./fs/driverfs/inode.c	2002/07/24 11:12:17	1.1
+++ ./fs/driverfs/inode.c	2002/07/24 11:14:42	1.2
@@ -267,7 +267,7 @@ driverfs_read_file(struct file *file, ch
 	if (count > PAGE_SIZE)
 		count = PAGE_SIZE;
 
-	dev = list_entry(entry->parent,struct device, dir);
+	dev = to_device(entry->parent);
 
 	page = (unsigned char*)__get_free_page(GFP_KERNEL);
 	if (!page)
@@ -328,7 +328,7 @@ driverfs_write_file(struct file *file, c
 	if (!entry->store)
 		return 0;
 
-	dev = list_entry(entry->parent,struct device, dir);
+	dev = to_device(entry->parent);
 
 	page = (char *)__get_free_page(GFP_KERNEL);
 	if (!page)
@@ -394,7 +394,7 @@ static int driverfs_open_file(struct ino
 	entry = (struct driver_file_entry *)inode->u.generic_ip;
 	if (!entry)
 		return -EFAULT;
-	dev = (struct device *)list_entry(entry->parent,struct device,dir);
+	dev = to_device(entry->parent);
 	get_device(dev);
 	filp->private_data = entry;
 	return 0;
@@ -408,7 +408,7 @@ static int driverfs_release(struct inode
 	entry = (struct driver_file_entry *)filp->private_data;
 	if (!entry)
 		return -EFAULT;
-	dev = (struct device *)list_entry(entry->parent,struct device,dir);
+	dev = to_device(entry->parent);
 	put_device(dev);
 	return 0;
 }
