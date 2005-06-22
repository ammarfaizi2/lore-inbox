Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262742AbVFVFRb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262742AbVFVFRb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 01:17:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262760AbVFVFR3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 01:17:29 -0400
Received: from mail.kroah.org ([69.55.234.183]:32663 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262742AbVFVFMO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 01:12:14 -0400
Cc: johnpol@2ka.mipt.ru
Subject: [PATCH] w1: Added the triplet w1 master method and changes w1_search() to use it.
In-Reply-To: <1119417127917@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 21 Jun 2005 22:12:07 -0700
Message-Id: <11194171271795@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] w1: Added the triplet w1 master method and changes w1_search() to use it.

Adds the triplet w1 master method and changes w1_search() to use it.

Signed-off-by: Ben Gardner <bgardner@wabtec.com>
Signed-off-by: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 6b729861831177b270a2932a13e79cb41d673146
tree 443c86578d04ba42d9b4e483d6ebee91ba30d25e
parent be57ce267fd558c52d2389530c15618681b7cfa7
author Evgeniy Polyakov <johnpol@2ka.mipt.ru> Sat, 04 Jun 2005 01:30:43 +0400
committer Greg Kroah-Hartman <gregkh@suse.de> Tue, 21 Jun 2005 21:43:11 -0700

 drivers/w1/w1.c    |  144 +++++++++++++++++++++++++---------------------------
 drivers/w1/w1.h    |   83 +++++++++++++++++++++++-------
 drivers/w1/w1_io.c |   43 +++++++++++++++-
 drivers/w1/w1_io.h |    1 
 4 files changed, 176 insertions(+), 95 deletions(-)

diff --git a/drivers/w1/w1.c b/drivers/w1/w1.c
--- a/drivers/w1/w1.c
+++ b/drivers/w1/w1.c
@@ -135,7 +135,7 @@ struct device w1_device = {
 
 static ssize_t w1_master_attribute_show_name(struct device *dev, struct device_attribute *attr, char *buf)
 {
-	struct w1_master *md = container_of (dev, struct w1_master, dev);
+	struct w1_master *md = container_of(dev, struct w1_master, dev);
 	ssize_t count;
 
 	if (down_interruptible (&md->mutex))
@@ -212,7 +212,6 @@ static ssize_t w1_master_attribute_show_
 }
 
 static ssize_t w1_master_attribute_show_slaves(struct device *dev, struct device_attribute *attr, char *buf)
-
 {
 	struct w1_master *md = container_of(dev, struct w1_master, dev);
 	int c = PAGE_SIZE;
@@ -286,13 +285,13 @@ static int __w1_attach_slave_device(stru
 	sl->dev.release = &w1_slave_release;
 
 	snprintf(&sl->dev.bus_id[0], sizeof(sl->dev.bus_id),
-		  "%02x-%012llx",
-		  (unsigned int) sl->reg_num.family,
-		  (unsigned long long) sl->reg_num.id);
-	snprintf (&sl->name[0], sizeof(sl->name),
-		  "%02x-%012llx",
-		  (unsigned int) sl->reg_num.family,
-		  (unsigned long long) sl->reg_num.id);
+		 "%02x-%012llx",
+		 (unsigned int) sl->reg_num.family,
+		 (unsigned long long) sl->reg_num.id);
+	snprintf(&sl->name[0], sizeof(sl->name),
+		 "%02x-%012llx",
+		 (unsigned int) sl->reg_num.family,
+		 (unsigned long long) sl->reg_num.id);
 
 	dev_dbg(&sl->dev, "%s: registering %s.\n", __func__,
 		&sl->dev.bus_id[0]);
@@ -300,8 +299,8 @@ static int __w1_attach_slave_device(stru
 	err = device_register(&sl->dev);
 	if (err < 0) {
 		dev_err(&sl->dev,
-			 "Device registration [%s] failed. err=%d\n",
-			 sl->dev.bus_id, err);
+			"Device registration [%s] failed. err=%d\n",
+			sl->dev.bus_id, err);
 		return err;
 	}
 
@@ -314,8 +313,8 @@ static int __w1_attach_slave_device(stru
 	err = device_create_file(&sl->dev, &sl->attr_name);
 	if (err < 0) {
 		dev_err(&sl->dev,
-			 "sysfs file creation for [%s] failed. err=%d\n",
-			 sl->dev.bus_id, err);
+			"sysfs file creation for [%s] failed. err=%d\n",
+			sl->dev.bus_id, err);
 		device_unregister(&sl->dev);
 		return err;
 	}
@@ -323,8 +322,8 @@ static int __w1_attach_slave_device(stru
 	err = sysfs_create_bin_file(&sl->dev.kobj, &sl->attr_bin);
 	if (err < 0) {
 		dev_err(&sl->dev,
-			 "sysfs file creation for [%s] failed. err=%d\n",
-			 sl->dev.bus_id, err);
+			"sysfs file creation for [%s] failed. err=%d\n",
+			sl->dev.bus_id, err);
 		device_remove_file(&sl->dev, &sl->attr_name);
 		device_unregister(&sl->dev);
 		return err;
@@ -483,26 +482,39 @@ static void w1_slave_found(unsigned long
 	atomic_dec(&dev->refcnt);
 }
 
-void w1_search(struct w1_master *dev)
-{
-	u64 last, rn, tmp;
-	int i, count = 0;
-	int last_family_desc, last_zero, last_device;
-	int search_bit, id_bit, comp_bit, desc_bit;
-
-	search_bit = id_bit = comp_bit = 0;
-	rn = tmp = last = 0;
-	last_device = last_zero = last_family_desc = 0;
+/**
+ * Performs a ROM Search & registers any devices found.
+ * The 1-wire search is a simple binary tree search.
+ * For each bit of the address, we read two bits and write one bit.
+ * The bit written will put to sleep all devies that don't match that bit.
+ * When the two reads differ, the direction choice is obvious.
+ * When both bits are 0, we must choose a path to take.
+ * When we can scan all 64 bits without having to choose a path, we are done.
+ *
+ * See "Application note 187 1-wire search algorithm" at www.maxim-ic.com
+ *
+ * @dev        The master device to search
+ * @cb         Function to call when a device is found
+ */
+void w1_search(struct w1_master *dev, w1_slave_found_callback cb)
+{
+	u64 last_rn, rn, tmp64;
+	int i, slave_count = 0;
+	int last_zero, last_device;
+	int search_bit, desc_bit;
+	u8  triplet_ret = 0;
+
+	search_bit = 0;
+	rn = last_rn = 0;
+	last_device = 0;
+	last_zero = -1;
 
 	desc_bit = 64;
 
-	while (!(id_bit && comp_bit) && !last_device &&
-	       count++ < dev->max_slave_count) {
-		last = rn;
+	while ( !last_device && (slave_count++ < dev->max_slave_count) ) {
+		last_rn = rn;
 		rn = 0;
 
-		last_family_desc = 0;
-
 		/*
 		 * Reset bus and all 1-wire device state machines
 		 * so they can respond to our requests.
@@ -514,59 +526,39 @@ void w1_search(struct w1_master *dev)
 			break;
 		}
 
-#if 1
+		/* Start the search */
 		w1_write_8(dev, W1_SEARCH);
 		for (i = 0; i < 64; ++i) {
-			/*
-			 * Read 2 bits from bus.
-			 * All who don't sleep must send ID bit and COMPLEMENT ID bit.
-			 * They actually are ANDed between all senders.
-			 */
-			id_bit = w1_touch_bit(dev, 1);
-			comp_bit = w1_touch_bit(dev, 1);
-
-			if (id_bit && comp_bit)
-				break;
-
-			if (id_bit == 0 && comp_bit == 0) {
-				if (i == desc_bit)
-					search_bit = 1;
-				else if (i > desc_bit)
-					search_bit = 0;
-				else
-					search_bit = ((last >> i) & 0x1);
-
-				if (search_bit == 0) {
-					last_zero = i;
-					if (last_zero < 9)
-						last_family_desc = last_zero;
-				}
-
-			} else
-				search_bit = id_bit;
-
-			tmp = search_bit;
-			rn |= (tmp << i);
-
-			/*
-			 * Write 1 bit to bus
-			 * and make all who don't have "search_bit" in "i"'th position
-			 * in it's registration number sleep.
-			 */
-			if (dev->bus_master->touch_bit)
-				w1_touch_bit(dev, search_bit);
+			/* Determine the direction/search bit */
+			if (i == desc_bit)
+				search_bit = 1;	  /* took the 0 path last time, so take the 1 path */
+			else if (i > desc_bit)
+				search_bit = 0;	  /* take the 0 path on the next branch */
 			else
-				w1_write_bit(dev, search_bit);
+				search_bit = ((last_rn >> i) & 0x1);
 
-		}
-#endif
+			/** Read two bits and write one bit */
+			triplet_ret = w1_triplet(dev, search_bit);
 
-		if (desc_bit == last_zero)
-			last_device = 1;
+			/* quit if no device responded */
+			if ( (triplet_ret & 0x03) == 0x03 )
+				break;
 
-		desc_bit = last_zero;
+			/* If both directions were valid, and we took the 0 path... */
+			if (triplet_ret == 0)
+				last_zero = i;
+
+			/* extract the direction taken & update the device number */
+			tmp64 = (triplet_ret >> 2);
+			rn |= (tmp64 << i);
+		}
 
-		w1_slave_found(dev->bus_master->data, rn);
+		if ( (triplet_ret & 0x03) != 0x03 ) {
+			if ( (desc_bit == last_zero) || (last_zero < 0))
+				last_device = 1;
+			desc_bit = last_zero;
+			cb(dev->bus_master->data, rn);
+		}
 	}
 }
 
diff --git a/drivers/w1/w1.h b/drivers/w1/w1.h
--- a/drivers/w1/w1.h
+++ b/drivers/w1/w1.h
@@ -25,9 +25,9 @@
 struct w1_reg_num
 {
 #if defined(__LITTLE_ENDIAN_BITFIELD)
-  	__u64	family:8,
-  		id:48,
-  		crc:8;
+	__u64	family:8,
+		id:48,
+		crc:8;
 #elif defined(__BIG_ENDIAN_BITFIELD)
 	__u64	crc:8,
 		id:48,
@@ -84,24 +84,71 @@ struct w1_slave
 
 typedef void (* w1_slave_found_callback)(unsigned long, u64);
 
+
+/**
+ * Note: read_bit and write_bit are very low level functions and should only
+ * be used with hardware that doesn't really support 1-wire operations,
+ * like a parallel/serial port.
+ * Either define read_bit and write_bit OR define, at minimum, touch_bit and
+ * reset_bus.
+ */
 struct w1_bus_master
 {
-	unsigned long		data;
-
-	u8			(*read_bit)(unsigned long);
-	void			(*write_bit)(unsigned long, u8);
-
-	u8			(*read_byte)(unsigned long);
-	void			(*write_byte)(unsigned long, u8);
-
-	u8			(*read_block)(unsigned long, u8 *, int);
-	void			(*write_block)(unsigned long, u8 *, int);
-
-	u8			(*touch_bit)(unsigned long, u8);
+	/** the first parameter in all the functions below */
+	unsigned long	data;
 
-	u8			(*reset_bus)(unsigned long);
+	/**
+	 * Sample the line level
+	 * @return the level read (0 or 1)
+	 */
+	u8		(*read_bit)(unsigned long);
+
+	/** Sets the line level */
+	void		(*write_bit)(unsigned long, u8);
+
+	/**
+	 * touch_bit is the lowest-level function for devices that really
+	 * support the 1-wire protocol.
+	 * touch_bit(0) = write-0 cycle
+	 * touch_bit(1) = write-1 / read cycle
+	 * @return the bit read (0 or 1)
+	 */
+	u8		(*touch_bit)(unsigned long, u8);
+
+	/**
+	 * Reads a bytes. Same as 8 touch_bit(1) calls.
+	 * @return the byte read
+	 */
+	u8		(*read_byte)(unsigned long);
+
+	/**
+	 * Writes a byte. Same as 8 touch_bit(x) calls.
+	 */
+	void		(*write_byte)(unsigned long, u8);
+
+	/**
+	 * Same as a series of read_byte() calls
+	 * @return the number of bytes read
+	 */
+	u8		(*read_block)(unsigned long, u8 *, int);
+
+	/** Same as a series of write_byte() calls */
+	void		(*write_block)(unsigned long, const u8 *, int);
+
+	/**
+	 * Combines two reads and a smart write for ROM searches
+	 * @return bit0=Id bit1=comp_id bit2=dir_taken
+	 */
+	u8		(*triplet)(unsigned long, u8);
+
+	/**
+	 * long write-0 with a read for the presence pulse detection
+	 * @return -1=Error, 0=Device present, 1=No device present
+	 */
+	u8		(*reset_bus)(unsigned long);
 
-	void			(*search)(unsigned long, w1_slave_found_callback);
+	/** Really nice hardware can handles the ROM searches */
+	void		(*search)(unsigned long, w1_slave_found_callback);
 };
 
 struct w1_master
@@ -137,7 +184,7 @@ struct w1_master
 };
 
 int w1_create_master_attributes(struct w1_master *);
-void w1_search(struct w1_master *dev);
+void w1_search(struct w1_master *dev, w1_slave_found_callback cb);
 
 #endif /* __KERNEL__ */
 
diff --git a/drivers/w1/w1_io.c b/drivers/w1/w1_io.c
--- a/drivers/w1/w1_io.c
+++ b/drivers/w1/w1_io.c
@@ -130,6 +130,47 @@ static u8 w1_read_bit(struct w1_master *
 }
 
 /**
+ * Does a triplet - used for searching ROM addresses.
+ * Return bits:
+ *  bit 0 = id_bit
+ *  bit 1 = comp_bit
+ *  bit 2 = dir_taken
+ * If both bits 0 & 1 are set, the search should be restarted.
+ *
+ * @param dev     the master device
+ * @param bdir    the bit to write if both id_bit and comp_bit are 0
+ * @return        bit fields - see above
+ */
+u8 w1_triplet(struct w1_master *dev, int bdir)
+{
+	if ( dev->bus_master->triplet )
+		return(dev->bus_master->triplet(dev->bus_master->data, bdir));
+	else {
+		u8 id_bit   = w1_touch_bit(dev, 1);
+		u8 comp_bit = w1_touch_bit(dev, 1);
+		u8 retval;
+
+		if ( id_bit && comp_bit )
+			return(0x03);  /* error */
+
+		if ( !id_bit && !comp_bit ) {
+			/* Both bits are valid, take the direction given */
+			retval = bdir ? 0x04 : 0;
+		} else {
+			/* Only one bit is valid, take that direction */
+			bdir = id_bit;
+			retval = id_bit ? 0x05 : 0x02;
+		}
+
+		if ( dev->bus_master->touch_bit )
+			w1_touch_bit(dev, bdir);
+		else
+			w1_write_bit(dev, bdir);
+		return(retval);
+	}
+}
+
+/**
  * Reads 8 bits.
  *
  * @param dev     the master device
@@ -233,7 +274,7 @@ void w1_search_devices(struct w1_master 
 	if (dev->bus_master->search)
 		dev->bus_master->search(dev->bus_master->data, cb);
 	else
-		w1_search(dev);
+		w1_search(dev, cb);
 }
 
 EXPORT_SYMBOL(w1_touch_bit);
diff --git a/drivers/w1/w1_io.h b/drivers/w1/w1_io.h
--- a/drivers/w1/w1_io.h
+++ b/drivers/w1/w1_io.h
@@ -26,6 +26,7 @@
 
 void w1_delay(unsigned long);
 u8 w1_touch_bit(struct w1_master *, int);
+u8 w1_triplet(struct w1_master *dev, int bdir);
 void w1_write_8(struct w1_master *, u8);
 u8 w1_read_8(struct w1_master *);
 int w1_reset_bus(struct w1_master *);

