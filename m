Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317003AbSHBUmh>; Fri, 2 Aug 2002 16:42:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317034AbSHBUmh>; Fri, 2 Aug 2002 16:42:37 -0400
Received: from air-2.osdl.org ([65.172.181.6]:896 "EHLO doc.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S317003AbSHBUmY>;
	Fri, 2 Aug 2002 16:42:24 -0400
Date: Fri, 2 Aug 2002 13:45:53 -0700
From: Bob Miller <rem@osdl.org>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2.5.30] Remove a FIXME from kernel/sysctl.c
Message-ID: <20020802134553.A1198@doc.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.513   -> 1.514  
#	drivers/net/arlan-proc.c	1.5     -> 1.6    
#	include/linux/sysctl.h	1.22    -> 1.23   
#	include/linux/coda_proc.h	1.3     -> 1.4    
#	 net/sunrpc/sysctl.c	1.2     -> 1.3    
#	drivers/char/random.c	1.20    -> 1.21   
#	     kernel/sysctl.c	1.26    -> 1.27   
#	drivers/net/aironet4500_proc.c	1.7     -> 1.8    
#	drivers/cdrom/cdrom.c	1.21    -> 1.22   
#	    net/ipv6/route.c	1.8     -> 1.9    
#	net/decnet/sysctl_net_decnet.c	1.4     -> 1.5    
#	  net/ipv4/devinet.c	1.9     -> 1.10   
#	drivers/parport/procfs.c	1.2     -> 1.3    
#	 net/decnet/dn_dev.c	1.5     -> 1.6    
#	    fs/coda/sysctl.c	1.8     -> 1.9    
#	 net/irda/irsysctl.c	1.7     -> 1.8    
#	drivers/i2c/i2c-proc.c	1.4     -> 1.5    
#	include/linux/i2c-proc.h	1.2     -> 1.3    
#	net/ipv4/sysctl_net_ipv4.c	1.5     -> 1.6    
#	 net/ipv6/addrconf.c	1.13    -> 1.14   
#	    net/ipv4/route.c	1.18    -> 1.19   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/08/02	rem@doc.pdx.osdl.net	1.509.17.1
# Remove a "FIXME" from kernel/sysctl.c:do_rw_proc().  The proc_handler
# typedef now takes a loff_t * parameter that points to the current possion
# in the file.  proc_handler()'s now read and change this value instead of
# f_pos.  This mirrors work done in vfs_read() and vfs_write().
# --------------------------------------------
# 02/08/02	rem@doc.pdx.osdl.net	1.514
# Merge doc.pdx.osdl.net:/views/BK/linux-2.5-linus
# into doc.pdx.osdl.net:/views/BK/linux-2.5-d_f_pos
# --------------------------------------------
#
diff -Nru a/drivers/cdrom/cdrom.c b/drivers/cdrom/cdrom.c
--- a/drivers/cdrom/cdrom.c	Fri Aug  2 12:56:17 2002
+++ b/drivers/cdrom/cdrom.c	Fri Aug  2 12:56:17 2002
@@ -2390,13 +2390,13 @@
 } cdrom_sysctl_settings;
 
 int cdrom_sysctl_info(ctl_table *ctl, int write, struct file * filp,
-                           void *buffer, size_t *lenp)
+                           void *buffer, size_t *lenp, loff_t *ppos)
 {
         int pos;
 	struct cdrom_device_info *cdi;
 	char *info = cdrom_sysctl_settings.info;
 	
-	if (!*lenp || (filp->f_pos && !write)) {
+	if (!*lenp || (*ppos && !write)) {
 		*lenp = 0;
 		return 0;
 	}
@@ -2473,7 +2473,7 @@
 
 	strcpy(info+pos,"\n\n");
 		
-        return proc_dostring(ctl, write, filp, buffer, lenp);
+        return proc_dostring(ctl, write, filp, buffer, lenp, ppos);
 }
 
 /* Unfortunately, per device settings are not implemented through
@@ -2505,13 +2505,13 @@
 }
 
 static int cdrom_sysctl_handler(ctl_table *ctl, int write, struct file * filp,
-				void *buffer, size_t *lenp)
+				void *buffer, size_t *lenp, loff_t *ppos)
 {
 	int *valp = ctl->data;
 	int val = *valp;
 	int ret;
 	
-	ret = proc_dointvec(ctl, write, filp, buffer, lenp);
+	ret = proc_dointvec(ctl, write, filp, buffer, lenp, ppos);
 
 	if (write && *valp != val) {
 	
diff -Nru a/drivers/char/random.c b/drivers/char/random.c
--- a/drivers/char/random.c	Fri Aug  2 12:56:17 2002
+++ b/drivers/char/random.c	Fri Aug  2 12:56:17 2002
@@ -1754,13 +1754,13 @@
 }
 
 static int proc_do_poolsize(ctl_table *table, int write, struct file *filp,
-			    void *buffer, size_t *lenp)
+			    void *buffer, size_t *lenp, loff_t *ppos)
 {
 	int	ret;
 
 	sysctl_poolsize = random_state->poolinfo.POOLBYTES;
 
-	ret = proc_dointvec(table, write, filp, buffer, lenp);
+	ret = proc_dointvec(table, write, filp, buffer, lenp, ppos);
 	if (ret || !write ||
 	    (sysctl_poolsize == random_state->poolinfo.POOLBYTES))
 		return ret;
@@ -1805,7 +1805,7 @@
  * sysctl system call, it is returned as 16 bytes of binary data.
  */
 static int proc_do_uuid(ctl_table *table, int write, struct file *filp,
-			void *buffer, size_t *lenp)
+			void *buffer, size_t *lenp, loff_t *ppos)
 {
 	ctl_table	fake_table;
 	unsigned char	buf[64], tmp_uuid[16], *uuid;
@@ -1827,7 +1827,7 @@
 	fake_table.data = buf;
 	fake_table.maxlen = sizeof(buf);
 
-	return proc_dostring(&fake_table, write, filp, buffer, lenp);
+	return proc_dostring(&fake_table, write, filp, buffer, lenp, ppos);
 }
 
 static int uuid_strategy(ctl_table *table, int *name, int nlen,
diff -Nru a/drivers/i2c/i2c-proc.c b/drivers/i2c/i2c-proc.c
--- a/drivers/i2c/i2c-proc.c	Fri Aug  2 12:56:17 2002
+++ b/drivers/i2c/i2c-proc.c	Fri Aug  2 12:56:17 2002
@@ -48,7 +48,7 @@
 			       long *results, int magnitude);
 static int i2c_proc_chips(ctl_table * ctl, int write,
 			      struct file *filp, void *buffer,
-			      size_t * lenp);
+			      size_t * lenp, loff_t *ppos);
 static int i2c_sysctl_chips(ctl_table * table, int *name, int nlen,
 				void *oldval, size_t * oldlenp,
 				void *newval, size_t newlen,
@@ -211,7 +211,7 @@
 }
 
 int i2c_proc_chips(ctl_table * ctl, int write, struct file *filp,
-		       void *buffer, size_t * lenp)
+		       void *buffer, size_t * lenp, loff_t *ppos)
 {
 	char BUF[SENSORS_PREFIX_MAX + 30];
 	int buflen, curbufsize, i;
@@ -224,7 +224,7 @@
 	   return nothing. Note that I think writing when not at the start
 	   does not work either, but anyway, this is straight from the kernel
 	   sources. */
-	if (!*lenp || (filp->f_pos && !write)) {
+	if (!*lenp || (*ppos && !write)) {
 		*lenp = 0;
 		return 0;
 	}
@@ -244,7 +244,7 @@
 			(char *) buffer += buflen;
 		}
 	*lenp = curbufsize;
-	filp->f_pos += curbufsize;
+	*ppos += curbufsize;
 	return 0;
 }
 
@@ -302,7 +302,7 @@
    In all cases, client points to the client we wish to interact with,
    and ctl_name is the SYSCTL id of the file we are accessing. */
 int i2c_proc_real(ctl_table * ctl, int write, struct file *filp,
-		      void *buffer, size_t * lenp)
+		      void *buffer, size_t * lenp, loff_t *ppos)
 {
 #define MAX_RESULTS 32
 	int mag, nrels = MAX_RESULTS;
@@ -315,7 +315,7 @@
 	   return nothing. Note that I think writing when not at the start
 	   does not work either, but anyway, this is straight from the kernel
 	   sources. */
-	if (!*lenp || (filp->f_pos && !write)) {
+	if (!*lenp || (*ppos && !write)) {
 		*lenp = 0;
 		return 0;
 	}
@@ -337,7 +337,7 @@
 		callback(client, SENSORS_PROC_REAL_WRITE, ctl->ctl_name,
 			 &nrels, results);
 
-		filp->f_pos += *lenp;
+		*ppos += *lenp;
 		return 0;
 	} else {		/* read */
 		/* Get the information from the client into results */
@@ -348,7 +348,7 @@
 		res = i2c_write_reals(nrels, buffer, lenp, results, mag);
 		if (res)
 			return res;
-		filp->f_pos += *lenp;
+		*ppos += *lenp;
 		return 0;
 	}
 }
diff -Nru a/drivers/net/aironet4500_proc.c b/drivers/net/aironet4500_proc.c
--- a/drivers/net/aironet4500_proc.c	Fri Aug  2 12:56:17 2002
+++ b/drivers/net/aironet4500_proc.c	Fri Aug  2 12:56:17 2002
@@ -253,7 +253,7 @@
 };
 
 int awc_proc_fun(ctl_table *ctl, int write, struct file * filp,
-                           void *buffer, size_t *lenp)
+		 void *buffer, size_t *lenp, loff_t *ppos)
 {
         int retv =-1;
    	struct awc_private *priv = NULL;
@@ -269,7 +269,7 @@
   	AWC_ENTRY_EXIT_DEBUG("awc_proc_fun");
 
 	if (!write && filp)
-	 if (filp->f_pos){
+	 if (*ppos){
 //	 	printk(KERN_CRIT "Oversize read\n");
 		*lenp = 0;// hack against reading til eof
 	  	return	0;
@@ -306,26 +306,34 @@
 	
 	if (rid->array > 1 || rid->bits > 32){
 		if (write){
-        		retv = proc_dostring(ctl, write, filp, buffer, lenp);
+        		retv = proc_dostring(ctl, write, filp, buffer,
+					     lenp, ppos);
         		if (retv) goto final;
-			retv = awc_proc_format_array(write, awc_proc_buff, lenp, rid_dir, rid);
+			retv = awc_proc_format_array(write, awc_proc_buff,
+						     lenp, rid_dir, rid);
 			if (retv) goto final;
 		} else {
-			retv = awc_proc_format_array(write, awc_proc_buff, lenp, rid_dir, rid);
+			retv = awc_proc_format_array(write, awc_proc_buff,
+						     lenp, rid_dir, rid);
 			if (retv) goto final;
-        		retv = proc_dostring(ctl, write, filp, buffer, lenp);
+        		retv = proc_dostring(ctl, write, filp, buffer,
+					     lenp, ppos);
 			if (retv) goto final;
         	}
         } else {
         	if (write){
-        		retv = proc_dointvec(ctl, write, filp, buffer, lenp);        
+        		retv = proc_dointvec(ctl, write, filp, buffer,
+					     lenp, ppos);        
 			if (retv) goto final;	
-			retv = awc_proc_format_bits(write, &awc_int_buff, lenp, rid_dir, rid);
+			retv = awc_proc_format_bits(write, &awc_int_buff,
+						    lenp, rid_dir, rid);
 			if (retv) goto final;	
 		} else {
-			retv = awc_proc_format_bits(write, &awc_int_buff, lenp,rid_dir, rid);
+			retv = awc_proc_format_bits(write, &awc_int_buff,
+						    lenp,rid_dir, rid);
 			if (retv) goto final;	
-        		retv = proc_dointvec(ctl, write, filp, buffer, lenp);        
+        		retv = proc_dointvec(ctl, write, filp, buffer,
+					     lenp, ppos);        
 			if (retv) goto final;	
 		}
         }
diff -Nru a/drivers/net/arlan-proc.c b/drivers/net/arlan-proc.c
--- a/drivers/net/arlan-proc.c	Fri Aug  2 12:56:17 2002
+++ b/drivers/net/arlan-proc.c	Fri Aug  2 12:56:17 2002
@@ -402,7 +402,7 @@
 static char arlan_drive_info[ARLAN_STR_SIZE] = "A655\n\0";
 
 static int arlan_sysctl_info(ctl_table * ctl, int write, struct file *filp,
-		      void *buffer, size_t * lenp)
+			     void *buffer, size_t * lenp, loff_t *ppos)
 {
 	int i;
 	int retv, pos, devnum;
@@ -628,7 +628,7 @@
 	*lenp = pos;
 
 	if (!write)
-		retv = proc_dostring(ctl, write, filp, buffer, lenp);
+		retv = proc_dostring(ctl, write, filp, buffer, lenp, ppos);
 	else
 	{
 		*lenp = 0;
@@ -638,8 +638,9 @@
 }
 
 
-static int arlan_sysctl_info161719(ctl_table * ctl, int write, struct file *filp,
-			    void *buffer, size_t * lenp)
+static int arlan_sysctl_info161719(ctl_table * ctl, int write,
+				   struct file *filp, void *buffer,
+				   size_t * lenp, loff_t *ppos)
 {
 	int i;
 	int retv, pos, devnum;
@@ -668,12 +669,13 @@
 
 final:
 	*lenp = pos;
-	retv = proc_dostring(ctl, write, filp, buffer, lenp);
+	retv = proc_dostring(ctl, write, filp, buffer, lenp, ppos);
 	return retv;
 }
 
-static int arlan_sysctl_infotxRing(ctl_table * ctl, int write, struct file *filp,
-			    void *buffer, size_t * lenp)
+static int arlan_sysctl_infotxRing(ctl_table * ctl, int write,
+				   struct file *filp, void *buffer,
+				   size_t * lenp, loff_t *ppos)
 {
 	int i;
 	int retv, pos, devnum;
@@ -697,12 +699,13 @@
 	SARLBNpln(u_char, txBuffer, 0x800);
 final:
 	*lenp = pos;
-	retv = proc_dostring(ctl, write, filp, buffer, lenp);
+	retv = proc_dostring(ctl, write, filp, buffer, lenp, ppos);
 	return retv;
 }
 
-static int arlan_sysctl_inforxRing(ctl_table * ctl, int write, struct file *filp,
-			    void *buffer, size_t * lenp)
+static int arlan_sysctl_inforxRing(ctl_table * ctl, int write,
+				   struct file *filp, void *buffer,
+				   size_t * lenp, loff_t *ppos)
 {
 	int i;
 	int retv, pos, devnum;
@@ -725,12 +728,12 @@
 	SARLBNpln(u_char, rxBuffer, 0x800);
 final:
 	*lenp = pos;
-	retv = proc_dostring(ctl, write, filp, buffer, lenp);
+	retv = proc_dostring(ctl, write, filp, buffer, lenp, ppos);
 	return retv;
 }
 
 static int arlan_sysctl_info18(ctl_table * ctl, int write, struct file *filp,
-			void *buffer, size_t * lenp)
+			void *buffer, size_t * lenp, loff_t *ppos)
 {
 	int i;
 	int retv, pos, devnum;
@@ -755,7 +758,7 @@
 
 final:
 	*lenp = pos;
-	retv = proc_dostring(ctl, write, filp, buffer, lenp);
+	retv = proc_dostring(ctl, write, filp, buffer, lenp, ppos);
 	return retv;
 }
 
@@ -766,7 +769,7 @@
 static char conf_reset_result[200];
 
 static int arlan_configure(ctl_table * ctl, int write, struct file *filp,
-		    void *buffer, size_t * lenp)
+		    void *buffer, size_t * lenp, loff_t *ppos)
 {
 	int pos = 0;
 	int devnum = ctl->procname[6] - '0';
@@ -787,11 +790,11 @@
 		return -1;
 
 	*lenp = pos;
-	return proc_dostring(ctl, write, filp, buffer, lenp);
+	return proc_dostring(ctl, write, filp, buffer, lenp, ppos);
 }
 
 static int arlan_sysctl_reset(ctl_table * ctl, int write, struct file *filp,
-		       void *buffer, size_t * lenp)
+		       void *buffer, size_t * lenp, loff_t *ppos)
 {
 	int pos = 0;
 	int devnum = ctl->procname[5] - '0';
@@ -810,7 +813,7 @@
 	} else
 		return -1;
 	*lenp = pos + 3;
-	return proc_dostring(ctl, write, filp, buffer, lenp);
+	return proc_dostring(ctl, write, filp, buffer, lenp, ppos);
 }
 
 
diff -Nru a/drivers/parport/procfs.c b/drivers/parport/procfs.c
--- a/drivers/parport/procfs.c	Fri Aug  2 12:56:17 2002
+++ b/drivers/parport/procfs.c	Fri Aug  2 12:56:17 2002
@@ -31,7 +31,7 @@
 #define PARPORT_MAX_SPINTIME_VALUE 1000
 
 static int do_active_device(ctl_table *table, int write, struct file *filp,
-		      void *result, size_t *lenp)
+		      void *result, size_t *lenp, loff_t *ppos)
 {
 	struct parport *port = (struct parport *)table->extra1;
 	char buffer[256];
@@ -41,7 +41,7 @@
 	if (write)		/* can't happen anyway */
 		return -EACCES;
 
-	if (filp->f_pos) {
+	if (*ppos) {
 		*lenp = 0;
 		return 0;
 	}
@@ -61,14 +61,14 @@
 	else
 		*lenp = len;
 
-	filp->f_pos += len;
+	*ppos += len;
 
 	return copy_to_user(result, buffer, len) ? -EFAULT : 0;
 }
 
 #ifdef CONFIG_PARPORT_1284
 static int do_autoprobe(ctl_table *table, int write, struct file *filp,
-			void *result, size_t *lenp)
+			void *result, size_t *lenp, loff_t *ppos)
 {
 	struct parport_device_info *info = table->extra2;
 	const char *str;
@@ -78,7 +78,7 @@
 	if (write) /* permissions stop this */
 		return -EACCES;
 
-	if (filp->f_pos) {
+	if (*ppos) {
 		*lenp = 0;
 		return 0;
 	}
@@ -103,7 +103,7 @@
 	else
 		*lenp = len;
 
-	filp->f_pos += len;
+	*ppos += len;
 
 	return copy_to_user (result, buffer, len) ? -EFAULT : 0;
 }
@@ -111,13 +111,13 @@
 
 static int do_hardware_base_addr (ctl_table *table, int write,
 				  struct file *filp, void *result,
-				  size_t *lenp)
+				  size_t *lenp, loff_t *ppos)
 {
 	struct parport *port = (struct parport *)table->extra1;
 	char buffer[20];
 	int len = 0;
 
-	if (filp->f_pos) {
+	if (*ppos) {
 		*lenp = 0;
 		return 0;
 	}
@@ -132,20 +132,20 @@
 	else
 		*lenp = len;
 
-	filp->f_pos += len;
+	*ppos += len;
 
 	return copy_to_user(result, buffer, len) ? -EFAULT : 0;
 }
 
 static int do_hardware_irq (ctl_table *table, int write,
 			    struct file *filp, void *result,
-			    size_t *lenp)
+			    size_t *lenp, loff_t *ppos)
 {
 	struct parport *port = (struct parport *)table->extra1;
 	char buffer[20];
 	int len = 0;
 
-	if (filp->f_pos) {
+	if (*ppos) {
 		*lenp = 0;
 		return 0;
 	}
@@ -160,20 +160,20 @@
 	else
 		*lenp = len;
 
-	filp->f_pos += len;
+	*ppos += len;
 
 	return copy_to_user(result, buffer, len) ? -EFAULT : 0;
 }
 
 static int do_hardware_dma (ctl_table *table, int write,
 			    struct file *filp, void *result,
-			    size_t *lenp)
+			    size_t *lenp, loff_t *ppos)
 {
 	struct parport *port = (struct parport *)table->extra1;
 	char buffer[20];
 	int len = 0;
 
-	if (filp->f_pos) {
+	if (*ppos) {
 		*lenp = 0;
 		return 0;
 	}
@@ -188,20 +188,20 @@
 	else
 		*lenp = len;
 
-	filp->f_pos += len;
+	*ppos += len;
 
 	return copy_to_user(result, buffer, len) ? -EFAULT : 0;
 }
 
 static int do_hardware_modes (ctl_table *table, int write,
 			      struct file *filp, void *result,
-			      size_t *lenp)
+			      size_t *lenp, loff_t *ppos)
 {
 	struct parport *port = (struct parport *)table->extra1;
 	char buffer[40];
 	int len = 0;
 
-	if (filp->f_pos) {
+	if (*ppos) {
 		*lenp = 0;
 		return 0;
 	}
@@ -227,7 +227,7 @@
 	else
 		*lenp = len;
 
-	filp->f_pos += len;
+	*ppos += len;
 
 	return copy_to_user(result, buffer, len) ? -EFAULT : 0;
 }
diff -Nru a/fs/coda/sysctl.c b/fs/coda/sysctl.c
--- a/fs/coda/sysctl.c	Fri Aug  2 12:56:17 2002
+++ b/fs/coda/sysctl.c	Fri Aug  2 12:56:17 2002
@@ -207,12 +207,12 @@
 }
 
 int do_reset_coda_vfs_stats( ctl_table * table, int write, struct file * filp,
-			     void * buffer, size_t * lenp )
+			     void * buffer, size_t * lenp, loff_t *ppos )
 {
 	if ( write ) {
 		reset_coda_vfs_stats();
 
-		filp->f_pos += *lenp;
+		*ppos += *lenp;
 	} else {
 		*lenp = 0;
 	}
@@ -222,7 +222,7 @@
 
 int do_reset_coda_upcall_stats( ctl_table * table, int write, 
 				struct file * filp, void * buffer, 
-				size_t * lenp )
+				size_t * lenp, loff_t *ppos )
 {
 	if ( write ) {
         	if (*lenp > 0) {
@@ -233,7 +233,7 @@
                 }
 		reset_coda_upcall_stats();
 
-		filp->f_pos += *lenp;
+		*ppos += *lenp;
 	} else {
 		*lenp = 0;
 	}
@@ -243,12 +243,12 @@
 
 int do_reset_coda_cache_inv_stats( ctl_table * table, int write, 
 				   struct file * filp, void * buffer, 
-				   size_t * lenp )
+				   size_t * lenp, loff_t *ppos )
 {
 	if ( write ) {
 		reset_coda_cache_inv_stats();
 
-		filp->f_pos += *lenp;
+		*ppos += *lenp;
 	} else {
 		*lenp = 0;
 	}
diff -Nru a/include/linux/coda_proc.h b/include/linux/coda_proc.h
--- a/include/linux/coda_proc.h	Fri Aug  2 12:56:17 2002
+++ b/include/linux/coda_proc.h	Fri Aug  2 12:56:17 2002
@@ -104,13 +104,13 @@
  * data structure for /proc/sys/... files 
  */
 int do_reset_coda_vfs_stats( ctl_table * table, int write, struct file * filp,
-			     void * buffer, size_t * lenp );
+			     void * buffer, size_t * lenp, loff_t *ppos );
 int do_reset_coda_upcall_stats( ctl_table * table, int write, 
 				struct file * filp, void * buffer, 
-				size_t * lenp );
+				size_t * lenp, loff_t *ppos );
 int do_reset_coda_cache_inv_stats( ctl_table * table, int write, 
 				   struct file * filp, void * buffer, 
-				   size_t * lenp );
+				   size_t * lenp, loff_t *ppos );
 
 /* these functions are called to form the content of /proc/fs/coda/... files */
 int coda_vfs_stats_get_info( char * buffer, char ** start, off_t offset,
diff -Nru a/include/linux/i2c-proc.h b/include/linux/i2c-proc.h
--- a/include/linux/i2c-proc.h	Fri Aug  2 12:56:17 2002
+++ b/include/linux/i2c-proc.h	Fri Aug  2 12:56:17 2002
@@ -61,7 +61,7 @@
 			       void *newval, size_t newlen,
 			       void **context);
 extern int i2c_proc_real(ctl_table * ctl, int write, struct file *filp,
-			     void *buffer, size_t * lenp);
+			     void *buffer, size_t * lenp, loff_t *ppos);
 
 
 
diff -Nru a/include/linux/sysctl.h b/include/linux/sysctl.h
--- a/include/linux/sysctl.h	Fri Aug  2 12:56:17 2002
+++ b/include/linux/sysctl.h	Fri Aug  2 12:56:17 2002
@@ -644,22 +644,23 @@
 			 void **context);
 
 typedef int proc_handler (ctl_table *ctl, int write, struct file * filp,
-			  void *buffer, size_t *lenp);
+			  void *buffer, size_t *lenp, loff_t *ppos);
 
 extern int proc_dostring(ctl_table *, int, struct file *,
-			 void *, size_t *);
+			 void *, size_t *, loff_t *);
 extern int proc_dointvec(ctl_table *, int, struct file *,
-			 void *, size_t *);
+			 void *, size_t *, loff_t *);
 extern int proc_dointvec_bset(ctl_table *, int, struct file *,
-			      void *, size_t *);
+			      void *, size_t *, loff_t *);
 extern int proc_dointvec_minmax(ctl_table *, int, struct file *,
-				void *, size_t *);
+				void *, size_t *, loff_t *);
 extern int proc_dointvec_jiffies(ctl_table *, int, struct file *,
-				 void *, size_t *);
+				 void *, size_t *, loff_t *);
 extern int proc_doulongvec_minmax(ctl_table *, int, struct file *,
-				  void *, size_t *);
+				  void *, size_t *, loff_t *);
 extern int proc_doulongvec_ms_jiffies_minmax(ctl_table *table, int,
-				      struct file *, void *, size_t *);
+				      struct file *, void *, size_t *,
+				      loff_t *);
 
 extern int do_sysctl (int *name, int nlen,
 		      void *oldval, size_t *oldlenp,
diff -Nru a/kernel/sysctl.c b/kernel/sysctl.c
--- a/kernel/sysctl.c	Fri Aug  2 12:56:17 2002
+++ b/kernel/sysctl.c	Fri Aug  2 12:56:17 2002
@@ -100,7 +100,7 @@
 static int parse_table(int *, int, void *, size_t *, void *, size_t,
 		       ctl_table *, void **);
 static int proc_doutsstring(ctl_table *table, int write, struct file *filp,
-		  void *buffer, size_t *lenp);
+		  void *buffer, size_t *lenp, loff_t *ppos);
 
 static ctl_table root_table[];
 static struct ctl_table_header root_table_header =
@@ -720,11 +720,7 @@
 	
 	res = count;
 
-	/*
-	 * FIXME: we need to pass on ppos to the handler.
-	 */
-
-	error = (*table->proc_handler) (table, write, file, buf, &res);
+	error = (*table->proc_handler) (table, write, file, buf, &res, ppos);
 	if (error)
 		return error;
 	return res;
@@ -765,13 +761,13 @@
  * Returns 0 on success.
  */
 int proc_dostring(ctl_table *table, int write, struct file *filp,
-		  void *buffer, size_t *lenp)
+		  void *buffer, size_t *lenp, loff_t *ppos)
 {
 	size_t len;
 	char *p, c;
 	
 	if (!table->data || !table->maxlen || !*lenp ||
-	    (filp->f_pos && !write)) {
+	    (*ppos && !write)) {
 		*lenp = 0;
 		return 0;
 	}
@@ -791,7 +787,7 @@
 		if(copy_from_user(table->data, buffer, len))
 			return -EFAULT;
 		((char *) table->data)[len] = 0;
-		filp->f_pos += *lenp;
+		*ppos += *lenp;
 	} else {
 		len = strlen(table->data);
 		if (len > table->maxlen)
@@ -807,7 +803,7 @@
 			len++;
 		}
 		*lenp = len;
-		filp->f_pos += len;
+		*ppos += len;
 	}
 	return 0;
 }
@@ -818,17 +814,17 @@
  */
  
 static int proc_doutsstring(ctl_table *table, int write, struct file *filp,
-		  void *buffer, size_t *lenp)
+		  void *buffer, size_t *lenp, loff_t *ppos)
 {
 	int r;
 
 	if (!write) {
 		down_read(&uts_sem);
-		r=proc_dostring(table,0,filp,buffer,lenp);
+		r=proc_dostring(table,0,filp,buffer,lenp,ppos);
 		up_read(&uts_sem);
 	} else {
 		down_write(&uts_sem);
-		r=proc_dostring(table,1,filp,buffer,lenp);
+		r=proc_dostring(table,1,filp,buffer,lenp,ppos);
 		up_write(&uts_sem);
 	}
 	return r;
@@ -841,7 +837,7 @@
 #define OP_MIN	4
 
 static int do_proc_dointvec(ctl_table *table, int write, struct file *filp,
-		  void *buffer, size_t *lenp, int conv, int op)
+		  void *buffer, size_t *lenp, loff_t *ppos, int conv, int op)
 {
 	int *i, vleft, first=1, neg, val;
 	size_t left, len;
@@ -850,7 +846,7 @@
 	char buf[TMPBUFLEN], *p;
 	
 	if (!table->data || !table->maxlen || !*lenp ||
-	    (filp->f_pos && !write)) {
+	    (*ppos && !write)) {
 		*lenp = 0;
 		return 0;
 	}
@@ -939,7 +935,7 @@
 	if (write && first)
 		return -EINVAL;
 	*lenp -= left;
-	filp->f_pos += *lenp;
+	*ppos += *lenp;
 	return 0;
 }
 
@@ -957,9 +953,9 @@
  * Returns 0 on success.
  */
 int proc_dointvec(ctl_table *table, int write, struct file *filp,
-		     void *buffer, size_t *lenp)
+		     void *buffer, size_t *lenp, loff_t *ppos)
 {
-    return do_proc_dointvec(table,write,filp,buffer,lenp,1,OP_SET);
+    return do_proc_dointvec(table,write,filp,buffer,lenp,ppos,1,OP_SET);
 }
 
 /*
@@ -967,12 +963,12 @@
  */
  
 int proc_dointvec_bset(ctl_table *table, int write, struct file *filp,
-			void *buffer, size_t *lenp)
+			void *buffer, size_t *lenp, loff_t *ppos)
 {
 	if (!capable(CAP_SYS_MODULE)) {
 		return -EPERM;
 	}
-	return do_proc_dointvec(table,write,filp,buffer,lenp,1,
+	return do_proc_dointvec(table,write,filp,buffer,lenp,ppos,1,
 				(current->pid == 1) ? OP_SET : OP_AND);
 }
 
@@ -993,7 +989,7 @@
  * Returns 0 on success.
  */
 int proc_dointvec_minmax(ctl_table *table, int write, struct file *filp,
-		  void *buffer, size_t *lenp)
+		  void *buffer, size_t *lenp, loff_t *ppos)
 {
 	int *i, *min, *max, vleft, first=1, neg, val;
 	size_t len, left;
@@ -1001,7 +997,7 @@
 	char buf[TMPBUFLEN], *p;
 	
 	if (!table->data || !table->maxlen || !*lenp ||
-	    (filp->f_pos && !write)) {
+	    (*ppos && !write)) {
 		*lenp = 0;
 		return 0;
 	}
@@ -1085,13 +1081,14 @@
 	if (write && first)
 		return -EINVAL;
 	*lenp -= left;
-	filp->f_pos += *lenp;
+	*ppos += *lenp;
 	return 0;
 }
 
 static int do_proc_doulongvec_minmax(ctl_table *table, int write,
 				     struct file *filp,
 				     void *buffer, size_t *lenp,
+				     loff_t *ppos,
 				     unsigned long convmul,
 				     unsigned long convdiv)
 {
@@ -1102,7 +1099,7 @@
 	char buf[TMPBUFLEN], *p;
 	
 	if (!table->data || !table->maxlen || !*lenp ||
-	    (filp->f_pos && !write)) {
+	    (*ppos && !write)) {
 		*lenp = 0;
 		return 0;
 	}
@@ -1188,7 +1185,7 @@
 	if (write && first)
 		return -EINVAL;
 	*lenp -= left;
-	filp->f_pos += *lenp;
+	*ppos += *lenp;
 	return 0;
 #undef TMPBUFLEN
 }
@@ -1210,9 +1207,10 @@
  * Returns 0 on success.
  */
 int proc_doulongvec_minmax(ctl_table *table, int write, struct file *filp,
-			   void *buffer, size_t *lenp)
+			   void *buffer, size_t *lenp, loff_t *ppos)
 {
-    return do_proc_doulongvec_minmax(table, write, filp, buffer, lenp, 1l, 1l);
+    return do_proc_doulongvec_minmax(table, write, filp, buffer, lenp,
+				     ppos, 1l, 1l);
 }
 
 /**
@@ -1234,10 +1232,11 @@
  */
 int proc_doulongvec_ms_jiffies_minmax(ctl_table *table, int write,
 				      struct file *filp,
-				      void *buffer, size_t *lenp)
+				      void *buffer, size_t *lenp,
+				      loff_t *ppos)
 {
     return do_proc_doulongvec_minmax(table, write, filp, buffer,
-				     lenp, HZ, 1000l);
+				     lenp, ppos, HZ, 1000l);
 }
 
 
@@ -1257,9 +1256,9 @@
  * Returns 0 on success.
  */
 int proc_dointvec_jiffies(ctl_table *table, int write, struct file *filp,
-			  void *buffer, size_t *lenp)
+			  void *buffer, size_t *lenp, loff_t *ppos)
 {
-    return do_proc_dointvec(table,write,filp,buffer,lenp,HZ,OP_SET);
+    return do_proc_dointvec(table,write,filp,buffer,lenp,ppos,HZ,OP_SET);
 }
 
 #else /* CONFIG_PROC_FS */
@@ -1271,44 +1270,44 @@
 }
 
 static int proc_doutsstring(ctl_table *table, int write, struct file *filp,
-			    void *buffer, size_t *lenp)
+			    void *buffer, size_t *lenp, loff_t *ppos)
 {
 	return -ENOSYS;
 }
 
 int proc_dointvec(ctl_table *table, int write, struct file *filp,
-		  void *buffer, size_t *lenp)
+		  void *buffer, size_t *lenp, loff_t *ppos)
 {
 	return -ENOSYS;
 }
 
 int proc_dointvec_bset(ctl_table *table, int write, struct file *filp,
-			void *buffer, size_t *lenp)
+			void *buffer, size_t *lenp, loff_t *ppos)
 {
 	return -ENOSYS;
 }
 
 int proc_dointvec_minmax(ctl_table *table, int write, struct file *filp,
-		    void *buffer, size_t *lenp)
+		    void *buffer, size_t *lenp, loff_t *ppos)
 {
 	return -ENOSYS;
 }
 
 int proc_dointvec_jiffies(ctl_table *table, int write, struct file *filp,
-		    void *buffer, size_t *lenp)
+		    void *buffer, size_t *lenp, loff_t *ppos)
 {
 	return -ENOSYS;
 }
 
 int proc_doulongvec_minmax(ctl_table *table, int write, struct file *filp,
-		    void *buffer, size_t *lenp)
+		    void *buffer, size_t *lenp, loff_t *ppos)
 {
 	return -ENOSYS;
 }
 
 int proc_doulongvec_ms_jiffies_minmax(ctl_table *table, int write,
-				      struct file *filp,
-				      void *buffer, size_t *lenp)
+				      struct file *filp, void *buffer,
+				      size_t *lenp, loff_t *ppos)
 {
     return -ENOSYS;
 }
diff -Nru a/net/decnet/dn_dev.c b/net/decnet/dn_dev.c
--- a/net/decnet/dn_dev.c	Fri Aug  2 12:56:17 2002
+++ b/net/decnet/dn_dev.c	Fri Aug  2 12:56:17 2002
@@ -155,7 +155,7 @@
 static int max_priority[] = { 127 }; /* From DECnet spec */
 
 static int dn_forwarding_proc(ctl_table *, int, struct file *,
-			void *, size_t *);
+			void *, size_t *, loff_t *ppos);
 static int dn_forwarding_sysctl(ctl_table *table, int *name, int nlen,
 			void *oldval, size_t *oldlenp,
 			void *newval, size_t newlen,
@@ -251,8 +251,8 @@
 
 
 static int dn_forwarding_proc(ctl_table *table, int write, 
-				struct file *filep,
-				void *buffer, size_t *lenp)
+				struct file *filep, void *buffer,
+				size_t *lenp, loff_t *ppos)
 {
 #ifdef CONFIG_DECNET_ROUTER
 	struct net_device *dev = table->extra1;
@@ -266,7 +266,7 @@
 	dn_db = dev->dn_ptr;
 	old = dn_db->parms.forwarding;
 
-	err = proc_dointvec(table, write, filep, buffer, lenp);
+	err = proc_dointvec(table, write, filep, buffer, lenp, ppos);
 
 	if ((err >= 0) && write) {
 		if (dn_db->parms.forwarding < 0)
diff -Nru a/net/decnet/sysctl_net_decnet.c b/net/decnet/sysctl_net_decnet.c
--- a/net/decnet/sysctl_net_decnet.c	Fri Aug  2 12:56:17 2002
+++ b/net/decnet/sysctl_net_decnet.c	Fri Aug  2 12:56:17 2002
@@ -160,14 +160,14 @@
 }
 
 static int dn_node_address_handler(ctl_table *table, int write, 
-				struct file *filp,
-				void *buffer, size_t *lenp)
+				struct file *filp, void *buffer,
+				size_t *lenp, loff_t *ppos)
 {
 	char addr[DN_ASCBUF_LEN];
 	size_t len;
 	dn_address dnaddr;
 
-	if (!*lenp || (filp->f_pos && !write)) {
+	if (!*lenp || (*ppos && !write)) {
 		*lenp = 0;
 		return 0;
 	}
@@ -191,7 +191,7 @@
 
 		dn_dev_devices_on();
 
-		filp->f_pos += len;
+		*ppos += len;
 
 		return 0;
 	}
@@ -206,7 +206,7 @@
 		return -EFAULT;
 
 	*lenp = len;
-	filp->f_pos += len;
+	*ppos += len;
 
 	return 0;
 }
@@ -264,15 +264,15 @@
 }
 
 
-static int dn_def_dev_handler(ctl_table *table, int write, 
-				struct file * filp,
-				void *buffer, size_t *lenp)
+static int dn_def_dev_handler(ctl_table *table, int write,
+			      struct file * filp, void *buffer,
+			      size_t *lenp, loff_t *ppos)
 {
 	size_t len;
 	struct net_device *dev = decnet_default_device;
 	char devname[17];
 
-	if (!*lenp || (filp->f_pos && !write)) {
+	if (!*lenp || (*ppos && !write)) {
 		*lenp = 0;
 		return 0;
 	}
@@ -294,7 +294,7 @@
 			return -ENODEV;
 
 		decnet_default_device = dev;
-		filp->f_pos += *lenp;
+		*ppos += *lenp;
 
 		return 0;
 	}
@@ -314,7 +314,7 @@
 		return -EFAULT;
 
 	*lenp = len;
-	filp->f_pos += len;
+	*ppos += len;
 
 	return 0;
 }
diff -Nru a/net/ipv4/devinet.c b/net/ipv4/devinet.c
--- a/net/ipv4/devinet.c	Fri Aug  2 12:56:17 2002
+++ b/net/ipv4/devinet.c	Fri Aug  2 12:56:17 2002
@@ -1023,11 +1023,11 @@
 
 static int devinet_sysctl_forward(ctl_table *ctl, int write,
 				  struct file* filp, void *buffer,
-				  size_t *lenp)
+				  size_t *lenp, loff_t *ppos)
 {
 	int *valp = ctl->data;
 	int val = *valp;
-	int ret = proc_dointvec(ctl, write, filp, buffer, lenp);
+	int ret = proc_dointvec(ctl, write, filp, buffer, lenp, ppos);
 
 	if (write && *valp != val) {
 		if (valp == &ipv4_devconf.forwarding)
diff -Nru a/net/ipv4/route.c b/net/ipv4/route.c
--- a/net/ipv4/route.c	Fri Aug  2 12:56:17 2002
+++ b/net/ipv4/route.c	Fri Aug  2 12:56:17 2002
@@ -2240,10 +2240,10 @@
 
 static int ipv4_sysctl_rtcache_flush(ctl_table *ctl, int write,
 					struct file *filp, void *buffer,
-					size_t *lenp)
+					size_t *lenp, loff_t *ppos)
 {
 	if (write) {
-		proc_dointvec(ctl, write, filp, buffer, lenp);
+		proc_dointvec(ctl, write, filp, buffer, lenp, ppos);
 		rt_cache_flush(flush_delay);
 		return 0;
 	} 
diff -Nru a/net/ipv4/sysctl_net_ipv4.c b/net/ipv4/sysctl_net_ipv4.c
--- a/net/ipv4/sysctl_net_ipv4.c	Fri Aug  2 12:56:17 2002
+++ b/net/ipv4/sysctl_net_ipv4.c	Fri Aug  2 12:56:17 2002
@@ -59,12 +59,12 @@
 
 static
 int ipv4_sysctl_forward(ctl_table *ctl, int write, struct file * filp,
-			void *buffer, size_t *lenp)
+			void *buffer, size_t *lenp, loff_t *ppos)
 {
 	int val = ipv4_devconf.forwarding;
 	int ret;
 
-	ret = proc_dointvec(ctl, write, filp, buffer, lenp);
+	ret = proc_dointvec(ctl, write, filp, buffer, lenp, ppos);
 
 	if (write && ipv4_devconf.forwarding != val)
 		inet_forward_change();
diff -Nru a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
--- a/net/ipv6/addrconf.c	Fri Aug  2 12:56:17 2002
+++ b/net/ipv6/addrconf.c	Fri Aug  2 12:56:17 2002
@@ -1843,13 +1843,13 @@
 
 static
 int addrconf_sysctl_forward(ctl_table *ctl, int write, struct file * filp,
-			   void *buffer, size_t *lenp)
+			   void *buffer, size_t *lenp, loff_t *ppos)
 {
 	int *valp = ctl->data;
 	int val = *valp;
 	int ret;
 
-	ret = proc_dointvec(ctl, write, filp, buffer, lenp);
+	ret = proc_dointvec(ctl, write, filp, buffer, lenp, ppos);
 
 	if (write && *valp != val && valp != &ipv6_devconf_dflt.forwarding) {
 		struct inet6_dev *idev = NULL;
diff -Nru a/net/ipv6/route.c b/net/ipv6/route.c
--- a/net/ipv6/route.c	Fri Aug  2 12:56:17 2002
+++ b/net/ipv6/route.c	Fri Aug  2 12:56:17 2002
@@ -1868,10 +1868,10 @@
 
 static
 int ipv6_sysctl_rtcache_flush(ctl_table *ctl, int write, struct file * filp,
-			      void *buffer, size_t *lenp)
+			      void *buffer, size_t *lenp, loff_t *ppos)
 {
 	if (write) {
-		proc_dointvec(ctl, write, filp, buffer, lenp);
+		proc_dointvec(ctl, write, filp, buffer, lenp, ppos);
 		if (flush_delay < 0)
 			flush_delay = 0;
 		fib6_run_gc((unsigned long)flush_delay);
diff -Nru a/net/irda/irsysctl.c b/net/irda/irsysctl.c
--- a/net/irda/irsysctl.c	Fri Aug  2 12:56:17 2002
+++ b/net/irda/irsysctl.c	Fri Aug  2 12:56:17 2002
@@ -79,11 +79,11 @@
  * us on that - Jean II */
 
 static int do_devname(ctl_table *table, int write, struct file *filp,
-		      void *buffer, size_t *lenp)
+		      void *buffer, size_t *lenp, loff_t *ppos)
 {
 	int ret;
 
-	ret = proc_dostring(table, write, filp, buffer, lenp);
+	ret = proc_dostring(table, write, filp, buffer, lenp, ppos);
 	if (ret == 0 && write) {
 		struct ias_value *val;
 
diff -Nru a/net/sunrpc/sysctl.c b/net/sunrpc/sysctl.c
--- a/net/sunrpc/sysctl.c	Fri Aug  2 12:56:17 2002
+++ b/net/sunrpc/sysctl.c	Fri Aug  2 12:56:17 2002
@@ -58,14 +58,14 @@
 }
 
 static int
-proc_dodebug(ctl_table *table, int write, struct file *file,
-				void *buffer, size_t *lenp)
+proc_dodebug(ctl_table *table, int write, struct file *file, void *buffer,
+	     size_t *lenp, loff_t *ppos)
 {
 	char		tmpbuf[20], *p, c;
 	unsigned int	value;
 	size_t		left, len;
 
-	if ((file->f_pos && !write) || !*lenp) {
+	if ((*ppos && !write) || !*lenp) {
 		*lenp = 0;
 		return 0;
 	}
@@ -112,7 +112,7 @@
 
 done:
 	*lenp -= left;
-	file->f_pos += *lenp;
+	*ppos += *lenp;
 	return 0;
 }
 
