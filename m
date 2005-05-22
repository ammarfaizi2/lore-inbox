Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261724AbVEWAYW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261724AbVEWAYW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 May 2005 20:24:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261825AbVEWAYV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 May 2005 20:24:21 -0400
Received: from igw2.watson.ibm.com ([129.34.20.6]:43156 "EHLO
	igw2.watson.ibm.com") by vger.kernel.org with ESMTP id S261739AbVEVX7y
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 May 2005 19:59:54 -0400
Date: Sun, 22 May 2005 19:59:55 -0400 (Eastern Daylight Time)
From: Reiner Sailer <sailer@us.ibm.com>
To: Pavel Machek <pavel@ucw.cz>
cc: linux-kernel@vger.kernel.org, linux-security-module@mail.wirex.com,
       Kylene@us.ibm.com, Emilyr@us.ibm.com, Toml@us.ibm.com
Subject: Re: [PATCH 2 of 4] ima: related Makefile compile order change and
 Readme
Message-ID: <Pine.WNT.4.63.0505221821520.4896@laptop>
X-Warning: UNAuthenticated Sender
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@ucw.cz> wrote on 05/22/2005 03:37:17 PM:

> Hi!
> 
> > +Limitations: IMA does not detect corruption of software once it is
> > +loaded into main memory. Instead, it indicates known vulnerabilities
> > +in such software (e.g., buffer overflow) by securely identifying the
> > +software at load-time. Only executable files (binaries, libraries,
> > +kernel modules) are measured by default. However, IMA offers a
> > +sysfs-interface that allows applications to instruct the kernel to
> > +measure files that they have opened.
> 
> What is it good for, then? So I have to put my backdoor into script,
> not into an executable...

Scripts can be measured as well (from the user space).
 
For example, equipping the bash shell with 5-10 lines of code, bash 
initiates IMA measurements on scripts and files that are sourced into bash before 
they are "executed" by bash. This way, startup scripts and executed scripts can 
be logged as measurements and the measuremnt list will include them. 

> > +Some of our work shows that IMA is very useful to detect Rootkit
> > +exploits that totally take over the software of a Linux system but
> > +cannot hide themselves from contributing to the TPM aggregate and this
> > +will be detectable from a non-corrupted platform. While the corrupted
> > +system might not show the Rootkit, a remote party can securely
> > +identify known bad or unknown software having been loaded into the
> > +system.
> 
> How does it work? It is corrupted software, not your TPM chip that is
> talking over network.... Do you sign the measurements inside TPM chip?
> 
>                         Pavel

We sign the _integrity_value_ of the measurements inside the TPM.

TPMs offer signing of their so-called Platform Configuration 
Registers (PCR) inside the TPM (Quote). IMA uses one of these PCRs (kernel 
configuration option) to maintains an integrity value over the 
kernel-held measurement list. Whenever a new measurement is added, we 
also adjust the TPM PCR holding the integrity value (that's why we call 
it also a measurement aggregate).

You retrieve not only the measurement list from a system (kernel) but also 
a signature over the TPM PCR holding the integrity value. Nonces 
(random numbers) are used to protect against replay of old signed TPM PCR 
contents by the kernel. Since PCR is signed inside the TPM together with 
the nonce, corrupt system software can't cheat unnoticedly.

IMA implements the measurment hooks and maintains the measurement list 
and its integrity value in the TPM PCR. Services retrieving and evaluating 
measurement lists can be based on top of IMA.

Thanks
Reiner

