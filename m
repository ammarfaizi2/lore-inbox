Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263693AbUC3OwS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 09:52:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263695AbUC3OwR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 09:52:17 -0500
Received: from kendy.up.ac.za ([137.215.101.101]:32087 "EHLO kendy.up.ac.za")
	by vger.kernel.org with ESMTP id S263693AbUC3OwI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 09:52:08 -0500
Message-ID: <4069898D.90005@cs.up.ac.za>
Date: Tue, 30 Mar 2004 16:51:57 +0200
From: Jaco Kroon <jkroon@cs.up.ac.za>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040325
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
CC: Fredrik Steen <fredrik@stone.nu>, linux-kernel@vger.kernel.org,
       dwmw2@infradead.org
Subject: Re: 2.4: kernel BUG at inode.c:334!
References: <90520000.1080235942@flay> <20040326154915.GC3472@logos.cnet> <20040326155806.GD3472@logos.cnet> <20040326154000.GA28389@panic.unixguru.info> <20040326183959.GC4218@logos.cnet>
In-Reply-To: <20040326183959.GC4218@logos.cnet>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Scan-Signature: 29aa382051d165bb7c7c95a867f9b38d
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

We were having similar problems on two oldish machines (about 5 years 
old, old prolines) and since the dpt_i2o driver isn't ported officially 
yet we were stuck with 2.4 for some time before we decided to just stuff 
it and switch to 2.6 using some patch for dpt_i2o.  Now we are still 
having the same problem, but less regularly - seems to die shortly after 
we run a addusers script that causes intensive io on /, which is using 
ext3.  Unfortunately the stack traces doesn't get sent to a log file 
(how can I quickly rig this?) and both machines are production machines 
-> ie, it goes down and we run for all we are worth to hit that reset 
button.

I do however have a small machine at home that seem to be giving similar 
problems, but I'm not sure.  I can't get stack traces in this case at 
all (APM kicks in and I can't get it back out after it crashes).  I've 
now recompiled with full kernel debugging (everything under kernel 
hacking) and the only thing I get in the kernel logs are ??? suppressed 
messages from the kernel.  It still dies.  It also has periods where it 
just slows down to a stop (doesn't respond to pings for up to a minute 
at a time).  Usually dies whilst compiling (heavy disk io).

One of the production machines and my machine at home currently runs 
2.6.4 and the other 2.4.25.

So this seems to be a more general problem (My co-worker suspects ext3 - 
since this bug report started with xfs that might not be the case).  The 
only pattern we are seeing between all of these is that they serve as 
nfs servers (but on mine at home it still dies, even when not serving 
nfs - it still is a nfs client when it dies though), are not the newest 
and greatest machines and all of them use ext3 as their root file 
system.  Oh, also, usually shortly after, or during, intensive disk io - 
which match up with what Mika mentioned.  I've also tried disabling 
IO-APIC (which we're not even sure is supported, but APIC is), as well 
as pre-empting.

We don't suspect nfs on the production machines anymore since we managed 
to trash the nfs exported dir for about an hour (keeping the server at 
load average 8.5) which makes use of reiserfs - we might've been lucky 
though.  In almost all the cases these exports are relatively big 
though, and I noticed there is a problem there as well (We don't get the 
magical 1000 number quite yet).

Is there anything else I should/can take a look at?  Is there any other 
way in which I can help find the problem?  If I can just get somewhere 
to start ... (The patch below doesn't apply to 2.6 as far as I can see).

Apologies for the essay.

Jaco

Marcelo Tosatti wrote:

>On Fri, Mar 26, 2004 at 04:40:00PM +0100, Fredrik Steen wrote:
>  
>
>>On [040326 16:20] Marcelo Tosatti <marcelo.tosatti@cyclades.com> wrote:
>>    
>>
>>> On Thu, Mar 25, 2004 at 09:32:22AM -0800, Martin J. Bligh wrote:
>>> > http://bugme.osdl.org/show_bug.cgi?id=2367
>>> 
>>>This is the second bug report of "BUG at inode.c:334" I have seen. 
>>>The other one reported by Mika Fischer.
>>> 
>>>Its indeed not valid for I_LOCK or I_FREEING inode's to be on the 
>>>superblock dirty list. I cannot see how this is happening.
>>> 
>>>Martin, Mika, can you please apply the attached patch and rerun the tests? 
>>> 
>>>It might give a bit more clue. Thanks.
>>> 
>>>--- fs/inode.c.orig	2004-03-26 12:30:01.961087616 -0300
>>>      
>>>
>>[...]
>>
>>I ran the patch and got this:
>>inode->i_istate:f
>>Kernel BUG at inode.c:340!
>>[...]
>>    
>>
>
>Hi Fredik, 
>
>It seems Trond already figured it out, we are erroneously moving 
>locked inodes to the dirty list. He attached the following patch in 
>the bugzilla to fix the problem. Can you please give it a try?
>
>--- linux-2.4.26-up/fs/inode.c.orig	2004-03-19 17:12:46.000000000 -0500
>+++ linux-2.4.26-up/fs/inode.c	2004-03-26 13:01:23.000000000 -0500
>@@ -319,7 +319,8 @@ void refile_inode(struct inode *inode)
> 	if (!inode)
> 		return;
> 	spin_lock(&inode_lock);
>-	__refile_inode(inode);
>+	if (!(inode->i_state & I_LOCK))
>+		__refile_inode(inode);
> 	spin_unlock(&inode_lock);
> }
>  
>
===========================================This message and attachments 
are subject to a disclaimer. Please refer to 
www.it.up.ac.za/documentation/governance/disclaimer/ for full details.

Hierdie boodskap en aanhangsels is aan 'n vrywaringsklousule onderhewig. Volledige besonderhede is by www.it.up.ac.za/documentation/governance/disclaimer/ beskikbaar.
===========================================

