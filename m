Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261965AbUAWNzP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 08:55:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266559AbUAWNzP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 08:55:15 -0500
Received: from delerium.codemonkey.org.uk ([81.187.208.145]:16297 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S261965AbUAWNzJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 08:55:09 -0500
Date: Fri, 23 Jan 2004 13:53:44 +0000
From: Dave Jones <davej@redhat.com>
To: John Levon <levon@movementarian.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: logic error in radeonfb.
Message-ID: <20040123135343.GI9327@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	John Levon <levon@movementarian.org>,
	Linux Kernel list <linux-kernel@vger.kernel.org>
References: <E1Ajuub-0000xr-00@hardwired> <1074840394.949.200.camel@gaston> <20040123065410.GF9327@redhat.com> <20040123112444.GB81582@compsoc.man.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040123112444.GB81582@compsoc.man.ac.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 23, 2004 at 11:24:44AM +0000, John Levon wrote:

 > > Back then someone came up with a cool one-liner that grepped for
 > > suspicious if's with !'s, it seems no-one ever did the same for 2.6,
 > > as there were a few others (see seperate mails for patches).
 > 
 > Actually I did make a one-liner for 2.6, and found rather a lot (15 or
 > so if I remember correctly). I also went as far as hacking up something
 > in gcc, but it was too flaky to go in and I haven't got round to fixing
 > it up yet.
 > 
 > Some of them were right under our noses for ages:
 > http://linus.bkbits.net:8080/linux-2.5/user=levon/patch@1.889.272.4?nav=!-|index.html|stats|!+|index.html|ChangeSet|cset@1.889.272.4
 > If you like I can see if I can dig up the gcc patch or the one-liner.

Yep, that's where I got the idea for this (seems no-one did the
same for the 2.6 tree). Here's the one-liner..
 
find ${1:-.} -name "*.c"    -type f | xargs grep -En '![a-zA-Z0-9_ ]+(\|[^|]|\&[^&])|([^|]\||[^&]\&) *!' | grep -v SCCS

As well as the misplaced brackets, it also catches if (foo & bar) where && was
probably intended (ditto | instead of ||).
It does miss some cases though. Whereas this..

find ${1:-.} -name "*.c"    -type f | xargs grep -En 'if[\ ]\(' | grep -v SCCS | grep \)[\ ]\[\|\&][\ ]  

turns up a few more, but also a lot more false positives.

And if you think the number of bugs it turned up in the kernel is
unfunny, you should see the results when you run it on a source tree
of an unpacked distro. It's Un-be-lievable how common this problem is.
It's not every week you get to do patches to ~80 projects in 3 days 8-)

I tried coming up with some regexps for other 'stupid errors',
things like
	if (foo);
		bar 

or the likes, I got 1-2 real hits out of zillions of lines of code
as opposed to the few dozen misplaced brackets and '|' instead of '||'

Fun.

		Dave

