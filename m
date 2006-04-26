Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964789AbWDZOYg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964789AbWDZOYg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 10:24:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964792AbWDZOYf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 10:24:35 -0400
Received: from nz-out-0102.google.com ([64.233.162.200]:18086 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S964789AbWDZOYe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 10:24:34 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=QPNe3MmG8vL+EI26TwqonHB5Ov4k7t0OIPeSxnHSQlNqJGS/BJJ/flbpImqnir5F7Q4oBDU13SApb5NQtaHCg7PNBa6/xc6OMejv8p9pAHte9nB1aYPa8hfjXkuX85ChERgotQkVyfQXtuM01Uy7SqWAFFx8GLB5IZPeN4IRl18=
Message-ID: <d120d5000604260724q45f52117t27920f2ae59bea76@mail.gmail.com>
Date: Wed, 26 Apr 2006 10:24:32 -0400
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: bjdouma <bjdouma@xs4all.nl>
Subject: Re: [PATCH 001/001] INPUT: new ioctl's to retrieve values of EV_REP and EV_SND event codes
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060426104301.GA4634@skyscraper.unix9.prv>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_17986_32896250.1146061472987"
References: <20060422204844.GA16968@skyscraper.unix9.prv>
	 <d120d5000604250823p4f2ed2acv4287f7d70c71c7c0@mail.gmail.com>
	 <20060425152600.GA30398@suse.cz>
	 <200604260106.38480.dtor_core@ameritech.net>
	 <20060426104301.GA4634@skyscraper.unix9.prv>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_17986_32896250.1146061472987
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On 4/26/06, bjdouma <bjdouma@xs4all.nl> wrote:
> On Wed, Apr 26, 2006 at 01:06:38AM -0400, Dmitry Torokhov wrote:
>
> > What do you gius think about the patch below?
>
> Works like a charm.
> Why is it though that we need EVIOCSREP, when I can set PERIOD and
> DELAY through writing a struct input_event directly to the file
> descriptor?  I've been doing that for quite some time, having
> softrepeat=3D1 (I need a quick keyboard, DELAY=3D120, PERIOD=3D18).
>
> One typo in the patch:
> +#define EVIOCSREP              _IOW('E', 0x03, int[2])                 /=
* get repeat settings */
> should be:
> +#define EVIOCSREP              _IOW('E', 0x03, int[2])                 /=
* set repeat settings */
>

Ah, OK, thanks, I will fix that.

> Now, the EV_SND bitmap is still broken.
> I don't think it's simply a matter of adding change_bit(code,dev->snd)
> in the EV_SND part of input.c.  During a quick test the bitmap
> became confused, after setting both bell and tone through writing
> a struct input_event to the file descriptor of the pcspkr's event
> file in /dev/input/, then setting just bell to 0.
>

Are you saying that both bits were set to 0 or that you could not hear
the tone after killing bell? If latter then it is sort of pcspkr
problem as from input core POV tone is still active.

Btw, your patch - did it resemble something like attached?

--
Dmitry

------=_Part_17986_32896250.1146061472987
Content-Type: text/plain; name=input-fix-EVIOCGSND.patch; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Attachment-Id: f_emhreev8
Content-Disposition: attachment; filename="input-fix-EVIOCGSND.patch"

Input: make EVIOCGSND return meaningful data

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---
 drivers/input/input.c |    3 +++
 1 file changed, 3 insertions(+)

Index: linux/drivers/input/input.c
===================================================================
--- linux.orig/drivers/input/input.c
+++ linux/drivers/input/input.c
@@ -155,6 +155,9 @@ void input_event(struct input_dev *dev, 
 			if (code > SND_MAX || !test_bit(code, dev->sndbit))
 				return;
 
+			if (!!test_bit(code, dev->snd) != !!value)
+				change_bit(code, dev->snd);
+
 			if (dev->event) dev->event(dev, type, code, value);
 
 			break;

------=_Part_17986_32896250.1146061472987--
