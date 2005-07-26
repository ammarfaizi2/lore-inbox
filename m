Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261779AbVGZOLk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261779AbVGZOLk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 10:11:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261790AbVGZOLk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 10:11:40 -0400
Received: from mivlgu.ru ([81.18.140.87]:12714 "EHLO mail.mivlgu.ru")
	by vger.kernel.org with ESMTP id S261779AbVGZOLi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 10:11:38 -0400
Date: Tue, 26 Jul 2005 18:11:31 +0400
From: Sergey Vlasov <vsu@altlinux.ru>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Pete Zaitcev <zaitcev@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: Fw: Oops in hidinput_hid_event
Message-Id: <20050726181131.451ed691.vsu@altlinux.ru>
In-Reply-To: <20050719133058.GA7872@ucw.cz>
References: <20050718141637.074c6f70.zaitcev@redhat.com>
	<20050719133058.GA7872@ucw.cz>
X-Mailer: Sylpheed version 1.0.0beta4 (GTK+ 1.2.10; i586-alt-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Tue__26_Jul_2005_18_11_31_+0400_B=z4A=mKKSVuirOy"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Tue__26_Jul_2005_18_11_31_+0400_B=z4A=mKKSVuirOy
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Tue, 19 Jul 2005 09:30:58 -0400 Vojtech Pavlik wrote:

> On Mon, Jul 18, 2005 at 02:16:37PM -0700, Pete Zaitcev wrote:
> 
> > I think this patch is rather obvious, so maybe I should ask Andrew to
> > apply it to -mm for now, to get some testing. Would that help to verify
> > it for acceptance?
> 
> Your patch is perfectly OK, my NULL check was indeed completely wrong.
> 
> I need to find out how there can be an input event happening without its
> associated input structure, though, since the oops actually reveals a
> deeper problem.

hidinput_connect() does:

	for (k = HID_INPUT_REPORT; k <= HID_OUTPUT_REPORT; k++)
		... loop which calls hidinput_configure_usage(),
		    which initializes report->hidinput pointers ...

So ->hidinput is getting set only for fields of input and output
reports, but the device may also support feature reports, and for their
fields ->hidinput will remain NULL.  When such report is requested with
hid_submit_report(hid, report, USB_DIR_IN), the completed urb will be
handled by hid_ctrl(), which will call hid_input_report() for it; this
corresponds to the traceback in oops.

BTW, the driver requests all feature reports during initialization (in
hid_init_reports()), but it does not oops there, because
hidinput_connect() is called only later, and therefore HID_CLAIMED_INPUT
is not yet set.

However, I still don't understand where hid_submit_report() gets called
for a feature report in the reported case (hidinput_input_event() can
submit only output reports, and a call from hiddev is unlikely to be
triggered by a NumLock press).

> So that's why I didn't apply the patch yet.
> 
> > Begin forwarded message:
> > 
> > Date: Tue, 28 Jun 2005 15:00:23 -0700
> > From: Pete Zaitcev <zaitcev@redhat.com>
> > To: vojtech@suse.cz
> > Cc: zaitcev@redhat.com, linux-usb-devel@lists.sourceforge.net
> > Subject: Oops in hidinput_hid_event
> > 
> > Hi, Vojtech:
> > 
> > Someone reported a bug in Fedora, which runs a largely unmodified upstream
> > kernel in this area. Whenever the user hits a key which switches LED,
> > the system oopses. Here's a trace:
> > 
> > Unable to handle kernel NULL pointer dereference at virtual address 000000c8
> > EFLAGS: 00010006   (2.6.11-1.1369_FC4smp)
> > EIP is at hidinput_hid_event+0x2d/0x292                                       
> > Call Trace:           
> >  [<c02872e0>] hid_process_event+0x57/0x5f
> >  [<c028758a>] hid_input_field+0x2a2/0x2ac
> >  [<c0287632>] hid_input_report+0x9e/0xb8
> >  [<c0287f62>] hid_ctrl+0x14c/0x151
> >  [<e0a21060>] uhci_destroy_urb_priv+0xb5/0x10a [uhci_hcd]
> >  [<c027dab5>] usb_hcd_giveback_urb+0x24/0x67
> >  [<e0a22360>] uhci_finish_urb+0x2d/0x38 [uhci_hcd]
> >  [<e0a223af>] uhci_finish_completion+0x44/0x56 [uhci_hcd]
> >  [<e0a224a2>] uhci_scan_schedule+0xaa/0x13a [uhci_hcd]
> >  [<c023413d>] i8042_interrupt+0x121/0x234
> >  [<e0a226d0>] uhci_irq+0x47/0x10d [uhci_hcd]
> > 
> > Full trace at
> >  https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=160709
> > 
> > Any ideas?
> > 
> > By the way, it seems that I see a bug in hidinput_hid_event.
> > The check for NULL can never work, becaue &hidinput->input
> > is nonzero at all times. How about this?
> > 
> > --- linux-2.6.12/drivers/usb/input/hid-input.c	2005-06-21 12:58:47.000000000 -0700
> > +++ linux-2.6.12-lem/drivers/usb/input/hid-input.c	2005-06-28 14:57:22.000000000 -0700
> > @@ -397,11 +397,12 @@
> >  
> >  void hidinput_hid_event(struct hid_device *hid, struct hid_field *field, struct hid_usage *usage, __s32 value, struct pt_regs *regs)
> >  {
> > -	struct input_dev *input = &field->hidinput->input;
> > +	struct input_dev *input;
> >  	int *quirks = &hid->quirks;
> >  
> > -	if (!input)
> > +	if (!field->hidinput)
> >  		return;
> > +	input = &field->hidinput->input;
> >  
> >  	input_regs(input, regs);
> >  
> > 
> > -- Pete
> > 
> 
> -- 
> Vojtech Pavlik
> SuSE Labs, SuSE CR

--Signature=_Tue__26_Jul_2005_18_11_31_+0400_B=z4A=mKKSVuirOy
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFC5kSVW82GfkQfsqIRAiG7AJ9ey12L2zZzBnnoSyMf9U+jRu5pAgCeMyx1
joNtnyDFKfI9usWEAtpDARI=
=uIPL
-----END PGP SIGNATURE-----

--Signature=_Tue__26_Jul_2005_18_11_31_+0400_B=z4A=mKKSVuirOy--
