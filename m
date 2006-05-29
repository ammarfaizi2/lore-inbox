Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750739AbWE2RLN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750739AbWE2RLN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 13:11:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750764AbWE2RLN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 13:11:13 -0400
Received: from perninha.conectiva.com.br ([200.140.247.100]:58577 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S1750739AbWE2RLN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 13:11:13 -0400
Date: Mon, 29 May 2006 14:11:10 -0300
From: "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>
To: "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>
Cc: Pete Zaitcev <zaitcev@redhat.com>, Frank Gevaerts <frank.gevaerts@fks.be>,
       linux-kernel@vger.kernel.org, gregkh@suse.de,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: usb-serial ipaq kernel problem
Message-ID: <20060529141110.6d149e21@doriath.conectiva>
In-Reply-To: <20060529132553.08b225ba@doriath.conectiva>
References: <20060526182217.GA12687@fks.be>
	<20060526133410.9cfff805.zaitcev@redhat.com>
	<20060529120102.1bc28bf2@doriath.conectiva>
	<20060529132553.08b225ba@doriath.conectiva>
Organization: Mandriva
X-Mailer: Sylpheed-Claws 2.2.0 (GTK+ 2.8.17; i586-mandriva-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 May 2006 13:25:53 -0300
"Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br> wrote:

| On Mon, 29 May 2006 12:01:02 -0300
| "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br> wrote:
| 
| | 
| |  Hi Pete,
| | 
| | On Fri, 26 May 2006 13:34:10 -0700
| | Pete Zaitcev <zaitcev@redhat.com> wrote:
| | 
| | | On Fri, 26 May 2006 20:22:17 +0200, Frank Gevaerts <frank.gevaerts@fks.be> wrote:
| | | 
| | | > usb 1-4.5.7: USB disconnect, address 79
| | | > ------------[ cut here ]------------
| | | > kernel BUG at kernel/workqueue.c:110!
| | | 
| | | Please let me know if this helps:
| | | 
| | | --- linux-2.6.17-rc2/drivers/usb/serial/usb-serial.c	2006-04-23 21:06:18.000000000 -0700
| | | +++ linux-2.6.17-rc2-lem/drivers/usb/serial/usb-serial.c	2006-05-22 21:23:29.000000000 -0700
| | | @@ -162,6 +162,8 @@ static void destroy_serial(struct kref *
| | |  		}
| | |  	}
| | |  
| | | +	flush_scheduled_work();		/* port->work */
| | | +
| | |  	usb_put_dev(serial->dev);
| | |  
| | |  	/* free up any memory that we allocated */
| | 
| |  IIUC, the problem occurred before the call to destroy_serial(),
| | otherwise it should be in the backtrace.
| | 
| |  It seems that 'port->work' is becoming NULL when the device is
| | disconnected, but the ipaq_write_bulk_callback() is executing after
| | that.
| 
|  Err, I meant 'port->work->entry' is empty, of course.

 Frank, could you try this one please?

 I have no sure whether this makes sense, but every USB-Serial driver
I know exits in the write URB callback if the URB got an error.

-------------------

usbserial: ipaq: Don't handle URB on errors.

ipaq_write_bulk_callback() should exit if the URB got an error, otherwise
we can get weird problems.

Signed-off-by: Luiz Fernando N. Capitulino <lcapitulino@mandriva.com.br>

---

 drivers/usb/serial/ipaq.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

6ad106187344769a4722f9e6d6f265529844d568
diff --git a/drivers/usb/serial/ipaq.c b/drivers/usb/serial/ipaq.c
index 9a5c979..d263a5e 100644
--- a/drivers/usb/serial/ipaq.c
+++ b/drivers/usb/serial/ipaq.c
@@ -855,6 +855,7 @@ static void ipaq_write_bulk_callback(str
 	
 	if (urb->status) {
 		dbg("%s - nonzero write bulk status received: %d", __FUNCTION__, urb->status);
+		return;
 	}
 
 	spin_lock_irqsave(&write_list_lock, flags);
-- 
1.3.2



-- 
Luiz Fernando N. Capitulino
