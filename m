Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291063AbSAaNUJ>; Thu, 31 Jan 2002 08:20:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291064AbSAaNT7>; Thu, 31 Jan 2002 08:19:59 -0500
Received: from codepoet.org ([166.70.14.212]:40918 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id <S291063AbSAaNTx>;
	Thu, 31 Jan 2002 08:19:53 -0500
Date: Thu, 31 Jan 2002 06:19:49 -0700
From: Erik Andersen <andersen@codepoet.org>
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Adaptec 1480b SlimSCSI vs hotplug
Message-ID: <20020131131949.GA11787@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	"Justin T. Gibbs" <gibbs@scsiguy.com>,
	linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20020130025212.GA5240@codepoet.org> <200201300453.g0U4rYI61847@aslan.scsiguy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200201300453.g0U4rYI61847@aslan.scsiguy.com>
User-Agent: Mutt/1.3.24i
X-Operating-System: Linux 2.4.16-rmk1, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue Jan 29, 2002 at 09:53:34PM -0700, Justin T. Gibbs wrote:
> to doing the comparison.  The logic in the kernel handles the
> mask correctly:
> 
> 	((ids->class ^ dev->class) & ids->class_mask) == 0
> 
> My guess is that diethotplug is not handling the mask correctly
> and thus doesn't work with a partial mask.

Upon looking closer, you are correct.  diethotplug gets it wrong
here.  I've fixed diethotplug, and now I can plug in my Adaptec
1480 card and have hotplug load the driver and everything works.
I can also unplug the card, and things seem to work as expected.

If I subsequently insert the card, it no longer works until I
have first manually unloaded the aic7xxx module.  A quick bit of
debugging shows that ahc_linux_pci_dev_probe is getting called
the second time as it should be, and aic7xxx_detect_complete is
indeed 1 the second time, so ahc_linux_register_host gets
called...  But nothing seems to actually get registered with the
scsi layer the second time around.

Here is another interesting bit.  insert the card for the first
time and wait for initialization and 'cat /proc/scsi/aic7xxx/0'
and all looks normal.  Now remove the card.  /proc/scsi/aic7xxx/0
is still present, and 'cat /proc/scsi/aic7xxx/0' produces an
Oops...  Hmm.

I see that on card removal, ahc_linux_pci_dev_remove() calls
ahc_free() which calls ahc_platform_free() which calls
scsi_unregister(), which means that /proc/scsi/aic7xxx/0
shouldn't be there anymore....  I'm missing something in 
there somewhere.  Ideas?

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
