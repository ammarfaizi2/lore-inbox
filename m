Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317299AbSGIDep>; Mon, 8 Jul 2002 23:34:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316991AbSGIDeo>; Mon, 8 Jul 2002 23:34:44 -0400
Received: from ns3.maptuit.com ([204.138.244.3]:62472 "EHLO gear.torque.net")
	by vger.kernel.org with ESMTP id <S316989AbSGIDeg>;
	Mon, 8 Jul 2002 23:34:36 -0400
Message-ID: <3D2A5858.5EE5EF09@torque.net>
Date: Mon, 08 Jul 2002 23:28:24 -0400
From: Douglas Gilbert <dougg@torque.net>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.25 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
       Andrew Morton <akpm@zip.com.au>
Subject: [PATCH] sg driver against lk 2.5.25
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,
This patch is against lk 2.5.25 . It 
  - fixes copy_from/to_user() [William Stinson from dj tree]
  - disables kiobuf use, so it will compile without kiobufs

The latter change is so Andrew Morton can remove kiobufs
as suggested in his "direct-to-BIO for O_DIRECT" thread.

Doug Gilbert


--- linux/include/scsi/sg.h	Thu May  9 22:40:42 2002
+++ linux/include/scsi/sg.h3526	Mon Jul  8 23:10:14 2002
@@ -11,24 +11,15 @@
 Version 2 and 3 extensions to driver:
 *       Copyright (C) 1998 - 2002 Douglas Gilbert
 
-    Version: 3.5.25 (20020504)
+    Version: 3.5.26 (20020708)
     This version is for 2.5 series kernels.
 
-    Changes since 3.5.24 (20020319)
-	- off by one fix for last scatter gather element
-	- if possible compact kiobuf_map into scatter gather list
-	- use Scsi_Request::upper_private_data
-	- zero buffers for non-root users
-    Changes since 3.5.23 (20011231)
-	- change EACCES to EPERM when O_RDONLY is insufficient
-	- suppress newlines in host string
-	- fix xfer direction, old interface, short reply_len [Travers Carter]
-    Changes since 3.1.22 (20011208)
-    	- branch sg driver for lk 2.5 series
-    	- remove lock_kernel() from sg_close()
-    	- remove code based on scsi mid level dma pool
-    	- change scatterlist 'address' to use page + offset
-    	- add SG_INTERFACE_ID_ORIG
+    Changes since 3.5.25 (20020504)
+	- driverfs additions
+	- copy_to/from_user() fixes [William Stinson]
+	- disable kiobufs support
+
+    For a full changelog see http://www.torque.net/sg
 
 Map of SG verions to the Linux kernels in which they appear:
        ----------        ----------------------------------
--- linux/drivers/scsi/sg.c	Sat Jul  6 08:57:35 2002
+++ linux/drivers/scsi/sg.c3526	Mon Jul  8 21:49:40 2002
@@ -19,7 +19,7 @@
  */
 #include <linux/config.h>
 #ifdef CONFIG_PROC_FS
- static char * sg_version_str = "Version: 3.5.25 (20020504)";
+ static char * sg_version_str = "Version: 3.5.26 (20020708)";
 #endif
  static int sg_version_num = 30525; /* 2 digits for each component */
 /*
@@ -77,12 +77,12 @@
 #endif /* LINUX_VERSION_CODE */
 
 #define SG_ALLOW_DIO_DEF 0
-#define SG_ALLOW_DIO_CODE	/* compile out be commenting this define */
+/* #define SG_ALLOW_DIO_CODE */	/* compile out be commenting this define */
 #ifdef SG_ALLOW_DIO_CODE
 #include <linux/iobuf.h>
+#define SG_NEW_KIOVEC 0	/* use alloc_kiovec(), not alloc_kiovec_sz() */
 #endif
 
-#define SG_NEW_KIOVEC 0	/* use alloc_kiovec(), not alloc_kiovec_sz() */
 
 #define SG_MAX_DEVS_MASK ((1U << KDEV_MINOR_BITS) - 1)
 
@@ -138,8 +138,10 @@
     unsigned bufflen;           /* Size of (aggregate) data buffer */
     unsigned b_malloc_len;      /* actual len malloc'ed in buffer */
     void * buffer;              /* Data buffer or scatter list + mem_src_arr */
+#ifdef SG_ALLOW_DIO_CODE
     struct kiobuf * kiobp;      /* for direct IO information */
     char mapped;                /* indicates kiobp has locked pages */
+#endif
     char buffer_mem_src;        /* heap whereabouts of 'buffer' */
     unsigned char cmd_opcode;   /* first byte of command */
 } Sg_scatter_hold;    /* 24 bytes long on i386 */
@@ -215,7 +217,7 @@
 		      int wr_xf, int * countp, unsigned char ** up);
 static int sg_write_xfer(Sg_request * srp);
 static int sg_read_xfer(Sg_request * srp);
-static void sg_read_oxfer(Sg_request * srp, char * outp, int num_read_xfer);
+static int sg_read_oxfer(Sg_request * srp, char * outp, int num_read_xfer);
 static void sg_remove_scat(Sg_scatter_hold * schp);
 static char * sg_get_sgat_msa(Sg_scatter_hold * schp);
 static void sg_build_reserve(Sg_fd * sfp, int req_size);
@@ -240,12 +242,14 @@
 static int sg_build_dir(Sg_request * srp, Sg_fd * sfp, int dxfer_len);
 static void sg_unmap_and(Sg_scatter_hold * schp, int free_also);
 static Sg_device * sg_get_dev(int dev);
-static inline int sg_alloc_kiovec(int nr, struct kiobuf **bufp, int *szp);
-static inline void sg_free_kiovec(int nr, struct kiobuf **bufp, int *szp);
 static inline unsigned char * sg_scatg2virt(const struct scatterlist * sclp);
 #ifdef CONFIG_PROC_FS
 static int sg_last_dev(void);
 #endif
+#ifdef SG_ALLOW_DIO_CODE
+static inline int sg_alloc_kiovec(int nr, struct kiobuf **bufp, int *szp);
+static inline void sg_free_kiovec(int nr, struct kiobuf **bufp, int *szp);
+#endif
 
 static Sg_device ** sg_dev_arr = NULL;
 
@@ -377,10 +381,12 @@
     if ((k = verify_area(VERIFY_WRITE, buf, count)))
         return k;
     if (sfp->force_packid && (count >= SZ_SG_HEADER)) {
-	__copy_from_user(&old_hdr, buf, SZ_SG_HEADER);
+	if (__copy_from_user(&old_hdr, buf, SZ_SG_HEADER))
+	    return -EFAULT;
 	if (old_hdr.reply_len < 0) {
 	    if (count >= SZ_SG_IO_HDR) {
-		__copy_from_user(&new_hdr, buf, SZ_SG_IO_HDR);
+		if (__copy_from_user(&new_hdr, buf, SZ_SG_IO_HDR))
+		    return -EFAULT;
 		req_pack_id = new_hdr.pack_id;
 	    }
 	}
@@ -452,12 +458,15 @@
 
     /* Now copy the result back to the user buffer.  */
     if (count >= SZ_SG_HEADER) {
-	__copy_to_user(buf, &old_hdr, SZ_SG_HEADER);
-        buf += SZ_SG_HEADER;
+	if (__copy_to_user(buf, &old_hdr, SZ_SG_HEADER))
+	    return -EFAULT;
+	buf += SZ_SG_HEADER;
 	if (count > old_hdr.reply_len)
 	    count = old_hdr.reply_len;
-	if (count > SZ_SG_HEADER)
-	    sg_read_oxfer(srp, buf, count - SZ_SG_HEADER);
+	if (count > SZ_SG_HEADER) {
+	    if ((res = sg_read_oxfer(srp, buf, count - SZ_SG_HEADER)))
+		return -EFAULT;
+	}
     }
     else
 	count = (old_hdr.result == 0) ? 0 : -EIO;
@@ -486,13 +495,19 @@
 	    len = (len > sb_len) ? sb_len : len;
 	    if ((err = verify_area(VERIFY_WRITE, hp->sbp, len)))
 		goto err_out;
-	    __copy_to_user(hp->sbp, srp->sense_b, len);
+	    if (__copy_to_user(hp->sbp, srp->sense_b, len)) {
+		err = -EFAULT;
+		goto err_out;
+	    }
 	    hp->sb_len_wr = len;
 	}
     }
     if (hp->masked_status || hp->host_status || hp->driver_status)
 	hp->info |= SG_INFO_CHECK;
-    copy_to_user(buf, hp, SZ_SG_IO_HDR);
+    if (copy_to_user(buf, hp, SZ_SG_IO_HDR)) {
+	err = -EFAULT;
+	goto err_out;
+    }
     err = sg_read_xfer(srp);
 err_out:
     sg_finish_rem_req(srp);
@@ -529,7 +544,8 @@
         return k;  /* protects following copy_from_user()s + get_user()s */
     if (count < SZ_SG_HEADER)
 	return -EIO;
-    __copy_from_user(&old_hdr, buf, SZ_SG_HEADER);
+    if (__copy_from_user(&old_hdr, buf, SZ_SG_HEADER))
+	return -EFAULT;
     blocking = !(filp->f_flags & O_NONBLOCK);
     if (old_hdr.reply_len < 0)
 	return sg_new_write(sfp, buf, count, blocking, 0, NULL);
@@ -587,7 +603,8 @@
     hp->flags = input_size;             /* structure abuse ... */
     hp->pack_id = old_hdr.pack_id;
     hp->usr_ptr = NULL;
-    __copy_from_user(cmnd, buf, cmd_size);
+    if (__copy_from_user(cmnd, buf, cmd_size))
+	return -EFAULT;
     k = sg_common_write(sfp, srp, cmnd, sfp->timeout, blocking);
     return (k < 0) ? k : count;
 }
@@ -612,7 +629,10 @@
 	return -EDOM;
     }
     hp = &srp->header;
-    __copy_from_user(hp, buf, SZ_SG_IO_HDR);
+    if (__copy_from_user(hp, buf, SZ_SG_IO_HDR)) {
+	sg_remove_request(sfp, srp);
+	return -EFAULT;
+    }
     if (hp->interface_id != 'S') {
 	sg_remove_request(sfp, srp);
 	return -ENOSYS;
@@ -640,7 +660,10 @@
 	sg_remove_request(sfp, srp);
 	return k;  /* protects following copy_from_user()s + get_user()s */
     }
-    __copy_from_user(cmnd, hp->cmdp, hp->cmd_len);
+    if (__copy_from_user(cmnd, hp->cmdp, hp->cmd_len)) {
+	sg_remove_request(sfp, srp);
+	return -EFAULT;
+    }
     if (read_only &&
 	(! sg_allow_access(cmnd[0], sfp->parentdp->device->type))) {
 	sg_remove_request(sfp, srp);
@@ -923,8 +946,8 @@
 		}
 	    }
 	    read_unlock_irqrestore(&sfp->rq_list_lock, iflags);
-	    __copy_to_user((void *)arg, rinfo, SZ_SG_REQ_INFO * SG_MAX_QUEUE);
-	    return 0;
+	    return (__copy_to_user((void *)arg, rinfo, 
+			SZ_SG_REQ_INFO * SG_MAX_QUEUE) ? -EFAULT : 0);
 	}
     case SG_EMULATED_HOST:
 	if (sdp->detached)
@@ -972,7 +995,8 @@
 	    unsigned char opcode = WRITE_6;
 	    Scsi_Ioctl_Command * siocp = (void *)arg;
 
-	    copy_from_user(&opcode, siocp->data, 1);
+	    if (copy_from_user(&opcode, siocp->data, 1))
+		return -EFAULT;
 	    if (! sg_allow_access(opcode, sdp->device->type))
 		return -EPERM;
 	}
@@ -1897,7 +1921,8 @@
 		res = sg_u_iovec(hp, iovec_count, j, 1, &usglen, &up);
 		if (res) return res;
 		usglen = (num_xfer > usglen) ? usglen : num_xfer;
-		__copy_from_user(p, up, usglen);
+		if (__copy_from_user(p, up, usglen))
+		    return -EFAULT;
 		p += usglen;
 		num_xfer -= usglen;
 		if (num_xfer <= 0)
@@ -1925,20 +1950,32 @@
 		    break;
 		if (ksglen > usglen) {
 		    if (usglen >= num_xfer) {
-			if (ok) __copy_from_user(p, up, num_xfer);
+			if (ok) {
+			   if (__copy_from_user(p, up, num_xfer))
+				return -EFAULT;
+			}
 			return 0;
 		    }
-		    if (ok) __copy_from_user(p, up, usglen);
+		    if (ok) {
+			if (__copy_from_user(p, up, usglen))
+			    return -EFAULT;
+		    }
 		    p += usglen;
 		    ksglen -= usglen;
                     break;
 		}
 		else {
 		    if (ksglen >= num_xfer) {
-			if (ok) __copy_from_user(p, up, num_xfer);
+			if (ok) {
+			    if (__copy_from_user(p, up, num_xfer))
+				return -EFAULT;
+			}
 			return 0;
 		    }
-		    if (ok) __copy_from_user(p, up, ksglen);
+		    if (ok) {
+			if (__copy_from_user(p, up, ksglen))
+			    return -EFAULT;
+		    }
 		    up += ksglen;
 		    usglen -= ksglen;
 		}
@@ -1964,9 +2001,10 @@
 	    count = num_xfer;
     }
     else {
-	__copy_from_user(&u_iovec,
+	if (__copy_from_user(&u_iovec,
 			 (unsigned char *)hp->dxferp + (ind * SZ_SG_IOVEC),
-			 SZ_SG_IOVEC);
+			 SZ_SG_IOVEC))
+	    return -EFAULT;
 	p = (unsigned char *)u_iovec.iov_base;
 	count = (int)u_iovec.iov_len;
     }
@@ -2050,7 +2088,8 @@
 		res = sg_u_iovec(hp, iovec_count, j, 0, &usglen, &up);
 		if (res) return res;
 		usglen = (num_xfer > usglen) ? usglen : num_xfer;
-		__copy_to_user(up, p, usglen);
+		if (__copy_to_user(up, p, usglen))
+		    return -EFAULT;
 		p += usglen;
 		num_xfer -= usglen;
 		if (num_xfer <= 0)
@@ -2078,20 +2117,32 @@
 		    break;
 		if (ksglen > usglen) {
 		    if (usglen >= num_xfer) {
-			if (ok) __copy_to_user(up, p, num_xfer);
+			if (ok) {
+			    if (__copy_to_user(up, p, num_xfer))
+				return -EFAULT;
+			}
 			return 0;
 		    }
-		    if (ok) __copy_to_user(up, p, usglen);
+		    if (ok) {
+			if (__copy_to_user(up, p, usglen))
+			    return -EFAULT;
+		    }
 		    p += usglen;
 		    ksglen -= usglen;
 		    break;
 		}
 		else {
 		    if (ksglen >= num_xfer) {
-			if (ok) __copy_to_user(up, p, num_xfer);
+			if (ok) {
+			    if (__copy_to_user(up, p, num_xfer))
+				return -EFAULT;
+			}
 			return 0;
 		    }
-		    if (ok) __copy_to_user(up, p, ksglen);
+		    if (ok) {
+			if (__copy_to_user(up, p, ksglen))
+			    return -EFAULT;
+		    }
 		    up += ksglen;
 		    usglen -= ksglen;
 		}
@@ -2101,14 +2152,14 @@
     return 0;
 }
 
-static void sg_read_oxfer(Sg_request * srp, char * outp, int num_read_xfer)
+static int sg_read_oxfer(Sg_request * srp, char * outp, int num_read_xfer)
 {
     Sg_scatter_hold * schp = &srp->data;
 
     SCSI_LOG_TIMEOUT(4, printk("sg_read_oxfer: num_read_xfer=%d\n",
 			       num_read_xfer));
     if ((! outp) || (num_read_xfer <= 0))
-        return;
+        return 0;
     if(schp->k_use_sg > 0) {
         int k, num;
         struct scatterlist * sclp = (struct scatterlist *)schp->buffer;
@@ -2116,11 +2167,13 @@
 	for (k = 0; (k < schp->k_use_sg) && sg_scatg2virt(sclp); ++k, ++sclp) {
             num = (int)sclp->length;
             if (num > num_read_xfer) {
-                __copy_to_user(outp, sg_scatg2virt(sclp), num_read_xfer);
+                if (__copy_to_user(outp, sg_scatg2virt(sclp), num_read_xfer))
+		    return -EFAULT;
                 break;
             }
             else {
-                __copy_to_user(outp, sg_scatg2virt(sclp), num);
+                if (__copy_to_user(outp, sg_scatg2virt(sclp), num))
+		    return -EFAULT;
                 num_read_xfer -= num;
                 if (num_read_xfer <= 0)
                     break;
@@ -2128,8 +2181,11 @@
             }
         }
     }
-    else
-        __copy_to_user(outp, schp->buffer, num_read_xfer);
+    else {
+        if (__copy_to_user(outp, schp->buffer, num_read_xfer))
+	    return -EFAULT;
+    }
+    return 0;
 }
 
 static void sg_build_reserve(Sg_fd * sfp, int req_size)
@@ -2294,7 +2350,9 @@
         resp->nextrp = NULL;
 	resp->header.duration = jiffies;
         resp->my_cmdp = NULL;
+#ifdef SG_ALLOW_DIO_CODE
 	resp->data.kiobp = NULL;
+#endif
     }
     write_unlock_irqrestore(&sfp->rq_list_lock, iflags);
     return resp;
@@ -2560,6 +2618,7 @@
     return resp;
 }
 
+#ifdef SG_ALLOW_DIO_CODE
 static inline int sg_alloc_kiovec(int nr, struct kiobuf **bufp, int *szp)
 {
 #if SG_NEW_KIOVEC
@@ -2568,6 +2627,7 @@
     return alloc_kiovec(nr, bufp);
 #endif
 }
+#endif
 
 static void sg_low_free(char * buff, int size, int mem_src)
 {
@@ -2604,6 +2664,7 @@
         sg_low_free(buff, size, mem_src);
 }
 
+#ifdef SG_ALLOW_DIO_CODE
 static inline void sg_free_kiovec(int nr, struct kiobuf **bufp, int *szp)
 {
 #if SG_NEW_KIOVEC
@@ -2612,6 +2673,7 @@
     free_kiovec(nr, bufp);
 #endif
 }
+#endif
 
 static int sg_ms_to_jif(unsigned int msecs)
 {
@@ -2820,7 +2882,8 @@
     if (!capable(CAP_SYS_ADMIN) || !capable(CAP_SYS_RAWIO))
 	return -EACCES;
     num = (count < 10) ? count : 10;
-    copy_from_user(buff, buffer, num);
+    if (copy_from_user(buff, buffer, num))
+	return -EFAULT;
     buff[num] = '\0';
     sg_allow_dio = simple_strtoul(buff, 0, 10) ? 1 : 0;
     return count;
@@ -2847,10 +2910,11 @@
     if (!capable(CAP_SYS_ADMIN) || !capable(CAP_SYS_RAWIO))
 	return -EACCES;
     num = (count < 10) ? count : 10;
-    copy_from_user(buff, buffer, num);
+    if (copy_from_user(buff, buffer, num))
+	return -EFAULT;
     buff[num] = '\0';
     k = simple_strtoul(buff, 0, 10);
-    if (k <= 1048576) {
+    if (k <= 1048576) {		/* limit "big buff" to 1 MB */
 	sg_big_buff = k;
 	return count;
     }

