Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751204AbVLPEcq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751204AbVLPEcq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 23:32:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751226AbVLPEcq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 23:32:46 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:47768 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751204AbVLPEcp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 23:32:45 -0500
Message-ID: <43A24362.6000602@us.ibm.com>
Date: Thu, 15 Dec 2005 23:32:34 -0500
From: JANAK DESAI <janak@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: viro@ftp.linux.org.uk, chrisw@osdl.org, dwmw2@infradead.org,
       jamie@shareable.org, serue@us.ibm.com, mingo@elte.hu,
       linuxram@us.ibm.com, jmorris@namei.org, sds@tycho.nsa.gov,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -mm 1/9] unshare system call: system call handler function
References: <1134513959.11972.167.camel@hobbs.atlanta.ibm.com>	<m1k6e687e2.fsf@ebiederm.dsl.xmission.com>	<43A1D435.5060602@us.ibm.com> <m1d5jy83nr.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m1d5jy83nr.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:

>JANAK DESAI <janak@us.ibm.com> writes:
>
>  
>
>>Eric W. Biederman wrote:
>>
>>    
>>
>>>If it isn't legal how about we deny the unshare call.
>>>Then we can share this code with clone.
>>>
>>>Eric
>>>
>>>
>>>
>>>
>>>      
>>>
>>unshare is doing the reverse of what clone does. So if you are unsharing
>>namespace
>>you want to make sure that you are not sharing fs. That's why the CLONE_FS flag
>>is forced (meaning you are also going to unshare fs). Since namespace is shared
>>by default and fs is not, if clone is called with CLONE_NEWNS, the intent is to
>>create a new namespace, which means you cannot share fs. clone checks to
>>makes sure that CLONE_NEWNS and CLONE_FS are not specified together, while
>>unshare will force CLONE_FS if CLONE_NEWNS is spefcified. Basically you
>>can have a shared namespace and non shared fs, but not the other way around and
>>since clone and unshare are doing opposite things, sharing code between them
>>that
>>checks constraints on the flags can get convoluted.
>>    
>>
>
>I follow but I am very disturbed.
>
>You are leaving CLONE_NEWNS to mean you want a new namespace.
>
>For clone CLONE_FS unset means generate an unshared fs_struct
>          CLONE_FS set   means share the fs_struct with the parent
>
>But for unshare CLONE_FS unset means share the fs_struct with others
>            and CLONE_FS set   means generate an unshared fs_struct
>
>The meaning of CLONE_FS between the two calls in now flipped,
>but CLONE_NEWNS is not.  Please let's not implement it this way.
>
>  
>
CLONE_FS unset for unshare doesn't mean that share the fs_struct with
others. It just means that you leave the fs_struct alone (which may or
maynot be shared). I agree that it is confusing, but I am having difficulty
in seeing this reversal of flag meaning. clone creates a second task and
allows you to pick what you want to share with the parent. unshare allows
you to pick what you don't want to share anymore. The "what" in both
cases can be same and still you can end up with a task with "share" state
for a perticular structure. For example, if we #define  FS   CLONE_FS,
then clone(FS) will imply that you want to share fs_struct but unshare(FS)
will imply that we want to unshare fs_struct. Does it still appear that
the flag meaning has changed? clone and unshare are doing different
things, the flag just indicates the structure on which they operate.

>Part of the problem is the double negative in the name, leading
>me to suggest that sys_share might almost be a better name.
>
>  
>
I disagree. You cannot start sharing with this system call. You can
only unshare a shared structure. If you don't specify a flag corresponding
to a structure, that structure stays in its current state which may be
shared or unshared. Since the only action you can perform with this
call is unshare, unshare is the more appropriate name.

>So please code don't invert the meaning of the bits.  This will
>allow sharing of the sanity checks with clone.
>
>In addition this leaves open the possibility that routines like
>copy_fs properly refactored can be shared between clone and unshare.
>
>
>  
>
umm.. I am not sure how you were thinking of refactoring it, but my 
attempt at
using copy_* functions introduced race conditions.

>Eric
>
>
>  
>

