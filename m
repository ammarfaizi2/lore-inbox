Return-Path: <linux-kernel-owner+w=401wt.eu-S1425535AbWLHPEM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1425535AbWLHPEM (ORCPT <rfc822;w@1wt.eu>);
	Fri, 8 Dec 2006 10:04:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1425542AbWLHPEM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 10:04:12 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:42698 "EHLO e1.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S938070AbWLHPEJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 10:04:09 -0500
Message-ID: <45797EFE.3040008@us.ibm.com>
Date: Fri, 08 Dec 2006 09:04:30 -0600
From: Maynard Johnson <maynardj@us.ibm.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.3) Gecko/20040910
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Arnd Bergmann <arnd.bergmann@de.ibm.com>
CC: cbe-oss-dev@ozlabs.org, maynardj@linux.vnet.ibm.com,
       Luke Browning <lukeb@br.ibm.com>,
       linuxppc-dev-bounces+lukebrowning=us.ibm.com@ozlabs.org,
       Luke Browning <lukebrowning@us.ibm.com>, linux-kernel@vger.kernel.org,
       linuxppc-dev@ozlabs.org, oprofile-list@lists.sourceforge.net
Subject: Re: [Cbe-oss-dev] [PATCH]Add notification for active Cell SPU tasks
References: <OF9A01B09B.B62F8342-ON8325723C.006A9343-8325723C.006B2236@us.ibm.com>	<45773E85.8040505@us.ibm.com> <200612072358.15707.arnd.bergmann@de.ibm.com>
In-Reply-To: <200612072358.15707.arnd.bergmann@de.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann wrote:

>On Wednesday 06 December 2006 23:04, Maynard Johnson wrote:
>  
>
>>text(struct spu *spu, struct 
>>    
>>
>>>spu_context *ctx)
>>>      
>>>
>>>>Is this really the right strategy?  First, it serializes all spu 
>>>>        
>>>>
>>>context
>>>      
>>>
>>>>switching at the node level.  Second, it performs 17 callouts for
>>>>        
>>>>
>>I could be wrong, but I think if we moved the mutex_lock to be inside of 
>>the list_for_each_entry loop, we could have a race condition.  For 
>>example, we obtain the next spu item from the spu_prio->active_mutex 
>>list, then wait on the mutex which is being held for the purpose of 
>>removing the very spu context we just obtained.
>>
>>    
>>
>>>>every context
>>>>switch.  Can't oprofile internally derive the list of active spus 
>>>>        
>>>>
>>>from the  
>>>      
>>>
>>>>context switch callout. 
>>>>        
>>>>
>>Arnd would certainly know the answer to this off the top of his head, 
>>but when I initially discussed the idea for this patch with him 
>>(probably a couple months ago or so), he didn't suggest a better 
>>alternative.  Perhaps there is a way to do this with current SPUFS 
>>code.  Arnd, any comments on this?
>>    
>>
>
>
>
>No code should ever need to look at other SPUs when performing an
>operation on a given SPU, so we don't need to hold a global lock
>during normal operation.
>
>We have two cases that need to be handled:
>
>- on each context unload and load (both for a full switch operation),
>  call to the profiling code with a pointer to the current context
>  and spu (context is NULL when unloading).
>
>  If the new context is not know yet, scan its overlay table (expensive)
>  and store information about it in an oprofile private object. Otherwise
>  just point to the currently active object, this should be really cheap.
>
>- When enabling oprofile initially, scan all contexts that are currently
>  running on one of the SPUs. This is also expensive, but should happen
>  before the measurement starts so it does not impact the resulting data.
>
>  
>
>>>>Also, the notify_spus_active() callout is dependent on the return 
>>>>        
>>>>
>>>code of
>>>      
>>>
>>>>spu_switch_notify().  Should notification be hierarchical?  If I
>>>>only register
>>>>for the second one, should my notification be dependent on the 
>>>>        
>>>>
>>>return code
>>>      
>>>
>>>>of some non-related subsystem's handler. 
>>>>        
>>>>
>>I'm not exactly sure what you're saying here.  Are you suggesting that a 
>>user may only be interested in acitve SPU notification and, therefore, 
>>shouldn't have to be depenent on the "standard" notification 
>>registration succeeding?  There may be a case for adding a new 
>>registration function, I suppose; although, I'm not aware of any other 
>>users of the SPUFS notification mechanism besides OProfile and PDT, and 
>>we need notification of both active and future SPU tasks.  But I would 
>>not object to a new function.
>>
>>    
>>
>I think what Luke was trying to get to is that notify_spus_active() should
>not call blocking_notifier_call_chain(), since it will notify other users
>as well as the newly registered one. Instead, it can simply call the
>notifier function directly.
>  
>
Ah, yes.  Thanks to both of you for pointing that out.  I'll fix that 
and re-post.

-Maynard

>	Arnd <><
>
>-------------------------------------------------------------------------
>Take Surveys. Earn Cash. Influence the Future of IT
>Join SourceForge.net's Techsay panel and you'll get the chance to share your
>opinions on IT & business topics through brief surveys - and earn cash
>http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
>_______________________________________________
>oprofile-list mailing list
>oprofile-list@lists.sourceforge.net
>https://lists.sourceforge.net/lists/listinfo/oprofile-list
>  
>


