Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261839AbVGSBev@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261839AbVGSBev (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Jul 2005 21:34:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261849AbVGSBev
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Jul 2005 21:34:51 -0400
Received: from zproxy.gmail.com ([64.233.162.206]:17870 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261839AbVGSBeu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Jul 2005 21:34:50 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=pQYCdecI1NM4HtlKTGw7BlMGHYGH/J1aNG8Fw0+NZDpIY4Yo9EWgMC/9D1ggpKjyia9bIClcUxK2kf/OLTUj7Ufnl3GApkWXXVJHSvNrmd+7rcFAJ1CK8qK6wr9W5iLLt/7BqAhYnQbKG9WiQgnjxpg4Vk4c4kSQbMmQI5A/ybM=
Message-ID: <9a87484905071818347419bf82@mail.gmail.com>
Date: Tue, 19 Jul 2005 03:34:23 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
Reply-To: Jesper Juhl <jesper.juhl@gmail.com>
To: Pete Zaitcev <zaitcev@redhat.com>
Subject: Re: Fw: Oops in hidinput_hid_event
Cc: vojtech@suse.cz, linux-kernel@vger.kernel.org
In-Reply-To: <9a874849050718183175bc08d4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050718141637.074c6f70.zaitcev@redhat.com>
	 <9a874849050718183175bc08d4@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/19/05, Jesper Juhl <jesper.juhl@gmail.com> wrote:
> On 7/18/05, Pete Zaitcev <zaitcev@redhat.com> wrote:
> > I think this patch is rather obvious, so maybe I should ask Andrew to
> > apply it to -mm for now, to get some testing. Would that help to verify
> > it for acceptance?
> >
> > -- Pete
> >
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
> > --- linux-2.6.12/drivers/usb/input/hid-input.c  2005-06-21 12:58:47.000000000 -0700
> > +++ linux-2.6.12-lem/drivers/usb/input/hid-input.c      2005-06-28 14:57:22.000000000 -0700
> > @@ -397,11 +397,12 @@
> >
> >  void hidinput_hid_event(struct hid_device *hid, struct hid_field *field, struct hid_usage *usage, __s32 value, struct pt_regs *regs)
> >  {
> > -       struct input_dev *input = &field->hidinput->input;
> > +       struct input_dev *input;
> >         int *quirks = &hid->quirks;
> >
> > -       if (!input)
> > +       if (!field->hidinput)
> 
> How about
>              if (!field || !field->hdinput)
> instead?
> 
> >                 return;
> > +       input = &field->hidinput->input;
> 
> Add a
>              if (!input)
>                      return;
> check here?
> 
Ehh, I must have been sleeping, disregard this last bit...

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
