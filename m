Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129324AbRAICPM>; Mon, 8 Jan 2001 21:15:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129267AbRAICPC>; Mon, 8 Jan 2001 21:15:02 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:59380 "HELO
	brinquedo.distro.conectiva") by vger.kernel.org with SMTP
	id <S129401AbRAICOw>; Mon, 8 Jan 2001 21:14:52 -0500
Date: Tue, 9 Jan 2001 00:14:43 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: linux@advansys.com
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: [PATCH] advansys.c: include missing restore_flags, etc
Message-ID: <20010109001443.A20786@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	linux@advansys.com, Alan Cox <alan@lxorguk.ukuu.org.uk>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20010108201103.E17087@conectiva.com.br> <20010108202533.F17087@conectiva.com.br> <20010108203002.H17087@conectiva.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010108203002.H17087@conectiva.com.br>; from acme@conectiva.com.br on Mon, Jan 08, 2001 at 08:30:02PM -0200
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

	Please consider applying, comments in the patch.

- Arnaldo


--- linux-2.4.0-ac4/drivers/scsi/advansys.c	Mon Jan  8 20:39:28 2001
+++ linux-2.4.0-ac4.acme/drivers/scsi/advansys.c	Tue Jan  9 00:12:03 2001
@@ -717,6 +717,13 @@
      Ken Mort <ken@mort.net> reported a DEBUG compile bug fixed
      in 3.2K.
 
+     Arnaldo Carvalho de Melo <acme@conectiva.com.br> fix issues
+     related to save_flags/restore_flags, some restore_flags and
+     DvcLeaveCritical were missing, use unsigned long flags instead
+     of int flags, a not needed cli commented out, like the sti
+     that matches it (in advansys_abort) - 08/01/2001
+     
+
   L. AdvanSys Contact Information
  
      Mail:                   Advanced System Products, Inc.
@@ -2098,8 +2105,8 @@
 STATIC uchar     AscGetChipIRQ(PortAddr, ushort);
 STATIC uchar     AscSetChipIRQ(PortAddr, uchar, ushort);
 STATIC ushort    AscGetChipBiosAddress(PortAddr, ushort);
-STATIC int       DvcEnterCritical(void);
-STATIC void      DvcLeaveCritical(int);
+STATIC unsigned long DvcEnterCritical(void);
+STATIC void      DvcLeaveCritical(unsigned long);
 STATIC void      DvcInPortWords(PortAddr, ushort *, int);
 STATIC void      DvcOutPortWords(PortAddr, ushort *, int);
 STATIC void      DvcOutPortDWords(PortAddr, ASC_DCNT *, int);
@@ -3103,8 +3110,8 @@
 /*
  * Device drivers must define the following functions.
  */
-STATIC int   DvcEnterCritical(void);
-STATIC void  DvcLeaveCritical(int);
+STATIC unsigned long  DvcEnterCritical(void);
+STATIC void  DvcLeaveCritical(unsigned long);
 STATIC void  DvcSleepMilliSecond(ADV_DCNT);
 STATIC uchar DvcAdvReadPCIConfigByte(ADV_DVC_VAR *, ushort);
 STATIC void  DvcAdvWritePCIConfigByte(ADV_DVC_VAR *, ushort, uchar);
@@ -5938,7 +5945,7 @@
 {
     struct Scsi_Host    *shp;
     asc_board_t         *boardp;
-    int                 flags;
+    unsigned long       flags;
     Scsi_Cmnd           *done_scp;
 
     shp = scp->host;
@@ -6033,7 +6040,7 @@
     asc_board_t         *boardp;
     ASC_DVC_VAR         *asc_dvc_varp;
     ADV_DVC_VAR         *adv_dvc_varp;
-    int                 flags;
+    unsigned long       flags;
     int                 do_scsi_done;
     int                 scp_found;
     Scsi_Cmnd           *done_scp = NULL;
@@ -6138,7 +6145,7 @@
                     ret = SCSI_ABORT_ERROR;
                     break;
                 }
-                cli();
+                /* cli(); XXX */
             } else {
                 /*
                  * Wide Board
@@ -6278,7 +6285,7 @@
     asc_board_t          *boardp;
     ASC_DVC_VAR          *asc_dvc_varp;
     ADV_DVC_VAR          *adv_dvc_varp;
-    int                  flags;
+    unsigned long        flags;
     Scsi_Cmnd            *done_scp = NULL, *last_scp = NULL;
     Scsi_Cmnd            *tscp, *new_last_scp;
     int                  do_scsi_done;
@@ -9954,10 +9961,10 @@
 #endif /* version < v2.1.0 */ 
 }
 
-STATIC int
+STATIC unsigned long
 DvcEnterCritical(void)
 {
-    int    flags;
+    unsigned long flags;
 
     save_flags(flags);
     cli();
@@ -9965,7 +9972,7 @@
 }
 
 STATIC void
-DvcLeaveCritical(int flags)
+DvcLeaveCritical(unsigned long flags)
 {
     restore_flags(flags);
 }
@@ -12173,7 +12180,7 @@
 )
 {
     PortAddr            iop_base;
-    int                 last_int_level;
+    unsigned long       last_int_level;
     int                 sta;
     int                 n_q_required;
     int                 disable_syn_offset_one_fix;
@@ -12235,6 +12242,7 @@
 #if !CC_VERY_LONG_SG_LIST
         if (sg_entry_cnt > ASC_MAX_SG_LIST)
         {
+            DvcLeaveCritical(last_int_level);
             return(ERR);
         }
 #endif /* !CC_VERY_LONG_SG_LIST */
@@ -13112,7 +13120,7 @@
     ASC_QDONE_INFO      scsiq_buf;
     ASC_QDONE_INFO *scsiq;
     ASC_ISR_CALLBACK    asc_isr_callback;
-    int                 last_int_level;
+    unsigned long       last_int_level;
 
     iop_base = asc_dvc->iop_base;
     asc_isr_callback = asc_dvc->isr_callback;
@@ -13137,6 +13145,7 @@
                             (ushort) (q_addr + (ushort) ASC_SCSIQ_B_STATUS),
                                  scsiq->q_status);
                 (*asc_isr_callback) (asc_dvc, scsiq);
+    		DvcLeaveCritical(last_int_level);
                 return (1);
             }
         }
@@ -13158,7 +13167,7 @@
     ASC_QDONE_INFO      scsiq_buf;
     ASC_QDONE_INFO *scsiq;
     ASC_ISR_CALLBACK    asc_isr_callback;
-    int                 last_int_level;
+    unsigned long       last_int_level;
 
     iop_base = asc_dvc->iop_base;
     asc_isr_callback = asc_dvc->isr_callback;
@@ -17570,7 +17579,7 @@
 AdvExeScsiQueue(ADV_DVC_VAR *asc_dvc,
                 ADV_SCSI_REQ_Q *scsiq)
 {
-    int                    last_int_level;
+    unsigned long          last_int_level;
     AdvPortAddr            iop_base;
     ADV_DCNT               req_size;
     ADV_PADDR              req_paddr;
@@ -17598,6 +17607,7 @@
      */
     if ((new_carrp = asc_dvc->carr_freelist) == NULL)
     {
+       DvcLeaveCritical(last_int_level);
        return ADV_BUSY;
     }
     asc_dvc->carr_freelist =
@@ -17835,7 +17845,7 @@
     ushort                      target_bit;
     ADV_CARR_T                  *free_carrp;
     ADV_VADDR                   irq_next_vpa;
-    int                         flags;
+    unsigned long               flags;
     ADV_SCSI_REQ_Q              *scsiq;
 
     flags = DvcEnterCritical();
@@ -17848,6 +17858,7 @@
     if ((int_stat & (ADV_INTR_STATUS_INTRA | ADV_INTR_STATUS_INTRB |
          ADV_INTR_STATUS_INTRC)) == 0)
     {
+        DvcLeaveCritical(flags);
         return ADV_FALSE;
     }
 
@@ -17982,7 +17993,7 @@
                ushort idle_cmd,
                ADV_DCNT idle_cmd_parameter)
 {
-    int         last_int_level;
+    unsigned long last_int_level;
     int         result;
     ADV_DCNT    i, j;
     AdvPortAddr iop_base;
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
