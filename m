Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750771AbWELBbd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750771AbWELBbd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 May 2006 21:31:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750775AbWELBbd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 May 2006 21:31:33 -0400
Received: from perninha.conectiva.com.br ([200.140.247.100]:22932 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S1750771AbWELBbc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 May 2006 21:31:32 -0400
Date: Thu, 11 May 2006 22:34:17 -0300
From: Luiz Fernando Capitulino <lcapitulino@mandriva.com.br>
To: gregkh@suse.de
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: [PATCH 1/2] usbserial: Fixes use-after-free in serial_open().
Message-ID: <20060511223417.7433e19b@home.brethil>
Organization: Mandriva
X-Mailer: Sylpheed-Claws 1.0.4 (GTK+ 1.2.10; x86_64-mandriva-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 If the device is disconnected while serial_open() is executing and either
try_module_get() or the device specific open function fails, the kref_put()
call in the 'bailout_kref_put' label will free the memory pointed out by
'port'.

 The subsequent dereferences in the 'bailout_kref_put' label will be
invalid.

 The fix is just to assure kref_put() is called after any 'port' usage.

Signed-off-by: Luiz Fernando N. Capitulino <lcapitulino@mandriva.com.br>

---

 drivers/usb/serial/usb-serial.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

4eaa6dcadd9df93d0297cdff45fe8a30169c7abe
diff --git a/drivers/usb/serial/usb-serial.c b/drivers/usb/serial/usb-serial.c
index 071f86a..d9dceb4 100644
--- a/drivers/usb/serial/usb-serial.c
+++ b/drivers/usb/serial/usb-serial.c
@@ -225,9 +225,9 @@ static int serial_open (struct tty_struc
 bailout_module_put:
 	module_put(serial->type->driver.owner);
 bailout_kref_put:
-	kref_put(&serial->kref, destroy_serial);
 	port->open_count = 0;
 	mutex_unlock(&port->mutex);
+	kref_put(&serial->kref, destroy_serial);
 	return retval;
 }
 
-- 
1.3.1.ge5de



-- 
Luiz Fernando N. Capitulino
