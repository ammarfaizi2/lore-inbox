Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932144AbWCTSzc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932144AbWCTSzc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 13:55:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932147AbWCTSzb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 13:55:31 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:26343 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S932144AbWCTSza convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 13:55:30 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Peter Wainwright <prw@ceiriog.eclipse.co.uk>
Subject: Re: Announcing crypto suspend
Date: Mon, 20 Mar 2006 19:54:45 +0100
User-Agent: KMail/1.9.1
Cc: Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>
References: <20060320080439.GA4653@elf.ucw.cz> <1142879707.9475.4.camel@localhost.localdomain>
In-Reply-To: <1142879707.9475.4.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200603201954.45572.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 20 March 2006 19:35, Peter Wainwright wrote:
> On Mon, 2006-03-20 at 09:04 +0100, Pavel Machek wrote:
> > Hi!
> > 
> > Thanks to Rafael's great work, we now have working encrypted suspend
> > and resume. You'll need recent -mm kernel, and code from
> > suspend.sf.net. Due to its use of RSA, you'll only need to enter
> > password during resume.
> > 
> > [Code got some minimal review; if you are a crypto expert, and think
> > you can poke a hole within it, please try to do so.]
> > 								Pavel
> Thats pretty interesting - we really need a featureful suspend
> implementation
> in mainline. But there doesn't seem to be much documentation for it.
> suspend.sf.net takes me to the Suspend 2 site: www.suspend2.net (a
> virtual
> server?). Which code from this site is needed for the mainline suspend?

cvs -z3 -d:pserver:anonymous@cvs.sourceforge.net:/cvsroot/suspend co suspend

and please read the HOWTO.  Unfortunately the RSA-related part hasn't been
documented yet, but it's pretty straightforward.

First, you need to generate the RSA key pair using suspend-keygen and save
the output file as /etc/suspend.key (or something else pointed to by
the "RSA key file =" configuration parameter of suspend).  This file contains
the public modulus (n), public exponent (e) and Blowfish-encrypted private
exponent (d) of the RSA key pair.

Then, the suspend utility will load the contents of this file,  generate a random
session key (k) and initialization vector (i) for the image encryption and use
(n, e) to encrypt these values with RSA.  The encrypted k, i as well as the
contents of the RSA key file will be saved in the image header.

The resume utility will read n, e and (encrypted) d as well as (encrypted) k, i
from the image header.  Then it will ask the user for a passphrase and will
try to decrypt d using it.  Next, it will use (n, e, d) to decrypt k, i needed
for decrypting the image.

Greetings,
Rafael
