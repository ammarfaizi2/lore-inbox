Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266981AbTB0U2y>; Thu, 27 Feb 2003 15:28:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267013AbTB0U2p>; Thu, 27 Feb 2003 15:28:45 -0500
Received: from inmail.compaq.com ([161.114.1.205]:1546 "EHLO
	ztxmail01.ztx.compaq.com") by vger.kernel.org with ESMTP
	id <S266981AbTB0U1I>; Thu, 27 Feb 2003 15:27:08 -0500
Date: Thu, 27 Feb 2003 14:39:53 +0600
From: Stephen Cameron <steve.cameron@hp.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.63 cciss fix unlikely startup problem
Message-ID: <20030227083953.GA3992@zuul.cca.cpqcorp.net>
Reply-To: steve.cameron@hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Another cciss patch for 2.5.63

Add new big passthrough ioctl to allow large buffers.
Used by e.g. online array controller firmware flash utility.

-- steve

--- linux-2.5.63/drivers/block/cciss.c~bigioctl	2003-02-27 14:11:56.000000000 +0600
+++ linux-2.5.63-scameron/drivers/block/cciss.c	2003-02-27 14:11:56.000000000 +0600
@@ -728,7 +728,153 @@ static int cciss_ioctl(struct inode *ino
 		cmd_free(h, c, 0);
                 return(0);
 	} 
-
+	case CCISS_BIG_PASSTHRU: {
+		BIG_IOCTL_Command_struct *ioc;
+		ctlr_info_t *h = hba[ctlr];
+		CommandList_struct *c;
+		unsigned char **buff = NULL;
+		int	*buff_size = NULL;
+		u64bit	temp64;
+		unsigned long flags;
+		BYTE sg_used = 0;
+		int status = 0;
+		int i;
+		DECLARE_COMPLETION(wait);
+		__u32   left;
+		__u32	sz;
+		BYTE    *data_ptr;
+
+		if (!arg)
+			return -EINVAL;
+		if (!capable(CAP_SYS_RAWIO))
+			return -EPERM;
+		ioc = (BIG_IOCTL_Command_struct *) 
+			kmalloc(sizeof(*ioc), GFP_KERNEL);
+		if (!ioc) {
+			status = -ENOMEM;
+			goto cleanup1;
+		}
+		if (copy_from_user(ioc, (void *) arg, sizeof(*ioc)))
+			return -EFAULT;
+		if ((ioc->buf_size < 1) &&
+			(ioc->Request.Type.Direction != XFER_NONE))
+				return -EINVAL;
+		/* Check kmalloc limits  using all SGs */
+		if (ioc->malloc_size > MAX_KMALLOC_SIZE)
+			return -EINVAL;
+		if (ioc->buf_size > ioc->malloc_size * MAXSGENTRIES)
+			return -EINVAL;
+		buff = (unsigned char **) kmalloc(MAXSGENTRIES * 
+				sizeof(char *), GFP_KERNEL);
+		if (!buff) {
+			status = -ENOMEM;
+			goto cleanup1;
+		}
+		memset(buff, 0, MAXSGENTRIES);
+		buff_size = (int *) kmalloc(MAXSGENTRIES * sizeof(int), 
+					GFP_KERNEL);
+		if (!buff_size) {
+			status = -ENOMEM;
+			goto cleanup1;
+		}
+		left = ioc->buf_size;
+		data_ptr = (BYTE *) ioc->buf;
+		while (left) {
+			sz = (left > ioc->malloc_size) ? ioc->malloc_size : left;
+			buff_size[sg_used] = sz;
+			buff[sg_used] = kmalloc(sz, GFP_KERNEL);
+			if (buff[sg_used] == NULL) {
+				status = -ENOMEM;
+				goto cleanup1;
+			}
+			if (ioc->Request.Type.Direction == XFER_WRITE &&
+				copy_from_user(buff[sg_used], data_ptr, sz)) {
+					status = -ENOMEM;
+					goto cleanup1;			
+			}
+			left -= sz;
+			data_ptr += sz;
+			sg_used++;
+		}
+		if ((c = cmd_alloc(h , 0)) == NULL) {
+			status = -ENOMEM;
+			goto cleanup1;	
+		}
+		c->cmd_type = CMD_IOCTL_PEND;
+		c->Header.ReplyQueue = 0;
+		
+		if( ioc->buf_size > 0) {
+			c->Header.SGList = sg_used;
+			c->Header.SGTotal= sg_used;
+		} else { 
+			c->Header.SGList = 0;
+			c->Header.SGTotal= 0;
+		}
+		c->Header.LUN = ioc->LUN_info;
+		c->Header.Tag.lower = c->busaddr;
+		
+		c->Request = ioc->Request;
+		if (ioc->buf_size > 0 ) {
+			int i;
+			for(i=0; i<sg_used; i++) {
+				temp64.val = pci_map_single( h->pdev, buff[i],
+					buff_size[i],
+					PCI_DMA_BIDIRECTIONAL);
+				c->SG[i].Addr.lower = temp64.val32.lower;
+				c->SG[i].Addr.upper = temp64.val32.upper;
+				c->SG[i].Len = buff_size[i];
+				c->SG[i].Ext = 0;  /* we are not chaining */
+			}
+		}
+		c->waiting = &wait;
+		/* Put the request on the tail of the request queue */
+		spin_lock_irqsave(CCISS_LOCK(ctlr), flags);
+		addQ(&h->reqQ, c);
+		h->Qdepth++;
+		start_io(h);
+		spin_unlock_irqrestore(CCISS_LOCK(ctlr), flags);
+		wait_for_completion(&wait);
+		/* unlock the buffers from DMA */
+		for(i=0; i<sg_used; i++) {
+			temp64.val32.lower = c->SG[i].Addr.lower;
+			temp64.val32.upper = c->SG[i].Addr.upper;
+			pci_unmap_single( h->pdev, (dma_addr_t) temp64.val,
+				buff_size[i], PCI_DMA_BIDIRECTIONAL);
+		}
+		/* Copy the error information out */
+		ioc->error_info = *(c->err_info);
+		if (copy_to_user((void *) arg, ioc, sizeof(*ioc))) {
+			cmd_free(h, c, 0);
+			status = -EFAULT;
+			goto cleanup1;
+		}
+		if (ioc->Request.Type.Direction == XFER_READ) {
+			/* Copy the data out of the buffer we created */
+			BYTE *ptr = (BYTE  *) ioc->buf;
+	        	for(i=0; i< sg_used; i++) {
+				if (copy_to_user(ptr, buff[i], buff_size[i])) {
+					cmd_free(h, c, 0);
+					status = -EFAULT;
+					goto cleanup1;
+				}
+				ptr += buff_size[i];
+			}
+		}
+		cmd_free(h, c, 0);
+		status = 0;
+cleanup1:
+		if (buff) {
+			for(i=0; i<sg_used; i++)
+				if(buff[i] != NULL)
+					kfree(buff[i]);
+			kfree(buff);
+		}
+		if (buff_size)
+			kfree(buff_size);
+		if (ioc)
+			kfree(ioc);
+		return(status);
+	}
 	default:
 		return -EBADRQC;
 	}
--- linux-2.5.63/include/linux/cciss_ioctl.h~bigioctl	2003-02-27 14:11:56.000000000 +0600
+++ linux-2.5.63-scameron/include/linux/cciss_ioctl.h	2003-02-27 14:11:56.000000000 +0600
@@ -33,6 +33,18 @@ typedef __u32 BusTypes_type;
 typedef char FirmwareVer_type[4];
 typedef __u32 DriverVer_type;
 
+#define MAX_KMALLOC_SIZE 128000
+
+typedef struct _BIG_IOCTL_Command_struct {
+  LUNAddr_struct	   LUN_info;
+  RequestBlock_struct      Request;
+  ErrorInfo_struct  	   error_info; 
+  DWORD			   malloc_size; /* < MAX_KMALLOC_SIZE in cciss.c */
+  DWORD			   buf_size;    /* size in bytes of the buf */
+  				        /* < malloc_size * MAXSGENTRIES */
+  BYTE			   *buf;
+} BIG_IOCTL_Command_struct;
+
 
 #ifndef CCISS_CMD_H
 // This defines are duplicated in cciss_cmd.h in the driver directory 
@@ -196,5 +208,6 @@ typedef struct _LogvolInfo_struct{
 
 #define CCISS_REGNEWD	   _IO(CCISS_IOC_MAGIC, 14)
 #define CCISS_GETLUNINFO   _IOR(CCISS_IOC_MAGIC, 17, LogvolInfo_struct)
+#define CCISS_BIG_PASSTHRU _IOWR(CCISS_IOC_MAGIC, 18, BIG_IOCTL_Command_struct)
 
 #endif  

_
