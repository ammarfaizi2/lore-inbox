Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262994AbTJUH0q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 03:26:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262993AbTJUH0q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 03:26:46 -0400
Received: from clix.aarnet.edu.au ([192.94.63.10]:58816 "EHLO
	clix.aarnet.edu.au") by vger.kernel.org with ESMTP id S262994AbTJUH0Z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 03:26:25 -0400
Subject: [PATCH] Fix CTS/RTS flow control in serial console
From: Glen Turner <glen.turner@aarnet.edu.au>
To: Russell King <rmk@arm.linux.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: Australian Academic and Research Network
Message-Id: <1066720965.3993.30.camel@andromache>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 21 Oct 2003 16:52:45 +0930
Content-Transfer-Encoding: 7bit
X-MDSA: Yes
X-Spam-Score: -103.4 PATCH_UNIFIED_DIFF,USER_AGENT_XIMIAN,USER_IN_WHITELIST
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Russell,

I have ported the patch which fixes all kernel bugs
reported to me as the maintainer of the "Remote Serial
Console HOWTO" from 2.4 to Linus's BitKeeper (2.6.0-test8).

Most significant among these is making the CTS/RTS
flow control option avoid pathological conditions.
Unfortunately, this requires the DSR and DCD control
lines.  Since this is a user-visible change it would
be nice to apply before 2.6.0-not-a-test.

A full rationale is at
http://www.ussg.iu.edu/hypermail/linux/kernel/0210.1/1790.html

I haven't forward-ported the sysctls and counters which
were part of the 2.4 patch.   I've left "future" comments
to show where these might go.

Let me know of the patch is munged. It's the first time
I've used BitKeeper.

Regards,
Glen

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or
higher.
# This patch includes the following deltas:
#                  ChangeSet    1.1349  -> 1.1350
#       drivers/serial/8250.c   1.40    -> 1.41
#       drivers/serial/serial_core.c    1.72    -> 1.73
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/10/21      gdt@andromache.(none)   1.1350
# serial_core.c:
#   Revert change which used only the termios flag to indicate flow
control
#   on the serial console.  If the termios gets trod on (which seems
#   to happen late in the boot process, around the time /sbin/init
#   is started) then we still want the console to do CTS/RTS
handshaking.
# 8250.c:
#   Serial console bug fixes.
#   End of line is now CR LF, not LF CR.
#   The kernel parameter 'console=ttyS...r' selects CTS/RTS
#   flow control for the serial console.  This waited on
#   the CTS line to be asserted before outputing a character.
#   Unfortunately, no RS-232 signal from the DCE is defined
#   unless DSR is asserted.  By not recognising this the code
#   took forever to boot when waiting for a CTS timeout when
#   no console was attached (or, more commonly, when attached
#   to an idle port of a terminal server).
#   CTS can still timeout, so the new code abandons the remainder
#   of the message on an error.  This leads to a worst-case delay
#   of 1s per line (rather than about 1m per line).  So booting
#   is slowed by a minute rather than the best part of an
#   hour.
#   The new flow control code also requires DCD to be asserted.
#   This prevents printing into the command mode of a Hayes
#   AT modem. That is (1) a security issue and (2) prevents
#   the sysadm from dialing-in when there are lots of messages
#   (eg, when a disk has died and console access is particularly
#   useful).
#   When the flow control option is not selected DSR, DCD and
#   CTS need not be asserted before a message is printed.
# --------------------------------------------
#
diff -Nru a/drivers/serial/8250.c b/drivers/serial/8250.c
--- a/drivers/serial/8250.c     Tue Oct 21 16:20:05 2003
+++ b/drivers/serial/8250.c     Tue Oct 21 16:20:05 2003
@@ -1893,78 +1893,236 @@
  
 #ifdef CONFIG_SERIAL_8250_CONSOLE
  
+/* Maximum number of uS to test for an empty transmit buffer.
+ * Future -- allow this to be tuned, default depending on bps.
+ */
+static int serial_console_attempts_tx = 10000; /* 10mS */
+
+/* Maximum number of uS to test for DSR, DCD & CTS to be asserted when
+ * using flow control.
+ * Future -- allow this to be tuned, default depending on bps.
+ */
+static int serial_console_attempts_cts = 1000000; /* 1S */
+
+/* Wait for UART's transmitter queue to empty.
+ *
+ * Inputs: up -- UART of RS232 port used as console.
+ *         flow_control -- non-zero if CTS/RTS flow control
+ * Returns: 0 -- the waiting character can be transmitted
+ *          non-0 -- discard message to be transmitted, as the
+ *                   transmit queue is massively long or stuck.
+ * Globals: up->lsr_break_flag -- updated if RS-232 Break condition
reported.
+ */
 #define BOTH_EMPTY (UART_LSR_TEMT | UART_LSR_THRE)
  
-/*
- *     Wait for transmitter & holding register to empty
+static inline int serial_console_drain(struct uart_8250_port *up,
+                                       int flow_control)
+{
+        /* Number of times to test the transmit buffer of the UART. */
+        unsigned int timeout;
+        /* Contents of a UART status register. */
+        unsigned int status;
+
+        timeout = serial_console_attempts_tx;
+        /* Drain transmit buffer. */
+        do {
+                status = serial_in(up, UART_LSR);
+                /* If Break has been recieved then note this for the
+                 * regular user of the serial port.
+                 */
+                if (status & UART_LSR_BI) {
+                        up->lsr_break_flag = UART_LSR_BI;
+                }
+                if (--timeout == 0) {
+                        /* Transmit buffer hasn't emptied in a
+                         * reasonable time. Discard the character. If
+                         * using flow control, let caller know to
+                         * discard the remainder of the message.
+                         */
+                        return flow_control;
+                }
+                udelay(1);
+        } while ((status & BOTH_EMPTY) != BOTH_EMPTY);
+        return 0;
+}
+
+/* Wait for transmitter queue to empty. If using flow control then
+ * check if RS-232 status signals are asserted and wait for flow
+ * control signals to be asserted.
+ *
+ * Inputs: up -- UART of RS232 port used as console.
+ *         flow_control -- non-zero if CTS/RTS flow control
+ * Returns: 0 -- the waiting character can be transmitted
+ *          non-0 -- discard message to be transmitted, usually because
+ *                   RS-232 status control lines indicate no reciever.
  */
-static inline void wait_for_xmitr(struct uart_8250_port *up)
+static inline int serial_console_flow(struct uart_8250_port *up,
+                                      int flow_control)
 {
-       unsigned int status, tmout = 10000;
+        /* Timeout loop tests Clear to Send. */
+        unsigned int timeout;
+        /* Contents of a UART status register. */
+        unsigned int status;
+
+        if (serial_console_drain(up, flow_control)) {
+                return !0;
+        }
+
+        /* If flow control is configured then wait for Clear to Send
+         * to be asserted. Abandon message if no status lines
+         * asserted.
+         */
+        if (flow_control) {
+                for (timeout = serial_console_attempts_cts;
+                     timeout > 0;
+                     timeout--) {
+                        status = serial_in(up, UART_MSR);
+                        /* None of the modem status lines, including
+                         * Clear to Send, are valid unless Data Set
+                         * Ready is asserted. Also, we should not
+                         * transmit unless Data Carrier Detect is
+                         * asserted (implying that a receiver is
+                         * present). If DSR or DCD is not present we
+                         * discard the message (the carrier won't be
+                         * asserted in the time taken to poll the UART
+                         * a few times more).
+                         */
+                        if ((status & UART_MSR_DSR) == 0) {
+                                /* Future -- increment counter for
+                                 * "message dropped because no DSR".
+                                 */
+                                return !0;
+                        }
+                        if ((status & UART_MSR_DCD) == 0) {
+                                /* Future -- increment counter for
+                                 * "message dropped because no DCD".
+                                 */
+                                return !0;
+                        }
+                        /* At this point DSR and DCD are asserted, so
+                         * valid to test CTS flow control.
+                         */
+                        if (status & UART_MSR_CTS) {
+                                return 0;
+                        }
+                        udelay(1);
+                }
+                /* CTS still not asserted. Discard the message for
+                 * correct operation on multi-drop lines.
+                 */
+                return !0;
+        }
+        /* No flow control, ready for next character. */
+        return 0;
+}
  
-       /* Wait up to 10ms for the character(s) to be sent. */
-       do {
-               status = serial_in(up, UART_LSR);
-
-               if (status & UART_LSR_BI)
-                       up->lsr_break_flag = UART_LSR_BI;
-
-               if (--tmout == 0)
-                       break;
-               udelay(1);
-       } while ((status & BOTH_EMPTY) != BOTH_EMPTY);
-
-       /* Wait up to 1s for flow control if necessary */
-       if (up->port.flags & UPF_CONS_FLOW) {
-               tmout = 1000000;
-               while (--tmout &&
-                      ((serial_in(up, UART_MSR) & UART_MSR_CTS) == 0))
-                       udelay(1);
-       }
+/* Print 'ch' to the serial console at 'up'.
+ *
+ * Inputs: up -- UART of RS232 port used as console.
+ *         flow_control -- non-zero if CTS/RTS flow control
+ *         ch -- character to print.
+ * Returns: 0 -- 'ch' was transmitted, caller should send me more
+ *               characters of the message.
+ *          non-0 -- 'ch' was dropped, caller should discard remainder
+ *                   of message.
+ */
+static int serial_console_out(struct uart_8250_port *up,
+                              int flow_control,
+                              char ch)
+{
+        int error;
+
+        error = serial_console_flow(up, flow_control);
+        if (!error) {
+                serial_out(up, UART_TX, ch);
+        }
+        return error;
 }
  
-/*
- *     Print a string to the serial port trying not to disturb
- *     any possible real use of the port...
+/* Print a console message to the serial port.
+ *
+ * Try not to disturb any possible real use of the port. So use
+ * polling rather than interrupts and leave UART registers as they
+ * were found.
+ *
+ * Errors (and with flow control, unasserted DSR and DCD status lines
+ * and CTS flow control lines which take too long to be asserted)
+ * cause the remainder of the message to be abandoned.  This behaviour
+ * is because the cause of the failure is unlikely to be gone within
+ * the few CPU instructions it takes to loop around to attempt to
+ * print the next character.
+ *
+ * The console_lock must be held when we get here.
  *
- *     The console_lock must be held when we get here.
+ * User-visible changes from Linux 2.4 to 2.6:
+ *
+ *  - The end of line in 2.4 was LF CR, it is now CR LF.
+ *
+ *  - When CTS/RTS flow control is requested (boot parameter
+ *    "console=ttyS...r" then full DCD and DSR status signals are
+ *    required. This prevents multi-second delays when no console is
+ *    attached. Also prevents printing to a AT-style modem's command
+ *    mode (a security exposure. Also it lead to dropping connecting
+ *    calls, making a console dial-in impossible when during lots of
+ *    console messages such as during boot or a disk failure).
+ *
+ *  - On error the remainder of the message is discarded, not just the
+ *    character. The prevents a continuing error causing a message to
+ *    take many seconds to attempt to print, this caused >30 minute
boot
+ *    times in Linux 2.4.
+ *
+ * Inputs: co -- console
+ *         message -- console message, not terminated by \0  or \n
+ *         message_length -- characters of 'message' to print
+ * Globals: input -- serial8250_ports[]
  */
-static void
-serial8250_console_write(struct console *co, const char *s, unsigned
int count)+static void serial8250_console_write(struct console *co,
+                                     const char *message,
+                                     unsigned int message_length)
 {
-       struct uart_8250_port *up = &serial8250_ports[co->index];
-       unsigned int ier;
-       int i;
-
-       /*
-        *      First save the UER then disable the interrupts
-        */
-       ier = serial_in(up, UART_IER);
-       serial_out(up, UART_IER, 0);
-
-       /*
-        *      Now, do each character
-        */
-       for (i = 0; i < count; i++, s++) {
-               wait_for_xmitr(up);
-
-               /*
-                *      Send the character out.
-                *      If a LF, also do CR...
-                */
-               serial_out(up, UART_TX, *s);
-               if (*s == 10) {
-                       wait_for_xmitr(up);
-                       serial_out(up, UART_TX, 13);
+        struct uart_8250_port *up = &serial8250_ports[co->index];
+        unsigned int ier;
+        unsigned int u;
+        const char *p;
+        int flow_control;
+
+        /* Salt away the UART's Interrput Enable Register before
+         * disabling interrupts.
+         */
+        ier = serial_in(up, UART_IER);
+        serial_out(up, UART_IER, 0);
+
+        /* Is console running RTS/CTS flow control? */
+        flow_control = (up->port.flags & UPF_CONS_FLOW);
+
+        /* Send the characters of the message to the serial port,
+         * abandoning the entire message on error.
+         */
+        for (u = 0, p = message; u < message_length; u++, p++) {
+                /* If a LF, then print CR LF. */
+                if (*p == '\n') {
+                        if (serial_console_out(up, flow_control, '\r'))
{
+                                /* Future - increment message discard
count. */+                                break;
+                        }
                }
-       }
-
-       /*
-        *      Finally, wait for transmitter to become empty
-        *      and restore the IER
-        */
-       wait_for_xmitr(up);
-       serial_out(up, UART_IER, ier);
+                /* Print the character. */
+                if (serial_console_out(up, flow_control, *p)) {
+                        /* Future - increment message discard count. */
+                        break;
+                }
+        }
+
+        /* Wait for remaining characters to be transmitted.  We don't
+         * wait for flow control, as user-space has to be prepared for
+         * a change in flow control signals in any case.
+         */
+        (void)serial_console_drain(up, flow_control);
+
+        /* Restore the UART's Interrput Enable Register, re-enabling
+         * any interrupts which were set on behalf of user-space.
+         */
+       serial_out(up, UART_IER, ier);
 }
  
 static int __init serial8250_console_setup(struct console *co, char
*options)
diff -Nru a/drivers/serial/serial_core.c b/drivers/serial/serial_core.c
--- a/drivers/serial/serial_core.c      Tue Oct 21 16:20:05 2003
+++ b/drivers/serial/serial_core.c      Tue Oct 21 16:20:05 2003
@@ -1856,8 +1856,15 @@
                break;
        }
  
-       if (flow == 'r')
-               termios.c_cflag |= CRTSCTS;
+       if (flow == 'r') {
+               /* This seems to get trod on by /sbin/init.  -GDT */
+                termios.c_cflag |= CRTSCTS;
+                /* If the BOFH asked for CTS/RTS in the kernel
+                 * parameters then we do CTS/RTS flow control
+                 * regardless of the alterable termios setting.
+                 */
+                port->flags |= UPF_CONS_FLOW;
+        }
  
        port->ops->set_termios(port, &termios, NULL);
        co->cflag = termios.c_cflag;


-- 
Glen Turner         Tel: (08) 8303 3936 or +61 8 8303 3936 
Network Engineer          Email: glen.turner@aarnet.edu.au
Australian Academic & Research Network   www.aarnet.edu.au


