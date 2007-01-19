Return-Path: <linux-kernel-owner+w=401wt.eu-S932856AbXASTey@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932856AbXASTey (ORCPT <rfc822;w@1wt.eu>);
	Fri, 19 Jan 2007 14:34:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932862AbXASTey
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Jan 2007 14:34:54 -0500
Received: from web50115.mail.yahoo.com ([206.190.39.163]:39779 "HELO
	web50115.mail.yahoo.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932856AbXASTey (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Jan 2007 14:34:54 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:Date:From:Subject:To:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=6AfchusKGPV7B8GdubbiYhkTG1N7jaxUH8ajIb8ziQWROIlmAUBNxTVys6rldVSyT/KsBjRtcg3groWddGoojEjNBy4ZYFCpUT0EHTnnOCzj2K3QngC8HnEncpvHR2MFDwWesMYyzdpdMbpGFNR6avufWDy2ZFwDZOosEYvTr14=;
X-YMail-OSG: FDLi1zQVM1mc06xK8ayHnib5DyZfwsLxS3L1T15Xg6brZ7Jeu54q.8mxbnD9muaJR4WVSJoIvsdox_ZrzI2eApM4L2yCCBMWl4ljIE5kbsCH9idK.QcFbuPs2uFMi6wTOWOYkkTN8fxGy3I-
Date: Fri, 19 Jan 2007 11:34:52 -0800 (PST)
From: Doug Thompson <norsk5@yahoo.com>
Subject: Re: EDAC chipkill messages
To: Orion Poplawski <orion@cora.nwra.com>, linux-kernel@vger.kernel.org
In-Reply-To: <45B0F5B7.4080703@cora.nwra.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-ID: <703726.11655.qm@web50115.mail.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- Orion Poplawski <orion@cora.nwra.com> wrote:

> Robert Hancock wrote:
> > Orion Poplawski wrote:
> >> Can someone please explain to me what these mean?
> >>
> >> EDAC k8 MC1: general bus error: participating processor(local node
> 
> >> origin), time-out(no timeout) memory transaction type(generic
> read), 
> >> mem or i/o(mem access), cache level(generic)
> >> EDAC MC1: CE page 0xfbf6f, offset 0x4d0, grain 8, syndrome 0xc8f4,
> row 
> >> 1, channel 0, label "": k8_edac
> >> EDAC MC1: CE - no information available: k8_edac Error Overflow
> set
> >> EDAC k8 MC1: extended error code: ECC chipkill x4 error
> >>
> >> Thanks!
> >>
> > 
> > Sounds like you're having some memory ECC errors.. some Memtest86,
> etc. 
> > runs may be in order. You may be able to figure out from this info
> what 
> > DIMM is having the problem.
> > 
> 
> That was my assumption as well, but was hoping someone could decode
> the 
> above information and point me to the problem chip.  I ran Memtest86 
> overnight but found no problems, but don't know if it needs to run in
> a 
> particular ECC mode.
> 
> This is a dual proc 275 system with 4 1GB DIMMs.  Guessing that MC1
> is 
> the controller on the second CPU.  Would row 1 be the second DIMM?


No that would be the FIRST DIMM, on Channel 0

Each DIMM has 2 ChipSelect Rows (CSROW)

Each csrow covers two channels across, therefore on a 4 socket memory
array, there are CSROWS 0 and 1 on the first DIMM row and CSROWS 2 and
3 on the second DIMM row.

WWWWWWWWW  XXXXXXXXXXX
YYYYYYYYY  ZZZZZZZZZZZ

The W and the Y DIMMs are channel 0
The X and the Z DIMMs are channel 1

csrows 0 and 1 would cross over Y and Z DIMMs
csrows 2 and 3 would cross over W and X DIMMs

The mapping problem occurs in then identifying each of the above goes
to which silk screen labeled sockets on the mobo.

Usually they are labeled:

H0_DIMM2A   H0_DIMM2B
H0_DIMM1A   H0_DIMM1B

where A is channel 0 and B is channel 1 and
the "DIMM1" would indicate the CSROWs 0 and 1
and "DIMM2" would indicate the CSROWs 2 and 3

The string 'label ""' can be filled in by a userspace script to
properly identify the DIMM silk screen according to the motherboard
used.

The lines with "EDAC MC1:" are EDAC CORE output messages, while the
"EDAC K8:" lines are EDAC Memory Controller driver messages.
"CE" is correctable error 
MC1 is memory controller 1 (0 based)

ECC ChipKill x4 was what found the error and corrected it.

The FRU, (field replaceable unit) is the DIMM located at socket
H1_DIMM1A, according to the labeling I mentioned above.

caveat: the detector is not 100% perfect but gives a general area to
look at, the DIMM specification. Sometimes other errors can cause what
looks like a memory error, but usually a bad memory DIMM is the root
cause of the vast majority of such errors.

In addition, memtest86+ doesn't find all the bad memory in all cases,
but it is still a VERY useful tool

doug thompson

