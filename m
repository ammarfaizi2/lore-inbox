Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311319AbSCVGQ3>; Fri, 22 Mar 2002 01:16:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312692AbSCVGQU>; Fri, 22 Mar 2002 01:16:20 -0500
Received: from ausmtp01.au.ibm.COM ([202.135.136.97]:18900 "EHLO
	ausmtp01.au.ibm.com") by vger.kernel.org with ESMTP
	id <S312689AbSCVGQC> convert rfc822-to-8bit; Fri, 22 Mar 2002 01:16:02 -0500
X-Priority: 1 (High)
Subject: Re: [PATCH] multithreaded coredumps for elf exeecutables
To: mgross@unix-os.sc.intel.com
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), Alan Cox <alan@lxorguk.ukuu.org.uk>,
        asit.k.mallick@intel.com, bharata@linux.ibm.com,
        dan@debian.org (Daniel Jacobowitz), david.p.howell@intel.com,
        hanharat@us.ibm.com, jefreyr@pacbell.net, linux-kernel@vger.kernel.org,
        marcelo@conectiva.com.br, pavel@suse.cz (Pavel Machek),
        Richard_J_Moore/UK/IBM%IBMGB <richardj_moore@uk.ibm.com>,
        "S Vamsikrishna" <"Richard J Moore/UK/IBM%IBMGB"@d23rh902.au.ibm.com>,
        sunil.saxena@intel.com, tachino@jp.fujitsu.com, tony.luck@intel.com,
        vamsi@linux.ibm.com
X-Mailer: Lotus Notes Release 5.0.3 (Intl) 21 March 2000
Message-ID: <OF1F3C9069.75D95567-ON65256B84.001751A9@in.ibm.com>
From: "Suparna Bhattacharya" <bsuparna@in.ibm.com>
Date: Fri, 22 Mar 2002 11:36:29 +0530
X-MIMETrack: Serialize by Router on d23m0062/23/M/IBM(Release 5.0.8 |June 18, 2001) at
 22/03/2002 11:36:20 AM
MIME-Version: 1.0
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


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
                    <mgross@unix-os.sc.       To:     Alan Cox <alan@lxorguk.ukuu.org.uk>   
                    intel.com>                cc:     alan@lxorguk.ukuu.org.uk (Alan Cox),  
                                               dan@debian.org (Daniel Jacobowitz),          
                    03/21/02 08:29 PM          vamsi@linux.ibm.com, pavel@suse.cz (Pavel    
                    Please respond to          Machek), linux-kernel@vger.kernel.org,       
                    mgross                     marcelo@conectiva.com.br,                    
                                               tachino@jp.fujitsu.com, jefreyr@pacbell.net, 
                                               S Vamsikrishna/India/IBM@IBMIN, Richard J    
                                               Moore/UK/IBM@IBMGB, hanharat@us.ibm.com,     
                                               Suparna Bhattacharya/India/IBM@IBMIN,        
                                               bharata@linux.ibm.com,                       
                                               asit.k.mallick@intel.com,                    
                                               david.p.howell@intel.com,                    
                                               tony.luck@intel.com, sunil.saxena@intel.com  
                                              Subject:     Re: [PATCH] multithreaded        
                                               coredumps for elf exeecutables               
                                                                                            
                                                                                            
                                                                                            



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





