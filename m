Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313364AbSC2Fqc>; Fri, 29 Mar 2002 00:46:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313361AbSC2FqM>; Fri, 29 Mar 2002 00:46:12 -0500
Received: from mta7.pltn13.pbi.net ([64.164.98.8]:37068 "EHLO
	mta7.pltn13.pbi.net") by vger.kernel.org with ESMTP
	id <S313359AbSC2FqC>; Fri, 29 Mar 2002 00:46:02 -0500
Date: Thu, 28 Mar 2002 21:43:39 -0800
From: Jeff Jenkins <jefreyr@pacbell.net>
Subject: RE: [PATCH] multithreaded coredumps for elf exeecutables
In-Reply-To: <OF1F3C9069.75D95567-ON65256B84.001751A9@in.ibm.com>
To: Suparna Bhattacharya <bsuparna@in.ibm.com>, mgross@unix-os.sc.intel.com
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        asit.k.mallick@intel.com, bharata@linux.ibm.com,
        Daniel Jacobowitz <dan@debian.org>, david.p.howell@intel.com,
        hanharat@us.ibm.com, linux-kernel@vger.kernel.org,
        marcelo@conectiva.com.br, Pavel Machek <pavel@suse.cz>,
        Richard_J_Moore/UK/IBM%IBMGB <richardj_moore@uk.ibm.com>,
        S Vamsikrishna <"Richard J Moore/UK/IBM%IBMGB"@d23rh902.au.ibm.com>,
        sunil.saxena@intel.com, tachino@jp.fujitsu.com, tony.luck@intel.com,
        vamsi@linux.ibm.com
Message-id: <HFEPKLGPJDEHEGCKLKCCIEIJCFAA.jefreyr@pacbell.net>
MIME-version: 1.0
X-MIMEOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 8BIT
Importance: Normal
X-Priority: 3 (Normal)
X-MSMail-priority: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

So, after all this discussion, is there a set of source that I can use to
build a kernel that will
dump ALL threads to a core file?

I recall that Vamsi initially send out the diffs that were to be used as a
patch.  This sparked the issue raised by Daniel.

Vamsi:  do you have a set of patches that differ than the original patch you
sent?

Thanks!

-- jrj

-----Original Message-----
From: Suparna Bhattacharya [mailto:bsuparna@in.ibm.com]
Sent: Thursday, March 21, 2002 10:06 PM
To: mgross@unix-os.sc.intel.com
Cc: Alan Cox; Alan Cox; asit.k.mallick@intel.com; bharata@linux.ibm.com;
Daniel Jacobowitz; david.p.howell@intel.com; hanharat@us.ibm.com;
jefreyr@pacbell.net; linux-kernel@vger.kernel.org;
marcelo@conectiva.com.br; Pavel Machek; Richard_J_Moore/UK/IBM%IBMGB; S
Vamsikrishna; sunil.saxena@intel.com; tachino@jp.fujitsu.com;
tony.luck@intel.com; vamsi@linux.ibm.com
Subject: Re: [PATCH] multithreaded coredumps for elf exeecutables
Importance: High



IIRC there was an observation that spin_lock_irq seems to first disable
interrupts and then start spinning on the lock, which is why such a
situation could arise (even though the code in schedule doesn't appear to
explicitly disable interrupts).

However, in Mark's implementation, its only the first IPI that happens
under the runqueue lock, and that actually doesn't wait for the other CPUs
to receive the IPI. (The purpose of the first IPI was more a matter of
trying to improve accuracy by notifying the other threads as soon as
possible). So there shouldn't be a deadlock. The synchronization/wait
happens in the case of the second IPI (i.e. the smp_call_function), and by
that time the runqueue lock has been released, and cpus_allowed has been
updated.

Regards
Suparna

  Suparna Bhattacharya
  Linux Technology Center
  IBM Software Lab, India
  E-mail : bsuparna@in.ibm.com
  Phone :  91-80-5044961




                    Mark Gross
                    <mgross@unix-os.sc.       To:     Alan Cox
<alan@lxorguk.ukuu.org.uk>
                    intel.com>                cc:
alan@lxorguk.ukuu.org.uk (Alan Cox),
                                               dan@debian.org (Daniel
Jacobowitz),
                    03/21/02 08:29 PM          vamsi@linux.ibm.com,
pavel@suse.cz (Pavel
                    Please respond to          Machek),
linux-kernel@vger.kernel.org,
                    mgross                     marcelo@conectiva.com.br,
                                               tachino@jp.fujitsu.com,
jefreyr@pacbell.net,
                                               S
Vamsikrishna/India/IBM@IBMIN, Richard J
                                               Moore/UK/IBM@IBMGB,
hanharat@us.ibm.com,
                                               Suparna
Bhattacharya/India/IBM@IBMIN,
                                               bharata@linux.ibm.com,
                                               asit.k.mallick@intel.com,
                                               david.p.howell@intel.com,
                                               tony.luck@intel.com,
sunil.saxena@intel.com
                                              Subject:     Re: [PATCH]
multithreaded
                                               coredumps for elf
exeecutables






On Thursday 21 March 2002 12:34 pm, Alan Cox wrote:
> > This why I grabbed all those locks, and did the two sets of IPI's in
the
> > tcore patch.  Once the runqueue lock is grabbed, even if that process
on
> > the
>
> If you IPI holding a lock whats going to happen if while the IPI is going
> across the cpus the other processor tries to grab the runqueue lock and
> is spinning on it with interrupts off ?

Then the at least 2 CPU's would quickly become dead locked on the
synchronization IPI this patch sends at the end of the
suspend_other_threads
function call.

Interrupts shouldn't be turned off when grabbing the runqueue lock.  Its
also
a bad thing if they would happen to be off while calling into to schedule.


I think schedule was designed to be called only while interrupts are turned

on.  It BUG's if "in_interrupt" to enforce this.

--mgross





