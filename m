Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261731AbUAAMff (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jan 2004 07:35:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263544AbUAAMff
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jan 2004 07:35:35 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:25522
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S261731AbUAAMf1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jan 2004 07:35:27 -0500
From: Rob Landley <rob@landley.net>
Reply-To: rob@landley.net
To: Rob Love <rml@ximian.com>, Andries Brouwer <aebr@win.tue.nl>
Subject: Re: udev and devfs - The final word
Date: Thu, 1 Jan 2004 06:34:28 -0600
User-Agent: KMail/1.5.4
Cc: Pascal Schmidt <der.eremit@email.de>, linux-kernel@vger.kernel.org,
       Greg KH <greg@kroah.com>
References: <18Cz7-7Ep-7@gated-at.bofh.it> <20040101001549.GA17401@win.tue.nl> <1072917113.11003.34.camel@fur>
In-Reply-To: <1072917113.11003.34.camel@fur>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401010634.28559.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 31 December 2003 18:31, Rob Love wrote:
> On Wed, 2003-12-31 at 19:15, Andries Brouwer wrote:
> > My plan has been to essentially use a hashed disk serial number
> > for this "any old unique value". The problem is that "any old"
> > is easy enough, but "unique" is more difficult.
> > Naming devices is very difficult, but in some important cases,
> > like SCSI or IDE disks, that would work and give a stable name.
>
> Yup.
>
> > The kernel must not invent consecutive numbers - that does not
> > lead to stable names. Setting this up correctly is nontrivial.
>
> This is definitely an interesting problem space.
>
> I agree wrt just inventing consecutive numbers.  If there was a nice way
> to trivially generate a random and unique number from some
> device-inherent information, that would be nice.
>
> 	Rob Love

Fundamental problem: "Unique" depends on the other devices in the system.  You 
can't guarantee unique by looking at one device, more or less by definition.

Combine that with hotplug and you have a world of pain.  Generating a number 
from a device is just a fancy hashing function, but as soon as you have two 
devices that generate the same number independently (when in separate 
systems) and you plug them both into the same system: boom.

Now if you don't care about hotplug, it gets a little easier.  You can have a 
collission handler that does some kind of hashing thing, figuring out which 
device needs to get bumped and bumping it.  (As long as it consistently picks 
the same victim, you're okay, although that in and of itself could get 
interesting.  And if you remove the earlier device it conflicted with and 
reboot, the device could get renumbered which is evil...)

Of course the EASY way to deal with collisions is to just fail the hash thingy 
in a detectable way, and punt to some kind of udev override.  So if you yank 
a drive from system A, throw it in system B, try to re-export it NFS, and 
it's not going to work, it TELLS you.

Solve 90% of the problem space and have a human deal with the exceptions.  How 
big's the unique number being exported, anyway?  (If it's 32 bits, the 
exceptions are 1 in 4 billion.  It may never be seen in the wild...)

Rob

