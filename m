Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264929AbUEYPDN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264929AbUEYPDN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 11:03:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264948AbUEYPDM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 11:03:12 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:17353 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S264929AbUEYPCB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 11:02:01 -0400
Message-ID: <40B35F83.8090901@watson.ibm.com>
Date: Tue, 25 May 2004 11:00:19 -0400
From: Hubertus Franke <frankeh@watson.ibm.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5b) Gecko/20030901 Thunderbird/0.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Peter Williams <peterw@aurema.com>
CC: Rik van Riel <riel@redhat.com>, Shailabh Nagar <nagar@watson.ibm.com>,
       kanderso@redhat.com, Chandra Seetharaman <sekharan@us.ibm.com>,
       limin@sgi.com, jlan@sgi.com, linux-kernel@vger.kernel.org, jh@sgi.com,
       Paul Jackson <pj@sgi.com>, gh@us.ibm.com,
       Erik Jacobson <erikj@subway.americas.sgi.com>, ralf@suse.de,
       lse-tech@lists.sourceforge.net, Vivek Kashyap <kashyapv@us.ibm.com>,
       mason@suse.com
Subject: Re: Minutes from 5/19 CKRM/PAGG discussion
References: <Pine.LNX.4.44.0405241404080.22438-100000@chimarrao.boston.redhat.com> <40B2534E.3040302@watson.ibm.com> <40B288BA.7010905@aurema.com>
In-Reply-To: <40B288BA.7010905@aurema.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Williams wrote:

> Hubertus Franke wrote:
>
>>
>> In our hooking scheme we therefore provide the ability to attach
>> to so called kernel events a callback function. Any kernel code
>> can attach a callback function. This is part of our core.
>>
>> Any classtype (not part of the core) can register a callback at
>> any of those events, so typically only limited
>> events are "hooked" for a particular type. Regardless, we have
>> function stacking, rather then object stacking.
>
>
> I'm assuming that this means several clients can use the same callback 
> simultaneously?

Yes it means exactly that ....

>
>>
>> PAGG by itself manages the proper association of a (or several)
>> "transparent" group object with the task. The functionality
>> hidden behind the group object
>> still needs to be implemented by the group object itself.
>>
>> In CKRM this is similar, yet, the class object is associated with
>> a particular class type. All interactions with the user component
>> and classification engine are architected by the higher layers of CKRM,
>> in that classes have automatic representation in RCFS and RBCE if
>> those are loaded.
>>
>> So here are some of the stickling points, we need to work on ...
>>
>> (a) how can PAGG be made general enough so we can provide generic
>>       KernelObject <-> ClassObject associations .. not just tasks 
>> groups.
>
>
> I would suggest that rather than extending PAGG, separate mechanisms 
> similar in design to PAGG be created for each KernelObject for which 
> such associations are required.  Perhaps the generic component of such 
> mechanisms could be separated out into a generic package and then each 
> specific mechanism just provides the specialization for its 
> KernelObject type.  I'd imagine that the main difference between the 
> specialized packages would be (apart from the different type of 
> KernelObject) in the set of callbacks provided.
>
Yes, and that has been done. Currently we have two such classtype  
(class task and network class) both supplied as independent "modules" 
atop the ckrm core.
And you are right again wrt the difference aspect. Each class registers 
the callbacks its interested in.

>>
>> (b) Can CSA use the extended rbce (CRBCE) instead of PAGG to
>>       do its accounting ?
>
>
> From my (possibly incorrect) understanding of the above description, 
> one thing that PAGG provides to its clients that CKRM doesn't is the 
> ability to attach some private data to task structs and it passes that 
> data to the client as part of the callback.  Am I correct in this 
> interpretation?
>
> Peter

That is the "stickling" point. Yes, PAGG provides this feature that one 
can chain private data to the attach/detach callback. CKRM at this point 
does not do that as we do not see the need for multiple class 
associations in the core. Instead we can drive such things through the 
extended RBCE interface. Here you register callbacks to the task 
classtype to be notified of the ckrm events.

Since we do networking, PAGG is not sufficient for us as it only deals 
with processes. Hence we need our generic infrastructure at the core 
level. Sure we can try to modularize further to take the CKRM EVENTS 
out. Then potentially one could implement task types on top of PAGG on 
top of CKRM Events (which are needed anyway for other the task class 
associations), but then again PAGG brings nothing but another indirections.

It worthwhile to consider to bite the bullet and allow PAGG to enter its 
task class association chain (1 word) and allow CKRM its own. CKRM is 
going after the integrated resource schedulers, PAGG/CSA (afaik) does not.

-- Hubertus

