Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312393AbSCURIf>; Thu, 21 Mar 2002 12:08:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312394AbSCURI0>; Thu, 21 Mar 2002 12:08:26 -0500
Received: from scfdns02.sc.intel.com ([143.183.152.26]:41419 "EHLO
	crotus.sc.intel.com") by vger.kernel.org with ESMTP
	id <S312393AbSCURIR>; Thu, 21 Mar 2002 12:08:17 -0500
Message-Id: <200203211707.g2LH7XW10116@unix-os.sc.intel.com>
Content-Type: text/plain; charset=US-ASCII
From: Mark Gross <mgross@unix-os.sc.intel.com>
Reply-To: mgross@unix-os.sc.intel.com
Organization: SSG Intel
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, dan@debian.org (Daniel Jacobowitz)
Subject: Re: [PATCH] multithreaded coredumps for elf exeecutables
Date: Thu, 21 Mar 2002 09:10:25 -0500
X-Mailer: KMail [version 1.3.1]
Cc: vamsi@in.ibm.com (Vamsi Krishna S .), pavel@suse.cz (Pavel Machek),
        linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk,
        marcelo@conectiva.com.br, tachino@jp.fujitsu.com, jefreyr@pacbell.net,
        vamsi_krishna@in.ibm.com, richardj_moore@uk.ibm.com,
        hanharat@us.ibm.com, bsuparna@in.ibm.com, bharata@in.ibm.com,
        asit.k.mallick@intel.com, david.p.howell@intel.com,
        tony.luck@intel.com, sunil.saxena@intel.com
In-Reply-To: <E16o5o5-0005gM-00@the-village.bc.nu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 21 March 2002 11:52 am, Alan Cox wrote:
> You need interrupts to handle this, even if you don't wrap it in the top
> layer of signals it will be able to use much of the code I agree. The nasty
> case is the "currently running on another cpu" one. Especially since you
> can't just "trap it" - if you IPI that processor it might have moved by the
> time the IPI arrives 8)

This why I grabbed all those locks, and did the two sets of IPI's in the 
tcore patch.  Once the runqueue lock is grabbed, even if that process on the 
other CPU tries to migrate, it won't get swapped in or looked at by the 
scheduler until its cpus_allowed member has been marked.   After cpus_allowed 
has been marked it won't run. 

I don't think there is any faster way of getting the other CPU's into 
schedule and a specific running process to be swapped out than what was done 
here.

The only risk with this type of code is if other code or drivers attempt 
similar maneuvers at the same time.  Having a standard mechanism or API for 
this in the scheduler would be a "good thing".

--mgross
ps.
I've just started considering how to do this with the 2.5 O(1) scheduler, and 
I'm not sure yet how I can accomplish this process "pausing" behavior just 
yet.
