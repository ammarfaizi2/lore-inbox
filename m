Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272540AbRI0MNq>; Thu, 27 Sep 2001 08:13:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272533AbRI0MNg>; Thu, 27 Sep 2001 08:13:36 -0400
Received: from atbode61.informatik.tu-muenchen.de ([131.159.32.54]:47488 "EHLO
	atbode61.informatik.tu-muenchen.de") by vger.kernel.org with ESMTP
	id <S272540AbRI0MNY>; Thu, 27 Sep 2001 08:13:24 -0400
Date: Thu, 27 Sep 2001 14:13:44 +0200
From: Georg Acher <acher@in.tum.de>
To: "Nemosoft Unv." <nemosoft@smcc.demon.nl>
Cc: Jan Harkes <jaharkes@cs.cmu.edu>, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org, webcam@smcc.demon.nl,
        "Eloy A. Paris" <eloy.paris@usa.net>,
        linux-usb-devel@lists.sourceforge.net, greg@kroah.com
Subject: Re: [linux-usb-devel] RE: [PATCH -R] Re: 2.4.10 is toxic to my system when I use my US
Message-ID: <20010927141344.A1491@atbode61.informatik.tu-muenchen.de>
Mail-Followup-To: Georg Acher <acher@in.tum.de>,
	"Nemosoft Unv." <nemosoft@smcc.demon.nl>,
	Jan Harkes <jaharkes@cs.cmu.edu>, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org, webcam@smcc.demon.nl,
	"Eloy A. Paris" <eloy.paris@usa.net>,
	linux-usb-devel@lists.sourceforge.net, greg@kroah.com
In-Reply-To: <20010926191123.A30545@cs.cmu.edu> <XFMail.010927083327.nemosoft@smcc.demon.nl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="AhhlLboLdkugWU4S"
Content-Disposition: inline
User-Agent: Mutt/1.3.16i
In-Reply-To: <XFMail.010927083327.nemosoft@smcc.demon.nl>; from nemosoft@smcc.demon.nl on Thu, Sep 27, 2001 at 08:33:27AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 27, 2001 at 08:33:27AM +0200, Nemosoft Unv. wrote:
> Personally, I say the above piece of code is faulty. Refering to a
> pointer after you appearently deleted it, is just very bad programming
> practice. 

ACK ;-) And according to our CVS it is lurking around since March 2000.
There are a few similar actions in other portions of the code, but they are
correct (as far I can see...).

> I?d say, fix the usb-uhci file, and do a quick run on all other instances
> of list_del. I think most programmers got it right, or 2.4.10 kernels would
> be coming down all over the planet.

Fix attached. Please apply it.
-- 
         Georg Acher, acher@in.tum.de         
         http://www.in.tum.de/~acher/
          "Oh no, not again !" The bowl of petunias          

--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="usb-uhci.patch"

--- linux/drivers/usb/usb-uhci.c.org	Thu Sep 27 12:12:39 2001
+++ linux/drivers/usb/usb-uhci.c	Thu Sep 27 14:06:43 2001
@@ -2528,7 +2528,7 @@
 	int i;
 	int ret = 0;
 	urb_priv_t *urb_priv = urb->hcpriv;
-	struct list_head *p = urb_priv->desc_list.next;
+	struct list_head *p = urb_priv->desc_list.next, *p_tmp;
 	uhci_desc_t *desc = list_entry (urb_priv->desc_list.prev, uhci_desc_t, desc_list);
 
 	dbg("urb contains iso request");
@@ -2578,8 +2578,9 @@
 		dbg("process_iso: %i: len:%d %08x status:%x",
 		     i, urb->iso_frame_desc[i].actual_length, le32_to_cpu(desc->hw.td.status),urb->iso_frame_desc[i].status);
 
-		list_del (p);
+		p_tmp = p;
 		p = p->next;
+		list_del (p_tmp);
 		delete_desc (s, desc);
 	}
 	

--AhhlLboLdkugWU4S--
