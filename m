Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262036AbVDVPdj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262036AbVDVPdj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Apr 2005 11:33:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262059AbVDVPca
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Apr 2005 11:32:30 -0400
Received: from mtagate3.de.ibm.com ([195.212.29.152]:53128 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP id S261972AbVDVPEG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Apr 2005 11:04:06 -0400
Date: Fri, 22 Apr 2005 17:03:31 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [patch 12/12] s390: cio documentation.
Message-ID: <20050422150331.GL17508@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[patch 12/12] s390: cio documentation.

From: Cornelia Huck <cohuck@de.ibm.com>

Synchronize documentation with current interface.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

diffstat:
 Documentation/s390/cds.txt |   45 +++++++++++++++++++++++++++++++++++++++++----
 1 files changed, 41 insertions(+), 4 deletions(-)

diff -urpN linux-2.6/Documentation/s390/cds.txt linux-2.6-patched/Documentation/s390/cds.txt
--- linux-2.6/Documentation/s390/cds.txt	2005-03-02 08:38:19.000000000 +0100
+++ linux-2.6-patched/Documentation/s390/cds.txt	2005-04-22 15:45:08.000000000 +0200
@@ -56,12 +56,16 @@ read_dev_chars()	
    read device characteristics
    
 read_conf_data()
+read_conf_data_lpm()
    read configuration data.
 
 ccw_device_get_ciw()
    get commands from extended sense data.
 
 ccw_device_start()	
+ccw_device_start_timeout()
+ccw_device_start_key()
+ccw_device_start_key_timeout()
    initiate an I/O request.
 
 ccw_device_resume()
@@ -197,19 +201,21 @@ The read_dev_chars() function returns :
           operational.
 
 
-read_conf_data() - Read Configuration Data
+read_conf_data(), read_conf_data_lpm() - Read Configuration Data
 
 Retrieve the device dependent configuration data. Please have a look at your 
 device dependent I/O commands for the device specific layout of the node 
-descriptor elements. 
+descriptor elements. read_conf_data_lpm() will retrieve the configuration data
+for a specific path.
 
-The function is meant to be called with an irq handler in place; that is,
+The function is meant to be called with the device already enabled; that is,
 at earliest during set_online() processing.
 
 The function may be called enabled or disabled, but the device must not be
 locked
 
-int read_conf_data(struct ccw_device, void **buffer, int *length, __u8 lpm);
+int read_conf_data(struct ccw_device, void **buffer, int *length);
+int read_conf_data_lpm(struct ccw_device, void **buffer, int *length, __u8 lpm);
 
 cdev   - the ccw_device the data is requested for.
 buffer - Pointer to a buffer pointer. The read_conf_data() routine
@@ -263,6 +269,25 @@ int ccw_device_start(struct ccw_device *
 		     unsigned long intparm,
 		     __u8 lpm,
 		     unsigned long flags);
+int ccw_device_start_timeout(struct ccw_device *cdev,
+			     struct ccw1 *cpa,
+			     unsigned long intparm,
+			     __u8 lpm,
+			     unsigned long flags,
+			     int expires);
+int ccw_device_start_key(struct ccw_device *cdev,
+			 struct ccw1 *cpa,
+			 unsigned long intparm,
+			 __u8 lpm,
+			 __u8 key,
+			 unsigned long flags);
+int ccw_device_start_key_timeout(struct ccw_device *cdev,
+				 struct ccw1 *cpa,
+				 unsigned long intparm,
+				 __u8 lpm,
+				 __u8 key,
+				 unsigned long flags,
+				 int expires);
 
 cdev         : ccw_device the I/O is destined for
 cpa          : logical start address of channel program
@@ -272,7 +297,12 @@ user_intparm : user specific interrupt i
                particular I/O request.
 lpm          : defines the channel path to be used for a specific I/O
                request. A value of 0 will make cio use the opm.
+key	     : the storage key to use for the I/O (useful for operating on a
+	       storage with a storage key != default key)
 flag         : defines the action to be performed for I/O processing
+expires      : timeout value in jiffies. The common I/O layer will terminate
+	       the running program after this and call the interrupt handler
+	       with ERR_PTR(-ETIMEDOUT) as irb.
 
 Possible flag values are :
 
@@ -327,6 +357,13 @@ current (last) I/O request. In case of a
 interrupt will be presented to indicate I/O completion as the I/O request was
 never started, even though ccw_device_start() returned with successful completion.
 
+The irb may contain an error value, and the device driver should check for this
+first:
+
+-ETIMEDOUT: the common I/O layer terminated the request after the specified
+            timeout value
+-EIO:       the common I/O layer terminated the request due to an error state
+
 If the concurrent sense flag in the extended status word in the irb is set, the
 field irb->scsw.count describes the numer of device specific sense bytes
 available in the extended control word irb->scsw.ecw[0]. No device sensing by
