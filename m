Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261413AbSJHWHn>; Tue, 8 Oct 2002 18:07:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261409AbSJHWHn>; Tue, 8 Oct 2002 18:07:43 -0400
Received: from mailout07.sul.t-online.com ([194.25.134.83]:51619 "EHLO
	mailout07.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S261402AbSJHWHf>; Tue, 8 Oct 2002 18:07:35 -0400
Content-Type: text/plain; charset=US-ASCII
From: Oliver Neukum <oliver@neukum.name>
To: "John Tyner" <jtyner@cs.ucr.edu>, "Greg KH" <greg@kroah.com>
Subject: Re: [linux-usb-devel] Re: Vicam/3com homeconnect usb camera driver
Date: Tue, 8 Oct 2002 18:30:04 +0200
X-Mailer: KMail [version 1.3.2]
Cc: <linux-usb-devel@lists.sourceforge.net>, linux-kernel@vger.kernel.org
References: <001c01c26ce4$39b67f80$0a00a8c0@refresco> <m17yUpC-006hzVC@Mail.ZEDAT.FU-Berlin.DE> <001901c26e8d$3f62f850$0a00a8c0@refresco>
In-Reply-To: <001901c26e8d$3f62f850$0a00a8c0@refresco>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-ID: <17z2b8-2CNQquC@fmrl08.sul.t-online.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 08 October 2002 07:40, John Tyner wrote:
> This is a resend of the patch I sent earlier. I worked on the one earlier
> while away from home and was unable to test it. This one has been fixed,
> tested, and should be correct. Sorry for the confusion.
>
> Patch is against 2.5.41.
>
> Thanks,
> John

Hi,

+	if ( waitqueue_active( &vicam_v4l_priv->no_users ) ) {
+		wake_up( &vicam_v4l_priv->no_users );

never ever do this. Always do the wake_up unconditionally.

ioctl() - VIDIOSYNC: this may hang if you unplug at the wrong moment,
as there's nobody to up the semaphore in that case.
You should do the up in the disconnect handler and check for disconnection
in the ioctl so you can return -ENODEV in that case.

in disconnect:

+	/* make sure no one will submit another urb */
+	clear_bit( 0, &vicam_v4l_priv->vicam_present );

But it does not guard against control messages in flight.
You need a semaphore to do that.

+	usb_unlink_urb( vicam_v4l_priv->urb );
+	down( &vicam_v4l_priv->busy_mutex );

This can hang for two reasons,
- you might not be the only user of that semaphore
- usb_unlink_urb may fail due to there being no queued urb,
  eg. if the completion handler is running - you need to check the return     
  value

+	if ( vdev->users ) {
+		sleep_on( &vicam_v4l_priv->no_users );
+	}

_Very_ bad idea.
First, never use sleep_on. Use the appropriate macro.
Second, you have blocked khubd without an upper time limit.
That you _must_ _not_ in any case do.

+	kfree( vicam_v4l_priv );
+	kfree( vicam_usb_priv );

Potentionally deadly if the device is open, you need to defer it to release 
in that case

Sorry for all that trouble.

	Regards
		Oliver
