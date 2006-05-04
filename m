Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751465AbWEDJof@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751465AbWEDJof (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 May 2006 05:44:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751467AbWEDJof
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 May 2006 05:44:35 -0400
Received: from dougal.buttersideup.com ([195.200.137.69]:52697 "EHLO
	dougal.buttersideup.com") by vger.kernel.org with ESMTP
	id S1751465AbWEDJoe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 May 2006 05:44:34 -0400
Message-ID: <4459CD45.6090007@buttersideup.com>
Date: Thu, 04 May 2006 10:45:41 +0100
From: Tim Small <tim@buttersideup.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: thockin@hockin.org
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "Ong, Soo Keong" <soo.keong.ong@intel.com>,
       "Gross, Mark" <mark.gross@intel.com>,
       bluesmoke-devel@lists.sourceforge.net,
       LKML <linux-kernel@vger.kernel.org>,
       "Carbonari, Steven" <steven.carbonari@intel.com>,
       "Wang, Zhenyu Z" <zhenyu.z.wang@intel.com>
Subject: Re: Problems with EDAC coexisting with BIOS
References: <C1989F6360C8E94B9645F0E4CF687C08C1E9FB@pgsmsx412.gar.corp.intel.com> <1145888979.29648.56.camel@localhost.localdomain> <4459119D.10905@buttersideup.com> <20060503203740.GA17515@hockin.org>
In-Reply-To: <20060503203740.GA17515@hockin.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

thockin@hockin.org wrote:

>On Wed, May 03, 2006 at 09:25:01PM +0100, Tim Small wrote:
>  
>
>>existing BIOSs, but the EDAC module could reprogram the chipset 
>>error-signalling registers, so that an ECC error no longer triggers an 
>>    
>>
>
>This is key, I think.
>
>  
>
>>SMI.  The BIOS SMI handler could then read the signalling registers, and 
>>leave the ECC registers well alone if ECC errors are not set to generate 
>>an SMI.
>>    
>>
>
>The fundamental problem with SMI is that we CAN'T know what it is doing.
>I've seen systems which trigger SMI from a GPIO toggled by a clock.  I've
>seen systems trigger SMI from a chipset-internal periodic timer.  I've
>seen chipsets route NMI->SMI or even MCE->SMI.  If the BIOS is polling the
>error status registers from a periodic SMI, we're GOING to lose data.
>
>The big hammer - turn off SMI - is probably OK on some systems, but is not
>a general solution.  More and more hardware workarounds and features are
>SMI based.  There are some rather interesting things that can be done in
>SMM, *iff* we could get the BIOS out of the way.
>  
>
Agreed - I have had experience of a system (Intel 855GME chipset based, 
AMI BIOS) which emulates the i8042 in the BIOS at SMI time.  Mmm nice. 
When the Linux i8042 driver can polled the (pretend) i8042, the system 
spent ages in the BIOS, and general interrupt latency on the system fell 
apart...  Oh what a mess.

A limited solution is probably to modify the existing EDAC drivers so 
that they ensure SMI generation is disabled (for the specific errors 
that the EDAC drivers are designed to handle).  The OS is then at least 
doing the right thing, even if the BIOS isn't...  This should improve 
upon the current behaviour on some systems, and shouldn't (as far as I 
can see) break any others.  The EDAC code also probably needs to be 
toughened up (at least on some chipsets) so that it doesn't fall over 
when the BIOS steps on its toes.

Tim.
