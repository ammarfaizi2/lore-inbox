Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750723AbWA1TxE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750723AbWA1TxE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jan 2006 14:53:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750728AbWA1TxE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jan 2006 14:53:04 -0500
Received: from xproxy.gmail.com ([66.249.82.195]:12376 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750723AbWA1TxC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jan 2006 14:53:02 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=DgiSQvcnEdnaEwTpNCOZ2J4Ek5jxLYD/+K6auibuCFN55B1iMoWRQy+Wdphl69Kfbg4LpcdgnPLE22VPae9JkQm3p29G3mH1GsSKOX7cFn15D513TqsN2tFnKueVeZZs3tfNx9dyvEyDvyFzwD6NgwykJWlG6VWRSuFTNM3AOB8=
Message-ID: <4807377b0601281153r618586ddhca27b7772e023d26@mail.gmail.com>
Date: Sat, 28 Jan 2006 11:53:01 -0800
From: Jesse Brandeburg <jesse.brandeburg@gmail.com>
To: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: e100 oops on resume
Cc: Stefan Seyfried <seife@suse.de>,
       Jesse Brandeburg <jesse.brandeburg@gmail.com>,
       Olaf Kirch <okir@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       netdev@vger.kernel.org, Jesse Brandeburg <jesse.brandeburg@intel.com>,
       Jeff Kirsher <jeffrey.t.kirsher@intel.com>
In-Reply-To: <20060128115335.GA4511@inferi.kami.home>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_10820_12746031.1138477981471"
References: <20060124225919.GC12566@suse.de>
	 <20060124232142.GB6174@inferi.kami.home>
	 <20060125090240.GA12651@suse.de> <20060125121125.GH5465@suse.de>
	 <4807377b0601251137r7621216byc47b03a3c634557c@mail.gmail.com>
	 <4807377b0601251628k4227dad0ld731f2c25c211b91@mail.gmail.com>
	 <20060126190236.GA12481@suse.de>
	 <20060128115335.GA4511@inferi.kami.home>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_10820_12746031.1138477981471
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On 1/28/06, Mattia Dongili <malattia@linux.it> wrote:
> On Thu, Jan 26, 2006 at 08:02:37PM +0100, Stefan Seyfried wrote:
> > On Wed, Jan 25, 2006 at 04:28:48PM -0800, Jesse Brandeburg wrote:
> >
> > > Okay I reproduced the issue on 2.6.15.1 (with S1 sleep) and was able
> > > to show that my patch that just removes e100_init_hw works okay for
> > > me.  Let me know how it goes for you, I think this is a good fix.
> >
> > worked for me in the Compaq Armada e500 and reportedly also fixed the
> > SONY that originally uncovered it.
>
> confirmed here too. The patch fixes S3 resume on this Sony (GR7/K)
> running 2.6.16-rc1-mm3.

excellent news! thanks for testing.

Jeff, could you please apply to 2.6.16-rcX

Jesse

------=_Part_10820_12746031.1138477981471
Content-Type: application/octet-stream; name=e100_resume_no_init.patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="e100_resume_no_init.patch"

e100: remove init_hw call to fix panic

Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>

e100 seems to have had a long standing bug where e100_init_hw was being
called when it should not have been.  This caused a panic due to recent
changes that rely on correct set up in the driver, and more robust error
paths.
---

 drivers/net/e100.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/drivers/net/e100.c b/drivers/net/e100.c
--- a/drivers/net/e100.c
+++ b/drivers/net/e100.c
@@ -2752,8 +2752,6 @@ static int e100_resume(struct pci_dev *p
 	retval = pci_enable_wake(pdev, 0, 0);
 	if (retval)
 		DPRINTK(PROBE,ERR, "Error clearing wake events\n");
-	if(e100_hw_init(nic))
-		DPRINTK(HW, ERR, "e100_hw_init failed\n");
 
 	netif_device_attach(netdev);
 	if(netif_running(netdev))

------=_Part_10820_12746031.1138477981471--
