Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261672AbVCNSHL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261672AbVCNSHL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 13:07:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261660AbVCNSD2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 13:03:28 -0500
Received: from amdext4.amd.com ([163.181.251.6]:63175 "EHLO amdext4.amd.com")
	by vger.kernel.org with ESMTP id S261680AbVCNR7d convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 12:59:33 -0500
X-Server-Uuid: 5FC0E2DF-CD44-48CD-883A-0ED95B391E89
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: RE: PowerNow-K8 and Winchester CPUs
Date: Mon, 14 Mar 2005 11:59:08 -0600
Message-ID: <84EA05E2CA77634C82730353CBE3A843021DDF8A@SAUSEXMB1.amd.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: PowerNow-K8 and Winchester CPUs
Thread-Index: AcUouell8WPRCLTYQ+2yCXHZFOJLaQABSnYw
From: "Devriendt, Paul" <paul.devriendt@amd.com>
To: "Pavel Machek" <pavel@suse.cz>, "Vojtech Pavlik" <vojtech@suse.cz>
cc: davej@codemonkey.org.uk, linux@brodo.de, linux-kernel@vger.kernel.org,
       "Langsdorf, Mark" <mark.langsdorf@amd.com>
X-WSS-ID: 6E2B0F641Q04395285-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel, 

This is similar to the Sempron patch I put out a while ago -
that was a similar problem. Let Mark and I think about it for
a couple of days. I think there is a better way to fix this.
There are some new fields in the status register in newer
parts to give things like maxvid, and we are not using them
at present. They were added in a manner compatible with the
older parts. I think we may have a better solution to use
the new fields.

Paul.

> -----Original Message-----
> From: Pavel Machek [mailto:pavel@suse.cz] 
> Sent: Monday, March 14, 2005 11:18 AM
> To: Vojtech Pavlik; Devriendt, Paul
> Cc: davej@codemonkey.org.uk; linux@brodo.de; 
> linux-kernel@vger.kernel.org
> Subject: Re: PowerNow-K8 and Winchester CPUs
> 
> Hi!
> 
> Paul, can you comment on this one? I know that pn-k8 logic is quite
> tricky... And BIOS tables are often wrong.
> 								Pavel
> 
> > I have a machine with an Athlon64 with a Winchester core. 
> It has a max
> > frequency of 2GHz, vid 0x6. The maximum vid allowed is 0x4. 
> It has an
> > intermediate vid 0x8. RVO is 3.
> > 
> > When transitioning (phase1) from vid 0x8 to vid 0x6, it 
> first increases
> > the vid to 6, and then proceeds increasing it three more 
> steps. This of
> > course fails, because it overflows the maximum allowed vid 0x4.
> > 
> > My first attempt to fix this was to limit the vid to the 
> max vid while
> > doing the rvo bump-up.
> > 
> > However, I believe that the real reason for the problem is that the
> > condition to start doing the rvo bump is wrong.
> > 
> > This patch should fix it:
> > 
> > diff -Nru a/arch/i386/kernel/cpu/cpufreq/powernow-k8.c 
> b/arch/i386/kernel/cpu/cpufreq/powernow-k8.c
> > --- a/arch/i386/kernel/cpu/cpufreq/powernow-k8.c	
> 2005-03-14 17:20:17 +01:00
> > +++ b/arch/i386/kernel/cpu/cpufreq/powernow-k8.c	
> 2005-03-14 17:20:17 +01:00
> > @@ -286,7 +286,7 @@
> >  			return 1;
> >  	}
> >  
> > -	while ((rvosteps > 0)  && ((data->rvo + data->currvid) 
> > reqvid)) {
> > +	while ((rvosteps > 0) && ((data->currvid - data->rvo) > 
> reqvid)) {
> >  		if (data->currvid == 0) {
> >  			rvosteps = 0;
> >  		} else {
> > 
> > if I understand the original intent of the second test in 
> the while()
> > statement. 
> > 
> > Any comments? Is my understanding of that bit of code correct?
> > 
> 
> -- 
> People were complaining that M$ turns users into beta-testers...
> ...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
> 
> 

