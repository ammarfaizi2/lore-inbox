Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751783AbWD1SVT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751783AbWD1SVT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 14:21:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751790AbWD1SVT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 14:21:19 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:58294 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751783AbWD1SVS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 14:21:18 -0400
Message-ID: <44525CE5.3060800@engr.sgi.com>
Date: Fri, 28 Apr 2006 11:20:21 -0700
From: Jay Lan <jlan@engr.sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050921
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: balbir@in.ibm.com
CC: Shailabh Nagar <nagar@watson.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       LSE <lse-tech@lists.sourceforge.net>
Subject: Re: [Lse-tech] Re: [Patch 5/8] taskstats interface
References: <444991EF.3080708@watson.ibm.com> <444996FB.8000103@watson.ibm.com> <44501A97.2060104@engr.sgi.com> <445041EB.7080205@watson.ibm.com> <20060427064237.GA14496@in.ibm.com> <445104DC.90401@engr.sgi.com> <20060427182719.GC14496@in.ibm.com> <44511CCF.1080504@engr.sgi.com> <20060428025927.GD14496@in.ibm.com>
In-Reply-To: <20060428025927.GD14496@in.ibm.com>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Balbir Singh wrote:
>>If we envision a need of it in the future, we'd better put it in
>>today. It would be nice to have the revision number at beginning of
>>the struct. Shailabh's instruction says to add new field after existing
>>fields.
>>
>>    
>
>Yes, true. It does not hurt to have a version number for taskstats.
>I will add it in.
>
><snip>
> 
>  
>>I am sorry that i did not make myself clear. My suggestion of using
>>the bitmask payload info is to be combined with #ifdef CONFIG_* to
>>eliminate unnecessary fields from the traffic. I am concerned about
>>losing data due to application not reading data fast enough.
>>
>>Well, we can revisit this suggestion when we start losing data
>>though. ;-)
>>    
>
>Like Shailabh said #ifdef CONFIG_* adds complexity for userspace parsing
>of the structure, but if it helps avoid sending unnecessary data we
>can consider using that approach. 
>
>Would something like the structure below be useful?
>
>struct csastats {
>#if defined(CONFIG_CSA) || defined(CONFIG_CSA_MODULE)
>       char    acctent[sizeof(struct acctcsa) +
>                       sizeof(struct acctmem) +
>                       sizeof(struct acctio)];
>       int     filled;
>#endif
>};
>
>The filled member can be a bool or an int to indicate that the structure
>contains meaningful data and the CONFIG_* is used to control the
>inclusion of meaningful fields. Instead of using a bitmap we use
>the filled member.
>
>Is this what you had in mind?
>  
No exactly. The payload information must be always available for
application.

On a second thought, the idea of one big taskstats struct with many
#ifconfig is not really a good idea. My goal is to cut down unnecessary
data being transfered throught the socket.

Here is my Take 2. We can have a  taskstats header containing taskstats
version and other general fields useful to more than one taskstats
application including a payload information. Then, we define
accounting subsystem specific structs for delayacct, csa, etc.
The kernel/{delayacct.c,csa.c,etc.c} set the payload information and
fill the buffer with desired subsystem structs. The header thus contain
enough information to tell  applications how to map the data following
the header.

Would IBM propose more accounting subsystems besides delayacct?
If we only see delayacct and csa on the horizon, this scheme is really
not necessary since delayacct does not have as much data (as csa :))
and csa can use part of the delayacct data. You gain more than
csa can benefit from this. ;-) I guess i just speak from design point
of view. :)

But, if one day somebody who does not need a paycheck decides
to convert BSD accounting to use taskstats interface, this can
be helpful.

Thanks,
 - jay



