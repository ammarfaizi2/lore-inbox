Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282223AbRK2AkE>; Wed, 28 Nov 2001 19:40:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282228AbRK2Aj5>; Wed, 28 Nov 2001 19:39:57 -0500
Received: from c1313109-a.potlnd1.or.home.com ([65.0.121.190]:45828 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S282223AbRK2AiM>;
	Wed, 28 Nov 2001 19:38:12 -0500
Date: Wed, 28 Nov 2001 16:38:10 -0800
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] fix for drivers/char/pc_keyb.c in 2.5.1-pre3
Message-ID: <20011128163810.C2512@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Wed, 31 Oct 2001 22:18:48 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here's a patch for 2.5.1-pre3 to fix the compile time problems in
drivers/char/pc_keyb.c.  It also fixes the places where the flags
variable is the wrong type.

thanks,

greg k-h


diff -Nru a/drivers/char/pc_keyb.c b/drivers/char/pc_keyb.c
--- a/drivers/char/pc_keyb.c	Wed Nov 28 16:34:37 2001
+++ b/drivers/char/pc_keyb.c	Wed Nov 28 16:34:37 2001
@@ -420,7 +420,7 @@
 			       kbd_write_command(KBD_CCMD_WRITE_MODE);
 			       kb_wait();
 			       kbd_write_output(AUX_INTS_OFF);
-			       spin_unlock(&kbd_controller_lock, flags);
+			       spin_unlock(&kbd_controller_lock);
 		       }
 		       spin_unlock_irqrestore( &aux_count_lock,flags );
 	       }
@@ -433,7 +433,7 @@
 static inline void handle_mouse_event(unsigned char scancode)
 {
 #ifdef CONFIG_PSMOUSE
-	int flags;
+	unsigned long flags;
 	static unsigned char prev_code;
 	if (mouse_reply_expected) {
 		if (scancode == AUX_ACK) {
@@ -1052,9 +1052,9 @@
 
 static int release_aux(struct inode * inode, struct file * file)
 {
-	int flags;
+	unsigned long flags;
 	fasync_aux(-1, file, 0);
-	spin_lock_irqsave( &aux_count, flags );
+	spin_lock_irqsave( &aux_count_lock, flags );
 	if ( --aux_count ) {
 		spin_unlock_irqrestore( &aux_count_lock );
 		return 0;
@@ -1073,7 +1073,7 @@
 
 static int open_aux(struct inode * inode, struct file * file)
 {
-	int flags;
+	unsigned long flags;
 	spin_lock_irqsave( &aux_count_lock, flags );
 	if ( aux_count++ ) {
 		spin_unlock_irqrestore( &aux_count_lock );
