Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265794AbUA1B6e (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 20:58:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265809AbUA1B6D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 20:58:03 -0500
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:54731 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S265800AbUA1BzP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 20:55:15 -0500
Date: Wed, 28 Jan 2004 10:54:37 +0900
From: Hironobu Ishii <ishii.hironobu@jp.fujitsu.com>
Subject: [RFC/PATCH, 2/4] readX_check() performance evaluation
To: linux-kernel <linux-kernel@vger.kernel.org>,
       linux-ia64 <linux-ia64@vger.kernel.org>
Message-id: <00a301c3e541$c13a6350$2987110a@lsd.css.fujitsu.com>
MIME-version: 1.0
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
Content-type: text/plain;	charset="iso-8859-1"
Content-transfer-encoding: 7bit
X-Priority: 3
X-MSMail-priority: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a readX_check() prototype patch to evaluate
the performance disadvantage.

Thanks,
Hironobu Ishii
--------------------
diff -prN linux-2.6.1/drivers/message/fusion/Makefile linux-2.6.1.modified/drivers/message/fusion/Makefile
*** linux-2.6.1/drivers/message/fusion/Makefile 2004-01-09 15:59:45.000000000 +0900
--- linux-2.6.1.modified/drivers/message/fusion/Makefile 2004-01-26 20:25:21.691512363 +0900
***************
*** 15,20 ****
--- 15,23 ----
  
  EXTRA_CFLAGS += ${MPT_CFLAGS}
  
+ # for PCI_RECOVERY
+ EXTRA_CFLAGS += -DCONFIG_PCI_RECOVERY
+ 
  # Fusion MPT drivers; recognized debug defines...
  #  MPT general:
  #EXTRA_CFLAGS += -DDEBUG
*************** obj-$(CONFIG_FUSION)  += mptbase.o mptsc
*** 50,52 ****
--- 53,60 ----
  obj-$(CONFIG_FUSION_ISENSE) += isense.o
  obj-$(CONFIG_FUSION_CTL) += mptctl.o
  obj-$(CONFIG_FUSION_LAN) += mptlan.o
+ 
+ # for PCI error recovery
+ mptbase-objs := mptbase_main.o read_check.o
+ 
+ 
diff -prN linux-2.6.1/drivers/message/fusion/mptbase.c linux-2.6.1.modified/drivers/message/fusion/mptbase.c
*** linux-2.6.1/drivers/message/fusion/mptbase.c 2004-01-09 15:59:18.000000000 +0900
--- linux-2.6.1.modified/drivers/message/fusion/mptbase.c 2004-01-26 22:29:18.185561891 +0900
*************** struct _mpt_ioc_proc_list {
*** 260,265 ****
--- 260,305 ----
  
  #endif
  
+ 
+ #ifdef CONFIG_PCI_RECOVERY
+ /*
+  * Try to recover from PCI intermittent read errors
+  */
+ #define REG_READ_SUCCESS   0
+ 
+ #define REG_READ_OK        0
+ #define REG_READ_RETRY_OK  1
+ #define REG_READ_NG       -1
+ 
+ #define REG_READ_RETRY     5 /* retry limit */
+ 
+ extern inline int readl_check(volatile u32 *d, volatile u32 *a);
+ 
+ static inline int do_readl(volatile u32 *d, volatile u32 *a)
+ {
+  int  retry ;
+  int  fail = 0;
+ 
+  for (retry = REG_READ_RETRY; retry; retry--) {
+   if (readl_check(d, a) == REG_READ_SUCCESS) {
+    return (fail ? REG_READ_RETRY_OK : REG_READ_OK);
+   }
+   fail++;
+  }
+  /* retry out */
+  /* PCI reset? */
+  return REG_READ_NG;
+ }
+ 
+ static inline int CHIPREG_READ32(volatile u32 *d, volatile u32 *a)
+ {
+  if (PortIo) {
+   *d =inl((unsigned long)a);
+   return REG_READ_OK;
+  } else
+   return do_readl(d, a);
+ }
+ #else
  /*=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
  /* 20000207 -sralston
   *  GRRRRR...  IOSpace (port i/o) register access (for the 909) is back!
*************** static inline u32 CHIPREG_READ32(volatil
*** 274,279 ****
--- 314,320 ----
   else
    return readl(a);
  }
+ #endif
  
  static inline void CHIPREG_WRITE32(volatile u32 *a, u32 v)
  {
*************** mpt_interrupt(int irq, void *bus_id, str
*** 352,360 ****
    */
   while (1) {
  
    if ((pa = CHIPREG_READ32(&ioc->chip->ReplyFifo)) == 0xFFFFFFFF)
     return IRQ_HANDLED;
! 
    cb_idx = 0;
    freeme = 0;
  
--- 393,413 ----
    */
   while (1) {
  
+ #ifdef CONFIG_PCI_RECOVERY
+   {
+    int read_fail;
+    read_fail = CHIPREG_READ32(&pa, &ioc->chip->ReplyFifo);
+    if (read_fail) {
+     printk("PCI PIO read error:%d\n", read_fail);
+     /* recovery code */
+    }
+    if (pa == 0xFFFFFFFF)
+     return IRQ_HANDLED;
+   }
+ #else
    if ((pa = CHIPREG_READ32(&ioc->chip->ReplyFifo)) == 0xFFFFFFFF)
     return IRQ_HANDLED;
! #endif
    cb_idx = 0;
    freeme = 0;
  
*************** mpt_send_handshake_request(int handle, i
*** 1066,1073 ****
--- 1119,1140 ----
    }
  
    /* Read doorbell and check for active bit */
+ #ifdef CONFIG_PCI_RECOVERY
+   {
+      int read_fail;
+      u32 dummy;
+      read_fail = CHIPREG_READ32(&dummy, &iocp->chip->Doorbell);
+      if (read_fail) {
+       printk("PCI PIO read error:%d\n", read_fail);
+       /* recovery code */
+      }
+      if (!(dummy & MPI_DOORBELL_ACTIVE))
+       return -5;
+   }
+ #else
    if (!(CHIPREG_READ32(&iocp->chip->Doorbell) & MPI_DOORBELL_ACTIVE))
      return -5;
+ #endif
  
    dhsprintk((KERN_INFO MYNAM ": %s: mpt_send_handshake_request start, WaitCnt=%d\n",
      iocp->name, ii));
*************** mpt_GetIocState(MPT_ADAPTER *ioc, int co
*** 2170,2176 ****
--- 2237,2255 ----
   u32 s, sc;
  
   /*  Get!  */
+ #ifdef CONFIG_PCI_RECOVERY
+  {
+   int read_fail;
+   read_fail = CHIPREG_READ32(&s, &ioc->chip->Doorbell);
+   if (read_fail) {
+    printk("PCI PIO read error:%d\n", read_fail);
+    /* recovery code */
+   }
+  }
+ #else
   s = CHIPREG_READ32(&ioc->chip->Doorbell);
+ #endif
+ 
  // dprintk((MYIOC_s_INFO_FMT "raw state = %08x\n", ioc->name, s));
   sc = s & MPI_IOC_STATE_MASK;
  
*************** mpt_downloadboot(MPT_ADAPTER *ioc, int s
*** 2871,2879 ****
--- 2950,2981 ----
   ddlprintk((MYIOC_s_INFO_FMT "DbGb0: downloadboot entered.\n",
      ioc->name));
  #ifdef MPT_DEBUG
+ #ifdef CONFIG_PCI_RECOVERY
+  {
+   int read_fail ;
+   read_fail = CHIPREG_READ32(&diag0val, &ioc->chip->Diagnostic);
+   if (read_fail) {
+    printk("PCI PIO read error:%d\n", read_fail);
+    /* recovery codes */
+   }
+  }
+ #else
   diag0val = CHIPREG_READ32(&ioc->chip->Diagnostic);
+ #endif
+ 
+ #ifdef CONFIG_PCI_RECOVERY
+  if (ioc->alt_ioc) {
+   int read_fail ;
+   read_fail = CHIPREG_READ32(&diag1val, &ioc->alt_ioc->chip->Diagnostic);
+   if (read_fail) {
+    printk("PCI PIO read error:%d\n", read_fail);
+    /* recovery code */
+   }
+  }
+ #else
   if (ioc->alt_ioc)
    diag1val = CHIPREG_READ32(&ioc->alt_ioc->chip->Diagnostic);
+ #endif
   ddlprintk((MYIOC_s_INFO_FMT "DbGb1: diag0=%08x, diag1=%08x\n",
      ioc->name, diag0val, diag1val));
  #endif
*************** mpt_downloadboot(MPT_ADAPTER *ioc, int s
*** 2903,2909 ****
--- 3005,3023 ----
   /* Write magic sequence to WriteSequence register
    * until enter diagnostic mode
    */
+ #ifdef CONFIG_PCI_RECOVERY
+  {
+   int read_fail;
+   read_fail = CHIPREG_READ32(&diag0val, &ioc->chip->Diagnostic);
+   if (read_fail) {
+    printk("PCI PIO error:%d\n", read_fail);
+    /* recovery code */
+   }
+  }
+ #else
   diag0val = CHIPREG_READ32(&ioc->chip->Diagnostic);
+ #endif
+ 
   while ((diag0val & MPI_DIAG_DRWE) == 0) {
    CHIPREG_WRITE32(&ioc->chip->WriteSequence, 0xFF);
    CHIPREG_WRITE32(&ioc->chip->WriteSequence, MPI_WRSEQ_1ST_KEY_VALUE);
*************** mpt_downloadboot(MPT_ADAPTER *ioc, int s
*** 2928,2937 ****
--- 3042,3075 ----
  
    }
  
+ #ifdef CONFIG_PCI_RECOVERY
+   {
+    int read_fail ;
+    read_fail = CHIPREG_READ32(&diag0val, &ioc->chip->Diagnostic);
+    if (read_fail) {
+     printk("PCI PIO read error:%d\n", read_fail);
+     /* recovery code */
+    }
+   }
+ #else
    diag0val = CHIPREG_READ32(&ioc->chip->Diagnostic);
+ #endif
+ 
  #ifdef MPT_DEBUG
+ #ifdef CONFIG_PCI_RECOVERY
+   if (ioc->alt_ioc)  {
+    int read_fail;
+    read_fail = CHIPREG_READ32(&diag1val, &ioc->alt_ioc->chip->Diagnostic);
+    if (read_fail) {
+     printk("PCI PIO read error:%d\n", read_fail);
+     /* recovery code */
+    }
+   }
+ #else
    if (ioc->alt_ioc)
     diag1val = CHIPREG_READ32(&ioc->alt_ioc->chip->Diagnostic);
+ #endif
+ 
    ddlprintk((MYIOC_s_INFO_FMT "DbGb3: diag0=%08x, diag1=%08x\n",
      ioc->name, diag0val, diag1val));
  #endif
*************** mpt_downloadboot(MPT_ADAPTER *ioc, int s
*** 2944,2951 ****
--- 3082,3100 ----
   CHIPREG_WRITE32(&ioc->chip->Diagnostic, diag0val);
  
  #ifdef MPT_DEBUG
+ #ifdef CONFIG_PCI_RECOVERY
+  if (ioc->alt_ioc) {
+   int read_fail;
+   read_fail = CHIPREG_READ32(&diag1val, &ioc->alt_ioc->chip->Diagnostic);
+   if (read_fail) {
+    printk("PCI PIO read error:%d\n", read_fail);
+    /* recovery code */
+   }
+  }
+ #else
   if (ioc->alt_ioc)
    diag1val = CHIPREG_READ32(&ioc->alt_ioc->chip->Diagnostic);
+ #endif
  
   ddlprintk((MYIOC_s_INFO_FMT "DbGb3: diag0=%08x, diag1=%08x\n",
     ioc->name, diag0val, diag1val));
*************** mpt_downloadboot(MPT_ADAPTER *ioc, int s
*** 3097,3103 ****
--- 3246,3265 ----
   CHIPREG_PIO_WRITE32(&ioc->pio_chip->DiagRwData, diagRwData);
  
   /* clear the RW enable and DISARM bits */
+ #ifdef CONFIG_PCI_RECOVERY
+  {
+   int read_fail ;
+ 
+   read_fail = CHIPREG_READ32(&diag0val, &ioc->chip->Diagnostic);
+   if (read_fail) {
+    printk("PCI PIO read error:%d\n", read_fail);
+    /* recovery code */
+   }
+  }
+ #else
   diag0val = CHIPREG_READ32(&ioc->chip->Diagnostic);
+ #endif
+ 
   diag0val &= ~(MPI_DIAG_DISABLE_ARM | MPI_DIAG_RW_ENABLE | MPI_DIAG_FLASH_BAD_SIG);
   CHIPREG_WRITE32(&ioc->chip->Diagnostic, diag0val);
  
*************** mpt_diag_reset(MPT_ADAPTER *ioc, int ign
*** 3215,3225 ****
--- 3377,3410 ----
   CHIPREG_WRITE32(&ioc->chip->IntStatus, 0);
  
   /* Use "Diagnostic reset" method! (only thing available!) */
+ #ifdef CONFIG_PCI_RECOVERY
+  {
+   int read_fail;
+   read_fail = CHIPREG_READ32(&diag0val, &ioc->chip->Diagnostic);
+   if (read_fail) {
+    printk("PCI PIO read error:%d\n", read_fail);
+    /* recovery code */
+   }
+  }
+ #else
   diag0val = CHIPREG_READ32(&ioc->chip->Diagnostic);
+ #endif
  
  #ifdef MPT_DEBUG
+ #ifdef CONFIG_PCI_RECOVERY
+  if (ioc->alt_ioc) {
+   int read_fail;
+   read_fail = CHIPREG_READ32(&diag1val, &ioc->alt_ioc->chip->Diagnostic);
+   if (read_fail) {
+    printk("PCI PIO read error:%d\n", read_fail);
+    /* recovery code */
+   }
+  }
+ #else
   if (ioc->alt_ioc)
    diag1val = CHIPREG_READ32(&ioc->alt_ioc->chip->Diagnostic);
+ #endif
+ 
   dprintk((MYIOC_s_INFO_FMT "DbG1: diag0=%08x, diag1=%08x\n",
     ioc->name, diag0val, diag1val));
  #endif
*************** mpt_diag_reset(MPT_ADAPTER *ioc, int ign
*** 3255,3269 ****
--- 3440,3477 ----
  
     }
  
+ #ifdef CONFIG_PCI_RECOVERY
+    {
+     int read_fail;
+     read_fail = CHIPREG_READ32(&diag0val, &ioc->chip->Diagnostic);
+     if (read_fail) {
+      printk("PCI PIO read error:%d\n", read_fail);
+      /* recovery code */
+     }
+    }
+ #else
     diag0val = CHIPREG_READ32(&ioc->chip->Diagnostic);
+ #endif
  
     dprintk((MYIOC_s_INFO_FMT "Wrote magic DiagWriteEn sequence (%x)\n",
       ioc->name, diag0val));
    }
  
  #ifdef MPT_DEBUG
+ #ifndef CONFIG_PCI_RECOVERY
+   if (ioc->alt_ioc) {
+    int read_fail;
+    read_fail = CHIPREG_READ32(&diag1val, &ioc->alt_ioc->chip->Diagnostic);
+    if (read_fail) {
+     printk("PCI PIO read error:%d\n", read_fail);
+     /* recovery code */
+    }
+   }
+ #else
    if (ioc->alt_ioc)
     diag1val = CHIPREG_READ32(&ioc->alt_ioc->chip->Diagnostic);
+ #endif
+ 
    dprintk((MYIOC_s_INFO_FMT "DbG2: diag0=%08x, diag1=%08x\n",
      ioc->name, diag0val, diag1val));
  #endif
*************** mpt_diag_reset(MPT_ADAPTER *ioc, int ign
*** 3320,3329 ****
--- 3528,3561 ----
      * case.  _diag_reset will return < 0
      */
     for (count = 0; count < 30; count ++) {
+ #ifdef CONFIG_PCI_RECOVERY
+     {
+      int read_fail;
+      read_fail = CHIPREG_READ32(&diag0val, &ioc->chip->Diagnostic);
+      if (read_fail) {
+       printk("PCI PIO read error:%d\n", read_fail);
+       /* recovery code */
+      }
+     }
+ #else
      diag0val = CHIPREG_READ32(&ioc->chip->Diagnostic);
+ #endif
+ 
  #ifdef MPT_DEBUG
+ #ifdef CONFIG_PCI_RECOVERY
+     if (ioc->alt_ioc) {
+      int read_fail;
+      read_fail = CHIPREG_READ32(&diag1val, &ioc->alt_ioc->chip->Diagnostic);
+      if (read_fail) {
+       printk("PCI PIO read error:%d\n", read_fail);
+       /* recovery code */
+      }
+     }
+ #else
      if (ioc->alt_ioc)
       diag1val = CHIPREG_READ32(&ioc->alt_ioc->chip->Diagnostic);
+ #endif
+ 
      dprintk((MYIOC_s_INFO_FMT
       "DbG2b: diag0=%08x, diag1=%08x\n",
       ioc->name, diag0val, diag1val));
*************** mpt_diag_reset(MPT_ADAPTER *ioc, int ign
*** 3353,3359 ****
--- 3585,3603 ----
      * with calling program.
      */
     for (count = 0; count < 30; count ++) {
+ #ifdef CONFIG_PCI_RECOVERY
+     {
+      int read_fail;
+      read_fail = CHIPREG_READ32(&doorbell, &ioc->chip->Doorbell);
+      if (read_fail) {
+       printk("PCI PIO read error:%d\n", read_fail);
+       /* recovery code */
+      }
+     }
+ #else
      doorbell = CHIPREG_READ32(&ioc->chip->Doorbell);
+ #endif
+ 
      doorbell &= MPI_IOC_STATE_MASK;
  
      if (doorbell == MPI_IOC_STATE_READY) {
*************** mpt_diag_reset(MPT_ADAPTER *ioc, int ign
*** 3371,3380 ****
--- 3615,3648 ----
    }
   }
  
+ #ifdef CONFIG_PCI_RECOVERY
+  {
+   int read_fail;
+   read_fail = CHIPREG_READ32(&diag0val, &ioc->chip->Diagnostic);
+   if (read_fail) {
+    printk("PCI PIO read error:%d\n", read_fail);
+    /* recovery code */
+   }
+  }
+ #else
   diag0val = CHIPREG_READ32(&ioc->chip->Diagnostic);
+ #endif
+ 
  #ifdef MPT_DEBUG
+ #ifdef CONFIG_PCI_RECOVERY
+  if (ioc->alt_ioc) {
+   int read_fail;
+   read_fail = CHIPREG_READ32(&diag1val, &ioc->alt_ioc->chip->Diagnostic);
+   if (read_fail) {
+    printk("PCI PIO read error:%d\n", read_fail);
+    /* recovery code */
+   }
+  }
+ #else
   if (ioc->alt_ioc)
    diag1val = CHIPREG_READ32(&ioc->alt_ioc->chip->Diagnostic);
+ #endif
+ 
   dprintk((MYIOC_s_INFO_FMT "DbG3: diag0=%08x, diag1=%08x\n",
    ioc->name, diag0val, diag1val));
  #endif
*************** mpt_diag_reset(MPT_ADAPTER *ioc, int ign
*** 3382,3388 ****
--- 3650,3668 ----
   /* Clear RESET_HISTORY bit!  Place board in the
    * diagnostic mode to update the diag register.
    */
+ #ifdef CONFIG_PCI_RECOVERY
+  {
+   int read_fail;
+   read_fail = CHIPREG_READ32(&diag0val, &ioc->chip->Diagnostic);
+   if (read_fail) {
+    printk("PCI PIO read error:%d\n", read_fail);
+    /* recovery code */
+   }
+  }
+ #else
   diag0val = CHIPREG_READ32(&ioc->chip->Diagnostic);
+ #endif
+ 
   count = 0;
   while ((diag0val & MPI_DIAG_DRWE) == 0) {
    /* Write magic sequence to WriteSequence register
*************** mpt_diag_reset(MPT_ADAPTER *ioc, int ign
*** 3408,3418 ****
--- 3688,3722 ----
       ioc->name, diag0val);
     break;
    }
+ #ifdef CONFIG_PCI_RECOVERY
+   {
+    int read_fail;
+    read_fail = CHIPREG_READ32(&diag0val, &ioc->chip->Diagnostic);
+    if (read_fail) {
+     printk("PCI PIO read error:%d\n", read_fail);
+     /* recovery code */
+    }
+   }
+ #else
    diag0val = CHIPREG_READ32(&ioc->chip->Diagnostic);
+ #endif
+ 
   }
   diag0val &= ~MPI_DIAG_RESET_HISTORY;
   CHIPREG_WRITE32(&ioc->chip->Diagnostic, diag0val);
+ #ifdef CONFIG_PCI_RECOVERY
+  {
+   int read_fail;
+   read_fail = CHIPREG_READ32(&diag0val, &ioc->chip->Diagnostic);
+   if (read_fail) {
+    printk("PCI PIO read error:%d\n", read_fail);
+    /* recovery code */
+   }
+  }
+ #else
   diag0val = CHIPREG_READ32(&ioc->chip->Diagnostic);
+ #endif
+ 
   if (diag0val & MPI_DIAG_RESET_HISTORY) {
    printk(MYIOC_s_WARN_FMT "ResetHistory bit failed to clear!\n",
      ioc->name);
*************** mpt_diag_reset(MPT_ADAPTER *ioc, int ign
*** 3424,3430 ****
--- 3728,3746 ----
  
   /* Check FW reload status flags.
    */
+ #ifdef CONFIG_PCI_RECOVERY
+  {
+   int read_fail;
+   read_fail = CHIPREG_READ32(&diag0val, &ioc->chip->Diagnostic);
+   if (read_fail) {
+    printk("PCI PIO read error:%d\n", read_fail);
+    /* recovery code */
+   }
+  }
+ #else
   diag0val = CHIPREG_READ32(&ioc->chip->Diagnostic);
+ #endif
+ 
   if (diag0val & (MPI_DIAG_FLASH_BAD_SIG | MPI_DIAG_RESET_ADAPTER | MPI_DIAG_DISABLE_ARM)) {
    printk(MYIOC_s_ERR_FMT "Diagnostic reset FAILED! (%02xh)\n",
      ioc->name, diag0val);
*************** mpt_diag_reset(MPT_ADAPTER *ioc, int ign
*** 3432,3439 ****
--- 3748,3767 ----
   }
  
  #ifdef MPT_DEBUG
+ #ifdef CONFIG_PCI_RECOVERY
+  if (ioc->alt_ioc) {
+   int read_fail;
+   read_fail = CHIPREG_READ32(&diag1val, &ioc->chip->Diagnostic);
+   if (read_fail) {
+    printk("PCI PIO read error:%d\n", read_fail);
+    /* recovery code */
+   }
+  }
+ #else
   if (ioc->alt_ioc)
    diag1val = CHIPREG_READ32(&ioc->alt_ioc->chip->Diagnostic);
+ #endif
+ 
   dprintk((MYIOC_s_INFO_FMT "DbG4: diag0=%08x, diag1=%08x\n",
     ioc->name, diag0val, diag1val));
  #endif
*************** mpt_handshake_req_reply_wait(MPT_ADAPTER
*** 3743,3750 ****
--- 4071,4092 ----
     ioc->name, t, failcnt ? " - MISSING DOORBELL HANDSHAKE!" : ""));
  
   /* Read doorbell and check for active bit */
+ #ifdef CONFIG_PCI_RECOVERY
+  {
+   int read_fail;
+   u32 dummy;
+   read_fail = CHIPREG_READ32(&dummy, &ioc->chip->Doorbell);
+   if (read_fail) {
+    printk("PCI PIO read error:%d\n", read_fail);
+    /* recovery code */
+   }
+   if (!(dummy & MPI_DOORBELL_ACTIVE))
+    return -1;
+  }
+ #else
   if (!(CHIPREG_READ32(&ioc->chip->Doorbell) & MPI_DOORBELL_ACTIVE))
     return -1;
+ #endif
  
   /*
    * Clear doorbell int (WRITE 0 to IntStatus reg),
*************** WaitForDoorbellAck(MPT_ADAPTER *ioc, int
*** 3822,3828 ****
--- 4164,4182 ----
  
   if (sleepFlag == CAN_SLEEP) {
    while (--cntdn) {
+ #ifdef CONFIG_PCI_RECOVERY
+    {
+     int read_fail;
+     read_fail = CHIPREG_READ32(&intstat, &ioc->chip->IntStatus);
+     if (read_fail) {
+      printk("PCI PIO read error:%d\n", read_fail);
+      /* recovery code */
+        }
+    }
+ #else
     intstat = CHIPREG_READ32(&ioc->chip->IntStatus);
+ #endif
+ 
     if (! (intstat & MPI_HIS_IOP_DOORBELL_STATUS))
      break;
     set_current_state(TASK_INTERRUPTIBLE);
*************** WaitForDoorbellAck(MPT_ADAPTER *ioc, int
*** 3831,3837 ****
--- 4185,4203 ----
    }
   } else {
    while (--cntdn) {
+ #ifdef CONFIG_PCI_RECOVERY
+    {
+     int read_fail;
+     read_fail = CHIPREG_READ32(&intstat, &ioc->chip->IntStatus);
+     if (read_fail) {
+      printk("PCI PIO read error:%d\n", read_fail);
+      /* recovery code */
+     }
+    }
+ #else
     intstat = CHIPREG_READ32(&ioc->chip->IntStatus);
+ #endif
+ 
     if (! (intstat & MPI_HIS_IOP_DOORBELL_STATUS))
      break;
     mdelay (1);
*************** WaitForDoorbellInt(MPT_ADAPTER *ioc, int
*** 3872,3878 ****
--- 4238,4256 ----
   cntdn = ((sleepFlag == CAN_SLEEP) ? HZ : 1000) * howlong;
   if (sleepFlag == CAN_SLEEP) {
    while (--cntdn) {
+ #ifdef CONFIG_PCI_RECOVERY
+    {
+     int read_fail;
+     read_fail = CHIPREG_READ32(&intstat, &ioc->chip->IntStatus);
+     if (read_fail) {
+      printk("PCI PIO read error:%d\n", read_fail);
+      /* recovery code */
+     }
+    }
+ #else
     intstat = CHIPREG_READ32(&ioc->chip->IntStatus);
+ #endif
+ 
     if (intstat & MPI_HIS_DOORBELL_INTERRUPT)
      break;
     set_current_state(TASK_INTERRUPTIBLE);
*************** WaitForDoorbellInt(MPT_ADAPTER *ioc, int
*** 3881,3887 ****
--- 4259,4277 ----
    }
   } else {
    while (--cntdn) {
+ #ifdef CONFIG_PCI_RECOVERY
+    {
+     int read_fail;
+     read_fail = CHIPREG_READ32(&intstat, &ioc->chip->IntStatus);
+     if (read_fail) {
+      printk("PCI PIO read error:%d\n", read_fail);
+      /* recovery code */
+     }
+    }
+ #else
     intstat = CHIPREG_READ32(&ioc->chip->IntStatus);
+ #endif
+ 
     if (intstat & MPI_HIS_DOORBELL_INTERRUPT)
      break;
     mdelay(1);
*************** WaitForDoorbellReply(MPT_ADAPTER *ioc, i
*** 3932,3943 ****
--- 4322,4361 ----
   if ((t = WaitForDoorbellInt(ioc, howlong, sleepFlag)) < 0) {
    failcnt++;
   } else {
+ #ifdef CONFIG_PCI_RECOVERY
+   {
+    int read_fail;
+    u32 dummy;
+    read_fail = CHIPREG_READ32(&dummy, &ioc->chip->Doorbell);
+    if (read_fail) {
+     printk("PCI PIO read error:%d\n", read_fail);
+     /* recovery code */
+    }
+    hs_reply[u16cnt++] = le16_to_cpu(dummy & 0x0000FFFF);
+   }
+ #else
    hs_reply[u16cnt++] = le16_to_cpu(CHIPREG_READ32(&ioc->chip->Doorbell) & 0x0000FFFF);
+ #endif
+ 
    CHIPREG_WRITE32(&ioc->chip->IntStatus, 0);
    if ((t = WaitForDoorbellInt(ioc, 2, sleepFlag)) < 0)
     failcnt++;
    else {
+ #ifdef CONFIG_PCI_RECOVERY
+    {
+     int read_fail;
+     u32 dummy;
+     read_fail = CHIPREG_READ32(&dummy, &ioc->chip->Doorbell);
+     if (read_fail) {
+      printk("PCI PIO read error:%d\n", read_fail);
+      /* recovery code */
+     }
+     hs_reply[u16cnt++] = le16_to_cpu(dummy & 0x0000FFFF);
+    }
+ #else
     hs_reply[u16cnt++] = le16_to_cpu(CHIPREG_READ32(&ioc->chip->Doorbell) & 0x0000FFFF);
+ #endif
+ 
     CHIPREG_WRITE32(&ioc->chip->IntStatus, 0);
    }
   }
*************** WaitForDoorbellReply(MPT_ADAPTER *ioc, i
*** 3953,3959 ****
--- 4371,4391 ----
   for (u16cnt=2; !failcnt && u16cnt < (2 * mptReply->MsgLength); u16cnt++) {
    if ((t = WaitForDoorbellInt(ioc, 2, sleepFlag)) < 0)
     failcnt++;
+ #ifdef CONFIG_PCI_RECOVERY
+   {
+    int read_fail;
+    u32 dummy;
+    read_fail = CHIPREG_READ32(&dummy, &ioc->chip->Doorbell);
+    if (read_fail) {
+     printk("PCI PIO read error:%d\n", read_fail);
+     /* recovery code */
+    }
+    hword = le16_to_cpu(dummy & 0x0000FFFF);
+   }
+ #else
    hword = le16_to_cpu(CHIPREG_READ32(&ioc->chip->Doorbell) & 0x0000FFFF);
+ #endif
+ 
    /* don't overflow our IOC hs_reply[] buffer! */
    if (u16cnt < sizeof(ioc->hs_reply) / sizeof(ioc->hs_reply[0]))
     hs_reply[u16cnt] = hword;
*************** fusion_init(void)
*** 5896,5901 ****
--- 6328,6339 ----
   show_mptmod_ver(my_NAME, my_VERSION);
   printk(KERN_INFO COPYRIGHT "\n");
  
+ #ifdef CONFIG_PCI_RECOVERY
+         printk(KERN_INFO "Enable PCI PIO read error recovery\n");
+ #else
+         printk(KERN_INFO "Disable PCI PIO read error recovery\n");
+ #endif
+ 
   Q_INIT(&MptAdapters, MPT_ADAPTER);   /* set to empty */
   for (i = 0; i < MPT_MAX_PROTOCOL_DRIVERS; i++) {
    MptCallbacks[i] = NULL;
*************** fusion_exit(void)
*** 5962,5968 ****
--- 6400,6418 ----
    /* Clear any lingering interrupt */
    CHIPREG_WRITE32(&this->chip->IntStatus, 0);
  
+ #ifdef CONFIG_PCI_RECOVERY
+   {
+    int read_fail;
+    u32 dummy;
+    read_fail = CHIPREG_READ32(&dummy, &this->chip->IntStatus);
+    if (read_fail) {
+     printk("PCI PIO read error:%d\n", read_fail);
+     /* recovery code */
+    }
+   }
+ #else
    CHIPREG_READ32(&this->chip->IntStatus);
+ #endif
  
    Q_DEL_ITEM(this);
    mpt_adapter_dispose(this);
diff -prN linux-2.6.1/drivers/message/fusion/mptbase.h linux-2.6.1.modified/drivers/message/fusion/mptbase.h
*** linux-2.6.1/drivers/message/fusion/mptbase.h 2004-01-09 15:59:10.000000000 +0900
--- linux-2.6.1.modified/drivers/message/fusion/mptbase.h 2004-01-26 16:41:43.394801737 +0900
***************
*** 80,87 ****
  #define COPYRIGHT "Copyright (c) 1999-2003 " MODULEAUTHOR
  #endif
  
! #define MPT_LINUX_VERSION_COMMON "2.05.00.05"
! #define MPT_LINUX_PACKAGE_NAME  "@(#)mptlinux-2.05.00.05"
  #define WHAT_MAGIC_STRING  "@" "(" "#" ")"
  
  #define show_mptmod_ver(s,ver)  \
--- 80,87 ----
  #define COPYRIGHT "Copyright (c) 1999-2003 " MODULEAUTHOR
  #endif
  
! #define MPT_LINUX_VERSION_COMMON "2.05.00.05PCI"
! #define MPT_LINUX_PACKAGE_NAME  "@(#)mptlinux-2.05.00.05PCI"
  #define WHAT_MAGIC_STRING  "@" "(" "#" ")"
  
  #define show_mptmod_ver(s,ver)  \
diff -prN linux-2.6.1/drivers/message/fusion/read_check.S linux-2.6.1.modified/drivers/message/fusion/read_check.S
*** linux-2.6.1/drivers/message/fusion/read_check.S 1970-01-01 09:00:00.000000000 +0900
--- linux-2.6.1.modified/drivers/message/fusion/read_check.S 2004-01-26 22:19:20.426780151 +0900
***************
*** 0 ****
--- 1,69 ----
+ #define ENTRY(name) \
+  .align 32; \
+  .global name; \
+  .proc name; \
+ name:
+ #define END(name) \
+  .endp name
+  
+ /****************************************************************************/
+  .rodata
+  .align 8
+  .global readchk_addrs
+ readchk_addrs:
+  data8 .readl_start#
+  data8 .readl_end#
+ 
+  /* This should be per CPU data */
+  .global readl_mca#
+  .sbss
+  .align 4
+  .type readl_mca#,@object
+  .size readl_mca#,4
+ readl_mca:
+  .skip 4
+ /*
+  *
+  * int readl_check( __u32 *valp, __u32 *addr ) ;
+  *     in0,           in1
+  */
+  .text
+  .align 16
+ ENTRY(readl_check)
+  .prologue
+  .body
+ {.mmi addl r15 = @ltoffx(readl_mca#), r1
+  ;;
+  ld8.mov r14 = [r15], readl_mca#  /* r14 = &readl_mca */
+  nop.i 0
+  ;;
+ }
+ .readl_start:
+ {.mmi ld4.acq r15 = [r14]  /* r15 = readl_mca */
+  ld4 r33 = [r33]  /* r33 = *addr(r33) */
+  nop.i 0
+  ;;
+ }
+ {.mmi add r16 =1, r33  /* consume r33 */
+  nop.m 0
+  nop.i 0
+  ;;
+ }
+ .readl_end:
+ {.mmi ld4.acq r14 = [r14]  /* r14 = readl_mca */
+  ;;
+  cmp4.ne p6, p7 = r14, r15 /* old readl_mca == readl_mca? */
+  nop.i 0
+  ;;
+ }
+ {.mmi (p7) st4 [r32] = r33  /* if (old==new) *valp(r32) = r33 */
+  (p7) mov r8 = r0  /* if (old==new) ret = 0 */
+  nop.i 0
+ }
+ {.mmb (p6) addl r8 = 1, r0  /* if (old!=new) ret = 1 */
+  nop.m 0
+  br.ret.sptk.many rp
+  ;;
+ }
+ 
+ END(readl_check)

