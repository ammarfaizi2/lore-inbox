Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261481AbUBYTZQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 14:25:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261584AbUBYTZQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 14:25:16 -0500
Received: from as8-6-1.ens.s.bonet.se ([217.215.92.25]:28596 "EHLO
	zoo.weinigel.se") by vger.kernel.org with ESMTP id S261481AbUBYTZD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 14:25:03 -0500
To: Nikita Danilov <Nikita@Namesys.COM>
Cc: root@chaos.analogic.com, Grigor Gatchev <grigor@zadnik.org>,
       Rik van Riel <riel@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: A Layered Kernel: Proposal
References: <Pine.LNX.4.44.0402251647190.17570-100000@lugburz.zadnik.org>
	<Pine.LNX.4.53.0402251023330.9271@chaos>
	<16444.50903.351290.50106@laputa.namesys.com>
From: Christer Weinigel <christer@weinigel.se>
Organization: Weinigel Ingenjorsbyra AB
Date: 25 Feb 2004 20:25:00 +0100
In-Reply-To: <16444.50903.351290.50106@laputa.namesys.com>
Message-ID: <m3ptc3otbn.fsf@zoo.weinigel.se>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nikita Danilov <Nikita@Namesys.COM> writes:

> Richard B. Johnson writes:
> 
> [...]
> 
>  > 
>  > So don't claim that layering does anything useful except
>  > to create jobs. It is a make-work technique that creates
>  > jobs for inadequate or incompetent programmers.
> 
> Interesting that whole notion of layering and separation of concerns was
> invented exactly during the design of "THE" OS kernel. By very competent
> and adequate programmer.
> 
> http://www.cs.utexas.edu/users/EWD/ewd01xx/EWD196.PDF

Just because there's an academic paper written about something doesn't
mean that its right.  For once Richard is partially right, unneccesary
layering can really ruin a system.  Grigor said that in 25 years he
has seen few cases of pretty code performing badly, but look at the
failure of SysV streams, it's a really pretty layering model, but in
practice it turns out to be too slow for most anything useful.  

It's not too uncommon with drivers that breaks just because the actual
hardware won't fit into the model that is exposed via a layer.  For
example, look at the error recovery of the old Linux SCSI code: it's
hard to do proper error recovery, and it is much slower than it needs
to because first the low level driver tries to do error recovery and
later on the higher layers try to do error recovery too.  Multiply a
couple of retries in the SCSI middle layer with another couple of
retries after a timeout a few seconds at the SCSI controller layer and
you have a model where it takes a minute to do figure out that
something is wrong, for something that ought to take just a few
seconds.

Additionally, because of the strict layering it's not always possible
to hand up a meaningful error status from the lower layers to the
higher layers, it gets lost in the middle just because it didn't fit
into the layers model of the world.  It can also mean that it's not
possible to use the intelligent features of a smart SCSI controller
that can do complex error recovery on its own since most layers end up
exposing only the "least common denominator".

In the linux kernel I think that one of the most important things I've
learned from it: middle layers are usually wrong.  Instead of hiding a
device driver behind a middle layer, expose the low level device
driver, but give it a library of common functions to build upon.  That
way the driver is in control all the time and can use all the neat
features of the hardware if it wants to, but for all the common tasks
that have to be done, hand them over to the library.

  /Christer

-- 
"Just how much can I get away with and still go to heaven?"

Freelance consultant specializing in device driver programming for Linux 
Christer Weinigel <christer@weinigel.se>  http://www.weinigel.se
