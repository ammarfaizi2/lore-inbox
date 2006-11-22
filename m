Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756975AbWKVIAf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756975AbWKVIAf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 03:00:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756972AbWKVIAf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 03:00:35 -0500
Received: from rgminet01.oracle.com ([148.87.113.118]:60593 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1756975AbWKVIAd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 03:00:33 -0500
Date: Wed, 22 Nov 2006 00:00:23 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Eric.Moore@lsil.com, mpt_linux_developer@lsil.com,
       markus.lidel@shadowconnect.com, akpm <akpm@osdl.org>
Subject: [PATCH 2/3] kernel-doc: fix fusion and i2o docs
Message-Id: <20061122000023.98607a17.randy.dunlap@oracle.com>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <randy.dunlap@oracle.com>

Correct lots of typos, kernel-doc warnings, & kernel-doc usage
in fusion and i2o drivers.

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
---
 drivers/message/fusion/mptbase.c  |  255 ++++++++++++++++++++------------------
 drivers/message/fusion/mptfc.c    |    5 
 drivers/message/fusion/mptscsih.c |   24 +--
 drivers/message/fusion/mptspi.c   |    4 
 drivers/message/i2o/bus-osm.c     |    3 
 drivers/message/i2o/device.c      |    8 -
 drivers/message/i2o/driver.c      |   20 +-
 drivers/message/i2o/exec-osm.c    |   10 -
 drivers/message/i2o/i2o_block.c   |   17 +-
 drivers/message/i2o/i2o_proc.c    |    2 
 drivers/message/i2o/i2o_scsi.c    |   11 -
 drivers/message/i2o/pci.c         |    5 
 include/linux/i2o.h               |   18 +-
 13 files changed, 204 insertions(+), 178 deletions(-)

--- linux-2619-rc6g4.orig/include/linux/i2o.h
+++ linux-2619-rc6g4/include/linux/i2o.h
@@ -986,7 +986,8 @@ extern void i2o_driver_unregister(struct
 
 /**
  *	i2o_driver_notify_controller_add - Send notification of added controller
- *					   to a single I2O driver
+ *	@drv: I2O driver
+ *	@c: I2O controller
  *
  *	Send notification of added controller to a single registered driver.
  */
@@ -998,8 +999,9 @@ static inline void i2o_driver_notify_con
 };
 
 /**
- *	i2o_driver_notify_controller_remove - Send notification of removed
- *					      controller to a single I2O driver
+ *	i2o_driver_notify_controller_remove - Send notification of removed controller
+ *	@drv: I2O driver
+ *	@c: I2O controller
  *
  *	Send notification of removed controller to a single registered driver.
  */
@@ -1011,8 +1013,9 @@ static inline void i2o_driver_notify_con
 };
 
 /**
- *	i2o_driver_notify_device_add - Send notification of added device to a
- *				       single I2O driver
+ *	i2o_driver_notify_device_add - Send notification of added device
+ *	@drv: I2O driver
+ *	@i2o_dev: the added i2o_device
  *
  *	Send notification of added device to a single registered driver.
  */
@@ -1025,7 +1028,8 @@ static inline void i2o_driver_notify_dev
 
 /**
  *	i2o_driver_notify_device_remove - Send notification of removed device
- *					  to a single I2O driver
+ *	@drv: I2O driver
+ *	@i2o_dev: the added i2o_device
  *
  *	Send notification of removed device to a single registered driver.
  */
@@ -1148,7 +1152,7 @@ static inline void i2o_msg_post(struct i
 /**
  * 	i2o_msg_post_wait - Post and wait a message and wait until return
  *	@c: controller
- *	@m: message to post
+ *	@msg: message to post
  *	@timeout: time in seconds to wait
  *
  * 	This API allows an OSM to post a message and then be told whether or
--- linux-2619-rc6g4.orig/drivers/message/i2o/bus-osm.c
+++ linux-2619-rc6g4/drivers/message/i2o/bus-osm.c
@@ -56,6 +56,9 @@ static int i2o_bus_scan(struct i2o_devic
 /**
  *	i2o_bus_store_scan - Scan the I2O Bus Adapter
  *	@d: device which should be scanned
+ *	@attr: device_attribute
+ *	@buf: output buffer
+ *	@count: buffer size
  *
  *	Returns count.
  */
--- linux-2619-rc6g4.orig/drivers/message/i2o/device.c
+++ linux-2619-rc6g4/drivers/message/i2o/device.c
@@ -54,8 +54,8 @@ static inline int i2o_device_issue_claim
  *	@dev: I2O device to claim
  *	@drv: I2O driver which wants to claim the device
  *
- *	Do the leg work to assign a device to a given OSM. If the claim succeed
- *	the owner of the rimary. If the attempt fails a negative errno code
+ *	Do the leg work to assign a device to a given OSM. If the claim succeeds,
+ *	the owner is the primary. If the attempt fails a negative errno code
  *	is returned. On success zero is returned.
  */
 int i2o_device_claim(struct i2o_device *dev)
@@ -208,7 +208,7 @@ static struct i2o_device *i2o_device_all
 
 /**
  *	i2o_device_add - allocate a new I2O device and add it to the IOP
- *	@iop: I2O controller where the device is on
+ *	@c: I2O controller that the device is on
  *	@entry: LCT entry of the I2O device
  *
  *	Allocate a new I2O device and initialize it with the LCT entry. The
@@ -275,7 +275,7 @@ static struct i2o_device *i2o_device_add
 
 /**
  *	i2o_device_remove - remove an I2O device from the I2O core
- *	@dev: I2O device which should be released
+ *	@i2o_dev: I2O device which should be released
  *
  *	Is used on I2O controller removal or LCT modification, when the device
  *	is removed from the system. Note that the device could still hang
--- linux-2619-rc6g4.orig/drivers/message/i2o/driver.c
+++ linux-2619-rc6g4/drivers/message/i2o/driver.c
@@ -34,9 +34,7 @@ static spinlock_t i2o_drivers_lock;
 static struct i2o_driver **i2o_drivers;
 
 /**
- *	i2o_bus_match - Tell if a I2O device class id match the class ids of
- *			the I2O driver (OSM)
- *
+ *	i2o_bus_match - Tell if I2O device class id matches the class ids of the I2O driver (OSM)
  *	@dev: device which should be verified
  *	@drv: the driver to match against
  *
@@ -248,7 +246,7 @@ int i2o_driver_dispatch(struct i2o_contr
 
 /**
  *	i2o_driver_notify_controller_add_all - Send notify of added controller
- *					       to all I2O drivers
+ *	@c: newly added controller
  *
  *	Send notifications to all registered drivers that a new controller was
  *	added.
@@ -267,8 +265,8 @@ void i2o_driver_notify_controller_add_al
 }
 
 /**
- *	i2o_driver_notify_controller_remove_all - Send notify of removed
- *						  controller to all I2O drivers
+ *	i2o_driver_notify_controller_remove_all - Send notify of removed controller
+ *	@c: controller that is being removed
  *
  *	Send notifications to all registered drivers that a controller was
  *	removed.
@@ -287,8 +285,8 @@ void i2o_driver_notify_controller_remove
 }
 
 /**
- *	i2o_driver_notify_device_add_all - Send notify of added device to all
- *					   I2O drivers
+ *	i2o_driver_notify_device_add_all - Send notify of added device
+ *	@i2o_dev: newly added I2O device
  *
  *	Send notifications to all registered drivers that a device was added.
  */
@@ -306,8 +304,8 @@ void i2o_driver_notify_device_add_all(st
 }
 
 /**
- *	i2o_driver_notify_device_remove_all - Send notify of removed device to
- *					      all I2O drivers
+ *	i2o_driver_notify_device_remove_all - Send notify of removed device
+ *	@i2o_dev: device that is being removed
  *
  *	Send notifications to all registered drivers that a device was removed.
  */
@@ -362,7 +360,7 @@ int __init i2o_driver_init(void)
 /**
  *	i2o_driver_exit - clean up I2O drivers (OSMs)
  *
- *	Unregisters the I2O bus and free driver array.
+ *	Unregisters the I2O bus and frees driver array.
  */
 void __exit i2o_driver_exit(void)
 {
--- linux-2619-rc6g4.orig/drivers/message/i2o/exec-osm.c
+++ linux-2619-rc6g4/drivers/message/i2o/exec-osm.c
@@ -94,8 +94,8 @@ static struct i2o_exec_wait *i2o_exec_wa
 };
 
 /**
- *	i2o_exec_wait_free - Free a i2o_exec_wait struct
- *	@i2o_exec_wait: I2O wait data which should be cleaned up
+ *	i2o_exec_wait_free - Free an i2o_exec_wait struct
+ *	@wait: I2O wait data which should be cleaned up
  */
 static void i2o_exec_wait_free(struct i2o_exec_wait *wait)
 {
@@ -105,7 +105,7 @@ static void i2o_exec_wait_free(struct i2
 /**
  * 	i2o_msg_post_wait_mem - Post and wait a message with DMA buffers
  *	@c: controller
- *	@m: message to post
+ *	@msg: message to post
  *	@timeout: time in seconds to wait
  *	@dma: i2o_dma struct of the DMA buffer to free on failure
  *
@@ -269,6 +269,7 @@ static int i2o_msg_post_wait_complete(st
 /**
  *	i2o_exec_show_vendor_id - Displays Vendor ID of controller
  *	@d: device of which the Vendor ID should be displayed
+ *	@attr: device_attribute to display
  *	@buf: buffer into which the Vendor ID should be printed
  *
  *	Returns number of bytes printed into buffer.
@@ -290,6 +291,7 @@ static ssize_t i2o_exec_show_vendor_id(s
 /**
  *	i2o_exec_show_product_id - Displays Product ID of controller
  *	@d: device of which the Product ID should be displayed
+ *	@attr: device_attribute to display
  *	@buf: buffer into which the Product ID should be printed
  *
  *	Returns number of bytes printed into buffer.
@@ -365,7 +367,7 @@ static int i2o_exec_remove(struct device
 
 /**
  *	i2o_exec_lct_modified - Called on LCT NOTIFY reply
- *	@c: I2O controller on which the LCT has modified
+ *	@work: work struct for a specific controller
  *
  *	This function handles asynchronus LCT NOTIFY replies. It parses the
  *	new LCT and if the buffer for the LCT was to small sends a LCT NOTIFY
--- linux-2619-rc6g4.orig/drivers/message/i2o/i2o_block.c
+++ linux-2619-rc6g4/drivers/message/i2o/i2o_block.c
@@ -259,7 +259,7 @@ static int i2o_block_device_unlock(struc
 /**
  *	i2o_block_device_power - Power management for device dev
  *	@dev: I2O device which should receive the power management request
- *	@operation: Operation which should be send
+ *	@op: Operation to send
  *
  *	Send a power management request to the device dev.
  *
@@ -315,7 +315,7 @@ static inline struct i2o_block_request *
  *	i2o_block_request_free - Frees a I2O block request
  *	@ireq: I2O block request which should be freed
  *
- *	Fres the allocated memory (give it back to the request mempool).
+ *	Frees the allocated memory (give it back to the request mempool).
  */
 static inline void i2o_block_request_free(struct i2o_block_request *ireq)
 {
@@ -326,6 +326,7 @@ static inline void i2o_block_request_fre
  *	i2o_block_sglist_alloc - Allocate the SG list and map it
  *	@c: I2O controller to which the request belongs
  *	@ireq: I2O block request
+ *	@mptr: message body pointer
  *
  *	Builds the SG list and map it to be accessable by the controller.
  *
@@ -419,7 +420,7 @@ static int i2o_block_prep_req_fn(struct 
 
 /**
  *	i2o_block_delayed_request_fn - delayed request queue function
- *	delayed_request: the delayed request with the queue to start
+ *	@delayed_request: the delayed request with the queue to start
  *
  *	If the request queue is stopped for a disk, and there is no open
  *	request, a new event is created, which calls this function to start
@@ -488,7 +489,7 @@ static void i2o_block_end_request(struct
  *	i2o_block_reply - Block OSM reply handler.
  *	@c: I2O controller from which the message arrives
  *	@m: message id of reply
- *	qmsg: the actuall I2O message reply
+ *	@msg: the actual I2O message reply
  *
  *	This function gets all the message replies.
  *
@@ -599,6 +600,8 @@ static void i2o_block_biosparam(unsigned
 
 /**
  *	i2o_block_open - Open the block device
+ *	@inode: inode for block device being opened
+ *	@file: file to open
  *
  *	Power up the device, mount and lock the media. This function is called,
  *	if the block device is opened for access.
@@ -626,6 +629,8 @@ static int i2o_block_open(struct inode *
 
 /**
  *	i2o_block_release - Release the I2O block device
+ *	@inode: inode for block device being released
+ *	@file: file to close
  *
  *	Unlock and unmount the media, and power down the device. Gets called if
  *	the block device is closed.
@@ -672,6 +677,8 @@ static int i2o_block_getgeo(struct block
 
 /**
  *	i2o_block_ioctl - Issue device specific ioctl calls.
+ *	@inode: inode for block device ioctl
+ *	@file: file for ioctl
  *	@cmd: ioctl command
  *	@arg: arg
  *
@@ -899,7 +906,7 @@ static int i2o_block_transfer(struct req
 
 /**
  *	i2o_block_request_fn - request queue handling function
- *	q: request queue from which the request could be fetched
+ *	@q: request queue from which the request could be fetched
  *
  *	Takes the next request from the queue, transfers it and if no error
  *	occurs dequeue it from the queue. On arrival of the reply the message
--- linux-2619-rc6g4.orig/drivers/message/i2o/pci.c
+++ linux-2619-rc6g4/drivers/message/i2o/pci.c
@@ -259,6 +259,7 @@ static irqreturn_t i2o_pci_interrupt(int
 
 /**
  *	i2o_pci_irq_enable - Allocate interrupt for I2O controller
+ *	@c: i2o_controller that the request is for
  *
  *	Allocate an interrupt for the I2O controller, and activate interrupts
  *	on the I2O controller.
@@ -305,7 +306,7 @@ static void i2o_pci_irq_disable(struct i
 
 /**
  *	i2o_pci_probe - Probe the PCI device for an I2O controller
- *	@dev: PCI device to test
+ *	@pdev: PCI device to test
  *	@id: id which matched with the PCI device id table
  *
  *	Probe the PCI device for any device which is a memory of the
@@ -450,7 +451,7 @@ static int __devinit i2o_pci_probe(struc
 
 /**
  *	i2o_pci_remove - Removes a I2O controller from the system
- *	pdev: I2O controller which should be removed
+ *	@pdev: I2O controller which should be removed
  *
  *	Reset the I2O controller, disable interrupts and remove all allocated
  *	resources.
--- linux-2619-rc6g4.orig/drivers/message/fusion/mptbase.c
+++ linux-2619-rc6g4/drivers/message/fusion/mptbase.c
@@ -347,7 +347,7 @@ mpt_reply(MPT_ADAPTER *ioc, u32 pa)
 }
 
 /*=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
-/*
+/**
  *	mpt_interrupt - MPT adapter (IOC) specific interrupt handler.
  *	@irq: irq number (not used)
  *	@bus_id: bus identifier cookie == pointer to MPT_ADAPTER structure
@@ -387,14 +387,16 @@ mpt_interrupt(int irq, void *bus_id)
 }
 
 /*=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
-/*
- *	mpt_base_reply - MPT base driver's callback routine; all base driver
- *	"internal" request/reply processing is routed here.
- *	Currently used for EventNotification and EventAck handling.
+/**
+ *	mpt_base_reply - MPT base driver's callback routine
  *	@ioc: Pointer to MPT_ADAPTER structure
  *	@mf: Pointer to original MPT request frame
  *	@reply: Pointer to MPT reply frame (NULL if TurboReply)
  *
+ *	MPT base driver's callback routine; all base driver
+ *	"internal" request/reply processing is routed here.
+ *	Currently used for EventNotification and EventAck handling.
+ *
  *	Returns 1 indicating original alloc'd request frame ptr
  *	should be freed, or 0 if it shouldn't.
  */
@@ -530,7 +532,7 @@ mpt_base_reply(MPT_ADAPTER *ioc, MPT_FRA
  *	@dclass: Protocol driver's class (%MPT_DRIVER_CLASS enum value)
  *
  *	This routine is called by a protocol-specific driver (SCSI host,
- *	LAN, SCSI target) to register it's reply callback routine.  Each
+ *	LAN, SCSI target) to register its reply callback routine.  Each
  *	protocol-specific driver must do this before it will be able to
  *	use any IOC resources, such as obtaining request frames.
  *
@@ -572,7 +574,7 @@ mpt_register(MPT_CALLBACK cbfunc, MPT_DR
  *	mpt_deregister - Deregister a protocol drivers resources.
  *	@cb_idx: previously registered callback handle
  *
- *	Each protocol-specific driver should call this routine when it's
+ *	Each protocol-specific driver should call this routine when its
  *	module is unloaded.
  */
 void
@@ -617,7 +619,7 @@ mpt_event_register(int cb_idx, MPT_EVHAN
  *
  *	Each protocol-specific driver should call this routine
  *	when it does not (or can no longer) handle events,
- *	or when it's module is unloaded.
+ *	or when its module is unloaded.
  */
 void
 mpt_event_deregister(int cb_idx)
@@ -656,7 +658,7 @@ mpt_reset_register(int cb_idx, MPT_RESET
  *
  *	Each protocol-specific driver should call this routine
  *	when it does not (or can no longer) handle IOC reset handling,
- *	or when it's module is unloaded.
+ *	or when its module is unloaded.
  */
 void
 mpt_reset_deregister(int cb_idx)
@@ -670,6 +672,8 @@ mpt_reset_deregister(int cb_idx)
 /*=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
 /**
  *	mpt_device_driver_register - Register device driver hooks
+ *	@dd_cbfunc: driver callbacks struct
+ *	@cb_idx: MPT protocol driver index
  */
 int
 mpt_device_driver_register(struct mpt_pci_driver * dd_cbfunc, int cb_idx)
@@ -696,6 +700,7 @@ mpt_device_driver_register(struct mpt_pc
 /*=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
 /**
  *	mpt_device_driver_deregister - DeRegister device driver hooks
+ *	@cb_idx: MPT protocol driver index
  */
 void
 mpt_device_driver_deregister(int cb_idx)
@@ -887,8 +892,7 @@ mpt_add_sge(char *pAddr, u32 flagslength
 
 /*=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
 /**
- *	mpt_send_handshake_request - Send MPT request via doorbell
- *	handshake method.
+ *	mpt_send_handshake_request - Send MPT request via doorbell handshake method.
  *	@handle: Handle of registered MPT protocol driver
  *	@ioc: Pointer to MPT adapter structure
  *	@reqBytes: Size of the request in bytes
@@ -981,10 +985,13 @@ mpt_send_handshake_request(int handle, M
 
 /*=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
 /**
- * mpt_host_page_access_control - provides mechanism for the host
- * driver to control the IOC's Host Page Buffer access.
+ * mpt_host_page_access_control - control the IOC's Host Page Buffer access
  * @ioc: Pointer to MPT adapter structure
  * @access_control_value: define bits below
+ * @sleepFlag: Specifies whether the process can sleep
+ *
+ * Provides mechanism for the host driver to control the IOC's
+ * Host Page Buffer access.
  *
  * Access Control Value - bits[15:12]
  * 0h Reserved
@@ -1022,10 +1029,10 @@ mpt_host_page_access_control(MPT_ADAPTER
 /*=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
 /**
  *	mpt_host_page_alloc - allocate system memory for the fw
- *	If we already allocated memory in past, then resend the same pointer.
- *	ioc@: Pointer to pointer to IOC adapter
- *	ioc_init@: Pointer to ioc init config page
+ *	@ioc: Pointer to pointer to IOC adapter
+ *	@ioc_init: Pointer to ioc init config page
  *
+ *	If we already allocated memory in past, then resend the same pointer.
  *	Returns 0 for success, non-zero for failure.
  */
 static int
@@ -1091,12 +1098,15 @@ return 0;
 
 /*=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
 /**
- *	mpt_verify_adapter - Given a unique IOC identifier, set pointer to
- *	the associated MPT adapter structure.
+ *	mpt_verify_adapter - Given IOC identifier, set pointer to its adapter structure.
  *	@iocid: IOC unique identifier (integer)
  *	@iocpp: Pointer to pointer to IOC adapter
  *
- *	Returns iocid and sets iocpp.
+ *	Given a unique IOC identifier, set pointer to the associated MPT
+ *	adapter structure.
+ *
+ *	Returns iocid and sets iocpp if iocid is found.
+ *	Returns -1 if iocid is not found.
  */
 int
 mpt_verify_adapter(int iocid, MPT_ADAPTER **iocpp)
@@ -1115,9 +1125,10 @@ mpt_verify_adapter(int iocid, MPT_ADAPTE
 }
 
 /*=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
-/*
+/**
  *	mpt_attach - Install a PCI intelligent MPT adapter.
  *	@pdev: Pointer to pci_dev structure
+ *	@id: PCI device ID information
  *
  *	This routine performs all the steps necessary to bring the IOC of
  *	a MPT adapter to a OPERATIONAL state.  This includes registering
@@ -1417,10 +1428,9 @@ mpt_attach(struct pci_dev *pdev, const s
 }
 
 /*=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
-/*
+/**
  *	mpt_detach - Remove a PCI intelligent MPT adapter.
  *	@pdev: Pointer to pci_dev structure
- *
  */
 
 void
@@ -1466,10 +1476,10 @@ mpt_detach(struct pci_dev *pdev)
  */
 #ifdef CONFIG_PM
 /*=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
-/*
+/**
  *	mpt_suspend - Fusion MPT base driver suspend routine.
- *
- *
+ *	@pdev: Pointer to pci_dev structure
+ *	@state: new state to enter
  */
 int
 mpt_suspend(struct pci_dev *pdev, pm_message_t state)
@@ -1505,10 +1515,9 @@ mpt_suspend(struct pci_dev *pdev, pm_mes
 }
 
 /*=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
-/*
+/**
  *	mpt_resume - Fusion MPT base driver resume routine.
- *
- *
+ *	@pdev: Pointer to pci_dev structure
  */
 int
 mpt_resume(struct pci_dev *pdev)
@@ -1566,7 +1575,7 @@ mpt_signal_reset(int index, MPT_ADAPTER 
 }
 
 /*=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
-/*
+/**
  *	mpt_do_ioc_recovery - Initialize or recover MPT adapter.
  *	@ioc: Pointer to MPT adapter structure
  *	@reason: Event word / reason
@@ -1892,13 +1901,15 @@ mpt_do_ioc_recovery(MPT_ADAPTER *ioc, u3
 }
 
 /*=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
-/*
- *	mpt_detect_bound_ports - Search for PCI bus/dev_function
- *	which matches PCI bus/dev_function (+/-1) for newly discovered 929,
- *	929X, 1030 or 1035.
+/**
+ *	mpt_detect_bound_ports - Search for matching PCI bus/dev_function
  *	@ioc: Pointer to MPT adapter structure
  *	@pdev: Pointer to (struct pci_dev) structure
  *
+ *	Search for PCI bus/dev_function which matches
+ *	PCI bus/dev_function (+/-1) for newly discovered 929,
+ *	929X, 1030 or 1035.
+ *
  *	If match on PCI dev_function +/-1 is found, bind the two MPT adapters
  *	using alt_ioc pointer fields in their %MPT_ADAPTER structures.
  */
@@ -1945,9 +1956,9 @@ mpt_detect_bound_ports(MPT_ADAPTER *ioc,
 }
 
 /*=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
-/*
+/**
  *	mpt_adapter_disable - Disable misbehaving MPT adapter.
- *	@this: Pointer to MPT adapter structure
+ *	@ioc: Pointer to MPT adapter structure
  */
 static void
 mpt_adapter_disable(MPT_ADAPTER *ioc)
@@ -2046,9 +2057,8 @@ mpt_adapter_disable(MPT_ADAPTER *ioc)
 }
 
 /*=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
-/*
- *	mpt_adapter_dispose - Free all resources associated with a MPT
- *	adapter.
+/**
+ *	mpt_adapter_dispose - Free all resources associated with an MPT adapter
  *	@ioc: Pointer to MPT adapter structure
  *
  *	This routine unregisters h/w resources and frees all alloc'd memory
@@ -2099,8 +2109,8 @@ mpt_adapter_dispose(MPT_ADAPTER *ioc)
 }
 
 /*=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
-/*
- *	MptDisplayIocCapabilities - Disply IOC's capacilities.
+/**
+ *	MptDisplayIocCapabilities - Disply IOC's capabilities.
  *	@ioc: Pointer to MPT adapter structure
  */
 static void
@@ -2142,7 +2152,7 @@ MptDisplayIocCapabilities(MPT_ADAPTER *i
 }
 
 /*=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
-/*
+/**
  *	MakeIocReady - Get IOC to a READY state, using KickStart if needed.
  *	@ioc: Pointer to MPT_ADAPTER structure
  *	@force: Force hard KickStart of IOC
@@ -2279,7 +2289,7 @@ MakeIocReady(MPT_ADAPTER *ioc, int force
 }
 
 /*=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
-/*
+/**
  *	mpt_GetIocState - Get the current state of a MPT adapter.
  *	@ioc: Pointer to MPT_ADAPTER structure
  *	@cooked: Request raw or cooked IOC state
@@ -2304,7 +2314,7 @@ mpt_GetIocState(MPT_ADAPTER *ioc, int co
 }
 
 /*=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
-/*
+/**
  *	GetIocFacts - Send IOCFacts request to MPT adapter.
  *	@ioc: Pointer to MPT_ADAPTER structure
  *	@sleepFlag: Specifies whether the process can sleep
@@ -2478,7 +2488,7 @@ GetIocFacts(MPT_ADAPTER *ioc, int sleepF
 }
 
 /*=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
-/*
+/**
  *	GetPortFacts - Send PortFacts request to MPT adapter.
  *	@ioc: Pointer to MPT_ADAPTER structure
  *	@portnum: Port number
@@ -2545,7 +2555,7 @@ GetPortFacts(MPT_ADAPTER *ioc, int portn
 }
 
 /*=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
-/*
+/**
  *	SendIocInit - Send IOCInit request to MPT adapter.
  *	@ioc: Pointer to MPT_ADAPTER structure
  *	@sleepFlag: Specifies whether the process can sleep
@@ -2630,7 +2640,7 @@ SendIocInit(MPT_ADAPTER *ioc, int sleepF
 	}
 
 	/* No need to byte swap the multibyte fields in the reply
-	 * since we don't even look at it's contents.
+	 * since we don't even look at its contents.
 	 */
 
 	dhsprintk((MYIOC_s_INFO_FMT "Sending PortEnable (req @ %p)\n",
@@ -2672,7 +2682,7 @@ SendIocInit(MPT_ADAPTER *ioc, int sleepF
 }
 
 /*=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
-/*
+/**
  *	SendPortEnable - Send PortEnable request to MPT adapter port.
  *	@ioc: Pointer to MPT_ADAPTER structure
  *	@portnum: Port number to enable
@@ -2723,9 +2733,13 @@ SendPortEnable(MPT_ADAPTER *ioc, int por
 	return rc;
 }
 
-/*
- *	ioc: Pointer to MPT_ADAPTER structure
- *      size - total FW bytes
+/**
+ *	mpt_alloc_fw_memory - allocate firmware memory
+ *	@ioc: Pointer to MPT_ADAPTER structure
+ *      @size: total FW bytes
+ *
+ *	If memory has already been allocated, the same (cached) value
+ *	is returned.
  */
 void
 mpt_alloc_fw_memory(MPT_ADAPTER *ioc, int size)
@@ -2742,9 +2756,12 @@ mpt_alloc_fw_memory(MPT_ADAPTER *ioc, in
 			ioc->alloc_total += size;
 	}
 }
-/*
- * If alt_img is NULL, delete from ioc structure.
- * Else, delete a secondary image in same format.
+/**
+ *	mpt_free_fw_memory - free firmware memory
+ *	@ioc: Pointer to MPT_ADAPTER structure
+ *
+ *	If alt_img is NULL, delete from ioc structure.
+ *	Else, delete a secondary image in same format.
  */
 void
 mpt_free_fw_memory(MPT_ADAPTER *ioc)
@@ -2763,7 +2780,7 @@ mpt_free_fw_memory(MPT_ADAPTER *ioc)
 
 
 /*=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
-/*
+/**
  *	mpt_do_upload - Construct and Send FWUpload request to MPT adapter port.
  *	@ioc: Pointer to MPT_ADAPTER structure
  *	@sleepFlag: Specifies whether the process can sleep
@@ -2865,10 +2882,10 @@ mpt_do_upload(MPT_ADAPTER *ioc, int slee
 }
 
 /*=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
-/*
+/**
  *	mpt_downloadboot - DownloadBoot code
  *	@ioc: Pointer to MPT_ADAPTER structure
- *	@flag: Specify which part of IOC memory is to be uploaded.
+ *	@pFwHeader: Pointer to firmware header info
  *	@sleepFlag: Specifies whether the process can sleep
  *
  *	FwDownloadBoot requires Programmed IO access.
@@ -3071,7 +3088,7 @@ mpt_downloadboot(MPT_ADAPTER *ioc, MpiFw
 }
 
 /*=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
-/*
+/**
  *	KickStart - Perform hard reset of MPT adapter.
  *	@ioc: Pointer to MPT_ADAPTER structure
  *	@force: Force hard reset
@@ -3145,12 +3162,12 @@ KickStart(MPT_ADAPTER *ioc, int force, i
 }
 
 /*=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
-/*
+/**
  *	mpt_diag_reset - Perform hard reset of the adapter.
  *	@ioc: Pointer to MPT_ADAPTER structure
  *	@ignore: Set if to honor and clear to ignore
  *		the reset history bit
- *	@sleepflag: CAN_SLEEP if called in a non-interrupt thread,
+ *	@sleepFlag: CAN_SLEEP if called in a non-interrupt thread,
  *		else set to NO_SLEEP (use mdelay instead)
  *
  *	This routine places the adapter in diagnostic mode via the
@@ -3436,11 +3453,12 @@ mpt_diag_reset(MPT_ADAPTER *ioc, int ign
 }
 
 /*=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
-/*
+/**
  *	SendIocReset - Send IOCReset request to MPT adapter.
  *	@ioc: Pointer to MPT_ADAPTER structure
  *	@reset_type: reset type, expected values are
  *	%MPI_FUNCTION_IOC_MESSAGE_UNIT_RESET or %MPI_FUNCTION_IO_UNIT_RESET
+ *	@sleepFlag: Specifies whether the process can sleep
  *
  *	Send IOCReset request to the MPT adapter.
  *
@@ -3494,11 +3512,12 @@ SendIocReset(MPT_ADAPTER *ioc, u8 reset_
 }
 
 /*=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
-/*
- *	initChainBuffers - Allocate memory for and initialize
- *	chain buffers, chain buffer control arrays and spinlock.
- *	@hd: Pointer to MPT_SCSI_HOST structure
- *	@init: If set, initialize the spin lock.
+/**
+ *	initChainBuffers - Allocate memory for and initialize chain buffers
+ *	@ioc: Pointer to MPT_ADAPTER structure
+ *
+ *	Allocates memory for and initializes chain buffers,
+ *	chain buffer control arrays and spinlock.
  */
 static int
 initChainBuffers(MPT_ADAPTER *ioc)
@@ -3594,7 +3613,7 @@ initChainBuffers(MPT_ADAPTER *ioc)
 }
 
 /*=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
-/*
+/**
  *	PrimeIocFifos - Initialize IOC request and reply FIFOs.
  *	@ioc: Pointer to MPT_ADAPTER structure
  *
@@ -3891,15 +3910,15 @@ mpt_handshake_req_reply_wait(MPT_ADAPTER
 }
 
 /*=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
-/*
- *	WaitForDoorbellAck - Wait for IOC to clear the IOP_DOORBELL_STATUS bit
- *	in it's IntStatus register.
+/**
+ *	WaitForDoorbellAck - Wait for IOC doorbell handshake acknowledge
  *	@ioc: Pointer to MPT_ADAPTER structure
  *	@howlong: How long to wait (in seconds)
  *	@sleepFlag: Specifies whether the process can sleep
  *
  *	This routine waits (up to ~2 seconds max) for IOC doorbell
- *	handshake ACKnowledge.
+ *	handshake ACKnowledge, indicated by the IOP_DOORBELL_STATUS
+ *	bit in its IntStatus register being clear.
  *
  *	Returns a negative value on failure, else wait loop count.
  */
@@ -3942,14 +3961,14 @@ WaitForDoorbellAck(MPT_ADAPTER *ioc, int
 }
 
 /*=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
-/*
- *	WaitForDoorbellInt - Wait for IOC to set the HIS_DOORBELL_INTERRUPT bit
- *	in it's IntStatus register.
+/**
+ *	WaitForDoorbellInt - Wait for IOC to set its doorbell interrupt bit
  *	@ioc: Pointer to MPT_ADAPTER structure
  *	@howlong: How long to wait (in seconds)
  *	@sleepFlag: Specifies whether the process can sleep
  *
- *	This routine waits (up to ~2 seconds max) for IOC doorbell interrupt.
+ *	This routine waits (up to ~2 seconds max) for IOC doorbell interrupt
+ *	(MPI_HIS_DOORBELL_INTERRUPT) to be set in the IntStatus register.
  *
  *	Returns a negative value on failure, else wait loop count.
  */
@@ -3991,8 +4010,8 @@ WaitForDoorbellInt(MPT_ADAPTER *ioc, int
 }
 
 /*=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
-/*
- *	WaitForDoorbellReply - Wait for and capture a IOC handshake reply.
+/**
+ *	WaitForDoorbellReply - Wait for and capture an IOC handshake reply.
  *	@ioc: Pointer to MPT_ADAPTER structure
  *	@howlong: How long to wait (in seconds)
  *	@sleepFlag: Specifies whether the process can sleep
@@ -4077,7 +4096,7 @@ WaitForDoorbellReply(MPT_ADAPTER *ioc, i
 }
 
 /*=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
-/*
+/**
  *	GetLanConfigPages - Fetch LANConfig pages.
  *	@ioc: Pointer to MPT_ADAPTER structure
  *
@@ -4188,12 +4207,9 @@ GetLanConfigPages(MPT_ADAPTER *ioc)
 }
 
 /*=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
-/*
- *	mptbase_sas_persist_operation - Perform operation on SAS Persitent Table
+/**
+ *	mptbase_sas_persist_operation - Perform operation on SAS Persistent Table
  *	@ioc: Pointer to MPT_ADAPTER structure
- *	@sas_address: 64bit SAS Address for operation.
- *	@target_id: specified target for operation
- *	@bus: specified bus for operation
  *	@persist_opcode: see below
  *
  *	MPI_SAS_OP_CLEAR_NOT_PRESENT - Free all persist TargetID mappings for
@@ -4202,7 +4218,7 @@ GetLanConfigPages(MPT_ADAPTER *ioc)
  *
  *	NOTE: Don't use not this function during interrupt time.
  *
- *	Returns: 0 for success, non-zero error
+ *	Returns 0 for success, non-zero error
  */
 
 /*=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
@@ -4399,7 +4415,7 @@ mptbase_raid_process_event_data(MPT_ADAP
 }
 
 /*=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
-/*
+/**
  *	GetIoUnitPage2 - Retrieve BIOS version and boot order information.
  *	@ioc: Pointer to MPT_ADAPTER structure
  *
@@ -4457,7 +4473,8 @@ GetIoUnitPage2(MPT_ADAPTER *ioc)
 }
 
 /*=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
-/*	mpt_GetScsiPortSettings - read SCSI Port Page 0 and 2
+/**
+ *	mpt_GetScsiPortSettings - read SCSI Port Page 0 and 2
  *	@ioc: Pointer to a Adapter Strucutre
  *	@portnum: IOC port number
  *
@@ -4644,7 +4661,8 @@ mpt_GetScsiPortSettings(MPT_ADAPTER *ioc
 }
 
 /*=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
-/*	mpt_readScsiDevicePageHeaders - save version and length of SDP1
+/**
+ *	mpt_readScsiDevicePageHeaders - save version and length of SDP1
  *	@ioc: Pointer to a Adapter Strucutre
  *	@portnum: IOC port number
  *
@@ -4996,9 +5014,8 @@ mpt_read_ioc_pg_1(MPT_ADAPTER *ioc)
 }
 
 /*=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
-/*
- *	SendEventNotification - Send EventNotification (on or off) request
- *	to MPT adapter.
+/**
+ *	SendEventNotification - Send EventNotification (on or off) request to adapter
  *	@ioc: Pointer to MPT_ADAPTER structure
  *	@EvSwitch: Event switch flags
  */
@@ -5062,8 +5079,8 @@ SendEventAck(MPT_ADAPTER *ioc, EventNoti
 /*=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
 /**
  *	mpt_config - Generic function to issue config message
- *	@ioc - Pointer to an adapter structure
- *	@cfg - Pointer to a configuration structure. Struct contains
+ *	@ioc:   Pointer to an adapter structure
+ *	@pCfg:  Pointer to a configuration structure. Struct contains
  *		action, page address, direction, physical address
  *		and pointer to a configuration page header
  *		Page header is updated.
@@ -5188,8 +5205,8 @@ mpt_config(MPT_ADAPTER *ioc, CONFIGPARMS
 }
 
 /*=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
-/*
- *	mpt_timer_expired - Call back for timer process.
+/**
+ *	mpt_timer_expired - Callback for timer process.
  *	Used only internal config functionality.
  *	@data: Pointer to MPT_SCSI_HOST recast as an unsigned long
  */
@@ -5214,12 +5231,12 @@ mpt_timer_expired(unsigned long data)
 }
 
 /*=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
-/*
+/**
  *	mpt_ioc_reset - Base cleanup for hard reset
  *	@ioc: Pointer to the adapter structure
  *	@reset_phase: Indicates pre- or post-reset functionality
  *
- *	Remark: Free's resources with internally generated commands.
+ *	Remark: Frees resources with internally generated commands.
  */
 static int
 mpt_ioc_reset(MPT_ADAPTER *ioc, int reset_phase)
@@ -5271,7 +5288,7 @@ mpt_ioc_reset(MPT_ADAPTER *ioc, int rese
  *	procfs (%MPT_PROCFS_MPTBASEDIR/...) support stuff...
  */
 /*=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
-/*
+/**
  *	procmpt_create - Create %MPT_PROCFS_MPTBASEDIR entries.
  *
  *	Returns 0 for success, non-zero for failure.
@@ -5297,7 +5314,7 @@ procmpt_create(void)
 }
 
 /*=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
-/*
+/**
  *	procmpt_destroy - Tear down %MPT_PROCFS_MPTBASEDIR entries.
  *
  *	Returns 0 for success, non-zero for failure.
@@ -5311,16 +5328,16 @@ procmpt_destroy(void)
 }
 
 /*=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
-/*
- *	procmpt_summary_read - Handle read request from /proc/mpt/summary
- *	or from /proc/mpt/iocN/summary.
+/**
+ *	procmpt_summary_read - Handle read request of a summary file
  *	@buf: Pointer to area to write information
  *	@start: Pointer to start pointer
  *	@offset: Offset to start writing
- *	@request:
+ *	@request: Amount of read data requested
  *	@eof: Pointer to EOF integer
  *	@data: Pointer
  *
+ *	Handles read request from /proc/mpt/summary or /proc/mpt/iocN/summary.
  *	Returns number of characters written to process performing the read.
  */
 static int
@@ -5355,12 +5372,12 @@ procmpt_summary_read(char *buf, char **s
 }
 
 /*=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
-/*
+/**
  *	procmpt_version_read - Handle read request from /proc/mpt/version.
  *	@buf: Pointer to area to write information
  *	@start: Pointer to start pointer
  *	@offset: Offset to start writing
- *	@request:
+ *	@request: Amount of read data requested
  *	@eof: Pointer to EOF integer
  *	@data: Pointer
  *
@@ -5411,12 +5428,12 @@ procmpt_version_read(char *buf, char **s
 }
 
 /*=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
-/*
+/**
  *	procmpt_iocinfo_read - Handle read request from /proc/mpt/iocN/info.
  *	@buf: Pointer to area to write information
  *	@start: Pointer to start pointer
  *	@offset: Offset to start writing
- *	@request:
+ *	@request: Amount of read data requested
  *	@eof: Pointer to EOF integer
  *	@data: Pointer
  *
@@ -5577,16 +5594,17 @@ mpt_print_ioc_summary(MPT_ADAPTER *ioc, 
  */
 /*=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
 /**
- *	mpt_HardResetHandler - Generic reset handler, issue SCSI Task
- *	Management call based on input arg values.  If TaskMgmt fails,
- *	return associated SCSI request.
+ *	mpt_HardResetHandler - Generic reset handler
  *	@ioc: Pointer to MPT_ADAPTER structure
  *	@sleepFlag: Indicates if sleep or schedule must be called.
  *
+ *	Issues SCSI Task Management call based on input arg values.
+ *	If TaskMgmt fails, returns associated SCSI request.
+ *
  *	Remark: _HardResetHandler can be invoked from an interrupt thread (timer)
  *	or a non-interrupt thread.  In the former, must not call schedule().
  *
- *	Remark: A return of -1 is a FATAL error case, as it means a
+ *	Note: A return of -1 is a FATAL error case, as it means a
  *	FW reload/initialization failed.
  *
  *	Returns 0 for SUCCESS or -1 if FAILED.
@@ -5935,13 +5953,14 @@ EventDescriptionStr(u8 event, u32 evData
 }
 
 /*=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
-/*
- *	ProcessEventNotification - Route a received EventNotificationReply to
- *	all currently regeistered event handlers.
+/**
+ *	ProcessEventNotification - Route EventNotificationReply to all event handlers
  *	@ioc: Pointer to MPT_ADAPTER structure
  *	@pEventReply: Pointer to EventNotification reply frame
  *	@evHandlers: Pointer to integer, number of event handlers
  *
+ *	Routes a received EventNotificationReply to all currently registered
+ *	event handlers.
  *	Returns sum of event handlers return values.
  */
 static int
@@ -6056,7 +6075,7 @@ ProcessEventNotification(MPT_ADAPTER *io
 }
 
 /*=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
-/*
+/**
  *	mpt_fc_log_info - Log information returned from Fibre Channel IOC.
  *	@ioc: Pointer to MPT_ADAPTER structure
  *	@log_info: U32 LogInfo reply word from the IOC
@@ -6077,7 +6096,7 @@ mpt_fc_log_info(MPT_ADAPTER *ioc, u32 lo
 }
 
 /*=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
-/*
+/**
  *	mpt_spi_log_info - Log information returned from SCSI Parallel IOC.
  *	@ioc: Pointer to MPT_ADAPTER structure
  *	@mr: Pointer to MPT reply frame
@@ -6200,7 +6219,7 @@ mpt_spi_log_info(MPT_ADAPTER *ioc, u32 l
 	};
 
 /*=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
-/*
+/**
  *	mpt_sas_log_info - Log information returned from SAS IOC.
  *	@ioc: Pointer to MPT_ADAPTER structure
  *	@log_info: U32 LogInfo reply word from the IOC
@@ -6255,7 +6274,7 @@ union loginfo_type {
 }
 
 /*=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
-/*
+/**
  *	mpt_sp_ioc_info - IOC information returned from SCSI Parallel IOC.
  *	@ioc: Pointer to MPT_ADAPTER structure
  *	@ioc_status: U32 IOCStatus word from IOC
@@ -6416,7 +6435,7 @@ EXPORT_SYMBOL(mpt_free_fw_memory);
 EXPORT_SYMBOL(mptbase_sas_persist_operation);
 
 /*=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
-/*
+/**
  *	fusion_init - Fusion MPT base driver initialization routine.
  *
  *	Returns 0 for success, non-zero for failure.
@@ -6456,7 +6475,7 @@ fusion_init(void)
 }
 
 /*=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
-/*
+/**
  *	fusion_exit - Perform driver unload cleanup.
  *
  *	This routine frees all resources associated with each MPT adapter
--- linux-2619-rc6g4.orig/drivers/message/fusion/mptscsih.c
+++ linux-2619-rc6g4/drivers/message/fusion/mptscsih.c
@@ -1230,15 +1230,15 @@ mptscsih_host_info(MPT_ADAPTER *ioc, cha
 /*=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
 /**
  *	mptscsih_proc_info - Return information about MPT adapter
+ * 	@host:   scsi host struct
+ * 	@buffer: if write, user data; if read, buffer for user
+ *	@start: returns the buffer address
+ * 	@offset: if write, 0; if read, the current offset into the buffer from
+ * 		 the previous read.
+ * 	@length: if write, return length;
+ *	@func:   write = 1; read = 0
  *
  *	(linux scsi_host_template.info routine)
- *
- * 	buffer: if write, user data; if read, buffer for user
- * 	length: if write, return length;
- * 	offset: if write, 0; if read, the current offset into the buffer from
- * 		the previous read.
- * 	hostno: scsi host number
- *	func:   if write = 1; if read = 0
  */
 int
 mptscsih_proc_info(struct Scsi_Host *host, char *buffer, char **start, off_t offset,
@@ -1902,8 +1902,7 @@ mptscsih_bus_reset(struct scsi_cmnd * SC
 
 /*=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
 /**
- *	mptscsih_host_reset - Perform a SCSI host adapter RESET!
- *	new_eh variant
+ *	mptscsih_host_reset - Perform a SCSI host adapter RESET (new_eh variant)
  *	@SCpnt: Pointer to scsi_cmnd structure, IO which reset is due to
  *
  *	(linux scsi_host_template.eh_host_reset_handler routine)
@@ -1949,8 +1948,7 @@ mptscsih_host_reset(struct scsi_cmnd *SC
 
 /*=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
 /**
- *	mptscsih_tm_pending_wait - wait for pending task management request to
- *		complete.
+ *	mptscsih_tm_pending_wait - wait for pending task management request to complete
  *	@hd: Pointer to MPT host structure.
  *
  *	Returns {SUCCESS,FAILED}.
@@ -1982,6 +1980,7 @@ mptscsih_tm_pending_wait(MPT_SCSI_HOST *
 /**
  *	mptscsih_tm_wait_for_completion - wait for completion of TM task
  *	@hd: Pointer to MPT host structure.
+ *	@timeout: timeout in seconds
  *
  *	Returns {SUCCESS,FAILED}.
  */
@@ -3429,8 +3428,7 @@ mptscsih_do_cmd(MPT_SCSI_HOST *hd, INTER
 /**
  *	mptscsih_synchronize_cache - Send SYNCHRONIZE_CACHE to all disks.
  *	@hd: Pointer to a SCSI HOST structure
- *	@vtarget: per device private data
- *	@lun: lun
+ *	@vdevice: virtual target device
  *
  *	Uses the ISR, but with special processing.
  *	MUST be single-threaded.
--- linux-2619-rc6g4.orig/drivers/message/fusion/mptspi.c
+++ linux-2619-rc6g4/drivers/message/fusion/mptspi.c
@@ -1098,8 +1098,7 @@ static struct pci_driver mptspi_driver =
 
 /*=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
 /**
- *	mptspi_init - Register MPT adapter(s) as SCSI host(s) with
- *	linux scsi mid-layer.
+ *	mptspi_init - Register MPT adapter(s) as SCSI host(s) with SCSI mid-layer.
  *
  *	Returns 0 for success, non-zero for failure.
  */
@@ -1133,7 +1132,6 @@ mptspi_init(void)
 /*=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
 /**
  *	mptspi_exit - Unregisters MPT adapter(s)
- *
  */
 static void __exit
 mptspi_exit(void)
--- linux-2619-rc6g4.orig/drivers/message/fusion/mptfc.c
+++ linux-2619-rc6g4/drivers/message/fusion/mptfc.c
@@ -1393,8 +1393,7 @@ mptfc_ioc_reset(MPT_ADAPTER *ioc, int re
 
 /*=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
 /**
- *	mptfc_init - Register MPT adapter(s) as SCSI host(s) with
- *	linux scsi mid-layer.
+ *	mptfc_init - Register MPT adapter(s) as SCSI host(s) with SCSI mid-layer.
  *
  *	Returns 0 for success, non-zero for failure.
  */
@@ -1438,7 +1437,7 @@ mptfc_init(void)
 
 /*=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
 /**
- *	mptfc_remove - Removed fc infrastructure for devices
+ *	mptfc_remove - Remove fc infrastructure for devices
  *	@pdev: Pointer to pci_dev structure
  *
  */
--- linux-2619-rc6g4.orig/drivers/message/i2o/i2o_scsi.c
+++ linux-2619-rc6g4/drivers/message/i2o/i2o_scsi.c
@@ -405,8 +405,7 @@ static void i2o_scsi_notify_device_add(s
 };
 
 /**
- *	i2o_scsi_notify_device_remove - Retrieve notifications of removed
- *				        devices
+ *	i2o_scsi_notify_device_remove - Retrieve notifications of removed devices
  *	@i2o_dev: the I2O device which was removed
  *
  *	If a I2O device is removed, we catch the notification to remove the
@@ -426,8 +425,7 @@ static void i2o_scsi_notify_device_remov
 };
 
 /**
- *	i2o_scsi_notify_controller_add - Retrieve notifications of added
- *					 controllers
+ *	i2o_scsi_notify_controller_add - Retrieve notifications of added controllers
  *	@c: the controller which was added
  *
  *	If a I2O controller is added, we catch the notification to add a
@@ -457,8 +455,7 @@ static void i2o_scsi_notify_controller_a
 };
 
 /**
- *	i2o_scsi_notify_controller_remove - Retrieve notifications of removed
- *					    controllers
+ *	i2o_scsi_notify_controller_remove - Retrieve notifications of removed controllers
  *	@c: the controller which was removed
  *
  *	If a I2O controller is removed, we catch the notification to remove the
@@ -745,7 +742,7 @@ static int i2o_scsi_abort(struct scsi_cm
  *	@capacity: size in sectors
  *	@ip: geometry array
  *
- *	This is anyones guess quite frankly. We use the same rules everyone
+ *	This is anyone's guess quite frankly. We use the same rules everyone
  *	else appears to and hope. It seems to work.
  */
 
--- linux-2619-rc6g4.orig/drivers/message/i2o/i2o_proc.c
+++ linux-2619-rc6g4/drivers/message/i2o/i2o_proc.c
@@ -163,7 +163,7 @@ static int print_serial_number(struct se
  *	i2o_get_class_name - 	do i2o class name lookup
  *	@class: class number
  *
- *	Return a descriptive string for an i2o class
+ *	Return a descriptive string for an i2o class.
  */
 static const char *i2o_get_class_name(int class)
 {


---
