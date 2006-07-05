Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964928AbWGERjw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964928AbWGERjw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 13:39:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964930AbWGERjw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 13:39:52 -0400
Received: from web50103.mail.yahoo.com ([206.190.38.31]:24913 "HELO
	web50103.mail.yahoo.com") by vger.kernel.org with SMTP
	id S964928AbWGERjv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 13:39:51 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=W0XcUVtUoAoo0jKxc/NFJLltKnr6USwqx4tMZsIatyYR2f2evHq0FKx/BDCgIPJoRVAfUIFdVUlrhdvZmWDYphH8mVYwZAPa5lq5uEYYs/HnPocuJbLG+ck8bJdvuPERL8FNNBwA2tDisLLvnn/oaz1QwS+OYu6g2oI5/hN/VhM=  ;
Message-ID: <20060705173950.5349.qmail@web50103.mail.yahoo.com>
Date: Wed, 5 Jul 2006 10:39:50 -0700 (PDT)
From: Doug Thompson <norsk5@yahoo.com>
Subject: Re: + edac-new-opteron-athlon64-memory-controller-driver.patch added to -mm tree
To: Andi Kleen <ak@muc.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Doug Thompson <norsk5@yahoo.com>, akpm@osdl.org,
       mm-commits@vger.kernel.org, norsk5@xmission.com,
       linux-kernel@vger.kernel.org, eric biederman <ebiederman@lnxi.com>
In-Reply-To: <20060704092358.GA13805@muc.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Andi Kleen <ak@muc.de> wrote:

> [moving to l-k - the discussion is how EDAC tries
> to duplicate already existing interface including
> a whole new duplicate polling machine check handler]
> 
> On Mon, Jul 03, 2006 at 10:28:34PM +0100, Alan Cox wrote:
> > Ar Llu, 2006-07-03 am 20:48 +0200, ysgrifennodd Andi Kleen:
> > > The only way to get the slot name <-> address mapping is 
> > > to ask the BIOS.
> > > 
> > > I bet you hardcoded it for your systems right?
> > 
> > Why don't you read the code ? Wouldn't be hard to check now would
> it.
> 
> I'm pretty sure I'm right from the code, but I was asking for
> confirmation.

The code provides for setting the DIMM labels from userspace (the
mechanism) which can utilize DMI tables or explicit motherboard label
implementation. See below on trustworthiness of DMI tables.

> 
> Ok hardcoding was perhaps the wrong word, but what they output
> isn't useful to identify the broken DIMM if you don't have very
> detailed 
> documentation of the motherboards which 99+% of all users don't.

Without correct DMI tables, this is true - it does require motherboard
information. But if there are DMI tables, then the labels can be
generated from DMI tables.  We have notices too that the 'labels' found
in the DMI tables do NOT match the silkscreens located on the
motherboards proper. 

> 
> > 
> > > Can you describe in more detail why you think that's not the
> case?
> > 
> > I did that, you said "buzzwords" insulted me and deleted the
> argument
> > then started this second discussion as if it never occurred. Not
> > productive.
> 
> It was refering to Doug's assertation that the memory address
> is not enough to identify the DIMM.
> 
> I bet it was only because they didn't use the SMBIOS information,
> but again I was asking for confirmation.

EDAC does NOT use the SMBIOS information. It provides userland
interface for setting/getting DIMM labels.

75% plus of our systems ship with LinuxBIOS. The rest with factory BIOS
for various reasons. LinuxBIOS has NO DMI/SMBIOS information available
for searching.

Our LinuxBIOS engineers have found that the majority of the DMI/SMBIOS
tables are incorrect and provide a false sense of security in terms of
getting the right information that is needed in finding failing devices
(DIMMs).

In Bluesmoke, which is the nursery of EDAC, it utilizes a mechanism to
set/get a CSROW/CHANNEL DIMM with a label from userspace. In the
generic case, the userland script "can" parse the DMI tables if they
are there and the user wishes to perform such automatic labeling. An
override allows the explicit specification of vendor/model of
motherboard. It does use a file based database for lookup - but that is
simply an implementation.

Using the same Bluesmoke 'pattern' of setter/getter DIMM labeler, EDAC
is providing the mechanism of labeling the DIMMs. Where that label
information comes from is pushed to userland: the implementations can
be expanded to use DMI tables if desired (dmidecode based script), or
an explicit labeling script. Currently, the EDAC scripts are not
written, as they are awaiting final sysfs interface. But the pattern is
the same as the working bluesmoke scripts. And they can be added to
with more policy.

Our users demand 100% correct DIMM labeling for error fault isolation,
with minimal manual operation - that is the requirement we are trying
to satisfy. These items are what lead to the Bluesmoke/EDAC labeling
solution pattern.

doug thompson

> 
> Regarding your buzzwords: I don't think mcelog is in any way
> less "manageable" or "consistent" than EDAC.
> 
> 
> > > Hmm, i haven't checked, but my understanding was that the newer
> > > Intel chipsets all forwarded the memory errors as machine 
> > > check anyways.
> > 
> > Quite a few still in use do not. We also have no idea where the
> future
> 
> New ones?  Would surprise me.
> 
> Yes the machine check architecture doesn't try to handle all old
> systems,
> but then in practice error reporting on old x86 systems doesn't tend
> to work particularly well either.
> 
> > 
> > > I also don't think it's very fortunate to put all the complicated
> > > decoding code into kernel space. It works just fine in user
> space.
> > > Can you explain what value add it gives over machine checks in
> > > modern systems?
> > 
> > See my original email, it provides consistency and means that we
> have
> > the same interface for different setups. That is very important
> just
> > like not having "reiser4_open()" "ext3_open" and the like is.
> 
> mce code also uses a consistent interface - it's even the same
> code in kernel space for all systems.
> 
> 
> > It's also zero cost to people who don't chose to use the EDAC
> interface.
> > The alternative is that every single monitoring and hardware
> management
> > tool for Linux has to have its own set of glue interfaces for all
> the
> > different processor and chip specific details.
> 
> At least for machine checks the mce interface is a single interface.
> 
> We don't have a generic interface for logging some of the other
> errors
> (like PCI-E errors), but I don't see EDAC solving that. In some ways
> it's understandable because there is no generic PCI-E error handling
> code at all yet.
> 
> > 
> > > > Sorry about that. I saved your email, but at that time got
> overwhelmed
> > > > in other matters and just recently got back into EDAC. I
> apologize for
> > > > not responding sooner.
> > > 
> > > Well you wasted a lot of time then redoing what's already done.
> > 
> > The ecc code predates the MCE bits by years. The re-doing occurred
> > rather earlier. Rather more useful would be to get the common
> interface
> 
> Earlier than the x86-64 machine check code?
> 
> > provided by things like EDAC provided by the fairly CPU specific
> mce
> > code for the newer chips with a clean interface between the two and
> the
> > minimum of duplicated code.
> 
> You could convert the EDAC drivers to log pseudo events with
> mce_log() like Intel
> thermal, AMD ecc threshold do. All the heavy decoding should be in
> user space
> in mcelog.
> 
> Giving a consistent sysfs interface is a bit harder, but I suppose
> one 
> could change the code to provide pseudo banks for enable/disable too.
> However that would be system specific again, so a default "all on/all
> off" 
> policy might be quite ok.
> 
> -Andi
> 




