Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932337AbWBPSKU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932337AbWBPSKU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 13:10:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932472AbWBPSKU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 13:10:20 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:37642 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932337AbWBPSKS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 13:10:18 -0500
Date: Thu, 16 Feb 2006 18:09:39 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       Jens Axboe <axboe@suse.de>, "Brown, Len" <len.brown@intel.com>,
       "David S. Miller" <davem@davemloft.net>, linux-acpi@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net,
       "Yu, Luming" <luming.yu@intel.com>, Ben Castricum <lk@bencastricum.nl>,
       sanjoy@mrao.cam.ac.uk, Helge Hafting <helgehaf@aitel.hist.no>,
       "Carlo E. Prelz" <fluido@fluido.as>,
       Gerrit Bruchh?user <gbruchhaeuser@gmx.de>, Nicolas.Mailhot@LaPoste.net,
       Jaroslav Kysela <perex@suse.cz>, Takashi Iwai <tiwai@suse.de>,
       Patrizio Bassi <patrizio.bassi@gmail.com>,
       Bj?rn Nilsson <bni.swe@gmail.com>, Andrey Borzenkov <arvidjaar@mail.ru>,
       "P. Christeas" <p_christ@hol.gr>, ghrt <ghrt@dial.kappa.ro>,
       jinhong hu <jinhong.hu@gmail.com>,
       Andrew Vasquez <andrew.vasquez@qlogic.com>, linux-scsi@vger.kernel.org,
       Benjamin LaHaise <bcrl@kvack.org>
Subject: Re: Linux 2.6.16-rc3
Message-ID: <20060216180939.GF29443@flint.arm.linux.org.uk>
Mail-Followup-To: James Bottomley <James.Bottomley@SteelEye.com>,
	Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>,
	Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@suse.de>, "Brown, Len" <len.brown@intel.com>,
	"David S. Miller" <davem@davemloft.net>, linux-acpi@vger.kernel.org,
	linux-usb-devel@lists.sourceforge.net,
	"Yu, Luming" <luming.yu@intel.com>,
	Ben Castricum <lk@bencastricum.nl>, sanjoy@mrao.cam.ac.uk,
	Helge Hafting <helgehaf@aitel.hist.no>,
	"Carlo E. Prelz" <fluido@fluido.as>,
	Gerrit Bruchh?user <gbruchhaeuser@gmx.de>,
	Nicolas.Mailhot@LaPoste.net, Jaroslav Kysela <perex@suse.cz>,
	Takashi Iwai <tiwai@suse.de>,
	Patrizio Bassi <patrizio.bassi@gmail.com>,
	Bj?rn Nilsson <bni.swe@gmail.com>,
	Andrey Borzenkov <arvidjaar@mail.ru>,
	"P. Christeas" <p_christ@hol.gr>, ghrt <ghrt@dial.kappa.ro>,
	jinhong hu <jinhong.hu@gmail.com>,
	Andrew Vasquez <andrew.vasquez@qlogic.com>,
	linux-scsi@vger.kernel.org, Benjamin LaHaise <bcrl@kvack.org>
References: <Pine.LNX.4.64.0602121709240.3691@g5.osdl.org> <20060212190520.244fcaec.akpm@osdl.org> <20060213203800.GC22441@kroah.com> <1139934883.14115.4.camel@mulgrave.il.steeleye.com> <1140054960.3037.5.camel@mulgrave.il.steeleye.com> <20060216171200.GD29443@flint.arm.linux.org.uk> <1140112653.3178.9.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1140112653.3178.9.camel@mulgrave.il.steeleye.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 16, 2006 at 09:57:32AM -0800, James Bottomley wrote:
> On Thu, 2006-02-16 at 17:12 +0000, Russell King wrote:
> > This is probably an idiotic question, but if there's something in the
> > scsi release handler can't be called in non-process context, why can't
> > scsi queue up the release processing via the work API itself, rather
> > than having to have this additional code and complexity for everyone?
> 
> It's because, in order to get a guaranteed single allocation for the
> workqueue to execute in user context, I need to know when the release
> will be called.  The only way to do that is to add the execute in
> process context directly to kref_put.

Is there something in the driver model which would prevent something
like this?

static void scsi_release_process(void *p)
{
	struct my_work *work = p;
	struct device *dev = work->dev;

	/* destroy dev */

	kfree(work);
}

static void scsi_release(struct device *dev)
{
	struct my_work *work;

	work = kmalloc(sizeof(struct my_work), GFP_ATOMIC);
	if (work) {
		INIT_WORK(&work->work, scsi_release_process, work);
		work->dev = dev;
		schedule_work(&work->work);
	} else {
		printk(KERN_ERR ...);
	}
}

where scsi_release() is the function called by the device model on the
last put of a scsi device.

I guess is more or less what you're trying to do invasively via the
driver model.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
