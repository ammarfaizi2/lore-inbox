Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291775AbSBTP5L>; Wed, 20 Feb 2002 10:57:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291787AbSBTP5E>; Wed, 20 Feb 2002 10:57:04 -0500
Received: from gw-nl4.philips.com ([212.153.190.6]:3591 "EHLO
	gw-nl4.philips.com") by vger.kernel.org with ESMTP
	id <S291775AbSBTP4y>; Wed, 20 Feb 2002 10:56:54 -0500
From: fabrizio.gennari@philips.com
To: linux-kernel@vger.kernel.org
Cc: rmk@arm.linux.org.uk, jt@bougret.hpl.hp.com, abbotti@mev.co.uk
Subject: [PATCH] Kernel support for 16C950's CPR register
X-Mailer: Lotus Notes Release 5.0.5  September 22, 2000
Message-ID: <OFB97BA691.962BF699-ONC1256B66.00546B48@diamond.philips.com>
Date: Wed, 20 Feb 2002 16:56:03 +0100
X-MIMETrack: Serialize by Router on hbg001soh/H/SERVER/PHILIPS(Release 5.0.5 |September
 22, 2000) at 20/02/2002 17:15:21,
	Serialize complete at 20/02/2002 17:15:21
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The 16C950 serial port from Oxford Semiconductor has a special register, 
called CPR (Clock Predivisor Register). This increases in steps of 1/8, 
thus allowing a finer control on the generated baud rate than the ordinary 
divisor registers DLL and DLM, that only increase in steps of 1.

There are 3 patches for CPR:
1. one written by me
2. one written by Jean Tourrilhes
3. one written by Ian Abbott

Patches 1 and 3 are available at 
http://sourceforge.net/tracker/?atid=300310&group_id=310&func=browse . 
Patch 2 is available at 
http://www.geocrawler.com/archives/3/8352/2001/10/0/6948700/ .

1. My patch is crap :) Avoid
2. Jean Tourrilhes' patch does not use CPR if the requested speed is 
higher than 115200 b/s. This is fine if the clock frequency is an integral 
multiple of 16*115200=1843200, but otherwise it does not exploit CPR's 
potential of fine-tuning speed.
3. Ian Abbott's patch is by far the best

Enclosed is an improvement over Ian Abbott's patch. Ian's disables 
quad-speed mode if the requested speed is lower than the baud base, while 
this enables quad-speed mode by default. Here is why: let's say the UART 
clock has a nonstandard frequency of 16 MHz, therefore the baud base is 
1000000. A speed of 460800 b/s is requested. Ian's patch disables 
quad-speed mode because 460800<1000000, then computes the best value of 
CPR=17. The resulting speed is 1000000/(17/8)=470588 b/s. This patch 
enables quad-speed mode, then computes the best value of CPR=69. Therefore 
the resulting speed is (1000000*4)/(69/8)=463768 b/s.

Using quad-speed mode allows a better resolution in setting speed.

Fabrizio Gennari
Philips Research Monza
via G.Casati 23, 20052 Monza (MI), Italy
tel. +39 039 2037816, fax +39 039 2037800


diff -ruN linux-2.4.17/drivers/char/serial.c 
linux-patched/drivers/char/serial.c
--- linux-2.4.17/drivers/char/serial.c  Fri Dec 21 18:41:54 2001
+++ linux-patched/drivers/char/serial.c Fri Jan 18 11:23:02 2002
@@ -57,6 +57,16 @@
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
  */
 
 static char *serial_version = "5.05c";
@@ -1277,6 +1287,11 @@
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
@@ -1610,6 +1625,109 @@
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
tcrbug, int *scale_numer, int *cpr)
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
+                 else{
+                   *scale_numer = 1;               /* Normal speed mode 
*/
+                   mbaud_base/=4;
+                   ed/=4;
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
@@ -1617,6 +1735,7 @@
                         struct termios *old_termios)
 {
        int     quot = 0, baud_base, baud;
+       int     scale_numer, scale_denom, mcr_clk_scale, tcr, rtl;
        unsigned cflag, cval, fcr = 0;
        int     bits;
        unsigned long   flags;
@@ -1651,76 +1770,109 @@
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
&scale_numer, &scale_denom);
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
@@ -1731,6 +1883,13 @@
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
@@ -1800,6 +1959,17 @@
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
+       }
        restore_flags(flags);
 }
 
@@ -3294,7 +3464,8 @@
 
        if (info->quot) {
                ret += sprintf(buf+ret, " baud:%d",
-                              state->baud_base / info->quot);
+                              ((state->baud_base * info->scale_numer) /
+                               (info->quot * info->scale_denom)));
        }
 
        ret += sprintf(buf+ret, " tx:%d rx:%d",
diff -ruN linux-2.4.17/include/linux/serialP.h 
linux-patched/include/linux/serialP.h
--- linux-2.4.17/include/linux/serialP.h        Thu Nov 22 20:47:23 2001
+++ linux-patched/include/linux/serialP.h       Fri Jan 18 10:51:29 2002
@@ -67,6 +67,8 @@
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
diff -ruN linux-2.4.17/include/linux/serial_reg.h 
linux-patched/include/linux/serial_reg.h
--- linux-2.4.17/include/linux/serial_reg.h     Wed May  2 01:05:00 2001
+++ linux-patched/include/linux/serial_reg.h    Fri Jan 18 10:51:29 2002
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
