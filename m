Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262182AbVEXVUn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262182AbVEXVUn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 17:20:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262195AbVEXVUn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 17:20:43 -0400
Received: from igw2.watson.ibm.com ([129.34.20.6]:15067 "EHLO
	igw2.watson.ibm.com") by vger.kernel.org with ESMTP id S262193AbVEXVR6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 17:17:58 -0400
Date: Tue, 24 May 2005 17:17:53 -0400 (Eastern Daylight Time)
From: Reiner Sailer <sailer@us.ibm.com>
To: Pavel Machek <pavel@ucw.cz>
cc: Emilyr@us.ibm.com, James Morris <jmorris@redhat.com>, Kylene@us.ibm.com,
       linux-kernel@vger.kernel.org, linux-security-module@wirex.com,
       Toml@us.ibm.com, Valdis.Kletnieks@vt.edu
Subject: Re: [PATCH 2 of 4] ima: related Makefile compile order change and
 Readme
Message-ID: <Pine.WNT.4.63.0505241524170.828@laptop>
X-Warning: UNAuthenticated Sender
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Pavel Machek <pavel@ucw.cz> wrote on 05/24/2005 02:47:52 PM:

> Hi!
> 
> > > * remove all the buffer overflows. I.e. if grub contains buffer
> > >    overflow in parsing menu.conf... that is not a security hole
> > >    (as of now) because only administrator can modify menu.conf.
> > >    With IMA enabled, it would make your certification useless...
> > 
> > Taking your example: Even if you run a buffer-overflow grub, IMA will 
> > enable remote parties to differentiate between systems that run
> > the vulnerable grub and systems that don't. IMA in this case actually
> > can put value to running better software.
> 
> Yes, but see above: that buffer overflow in grub was *not* a
> vulnerability... not until you introduce IMA.
> 
> That is my biggest concern. You are completely changing rules for
> userland code. Buffer overflow that only root could exploit used to be
> okay. It used to be okay to read config files without communicating
> with TPM.
>                         Pavel
> 

I don't follow your argumentation.

Measuring a file is done by new IMA code (hook) that opens the file, 
calculates the SHA1, closes the file, and saves new SHA1 measurements in the 
measurement list. This code must be carefully inspected. The only code 
that a user can trigger through IMA is the IMA kernel code that calculates 
the SHA1 over a file that the user has already opened (requires file 
descriptor).

Can you be more specific about how IMA affects existing buffer overflow 
vulnerabilities in grub or other applications?


Also, grub/grub.conf is not measured by users or the kernel but by the stages 
loading it (see below) according to the  "measure-before-load" principle, 
coined by the Trusted Computing Group.

I shortly summarize the steps involving TPM and measurements when booting 
a system to avoid misunderstandings of "who is measuring what and when":
 
(i) On TPM-enabled systems, the BIOS automatically measures the first 
bootstage (MBR) and some platform configuration parameters (usually 
configurable in the BIOS setup).

(ii) Then tcg-grub (if installed) measures its configuration file and 
later tcg-grub stages. Grub finally measures kernel and initrd before 
booting the kernel. This requires a grub-patch that creates the 
SHA1 measurements and extends TPM PCRs. There are to my knowlege 
opensource versions of grub extensions for tpm support already available 
and there are patches in preparation to be released soon.

(iii) Once started, the kernel part of IMA (the currently submitted ima 
patches) picks up these boot measurements and integrates them as the 
very first measurement into the measurement list and TPM PCR aggregate 
(look for it in the initialization code of the IMA patches submitted).

(iv) From then on, the IMA in the kernel is responsible for measuring 
executables/modules before loading them and for maintaining the 
measurement list and its TPM aggregate. 

(v) Remote parties will validate the boot stages with the very first
measurement, which they receive as part of the measurement list from IMA.

Thanks
Reiner

