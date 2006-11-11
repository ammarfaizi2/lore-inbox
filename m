Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424375AbWKKQM6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424375AbWKKQM6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Nov 2006 11:12:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424272AbWKKQM6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Nov 2006 11:12:58 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:49936 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1424255AbWKKQM5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Nov 2006 11:12:57 -0500
Date: Sat, 11 Nov 2006 17:13:00 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Manuel Francisco Naranjo <naranjo.manuel@gmail.com>
Cc: gregkh@suse.de, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: drivers/usb/serial/aircable.c: inconsequent NULL checking
Message-ID: <20061111161300.GB8809@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The Coverity checker spotted the following in 
drivers/usb/serial/aircable.c:

<--  snip  -->

...
static void aircable_read(void *params)
{
        struct usb_serial_port *port = params;
        struct aircable_private *priv = usb_get_serial_port_data(port);
        struct tty_struct *tty;
        unsigned char *data;
        int count;
        if (priv->rx_flags & THROTTLED){
                if (priv->rx_flags & ACTUALLY_THROTTLED)
                        schedule_work(&priv->rx_work);
                return;
        }

        /* By now I will flush data to the tty in packages of no more than
         * 64 bytes, to ensure I do not get throttled.
         * Ask USB mailing list for better aproach.
         */
        tty = port->tty;

        if (!tty)
                schedule_work(&priv->rx_work);

        count = min(64, serial_buf_data_avail(priv->rx_buf));

        if (count <= 0)
                return; //We have finished sending everything.

        tty_prepare_flip_string(tty, &data, count);
...

<--  snip  -->

"tty" is first checked for being !NULL, but later it's unconditionally 
dereferenced.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

