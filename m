Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261782AbSJNApB>; Sun, 13 Oct 2002 20:45:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261783AbSJNApB>; Sun, 13 Oct 2002 20:45:01 -0400
Received: from clix.aarnet.edu.au ([192.94.63.10]:25836 "EHLO
	clix.aarnet.edu.au") by vger.kernel.org with ESMTP
	id <S261782AbSJNAoy>; Sun, 13 Oct 2002 20:44:54 -0400
Message-ID: <3DAA14E7.1000303@aarnet.edu.au>
Date: Mon, 14 Oct 2002 10:20:47 +0930
From: Glen Turner <glen.turner@aarnet.edu.au>
Organization: Australian Academic and Research Network
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020408
X-Accept-Language: en-au, en-gb, en, en-us
MIME-Version: 1.0
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] 1/3 Fix serial console flow control, serial.c
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- linux-2.4.19/drivers/char/serial.c    Fri Oct 11 15:51:36 2002
+++ linux-2.4.20-pre8/drivers/char/serial.c    Fri Oct 11 15:47:27 2002
@@ -62,10 +62,16 @@
   *        Robert Schwebel <robert@schwebel.de>,
   *        Juergen Beisert <jbeisert@eurodsn.de>,
   *        Theodore Ts'o <tytso@mit.edu>
+ *
+ * 10/02: Fixed flow control (CTS) bugs in serial console by adding
+ *      status control (DSR, DCD) too. This required new heirarchy of
+ *      serial console output functions. Added statistics so users
+ *      can debug lack of console output. Incremented to version 5.05d.
+ *      Glen Turner <glen.turner+linux@aarnet.edu.au>
   */

-static char *serial_version = "5.05c";
-static char *serial_revdate = "2001-07-08";
+static char *serial_version = "5.05d";
+static char *serial_revdate = "2002-10-11";

  /*
   * Serial driver configuration section.  Here are the various options:
@@ -97,8 +103,10 @@
   *        ACPI 2.0.
   */

+#include <limits.h>       /* For INT_MAX */
  #include <linux/config.h>
  #include <linux/version.h>
+#include <linux/sysctl.h>

  #undef SERIAL_PARANOIA_CHECK
  #define CONFIG_SERIAL_NOPAUSE_IO
@@ -248,6 +256,10 @@
  #define _INLINE_
  #endif

+#ifdef CONFIG_SERIAL_CONSOLE
+static int __init serial_console_sysctl_init(void);
+#endif
+
  static char *serial_name = "Serial driver";

  static DECLARE_TASK_QUEUE(tq_serial);
@@ -5543,6 +5555,9 @@
  #ifdef ENABLE_SERIAL_PNP
         probe_serial_pnp();
  #endif
+#ifdef CONFIG_SERIAL_CONSOLE
+       serial_console_sysctl_init();
+#endif
      return 0;
  }

@@ -5778,80 +5793,369 @@
   * ------------------------------------------------------------
   * Serial console driver
   * ------------------------------------------------------------
+ *
+ * When flow control is enabled there are some changes between this
+ * code and v5.05c to fix the following pathological conditions:
+ *
+ * - Linux took upwards of 30 minutes to boot when CTS was never
+ * asserted, such as when a modem or terminal server was idle.    This
+ * code checks the DSR and DCD status lines, detecting most cases
+ * where CTS will never be asserted if the terminal server or modem is
+ * configured with status and flow control (AT &C1 &D2 &K3).
+ *
+ * - An attached smart modem would not answer calls during disk
+ * failures.  Hayes AT command modems hang up when a call is
+ * negotiating and a character is receieved from the local machine.
+ * So a stream of constant console mesasges, such as from a failing
+ * disk, would never allow the modem to complete negotiation on an
+ * incoming call.  This condition can be avoided if the kernel flow
+ * control code checks the DCD status line and the modem is configured
+ * to assert DCD upon the conclusion of call negotiation (AT &C1).
+ *
+ * and the following bugs:
+ *
+ * - Security consideration: kernel messages, possibly containing
+ * user-derived text, were sent to modems without active calls.     Smart
+ * modems without active calls are in command mode.  So users had a
+ * path to subvert modem configurations (eg: alter auto-answer,
+ * callback or authentication).     This bug exists without the flow
+ * control option, but can't be fixed without looking at the status
+ * lines (implying that the flow control option is a Good Idea for
+ * security-conscious sites).
+ *
+ * - When CTS timed out v5.05c send the character regardless.  If CTS
+ * is used for media access control, such as on a multi-drop line or
+ * satelite circuit, other users of the circuit would be disrupted.
+ *
+ * - When the Transmit Buffer timed out v5.05 queued the character
+ * regardless.    This could result in a number of the issues above.
+ *
+ * The behaviour *without* flow control remains identical to v5.05c,
+ * with the exception of Transmit Buffer timeouts. These now cause the
+ * message to be discarded (and counted).
+ *
+ * In short, professional RS-232 applications should configure the
+ * flow control option and supply strictly correct status (DSR, DCD)
+ * and flow control (CTS) signals. For example:
+ *
+ *   console=ttyS0,9600n8r
+ *
+ * A quick three-wire hack to grab an Oops message should not use flow
+ * control.  For example:
+ *
+ *   console=ttyS0,9600n8
   */
  #ifdef CONFIG_SERIAL_CONSOLE

-#define BOTH_EMPTY (UART_LSR_TEMT | UART_LSR_THRE)
-
  static struct async_struct async_sercons;
+/* A count of the number of messages, dropped messages and reasons for
+ * dropping messages.  There really should be one of these for each
+ * console=ttyS parameter.  The counters are not yet visible to user
+ * space.
+ */
+static struct serial_console_counters_t serial_console_counters;
+
+/* Maximum number of times to test for an empty transmit buffer.
+ * About 1S.  Can be tuned using dev.serialconsole.timeout-transmit.
+ * This number could be significantly smaller than 1M, as even at
+ * 75bps the tramsit buffer of contemporary UARTs will clear in 0.5S.
+ */
+static int serial_console_attempts_tx = 1000000;
+/* Maximum number of times to test for CTS to be asserted when using
+ * flow control.  About 1S.  Can be tuned using
+ * dev.serialconsole.timeout-cts.
+ */
+static int serial_console_attempts_cts = 1000000;

-/*
- *    Wait for transmitter & holding register to empty
+
+/* Sysctl routines to access serial_console_counters.
+ *
+ * See "sysctl interface" in linux/Docmentaion/DocBook/kernel-api.*
   */
-static inline void wait_for_xmitr(struct async_struct *info)
+static int serial_console_attempts_min = 1;
+static int serial_console_attempts_max = INT_MAX;
+static ctl_table serial_console_sysctl_files[] = {
+ { 1, "messages-total",
+   &(serial_console_counters.messages_total), sizeof(int),
+   0444, NULL,
+   &proc_dointvec },
+ { 2, "messages-dropped",
+   &(serial_console_counters.messages_dropped), sizeof(int),
+   0444, NULL,
+   &proc_dointvec },
+ { 3, "timeouts-transmit",
+   &(serial_console_counters.timeouts_tx), sizeof(int),
+   0444, NULL,
+   &proc_dointvec },
+ { 4, "timeouts-data-set-ready",
+   &(serial_console_counters.timeouts_dsr), sizeof(int),
+   0444, NULL,
+   &proc_dointvec },
+ { 5, "timeouts-data-carrier-detect",
+   &(serial_console_counters.timeouts_cts), sizeof(int),
+   0444, NULL,
+   &proc_dointvec },
+ { 6, "timeouts-clear-to-send",
+   &(serial_console_counters.timeouts_cts), sizeof(int),
+   0444, NULL,
+   &proc_dointvec },
+ { 7, "maximum-attempts-transmit",
+   &serial_console_attempts_tx, sizeof(int),
+   0664, NULL,
+   &proc_dointvec_minmax, NULL, NULL,
+   &serial_console_attempts_min,
+   &serial_console_attempts_max },
+ { 8, "maximum-attempts-clear-to-send",
+   &serial_console_attempts_cts, sizeof(int),
+   0664, NULL,
+   &proc_dointvec_minmax, NULL, NULL,
+   &serial_console_attempts_min,
+   &serial_console_attempts_max },
+ { 0 }  /* Last */
+};
+
+static ctl_table serial_console_sysctl_directory[] = {
+ { 1, "serialconsole",
+   NULL, 0,
+   0555, serial_console_sysctl_files },
+ { 0 }  /* Last */
+};
+
+static ctl_table serial_console_sysctl_root[] = {
+ { CTL_DEV, "dev",
+   NULL, 0,
+   0555, serial_console_sysctl_directory },
+ { 0 }  /* Last */
+};
+
+static struct ctl_table_header *serial_console_sysctl;
+
+
+/* Initialise statitsics for the serial console.
+ *
+ * Called from rs_init(), the serial device initialiser.  Calling this
+ * routine from serial_console_init() leads to an Oops, perhaps the
+ * necessary infrastructure is not in place at that time. Hmmm. -GDT
+ *
+ * Returns: 0, always.
+ */
+static int __init serial_console_sysctl_init(void)
+{
+ memset(&serial_console_counters,
+        0,
+        sizeof(serial_console_counters));
+ serial_console_sysctl =
+   register_sysctl_table(serial_console_sysctl_root,
+             0);  /* Insert at end */
+ return 0;
+}
+
+
+/* There is no
+ *   static void __exit serial_console_sysctl_exit(void)
+ *  as compling this code as a MODULE defeats CONFIG_SERIAL_CONSOLE.
+ * This should be added should Alan Cox succeed in making all code
+ * module-based.
+ */
+
+
+/* Wait for UART's transmitter queue to empty.
+ *
+ * Inputs: info -- RS232 port used as console.
+ * Returns: 0 -- the waiting character can be transmitted
+ *        non-0 -- discard message to be transmitted, as the
+ *             transmit queue is massively long or stuck.
+ * Globals: serial_console_counters.
+ */
+#define BOTH_EMPTY (UART_LSR_TEMT | UART_LSR_THRE)
+
+static inline int serial_console_drain(struct async_struct *info)
  {
- unsigned int status, tmout = 1000000;
+ /* Number of times to test the transmit buffer of the UART. */
+ unsigned int timeout;
+ /* Contents of a UART status register. */
+ unsigned int status;

+ timeout = serial_console_attempts_tx;
+ /* Drain transmit buffer. */
      do {
          status = serial_in(info, UART_LSR);

-     if (status & UART_LSR_BI)
+     /* If Break has been recieved then note that for the
+      * regular user of the serial port.
+      */
+     if (status & UART_LSR_BI) {
           lsr_break_flag = UART_LSR_BI;
+     }

-     if (--tmout == 0)
-         break;
- } while((status & BOTH_EMPTY) != BOTH_EMPTY);
+     if (--timeout == 0) {
+         /* Transmit buffer hasn't emptied in a
+          * reasonable time.  Discard the character.
+          */
+         serial_console_counters.timeouts_tx++;
+         return (info->flags & ASYNC_CONS_FLOW);
+     }
+ } while ((status & BOTH_EMPTY) != BOTH_EMPTY);
+ return 0;
+}
+
+/* Wait for transmitter queue to empty. If using flow control then
+ * check if RS-232 status signals are asserted and wait for flow
+ * control to be asserted.
+ *
+ *
+ * Inputs: info -- RS232 port used as console.
+ * Returns: 0 -- the waiting character can be transmitted
+ *        non-0 -- discard message to be transmitted, usually because
+ *             RS-232 status control lines indicate no reciever.
+ * Globals: lsr_break_flag -- updated if RS-232 Break condition reported.
+ *        serial_console_counters
+ */
+static inline int serial_console_flow(struct async_struct *info)
+{
+ /* Timeout loop tests Clear to Send. */
+ unsigned int timeout;
+ /* Contents of a UART status register. */
+ unsigned int status;

- /* Wait for flow control if necessary */
+ if (serial_console_drain(info))
+ {
+     return !0;
+ }
+
+ /* If flow control is configured then wait for Clear to Send
+  * to be asserted.  Abandon message if no status lines
+  * asserted.
+  */
      if (info->flags & ASYNC_CONS_FLOW) {
-     tmout = 1000000;
-     while (--tmout &&
-            ((serial_in(info, UART_MSR) & UART_MSR_CTS) == 0));
- }
-}
+     for (timeout = serial_console_attempts_cts;
+          timeout > 0;
+          timeout --) {
+         status = serial_in(info, UART_MSR);
+         /* None of the modem status lines, including
+          * Clear to Send, are valid unless Data Set
+          * Ready is asserted.  Also, we should not
+          * transmit unless Data Carrier Detect is
+          * asserted (implying that a receiver is
+          * present).  If DSR or DCD is not present we
+          * discard the message (the carrier won't be
+          * asserted in the time taken to poll the UART
+          * a few times more).  Distinct DSR and DCD
+          * counters are maintained for simple
+          * diagnosis of cable and modem faults.
+          */
+         if ((status & UART_MSR_DSR) == 0) {
+             serial_console_counters.timeouts_dsr++;
+             return !0;
+         }
+         if ((status & UART_MSR_DCD) == 0) {
+             serial_console_counters.timeouts_dcd++;
+             return !0;
+         }
+         /* At this point DSR and DCD are asserted, so
+          * valid to test flow control.
+          */
+         if (status & UART_MSR_CTS) {
+             return 0;
+         }
+     }
+     /* CTS still not asserted.  Discard the message for
+      * correct operation on multi-drop lines.
+      */
+     serial_console_counters.timeouts_cts++;
+     return !0;
+ }

+ return 0;
+}

-/*
- *    Print a string to the serial port trying not to disturb
- *    any possible real use of the port...
+/* Print 'ch' to the serial console at 'info'.
   *
- *    The console must be locked when we get here.
+ * Inputs: info -- RS232 port used as console.
+ *       ch -- character to print.
+ * Returns: 0 -- 'ch' was transmitted, caller should send me more
+ *         characters of the message.
+ *        non-0 -- 'ch' was dropped, caller should discard remainder
+ *             of message.
   */
-static void serial_console_write(struct console *co, const char *s,
-             unsigned count)
+static int serial_console_out(struct async_struct *info,
+               char ch)
+{
+ int error;
+
+ error = serial_console_flow(info);
+ if (!error) {
+     serial_out(info, UART_TX, ch);
+ }
+ return error;
+}
+
+/* Print a string 'message' of 'message_length' to the serial
+ * port. 'co' is ingnored, as the serial console is described by the
+ * global 'async_sercons'.
+ *
+ * Try not to disturb any possible real use of the port (such as by
+ * getty).  So use polling rather than interrupts.
+ *
+ * The console must be locked when we get here.
+ *
+ * Inputs: co -- console to print message upon, ignored.
+ *       message -- pointer to text to print.
+ *       message_length -- amount of text, [0, MAX_UINT].
+ * Globals: async_sercons.
+ */
+static void serial_console_write(struct console *co,
+              const char *message,
+              unsigned int message_length)
  {
      static struct async_struct *info = &async_sercons;
- int ier;
- unsigned i;
+ unsigned int ier;
+ /* We go to some trouble with unsigned ints and avoiding array
+  * references to ensure that messages can be longer than is
+  * indexable by an int/size_t.    Not sure why the ability to
+  * print 4 billion characters is valuable, unless we're trying
+  * to avoid invalid memory accesses upon corrupt
+  * message_lengths [GDT].
+  */
+ unsigned int u;
+ const char *p;

- /*
-  *    First save the IER then disable the interrupts
+ serial_console_counters.messages_total++;
+
+ /* Salt away the serial port UART's Interrupt Enable Register
+  * before disabling UART interrupts.
       */
      ier = serial_in(info, UART_IER);
      serial_out(info, UART_IER, 0x00);

- /*
-  *    Now, do each character
-  */
- for (i = 0; i < count; i++, s++) {
-     wait_for_xmitr(info);
-
-     /*
-      * Send the character out.
-      * If a LF, also do CR...
-      */
-     serial_out(info, UART_TX, *s);
-     if (*s == 10) {
-         wait_for_xmitr(info);
-         serial_out(info, UART_TX, 13);
+ /* Send each character down the port. */
+ for (u = 0, p = message; u < message_length; u++, p++)
+ {
+     if (*p == '\n') {
+         /* Expand end of line LF to CR LF, as expected
+          * by terminals and printers.  v5.05c sent LF
+          * CR, which isn't right for printers.
+          */
+         if (serial_console_out(info, '\r')) {
+             serial_console_counters.messages_dropped++;
+             break;
+         }
+     }
+     if (serial_console_out(info, *p)) {
+         serial_console_counters.messages_dropped++;
+         break;
          }
      }
+ /* At this point all characters are sent or we have abandoned
+  * the message due to soft errors like timeouts on transmit
+  * queues, timeouts on CTS or unasserted DSR or DCD.
+  */

- /*
-  *    Finally, Wait for transmitter & holding register to empty
-  *     and restore the IER
+ /* Restore the interrupt status.  v5.05c also waited up to 1S
+  * for any flow control to be reasserted, now we leave any
+  * user application to cope with that.
       */
- wait_for_xmitr(info);
+ (void)serial_console_drain(info);
      serial_out(info, UART_IER, ier);
  }


