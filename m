Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271439AbRHOUz5>; Wed, 15 Aug 2001 16:55:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271438AbRHOUzh>; Wed, 15 Aug 2001 16:55:37 -0400
Received: from zero.tech9.net ([209.61.188.187]:63754 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S271439AbRHOUzZ>;
	Wed, 15 Aug 2001 16:55:25 -0400
Subject: Re: /dev/random in 2.4.6
From: Robert Love <rml@tech9.net>
To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Cc: Steve Hill <steve@navaho.co.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <125898493.997907155@[169.254.45.213]>
In-Reply-To: <Pine.LNX.4.21.0108151605180.2107-100000@sorbus.navaho> 
	<125898493.997907155@[169.254.45.213]>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.12.99 (Preview Release)
Date: 15 Aug 2001 16:55:53 -0400
Message-Id: <997908956.733.102.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 15 Aug 2001 20:25:56 +0100, Alex Bligh - linux-kernel wrote:
> I'd prefer a single /proc/ entry to turn entropy on from ALL network
> devices for precisely the reason you state (SCSI means no IDE
> entity either), even if its off by default for ALL network
> devices for paranoia reasons, but there seems to be some religious
> issue at play which means the state currently depends on which
> brand of network card you have.

This is a _very_ good idea and one I suspect most people won't find
fault with.

Personally, I want entropy gathering enabled for my network devices.
While I disagree that there is any chance in hell that a remote intruder
can influence the entropy pool in a manner where the returned hash is
able to be determined, I understand some people don't want entropy
gathering enabled on their NICs.

There are two approaches to this.  Neither idea would be too hard.

Method one, your idea, would have us add SA_SAMPLE_NET_RANDOM to each
NIC's request_irq call.  The random gatherer would then need to be made
aware of the sysctl and check and add/remove interripts derived from
NICs as needed.  This would require a bit of recoding (take a look at
request_irq and random.c)

Note we can't do the check once in request_irq because this is only
called once.  Anything loaded before the sysctl was set would be out of
luck (note this is anything not a module).  Additionally, we wouldn't be
able to change the sysctl on the fly and have the NICs start/stop adding
entropy.

An easier, although less robust idea (although one I like) is a
configure statement "Gather entropy using Network Devices".  Then we add
SA_SAMPLE_NET_RANDOM to each NIC's request_irq flags and define it like
this:

#ifdef CONFIG_USE_NET_ENTRY
#define SA_SAMPLE_NET_RANDOM SA_SAMPLE_RANDOM
#else
#define SA_SAMPLE_NET_RANDOM 0
#endif

and voila.  No extra code after compile, everyone can choose, and who
would complain?  Those who want the entropy, will get it.

-- 
Robert M. Love
rml at ufl.edu
rml at tech9.net

