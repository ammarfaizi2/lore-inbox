Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757379AbWK2AEd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757379AbWK2AEd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 19:04:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757290AbWK2AEd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 19:04:33 -0500
Received: from mout0.freenet.de ([194.97.50.131]:26270 "EHLO mout0.freenet.de")
	by vger.kernel.org with ESMTP id S1757379AbWK2AEc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 19:04:32 -0500
From: Karsten Wiese <fzu@wemgehoertderstaat.de>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6.19-rc6-rt8
Date: Wed, 29 Nov 2006 01:04:51 +0100
User-Agent: KMail/1.9.5
Cc: "Fernando Lopez-Lezcano" <nando@ccrma.stanford.edu>,
       linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
References: <20061127094927.GA7339@elte.hu> <200611282340.21317.fzu@wemgehoertderstaat.de>
In-Reply-To: <200611282340.21317.fzu@wemgehoertderstaat.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611290104.51731.fzu@wemgehoertderstaat.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 28. November 2006 23:40 schrieb Karsten Wiese:
> Am Montag, 27. November 2006 10:49 schrieb Ingo Molnar:
> > i have released the 2.6.19-rc6-rt8 tree, which can be downloaded from 
> 
> I saw usb transport errors here before rebooting with
> 	nmi_watchdog=0
> contained in kernel command line.
> 
> Testcase stalled within 2 minutes before change,
> ticks happily after change for 15 minutes now.
> .config is a "release" type, no debugging options.

After estimated 15 minutes more it bugged again.
Related dmesg translates to linux error
	-EXDEV
propably caused by the following lines:

<snip>
static int uhci_result_isochronous(struct uhci_hcd *uhci, struct urb *urb)
{
	struct uhci_td *td, *tmp;
	struct urb_priv *urbp = urb->hcpriv;
	struct uhci_qh *qh = urbp->qh;

	list_for_each_entry_safe(td, tmp, &urbp->td_list, list) {
		unsigned int ctrlstat;
		int status;
		int actlength;

		if (uhci_frame_before_eq(uhci->cur_iso_frame, qh->iso_frame))
			return -EINPROGRESS;

		uhci_remove_tds_from_frame(uhci, qh->iso_frame);

		ctrlstat = td_status(td);
		if (ctrlstat & TD_CTRL_ACTIVE) {
			status = -EXDEV;	/* TD was added too late? */
</snip>

      Karsten
