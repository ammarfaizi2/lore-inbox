Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932365AbWDZFGm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932365AbWDZFGm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 01:06:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932369AbWDZFGl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 01:06:41 -0400
Received: from smtp102.sbc.mail.re2.yahoo.com ([68.142.229.103]:58297 "HELO
	smtp102.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S932367AbWDZFGl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 01:06:41 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: [PATCH 001/001] INPUT: new ioctl's to retrieve values of EV_REP and EV_SND event codes
Date: Wed, 26 Apr 2006 01:06:38 -0400
User-Agent: KMail/1.9.1
Cc: bjd <bjdouma@xs4all.nl>, linux-kernel@vger.kernel.org
References: <20060422204844.GA16968@skyscraper.unix9.prv> <d120d5000604250823p4f2ed2acv4287f7d70c71c7c0@mail.gmail.com> <20060425152600.GA30398@suse.cz>
In-Reply-To: <20060425152600.GA30398@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604260106.38480.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 25 April 2006 11:26, Vojtech Pavlik wrote:
> On Tue, Apr 25, 2006 at 11:23:02AM -0400, Dmitry Torokhov wrote:
> > On 4/25/06, Vojtech Pavlik <vojtech@suse.cz> wrote:
> > > On Tue, Apr 25, 2006 at 09:19:42AM -0400, Dmitry Torokhov wrote:
> > > > On 4/24/06, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> > > > > On 4/24/06, Vojtech Pavlik <vojtech@suse.cz> wrote:
> > > > > > On Mon, Apr 24, 2006 at 10:31:39AM -0400, Dmitry Torokhov wrote:
> > > > > > >
> > > > > > > Vojtech, could you remind me why EVIOC{G|S}REP were removed? Some
> > > > > > > people want to have ability to separate keyboards (via grabbing); they
> > > > > > > also might want to control repeat rate independently. Shoudl we
> > > > > > > reinstate these ioctls?
> > > > > >
> > > > > > I believe they were replaced by the ability to send EV_REP style events
> > > > > > to the device, setting the repeat rate.
> > > > > >
> > > > >
> > > > > Argh, why am I always forgetting about ability to write events into devices?
> > > >
> > > > Thinking about it some more - writing to the event device is an
> > > > elegant way to set repeat rate but how do you retrieve current repeat
> > > > rate for a given device?
> > >
> > > You can't. And that's likely a problem that needs fixing.
> > >
> > 
> > So do you agree that we need to ressurect EVIOCGREP (and EVIOCSREP
> > just to complement the interface)?
>  
> Yes. And EVIOCSREP should just generate the events needed to notify the
> drivers to do the change.
> 

What do you gius think about the patch below?

-- 
Dmitry

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/evdev.c |   21 +++++++++++++++++++++
 include/linux/input.h |    2 ++
 2 files changed, 23 insertions(+)

Index: work/drivers/input/evdev.c
===================================================================
--- work.orig/drivers/input/evdev.c
+++ work/drivers/input/evdev.c
@@ -403,6 +403,27 @@ static long evdev_ioctl_handler(struct f
 		case EVIOCGID:
 			if (copy_to_user(p, &dev->id, sizeof(struct input_id)))
 				return -EFAULT;
+			return 0;
+
+		case EVIOCGREP:
+			if (!test_bit(EV_REP, dev->evbit))
+				return -ENOSYS;
+			if (put_user(dev->rep[REP_DELAY], ip))
+				return -EFAULT;
+			if (put_user(dev->rep[REP_PERIOD], ip + 1))
+				return -EFAULT;
+			return 0;
+
+		case EVIOCSREP:
+			if (!test_bit(EV_REP, dev->evbit))
+				return -ENOSYS;
+			if (get_user(u, ip))
+				return -EFAULT;
+			if (get_user(v, ip + 1))
+				return -EFAULT;
+
+			input_event(dev, EV_REP, REP_DELAY, u);
+			input_event(dev, EV_REP, REP_PERIOD, v);
 
 			return 0;
 
Index: work/include/linux/input.h
===================================================================
--- work.orig/include/linux/input.h
+++ work/include/linux/input.h
@@ -56,6 +56,8 @@ struct input_absinfo {
 
 #define EVIOCGVERSION		_IOR('E', 0x01, int)			/* get driver version */
 #define EVIOCGID		_IOR('E', 0x02, struct input_id)	/* get device ID */
+#define EVIOCGREP		_IOR('E', 0x03, int[2])			/* get repeat settings */
+#define EVIOCSREP		_IOW('E', 0x03, int[2])			/* get repeat settings */
 #define EVIOCGKEYCODE		_IOR('E', 0x04, int[2])			/* get keycode */
 #define EVIOCSKEYCODE		_IOW('E', 0x04, int[2])			/* set keycode */
 
