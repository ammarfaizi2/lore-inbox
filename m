Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261334AbVC2Thl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261334AbVC2Thl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 14:37:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261326AbVC2Thk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 14:37:40 -0500
Received: from smtp811.mail.sc5.yahoo.com ([66.163.170.81]:21600 "HELO
	smtp811.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261343AbVC2Tev (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 14:34:51 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Stefan Seyfried <seife@suse.de>
Subject: Re: swsusp 'disk' fails in bk-current - intel_agp at fault?
Date: Tue, 29 Mar 2005 13:42:26 -0500
User-Agent: KMail/1.7.2
Cc: Andy Isaacson <adi@hexapodia.org>,
       kernel list <linux-kernel@vger.kernel.org>
References: <20050323184919.GA23486@hexapodia.org> <20050324181059.GA18490@hexapodia.org> <4243252D.6090206@suse.de>
In-Reply-To: <4243252D.6090206@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503291342.27224.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 24 March 2005 15:38, Stefan Seyfried wrote:
> Andy Isaacson wrote:
> > So I added i8042.noaux to my kernel command line, rebooted, insmodded
> > intel_agp, started X, and verified no touchpad action.  Then I
> > suspended, and it worked fine.  After restart, I suspended again - also
> > fine.
> > 
> > So I think that fixed it.  But no touchpad is a bit annoying. :)
> 
> Yes, it was not thought as a fix but just for verification, since i have
> seen something similar.
> We have a SUSE bug for this, i believe Vojtech and Pavel will take care
> of this one. Thanks for confirming, i almost started to believe i was
> seeing ghosts :-)

Could you please try the patch below - it should fix the issues you are
seeing although there may be other devices (really any hot-pluggable
device) that will show the same behaviour. In the long run swsusp should
not attempt resuming devices when the system can not handle the process
properly. 

-- 
Dmitry

===================================================================

Input: serio - do not attempt to immediately disconnect port if
       resume failed, let kseriod take care of it. Otherwise we
       may attempt to unregister associated input devices which
       will generate hotplug events which are not handled well
       during swsusp.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>


 serio.c |    1 -
 1 files changed, 1 deletion(-)

Index: dtor/drivers/input/serio/serio.c
===================================================================
--- dtor.orig/drivers/input/serio/serio.c
+++ dtor/drivers/input/serio/serio.c
@@ -779,7 +779,6 @@ static int serio_resume(struct device *d
 	struct serio *serio = to_serio_port(dev);
 
 	if (!serio->drv || !serio->drv->reconnect || serio->drv->reconnect(serio)) {
-		serio_disconnect_port(serio);
 		/*
 		 * Driver re-probing can take a while, so better let kseriod
 		 * deal with it.
