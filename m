Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261941AbVEWT4q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261941AbVEWT4q (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 May 2005 15:56:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261942AbVEWT4q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 May 2005 15:56:46 -0400
Received: from igw2.watson.ibm.com ([129.34.20.6]:18905 "EHLO
	igw2.watson.ibm.com") by vger.kernel.org with ESMTP id S261941AbVEWT4b
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 May 2005 15:56:31 -0400
Date: Mon, 23 May 2005 15:56:23 -0400 (Eastern Daylight Time)
From: Reiner Sailer <sailer@us.ibm.com>
To: Valdis.Kletnieks@vt.edu
cc: James Morris <jmorris@redhat.com>, sailer@us.ibm.com, Toml@us.ibm.com,
       linux-security-module@wirex.com, linux-kernel@vger.kernel.org,
       Pavel Machek <pavel@ucw.cz>, Emilyr@us.ibm.com, Kylene@us.ibm.com
Subject: Re: [PATCH 2 of 4] ima: related Makefile compile order change and
 Readme
Message-ID: <Pine.WNT.4.63.0505231351590.4028@laptop>
X-Warning: UNAuthenticated Sender
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Valdis.Kletnieks@vt.edu wrote on 05/23/2005 12:52:13 AM:

> On Mon, 23 May 2005 00:30:15 EDT, James Morris said:
> 
> > Perhaps I don't understand things fully, but what is the purpose of 
> > providing measurement values locally via proc?
> > 
> > How can they be trusted without the TPM signing an externally generated 
> > nonce?
> 
> If you can't trust what the kernel is outputting in /proc, you're screwed.

No, this is not the case. You can establish trust into the measurements 
read through /proc by validating the TPM signature over the measurement 
aggregate on a separate, trusted system. IMA measurements are not intended 
to be used on the local system but on a separate system that is trusted not 
to be compromised. The system validating the measurements does not trust 
the origin; the TPM signature is the part that (i) verifies 
the integrity of the measurement list, and (ii) verifies the platform 
where the signature was created and links the validated measurement list 
to this system.

You can think of IMA as a reliable, Hardware-root-of-trust (TPM) 
based logging mechanism for loaded executables. IMA is a usage-example of 
the TPM HW root-of-trust used to gain confidence into what was loaded into 
another system. Since IMA is released opensource (GPL), people can experiment 
with services putting value to the IMA load-time guarantees. We did experiment 
with IMA, and we found it interesting enough to make it available.

> And for that matter, how would you verify that it's the TPM that signed the
> externally generated nonce? (Remember - if you can't trust /proc, then you
> have to assume that *any* attempt at talking to the TPM from userspace *is*
> a MITM attack - and you don't have access to any out-of-band info.  If the
> now-untrusted kernel did a MITM on your nonce and signed it with a fake key,
> then it can *also* MITM your attempt to read the "correct" key from /etc/tpm.key
> or wherever it is....

Your concern would be relevant if measurements were validated on 
the (measured) system that creates them, which is not the intended use.

Verification is based on the public TPM signature key: The remote party 
has a certificate of the public key of the system from which it retrieves 
measurements. If the public key does not 'validate' the TPM signature 
(delivered with a measurement list) then the retrieved  measurement list 
is not trusted. All signature keys used by the TPM are protected when stored 
outside the TPM chip. A system cannot use TPM signature keys outside the TPM
and cannot create valid signatures over manipulated measurement lists.

Man-in-the-middle-attacks on the measurement-list-retrieval are only successful
if the entity controlling the measured system can guess the 160bit random 
number (nonce) that will be used in the future by a remote party
or if a remote party re-uses nonces. In this case, old measurement lists can be 
replayed; this is very unlikely if the nonces / random numbers are chosen as 
directed in the TPM specs.

Thanks
Reiner

