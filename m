Return-Path: <linux-kernel-owner+w=401wt.eu-S1759218AbWLIGxb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759218AbWLIGxb (ORCPT <rfc822;w@1wt.eu>);
	Sat, 9 Dec 2006 01:53:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759225AbWLIGxb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Dec 2006 01:53:31 -0500
Received: from smtp108.sbc.mail.mud.yahoo.com ([68.142.198.207]:44527 "HELO
	smtp108.sbc.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1759218AbWLIGxa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Dec 2006 01:53:30 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:X-YMail-OSG:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=ARu5pkq2JJWryRPg2KZjfgYCw+gifXtbZaCsBXZID9UEwxp/RzrNOg8Oj4w4rzAMiD+pnjVhYda05lsgGGzS+Q83NF/bSypEGPZyg3QpHageqxIRtZT/PpltSFtOLdonXGT8trTsHZSt7HVxS6j5GqkVgXNd3LB3uF0Ql6yKyjk=  ;
X-YMail-OSG: o5h6aYYVM1nGq7zo2PXz2PWqG1AKfzPCLNq8kKHpfhcVs7LwIuOQ.PZSxlTLGQrCGxCEC_fq8xNhcvDAQwJNoDf2FpmBN7qQrHtLlFKELi4uh32gpuPqM.zrsUtIahp3x7qprYP4dOxBv3PJjQiqS0JNeW6k.UdjHWvdNybaM1VmuJJE21c5eOUkgS9F
From: David Brownell <david-b@pacbell.net>
To: "Marco d'Itri" <md@Linux.IT>
Subject: Re: [patch 2.6.19-rc6] fix hotplug for legacy platform drivers
Date: Fri, 8 Dec 2006 22:03:37 -0800
User-Agent: KMail/1.7.1
Cc: Greg KH <gregkh@suse.de>, Kay Sievers <kay.sievers@vrfy.org>,
       linux-kernel@vger.kernel.org
References: <20061122135948.GA7888@bongo.bofh.it> <200612051603.09649.david-b@pacbell.net> <20061206235621.GB25272@bongo.bofh.it>
In-Reply-To: <20061206235621.GB25272@bongo.bofh.it>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612082203.38799.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 06 December 2006 3:56 pm, Marco d'Itri wrote:
> On Dec 06, David Brownell <david-b@pacbell.net> wrote:
> 
> > > Please explain in more details how hotplugging would be broken, possibly
> > > with examples.
> >
> > First, for reference, I refer to hotplugging using the trivial ASH scripts
> > from [1], updated by removing no-longer-needed special cases for platform_bus
> > (that original logic didn't work sometimes) and pcmcia.  See the (short)
>
> I.e. a quick hack which has never been used by any distribution.

Not a "quick hack" at all; boiling down hotplug + coldplug to something
that tight got a fair degree of thought back then.  It takes work to get
things to be small enough to use on very small Linux-based systems.

As for "never been used" ... you can't know that, given that embedded
distros are normally custom built.  I'm certain that I submitted it to
buildroot back then.  So a lot of folk building custom distros have had
access to that, and I'd be surprised if it was "never" used.


> And anyway some kernel component is supposed to provide the aliases
> pointing from the $MODALIAS values to the drivers, so modprobe $MODALIAS
> would still work.

A driver named "foo" is usually named "foo.ko"; aliases not needed, or
even desirable.  The kernel source tree has done that for years.


> > Second, note that you're asking me to construct a straw man for you and
> > then break it down, since nobody arguing with the $SUBJECT patch has ever
> > provided a complete counter-proposal (much less respond to the points
> > I've made about legacy driver bugginess -- which is suggestive).
>
> I am asking what is the point for a module to provide its own name in
> $MODALIAS.

As I pointed out previously, more than once:  it's providing a driver
identifier there, all it needs is to be understood by "modprobe".


> $MODALIAS is available only *after* the module has been loaded by
> something else.

You seem like you're being intentionally dense here ... that's rarely
true, which is what makes hotplug-driven driver loading work.

The $MODALIAS thing is passed to userspace after creation of driver
model device nodes.  (Contrary to what you said above.  It's related
to add_device calls, not module loading.)

Normal driver modules do not create those nodes ... and $MODALIAS is used
as a driver identifier so that /sbin/hotplug can "modprobe $MODALIAS" to
load the right driver module.

But *legacy* driver modules are not well behaved; they create those nodes
themselves, rather than letting bus infrastructure do so.  Which is why
they are not hotpluggable.  The $SUBJECT patch just turns off $MODALIAS
based hotplugging for those ill-mannered drivers.

- Dave

