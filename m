Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932141AbWAYTho@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932141AbWAYTho (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 14:37:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932145AbWAYTho
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 14:37:44 -0500
Received: from xproxy.gmail.com ([66.249.82.194]:43237 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932141AbWAYThn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 14:37:43 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=Gv7it6gMMv291NuxGGSMpNlbOjdT/LK1rogTASjjX23hkx0nOxjz9tkV/FMUPhQORXRS1vsoN6poLpnWLFDbOVrLLCO5FTTh73PUfEop8xUMIZM2wzLOV7RogERzRhaFO2ldIUe6T/BWVp3Oqn1+Uk1Ti1gYik3JkPwhnuz0foY=
Message-ID: <4807377b0601251137r7621216byc47b03a3c634557c@mail.gmail.com>
Date: Wed, 25 Jan 2006 11:37:40 -0800
From: Jesse Brandeburg <jesse.brandeburg@gmail.com>
To: Olaf Kirch <okir@suse.de>
Subject: Re: e100 oops on resume
Cc: Stefan Seyfried <seife@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       netdev@vger.kernel.org
In-Reply-To: <20060125121125.GH5465@suse.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_68443_5705500.1138217860777"
References: <20060124225919.GC12566@suse.de>
	 <20060124232142.GB6174@inferi.kami.home>
	 <20060125090240.GA12651@suse.de> <20060125121125.GH5465@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_68443_5705500.1138217860777
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On 1/25/06, Olaf Kirch <okir@suse.de> wrote:
> On Wed, Jan 25, 2006 at 10:02:40AM +0100, Olaf Kirch wrote:
> > I'm not sure what the right fix would be. e100_resume would probably
> > have to call e100_alloc_cbs early on, while e100_up should avoid
> > calling it a second time if nic->cbs_avail !=3D 0. A tentative patch
> > for testing is attached.
>
> Reportedly, the patch fixes the crash on resume.

Cool, thanks for the research, I have a concern about this however.

its an interesting patch, but it raises the question why does
e100_init_hw need to be called at all in resume?  I looked back
through our history and that init_hw call has always been there.  I
think its incorrect, but its taking me a while to set up a system with
the ability to resume.

everywhere else in the driver alloc_cbs is called before init_hw so it
just seems like a long standing bug.

comments?  anyone want to test? i compile tested this, but it is untested.

------=_Part_68443_5705500.1138217860777
Content-Type: application/octet-stream; name=e100_resume_no_init.diff
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="e100_resume_no_init.diff"

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

------=_Part_68443_5705500.1138217860777--
