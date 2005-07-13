Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262554AbVGMFbv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262554AbVGMFbv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 01:31:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262563AbVGMFbv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 01:31:51 -0400
Received: from smtp2.oregonstate.edu ([128.193.4.8]:26605 "EHLO
	smtp2.oregonstate.edu") by vger.kernel.org with ESMTP
	id S262554AbVGMFbu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 01:31:50 -0400
Message-ID: <42D4A73E.4060509@engr.orst.edu>
Date: Tue, 12 Jul 2005 22:31:42 -0700
From: Micheal Marineau <marineam@engr.orst.edu>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050525)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][help?] Radeonfb acpi resume
References: <42D19EE1.90809@engr.orst.edu> <1121214768.31924.412.camel@gaston>
In-Reply-To: <1121214768.31924.412.camel@gaston>
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig6F74CC0A0733E2957DA7E16D"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig6F74CC0A0733E2957DA7E16D
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Thanks for the input,

Benjamin Herrenschmidt wrote:
> On Sun, 2005-07-10 at 15:19 -0700, Micheal Marineau wrote:
> 
>>I've been forward porting this patch for a while now and need
>>some input on it. You can see the last time someone posted it
>>to the list here:
>>http://www.ussg.iu.edu/hypermail/linux/kernel/0410.0/0600.html
>>
>>The big issue mentioned in that thread, that it reqires a key
>>press during the resume process to keep going still exists and
>>I have been unable to understand why.  The issue is in radeon_pm.c
>>in this block that follows the last hunk of the diff:
>>
>>        if (rinfo->no_schedule) {
>>                if (try_acquire_console_sem())
>>                        return 0;
>>        } else
>>                acquire_console_sem();
>>
>>Specificly it's acquire_console_sem(); where the resume stops waiting
>>for a key press.  What could be stopping things?
> 
> 
> I don't see any reason for that. That definitely shouldn't happen.
> 
>    .../...

Yea, so it would seem.  Hopefully that'll get fixed magicly once I
clean up the rest a little bit.

> 
> 
>>diff -ru linux-2.6.12.orig/drivers/video/aty/radeon_pm.c
>>linux-2.6.12/drivers/video/aty/radeon_pm.c
>>--- linux-2.6.12.orig/drivers/video/aty/radeon_pm.c	2005-06-17
>>12:48:29.000000000 -0700
>>+++ linux-2.6.12/drivers/video/aty/radeon_pm.c	2005-07-03
>>19:55:36.000000000 -0700
>>@@ -2606,10 +2606,13 @@
>>
>>  done:
>> 	pdev->dev.power.power_state = state;
>>+	pci_save_state (pdev);
>>
>> 	return 0;
>> }
> 
> 
> Hrm... radeonfb already saves the config space elsewhere. Note that it
> could maybe be converted to pci_save_state() / pci_restore_state() but
> currently, I do my own as I use that for "testing" if the card is still
> in it's previous state or was shut down. (I could probably use the
> content of a register instead, like CLK_PIN_CNTL)

Hrm, maybe it works now, but a few kernel versions back something broke
and I added that in as an easy fix.  I'll try taking pci_save/restore out
again, hopefully all is well again.

> 
> 
>>+extern void acpi_vgapost (unsigned long slot);
>>+
>> int radeonfb_pci_resume(struct pci_dev *pdev)
>> {
>>         struct fb_info *info = pci_get_drvdata(pdev);
>>@@ -2619,6 +2622,12 @@
>> 	if (pdev->dev.power.power_state == 0)
>> 		return 0;
>>
>>+	if (pdev->dev.power.power_state != 4)
>>+	{
>>+		pci_restore_state (pdev);
>>+		acpi_vgapost (pdev->devfn);
>>+	}
>>+
>> 	if (rinfo->no_schedule) {
>> 		if (try_acquire_console_sem())
>> 			return 0;
> 
> 
> The above will probably blow up anything that is not an x86 with ACPI.
> Besides there is already a mecanism in that file for calling functions
> for re-posting cards (since I have code to explicitely re-post rv280 and
> rv350 mobility on macs), you should hook into that existing mecanism
> when you detect ACPI.
> 
> Ben.
>  

ok, I haven't looked at the existing code very extensivly, I should check
it out :-)


-- 
Michael Marineau
marineam@engr.orst.edu
Oregon State University


--------------enig6F74CC0A0733E2957DA7E16D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFC1Kc+iP+LossGzjARAqmWAJ9YELF9rmGTmK4I8Ff2ftCNrpLYsQCeOIYK
F+ZfhNDLyRmZrxySq9ZFBSk=
=ZTeq
-----END PGP SIGNATURE-----

--------------enig6F74CC0A0733E2957DA7E16D--
