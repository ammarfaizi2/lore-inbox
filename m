Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261862AbUBWQDA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 11:03:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261939AbUBWQDA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 11:03:00 -0500
Received: from sccrmhc12.comcast.net ([204.127.202.56]:693 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S261862AbUBWQAa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 11:00:30 -0500
Message-ID: <403A2398.1040801@acm.org>
Date: Mon, 23 Feb 2004 10:00:24 -0600
From: Corey Minyard <minyard@acm.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3.1) Gecko/20030428
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH] IPMI driver updates, part 2
Content-Type: multipart/mixed;
 boundary="------------090208000301020007070405"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090208000301020007070405
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

It has been far too long since the last IPMI driver updates, but now all 
the planets have aligned and all the pieces I needed are in and all seem 
to be working.  This update is coming as four parts that must be applied 
in order, but the later parts do not have to be applied for the former 
parts to work.

This second part adds the "System Interface" driver.  The previous 
driver for system interfaces only supported the KCS interface, this 
driver supports all system interfaces defined in the IPMI standard.  It 
also does a much better job of handling ACPI and SMBIOS tables for 
detecting IPMI system interfaces.

FYI, IPMI is a standard for monitoring and maintaining a system.  It 
provides interfaces for detecting sensors (voltage, temperature, etc.) 
in the system and monitoring those sensors.  Many systems have extended 
capabilities that allow IPMI to control the system, doing things like 
lighting leds and controlling hot-swap.  This driver allows access to 
the IPMI system.

-Corey

--------------090208000301020007070405
Content-Type: text/plain;
 name="linux-2.6.3-ipmi-part2-si.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="linux-2.6.3-ipmi-part2-si.diff"

diff -urN linux-a1/Documentation/IPMI.txt linux-a2/Documentation/IPMI.txt
--- linux-a1/Documentation/IPMI.txt	2004-02-23 08:22:00.000000000 -0600
+++ linux-a2/Documentation/IPMI.txt	2004-02-23 08:35:19.000000000 -0600
@@ -40,8 +40,13 @@
 main menu.  This provides a socket interface to IPMI.  You may select
 both of these at the same time, they will both work together.
 
-There is also a KCS-only driver interface supplied, most IPMI systems
-support KCS, so you need taht.
+The driver interface depends on your hardware.  If you have a board
+with a standard interface (These will generally be either "KCS",
+"SMIC", or "BT", consult your hardware manual), choose the 'IPMI SI
+handler' option.
+
+There is also a KCS-only driver interface supplied, but it is
+depracated in favor of the SI interface.
 
 You should generally enable ACPI on your system, as systems with IPMI
 should have ACPI tables describing them.
@@ -84,8 +89,13 @@
 driver, each open file for this device ties in to the message handler
 as an IPMI user.
 
+ipmi_si_drv - A driver for various system interfaces.  This supports
+KCS, SMIC, and may support BT in the future.  Unless you have your own
+custom interface, you probably need to use this.
+
 ipmi_kcs_drv - A driver for the KCS SI.  Most systems have a KCS
-interface for IPMI.
+interface for IPMI.  This is deprecated, ipmi_si_drv supports KCS and
+SMIC interfaces.
 
 
 Much documentation for the interface is in the include files.  The
@@ -308,6 +318,64 @@
 that for more details.
 
 
+The SI Driver
+-------------
+
+The SI driver allows up to 4 KCS or SMIC interfaces to be configured
+in the system.  By default, scan the ACPI tables for interfaces, and
+if it doesn't find any the driver will attempt to register one KCS
+interface at the spec-specified I/O port 0xca2 without interrupts.
+You can change this at module load time (for a module) with:
+
+  insmod ipmi_si_drv.o si_type=<type1>,<type2>....
+       si_ports=<port1>,<port2>... si_addrs=<addr1>,<addr2>
+       si_irqs=<irq1>,<irq2>... si_trydefaults=[0|1]
+
+Each of these except si_trydefaults is a list, the first item for the
+first interface, second item for the second interface, etc.
+
+The si_type may be either "kcs", "smic", or "bt".  If you leave it blank, it
+defaults to "kcs".
+
+If you specify si_addrs as non-zero for an interface, the driver will
+use the memory address given as the address of the device.  This
+overrides si_ports.
+
+If you specify si_ports as non-zero for an interface, the driver will
+use the I/O port given as the device address.
+
+If you specify si_irqs as non-zero for an interface, the driver will
+attempt to use the given interrupt for the device.
+
+si_trydefaults sets whether the standard IPMI interface at 0xca2 and
+any interfaces specified by ACPE are tried.  By default, the driver
+tries it, set this value to zero to turn this off.
+
+When compiled into the kernel, the addresses can be specified on the
+kernel command line as:
+
+  ipmi_si=[<type>,]<bmc1>:<irq1>,[<type>,]<bmc2>:<irq2>....,[nodefault]
+
+The type is optional and may be either "kcs" for KCS, "smic" for
+SMIC, or "bt" for BT.  If not specified, it defaults to KCS.
+The <bmcx> values is either "p<port>" or "m<addr>" for port or memory
+addresses.  So for instance, a KCS interface at port 0xca2 using
+interrupt 9 and a SMIC memory interface at address 0xf9827341 with no
+interrupt would be specified "ipmi_si=k,p0xca2:9,s,m0xf9827341".  If you
+specify zero for in irq or don't specify it, the driver will run polled
+unless the software can detect the interrupt to use in the ACPI tables.
+
+By default, the driver will attempt to detect a KCS device at the
+spec-specified 0xca2 address and any address specified by ACPI.  If
+you want to turn this off, use the "nodefault" option.
+
+If you have high-res timers compiled into the kernel, the driver will
+use them to provide much better performance.  Note that if you do not
+have high-res timers enabled in the kernel and you don't have
+interrupts enabled, the driver will run VERY slowly.  Don't blame me,
+these interfaces suck.
+
+
 The KCS Driver
 --------------
 
diff -urN linux-a1/drivers/char/ipmi/ipmi_bt_sm.c linux-a2/drivers/char/ipmi/ipmi_bt_sm.c
--- linux-a1/drivers/char/ipmi/ipmi_bt_sm.c	1969-12-31 18:00:00.000000000 -0600
+++ linux-a2/drivers/char/ipmi/ipmi_bt_sm.c	2004-02-23 08:27:14.000000000 -0600
@@ -0,0 +1,511 @@
+/*
+ *  ipmi_bt_sm.c
+ *
+ *  The state machine for an Open IPMI BT sub-driver under ipmi_si.c, part
+ *  of the driver architecture at http://sourceforge.net/project/openipmi
+ *
+ *  Author:	Rocky Craig <first.last@hp.com>
+ *
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under the terms of the GNU General Public License as published by the
+ *  Free Software Foundation; either version 2 of the License, or (at your
+ *  option) any later version.
+ *
+ *  THIS SOFTWARE IS PROVIDED ``AS IS'' AND ANY EXPRESS OR IMPLIED
+ *  WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
+ *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
+ *  IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
+ *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
+ *  BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS
+ *  OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
+ *  ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR
+ *  TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE
+ *  USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  675 Mass Ave, Cambridge, MA 02139, USA.  */
+
+#include <linux/kernel.h> /* For printk. */
+#include <linux/string.h>
+#include <linux/ipmi_msgdefs.h>		/* for completion codes */
+#include "ipmi_si_sm.h"
+
+#define IPMI_BT_VERSION "v30"
+
+static int bt_debug = 0x00;	/* Production value 0, see following flags */
+
+#define	BT_DEBUG_ENABLE	1
+#define BT_DEBUG_MSG	2
+#define BT_DEBUG_STATES	4
+
+/* Typical "Get BT Capabilities" values are 2-3 retries, 5-10 seconds,
+   and 64 byte buffers.  However, one HP implementation wants 255 bytes of
+   buffer (with a documented message of 160 bytes) so go for the max. 
+   Since the Open IPMI architecture is single-message oriented at this
+   stage, the queue depth of BT is of no concern. */
+
+#define BT_NORMAL_TIMEOUT	2000000	/* seconds in microseconds */
+#define BT_RETRY_LIMIT		2
+#define BT_RESET_DELAY		6000000	/* 6 seconds after warm reset */
+
+enum bt_states {
+	BT_STATE_IDLE,
+	BT_STATE_XACTION_START,
+	BT_STATE_WRITE_BYTES,
+	BT_STATE_WRITE_END,
+	BT_STATE_WRITE_CONSUME,
+	BT_STATE_B2H_WAIT,
+	BT_STATE_READ_END,
+	BT_STATE_RESET1,		/* These must come last */
+	BT_STATE_RESET2,
+	BT_STATE_RESET3,
+	BT_STATE_RESTART,
+	BT_STATE_HOSED
+};
+
+struct si_sm_data {
+	enum bt_states	state;
+	enum bt_states	last_state;	/* assist printing and resets */
+	unsigned char	seq;		/* BT sequence number */
+	struct si_sm_io	*io;
+        unsigned char	write_data[IPMI_MAX_MSG_LENGTH];
+        int		write_count;
+        unsigned char	read_data[IPMI_MAX_MSG_LENGTH];
+        int		read_count;
+        int		truncated;
+        long		timeout;
+        unsigned int	error_retries;	/* end of "common" fields */
+	int		nonzero_status;	/* hung BMCs stay all 0 */
+};
+
+#define BT_CLR_WR_PTR	0x01	/* See IPMI 1.5 table 11.6.4 */
+#define BT_CLR_RD_PTR	0x02
+#define BT_H2B_ATN	0x04
+#define BT_B2H_ATN	0x08
+#define BT_SMS_ATN	0x10
+#define BT_OEM0		0x20
+#define BT_H_BUSY	0x40
+#define BT_B_BUSY	0x80
+
+/* Some bits are toggled on each write: write once to set it, once
+   more to clear it; writing a zero does nothing.  To absolutely
+   clear it, check its state and write if set.  This avoids the "get 
+   current then use as mask" scheme to modify one bit.  Note that the 
+   variable "bt" is hardcoded into these macros. */ 
+
+#define BT_STATUS	bt->io->inputb(bt->io, 0)
+#define BT_CONTROL(x)	bt->io->outputb(bt->io, 0, x)
+
+#define BMC2HOST	bt->io->inputb(bt->io, 1)
+#define HOST2BMC(x)	bt->io->outputb(bt->io, 1, x)
+
+#define BT_INTMASK_R	bt->io->inputb(bt->io, 2)
+#define BT_INTMASK_W(x)	bt->io->outputb(bt->io, 2, x)
+
+/* Convenience routines for debugging.  These are not multi-open safe!
+   Note the macros have hardcoded variables in them. */
+
+static char *state2txt(unsigned char state)
+{
+	switch (state) {
+		case BT_STATE_IDLE:		return("IDLE");
+		case BT_STATE_XACTION_START:	return("XACTION");
+		case BT_STATE_WRITE_BYTES:	return("WR_BYTES");
+		case BT_STATE_WRITE_END:	return("WR_END");
+		case BT_STATE_WRITE_CONSUME:	return("WR_CONSUME");
+		case BT_STATE_B2H_WAIT:		return("B2H_WAIT");
+		case BT_STATE_READ_END:		return("RD_END");
+		case BT_STATE_RESET1:		return("RESET1");
+		case BT_STATE_RESET2:		return("RESET2");
+		case BT_STATE_RESET3:		return("RESET3");
+		case BT_STATE_RESTART:		return("RESTART");
+		case BT_STATE_HOSED:		return("HOSED");
+	}
+	return("BAD STATE");
+}
+#define STATE2TXT state2txt(bt->state)
+
+static char *status2txt(unsigned char status)
+{
+	static char msg[40];
+	strcpy(msg, "[ ");
+	if (status & BT_B_BUSY) strcat(msg, "B_BUSY ");
+	if (status & BT_H_BUSY) strcat(msg, "H_BUSY ");
+	if (status & BT_OEM0) strcat(msg, "OEM0 ");
+	if (status & BT_SMS_ATN) strcat(msg, "SMS ");
+	if (status & BT_B2H_ATN) strcat(msg, "B2H ");
+	if (status & BT_H2B_ATN) strcat(msg, "H2B ");
+	strcat(msg, "]");
+	return msg;
+}
+#define STATUS2TXT status2txt(status)
+
+/* This will be called from within this module on a hosed condition */
+#define FIRST_SEQ	0
+static unsigned int bt_init_data(struct si_sm_data *bt, struct si_sm_io *io)
+{
+	bt->state = BT_STATE_IDLE;
+	bt->last_state = BT_STATE_IDLE;
+	bt->seq = FIRST_SEQ;
+	bt->io = io;
+	bt->write_count = 0;
+	bt->read_count = 0;
+	bt->error_retries = 0;
+	bt->nonzero_status = 0;
+	bt->truncated = 0;
+	bt->timeout = BT_NORMAL_TIMEOUT;
+	return 3; /* We claim 3 bytes of space; ought to check SPMI table */
+}
+
+static int bt_start_transaction(struct si_sm_data *bt,
+				unsigned char *data, 
+				unsigned int size)
+{
+	unsigned int i;
+
+	if ((size < 2) || (size > IPMI_MAX_MSG_LENGTH)) return -1;
+	
+	if ((bt->state != BT_STATE_IDLE) && (bt->state != BT_STATE_HOSED))
+		return -2;
+	
+	if (bt_debug & BT_DEBUG_MSG) {
+    		printk(KERN_WARNING "+++++++++++++++++++++++++++++++++++++\n");
+		printk(KERN_WARNING "BT: write seq=0x%02X:", bt->seq);
+		for (i = 0; i < size; i ++) printk (" %02x", data[i]);
+		printk("\n");
+	}
+	bt->write_data[0] = size + 1;	/* all data plus seq byte */
+	bt->write_data[1] = *data;	/* NetFn/LUN */
+	bt->write_data[2] = bt->seq;
+	memcpy(bt->write_data + 3, data + 1, size - 1);
+	bt->write_count = size + 2;
+
+	bt->error_retries = 0;
+	bt->nonzero_status = 0;
+	bt->read_count = 0;
+	bt->truncated = 0;
+	bt->state = BT_STATE_XACTION_START;
+	bt->last_state = BT_STATE_IDLE;
+	bt->timeout = BT_NORMAL_TIMEOUT;
+	return 0;
+}
+
+/* After the upper state machine has been told SI_SM_TRANSACTION_COMPLETE 
+   it calls this.  Strip out the length and seq bytes. */
+
+static int bt_get_result(struct si_sm_data *bt,
+			   unsigned char *data, 
+			   unsigned int length)
+{
+	int i, msg_len;
+
+	msg_len = bt->read_count - 2;		/* account for length & seq */
+	/* Always NetFn, Cmd, cCode */
+	if (msg_len < 3 || msg_len > IPMI_MAX_MSG_LENGTH) {
+		printk(KERN_WARNING "BT results: bad msg_len = %d\n", msg_len);
+		data[0] = bt->write_data[1] | 0x4;	/* Kludge a response */
+		data[1] = bt->write_data[3];
+		data[2] = IPMI_ERR_UNSPECIFIED;
+		msg_len = 3;
+	} else {
+		data[0] = bt->read_data[1];
+		data[1] = bt->read_data[3];
+		if (length < msg_len) bt->truncated = 1;
+		if (bt->truncated) {	/* can be set in read_all_bytes() */
+			data[2] = IPMI_ERR_MSG_TRUNCATED;
+			msg_len = 3;
+		} else memcpy(data + 2, bt->read_data + 4, msg_len - 2);
+	
+		if (bt_debug & BT_DEBUG_MSG) {
+			printk (KERN_WARNING "BT: res (raw)");
+			for (i = 0; i < msg_len; i++) printk(" %02x", data[i]);
+			printk ("\n");
+		}
+	}
+	bt->read_count = 0;	/* paranoia */
+	return msg_len;
+}
+
+/* This bit's functionality is optional */
+#define BT_BMC_HWRST	0x80
+
+static void reset_flags(struct si_sm_data *bt)
+{
+	if (BT_STATUS & BT_H_BUSY) BT_CONTROL(BT_H_BUSY);
+	if (BT_STATUS & BT_B_BUSY) BT_CONTROL(BT_B_BUSY);
+	BT_CONTROL(BT_CLR_WR_PTR);
+	BT_CONTROL(BT_SMS_ATN);
+	BT_INTMASK_W(BT_BMC_HWRST);
+#ifdef DEVELOPMENT_ONLY_NOT_FOR_PRODUCTION
+	if (BT_STATUS & BT_B2H_ATN) {
+		int i;
+		BT_CONTROL(BT_H_BUSY);
+		BT_CONTROL(BT_B2H_ATN);
+		BT_CONTROL(BT_CLR_RD_PTR);
+		for (i = 0; i < IPMI_MAX_MSG_LENGTH + 2; i++) BMC2HOST;
+		BT_CONTROL(BT_H_BUSY);
+	}
+#endif
+}
+
+static inline void write_all_bytes(struct si_sm_data *bt)
+{
+	int i;
+
+	if (bt_debug & BT_DEBUG_MSG) {
+    		printk(KERN_WARNING "BT: write %d bytes seq=0x%02X", 
+			bt->write_count, bt->seq);
+		for (i = 0; i < bt->write_count; i++) 
+			printk (" %02x", bt->write_data[i]);
+		printk ("\n");
+	}
+	for (i = 0; i < bt->write_count; i++) HOST2BMC(bt->write_data[i]);
+}
+
+static inline int read_all_bytes(struct si_sm_data *bt)
+{
+	unsigned char i;
+
+	bt->read_data[0] = BMC2HOST;	
+	bt->read_count = bt->read_data[0];
+	if (bt_debug & BT_DEBUG_MSG) 
+    		printk(KERN_WARNING "BT: read %d bytes:", bt->read_count);
+
+	/* minimum: length, NetFn, Seq, Cmd, cCode == 5 total, or 4 more 
+	   following the length byte. */
+	if (bt->read_count < 4 || bt->read_count >= IPMI_MAX_MSG_LENGTH) {
+		if (bt_debug & BT_DEBUG_MSG) 
+			printk("bad length %d\n", bt->read_count);
+		bt->truncated = 1;
+		return 1;	/* let next XACTION START clean it up */
+	}
+	for (i = 1; i <= bt->read_count; i++) bt->read_data[i] = BMC2HOST;	
+	bt->read_count++;	/* account for the length byte */
+
+	if (bt_debug & BT_DEBUG_MSG) {
+	    	for (i = 0; i < bt->read_count; i++) 
+			printk (" %02x", bt->read_data[i]);
+	    	printk ("\n");
+	}
+	if (bt->seq != bt->write_data[2])	/* idiot check */
+		printk(KERN_WARNING "BT: internal error: sequence mismatch\n");
+
+	/* per the spec, the (NetFn, Seq, Cmd) tuples should match */
+	if ((bt->read_data[3] == bt->write_data[3]) &&		/* Cmd */
+        	(bt->read_data[2] == bt->write_data[2]) &&	/* Sequence */
+        	((bt->read_data[1] & 0xF8) == (bt->write_data[1] & 0xF8))) 
+			return 1;
+
+	if (bt_debug & BT_DEBUG_MSG) printk(KERN_WARNING "BT: bad packet: "
+		"want 0x(%02X, %02X, %02X) got (%02X, %02X, %02X)\n", 
+		bt->write_data[1], bt->write_data[2], bt->write_data[3],
+		bt->read_data[1],  bt->read_data[2],  bt->read_data[3]);
+	return 0;
+}
+
+/* Modifies bt->state appropriately, need to get into the bt_event() switch */
+
+static void error_recovery(struct si_sm_data *bt, char *reason)
+{
+	volatile unsigned char status;
+
+	bt->timeout = BT_NORMAL_TIMEOUT; /* various places want to retry */
+
+	status = BT_STATUS;
+	printk(KERN_WARNING "BT: %s in %s %s ", reason, STATE2TXT, STATUS2TXT);
+
+	(bt->error_retries)++;
+	if (bt->error_retries > BT_RETRY_LIMIT) {
+		printk("retry limit (%d) exceeded\n", BT_RETRY_LIMIT);
+		bt->state = BT_STATE_HOSED;
+		if (!bt->nonzero_status)
+			printk(KERN_ERR "IPMI: BT stuck, try power cycle\n");
+		else if (bt->seq == FIRST_SEQ + BT_RETRY_LIMIT) {
+			/* most likely during insmod */
+			printk(KERN_WARNING "IPMI: BT reset (takes 5 secs)\n");
+        		bt->state = BT_STATE_RESET1;
+		}
+	return;
+	}
+
+	/* Sometimes the BMC queues get in an "off-by-one" state...*/
+	if ((bt->state == BT_STATE_B2H_WAIT) && (status & BT_B2H_ATN)) {
+    		printk("retry B2H_WAIT\n");
+		return;
+	}
+    
+	printk("restart command\n");
+	bt->state = BT_STATE_RESTART;
+}
+
+/* Check the status and (possibly) advance the BT state machine.  The
+   default return is SI_SM_CALL_WITH_DELAY. */
+
+static enum si_sm_result bt_event(struct si_sm_data *bt, long time)
+{
+	volatile unsigned char status;
+	int i;
+
+	status = BT_STATUS;
+	bt->nonzero_status |= status;
+
+	if ((bt_debug & BT_DEBUG_STATES) && (bt->state != bt->last_state))
+		printk(KERN_WARNING "BT: %s %s TO=%ld - %ld \n",
+			STATE2TXT,
+			STATUS2TXT, 
+			bt->timeout, 
+			time);
+	bt->last_state = bt->state;
+  
+	if (bt->state == BT_STATE_HOSED) return SI_SM_HOSED;
+    
+	if (bt->state != BT_STATE_IDLE) {	/* do timeout test */
+
+		/* Certain states, on error conditions, can lock up a CPU 
+		   because they are effectively in an infinite loop with 
+		   CALL_WITHOUT_DELAY (right back here with time == 0).  
+		   Prevent infinite lockup by ALWAYS decrementing timeout. */
+
+    	/* FIXME: bt_event is sometimes called with time > BT_NORMAL_TIMEOUT
+              (noticed in ipmi_smic_sm.c January 2004) */
+
+		if ((time <= 0) || (time >= BT_NORMAL_TIMEOUT)) time = 100;
+		bt->timeout -= time;
+		if ((bt->timeout < 0) && (bt->state < BT_STATE_RESET1)) {
+			error_recovery(bt, "timed out");
+			return SI_SM_CALL_WITHOUT_DELAY;
+		}
+	}
+
+	switch (bt->state) {
+
+    	case BT_STATE_IDLE:	/* check for asynchronous messages */
+		if (status & BT_SMS_ATN) {
+			BT_CONTROL(BT_SMS_ATN);	/* clear it */
+			return SI_SM_ATTN;
+		}
+		return SI_SM_IDLE;
+
+	case BT_STATE_XACTION_START:
+		if (status & BT_H_BUSY) { 
+			BT_CONTROL(BT_H_BUSY);
+			break;
+		}
+    		if (status & BT_B2H_ATN) break;
+		bt->state = BT_STATE_WRITE_BYTES;
+		return SI_SM_CALL_WITHOUT_DELAY;	/* for logging */
+
+	case BT_STATE_WRITE_BYTES:
+		if (status & (BT_B_BUSY | BT_H2B_ATN)) break;
+		BT_CONTROL(BT_CLR_WR_PTR);
+		write_all_bytes(bt);
+		BT_CONTROL(BT_H2B_ATN);	/* clears too fast to catch? */
+		bt->state = BT_STATE_WRITE_CONSUME;
+		return SI_SM_CALL_WITHOUT_DELAY; /* it MIGHT sail through */
+
+	case BT_STATE_WRITE_CONSUME: /* BMCs usually blow right thru here */
+        	if (status & (BT_H2B_ATN | BT_B_BUSY)) break;
+		bt->state = BT_STATE_B2H_WAIT;
+		/* fall through with status */
+
+	/* Stay in BT_STATE_B2H_WAIT until a packet matches.  However, spinning 
+	   hard here, constantly reading status, seems to hold off the 
+	   generation of B2H_ATN so ALWAYS return CALL_WITH_DELAY. */
+
+	case BT_STATE_B2H_WAIT:
+    		if (!(status & BT_B2H_ATN)) break;
+		
+		/* Assume ordered, uncached writes: no need to wait */
+		if (!(status & BT_H_BUSY)) BT_CONTROL(BT_H_BUSY); /* set */
+		BT_CONTROL(BT_B2H_ATN);		/* clear it, ACK to the BMC */
+		BT_CONTROL(BT_CLR_RD_PTR);	/* reset the queue */
+		i = read_all_bytes(bt);
+		BT_CONTROL(BT_H_BUSY);		/* clear */
+		if (!i) break;			/* Try this state again */
+		bt->state = BT_STATE_READ_END;
+		return SI_SM_CALL_WITHOUT_DELAY;	/* for logging */
+
+    	case BT_STATE_READ_END:
+
+		/* I could wait on BT_H_BUSY to go clear for a truly clean 
+		   exit.  However, this is already done in XACTION_START
+		   and the (possible) extra loop/status/possible wait affects 
+		   performance.  So, as long as it works, just ignore H_BUSY */
+
+#ifdef MAKE_THIS_TRUE_IF_NECESSARY
+
+		if (status & BT_H_BUSY) break;
+#endif
+		bt->seq++;
+		bt->state = BT_STATE_IDLE;
+		return SI_SM_TRANSACTION_COMPLETE;
+
+	case BT_STATE_RESET1:
+    		reset_flags(bt);
+    		bt->timeout = BT_RESET_DELAY;;
+		bt->state = BT_STATE_RESET2;
+		break;
+
+	case BT_STATE_RESET2:		/* Send a soft reset */
+		BT_CONTROL(BT_CLR_WR_PTR);
+		HOST2BMC(3);		/* number of bytes following */
+		HOST2BMC(0x18);		/* NetFn/LUN == Application, LUN 0 */
+		HOST2BMC(42);		/* Sequence number */
+		HOST2BMC(3);		/* Cmd == Soft reset */
+		BT_CONTROL(BT_H2B_ATN);	
+		bt->state = BT_STATE_RESET3;
+		break;
+
+	case BT_STATE_RESET3:
+		if (bt->timeout > 0) return SI_SM_CALL_WITH_DELAY;
+		bt->state = BT_STATE_RESTART;	/* printk in debug modes */
+		break;
+
+	case BT_STATE_RESTART:		/* don't reset retries! */
+		bt->write_data[2] = ++bt->seq;
+		bt->read_count = 0;
+		bt->nonzero_status = 0;
+		bt->timeout = BT_NORMAL_TIMEOUT;
+		bt->state = BT_STATE_XACTION_START;
+		break;
+
+	default:	/* HOSED is supposed to be caught much earlier */
+		error_recovery(bt, "internal logic error");
+		break;
+  	}
+  	return SI_SM_CALL_WITH_DELAY;
+}
+
+static int bt_detect(struct si_sm_data *bt)
+{
+	/* It's impossible for the BT status and interrupt registers to be 
+	   all 1's, (assuming a properly functioning, self-initialized BMC)
+	   but that's what you get from reading a bogus address, so we
+	   test that first.  The calling routine uses negative logic. */
+
+	if ((BT_STATUS == 0xFF) && (BT_INTMASK_R == 0xFF)) return 1;
+	reset_flags(bt);
+	return 0;
+}
+
+static void bt_cleanup(struct si_sm_data *bt)
+{
+}
+
+static int bt_size(void)
+{
+	return sizeof(struct si_sm_data);
+}
+
+struct si_sm_handlers bt_smi_handlers =
+{
+	.version           = IPMI_BT_VERSION,
+	.init_data         = bt_init_data,
+	.start_transaction = bt_start_transaction,
+	.get_result        = bt_get_result,
+	.event             = bt_event,
+	.detect            = bt_detect,
+	.cleanup           = bt_cleanup,
+	.size              = bt_size,
+};
diff -urN linux-a1/drivers/char/ipmi/ipmi_si.c linux-a2/drivers/char/ipmi/ipmi_si.c
--- linux-a1/drivers/char/ipmi/ipmi_si.c	1969-12-31 18:00:00.000000000 -0600
+++ linux-a2/drivers/char/ipmi/ipmi_si.c	2004-02-23 08:27:14.000000000 -0600
@@ -0,0 +1,2077 @@
+/*
+ * ipmi_si.c
+ *
+ * The interface to the IPMI driver for the system interfaces (KCS, SMIC,
+ * BT in the future).
+ *
+ * Author: MontaVista Software, Inc.
+ *         Corey Minyard <minyard@mvista.com>
+ *         source@mvista.com
+ *
+ * Copyright 2002 MontaVista Software Inc.
+ *
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under the terms of the GNU General Public License as published by the
+ *  Free Software Foundation; either version 2 of the License, or (at your
+ *  option) any later version.
+ *
+ *
+ *  THIS SOFTWARE IS PROVIDED ``AS IS'' AND ANY EXPRESS OR IMPLIED
+ *  WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
+ *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
+ *  IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
+ *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
+ *  BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS
+ *  OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
+ *  ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR
+ *  TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE
+ *  USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+/*
+ * This file holds the "policy" for the interface to the SMI state
+ * machine.  It does the configuration, handles timers and interrupts,
+ * and drives the real SMI state machine.
+ */
+
+#include <linux/config.h>
+#include <linux/module.h>
+#include <asm/system.h>
+#include <linux/sched.h>
+#include <linux/timer.h>
+#include <linux/errno.h>
+#include <linux/spinlock.h>
+#include <linux/slab.h>
+#include <linux/delay.h>
+#include <linux/list.h>
+#include <linux/pci.h>
+#include <linux/ioport.h>
+#ifdef CONFIG_HIGH_RES_TIMERS
+#include <linux/hrtime.h>
+# if defined(schedule_next_int)
+/* Old high-res timer code, do translations. */
+#  define get_arch_cycles(a) quick_update_jiffies_sub(a) 
+#  define arch_cycles_per_jiffy cycles_per_jiffies
+# endif
+static inline void add_usec_to_timer(struct timer_list *t, long v)
+{
+	t->sub_expires += nsec_to_arch_cycle(v * 1000);
+	while (t->sub_expires >= arch_cycles_per_jiffy)
+	{
+		t->expires++;
+		t->sub_expires -= arch_cycles_per_jiffy;
+	}
+}
+#endif
+#include <linux/interrupt.h>
+#include <linux/rcupdate.h>
+#include <linux/ipmi_smi.h>
+#include <asm/io.h>
+#include <asm/irq.h>
+#include "ipmi_si_sm.h"
+#include <linux/init.h>
+
+#define IPMI_SI_VERSION "v30"
+
+/* Measure times between events in the driver. */
+#undef DEBUG_TIMING
+
+/* Call every 10 ms. */
+#define SI_TIMEOUT_TIME_USEC	10000
+#define SI_USEC_PER_JIFFY	(1000000/HZ)
+#define SI_TIMEOUT_JIFFIES	(SI_TIMEOUT_TIME_USEC/SI_USEC_PER_JIFFY)
+#define SI_SHORT_TIMEOUT_USEC  250 /* .25ms when the SM request a
+                                       short timeout */
+
+enum si_intf_state {
+	SI_NORMAL,
+	SI_GETTING_FLAGS,
+	SI_GETTING_EVENTS,
+	SI_CLEARING_FLAGS,
+	SI_CLEARING_FLAGS_THEN_SET_IRQ,
+	SI_GETTING_MESSAGES,
+	SI_ENABLE_INTERRUPTS1,
+	SI_ENABLE_INTERRUPTS2
+	/* FIXME - add watchdog stuff. */
+};
+
+enum si_type {
+    SI_KCS, SI_SMIC, SI_BT
+};
+
+struct smi_info
+{
+	ipmi_smi_t             intf;
+	struct si_sm_data      *si_sm;
+	struct si_sm_handlers  *handlers;
+	enum si_type           si_type;
+	spinlock_t             si_lock;
+	spinlock_t             msg_lock;
+	struct list_head       xmit_msgs;
+	struct list_head       hp_xmit_msgs;
+	struct ipmi_smi_msg    *curr_msg;
+	enum si_intf_state     si_state;
+
+	/* Used to handle the various types of I/O that can occur with
+           IPMI */
+	struct si_sm_io io;
+	int (*io_setup)(struct smi_info *info);
+	void (*io_cleanup)(struct smi_info *info);
+	int (*irq_setup)(struct smi_info *info);
+	void (*irq_cleanup)(struct smi_info *info);
+	unsigned int io_size;
+
+	/* Flags from the last GET_MSG_FLAGS command, used when an ATTN
+	   is set to hold the flags until we are done handling everything
+	   from the flags. */
+#define RECEIVE_MSG_AVAIL	0x01
+#define EVENT_MSG_BUFFER_FULL	0x02
+#define WDT_PRE_TIMEOUT_INT	0x08
+	unsigned char       msg_flags;
+
+	/* If set to true, this will request events the next time the
+	   state machine is idle. */
+	atomic_t            req_events;
+
+	/* If true, run the state machine to completion on every send
+	   call.  Generally used after a panic to make sure stuff goes
+	   out. */
+	int                 run_to_completion;
+
+	/* The I/O port of an SI interface. */
+	int                 port;
+
+	/* zero if no irq; */
+	int                 irq;
+
+	/* The timer for this si. */
+	struct timer_list   si_timer;
+
+	/* The time (in jiffies) the last timeout occurred at. */
+	unsigned long       last_timeout_jiffies;
+
+	/* Used to gracefully stop the timer without race conditions. */
+	volatile int        stop_operation;
+	volatile int        timer_stopped;
+
+	/* The driver will disable interrupts when it gets into a
+	   situation where it cannot handle messages due to lack of
+	   memory.  Once that situation clears up, it will re-enable
+	   interrupts. */
+	int interrupt_disabled;
+
+	unsigned char ipmi_si_dev_rev;
+	unsigned char ipmi_si_fw_rev_major;
+	unsigned char ipmi_si_fw_rev_minor;
+	unsigned char ipmi_version_major;
+	unsigned char ipmi_version_minor;
+
+	/* Counters and things for the proc filesystem. */
+	spinlock_t count_lock;
+	unsigned long short_timeouts;
+	unsigned long long_timeouts;
+	unsigned long timeout_restarts;
+	unsigned long idles;
+	unsigned long interrupts;
+	unsigned long attentions;
+	unsigned long flag_fetches;
+	unsigned long hosed_count;
+	unsigned long complete_transactions;
+	unsigned long events;
+	unsigned long watchdog_pretimeouts;
+	unsigned long incoming_messages;
+};
+
+static void si_restart_short_timer(struct smi_info *smi_info);
+
+static void deliver_recv_msg(struct smi_info *smi_info,
+			     struct ipmi_smi_msg *msg)
+{
+	/* Deliver the message to the upper layer with the lock
+           released. */
+	spin_unlock(&(smi_info->si_lock));
+	ipmi_smi_msg_received(smi_info->intf, msg);
+	spin_lock(&(smi_info->si_lock));
+}
+
+static void return_hosed_msg(struct smi_info *smi_info)
+{
+	struct ipmi_smi_msg *msg = smi_info->curr_msg;
+
+	/* Make it a reponse */
+	msg->rsp[0] = msg->data[0] | 4;
+	msg->rsp[1] = msg->data[1];
+	msg->rsp[2] = 0xFF; /* Unknown error. */
+	msg->rsp_size = 3;
+			
+	smi_info->curr_msg = NULL;
+	deliver_recv_msg(smi_info, msg);
+}
+
+static enum si_sm_result start_next_msg(struct smi_info *smi_info)
+{
+	int              rv;
+	struct list_head *entry = NULL;
+#ifdef DEBUG_TIMING
+	struct timeval t;
+#endif
+
+	/* No need to save flags, we aleady have interrupts off and we
+	   already hold the SMI lock. */
+	spin_lock(&(smi_info->msg_lock));
+	
+	/* Pick the high priority queue first. */
+	if (! list_empty(&(smi_info->hp_xmit_msgs))) {
+		entry = smi_info->hp_xmit_msgs.next;
+	} else if (! list_empty(&(smi_info->xmit_msgs))) {
+		entry = smi_info->xmit_msgs.next;
+	}
+
+	if (!entry) {
+		smi_info->curr_msg = NULL;
+		rv = SI_SM_IDLE;
+	} else {
+		int err;
+
+		list_del(entry);
+		smi_info->curr_msg = list_entry(entry,
+						struct ipmi_smi_msg,
+						link);
+#ifdef DEBUG_TIMING
+		do_gettimeofday(&t);
+		printk("**Start2: %d.%9.9d\n", t.tv_sec, t.tv_usec);
+#endif
+		err = smi_info->handlers->start_transaction(
+			smi_info->si_sm,
+			smi_info->curr_msg->data,
+			smi_info->curr_msg->data_size);
+		if (err) {
+			return_hosed_msg(smi_info);
+		}
+
+		rv = SI_SM_CALL_WITHOUT_DELAY;
+	}
+	spin_unlock(&(smi_info->msg_lock));
+
+	return rv;
+}
+
+static void start_enable_irq(struct smi_info *smi_info)
+{
+	unsigned char msg[2];
+
+	/* If we are enabling interrupts, we have to tell the
+	   BMC to use them. */
+	msg[0] = (IPMI_NETFN_APP_REQUEST << 2);
+	msg[1] = IPMI_GET_BMC_GLOBAL_ENABLES_CMD;
+
+	smi_info->handlers->start_transaction(smi_info->si_sm, msg, 2);
+	smi_info->si_state = SI_ENABLE_INTERRUPTS1;
+}
+
+static void start_clear_flags(struct smi_info *smi_info)
+{
+	unsigned char msg[3];
+
+	/* Make sure the watchdog pre-timeout flag is not set at startup. */
+	msg[0] = (IPMI_NETFN_APP_REQUEST << 2);
+	msg[1] = IPMI_CLEAR_MSG_FLAGS_CMD;
+	msg[2] = WDT_PRE_TIMEOUT_INT;
+
+	smi_info->handlers->start_transaction(smi_info->si_sm, msg, 3);
+	smi_info->si_state = SI_CLEARING_FLAGS;
+}
+
+/* When we have a situtaion where we run out of memory and cannot
+   allocate messages, we just leave them in the BMC and run the system
+   polled until we can allocate some memory.  Once we have some
+   memory, we will re-enable the interrupt. */
+static inline void disable_si_irq(struct smi_info *smi_info)
+{
+	if ((smi_info->irq) && (!smi_info->interrupt_disabled)) {
+		disable_irq_nosync(smi_info->irq);
+		smi_info->interrupt_disabled = 1;
+	}
+}
+
+static inline void enable_si_irq(struct smi_info *smi_info)
+{
+	if ((smi_info->irq) && (smi_info->interrupt_disabled)) {
+		enable_irq(smi_info->irq);
+		smi_info->interrupt_disabled = 0;
+	}
+}
+
+static void handle_flags(struct smi_info *smi_info)
+{
+	if (smi_info->msg_flags & WDT_PRE_TIMEOUT_INT) {
+		/* Watchdog pre-timeout */
+		spin_lock(&smi_info->count_lock);
+		smi_info->watchdog_pretimeouts++;
+		spin_unlock(&smi_info->count_lock);
+
+		start_clear_flags(smi_info);
+		smi_info->msg_flags &= ~WDT_PRE_TIMEOUT_INT;
+		spin_unlock(&(smi_info->si_lock));
+		ipmi_smi_watchdog_pretimeout(smi_info->intf);
+		spin_lock(&(smi_info->si_lock));
+	} else if (smi_info->msg_flags & RECEIVE_MSG_AVAIL) {
+		/* Messages available. */
+		smi_info->curr_msg = ipmi_alloc_smi_msg();
+		if (!smi_info->curr_msg) {
+			disable_si_irq(smi_info);
+			smi_info->si_state = SI_NORMAL;
+			return;
+		}
+		enable_si_irq(smi_info);
+
+		smi_info->curr_msg->data[0] = (IPMI_NETFN_APP_REQUEST << 2);
+		smi_info->curr_msg->data[1] = IPMI_GET_MSG_CMD;
+		smi_info->curr_msg->data_size = 2;
+
+		smi_info->handlers->start_transaction(
+			smi_info->si_sm,
+			smi_info->curr_msg->data,
+			smi_info->curr_msg->data_size);
+		smi_info->si_state = SI_GETTING_MESSAGES;
+	} else if (smi_info->msg_flags & EVENT_MSG_BUFFER_FULL) {
+		/* Events available. */
+		smi_info->curr_msg = ipmi_alloc_smi_msg();
+		if (!smi_info->curr_msg) {
+			disable_si_irq(smi_info);
+			smi_info->si_state = SI_NORMAL;
+			return;
+		}
+		enable_si_irq(smi_info);
+
+		smi_info->curr_msg->data[0] = (IPMI_NETFN_APP_REQUEST << 2);
+		smi_info->curr_msg->data[1] = IPMI_READ_EVENT_MSG_BUFFER_CMD;
+		smi_info->curr_msg->data_size = 2;
+
+		smi_info->handlers->start_transaction(
+			smi_info->si_sm,
+			smi_info->curr_msg->data,
+			smi_info->curr_msg->data_size);
+		smi_info->si_state = SI_GETTING_EVENTS;
+	} else {
+		smi_info->si_state = SI_NORMAL;
+	}
+}
+
+static void handle_transaction_done(struct smi_info *smi_info)
+{
+	struct ipmi_smi_msg *msg;
+#ifdef DEBUG_TIMING
+	struct timeval t;
+
+	do_gettimeofday(&t);
+	printk("**Done: %d.%9.9d\n", t.tv_sec, t.tv_usec);
+#endif
+	switch (smi_info->si_state) {
+	case SI_NORMAL:
+		if (!smi_info->curr_msg)
+			break;
+			
+		smi_info->curr_msg->rsp_size
+			= smi_info->handlers->get_result(
+				smi_info->si_sm,
+				smi_info->curr_msg->rsp,
+				IPMI_MAX_MSG_LENGTH);
+		
+		/* Do this here becase deliver_recv_msg() releases the
+		   lock, and a new message can be put in during the
+		   time the lock is released. */
+		msg = smi_info->curr_msg;
+		smi_info->curr_msg = NULL;
+		deliver_recv_msg(smi_info, msg);
+		break;
+		
+	case SI_GETTING_FLAGS:
+	{
+		unsigned char msg[4];
+		unsigned int  len;
+
+		/* We got the flags from the SMI, now handle them. */
+		len = smi_info->handlers->get_result(smi_info->si_sm, msg, 4);
+		if (msg[2] != 0) {
+			/* Error fetching flags, just give up for
+			   now. */
+			smi_info->si_state = SI_NORMAL;
+		} else if (len < 3) {
+			/* Hmm, no flags.  That's technically illegal, but
+			   don't use uninitialized data. */
+			smi_info->si_state = SI_NORMAL;
+		} else {
+			smi_info->msg_flags = msg[3];
+			handle_flags(smi_info);
+		}
+		break;
+	}
+
+	case SI_CLEARING_FLAGS:
+	case SI_CLEARING_FLAGS_THEN_SET_IRQ:
+	{
+		unsigned char msg[3];
+
+		/* We cleared the flags. */
+		smi_info->handlers->get_result(smi_info->si_sm, msg, 3);
+		if (msg[2] != 0) {
+			/* Error clearing flags */
+			printk(KERN_WARNING
+			       "ipmi_si: Error clearing flags: %2.2x\n",
+			       msg[2]);
+		}
+		if (smi_info->si_state == SI_CLEARING_FLAGS_THEN_SET_IRQ)
+			start_enable_irq(smi_info);
+		else
+			smi_info->si_state = SI_NORMAL;
+		break;
+	}
+
+	case SI_GETTING_EVENTS:
+	{
+		smi_info->curr_msg->rsp_size
+			= smi_info->handlers->get_result(
+				smi_info->si_sm,
+				smi_info->curr_msg->rsp,
+				IPMI_MAX_MSG_LENGTH);
+
+		/* Do this here becase deliver_recv_msg() releases the
+		   lock, and a new message can be put in during the
+		   time the lock is released. */
+		msg = smi_info->curr_msg;
+		smi_info->curr_msg = NULL;
+		if (msg->rsp[2] != 0) {
+			/* Error getting event, probably done. */
+			msg->done(msg);
+
+			/* Take off the event flag. */
+			smi_info->msg_flags &= ~EVENT_MSG_BUFFER_FULL;
+		} else {
+			spin_lock(&smi_info->count_lock);
+			smi_info->events++;
+			spin_unlock(&smi_info->count_lock);
+
+			deliver_recv_msg(smi_info, msg);
+		}
+		handle_flags(smi_info);
+		break;
+	}
+
+	case SI_GETTING_MESSAGES:
+	{
+		smi_info->curr_msg->rsp_size
+			= smi_info->handlers->get_result(
+				smi_info->si_sm,
+				smi_info->curr_msg->rsp,
+				IPMI_MAX_MSG_LENGTH);
+
+		/* Do this here becase deliver_recv_msg() releases the
+		   lock, and a new message can be put in during the
+		   time the lock is released. */
+		msg = smi_info->curr_msg;
+		smi_info->curr_msg = NULL;
+		if (msg->rsp[2] != 0) {
+			/* Error getting event, probably done. */
+			msg->done(msg);
+
+			/* Take off the msg flag. */
+			smi_info->msg_flags &= ~RECEIVE_MSG_AVAIL;
+		} else {
+			spin_lock(&smi_info->count_lock);
+			smi_info->incoming_messages++;
+			spin_unlock(&smi_info->count_lock);
+
+			deliver_recv_msg(smi_info, msg);
+		}
+		handle_flags(smi_info);
+		break;
+	}
+
+	case SI_ENABLE_INTERRUPTS1:
+	{
+		unsigned char msg[4];
+
+		/* We got the flags from the SMI, now handle them. */
+		smi_info->handlers->get_result(smi_info->si_sm, msg, 4);
+		if (msg[2] != 0) {
+			printk(KERN_WARNING
+			       "ipmi_si: Could not enable interrupts"
+			       ", failed get, using polled mode.\n");
+			smi_info->si_state = SI_NORMAL;
+		} else {
+			msg[0] = (IPMI_NETFN_APP_REQUEST << 2);
+			msg[1] = IPMI_SET_BMC_GLOBAL_ENABLES_CMD;
+			msg[2] = msg[3] | 1; /* enable msg queue int */
+			smi_info->handlers->start_transaction(
+				smi_info->si_sm, msg, 3);
+			smi_info->si_state = SI_ENABLE_INTERRUPTS2;
+		}
+		break;
+	}
+
+	case SI_ENABLE_INTERRUPTS2:
+	{
+		unsigned char msg[4];
+
+		/* We got the flags from the SMI, now handle them. */
+		smi_info->handlers->get_result(smi_info->si_sm, msg, 4);
+		if (msg[2] != 0) {
+			printk(KERN_WARNING
+			       "ipmi_si: Could not enable interrupts"
+			       ", failed set, using polled mode.\n");
+		}
+		smi_info->si_state = SI_NORMAL;
+		break;
+	}
+	}
+}
+
+/* Called on timeouts and events.  Timeouts should pass the elapsed
+   time, interrupts should pass in zero. */
+static enum si_sm_result smi_event_handler(struct smi_info *smi_info,
+					   int time)
+{
+	enum si_sm_result si_sm_result;
+
+ restart:
+	/* There used to be a loop here that waited a little while
+	   (around 25us) before giving up.  That turned out to be
+	   pointless, the minimum delays I was seeing were in the 300us
+	   range, which is far too long to wait in an interrupt.  So
+	   we just run until the state machine tells us something
+	   happened or it needs a delay. */
+	si_sm_result = smi_info->handlers->event(smi_info->si_sm, time);
+	time = 0;
+	while (si_sm_result == SI_SM_CALL_WITHOUT_DELAY)
+	{
+		si_sm_result = smi_info->handlers->event(smi_info->si_sm, 0);
+	}
+
+	if (si_sm_result == SI_SM_TRANSACTION_COMPLETE)
+	{
+		spin_lock(&smi_info->count_lock);
+		smi_info->complete_transactions++;
+		spin_unlock(&smi_info->count_lock);
+
+		handle_transaction_done(smi_info);
+		si_sm_result = smi_info->handlers->event(smi_info->si_sm, 0);
+	}
+	else if (si_sm_result == SI_SM_HOSED)
+	{
+		spin_lock(&smi_info->count_lock);
+		smi_info->hosed_count++;
+		spin_unlock(&smi_info->count_lock);
+
+		if (smi_info->curr_msg != NULL) {
+			/* If we were handling a user message, format
+                           a response to send to the upper layer to
+                           tell it about the error. */
+			return_hosed_msg(smi_info);
+		}
+		si_sm_result = smi_info->handlers->event(smi_info->si_sm, 0);
+		smi_info->si_state = SI_NORMAL;
+	}
+
+	/* We prefer handling attn over new messages. */
+	if (si_sm_result == SI_SM_ATTN)
+	{
+		unsigned char msg[2];
+
+		spin_lock(&smi_info->count_lock);
+		smi_info->attentions++;
+		spin_unlock(&smi_info->count_lock);
+
+		/* Got a attn, send down a get message flags to see
+                   what's causing it.  It would be better to handle
+                   this in the upper layer, but due to the way
+                   interrupts work with the SMI, that's not really
+                   possible. */
+		msg[0] = (IPMI_NETFN_APP_REQUEST << 2);
+		msg[1] = IPMI_GET_MSG_FLAGS_CMD;
+
+		smi_info->handlers->start_transaction(
+			smi_info->si_sm, msg, 2);
+		smi_info->si_state = SI_GETTING_FLAGS;
+		goto restart;
+	}
+
+	/* If we are currently idle, try to start the next message. */
+	if (si_sm_result == SI_SM_IDLE) {
+		spin_lock(&smi_info->count_lock);
+		smi_info->idles++;
+		spin_unlock(&smi_info->count_lock);
+
+		si_sm_result = start_next_msg(smi_info);
+		if (si_sm_result != SI_SM_IDLE)
+			goto restart;
+        }
+
+	if ((si_sm_result == SI_SM_IDLE)
+	    && (atomic_read(&smi_info->req_events)))
+	{
+		/* We are idle and the upper layer requested that I fetch
+		   events, so do so. */
+		unsigned char msg[2];
+
+		spin_lock(&smi_info->count_lock);
+		smi_info->flag_fetches++;
+		spin_unlock(&smi_info->count_lock);
+
+		atomic_set(&smi_info->req_events, 0);
+		msg[0] = (IPMI_NETFN_APP_REQUEST << 2);
+		msg[1] = IPMI_GET_MSG_FLAGS_CMD;
+
+		smi_info->handlers->start_transaction(
+			smi_info->si_sm, msg, 2);
+		smi_info->si_state = SI_GETTING_FLAGS;
+		goto restart;
+	}
+
+	return si_sm_result;
+}
+
+static void sender(void                *send_info,
+		   struct ipmi_smi_msg *msg,
+		   int                 priority)
+{
+	struct smi_info   *smi_info = (struct smi_info *) send_info;
+	enum si_sm_result result;
+	unsigned long     flags;
+#ifdef DEBUG_TIMING
+	struct timeval    t;
+#endif
+
+	spin_lock_irqsave(&(smi_info->msg_lock), flags);
+#ifdef DEBUG_TIMING
+	do_gettimeofday(&t);
+	printk("**Enqueue: %d.%9.9d\n", t.tv_sec, t.tv_usec);
+#endif
+
+	if (smi_info->run_to_completion) {
+		/* If we are running to completion, then throw it in
+		   the list and run transactions until everything is
+		   clear.  Priority doesn't matter here. */
+		list_add_tail(&(msg->link), &(smi_info->xmit_msgs));
+
+		/* We have to release the msg lock and claim the smi
+		   lock in this case, because of race conditions. */
+		spin_unlock_irqrestore(&(smi_info->msg_lock), flags);
+
+		spin_lock_irqsave(&(smi_info->si_lock), flags);
+		result = smi_event_handler(smi_info, 0);
+		while (result != SI_SM_IDLE) {
+			udelay(SI_SHORT_TIMEOUT_USEC);
+			result = smi_event_handler(smi_info,
+						   SI_SHORT_TIMEOUT_USEC);
+		}
+		spin_unlock_irqrestore(&(smi_info->si_lock), flags);
+		return;
+	} else {
+		if (priority > 0) {
+			list_add_tail(&(msg->link), &(smi_info->hp_xmit_msgs));
+		} else {
+			list_add_tail(&(msg->link), &(smi_info->xmit_msgs));
+		}
+	}
+	spin_unlock_irqrestore(&(smi_info->msg_lock), flags);
+
+	spin_lock_irqsave(&(smi_info->si_lock), flags);
+	if ((smi_info->si_state == SI_NORMAL)
+	    && (smi_info->curr_msg == NULL))
+	{
+		start_next_msg(smi_info);
+		si_restart_short_timer(smi_info);
+	}
+	spin_unlock_irqrestore(&(smi_info->si_lock), flags);
+}
+
+static void set_run_to_completion(void *send_info, int i_run_to_completion)
+{
+	struct smi_info   *smi_info = (struct smi_info *) send_info;
+	enum si_sm_result result;
+	unsigned long     flags;
+
+	spin_lock_irqsave(&(smi_info->si_lock), flags);
+
+	smi_info->run_to_completion = i_run_to_completion;
+	if (i_run_to_completion) {
+		result = smi_event_handler(smi_info, 0);
+		while (result != SI_SM_IDLE) {
+			udelay(SI_SHORT_TIMEOUT_USEC);
+			result = smi_event_handler(smi_info,
+						   SI_SHORT_TIMEOUT_USEC);
+		}
+	}
+
+	spin_unlock_irqrestore(&(smi_info->si_lock), flags);
+}
+
+static void request_events(void *send_info)
+{
+	struct smi_info *smi_info = (struct smi_info *) send_info;
+
+	atomic_set(&smi_info->req_events, 1);
+}
+
+static int initialized = 0;
+
+/* Must be called with interrupts off and with the si_lock held. */
+static void si_restart_short_timer(struct smi_info *smi_info)
+{
+#if defined(CONFIG_HIGH_RES_TIMERS)
+	unsigned long flags;
+	unsigned long jiffies_now;
+
+	if (del_timer(&(smi_info->si_timer))) {
+		/* If we don't delete the timer, then it will go off
+		   immediately, anyway.  So we only process if we
+		   actually delete the timer. */
+
+		/* We already have irqsave on, so no need for it
+                   here. */
+		read_lock(&xtime_lock);
+		jiffies_now = jiffies;
+		smi_info->si_timer.expires = jiffies_now;
+		smi_info->si_timer.sub_expires = get_arch_cycles(jiffies_now);
+
+		add_usec_to_timer(&smi_info->si_timer, SI_SHORT_TIMEOUT_USEC);
+
+		add_timer(&(smi_info->si_timer));
+		spin_lock_irqsave(&smi_info->count_lock, flags);
+		smi_info->timeout_restarts++;
+		spin_unlock_irqrestore(&smi_info->count_lock, flags);
+	}
+#endif
+}
+
+static void smi_timeout(unsigned long data)
+{
+	struct smi_info   *smi_info = (struct smi_info *) data;
+	enum si_sm_result smi_result;
+	unsigned long     flags;
+	unsigned long     jiffies_now;
+	unsigned long     time_diff;
+#ifdef DEBUG_TIMING
+	struct timeval    t;
+#endif
+
+	if (smi_info->stop_operation) {
+		smi_info->timer_stopped = 1;
+		return;
+	}
+
+	spin_lock_irqsave(&(smi_info->si_lock), flags);
+#ifdef DEBUG_TIMING
+	do_gettimeofday(&t);
+	printk("**Timer: %d.%9.9d\n", t.tv_sec, t.tv_usec);
+#endif
+	jiffies_now = jiffies;
+	time_diff = ((jiffies_now - smi_info->last_timeout_jiffies)
+		     * SI_USEC_PER_JIFFY);
+	smi_result = smi_event_handler(smi_info, time_diff);
+
+	spin_unlock_irqrestore(&(smi_info->si_lock), flags);
+
+	smi_info->last_timeout_jiffies = jiffies_now;
+
+	if ((smi_info->irq) && (! smi_info->interrupt_disabled)) {
+		/* Running with interrupts, only do long timeouts. */
+		smi_info->si_timer.expires = jiffies + SI_TIMEOUT_JIFFIES;
+		spin_lock_irqsave(&smi_info->count_lock, flags);
+		smi_info->long_timeouts++;
+		spin_unlock_irqrestore(&smi_info->count_lock, flags);
+		goto do_add_timer;
+	}
+
+	/* If the state machine asks for a short delay, then shorten
+           the timer timeout. */
+	if (smi_result == SI_SM_CALL_WITH_DELAY) {
+		spin_lock_irqsave(&smi_info->count_lock, flags);
+		smi_info->short_timeouts++;
+		spin_unlock_irqrestore(&smi_info->count_lock, flags);
+#if defined(CONFIG_HIGH_RES_TIMERS)
+		read_lock(&xtime_lock);
+                smi_info->si_timer.expires = jiffies;
+                smi_info->si_timer.sub_expires
+                        = get_arch_cycles(smi_info->si_timer.expires);
+                read_unlock(&xtime_lock);
+		add_usec_to_timer(&smi_info->si_timer, SI_SHORT_TIMEOUT_USEC);
+#else
+		smi_info->si_timer.expires = jiffies + 1;
+#endif
+	} else {
+		spin_lock_irqsave(&smi_info->count_lock, flags);
+		smi_info->long_timeouts++;
+		spin_unlock_irqrestore(&smi_info->count_lock, flags);
+		smi_info->si_timer.expires = jiffies + SI_TIMEOUT_JIFFIES;
+#if defined(CONFIG_HIGH_RES_TIMERS)
+		smi_info->si_timer.sub_expires = 0;
+#endif
+	}
+
+ do_add_timer:
+	add_timer(&(smi_info->si_timer));
+}
+
+static irqreturn_t si_irq_handler(int irq, void *data, struct pt_regs *regs)
+{
+	struct smi_info *smi_info = (struct smi_info *) data;
+	unsigned long   flags;
+#ifdef DEBUG_TIMING
+	struct timeval  t;
+#endif
+
+	spin_lock_irqsave(&(smi_info->si_lock), flags);
+
+	spin_lock(&smi_info->count_lock);
+	smi_info->interrupts++;
+	spin_unlock(&smi_info->count_lock);
+
+	if (smi_info->stop_operation)
+		goto out;
+
+#ifdef DEBUG_TIMING
+	do_gettimeofday(&t);
+	printk("**Interrupt: %d.%9.9d\n", t.tv_sec, t.tv_usec);
+#endif
+	smi_event_handler(smi_info, 0);
+ out:
+	spin_unlock_irqrestore(&(smi_info->si_lock), flags);
+	return IRQ_HANDLED;
+}
+
+static struct ipmi_smi_handlers handlers =
+{
+	.owner                  = THIS_MODULE,
+	.sender			= sender,
+	.request_events		= request_events,
+	.set_run_to_completion  = set_run_to_completion
+};
+
+/* There can be 4 IO ports passed in (with or without IRQs), 4 addresses,
+   a default IO port, and 1 ACPI/SPMI address.  That sets SI_MAX_DRIVERS */
+
+#define SI_MAX_PARMS 4
+#define SI_MAX_DRIVERS ((SI_MAX_PARMS * 2) + 2)
+static struct smi_info *smi_infos[SI_MAX_DRIVERS] =
+{ NULL, NULL, NULL, NULL };
+
+#define DEVICE_NAME "ipmi_si"
+
+#define DEFAULT_KCS_IO_PORT 0xca2
+#define DEFAULT_SMIC_IO_PORT 0xca9
+#define DEFAULT_BT_IO_PORT   0xe4
+
+static int           si_trydefaults = 1;
+static char          *si_type[SI_MAX_PARMS] = { NULL, NULL, NULL, NULL };
+static unsigned long si_addrs[SI_MAX_PARMS] = { 0, 0, 0, 0 };
+static unsigned int  si_ports[SI_MAX_PARMS] = { 0, 0, 0, 0 };
+static int           si_irqs[SI_MAX_PARMS] = { 0, 0, 0, 0 };
+
+
+MODULE_PARM(si_trydefaults, "i");
+MODULE_PARM(si_type, "1-4s");
+MODULE_PARM(si_addrs, "1-4l");
+MODULE_PARM(si_irqs, "1-4i");
+MODULE_PARM(si_ports, "1-4i");
+
+
+#if defined(CONFIG_ACPI_INTERPETER) || defined(CONFIG_X86) || defined(CONFIG_PCI)
+#define IPMI_MEM_ADDR_SPACE 1
+#define IPMI_IO_ADDR_SPACE  2
+static int is_new_interface(int intf, u8 addr_space, unsigned long base_addr)
+{
+	int i;
+
+	for (i = 0; i < SI_MAX_PARMS; ++i) {
+		/* Don't check our address. */
+		if (i == intf)
+			continue;
+		if (si_type[i] != NULL) {
+			if ((addr_space == IPMI_MEM_ADDR_SPACE && 
+			     base_addr == si_addrs[i]) ||
+			    (addr_space == IPMI_IO_ADDR_SPACE &&
+			     base_addr == si_ports[i]))
+				return 0;
+		}
+		else
+			break;
+	}
+	
+	return 1;
+}
+#endif
+ 
+static int std_irq_setup(struct smi_info *info)
+{
+	int rv;
+
+	if (!info->irq)
+		return 0;
+
+	rv = request_irq(info->irq,
+			 si_irq_handler,
+			 SA_INTERRUPT,
+			 DEVICE_NAME,
+			 info);
+	if (rv) {
+		printk(KERN_WARNING
+		       "ipmi_si: %s unable to claim interrupt %d,"
+		       " running polled\n",
+		       DEVICE_NAME, info->irq);
+		info->irq = 0;
+	} else {
+		printk("  Using irq %d\n", info->irq);
+	}
+
+	return rv;
+}
+
+static void std_irq_cleanup(struct smi_info *info)
+{
+	if (!info->irq)
+		return;
+
+	free_irq(info->irq, info);
+}
+
+static unsigned char port_inb(struct si_sm_io *io, unsigned int offset)
+{
+	unsigned int *addr = io->info;
+
+	return inb((*addr)+offset);
+}
+
+static void port_outb(struct si_sm_io *io, unsigned int offset,
+		      unsigned char b)
+{
+	unsigned int *addr = io->info;
+
+	outb(b, (*addr)+offset);
+}
+
+static int port_setup(struct smi_info *info)
+{
+	unsigned int *addr = info->io.info;
+
+	if (!addr || (!*addr))
+		return -ENODEV;
+
+	if (request_region(*addr, info->io_size, DEVICE_NAME) == NULL)
+		return -EIO;
+	return 0;
+}
+
+static void port_cleanup(struct smi_info *info)
+{
+	unsigned int *addr = info->io.info;
+
+	if (addr && (*addr)) 
+		release_region (*addr, info->io_size);
+	kfree(info);
+}
+
+static int try_init_port(int intf_num, struct smi_info **new_info)
+{
+	struct smi_info *info;
+
+	if (!si_ports[intf_num])
+		return -ENODEV;
+
+	if (!is_new_interface(intf_num, IPMI_IO_ADDR_SPACE,
+			      si_ports[intf_num]))
+		return -ENODEV;
+
+	info = kmalloc(sizeof(*info), GFP_KERNEL);
+	if (!info) {
+		printk(KERN_ERR "ipmi_si: Could not allocate SI data (1)\n");
+		return -ENOMEM;
+	}
+	memset(info, 0, sizeof(*info));
+
+	info->io_setup = port_setup;
+	info->io_cleanup = port_cleanup;
+	info->io.inputb = port_inb;
+	info->io.outputb = port_outb;
+	info->io.info = &(si_ports[intf_num]);
+	info->io.addr = NULL;
+	info->irq = 0;
+	info->irq_setup = NULL;
+	*new_info = info;
+
+	printk("ipmi_si: Trying \"%s\" at I/O port 0x%x\n",
+	       si_type[intf_num], si_ports[intf_num]);
+	return 0;
+}
+
+static unsigned char mem_inb(struct si_sm_io *io, unsigned int offset)
+{
+	return readb((io->addr)+offset);
+}
+
+static void mem_outb(struct si_sm_io *io, unsigned int offset,
+		     unsigned char b)
+{
+	writeb(b, (io->addr)+offset);
+}
+
+static int mem_setup(struct smi_info *info)
+{
+	unsigned long *addr = info->io.info;
+
+	if (!addr || (!*addr))
+		return -ENODEV;
+
+	if (request_mem_region(*addr, info->io_size, DEVICE_NAME) == NULL)
+		return -EIO;
+
+	info->io.addr = ioremap(*addr, info->io_size);
+	if (info->io.addr == NULL) {
+		release_mem_region(*addr, info->io_size);
+		return -EIO;
+	}
+	return 0;
+}
+
+static void mem_cleanup(struct smi_info *info)
+{
+	unsigned long *addr = info->io.info;
+
+	if (info->io.addr) {
+		iounmap(info->io.addr);
+		release_mem_region(*addr, info->io_size);
+	}
+	kfree(info);
+}
+
+static int try_init_mem(int intf_num, struct smi_info **new_info)
+{
+	struct smi_info *info;
+
+	if (!si_addrs[intf_num])
+		return -ENODEV;
+
+	if (!is_new_interface(intf_num, IPMI_MEM_ADDR_SPACE,
+			      si_addrs[intf_num]))
+		return -ENODEV;
+
+	info = kmalloc(sizeof(*info), GFP_KERNEL);
+	if (!info) {
+		printk(KERN_ERR "ipmi_si: Could not allocate SI data (2)\n");
+		return -ENOMEM;
+	}
+	memset(info, 0, sizeof(*info));
+
+	info->io_setup = mem_setup;
+	info->io_cleanup = mem_cleanup;
+	info->io.inputb = mem_inb;
+	info->io.outputb = mem_outb;
+	info->io.info = (void *) si_addrs[intf_num];
+	info->io.addr = NULL;
+	info->irq = 0;
+	info->irq_setup = NULL;
+	*new_info = info;
+
+	printk("ipmi_si: Trying \"%s\" at memory address 0x%lx\n",
+	       si_type[intf_num], si_addrs[intf_num]);
+	return 0;
+}
+
+
+#ifdef CONFIG_ACPI_INTERPRETER
+
+#include <linux/acpi.h>
+
+/* Once we get an ACPI failure, we don't try any more, because we go
+   through the tables sequentially.  Once we don't find a table, there
+   are no more. */
+static int acpi_failure = 0;
+
+/* For GPE-type interrupts. */
+void ipmi_acpi_gpe(void *context)
+{
+	struct smi_info *smi_info = context;
+	unsigned long   flags;
+#ifdef DEBUG_TIMING
+	struct timeval t;
+#endif
+
+	spin_lock_irqsave(&(smi_info->si_lock), flags);
+
+	spin_lock(&smi_info->count_lock);
+	smi_info->interrupts++;
+	spin_unlock(&smi_info->count_lock);
+
+	if (smi_info->stop_operation)
+		goto out;
+
+#ifdef DEBUG_TIMING
+	do_gettimeofday(&t);
+	printk("**ACPI_GPE: %d.%9.9d\n", t.tv_sec, t.tv_usec);
+#endif
+	smi_event_handler(smi_info, 0);
+ out:
+	spin_unlock_irqrestore(&(smi_info->si_lock), flags);
+}
+
+static int acpi_gpe_irq_setup(struct smi_info *info)
+{
+	acpi_status status;
+
+	if (!info->irq)
+		return 0;
+
+	/* FIXME - is level triggered right? */
+	status = acpi_install_gpe_handler(NULL,
+					  info->irq,
+					  ACPI_EVENT_LEVEL_TRIGGERED,
+					  ipmi_acpi_gpe,
+					  info);
+	if (status != AE_OK) {
+		printk(KERN_WARNING
+		       "ipmi_si: %s unable to claim ACPI GPE %d,"
+		       " running polled\n",
+		       DEVICE_NAME, info->irq);
+		info->irq = 0;
+		return -EINVAL;
+	} else {
+		printk("  Using ACPI GPE %d\n", info->irq);
+		return 0;
+	}
+
+}
+
+static void acpi_gpe_irq_cleanup(struct smi_info *info)
+{
+	if (!info->irq)
+		return;
+
+	acpi_remove_gpe_handler(NULL, info->irq, ipmi_acpi_gpe);
+}
+
+/*
+ * Defined at
+ * http://h21007.www2.hp.com/dspp/files/unprotected/devresource/Docs/TechPapers/IA64/hpspmi.pdf
+ */
+struct SPMITable {
+	s8	Signature[4];
+	u32	Length;
+	u8	Revision;
+	u8	Checksum;
+	s8	OEMID[6];
+	s8	OEMTableID[8];
+	s8	OEMRevision[4];
+	s8	CreatorID[4];
+	s8	CreatorRevision[4];
+	u8	InterfaceType;
+	u8	IPMIlegacy;
+	s16	SpecificationRevision;
+
+	/*
+	 * Bit 0 - SCI interrupt supported
+	 * Bit 1 - I/O APIC/SAPIC
+	 */
+	u8	InterruptType;
+
+	/* If bit 0 of InterruptType is set, then this is the SCI
+           interrupt in the GPEx_STS register. */
+	u8	GPE;
+
+	s16	Reserved;
+
+	/* If bit 1 of InterruptType is set, then this is the I/O
+           APIC/SAPIC interrupt. */
+	u32	GlobalSystemInterrupt;
+
+	/* The actual register address. */
+	struct acpi_generic_address addr;
+
+	u8	UID[4];
+
+	s8      spmi_id[1]; /* A '\0' terminated array starts here. */
+};
+
+static int try_init_acpi(int intf_num, struct smi_info **new_info)
+{
+	struct smi_info  *info;
+	acpi_status      status;
+	struct SPMITable *spmi;
+	char             *io_type;
+	u8 		 addr_space;
+
+	if (acpi_failure)
+		return -ENODEV;
+
+	status = acpi_get_firmware_table("SPMI", intf_num+1,
+					 ACPI_LOGICAL_ADDRESSING,
+					 (struct acpi_table_header **) &spmi);
+	if (status != AE_OK) {
+		acpi_failure = 1;
+		return -ENODEV;
+	}
+
+	if (spmi->IPMIlegacy != 1) {
+	    printk(KERN_INFO "IPMI: Bad SPMI legacy %d\n", spmi->IPMIlegacy);
+  	    return -ENODEV;
+	}
+
+	if (spmi->addr.address_space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY)
+		addr_space = IPMI_MEM_ADDR_SPACE;
+	else
+		addr_space = IPMI_IO_ADDR_SPACE;
+	if (!is_new_interface(-1, addr_space, spmi->addr.address))
+		return -ENODEV;
+
+	/* Figure out the interface type. */
+	switch (spmi->InterfaceType)
+	{
+	case 1:	/* KCS */
+		si_type[intf_num] = "kcs";
+		break;
+
+	case 2:	/* SMIC */
+		si_type[intf_num] = "smic";
+		break;
+
+	case 3:	/* BT */
+		si_type[intf_num] = "bt";
+		break;
+
+	default:
+		printk(KERN_INFO "ipmi_si: Unknown ACPI/SPMI SI type %d\n",
+			spmi->InterfaceType);
+		return -EIO;
+	} 
+
+	info = kmalloc(sizeof(*info), GFP_KERNEL);
+	if (!info) {
+		printk(KERN_ERR "ipmi_si: Could not allocate SI data (3)\n");
+		return -ENOMEM;
+	}
+	memset(info, 0, sizeof(*info));
+
+	if (spmi->InterruptType & 1) {
+		/* We've got a GPE interrupt. */
+		info->irq = spmi->GPE;
+		info->irq_setup = acpi_gpe_irq_setup;
+		info->irq_cleanup = acpi_gpe_irq_cleanup;
+	} else if (spmi->InterruptType & 2) {
+		/* We've got an APIC/SAPIC interrupt. */
+		info->irq = spmi->GlobalSystemInterrupt;
+		info->irq_setup = std_irq_setup;
+		info->irq_cleanup = std_irq_cleanup;
+	} else {
+		/* Use the default interrupt setting. */
+		info->irq = 0;
+		info->irq_setup = NULL;
+	}
+
+	if (spmi->addr.address_space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY) {
+		io_type = "memory";
+		info->io_setup = mem_setup;
+		info->io_cleanup = mem_cleanup;
+		si_addrs[intf_num] = spmi->addr.address;
+		info->io.inputb = mem_inb;
+		info->io.outputb = mem_outb;
+		info->io.info = &(si_addrs[intf_num]);
+	} else if (spmi->addr.address_space_id == ACPI_ADR_SPACE_SYSTEM_IO) {
+		io_type = "I/O";
+		info->io_setup = port_setup;
+		info->io_cleanup = port_cleanup;
+		si_ports[intf_num] = spmi->addr.address;
+		info->io.inputb = port_inb;
+		info->io.outputb = port_outb;
+		info->io.info = &(si_ports[intf_num]);
+	} else {
+		kfree(info);
+		printk("ipmi_si: Unknown ACPI I/O Address type\n");
+		return -EIO;
+	}
+
+	*new_info = info;
+
+	printk("ipmi_si: ACPI/SPMI specifies \"%s\" %s SI @ 0x%lx\n",
+	       si_type[intf_num], io_type, (unsigned long) spmi->addr.address);
+	return 0;
+}
+#endif
+
+#ifdef CONFIG_X86
+
+typedef struct dmi_ipmi_data
+{
+	u8   		type;
+	u8   		addr_space;
+	unsigned long	base_addr;
+	u8   		irq;
+}dmi_ipmi_data_t;
+
+typedef struct dmi_header
+{
+	u8	type;
+	u8	length;
+	u16	handle;
+}dmi_header_t;
+
+static int decode_dmi(dmi_header_t *dm, dmi_ipmi_data_t *ipmi_data)
+{
+	u8		*data = (u8 *)dm;
+	unsigned long  	base_addr;
+	
+	ipmi_data->type = data[0x04];
+	
+	memcpy(&base_addr,&data[0x08],sizeof(unsigned long));
+	if (base_addr & 1) {
+		/* I/O */
+		base_addr &= 0xFFFE;
+		ipmi_data->addr_space = IPMI_IO_ADDR_SPACE;
+	}
+	else {
+		/* Memory */
+		ipmi_data->addr_space = IPMI_MEM_ADDR_SPACE;
+	}
+		
+	ipmi_data->base_addr = base_addr;
+	ipmi_data->irq = data[0x11];
+	
+	if (is_new_interface(-1, ipmi_data->addr_space,ipmi_data->base_addr))
+	    return 0;
+	    
+	memset(ipmi_data,0,sizeof(dmi_ipmi_data_t));
+	    
+	return -1;
+}
+
+static int dmi_table(u32 base, int len, int num, 
+	dmi_ipmi_data_t *ipmi_data)
+{
+	u8 		  *buf;
+	struct dmi_header *dm;
+	u8 		  *data;
+	int 		  i=1;
+	int		  status=-1;
+
+	buf = ioremap(base, len);
+	if(buf==NULL)
+		return -1;
+
+	data = buf;
+
+	while(i<num && (data - buf) < len)
+	{        
+		dm=(dmi_header_t *)data;
+
+		if((data-buf+dm->length) >= len)
+        		break;
+       
+		if (dm->type == 38) {
+			if (decode_dmi(dm, ipmi_data) == 0) {
+				status = 0;
+				break;
+			}
+		}
+       
+	        data+=dm->length;
+		while((data-buf) < len && (*data || data[1]))
+			data++;
+		data+=2;
+		i++;
+	}
+	iounmap(buf);
+	
+	return status;
+}
+
+inline static int dmi_checksum(u8 *buf)
+{
+	u8   sum=0;
+	int  a;
+	
+	for(a=0; a<15; a++)
+		sum+=buf[a];
+	return (sum==0);
+}
+
+static int dmi_iterator(dmi_ipmi_data_t *ipmi_data)
+{
+	u8   buf[15];
+	u32  fp=0xF0000;
+
+#ifdef CONFIG_SIMNOW
+	return -1;
+#endif
+ 	
+	while(fp < 0xFFFFF)
+	{
+		isa_memcpy_fromio(buf, fp, 15);
+		if(memcmp(buf, "_DMI_", 5)==0 && dmi_checksum(buf))
+		{
+			u16 num=buf[13]<<8|buf[12];
+			u16 len=buf[7]<<8|buf[6];
+			u32 base=buf[11]<<24|buf[10]<<16|buf[9]<<8|buf[8];
+
+			if(dmi_table(base, len, num, ipmi_data) == 0)
+				return 0;
+		}
+		fp+=16;
+	}
+	
+	return -1;
+}
+
+static int try_init_smbios(int intf_num, struct smi_info **new_info)
+{
+	struct smi_info   *info;
+	dmi_ipmi_data_t   ipmi_data;
+	char              *io_type;
+	int               status;
+
+	status = dmi_iterator(&ipmi_data);
+
+	if (status < 0)
+		return -ENODEV;
+	
+	switch(ipmi_data.type) {
+		case 0x01: /* KCS */
+			si_type[intf_num] = "kcs";
+			break;
+		case 0x02: /* SMIC */
+			si_type[intf_num] = "smic";
+			break;
+		case 0x03: /* BT */
+			si_type[intf_num] = "bt";
+			break;
+		default:
+			printk("ipmi_si: Unknown SMBIOS SI type.\n");
+			return -EIO;
+	}
+	
+	info = kmalloc(sizeof(*info), GFP_KERNEL);
+	if (!info) {
+		printk(KERN_ERR "ipmi_si: Could not allocate SI data (4)\n");
+		return -ENOMEM;
+	}
+	memset(info, 0, sizeof(*info));
+
+	if (ipmi_data.addr_space == 1) {
+		io_type = "memory";
+		info->io_setup = mem_setup;
+		info->io_cleanup = mem_cleanup;
+		si_addrs[intf_num] = ipmi_data.base_addr;
+		info->io.inputb = mem_inb;
+		info->io.outputb = mem_outb;
+		info->io.info = &(si_addrs[intf_num]);
+	} else if (ipmi_data.addr_space == 2) {
+		io_type = "I/O";
+		info->io_setup = port_setup;
+		info->io_cleanup = port_cleanup;
+		si_ports[intf_num] = ipmi_data.base_addr;
+		info->io.inputb = port_inb;
+		info->io.outputb = port_outb;
+		info->io.info = &(si_ports[intf_num]);
+	} else {
+		kfree(info);
+		printk("ipmi_si: Unknown SMBIOS I/O Address type.\n");
+		return -EIO;
+	}
+
+	si_irqs[intf_num] = ipmi_data.irq;
+
+	*new_info = info;
+
+	printk("ipmi_si: Found SMBIOS-specified state machine at %s"
+	       " address 0x%lx\n",
+	       io_type, (unsigned long)ipmi_data.base_addr);
+	return 0;
+}
+#endif /* CONFIG_X86 */
+
+#ifdef CONFIG_PCI
+
+#define PCI_ERMC_CLASSCODE  0x0C0700
+#define PCI_HP_VENDOR_ID    0x103C
+#define PCI_MMC_DEVICE_ID   0x121A
+#define PCI_MMC_ADDR_CW     0x10
+
+/* Avoid more than one attempt to probe pci smic. */
+static int pci_smic_checked = 0;
+
+static int find_pci_smic(int intf_num, struct smi_info **new_info)
+{
+	struct smi_info  *info;
+	int              error;
+	struct pci_dev   *pci_dev = NULL;
+	u16    		 base_addr;
+	int              fe_rmc = 0;
+	
+	if (pci_smic_checked)
+		return -ENODEV;
+
+	pci_smic_checked = 1;
+	
+	if ((pci_dev = pci_find_device(PCI_HP_VENDOR_ID, PCI_MMC_DEVICE_ID,
+				       NULL)))
+		;
+	else if ((pci_dev = pci_find_class(PCI_ERMC_CLASSCODE, NULL)) &&
+		 pci_dev->subsystem_vendor == PCI_HP_VENDOR_ID)
+		fe_rmc = 1;
+	else
+		return -ENODEV;
+	
+	error = pci_read_config_word(pci_dev, PCI_MMC_ADDR_CW, &base_addr);
+	if (error)
+	{
+		printk(KERN_ERR
+		       "ipmi_si: pci_read_config_word() failed (%d).\n",
+		       error);
+		return -ENODEV;
+	}
+	
+	/* Bit 0: 1 specifies programmed I/O, 0 specifies memory mapped I/O */
+	if (!(base_addr & 0x0001))
+	{
+		printk(KERN_ERR
+		       "ipmi_si: memory mapped I/O not supported for PCI"
+		       " smic.\n");
+		return -ENODEV;
+	}
+	
+	base_addr &= 0xFFFE;
+	if (!fe_rmc)
+		/* Data register starts at base address + 1 in eRMC */
+		++base_addr;
+	
+	if (!is_new_interface(-1, IPMI_IO_ADDR_SPACE, base_addr))
+	    return -ENODEV;
+	
+	info = kmalloc(sizeof(*info), GFP_KERNEL);
+	if (!info) {
+		printk(KERN_ERR "ipmi_si: Could not allocate SI data (5)\n");
+		return -ENOMEM;
+	}
+	memset(info, 0, sizeof(*info));
+	
+	info->io_setup = port_setup;
+	info->io_cleanup = port_cleanup;
+	si_ports[intf_num] = base_addr;
+	info->io.inputb = port_inb;
+	info->io.outputb = port_outb;
+	info->io.info = &(si_ports[intf_num]);
+
+	*new_info = info;
+	
+	si_irqs[intf_num] = pci_dev->irq;
+	si_type[intf_num] = "smic";
+
+	printk("ipmi_si: Found PCI SMIC at I/O address 0x%lx\n",
+		(long unsigned int) base_addr);
+	
+	return 0;
+}
+#endif /* CONFIG_PCI */
+
+static int try_init_plug_and_play(int intf_num, struct smi_info **new_info)
+{
+#ifdef CONFIG_PCI
+	if (find_pci_smic(intf_num, new_info)==0)
+		return 0;
+#endif
+	/* Include other methods here. */
+    
+	return -ENODEV;
+}
+
+
+static int try_get_dev_id(struct smi_info *smi_info)
+{
+	unsigned char      msg[2];
+	unsigned char      resp[IPMI_MAX_MSG_LENGTH];
+	unsigned long      resp_len;
+	enum si_sm_result smi_result;
+
+	/* Do a Get Device ID command, since it comes back with some
+	   useful info. */
+	msg[0] = IPMI_NETFN_APP_REQUEST << 2;
+	msg[1] = IPMI_GET_DEVICE_ID_CMD;
+	smi_info->handlers->start_transaction(smi_info->si_sm, msg, 2);
+	
+	smi_result = smi_info->handlers->event(smi_info->si_sm, 0);
+	for (;;)
+	{
+		if (smi_result == SI_SM_CALL_WITH_DELAY) {
+			set_current_state(TASK_UNINTERRUPTIBLE);
+			schedule_timeout(1);
+			smi_result = smi_info->handlers->event(
+				smi_info->si_sm, 100);
+		}
+		else if (smi_result == SI_SM_CALL_WITHOUT_DELAY)
+		{
+			smi_result = smi_info->handlers->event(
+				smi_info->si_sm, 0);
+		}
+		else
+			break;
+	}
+	if (smi_result == SI_SM_HOSED)
+		/* We couldn't get the state machine to run, so whatever's at
+		   the port is probably not an IPMI SMI interface. */
+		return -ENODEV;
+
+	/* Otherwise, we got some data. */
+	resp_len = smi_info->handlers->get_result(smi_info->si_sm,
+						  resp, IPMI_MAX_MSG_LENGTH);
+	if (resp_len < 6)
+		/* That's odd, it should be longer. */
+		return -EINVAL;
+	
+	if ((resp[1] != IPMI_GET_DEVICE_ID_CMD) || (resp[2] != 0))
+		/* That's odd, it shouldn't be able to fail. */
+		return -EINVAL;
+
+	/* Record info from the get device id, in case we need it. */
+	smi_info->ipmi_si_dev_rev = resp[4] & 0xf;
+	smi_info->ipmi_si_fw_rev_major = resp[5] & 0x7f;
+	smi_info->ipmi_si_fw_rev_minor = resp[6];
+	smi_info->ipmi_version_major = resp[7] & 0xf;
+	smi_info->ipmi_version_minor = resp[7] >> 4;
+
+	return 0;
+}
+
+extern struct si_sm_handlers kcs_smi_handlers;
+extern struct si_sm_handlers smic_smi_handlers;
+extern struct si_sm_handlers bt_smi_handlers;
+
+static int type_file_read_proc(char *page, char **start, off_t off,
+			       int count, int *eof, void *data)
+{
+	char            *out = (char *) page;
+	struct smi_info *smi = data;
+
+	switch (smi->si_type) {
+	    case SI_KCS:
+		return sprintf(out, "kcs\n");
+	    case SI_SMIC:
+		return sprintf(out, "smic\n");
+	    case SI_BT:
+		return sprintf(out, "bt\n");
+	    default:
+		return 0;
+	}
+}
+
+static int stat_file_read_proc(char *page, char **start, off_t off,
+			       int count, int *eof, void *data)
+{
+	char            *out = (char *) page;
+	struct smi_info *smi = data;
+
+	out += sprintf(out, "interrupts_enabled:    %d\n",
+		       smi->irq && !smi->interrupt_disabled);
+	out += sprintf(out, "short_timeouts:        %ld\n",
+		       smi->short_timeouts);
+	out += sprintf(out, "long_timeouts:         %ld\n",
+		       smi->long_timeouts);
+	out += sprintf(out, "timeout_restarts:      %ld\n",
+		       smi->timeout_restarts);
+	out += sprintf(out, "idles:                 %ld\n",
+		       smi->idles);
+	out += sprintf(out, "interrupts:            %ld\n",
+		       smi->interrupts);
+	out += sprintf(out, "attentions:            %ld\n",
+		       smi->attentions);
+	out += sprintf(out, "flag_fetches:          %ld\n",
+		       smi->flag_fetches);
+	out += sprintf(out, "hosed_count:           %ld\n",
+		       smi->hosed_count);
+	out += sprintf(out, "complete_transactions: %ld\n",
+		       smi->complete_transactions);
+	out += sprintf(out, "events:                %ld\n",
+		       smi->events);
+	out += sprintf(out, "watchdog_pretimeouts:  %ld\n",
+		       smi->watchdog_pretimeouts);
+	out += sprintf(out, "incoming_messages:     %ld\n",
+		       smi->incoming_messages);
+
+	return (out - ((char *) page));
+}
+
+/* Returns 0 if initialized, or negative on an error. */
+static int init_one_smi(int intf_num, struct smi_info **smi)
+{
+	int		rv;
+	struct smi_info *new_smi;
+
+
+	rv = try_init_mem(intf_num, &new_smi);
+	if (rv)
+		rv = try_init_port(intf_num, &new_smi);
+#ifdef CONFIG_ACPI_INTERPRETER
+	if ((rv) && (si_trydefaults)) {
+		rv = try_init_acpi(intf_num, &new_smi);
+	}
+#endif
+#ifdef CONFIG_X86
+	if ((rv) && (si_trydefaults)) {
+		rv = try_init_smbios(intf_num, &new_smi);
+        }
+#endif
+	if ((rv) && (si_trydefaults)) {
+		rv = try_init_plug_and_play(intf_num, &new_smi);
+	}
+
+
+	if (rv)
+		return rv;
+
+	/* So we know not to free it unless we have allocated one. */
+	new_smi->intf = NULL;
+	new_smi->si_sm = NULL;
+	new_smi->handlers = 0;
+
+	if (!new_smi->irq_setup) {
+		new_smi->irq = si_irqs[intf_num];
+		new_smi->irq_setup = std_irq_setup;
+		new_smi->irq_cleanup = std_irq_cleanup;
+	}
+
+	/* Default to KCS if no type is specified. */
+	if (si_type[intf_num] == NULL) {
+		if (si_trydefaults)
+			si_type[intf_num] = "kcs";
+		else {
+			rv = -EINVAL;
+			goto out_err;
+		}
+	}
+
+	/* Set up the state machine to use. */
+	if (strcmp(si_type[intf_num], "kcs") == 0) {
+		new_smi->handlers = &kcs_smi_handlers;
+		new_smi->si_type = SI_KCS;
+	} else if (strcmp(si_type[intf_num], "smic") == 0) {
+		new_smi->handlers = &smic_smi_handlers;
+		new_smi->si_type = SI_SMIC;
+	} else if (strcmp(si_type[intf_num], "bt") == 0) {
+		new_smi->handlers = &bt_smi_handlers;
+		new_smi->si_type = SI_BT;
+	} else {
+		/* No support for anything else yet. */
+		rv = -EIO;
+		goto out_err;
+	}
+
+	/* Allocate the state machine's data and initialize it. */
+	new_smi->si_sm = kmalloc(new_smi->handlers->size(), GFP_KERNEL);
+	if (!new_smi->si_sm) {
+		printk(" Could not allocate state machine memory\n");
+		rv = -ENOMEM;
+		goto out_err;
+	}
+	new_smi->io_size = new_smi->handlers->init_data(new_smi->si_sm,
+							&new_smi->io);
+
+	/* Now that we know the I/O size, we can set up the I/O. */
+	rv = new_smi->io_setup(new_smi);
+	if (rv) {
+		printk(" Could not set up I/O space\n");
+		goto out_err;
+	}
+	
+	spin_lock_init(&(new_smi->si_lock));
+	spin_lock_init(&(new_smi->msg_lock));
+	spin_lock_init(&(new_smi->count_lock));
+
+	/* Do low-level detection first. */
+	if (new_smi->handlers->detect(new_smi->si_sm)) {
+		rv = -ENODEV;
+		goto out_err;
+	}
+
+	/* Attempt a get device id command.  If it fails, we probably
+           don't have a SMI here. */
+	rv = try_get_dev_id(new_smi);
+	if (rv)
+		goto out_err;
+
+	/* Try to claim any interrupts. */
+	new_smi->irq_setup(new_smi);
+
+	INIT_LIST_HEAD(&(new_smi->xmit_msgs));
+	INIT_LIST_HEAD(&(new_smi->hp_xmit_msgs));
+	new_smi->curr_msg = NULL;
+	atomic_set(&new_smi->req_events, 0);
+	new_smi->run_to_completion = 0;
+
+	rv = ipmi_register_smi(&handlers,
+			       new_smi,
+			       new_smi->ipmi_version_major,
+			       new_smi->ipmi_version_minor,
+			       &(new_smi->intf));
+	if (rv) {
+		printk(KERN_ERR 
+		       "ipmi_si: Unable to register device: error %d\n",
+		       rv);
+		goto out_err;
+	}
+
+	rv = ipmi_smi_add_proc_entry(new_smi->intf, "type",
+				     type_file_read_proc, NULL,
+				     new_smi, THIS_MODULE);
+	if (rv) {
+		printk(KERN_ERR 
+		       "ipmi_si: Unable to create proc entry: %d\n",
+		       rv);
+		goto out_err;
+	}
+
+	rv = ipmi_smi_add_proc_entry(new_smi->intf, "si_stats",
+				     stat_file_read_proc, NULL,
+				     new_smi, THIS_MODULE);
+	if (rv) {
+		printk(KERN_ERR 
+		       "ipmi_si: Unable to create proc entry: %d\n",
+		       rv);
+		goto out_err;
+	}
+
+	start_clear_flags(new_smi);
+
+	/* IRQ is defined to be set when non-zero. */
+	if (new_smi->irq)
+		new_smi->si_state = SI_CLEARING_FLAGS_THEN_SET_IRQ;
+
+	new_smi->interrupt_disabled = 0;
+	new_smi->timer_stopped = 0;
+	new_smi->stop_operation = 0;
+
+	init_timer(&(new_smi->si_timer));
+	new_smi->si_timer.data = (long) new_smi;
+	new_smi->si_timer.function = smi_timeout;
+	new_smi->last_timeout_jiffies = jiffies;
+	new_smi->si_timer.expires = jiffies + SI_TIMEOUT_JIFFIES;
+	add_timer(&(new_smi->si_timer));
+
+	*smi = new_smi;
+
+	printk(" IPMI %s interface initialized\n", si_type[intf_num]);
+
+	return 0;
+
+ out_err:
+	if (new_smi->intf)
+		ipmi_unregister_smi(new_smi->intf);
+
+	new_smi->irq_cleanup(new_smi);
+	if (new_smi->si_sm) {
+		if (new_smi->handlers)
+			new_smi->handlers->cleanup(new_smi->si_sm);
+		kfree(new_smi->si_sm);
+	}
+	new_smi->io_cleanup(new_smi);
+	return rv;
+}
+
+static __init int init_ipmi_si(void)
+{
+	int		rv = 0;
+	int		pos = 0;
+	int		i = 0;
+
+	if (initialized)
+		return 0;
+	initialized = 1;
+
+	printk(KERN_INFO "IPMI System Interface driver version "
+	       IPMI_SI_VERSION);
+	if (kcs_smi_handlers.version)
+		printk(", KCS version %s", kcs_smi_handlers.version);
+	if (smic_smi_handlers.version)
+		printk(", SMIC version %s", smic_smi_handlers.version);
+	if (bt_smi_handlers.version)
+   	        printk(", BT version %s", bt_smi_handlers.version);
+	printk("\n");
+
+	rv = init_one_smi(0, &(smi_infos[pos]));
+	if (rv && !si_ports[0] && si_trydefaults) {
+		/* If we are trying defaults and the initial port is
+                   not set, then set it. */
+		si_type[0] = "kcs";
+		si_ports[0] = DEFAULT_KCS_IO_PORT;
+		rv = init_one_smi(0, &(smi_infos[pos]));
+		if (rv) {
+			/* No KCS - try SMIC */
+			si_type[0] = "smic";
+			si_ports[0] = DEFAULT_SMIC_IO_PORT;
+			rv = init_one_smi(0, &(smi_infos[pos]));
+		}
+		if (rv) {
+			/* No SMIC - try BT */
+			si_type[0] = "bt";
+			si_ports[0] = DEFAULT_BT_IO_PORT;
+			rv = init_one_smi(0, &(smi_infos[pos]));
+		}
+	}
+	if (rv == 0)
+		pos++;
+
+	for (i=1; i < SI_MAX_PARMS; i++) {
+		rv = init_one_smi(i, &(smi_infos[pos]));
+		if (rv == 0)
+			pos++;
+	}
+
+	if (smi_infos[0] == NULL) {
+		printk("ipmi_si: Unable to find any System Interface(s)\n");
+		return -ENODEV;
+	} 
+
+	return 0;
+}
+module_init(init_ipmi_si);
+
+#ifdef MODULE
+void __exit cleanup_one_si(struct smi_info *to_clean)
+{
+	int           rv;
+	unsigned long flags;
+
+	if (! to_clean)
+		return;
+
+	/* Tell the timer and interrupt handlers that we are shutting
+	   down. */
+	spin_lock_irqsave(&(to_clean->si_lock), flags);
+	spin_lock(&(to_clean->msg_lock));
+
+	to_clean->stop_operation = 1;
+
+	to_clean->irq_cleanup(to_clean);
+
+	spin_unlock(&(to_clean->msg_lock));
+	spin_unlock_irqrestore(&(to_clean->si_lock), flags);
+
+	/* Wait until we know that we are out of any interrupt
+	   handlers might have been running before we freed the
+	   interrupt. */
+	synchronize_kernel();
+
+	/* Wait for the timer to stop.  This avoids problems with race
+	   conditions removing the timer here. */
+	while (!to_clean->timer_stopped) {
+		set_current_state(TASK_UNINTERRUPTIBLE);
+		schedule_timeout(1);
+	}
+
+	rv = ipmi_unregister_smi(to_clean->intf);
+	if (rv) {
+		printk(KERN_ERR 
+		       "ipmi_si: Unable to unregister device: errno=%d\n",
+		       rv);
+	}
+
+	to_clean->handlers->cleanup(to_clean->si_sm);
+
+	kfree(to_clean->si_sm);
+
+	to_clean->io_cleanup(to_clean);
+}
+
+static __exit void cleanup_ipmi_si(void)
+{
+	int i;
+
+	if (!initialized)
+		return;
+
+	for (i=0; i<SI_MAX_DRIVERS; i++) {
+		cleanup_one_si(smi_infos[i]);
+	}
+}
+module_exit(cleanup_ipmi_si);
+#else
+
+/* Unfortunately, cmdline::get_options() only returns integers, not
+   longs.  Since we need ulongs (64-bit physical addresses) parse the 
+   comma-separated list manually.  Arguments can be one of these forms:
+   m0xaabbccddeeff	A physical memory address without an IRQ
+   m0xaabbccddeeff:cc	A physical memory address with an IRQ
+   p0xaabb		An IO port without an IRQ
+   p0xaabb:cc		An IO port with an IRQ
+   nodefaults		Suppress trying the default IO port or ACPI address 
+
+   For example, to pass one IO port with an IRQ, one address, and 
+   suppress the use of the default IO port and ACPI address,
+   use this option string: ipmi_smi=p0xCA2:5,m0xFF5B0022,nodefaults
+
+   Remember, ipmi_si_setup() is passed the string after the equal sign. */
+
+static int __init ipmi_si_setup(char *str)
+{
+	unsigned long val;
+	char *cur, *colon;
+	int pos;
+
+	pos = 0;
+	
+	cur = strsep(&str, ",");
+	while ((cur) && (*cur) && (pos < SI_MAX_PARMS)) {
+		switch (*cur) {
+		case 'n':
+			if (strcmp(cur, "nodefaults") == 0)
+				si_trydefaults = 0;
+			else
+				printk(KERN_INFO 
+				       "ipmi_si: bad parameter value %s\n",
+				       cur);
+			break;
+
+		case 'k': /* KCS */
+			si_type[pos] = "kcs";
+			break;
+		
+		case 's': /* SMIC */
+			si_type[pos] = "smic";
+			break;
+		
+		case 'b': /* BT */
+			si_type[pos] = "bt";
+			break;
+		
+		case 'm':
+		case 'p':
+			val = simple_strtoul(cur + 1,
+					     &colon,
+					     0);
+			if (*cur == 'p')
+				si_ports[pos] = val;
+			else
+				si_addrs[pos] = val;
+			if (*colon == ':') {
+				val = simple_strtoul(colon + 1,
+						     &colon,
+						     0);
+				si_irqs[pos] = val;
+			}
+			pos++;
+			break;
+
+		default:
+			printk(KERN_INFO 
+			       "ipmi_si: bad parameter value %s\n",
+			       cur);
+		}
+		cur = strsep(&str, ",");
+	}
+
+	return 1;
+}
+__setup("ipmi_si=", ipmi_si_setup);
+#endif
+
+MODULE_LICENSE("GPL");
diff -urN linux-a1/drivers/char/ipmi/ipmi_smic_sm.c linux-a2/drivers/char/ipmi/ipmi_smic_sm.c
--- linux-a1/drivers/char/ipmi/ipmi_smic_sm.c	1969-12-31 18:00:00.000000000 -0600
+++ linux-a2/drivers/char/ipmi/ipmi_smic_sm.c	2004-02-23 08:27:14.000000000 -0600
@@ -0,0 +1,599 @@
+/*
+ * ipmi_smic_sm.c
+ *
+ * The state-machine driver for an IPMI SMIC driver
+ *
+ * It started as a copy of Corey Minyard's driver for the KSC interface
+ * and the kernel patch "mmcdev-patch-245" by HP
+ *
+ * modified by:	Hannes Schulz <schulz@schwaar.com>
+ *		ipmi@schwaar.com
+ *
+ *
+ * Corey Minyard's driver for the KSC interface has the following
+ * copyright notice:
+ *   Copyright 2002 MontaVista Software Inc.
+ *
+ * the kernel patch "mmcdev-patch-245" by HP has the following
+ * copyright notice:
+ * (c) Copyright 2001 Grant Grundler (c) Copyright
+ * 2001 Hewlett-Packard Company
+ * 
+ *
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under the terms of the GNU General Public License as published by the
+ *  Free Software Foundation; either version 2 of the License, or (at your
+ *  option) any later version.
+ *
+ *
+ *  THIS SOFTWARE IS PROVIDED ``AS IS'' AND ANY EXPRESS OR IMPLIED
+ *  WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
+ *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
+ *  IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
+ *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
+ *  BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS
+ *  OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
+ *  ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR
+ *  TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE
+ *  USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  675 Mass Ave, Cambridge, MA 02139, USA.  */
+
+#include <linux/kernel.h> /* For printk. */
+#include <linux/string.h>
+#include <linux/ipmi_msgdefs.h>		/* for completion codes */
+#include "ipmi_si_sm.h"
+
+#define IPMI_SMIC_VERSION "v30"
+
+/* smic_debug is a bit-field 
+ *	SMIC_DEBUG_ENABLE -	turned on for now 
+ *	SMIC_DEBUG_MSG -	commands and their responses
+ *	SMIC_DEBUG_STATES -	state machine
+*/
+#define SMIC_DEBUG_STATES	4
+#define SMIC_DEBUG_MSG		2
+#define	SMIC_DEBUG_ENABLE	1
+
+static int smic_debug = 1;
+
+enum smic_states {
+	SMIC_IDLE,
+	SMIC_START_OP,
+	SMIC_OP_OK,
+	SMIC_WRITE_START,
+	SMIC_WRITE_NEXT,
+	SMIC_WRITE_END,
+	SMIC_WRITE2READ,
+	SMIC_READ_START,
+	SMIC_READ_NEXT,
+	SMIC_READ_END,
+	SMIC_HOSED
+};
+
+#define MAX_SMIC_READ_SIZE 80
+#define MAX_SMIC_WRITE_SIZE 80
+#define SMIC_MAX_ERROR_RETRIES 3
+
+/* Timeouts in microseconds. */
+#define SMIC_RETRY_TIMEOUT 100000
+
+/* SMIC Flags Register Bits */
+#define SMIC_RX_DATA_READY	0x80
+#define SMIC_TX_DATA_READY	0x40
+#define SMIC_SMI		0x10
+#define SMIC_EVM_DATA_AVAIL	0x08
+#define SMIC_SMS_DATA_AVAIL	0x04
+#define SMIC_FLAG_BSY		0x01
+
+/* SMIC Error Codes */
+#define	EC_NO_ERROR		0x00
+#define	EC_ABORTED		0x01
+#define	EC_ILLEGAL_CONTROL	0x02
+#define	EC_NO_RESPONSE		0x03
+#define	EC_ILLEGAL_COMMAND	0x04
+#define	EC_BUFFER_FULL		0x05
+
+struct si_sm_data
+{
+	enum smic_states state;
+	struct si_sm_io *io;
+        unsigned char	 write_data[MAX_SMIC_WRITE_SIZE];
+        int		 write_pos;
+        int		 write_count;
+        int		 orig_write_count;
+        unsigned char	 read_data[MAX_SMIC_READ_SIZE];
+        int		 read_pos;
+        int		 truncated;
+        unsigned int	 error_retries;
+        long		 smic_timeout;
+};
+
+static unsigned int init_smic_data (struct si_sm_data *smic,
+				    struct si_sm_io *io)
+{
+	smic->state = SMIC_IDLE;
+	smic->io = io;
+	smic->write_pos = 0;
+	smic->write_count = 0;
+	smic->orig_write_count = 0;
+	smic->read_pos = 0;
+	smic->error_retries = 0;
+	smic->truncated = 0;
+	smic->smic_timeout = SMIC_RETRY_TIMEOUT;
+
+	/* We use 3 bytes of I/O. */
+	return 3;
+}
+
+static int start_smic_transaction(struct si_sm_data *smic,
+				  unsigned char *data, unsigned int size)
+{
+	unsigned int i;
+
+	if ((size < 2) || (size > MAX_SMIC_WRITE_SIZE)) {
+		return -1;
+	}
+	if ((smic->state != SMIC_IDLE) && (smic->state != SMIC_HOSED)) {
+		return -2;
+	}
+	if (smic_debug & SMIC_DEBUG_MSG) {
+		printk(KERN_INFO "start_smic_transaction -");
+		for (i = 0; i < size; i ++) {
+			printk (" %02x", (unsigned char) (data [i]));
+		}
+		printk ("\n");
+	}
+	smic->error_retries = 0;
+	memcpy(smic->write_data, data, size);
+	smic->write_count = size;
+	smic->orig_write_count = size;
+	smic->write_pos = 0;
+	smic->read_pos = 0;
+	smic->state = SMIC_START_OP;
+	smic->smic_timeout = SMIC_RETRY_TIMEOUT;
+	return 0;
+}
+
+static int smic_get_result(struct si_sm_data *smic,
+			   unsigned char *data, unsigned int length)
+{
+	int i;
+
+	if (smic_debug & SMIC_DEBUG_MSG) {
+		printk (KERN_INFO "smic_get result -");
+		for (i = 0; i < smic->read_pos; i ++) {
+			printk (" %02x", (smic->read_data [i]));
+		}
+		printk ("\n");
+	}
+	if (length < smic->read_pos) {
+		smic->read_pos = length;
+		smic->truncated = 1;
+	}
+	memcpy(data, smic->read_data, smic->read_pos);
+
+	if ((length >= 3) && (smic->read_pos < 3)) {
+		data[2] = IPMI_ERR_UNSPECIFIED;
+		smic->read_pos = 3;
+	}
+	if (smic->truncated) {
+		data[2] = IPMI_ERR_MSG_TRUNCATED;
+		smic->truncated = 0;
+	}
+	return smic->read_pos;
+}
+
+static inline unsigned char read_smic_flags(struct si_sm_data *smic)
+{
+	return smic->io->inputb(smic->io, 2);
+}
+
+static inline unsigned char read_smic_status(struct si_sm_data *smic)
+{
+	return smic->io->inputb(smic->io, 1);
+}
+
+static inline unsigned char read_smic_data(struct si_sm_data *smic)
+{
+	return smic->io->inputb(smic->io, 0);
+}
+
+static inline void write_smic_flags(struct si_sm_data *smic,
+				    unsigned char   flags)
+{
+	smic->io->outputb(smic->io, 2, flags);
+}
+
+static inline void write_smic_control(struct si_sm_data *smic,
+				      unsigned char   control)
+{
+	smic->io->outputb(smic->io, 1, control);
+}
+
+static inline void write_si_sm_data (struct si_sm_data *smic,
+				   unsigned char   data)
+{
+	smic->io->outputb(smic->io, 0, data);
+}
+
+static inline void start_error_recovery(struct si_sm_data *smic, char *reason)
+{
+	(smic->error_retries)++;
+	if (smic->error_retries > SMIC_MAX_ERROR_RETRIES) {
+		if (smic_debug & SMIC_DEBUG_ENABLE) {
+			printk(KERN_WARNING
+			       "ipmi_smic_drv: smic hosed: %s\n", reason);
+		}	
+		smic->state = SMIC_HOSED;
+	} else {
+		smic->write_count = smic->orig_write_count;
+		smic->write_pos = 0;
+		smic->read_pos = 0;
+		smic->state = SMIC_START_OP;
+		smic->smic_timeout = SMIC_RETRY_TIMEOUT;
+	}
+}
+
+static inline void write_next_byte(struct si_sm_data *smic)
+{
+	write_si_sm_data(smic, smic->write_data[smic->write_pos]);
+	(smic->write_pos)++;
+	(smic->write_count)--;
+}
+
+static inline void read_next_byte (struct si_sm_data *smic)
+{
+	if (smic->read_pos >= MAX_SMIC_READ_SIZE) {
+		read_smic_data (smic);
+		smic->truncated = 1;
+	} else {
+		smic->read_data[smic->read_pos] = read_smic_data(smic);	
+		(smic->read_pos)++;
+	}
+}
+
+/*  SMIC Control/Status Code Components */
+#define	SMIC_GET_STATUS		0x00	/* Control form's name */
+#define	SMIC_READY		0x00	/* Status  form's name */
+#define	SMIC_WR_START		0x01	/* Unified Control/Status names... */
+#define	SMIC_WR_NEXT		0x02
+#define	SMIC_WR_END		0x03
+#define	SMIC_RD_START		0x04
+#define	SMIC_RD_NEXT		0x05
+#define	SMIC_RD_END		0x06
+#define	SMIC_CODE_MASK		0x0f
+
+#define	SMIC_CONTROL		0x00
+#define	SMIC_STATUS		0x80
+#define	SMIC_CS_MASK		0x80
+
+#define	SMIC_SMS		0x40
+#define	SMIC_SMM		0x60
+#define	SMIC_STREAM_MASK	0x60
+
+/*  SMIC Control Codes */
+#define	SMIC_CC_SMS_GET_STATUS	(SMIC_CONTROL|SMIC_SMS|SMIC_GET_STATUS)
+#define	SMIC_CC_SMS_WR_START	(SMIC_CONTROL|SMIC_SMS|SMIC_WR_START)
+#define	SMIC_CC_SMS_WR_NEXT	(SMIC_CONTROL|SMIC_SMS|SMIC_WR_NEXT)
+#define	SMIC_CC_SMS_WR_END	(SMIC_CONTROL|SMIC_SMS|SMIC_WR_END)
+#define	SMIC_CC_SMS_RD_START	(SMIC_CONTROL|SMIC_SMS|SMIC_RD_START)
+#define	SMIC_CC_SMS_RD_NEXT	(SMIC_CONTROL|SMIC_SMS|SMIC_RD_NEXT)
+#define	SMIC_CC_SMS_RD_END	(SMIC_CONTROL|SMIC_SMS|SMIC_RD_END)
+
+#define	SMIC_CC_SMM_GET_STATUS	(SMIC_CONTROL|SMIC_SMM|SMIC_GET_STATUS)
+#define	SMIC_CC_SMM_WR_START	(SMIC_CONTROL|SMIC_SMM|SMIC_WR_START)
+#define	SMIC_CC_SMM_WR_NEXT	(SMIC_CONTROL|SMIC_SMM|SMIC_WR_NEXT)
+#define	SMIC_CC_SMM_WR_END	(SMIC_CONTROL|SMIC_SMM|SMIC_WR_END)
+#define	SMIC_CC_SMM_RD_START	(SMIC_CONTROL|SMIC_SMM|SMIC_RD_START)
+#define	SMIC_CC_SMM_RD_NEXT	(SMIC_CONTROL|SMIC_SMM|SMIC_RD_NEXT)
+#define	SMIC_CC_SMM_RD_END	(SMIC_CONTROL|SMIC_SMM|SMIC_RD_END)
+
+/*  SMIC Status Codes */
+#define	SMIC_SC_SMS_READY	(SMIC_STATUS|SMIC_SMS|SMIC_READY)
+#define	SMIC_SC_SMS_WR_START	(SMIC_STATUS|SMIC_SMS|SMIC_WR_START)
+#define	SMIC_SC_SMS_WR_NEXT	(SMIC_STATUS|SMIC_SMS|SMIC_WR_NEXT)
+#define	SMIC_SC_SMS_WR_END	(SMIC_STATUS|SMIC_SMS|SMIC_WR_END)
+#define	SMIC_SC_SMS_RD_START	(SMIC_STATUS|SMIC_SMS|SMIC_RD_START)
+#define	SMIC_SC_SMS_RD_NEXT	(SMIC_STATUS|SMIC_SMS|SMIC_RD_NEXT)
+#define	SMIC_SC_SMS_RD_END	(SMIC_STATUS|SMIC_SMS|SMIC_RD_END)
+
+#define	SMIC_SC_SMM_READY	(SMIC_STATUS|SMIC_SMM|SMIC_READY)
+#define	SMIC_SC_SMM_WR_START	(SMIC_STATUS|SMIC_SMM|SMIC_WR_START)
+#define	SMIC_SC_SMM_WR_NEXT	(SMIC_STATUS|SMIC_SMM|SMIC_WR_NEXT)
+#define	SMIC_SC_SMM_WR_END	(SMIC_STATUS|SMIC_SMM|SMIC_WR_END)
+#define	SMIC_SC_SMM_RD_START	(SMIC_STATUS|SMIC_SMM|SMIC_RD_START)
+#define	SMIC_SC_SMM_RD_NEXT	(SMIC_STATUS|SMIC_SMM|SMIC_RD_NEXT)
+#define	SMIC_SC_SMM_RD_END	(SMIC_STATUS|SMIC_SMM|SMIC_RD_END)
+
+/* these are the control/status codes we actually use
+	SMIC_CC_SMS_GET_STATUS	0x40
+	SMIC_CC_SMS_WR_START	0x41
+	SMIC_CC_SMS_WR_NEXT	0x42
+	SMIC_CC_SMS_WR_END	0x43
+	SMIC_CC_SMS_RD_START	0x44
+	SMIC_CC_SMS_RD_NEXT	0x45
+	SMIC_CC_SMS_RD_END	0x46
+
+	SMIC_SC_SMS_READY	0xC0
+	SMIC_SC_SMS_WR_START	0xC1
+	SMIC_SC_SMS_WR_NEXT	0xC2
+	SMIC_SC_SMS_WR_END	0xC3
+	SMIC_SC_SMS_RD_START	0xC4
+	SMIC_SC_SMS_RD_NEXT	0xC5
+	SMIC_SC_SMS_RD_END	0xC6
+*/
+
+static enum si_sm_result smic_event (struct si_sm_data *smic, long time)
+{
+	unsigned char status;
+	unsigned char flags;
+	unsigned char data;
+
+	if (smic->state == SMIC_HOSED) {
+		init_smic_data(smic, smic->io);
+		return SI_SM_HOSED;
+	}
+	if (smic->state != SMIC_IDLE) {
+		if (smic_debug & SMIC_DEBUG_STATES) {
+			printk(KERN_INFO
+			       "smic_event - smic->smic_timeout = %ld,"
+			       " time = %ld\n",
+			       smic->smic_timeout, time);
+		}
+/* FIXME: smic_event is sometimes called with time > SMIC_RETRY_TIMEOUT */
+		if (time < SMIC_RETRY_TIMEOUT) {
+			smic->smic_timeout -= time;
+			if (smic->smic_timeout < 0) {
+				start_error_recovery(smic, "smic timed out.");
+				return SI_SM_CALL_WITH_DELAY;
+			}
+		}
+	}
+	flags = read_smic_flags(smic);
+	if (flags & SMIC_FLAG_BSY)
+		return SI_SM_CALL_WITH_DELAY;
+
+	status = read_smic_status (smic);
+	if (smic_debug & SMIC_DEBUG_STATES)
+		printk(KERN_INFO
+		       "smic_event - state = %d, flags = 0x%02x,"
+		       " status = 0x%02x\n",
+		       smic->state, flags, status);
+
+	switch (smic->state) {
+	case SMIC_IDLE:
+		/* in IDLE we check for available messages */
+		if (flags & (SMIC_SMI |
+			     SMIC_EVM_DATA_AVAIL | SMIC_SMS_DATA_AVAIL))
+		{
+			return SI_SM_ATTN;
+		}
+		return SI_SM_IDLE;
+
+	case SMIC_START_OP:
+		/* sanity check whether smic is really idle */
+		write_smic_control(smic, SMIC_CC_SMS_GET_STATUS);
+		write_smic_flags(smic, flags | SMIC_FLAG_BSY);
+		smic->state = SMIC_OP_OK;
+		break;
+
+	case SMIC_OP_OK:
+		if (status != SMIC_SC_SMS_READY) {
+				/* this should not happen */
+			start_error_recovery(smic,
+					     "state = SMIC_OP_OK,"
+					     " status != SMIC_SC_SMS_READY");
+			return SI_SM_CALL_WITH_DELAY;
+		}
+		/* OK so far; smic is idle let us start ... */
+		write_smic_control(smic, SMIC_CC_SMS_WR_START);
+		write_next_byte(smic);
+		write_smic_flags(smic, flags | SMIC_FLAG_BSY);
+		smic->state = SMIC_WRITE_START;
+		break;
+
+	case SMIC_WRITE_START:
+		if (status != SMIC_SC_SMS_WR_START) {
+			start_error_recovery(smic,
+					     "state = SMIC_WRITE_START, "
+					     "status != SMIC_SC_SMS_WR_START");
+			return SI_SM_CALL_WITH_DELAY;
+		}
+		/* we must not issue WR_(NEXT|END) unless
+                   TX_DATA_READY is set */
+		if (flags & SMIC_TX_DATA_READY) {
+			if (smic->write_count == 1) {
+				/* last byte */
+				write_smic_control(smic, SMIC_CC_SMS_WR_END);
+				smic->state = SMIC_WRITE_END;
+			} else {
+				write_smic_control(smic, SMIC_CC_SMS_WR_NEXT);
+				smic->state = SMIC_WRITE_NEXT;
+			}
+			write_next_byte(smic);
+			write_smic_flags(smic, flags | SMIC_FLAG_BSY);
+		}
+		else {
+			return SI_SM_CALL_WITH_DELAY;
+		}
+		break;
+
+	case SMIC_WRITE_NEXT:
+		if (status != SMIC_SC_SMS_WR_NEXT) {
+			start_error_recovery(smic,
+					     "state = SMIC_WRITE_NEXT, "
+					     "status != SMIC_SC_SMS_WR_NEXT");
+			return SI_SM_CALL_WITH_DELAY;
+		}
+		/* this is the same code as in SMIC_WRITE_START */
+		if (flags & SMIC_TX_DATA_READY) {
+			if (smic->write_count == 1) {
+				write_smic_control(smic, SMIC_CC_SMS_WR_END);
+				smic->state = SMIC_WRITE_END;
+			}
+			else {
+				write_smic_control(smic, SMIC_CC_SMS_WR_NEXT);
+				smic->state = SMIC_WRITE_NEXT;
+			}
+			write_next_byte(smic);
+			write_smic_flags(smic, flags | SMIC_FLAG_BSY);
+		}
+		else {
+			return SI_SM_CALL_WITH_DELAY;
+		}
+		break;
+
+	case SMIC_WRITE_END:
+		if (status != SMIC_SC_SMS_WR_END) {
+			start_error_recovery (smic,
+					      "state = SMIC_WRITE_END, "
+					      "status != SMIC_SC_SMS_WR_END");
+			return SI_SM_CALL_WITH_DELAY;
+		}
+		/* data register holds an error code */
+		data = read_smic_data(smic);
+		if (data != 0) {
+			if (smic_debug & SMIC_DEBUG_ENABLE) {
+				printk(KERN_INFO
+				       "SMIC_WRITE_END: data = %02x\n", data);
+			}
+			start_error_recovery(smic,
+					     "state = SMIC_WRITE_END, "
+					     "data != SUCCESS");
+			return SI_SM_CALL_WITH_DELAY;
+		} else {
+			smic->state = SMIC_WRITE2READ;
+		}
+		break;
+
+	case SMIC_WRITE2READ:
+		/* we must wait for RX_DATA_READY to be set before we
+                   can continue */
+		if (flags & SMIC_RX_DATA_READY) {
+			write_smic_control(smic, SMIC_CC_SMS_RD_START);
+			write_smic_flags(smic, flags | SMIC_FLAG_BSY);
+			smic->state = SMIC_READ_START;
+		} else {
+			return SI_SM_CALL_WITH_DELAY;
+		}
+		break;
+
+	case SMIC_READ_START:
+		if (status != SMIC_SC_SMS_RD_START) {
+			start_error_recovery(smic,
+					     "state = SMIC_READ_START, "
+					     "status != SMIC_SC_SMS_RD_START");
+			return SI_SM_CALL_WITH_DELAY;
+		}
+		if (flags & SMIC_RX_DATA_READY) {
+			read_next_byte(smic);
+			write_smic_control(smic, SMIC_CC_SMS_RD_NEXT);
+			write_smic_flags(smic, flags | SMIC_FLAG_BSY);
+			smic->state = SMIC_READ_NEXT;
+		} else {
+			return SI_SM_CALL_WITH_DELAY;
+		}
+		break;
+
+	case SMIC_READ_NEXT:
+		switch (status) {
+		/* smic tells us that this is the last byte to be read
+                   --> clean up */
+		case SMIC_SC_SMS_RD_END:
+			read_next_byte(smic);
+			write_smic_control(smic, SMIC_CC_SMS_RD_END);
+			write_smic_flags(smic, flags | SMIC_FLAG_BSY);
+			smic->state = SMIC_READ_END;
+			break;
+		case SMIC_SC_SMS_RD_NEXT:
+			if (flags & SMIC_RX_DATA_READY) {
+				read_next_byte(smic);
+				write_smic_control(smic, SMIC_CC_SMS_RD_NEXT);
+				write_smic_flags(smic, flags | SMIC_FLAG_BSY);
+				smic->state = SMIC_READ_NEXT;
+			} else {
+				return SI_SM_CALL_WITH_DELAY;
+			}
+			break;
+		default:
+			start_error_recovery(
+				smic,
+				"state = SMIC_READ_NEXT, "
+				"status != SMIC_SC_SMS_RD_(NEXT|END)");
+			return SI_SM_CALL_WITH_DELAY;
+		}
+		break;
+
+	case SMIC_READ_END:
+		if (status != SMIC_SC_SMS_READY) {
+			start_error_recovery(smic,
+					     "state = SMIC_READ_END, "
+					     "status != SMIC_SC_SMS_READY");
+			return SI_SM_CALL_WITH_DELAY;
+		}
+		data = read_smic_data(smic);
+		/* data register holds an error code */
+		if (data != 0) {
+			if (smic_debug & SMIC_DEBUG_ENABLE) {
+				printk(KERN_INFO
+				       "SMIC_READ_END: data = %02x\n", data);
+			}
+			start_error_recovery(smic,
+					     "state = SMIC_READ_END, "
+					     "data != SUCCESS");
+			return SI_SM_CALL_WITH_DELAY;
+		} else {
+			smic->state = SMIC_IDLE;
+			return SI_SM_TRANSACTION_COMPLETE;
+		}
+
+	case SMIC_HOSED:
+		init_smic_data(smic, smic->io);
+		return SI_SM_HOSED;
+
+	default:
+		if (smic_debug & SMIC_DEBUG_ENABLE) {
+			printk(KERN_WARNING "smic->state = %d\n", smic->state);
+			start_error_recovery(smic, "state = UNKNOWN");
+			return SI_SM_CALL_WITH_DELAY;
+		}
+	}
+	smic->smic_timeout = SMIC_RETRY_TIMEOUT;
+	return SI_SM_CALL_WITHOUT_DELAY;
+}
+
+static int smic_detect(struct si_sm_data *smic)
+{
+	/* It's impossible for the SMIC fnags register to be all 1's,
+	   (assuming a properly functioning, self-initialized BMC)
+	   but that's what you get from reading a bogus address, so we
+	   test that first. */
+	if (read_smic_flags(smic) == 0xff)
+		return 1; 
+
+	return 0;
+}
+
+static void smic_cleanup(struct si_sm_data *kcs)
+{
+}
+
+static int smic_size(void)
+{
+	return sizeof(struct si_sm_data);
+}
+
+struct si_sm_handlers smic_smi_handlers =
+{
+	.version           = IPMI_SMIC_VERSION,
+	.init_data         = init_smic_data,
+	.start_transaction = start_smic_transaction,
+	.get_result        = smic_get_result,
+	.event             = smic_event,
+	.detect            = smic_detect,
+	.cleanup           = smic_cleanup,
+	.size              = smic_size,
+};
diff -urN linux-a1/drivers/char/ipmi/Kconfig linux-a2/drivers/char/ipmi/Kconfig
--- linux-a1/drivers/char/ipmi/Kconfig	2003-12-17 20:59:06.000000000 -0600
+++ linux-a2/drivers/char/ipmi/Kconfig	2004-02-23 08:27:14.000000000 -0600
@@ -43,11 +43,21 @@
          This provides an IOCTL interface to the IPMI message handler so
 	 userland processes may use IPMI.  It supports poll() and select().
 
+config IPMI_SI
+       tristate 'IPMI System Interface handler'
+       depends on IPMI_HANDLER
+       help
+         Provides a driver for System Interfaces (KCS, SMIC, BT).
+	 Currently, only KCS and SMIC are supported.  If
+	 you are using IPMI, you should probably say "y" here.
+
 config IPMI_KCS
        tristate 'IPMI KCS handler'
        depends on IPMI_HANDLER
        help
-         Provides a driver for a KCS-style interface to a BMC.
+         Provides a driver for a KCS-style interface to a BMC.  This
+         is deprecated, please use the IPMI System Interface handler
+	 instead.
 
 config IPMI_WATCHDOG
        tristate 'IPMI Watchdog Timer'
diff -urN linux-a1/drivers/char/ipmi/Makefile linux-a2/drivers/char/ipmi/Makefile
--- linux-a1/drivers/char/ipmi/Makefile	2003-12-17 20:59:40.000000000 -0600
+++ linux-a2/drivers/char/ipmi/Makefile	2004-02-23 08:27:14.000000000 -0600
@@ -3,11 +3,17 @@
 #
 
 ipmi_kcs_drv-objs := ipmi_kcs_sm.o ipmi_kcs_intf.o
+ipmi_si_drv-objs := ipmi_si.o ipmi_kcs_sm.o ipmi_smic_sm.o ipmi_bt_sm.o
 
 obj-$(CONFIG_IPMI_HANDLER) += ipmi_msghandler.o
 obj-$(CONFIG_IPMI_DEVICE_INTERFACE) += ipmi_devintf.o
+obj-$(CONFIG_IPMI_SI) += ipmi_si_drv.o
 obj-$(CONFIG_IPMI_KCS) += ipmi_kcs_drv.o
 obj-$(CONFIG_IPMI_WATCHDOG) += ipmi_watchdog.o
 
 ipmi_kcs_drv.o:	$(ipmi_kcs_drv-objs)
 	$(LD) -r -o $@ $(ipmi_kcs_drv-objs) 
+
+ipmi_si_drv.o:	$(ipmi_si_drv-objs)
+	$(LD) -r -o $@ $(ipmi_si_drv-objs) 
+

--------------090208000301020007070405--

