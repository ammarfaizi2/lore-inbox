Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311841AbSCTRFO>; Wed, 20 Mar 2002 12:05:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292890AbSCTRFG>; Wed, 20 Mar 2002 12:05:06 -0500
Received: from gw-nl4.philips.com ([212.153.190.6]:3589 "EHLO
	gw-nl4.philips.com") by vger.kernel.org with ESMTP
	id <S311838AbSCTREh>; Wed, 20 Mar 2002 12:04:37 -0500
From: fabrizio.gennari@philips.com
To: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Support for CPR register in 16C950 UARTs and Brainboxes serial/Bluetooth
 cards
X-Mailer: Lotus Notes Release 5.0.5  September 22, 2000
Message-ID: <OFAB55B09E.868BB835-ONC1256B82.005C3839@diamond.philips.com>
Date: Wed, 20 Mar 2002 18:03:54 +0100
X-MIMETrack: Serialize by Router on hbg001soh/H/SERVER/PHILIPS(Release 5.0.9a |January 7, 2002) at
 20/03/2002 18:23:47,
	Serialize complete at 20/03/2002 18:23:47
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is a patch, that applies to kernel 2.4.17, that
-adds support for CPR register in 16C950 UARTs, by Ian Abbott
-autodetects the baud_base in 16C950 UARTs
-recognizes whether the card is a Brainboxes card, and sets the 
appropriate registers. Brainboxes cards have a clock frequency of 14.7456MHz, 8 times the ordinary one, and an additional divisor circuit that divides 
the frequency by 8, thus obtaining full compatibility with the ordinary 
clock. The additional divisor is turned on and off by writing in the MSR 
register. By default, the divisor is on, and this patch turns it off when 
appropriate, so higher (8x) speeds can be obtained. Credits go to Jean 
Tourrilhes of HP and Gavin Jewell of Brainboxes who provided the info.

Some caveats exist with the automatic clock detection:
-it is done with do_gettimeofday, which is not the cleanest way of doing 
it, but a better method, using the jiffies variable, cannot be used 
because jiffies does not increment in that function. The detection works 
remarkably well on i386 processors, but it gives wrong (negative!) results 
on ARM processors (it is an issue with do_gettimeofday I do not know how 
to solve)
-the detected baud_base is stored in the appropriate structure member. 
But, if the card is PCI, the value in serial_pci_tbl overwrites the 
detected value

Fabrizio Gennari
Philips Research Monza
via G.Casati 23, 20052 Monza (MI), Italy
tel. +39 039 2037816, fax +39 039 2037800

diff -ruN linux/drivers/char/serial.c linux-patched/drivers/char/serial.c
--- linux/drivers/char/serial.c Fri Dec 21 18:41:54 2001
+++ linux-patched/drivers/char/serial.c Wed Mar 20 15:30:14 2002
@@ -57,6 +57,19 @@
  * 10/00: add in optional software flow control for serial console.
  *       Kanoj Sarcar <kanoj@sgi.com>  (Modified by Theodore Ts'o)
  *
+ *  6/01: Baud base scaling for 16C950 UARTs with unusual clocks
+ *       Ian Abbott <abbotti@mev.co.uk>
+ *
+ *  6/01: Use 16C950 interrupt trigger levels (RTL and TTL registers).
+ *       Ian Abbott <abbotti@mev.co.uk>
+ *
+ *  1/02: Use 16C950's quad-speed mode by default
+ *        Fabrizio Gennari <fabrizio.gennari@philips.com>
+ *
+ *
+ *  3/02: 16C950 automatic clock frequency detection and Brainboxes 
support
+ *       Fabrizio Gennari <fabrizio.gennari@philips.com>
+ *
  */
 
 static char *serial_version = "5.05c";
@@ -1277,6 +1290,11 @@
                serial_outp(info, UART_LCR, 0xBF);
                serial_outp(info, UART_EFR, UART_EFR_ECB);
                serial_outp(info, UART_LCR, 0);
+               /* Initialize interrupt trigger levels. */
+               serial_icr_write(info, UART_RTL, 1);
+               serial_icr_write(info, UART_TTL, 1);
+               info->ACR |= UART_ACR_TLENB;
+               serial_icr_write(info, UART_ACR, info->ACR);
        }
 
 #ifdef CONFIG_SERIAL_RSA
@@ -1393,7 +1411,7 @@
        }
        info->MCR |= ALPHA_KLUDGE_MCR;          /* Don't ask */
        serial_outp(info, UART_MCR, info->MCR);
- 
+
        /*
         * Finally, enable interrupts
         */
@@ -1610,6 +1628,126 @@
 #endif
 
 /*
+ * This routine generates a CPR pre-scaler and quot divisor combination
+ * for the 16C950/954.  The CPR register allows us to generate unusual 
baud
+ * rates from standard clocks or standard baud rates from unusual clocks 
more
+ * accurately, and also allows us to scale the input clock down if 
required.
+ * The input clock can be scaled down by any value in the range 1 to 
31.875
+ * in steps of 0.125. This is CPR value / 8.
+ *
+ * Returns a quot divisor value (or zero if baud out of range) and sets a
+ * corresponding CPR value by reference.
+ */
+static int calc950_cpr_quot(int baud_base, int baud, int dllbug, int 
tcrbug, int *scale_numer, int *cpr, int *msr, u8 is_brainboxes)
+{
+       unsigned mbaud_base, mbaud, d, ed;
+       unsigned x, q, a, err, best_err;
+       unsigned char sieve[256 / 8];
+       int best_quot, best_cpr;
+
+       *scale_numer = 4;
+       best_quot = 0;
+       best_cpr = 8;   /* Default value. */
+       if ((baud > 0) && (baud_base >= baud)) {
+               mbaud_base = 8 * baud_base;
+
+               /* Determine whether quad speed mode should be disabled */
+
+               ed = (mbaud_base + baud - 1) / baud;
+               if (ed > 65535*255){                /* Quad speed mode is 
too fast */
+                 if (!tcrbug && ed <=65535*255*2){ 
+                   *scale_numer = 2;               /* Dual speed mode */
+                   mbaud_base/=2;
+                   ed/=2;
+                 }
+                 else if (!is_brainboxes || ed <=65535*255*4){
+                   *scale_numer = 1;               /* Normal speed mode 
*/
+                   mbaud_base/=4;
+                   ed/=4;
+                 }
+                 else if (ed <=65535*255*8){
+                   *msr = 0x00;
+                    mbaud_base/=8;
+                    ed/=8;
+                 }
+                  else if (!tcrbug && ed <=65535*255*16){
+                    *msr = 0x00;
+                    *scale_numer = 2;               /* Dual speed mode */
+                    mbaud_base/=16;
+                    ed/=16;
+                 }
+                 else{
+                    *msr = 0x00;
+                    *scale_numer = 1;               /* Normal speed mode 
*/
+                    mbaud_base/=32;
+                    ed/=32;
+                 }
+               }
+
+               /* Determine minimum and maximum CPR values to consider. 
*/
+
+               d = ed / 65535;
+               if (d < 8)
+                       d = 8;
+               else if ((mbaud_base / (d * baud)) > 65535)
+                       ++d;    /* Round up. */
+               if (ed > 255)
+                       ed = 255;
+
+               /*
+                * Scale our calculations up so we can compare errors to 
find
+                * the best CPR value.
+                */
+               x = (UINT_MAX - 255) / (2 * mbaud_base);
+               mbaud_base *= x;
+               mbaud = x * baud;
+               /*
+                * Search for best (or close to best) CPR value.  Rounding
+                * errors mean we may not find the absolute best, but we 
should
+                * get pretty close.  We will end up with the required CPR
+                * value in scale_denom.
+                *
+                * A sieve is used to eliminate a lot of redundant cases. 
I
+                * think the extra cycles to maintain this sieve more than 
pay
+                * for themselves by the time the loop terminates.
+                */
+               memset(sieve, 0, sizeof(sieve));
+               best_err = UINT_MAX;
+               for ( ; d <= ed; d++) {
+                       int skip_sieve = 0;
+                       if (sieve[d>>3] & (1<<(d&7)))
+                               continue;
+                       x = (2*mbaud_base + d) / (2*d);
+                       q = (2*x + mbaud) / (2*mbaud);
+                       /*
+                        * Work around a bug in the Oxford Semiconductor 
952
+                        * rev B chip which causes it to seriously 
miscalculate
+                        * baud rates when DLL is 0.
+                        */
+                       if (((q & 0xFF) == 0) && dllbug) {
+                               q++;
+                               skip_sieve = 1;
+                       }
+                       a = (2*x + q) / (2*q);
+                       err = (a > mbaud) ? (a - mbaud) : (mbaud - a);
+                       if (err < best_err) {
+                               best_err = err;
+                               best_cpr = d;
+                               best_quot = q;
+                               if (err == 0)
+                                       break;
+                       }
+                       if (skip_sieve)
+                               continue;
+                       for (x = 2*d; x <= ed; x += d)
+                               sieve[x>>3] |= (1<<(x&7));
+               }
+       }
+       *cpr = best_cpr;
+       return best_quot;
+}
+
+/*
  * This routine is called to set the UART divisor registers to match
  * the specified baud rate for a serial port.
  */
@@ -1617,6 +1755,7 @@
                         struct termios *old_termios)
 {
        int     quot = 0, baud_base, baud;
+       int     scale_numer, scale_denom, mcr_clk_scale, tcr, 
rtl,msr_clk_scale;
        unsigned cflag, cval, fcr = 0;
        int     bits;
        unsigned long   flags;
@@ -1651,76 +1790,110 @@
                cval |= UART_LCR_SPAR;
 #endif
 
-       /* Determine divisor based on baud rate */
-       baud = tty_get_baud_rate(info->tty);
-       if (!baud)
-               baud = 9600;    /* B0 transition handled in rs_set_termios 
*/
 #ifdef CONFIG_SERIAL_RSA
        if ((info->state->type == PORT_RSA) &&
            (info->state->baud_base != SERIAL_RSA_BAUD_BASE) &&
            enable_rsa(info))
                info->state->baud_base = SERIAL_RSA_BAUD_BASE;
 #endif
+
+recalculate_quot:
+       /* Determine divisor based on baud rate */
+       baud = tty_get_baud_rate(info->tty);
+       if (!baud)
+               baud = 9600;    /* B0 transition handled in rs_set_termios 
*/
+recalculate_quot_fixed_baud:
        baud_base = info->state->baud_base;
-       if (info->state->type == PORT_16C950) {
-               if (baud <= baud_base)
-                       serial_icr_write(info, UART_TCR, 0);
-               else if (baud <= 2*baud_base) {
-                       serial_icr_write(info, UART_TCR, 0x8);
-                       baud_base = baud_base * 2;
-               } else if (baud <= 4*baud_base) {
-                       serial_icr_write(info, UART_TCR, 0x4);
-                       baud_base = baud_base * 4;
-               } else
-                       serial_icr_write(info, UART_TCR, 0);
-       }
+       scale_numer = 1;
+       scale_denom = 1;
+       mcr_clk_scale = 0;
+       msr_clk_scale = 0xFF;
+       tcr = 0;
        if (baud == 38400 &&
            ((info->flags & ASYNC_SPD_MASK) == ASYNC_SPD_CUST))
                quot = info->state->custom_divisor;
        else {
-               if (baud == 134)
-                       /* Special case since 134 is really 134.5 */
-                       quot = (2*baud_base / 269);
-               else if (baud)
-                       quot = baud_base / baud;
-       }
-       /* If the quotient is zero refuse the change */
-       if (!quot && old_termios) {
-               info->tty->termios->c_cflag &= ~CBAUD;
-               info->tty->termios->c_cflag |= (old_termios->c_cflag & 
CBAUD);
-               baud = tty_get_baud_rate(info->tty);
-               if (!baud)
-                       baud = 9600;
-               if (baud == 38400 &&
-                   ((info->flags & ASYNC_SPD_MASK) == ASYNC_SPD_CUST))
-                       quot = info->state->custom_divisor;
-               else {
+               if (info->state->type == PORT_16C950) {
+                       /*
+                        * Handle speeds higher than baud_base by using 
the
+                        * TCR register to divide the clock by 4 or 8 
instead
+                        * of the usual 16. OX16C952 rev B and OX16C954 
rev A
+                        * only support 4 and 16 properly.
+                        */
+                       if (baud <= 4*baud_base) {
+                               int sbaud_base, sbaud;
+                               int dllbug = (info->state->revision == 
0x9502);
+                               int tcrbug = ((info->state->revision == 
0x5201) || (info->state->revision != 0x5400));
+ 
+                               sbaud_base = baud_base * 4;
+                               sbaud = baud;
+                               if (baud == 134) {
+                                       /* Special case: 134 is really 
134.5 */
+                                       sbaud_base *= 2;
+                                       sbaud = 269;
+                               }
+                               quot = calc950_cpr_quot(sbaud_base, sbaud,
+                                                       dllbug, tcrbug, 
&scale_numer, &scale_denom, &msr_clk_scale, info->state->is_brainboxes);
+                               switch(scale_numer){
+                               case 4 : tcr = 4; break;
+                               case 2 : tcr = 8; break;
+                               default: tcr = 0; break; /* always = 1 */
+                               }
+
+                               if (scale_denom == 8)
+                                       /* CPR pre-scaling not required. 
*/
+                                       scale_denom = 1;
+                               else {
+                                       scale_numer *= 8;
+                                       mcr_clk_scale = 
UART_MCR_CLK_SCALE;
+                               }
+                       }
+               } else {
                        if (baud == 134)
                                /* Special case since 134 is really 134.5 
*/
                                quot = (2*baud_base / 269);
                        else if (baud)
                                quot = baud_base / baud;
+                       if (quot > 65535)
+                               /* Baud must be too small. */
+                               quot = 0;
                }
        }
+       /* If the quotient is zero refuse the change */
+       if (!quot && old_termios) {
+               info->tty->termios->c_cflag &= ~CBAUD;
+               info->tty->termios->c_cflag |= (old_termios->c_cflag & 
CBAUD);
+               goto recalculate_quot;
+       }
        /* As a last resort, if the quotient is zero, default to 9600 bps 
*/
-       if (!quot)
-               quot = baud_base / 9600;
-       /*
-        * Work around a bug in the Oxford Semiconductor 952 rev B
-        * chip which causes it to seriously miscalculate baud rates
-        * when DLL is 0.
-        */
-       if (((quot & 0xFF) == 0) && (info->state->type == PORT_16C950) &&
-           (info->state->revision == 0x5201))
-               quot++;
+       if (!quot) {
+               if (baud != 9600) {
+                       baud = 9600;
+                       goto recalculate_quot_fixed_baud;
+               } else {
+                       /* Paranoia steps in... */
+                       quot = baud_base / 9600;
+                       if (quot < 1)
+                               quot = 1;
+                       else if (quot > 65535)
+                               quot = 65535;
+                       scale_numer = 1;
+                       scale_denom = 1;
+                       mcr_clk_scale = 0;
+                       tcr = 0;
+               }
+       }
 
        info->quot = quot;
-       info->timeout = ((info->xmit_fifo_size*HZ*bits*quot) / baud_base);
+       info->scale_numer = scale_numer;
+       info->scale_denom = scale_denom;
+       info->timeout = ((info->xmit_fifo_size*HZ*bits*quot*scale_denom) /
+                        (baud_base*scale_numer));
        info->timeout += HZ/50;         /* Add .02 seconds of slop */
 
        /* Set up FIFO's */
        if (uart_config[info->state->type].flags & UART_USE_FIFO) {
-               if ((info->state->baud_base / quot) < 2400)
+               if (baud < 2400)
                        fcr = UART_FCR_ENABLE_FIFO | UART_FCR_TRIGGER_1;
 #ifdef CONFIG_SERIAL_RSA
                else if (info->state->type == PORT_RSA)
@@ -1731,6 +1904,13 @@
        }
        if (info->state->type == PORT_16750)
                fcr |= UART_FCR7_64BYTE;
+       /* 16C950 receiver interrupt trigger level. */
+       rtl = 1;
+       if (info->state->type == PORT_16C950) {
+               /* XXX This could probably use more tweaking... */
+               if (baud >= 2400)
+                       rtl = 32;
+       }
 
        /* CTS flow control flag and modem status interrupts */
        info->IER &= ~UART_IER_MSI;
@@ -1800,6 +1980,22 @@
                }
                serial_outp(info, UART_FCR, fcr);       /* set fcr */
        }
+       if (info->state->type == PORT_16C950) {
+               serial_icr_write(info, UART_TCR, tcr);
+               if (mcr_clk_scale)
+                       serial_icr_write(info, UART_CPR, scale_denom);
+               if ((info->MCR & UART_MCR_CLK_SCALE) != mcr_clk_scale) {
+                       info->MCR ^= UART_MCR_CLK_SCALE;
+                       serial_outp(info, UART_MCR, info->MCR);
+               }
+               if (fcr & UART_FCR_ENABLE_FIFO)
+                       serial_icr_write(info, UART_RTL, rtl);
+               if (info->state->is_brainboxes){
+                        serial_outp(info, UART_MSR, msr_clk_scale);
+                       if (msr_clk_scale == 0x00)
+                               info->scale_denom *= 8;
+               }
+       }
        restore_flags(flags);
 }
 
@@ -3294,7 +3490,8 @@
 
        if (info->quot) {
                ret += sprintf(buf+ret, " baud:%d",
-                              state->baud_base / info->quot);
+                              ((state->baud_base * info->scale_numer) /
+                               (info->quot * info->scale_denom)));
        }
 
        ret += sprintf(buf+ret, " tx:%d rx:%d",
@@ -3510,6 +3707,61 @@
        return count;
 }
 
+/* The algorithm for detecting the clock frequency in 16C950 UARTs
+   was suggested by Anna Trett of Oxford Semiconductor */
+
+static int autodetect_16c950_clock(struct async_struct *info,
+                                  struct serial_state *state)
+{
+       unsigned char old_fcr, old_mcr, old_dll, old_dlm, old_tcr;
+       int nchar=0,num=0,result;
+       struct timeval before,after;
+       int husec_elapsed;
+
+       old_fcr = serial_inp(info, UART_FCR);
+       old_mcr = serial_inp(info, UART_MCR);
+       serial_outp(info, UART_FCR, 
+                   UART_FCR_CLEAR_RCVR | UART_FCR_CLEAR_XMIT);
+       serial_outp(info, UART_MCR, UART_MCR_LOOP);
+       serial_outp(info, UART_LCR, UART_LCR_DLAB);
+       old_dll = serial_inp(info, UART_DLL);
+       old_dlm = serial_inp(info, UART_DLM);
+       old_tcr = serial_inp(info, UART_TCR);
+       serial_outp(info, UART_DLL, 0x01);
+       serial_outp(info, UART_DLM, 0x00);
+       serial_outp(info, UART_TCR, 0x00);
+       serial_outp(info, UART_LCR, 0x03);
+       printk(KERN_INFO "Autodetecting...\n");
+
+       /* The best thing to do would be to loop for
+       a set number of jiffies. But the variable jiffies does
+       not increment here. So, we just loop until a set number 
+       of characters is received (it should take 1 sec if a standard
+       clock is used) and measure how many hundreds of usecs it took,
+       storing it in husec_elapsed */
+
+       do_gettimeofday(&before);
+       do{
+               serial_outp(info, UART_TX, (num++)&0xFF);
+               if (serial_inp(info, UART_LSR) & UART_LSR_DR){
+                 nchar++;
+                 serial_inp(info, UART_RX);
+               }
+       }while(nchar<11520 && num < 1000000);
+       do_gettimeofday(&after);
+ 
husec_elapsed=(after.tv_sec-before.tv_sec)*10000+(after.tv_usec-before.tv_usec)/100;
+       serial_outp(info, UART_FCR, old_fcr);
+       serial_outp(info, UART_MCR, old_mcr);
+       serial_outp(info, UART_LCR, UART_LCR_DLAB);
+       serial_outp(info, UART_DLL, old_dll);
+       serial_outp(info, UART_DLM, old_dlm);
+       serial_outp(info, UART_TCR, old_tcr);
+
+       nchar = nchar*10*10000;
+       result = nchar/husec_elapsed;
+       return result;
+}
+
 /*
  * This is a helper routine to autodetect StarTech/Exar/Oxsemi UART's.
  * When this function is called we know it is at least a StarTech
@@ -3553,9 +3805,21 @@
                if (scratch == 0x16 && scratch2 == 0xC9 &&
                    (scratch3 == 0x50 || scratch3 == 0x52 ||
                     scratch3 == 0x54)) {
+                       int new_baud_base;
                        state->type = PORT_16C950;
                        state->revision = serial_icr_read(info, UART_REV) 
|
                                (scratch3 << 8);
+                       serial_out(info, UART_MSR, 0x00);
+ state->baud_base=autodetect_16c950_clock(info,state);
+                       /* Brainboxes cards become 8 time faster when 0xFF
+                         is written in MSR */
+                       serial_out(info, UART_MSR, 0xFF);
+                       if ( 
(new_baud_base=autodetect_16c950_clock(info,state)) > 4*state->baud_base) 
{
+                               state->baud_base=new_baud_base;
+                               state->is_brainboxes = 1;
+                       }
+                       else
+                               state->is_brainboxes = 0;
                        return;
                }
        }
@@ -4447,6 +4711,8 @@
        return 1;
 }
 
+static struct pci_device_id serial_pci_tbl[];
+
 static int __devinit serial_init_one(struct pci_dev *dev,
                                     const struct pci_device_id *ent)
 {
diff -ruN linux/include/linux/serialP.h 
linux-patched/include/linux/serialP.h
--- linux/include/linux/serialP.h       Thu Nov 22 20:47:23 2001
+++ linux-patched/include/linux/serialP.h       Wed Mar 20 15:16:37 2002
@@ -40,6 +40,7 @@
        int     type;
        int     line;
        int     revision;       /* Chip revision (950) */
+       u8      is_brainboxes;
        int     xmit_fifo_size;
        int     custom_divisor;
        int     count;
@@ -67,6 +68,8 @@
        int                     ignore_status_mask;
        int                     timeout;
        int                     quot;
+       int                     scale_numer;    /* Multiply baud_base by 
*/
+       int                     scale_denom;    /* scale_numer / 
scale_denom */
        int                     x_char; /* xon/xoff character */
        int                     close_delay;
        unsigned short          closing_wait;
diff -ruN linux/include/linux/serial_reg.h 
linux-patched/include/linux/serial_reg.h
--- linux/include/linux/serial_reg.h    Wed May  2 01:05:00 2001
+++ linux-patched/include/linux/serial_reg.h    Wed Mar 20 15:16:47 2002
@@ -126,6 +126,15 @@
 #define UART_MCR_OUT1  0x04    /* Out1 complement */
 #define UART_MCR_RTS   0x02    /* RTS complement */
 #define UART_MCR_DTR   0x01    /* DTR complement */
+/*
+ * Clock scaler for Startech and 16C950.
+ * This enables a divide by 4 on Startech.
+ * This enables a divide by M+N/8 on 16C950 (controlled by CPR register).
+ * Note the bit can only be modified when EFR-bit 4 is selected but the 
last
+ * value written remains active (but reads as 0) if EFR-bit 4 is 
subsequently
+ * unselected.
+ */
+#define UART_MCR_CLK_SCALE     0x80    /* Enable clock scaler */
 
 /*
  * These are the definitions for the Modem Status Register


