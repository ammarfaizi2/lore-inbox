Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261792AbSJNAt2>; Sun, 13 Oct 2002 20:49:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261795AbSJNAt2>; Sun, 13 Oct 2002 20:49:28 -0400
Received: from clix.aarnet.edu.au ([192.94.63.10]:44012 "EHLO
	clix.aarnet.edu.au") by vger.kernel.org with ESMTP
	id <S261792AbSJNAtZ>; Sun, 13 Oct 2002 20:49:25 -0400
Message-ID: <3DAA15F6.6020500@aarnet.edu.au>
Date: Mon, 14 Oct 2002 10:25:18 +0930
From: Glen Turner <glen.turner@aarnet.edu.au>
Organization: Australian Academic and Research Network
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020408
X-Accept-Language: en-au, en-gb, en, en-us
MIME-Version: 1.0
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] 3/3 Fix serial console flow control, serial-console.txt
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- linux-2.4.20-pre8/Documentation/serial-console.txt    Tue Jun 20 05:26:07 2000
+++ linux-2.4.20-pre8-gdt1/Documentation/serial-console.txt    Fri Oct 11 12:01:15 2002
@@ -102,3 +102,159 @@
     the integration of these patches into m68k, ppc and alpha.

  Miquel van Smoorenburg <miquels@cistron.nl>, 11-Jun-2000
+
+            ----------------
+
+          Serial console flow control
+
+The serial console now supports CTS-based flow control, along with DSR
+and DCD for status control.  This is configured by appending a 'r' to
+the kernel paramater.  For example
+
+    console=ttyS1,9600n8
+
+becomes
+
+    console=ttyS1,9600n8r
+
+I've no idea why Kanoj Sarcar, the flow control author, chose 'r'.
+Think of it as "Rigidly Interpreting the RS-232 Specification".
+
+The remote device must assert the incoming status lines Data Set Ready
+and Data Carrier Detect and the incoming flow control line Clear to
+Send before seeing any kernel-generated console output.
+
+When initializing the serial console the kernel asserts the outgoing
+status line Data Terminal Ready and the outgoing flow control line
+Ready to Send.  A user-space application may later alter DTR or RTS
+(getty often clears and re-asserts DTR and RTS when initializing).
+
+Configuring status and flow control requires a correctly configured
+remote device and a correctly wired cable.  In return disconnected
+devices do not see kernel messages and can use flow control to ensure
+that characters are not dropped from kernel-generated messages.  This
+allows smart modems to be used reliably.
+
+The code has one pathological case.  If DSR and DCD are cabled to be
+always asserted but there is no remote host present then CTS will be
+tested a million times before the pending kernel message is discarded.
+This is about a one second delay for each console message [1].  When
+wiring a null modem cable take care to avoid this case by powering DSR
+and DCD from the remote machine's DTR, not the local machine's DTR.
+
+Glen Turner
+2002-10-10
+
+ [1] If it is any consolation, in these circumstances a previous
+     version of flow control looped testing for about one second per
+     character in the message.
+
+            ----------------
+
+            sysctl variables
+
+Debugging RS-232 cabling on a remotely-located machine can be
+difficult, so a number of sysctl variables are maintained.  These are
+located in the "dev.serialconsole" namespace, which can be found at
+
+        /proc/sys/dev/serialconsole/
+
+messages-total
+
+    The number of messages presented to the serial console
+
+    Expected values are 0 or greater.
+
+messages-dropped
+
+    The number of messages abandoned during output by the serial
+    console.
+
+    The reasons message were abandoned are counted in the timeouts-*
+    variables.  Totalling the values in timeouts-* should match
+    messages-dropped.
+
+    The number of successfully output messages is (messages-total -
+    messages-dropped).
+
+    Expected values are integers of 0 or greater.  When no flow
+    control is configured, the only source of update is
+    timeouts-transmit.
+
+timeouts-transmit
+maximum-attempts-transmit
+
+    The number of times when printing a character the UART's transmit
+    buffer, after being tested maximum-attempts-transmit times, is
+    still full.  The character and the remainder of the messages is
+    abandoned and messages-dropped incremented.
+
+    The expected values of timeouts-transmit are integers of 0 or
+    greater.  Values greater than 0 suggest a design or hardware fault
+    in the UART.
+
+    maximum-attempts-transmit can be altered, valid values are
+    integers greater than 1.  Values that result in waiting for the
+    UART's transmit buffer for more than a second or so are not
+    recommended.
+
+timeouts-data-set-ready
+
+    When flow control is configured, the number of times when printing
+    a character the RS-232 signal Data Set Ready was not asserted.
+    The character and the remainder of the messages is abandoned and
+    messages-dropped incremented.
+
+    Expected value is 0 if flow control is not configued.
+
+    Expected values are integers of 0 or greater if flow control is
+    configured.
+
+    If the remote RS-232 device is disconnected then increments to
+    this variable or timeouts-data-carrier-detect are expected.  If
+    the device is connected then increments suggest a cabling error or
+    a DSR status configuration error on the remote device.
+
+timeouts-data-carrier-detect
+
+    When flow control is configured, the number of times when printing
+    a character the RS-232 signal Data Carrier Detect was not
+    asserted.  The character and the remainder of the messages is
+    abandoned and messages-dropped incremented.
+
+    Expected value is 0 if flow control is not configued.
+
+    Expected values are integers of 0 or greater if flow control is
+    configured.
+
+    If the remote RS-232 device is disconnected then increments to
+    this variable or timeouts-data-set-ready are expected.  If the
+    device is connected then increments suggest a cabling error or a
+    DCD status configuration error on the remote device.
+
+timeouts-clear-to-send
+maximum-attempts-clear-to-send
+
+    When flow control is configured, the number of times when printing
+    a character the RS-232 signal Clear to Send, after being tested
+    maximum-attempts-clear-to-send times, is still not asserted.  The
+    character and the remainder of the messages is abandoned and
+    messages-dropped incremented.
+
+    The expected values of timeouts-clear-to-send are integers of 0 or
+    greater.  Values greater than 0 suggest a very slow RS-232 device,
+    a cabling error, or a handshaking configuration error on the
+    remote device.
+
+    maximum-attempts-clear-to-send can be altered, valid values are
+    integers greater than 1.  Values that result in waiting for CTS
+    for more than a second or so are not recommended.
+
+            ----------------
+
+         Further documentation
+
+More information on configuring a serial console can be found in the
+Linux Documentation Project's "Remote Serial Console HOWTO".
+
+    http://www.tldp.org/HOWTO/Remote-Serial-Console-HOWTO/

