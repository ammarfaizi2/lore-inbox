Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265983AbUGTTMo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265983AbUGTTMo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jul 2004 15:12:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266155AbUGTSjr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jul 2004 14:39:47 -0400
Received: from nl-ams-slo-l4-01-pip-7.chellonetwork.com ([213.46.243.25]:20753
	"EHLO amsfep16-int.chello.nl") by vger.kernel.org with ESMTP
	id S266130AbUGTSiF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jul 2004 14:38:05 -0400
Date: Tue, 20 Jul 2004 20:38:00 +0200
Message-Id: <200407201838.i6KIc0iT015399@anakin.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 466] m68k sparse inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

M68k: Define inline functions before use (found by sparse)
Affected drivers:
  - Atari floppy
  - Amiga A2232 serial
  - Amiga Fastlane SCSI
  - Mac/PowerMac Valkyrie frame buffer

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

--- linux-2.6.8-rc2/drivers/block/ataflop.c	2004-04-28 11:02:33.000000000 +0200
+++ linux-m68k-2.6.8-rc2/drivers/block/ataflop.c	2004-07-10 21:07:35.000000000 +0200
@@ -342,8 +342,6 @@
 static void fd_deselect( void );
 static void fd_motor_off_timer( unsigned long dummy );
 static void check_change( unsigned long dummy );
-static __inline__ void set_head_settle_flag( void );
-static __inline__ int get_head_settle_flag( void );
 static irqreturn_t floppy_irq (int irq, void *dummy, struct pt_regs *fp);
 static void fd_error( void );
 static int do_format(int drive, int type, struct atari_format_descr *desc);
@@ -361,7 +359,6 @@
 static void fd_times_out( unsigned long dummy );
 static void finish_fdc( void );
 static void finish_fdc_done( int dummy );
-static __inline__ void copy_buffer( void *from, void *to);
 static void setup_req_params( int drive );
 static void redo_fd_request( void);
 static int fd_ioctl( struct inode *inode, struct file *filp, unsigned int
@@ -385,27 +382,23 @@
 static struct timer_list fd_timer =
 	TIMER_INITIALIZER(check_change, 0, 0);
 	
-static inline void
-start_motor_off_timer(void)
+static inline void start_motor_off_timer(void)
 {
 	mod_timer(&motor_off_timer, jiffies + FD_MOTOR_OFF_DELAY);
 	MotorOffTrys = 0;
 }
 
-static inline void
-start_check_change_timer( void )
+static inline void start_check_change_timer( void )
 {
 	mod_timer(&fd_timer, jiffies + CHECK_CHANGE_DELAY);
 }
 
-static inline void
-start_timeout(void)
+static inline void start_timeout(void)
 {
 	mod_timer(&timeout_timer, jiffies + FLOPPY_TIMEOUT);
 }
 
-static inline void
-stop_timeout(void)
+static inline void stop_timeout(void)
 {
 	del_timer(&timeout_timer);
 }
@@ -558,18 +551,27 @@
  * seek operation, because we don't use seeks with verify.
  */
 
-static __inline__ void set_head_settle_flag( void )
+static inline void set_head_settle_flag(void)
 {
 	HeadSettleFlag = FDCCMDADD_E;
 }
 
-static __inline__ int get_head_settle_flag( void )
+static inline int get_head_settle_flag(void)
 {
 	int	tmp = HeadSettleFlag;
 	HeadSettleFlag = 0;
 	return( tmp );
 }
 
+static inline void copy_buffer(void *from, void *to)
+{
+	ulong *p1 = (ulong *)from, *p2 = (ulong *)to;
+	int cnt;
+
+	for (cnt = 512/4; cnt; cnt--)
+		*p2++ = *p1++;
+}
+
   
   
 
@@ -1372,15 +1374,6 @@
 	return 0;
 }
 
-static __inline__ void copy_buffer(void *from, void *to)
-{
-	ulong	*p1 = (ulong *)from, *p2 = (ulong *)to;
-	int		cnt;
-
-	for( cnt = 512/4; cnt; cnt-- )
-		*p2++ = *p1++;
-}
-
 
 /* This sets up the global variables describing the current request. */
 
--- linux-2.6.8-rc2/drivers/char/ser_a2232.c	2004-04-28 11:05:02.000000000 +0200
+++ linux-m68k-2.6.8-rc2/drivers/char/ser_a2232.c	2004-07-10 21:06:54.000000000 +0200
@@ -109,12 +109,6 @@
 /************************* End of Includes **************************/
 
 /***************************** Prototypes ***************************/
-/* Helper functions */
-static __inline__ volatile struct a2232status *a2232stat(unsigned int board,
-						unsigned int portonboard);
-static __inline__ volatile struct a2232memory *a2232mem (unsigned int board); 
-static __inline__ void a2232_receive_char(	struct a2232_port *port,
-						int ch, int err );
 /* The interrupt service routine */
 static irqreturn_t a2232_vbl_inter(int irq, void *data, struct pt_regs *fp);
 /* Initialize the port structures */
@@ -178,6 +172,51 @@
 static struct zorro_dev *zd_a2232[MAX_A2232_BOARDS]; 
 /***************************** End of Global variables **************/
 
+/* Helper functions */
+
+static inline volatile struct a2232memory *a2232mem(unsigned int board)
+{
+	return (volatile struct a2232memory *)ZTWO_VADDR(zd_a2232[board]->resource.start);
+}
+
+static inline volatile struct a2232status *a2232stat(unsigned int board,
+						     unsigned int portonboard)
+{
+	volatile struct a2232memory *mem = a2232mem(board);
+	return &(mem->Status[portonboard]);
+}
+
+static inline void a2232_receive_char(struct a2232_port *port, int ch, int err)
+{
+/* 	Mostly stolen from other drivers.
+	Maybe one could implement a more efficient version by not only
+	transferring one character at a time.
+*/
+	struct tty_struct *tty = port->gs.tty;
+	
+	if (tty->flip.count >= TTY_FLIPBUF_SIZE)
+		return;
+
+	tty->flip.count++;
+
+#if 0
+	switch(err) {
+	case TTY_BREAK:
+		break;
+	case TTY_PARITY:
+		break;
+	case TTY_OVERRUN:
+		break;
+	case TTY_FRAME:
+		break;
+	}
+#endif
+
+	*tty->flip.flag_buf_ptr++ = err;
+	*tty->flip.char_buf_ptr++ = ch;
+	tty_flip_buffer_push(tty);
+}
+
 /***************************** Functions ****************************/
 /*** BEGIN OF REAL_DRIVER FUNCTIONS ***/
 
@@ -470,49 +509,6 @@
 }
 /*** END OF FUNCTIONS EXPECTED BY TTY DRIVER STRUCTS ***/
 
-static __inline__ volatile struct a2232status *a2232stat(unsigned int board, unsigned int portonboard)
-{
-	volatile struct a2232memory *mem = a2232mem(board);
-	return &(mem->Status[portonboard]);
-}
-
-static __inline__ volatile struct a2232memory *a2232mem (unsigned int board)
-{
-	return (volatile struct a2232memory *) ZTWO_VADDR( zd_a2232[board]->resource.start );
-}
-
-static __inline__ void a2232_receive_char(	struct a2232_port *port,
-						int ch, int err )
-{
-/* 	Mostly stolen from other drivers.
-	Maybe one could implement a more efficient version by not only
-	transferring one character at a time.
-*/
-	struct tty_struct *tty = port->gs.tty;
-	
-	if (tty->flip.count >= TTY_FLIPBUF_SIZE)
-		return;
-
-	tty->flip.count++;
-
-#if 0
-	switch(err) {
-	case TTY_BREAK:
-		break;
-	case TTY_PARITY:
-		break;
-	case TTY_OVERRUN:
-		break;
-	case TTY_FRAME:
-		break;
-	}
-#endif
-
-	*tty->flip.flag_buf_ptr++ = err;
-	*tty->flip.char_buf_ptr++ = ch;
-	tty_flip_buffer_push(tty);
-}
-
 static irqreturn_t a2232_vbl_inter(int irq, void *data, struct pt_regs *fp)
 {
 #if A2232_IOBUFLEN != 256
--- linux-2.6.8-rc2/drivers/scsi/fastlane.c	2004-04-28 15:49:02.000000000 +0200
+++ linux-m68k-2.6.8-rc2/drivers/scsi/fastlane.c	2004-07-10 21:06:54.000000000 +0200
@@ -85,7 +85,6 @@
 
 static int  dma_bytes_sent(struct NCR_ESP *esp, int fifo_count);
 static int  dma_can_transfer(struct NCR_ESP *esp, Scsi_Cmnd *sp);
-static inline void dma_clear(struct NCR_ESP *esp);
 static void dma_dump_state(struct NCR_ESP *esp);
 static void dma_init_read(struct NCR_ESP *esp, __u32 addr, int length);
 static void dma_init_write(struct NCR_ESP *esp, __u32 vaddr, int length);
@@ -110,6 +109,21 @@
 				 * via PIO.
 				 */
 
+static inline void dma_clear(struct NCR_ESP *esp)
+{
+	struct fastlane_dma_registers *dregs = 
+		(struct fastlane_dma_registers *) (esp->dregs);
+	unsigned long *t;
+
+	ctrl_data = (ctrl_data & FASTLANE_DMA_MASK);
+	dregs->ctrl_reg = ctrl_data;
+
+	t = (unsigned long *)(esp->edev);
+
+	dregs->clear_strobe = 0;
+	*t = 0 ;
+}
+
 /***************************************************************** Detection */
 int __init fastlane_esp_detect(Scsi_Host_Template *tpnt)
 {
@@ -297,21 +311,6 @@
 	dregs->ctrl_reg = ctrl_data;
 }
 
-static inline void dma_clear(struct NCR_ESP *esp)
-{
-	struct fastlane_dma_registers *dregs = 
-		(struct fastlane_dma_registers *) (esp->dregs);
-	unsigned long *t;
-
-	ctrl_data = (ctrl_data & FASTLANE_DMA_MASK);
-	dregs->ctrl_reg = ctrl_data;
-
-	t = (unsigned long *)(esp->edev);
-
-	dregs->clear_strobe = 0;
-	*t = 0 ;
-}
-
 
 static void dma_ints_off(struct NCR_ESP *esp)
 {
--- linux-2.6.8-rc2/drivers/video/valkyriefb.c	2004-04-28 10:58:56.000000000 +0200
+++ linux-m68k-2.6.8-rc2/drivers/video/valkyriefb.c	2004-07-10 21:06:54.000000000 +0200
@@ -118,9 +118,7 @@
 static int valkyriefb_blank(int blank_mode, struct fb_info *info);
 
 static int read_valkyrie_sense(struct fb_info_valkyrie *p);
-static inline int valkyrie_vram_reqd(int video_mode, int color_mode);
 static void set_valkyrie_clock(unsigned char *params);
-static inline int valkyrie_par_to_var(struct fb_par_valkyrie *par, struct fb_var_screeninfo *var);
 static int valkyrie_var_to_par(struct fb_var_screeninfo *var,
 	struct fb_par_valkyrie *par, const struct fb_info *fb_info);
 
@@ -171,6 +169,12 @@
 	return 0;
 }
 
+static inline int valkyrie_par_to_var(struct fb_par_valkyrie *par,
+				      struct fb_var_screeninfo *var)
+{
+	return mac_vmode_to_var(par->vmode, par->cmode, var);
+}
+
 static int
 valkyriefb_check_var(struct fb_var_screeninfo *var, struct fb_info *info)
 {
@@ -252,7 +256,7 @@
 	return 0;
 }
 
-static int valkyrie_vram_reqd(int video_mode, int color_mode)
+static inline int valkyrie_vram_reqd(int video_mode, int color_mode)
 {
 	int pitch;
 	struct valkyrie_regvals *init = valkyrie_reg_init[video_mode-1];
@@ -504,11 +508,6 @@
 	return 0;
 }
 
-static int valkyrie_par_to_var(struct fb_par_valkyrie *par, struct fb_var_screeninfo *var)
-{
-	return mac_vmode_to_var(par->vmode, par->cmode, var);
-}
-
 static void valkyrie_init_fix(struct fb_fix_screeninfo *fix, struct fb_info_valkyrie *p)
 {
 	memset(fix, 0, sizeof(*fix));

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
