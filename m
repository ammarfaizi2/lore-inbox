Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750761AbWBQSCE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750761AbWBQSCE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 13:02:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750755AbWBQSCE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 13:02:04 -0500
Received: from smtp.enter.net ([216.193.128.24]:46861 "EHLO smtp.enter.net")
	by vger.kernel.org with ESMTP id S1750820AbWBQSCC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 13:02:02 -0500
From: "D. Hazelton" <dhazelton@enter.net>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Date: Fri, 17 Feb 2006 15:02:19 -0500
User-Agent: KMail/1.8.1
References: <43EB7BBA.nailIFG412CGY@burner> <200602161742.26419.dhazelton@enter.net> <43F5B686.nail2VCA2A2OF@burner>
In-Reply-To: <43F5B686.nail2VCA2A2OF@burner>
Cc: matthias.andree@gmx.de, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602171502.20268.dhazelton@enter.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 17 February 2006 06:41, you wrote:
> "D. Hazelton" <dhazelton@enter.net> wrote:
> > At this point I, personally, am not aware of any.  However, after a
> > careful review of libscg in preparation for the patch I promised you, I
> > can see that it would be possible for the code to be rewritten so that
> > just the linux section contains the various workarounds that might be
> > needed.
> >
> > With your refusal to even consider doing that I can see where some people
> > get this idea (I myself was under this exact same belief until I began my
> > code review in preparation for the proposed patch).
>
> I am not refusing useful changes but I of course refuse to apply changes
> that will or even may cause problems in the future.

sysfs is in the kernel and I doubt the contents of /sys/block will change any. 
By reading that directory you can find _all_ existing ATA/ATAPI devices as 
well as all existing SCSI devices.

As a useful change I could patch your ATA/ATAPI scanning code in libscg to do 
that - it would certainly clean up the code. Furthermore, as was pointed out 
by Albert Cahalan, Linux does provide b,t,l addresses for ATA/ATAPI devices - 
available from a simple stat of the device node.

With him having checked a quick hack of code I tossed together to check the 
idea I can even provide code to you that proves this point. 

If you are amenable to a patch that does nothing more than fix the ATA/ATAPI 
scanning code on Linux so it functions properly then I will go ahead and 
create such.

> cdrtools and libscg are a serious project and are maintained in a way that
> tries to _plan_ all interfaces in a way that allows to upgrade interfaces
> for at least 10 years without a need for incompatible changes.

Noted. However even if I do create said patch, I'm more than 90% certain you 
won't even take a look at it.

And if you are worried about the future of your code...

Why do you use the autoconf system in such a nonstandard way? It's scripts are 
portable to all POSIX compliant systems. From what I have seen they would 
remove most of the problems you have and would allow for the code to be 
ported to other operating systems even faster.

(Yes, I'm aware of the DOS/Windows case - but I did say all POSIX compliant 
systems, didn't I? Most packages provide prebuilt stuff for compiling for 
DOS/Windows anyway.)
 
> > I am unsure if you refused to provide OS specific workarounds for known
> > bugs in order to keep the code orthogonal,  or if you had another reason.
> > But with the division of the various operating system specific pieces of
> > libscg into seperate source files it doesn't make sense.
>
> I like to have things orthogonal, but it seems that most people in LKML
> do not understand implicit constraints from requiring orthogobality.

This is why I'm asking why you don't include such workarounds. As far as I can 
see all you do in your code is complain about things with somewhat pointless 
warnings and do minimal work to get around the flaws you complain about.

> > Of the two bugs you've reported, one only exists in a deprecated and soon
> > to be removed module. I will try to fix the other one as soon as you can
> > provide me with enough data that I can see exactly what is getting messed
> > up where.
>
> Sorry, the way to access SCSI generic via /dev/hd* is deprecated. If
> ide-scsi ir removed, then a clean and orthogonal way of accessing SCSI in a
> generic way is removed from Linux. If Linux does nto care about
> orthogonality of interfaces, this is a problem of the people who are
> responbile for the related interfaces.

Says you. Since the SCSI system via /dev/hd* was just added in, IIRC, the 2.5 
series kernel - at the same time ide-scsi was deprecated access via SG_IO 
on /dev/hd* is the new method and not deprecated.

I do agree that it would be _easier_ if Linux had tied the ATA/ATAPI transport 
layer into the SCSI bus code for generic SCSI access, but in Linux there is a 
clear distinction that exists because the IDE/ATA/ATAPI drivers can exist on 
the system entirely without the SCSI system even being built.

The reason for this, at least to me, is to allow people building Linux kernels 
for embedded devices to turn off everything that isn't needed.

> > As to you wanting to be able to read the SCSI status byte and the actual
> > size of the completed DMA... Those parts of the kernel are as close to a
> > blackbox to me as any code gets. Perhaps you could provide information or
> > ideas on how it could be managed?
>
> This is another construction side in Linux.
>
> In 1997, I did cleanly write dowen what exact features are missing to allow
> Linux to be used to _develop_ SCSI user space programs. I did even send a
> patch for sg.c to the Linux folks. This patch extends the sg SCSI Generic
> interface in a source AND binary, up AND downwards compatible way.

Okay. I haven't gone through the mailing list archives to look at this patch. 
There are any number of reasons for it being rejected. One of them is that it 
got lost in the traffic on LKML.

>
> My patch did enable sg.c to return more error/status information back to
> the user (e.g. the SCSI status byte) _and_ it defined a way to return DMA
> residual counts to the user. If Linux still does not even have the DMA
> residual count internally available, this is a proof that nobody with
> sufficient SCSI know how is willing to work on the Linux SCSI layer.

I can see how the residual DMA count information might be impossible to get at 
- the Linux memory allocator has been changed quite a bit over the course of 
the past nine years.

However reading the SCSI status byte should still be possible. I have 
absolutely _no_ familiarity with that section of the kernel so I wont even 
attempt to create such a patch but you should be familiar enough with whats 
going on to create said patch.

So, in the end, I have to ask - why don't you create that patch?

DRH
