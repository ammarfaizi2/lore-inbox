Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129573AbRAIRup>; Tue, 9 Jan 2001 12:50:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129431AbRAIRuf>; Tue, 9 Jan 2001 12:50:35 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:28658 "HELO
	brinquedo.distro.conectiva") by vger.kernel.org with SMTP
	id <S129627AbRAIRuX>; Tue, 9 Jan 2001 12:50:23 -0500
Date: Tue, 9 Jan 2001 14:02:37 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] isicom.c: restore_flags on failure, etc
Message-ID: <20010109140237.X21057@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

	Please consider applying.

- Arnaldo

--- linux-2.4.0-ac4/drivers/char/isicom.c	Tue Dec 19 11:25:34 2000
+++ linux-2.4.0-ac4.acme/drivers/char/isicom.c	Tue Jan  9 13:51:37 2001
@@ -16,6 +16,10 @@
  *
  *	10/6/99 sameer			Merged the ISA and PCI drivers to
  *					a new unified driver.
+ *	09/06/01 acme@conectiva.com.br	use capable, not suser, do
+ *					restore_flags on failure in
+ *					isicom_send_break, verify put_user
+ *					result
  *	***********************************************************
  *
  *	To use this driver you also need the support package. You 
@@ -1354,13 +1358,13 @@
 	while (((inw(base + 0x0e) & 0x0001) == 0) && (wait-- > 0));	
 	if (!wait) {
 		printk(KERN_DEBUG "ISICOM: Card found busy in isicom_send_break.\n");
-		return;
+		goto out;
 	}	
 	outw(0x8000 | ((port->channel) << (card->shift_count)) | 0x3, base);
 	outw((length & 0xff) << 8 | 0x00, base);
 	outw((length & 0xff00), base);
 	InterruptTheCard(base);
-	restore_flags(flags);
+out:	restore_flags(flags);
 }
 
 static int isicom_get_modem_info(struct isi_port * port, unsigned int * value)
@@ -1375,8 +1379,7 @@
 		((status & ISI_DSR) ? TIOCM_DSR : 0) |
 		((status & ISI_CTS) ? TIOCM_CTS : 0) |
 		((status & ISI_RI ) ? TIOCM_RI  : 0);
-	put_user(info, (unsigned int *) value);
-	return 0;	
+	return put_user(info, (unsigned int *) value);
 }
 
 static int isicom_set_modem_info(struct isi_port * port, unsigned int cmd,
@@ -1438,7 +1441,7 @@
 	reconfig_port = ((port->flags & ASYNC_SPD_MASK) != 
 			 (newinfo.flags & ASYNC_SPD_MASK));
 	
-	if (!suser()) {
+	if (!capable(CAP_SYS_ADMIN)) {
 		if ((newinfo.close_delay != port->close_delay) ||
 		    (newinfo.closing_wait != port->closing_wait) ||
 		    ((newinfo.flags & ~ASYNC_USR_MASK) != 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
