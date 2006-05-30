Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932350AbWE3RTZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932350AbWE3RTZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 13:19:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932352AbWE3RTY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 13:19:24 -0400
Received: from nz-out-0102.google.com ([64.233.162.203]:20562 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932350AbWE3RTY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 13:19:24 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=SVmNvvHEO108A8/fWBZTLjMQpePIbfOE5CVmhpzZcrygSQvYJqKCWxxPoCTPNjbFKtrJXiZpFdpbN1VT4FdPkuqz/9Ayc37dZBAYpVP3YSb/aYLEZ2G0vWdOK3Xe3kNAk6Hivj40mXp1xxVt1LYV9CYAqot7oAKnk+OwlDfCdUs=
Message-ID: <9e4733910605301019x30cb41eby2ac54b8b48856179@mail.gmail.com>
Date: Tue, 30 May 2006 13:19:23 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Matthew Wilcox" <matthew@wil.cx>
Subject: Re: searching for pci busses
Cc: "Greg KH" <gregkh@suse.de>, "Jeff Garzik" <jgarzik@pobox.com>,
       "Greg KH" <greg@kroah.com>, "Jiri Slaby" <jirislaby@gmail.com>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz
In-Reply-To: <20060530170051.GA1610@parisc-linux.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_9157_9954774.1149009563352"
References: <4478DCF1.8080608@gmail.com> <20060529214753.GD10875@kroah.com>
	 <447B6ECB.9080207@pobox.com> <20060530163821.GC7146@suse.de>
	 <9e4733910605300952v1cf56beasc2a907cc77b8a09f@mail.gmail.com>
	 <20060530170051.GA1610@parisc-linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_9157_9954774.1149009563352
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On 5/30/06, Matthew Wilcox <matthew@wil.cx> wrote:
> On Tue, May 30, 2006 at 12:52:31PM -0400, Jon Smirl wrote:
> > This is how DRM does it...
>
> >        for (i = 0; driver->pci_driver.id_table[i].vendor != 0; i++) {
> >                pid = (struct pci_device_id *)&driver->pci_driver.id_table[i];
>
> Why do you cast away the const warning?  Why not just make pid a pointer
> to const?  drm_get_dev already has the const qualifier, so somebody
> realised what the right thing to do was.

Nobody pointed that out before (That code has been around for a while,
I suspect one of the routines being called wasn't always marked as
taking a const parameter). I made a patch and attached it. You can
send it to DaveA, they reject everything from me.

> But looking at this code just reinforces the basic problem -- that DRM
> does everything wrong and it needs shooting in the head.

DRM has to do that loop because the fbdev drivers are already bound to
the device. There is a more complex version in DRM CVS that looks for
the fbdev drivers, if they are not present DRM will bind to the
device, otherwise it falls back in stealth mode. It also adds code to
manually mark PCI memory regions in use. Confusion over who can bind
has impacts on attaching to the suspend/resume hooks.

But binding is only a minor problem. The true problem is who controls
the state loaded inside of the device.

-- 
Jon Smirl
jonsmirl@gmail.com

------=_Part_9157_9954774.1149009563352
Content-Type: text/x-patch; name=drm.patch; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
X-Attachment-Id: f_enuiigb8
Content-Disposition: attachment; filename="drm.patch"

diff --git a/drivers/char/drm/drm_drv.c b/drivers/char/drm/drm_drv.c
index 3c0b882..3af48be 100644
--- a/drivers/char/drm/drm_drv.c
+++ b/drivers/char/drm/drm_drv.c
@@ -253,7 +253,7 @@ int drm_lastclose(drm_device_t * dev)
 int drm_init(struct drm_driver *driver)
 {
 =09struct pci_dev *pdev =3D NULL;
-=09struct pci_device_id *pid;
+=09const struct pci_device_id *pid;
 =09int i;
=20
 =09DRM_DEBUG("\n");
@@ -261,7 +261,7 @@ int drm_init(struct drm_driver *driver)
 =09drm_mem_init();
=20
 =09for (i =3D 0; driver->pci_driver.id_table[i].vendor !=3D 0; i++) {
-=09=09pid =3D (struct pci_device_id *)&driver->pci_driver.id_table[i];
+=09=09pid =3D &driver->pci_driver.id_table[i];
=20
 =09=09pdev =3D NULL;
 =09=09/* pass back in pdev to account for multiple identical cards */

------=_Part_9157_9954774.1149009563352--
