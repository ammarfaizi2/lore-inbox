Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261500AbVEYSXi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261500AbVEYSXi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 May 2005 14:23:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261491AbVEYSXi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 May 2005 14:23:38 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:40941 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261521AbVEYSGX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 May 2005 14:06:23 -0400
In-Reply-To: <Xine.LNX.4.44.0505231938340.890-100000@thoron.boston.redhat.com>
To: James Morris <jmorris@redhat.com>
Cc: Emily Ratliff <Emilyr@us.ibm.com>, Kylene J Hall <Kylene@us.ibm.com>,
       linux-kernel@vger.kernel.org, linux-security-module@wirex.com,
       Pavel Machek <pavel@ucw.cz>, Tom Lendacky <Toml@us.ibm.com>,
       Valdis.Kletnieks@vt.edu
MIME-Version: 1.0
Subject: Re: [PATCH 2 of 4] ima: related Makefile compile order change and Readme
X-Mailer: Lotus Notes Release 6.5.3 September 14, 2004
Message-ID: <OF966CFAC9.55AA50BD-ON8525700C.005D1104-8525700C.0063756B@us.ibm.com>
From: Reiner Sailer <sailer@us.ibm.com>
Date: Wed, 25 May 2005 14:06:20 -0400
X-MIMETrack: Serialize by Router on D01ML605/01/M/IBM(Build V70_M4_01112005 Beta 3|January
 11, 2005) at 05/25/2005 14:06:21,
	Serialize complete at 05/25/2005 14:06:21
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Morris <jmorris@redhat.com> wrote on 05/23/2005 07:59:09 PM:

> On Mon, 23 May 2005, Reiner Sailer wrote:
> 
> > > It seems to me that the mechanism is sound... it does what the docs
> > > says. Another questions is "is it usefull"?
> > > 
> > >                         Pavel 
> > > 
> > 
> > We implemented some exemplary IMA-applications. If you like, visit our 

> > project page and check out the references:
> > 
http://www.research.ibm.com/secure_systems_department/projects/tcglinux/
> > There you also find a complete  measurement list and a response of a 
measured 
> > system replying to an authorized remote measurement-list-request.
> 
> How did you retrieve the TPM-aggregate?

We use the general TPM interface and a TPM library that IBM open-sourced 
in the
"early times of TPM". Today, the there is also the TrouSerS open-source 
(sorceforge)
stack that can be used to retrieve a quote. Other libraries are certainly
available as well. Any implementation offering TPM-Spec quote function can 
be used.

> I'm still not sure why exporting just the kernel measurement values via 
> proc is useful.

It is useful in practice because once the system is up and running, the
measurement list grows very slowly. Thus, retrieving the measurements 
separately from the signature did not result in sync problems 
(measurements
being added between retrieving the signature and retrieving the 
measurement
list). We did not have a single case where we run into the problem but one 
can
construct system loads that might trigger an async between the retrievals. 
In this 
case, one can adjust the measurement list (skip entries added after the 
TPM signature
was created) if you first retrieve the TPM signature and then the 
measurement list.
You'll discover the last signed measurement entries by recalculating the 
signed 
aggregate.

> Wouldn't you need to retrieve the measurement list atomically with the 
> TPM-aggregate?

You can do this atomically but then you need to implement the quote 
functionality
in the kernel when retrieving the list or you need to develop a quote* TPM 
command 
that includes the measurement list with the signature blob (non-TPM-spec 
conform). 
We chose to go with the original Quote (TPM signature) and keep the 
defined TPM 
interface, since we preferred keeping existing interfaces until we 
encounter problems.

> In which case, we'd need an interface which takes a nonce and returns 
the
> kernel measurement list and the TPM-aggregate together.

> Is the source of your example IMA attestation application available?

This application is not available at this time. However, its major 
building blocks
are almost all open-source (TSS stack, TPM kernel driver, IMA). The rest 
is mainly
communication infrastructure and building SHA1-databases to compare 
measurements 
against expected and known measurements.

> 
> - James
> -- 
> James Morris
> <jmorris@redhat.com>
> 
> 
> 

The point you are making is a good one. We implemented a trade-off and if 
users of
IMA suggest that the trade-off towards compatibility is leading to 
problems, it is 
worth to re-evaluate this trade-off and create an atomic function.

Thanks.
Reiner
