Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275043AbRJNKlZ>; Sun, 14 Oct 2001 06:41:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275045AbRJNKlQ>; Sun, 14 Oct 2001 06:41:16 -0400
Received: from ns1.uklinux.net ([212.1.130.11]:4875 "EHLO s1.uklinux.net")
	by vger.kernel.org with ESMTP id <S275043AbRJNKlG>;
	Sun, 14 Oct 2001 06:41:06 -0400
Envelope-To: <linux-kernel@vger.kernel.org>
Message-ID: <3BC96B65.AA83D3C2@localhost.localdomain>
Date: Sun, 14 Oct 2001 11:39:33 +0100
From: Andy Greenhalgh <andy.greenhalgh@bazaar.uklinux.net>
X-Mailer: Mozilla 4.73 [en] (X11; I; Linux 2.2.17 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] for 2.4.9 console driver: user defined terminal answerbacks
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I've put together a simple patch for the console driver of the 2.4.9
kernel
(listed below). The same patch can also be applied to the 2.2.17 kernel
but
I guess that's becoming less relevant. The patch enables what I believe
to
be correct vt102 answerback behaviour i.e. an answerback string of up to
20
characters in response to ascii ENQ (0x05). Later DEC terminals would
respond to an answerback request of \E[c if I remember rightly, however
I
have tried to remain faithful to the philosophy of providing a vt102
emulation. In truth I did patch this as well, but took it out after
succumbing to a puritanical whim. The answerback is user defined by
setting
the top most string in the kernel function key string table:
func_table[255]. This kernel data structure can be accessed by the
existing
console_ioctl interface. In practice users can set the answerback by the
use
of loadkeys (string F246).

All errors are of course my own and confident though I am, I would
suggest
you initially proceed with caution as I can not accept liability for any
untoward consequences :-(. Also, please CC any responses as
unfortunately I
am not subscribed to this mail list due to the limitations of eking out
an
existence on a humble dial-up connection.

Best wishes



Andy

--- console.c_orig_     Sun Sep  2 13:53:20 2001
+++ console.c   Sun Sep  2 14:26:17 2001
@@ -113,7 +113,7 @@
  * (such as cursor movement) and should not be displayed as a
  * glyph unless the disp_ctrl mode is explicitly enabled.
  */
-#define CTRL_ACTION 0x0d00ff81
+#define CTRL_ACTION 0x0d00ffa1
 #define CTRL_ALWAYS 0x0800f501 /* Cannot be overridden by disp_ctrl */
 
 /*
@@ -1148,6 +1148,23 @@
        respond_string(VT102ID, tty);
 }
 
+/* User defined answerback: string F246 in loadkeys 
+   Truncated at 20 chars for correct vt102 behavior */
+static inline void answerback(struct tty_struct * tty)
+{
+       char buf[21];
+
+       if (func_table[255]) {
+               if (strlen(func_table[255]) > 20) {
+                       strncpy(buf, func_table[255], 20);
+                       buf[20] = '\0';
+                       respond_string(buf, tty);
+               }
+               else
+                       respond_string(func_table[255], tty);
+       }
+}
+
 void mouse_report(struct tty_struct * tty, int butt, int mrx, int mry)
 {
        char buf[8];
@@ -1430,6 +1447,9 @@
         */
        switch (c) {
        case 0:
+               return;
+       case 5:
+               answerback(tty);
                return;
        case 7:
                if (bell_duration)


-- 
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
The beer-cooled computer does not harm the ozone layer.
		-- John M. Ford, a.k.a. Dr. Mike

	[If I can read my notes from the Ask Dr. Mike session at Baycon, I
	 believe he added that the beer-cooled computer uses "Forget Only
	 Memory".  Ed.]

andy.greenhalgh@bazaar.uklinux.net
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
